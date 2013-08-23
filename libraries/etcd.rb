module KTC
  class Etcd
    # support chef10
    if  Chef::Version.new(Chef::VERSION) <= Chef::Version.new("11.0.0")
      include Chef::Mixin::Language
    else
      include Chef::DSL::DataQuery
    end


    attr :node, :run_context, :client

    def load_gem
      begin
        require "etcd"
      rescue LoadError
        Chef::Log.info "etcd gem not found. attempting to install"
        g = Chef::Resource::ChefGem.new "etcd", run_context
        run_context.resource_collection.insert g
        g.run_action :install

        require "etcd"
      end
    end

    # Initialize etcd client
    def initialize(run_context)
      @node = run_context.node
      @run_context = run_context

      load_gem

      servers = node["etcd"]["servers"]
      if servers.nil? or serveres.empty?
        servers = locate_etcd_servers
      end

      # if nothing is found just use attributes
      # chose any server, first will do
      # TODO: this should ideally try individaul servers an ensure the
      # connection it returns is good
      if servers.nil? or servers.empty?
        ip = node["etcd"]["ip"]
        port = node["etcd"]["port"]
      else
        ip = servers.values.first["ip"]
        port = servers.values.first["port"]
      end
      client = ::Etcd.client(:host=>ip, :port=>port)
    end


    #
    # Takes a hash of vips and registers the enpoints
    #
    def register_vips vips
      vips.each_pair do |k, v|
        proto =  v[:proto] || "http"
        uri   =  v[:uri] || "#{proto.to_s}://#{v[:ip]}:#{v[:port]}"
        set_endpoint k, {
          ip: v[:ip],
          port: v[:port],
          proto: proto,
          uri: uri
        }
      end
    end

    #
    #
    # set_endpoint name, data
    # TODO: endpoint and service are very similar, DRY these out
    #
    def set_endpoint name, data
      data.each do |k, v|
        begin
          path = "/openstack/services/#{name}/enpoint/#{k}"
          puts "adding key #{path}"
          client.set(path, v)
        rescue
          puts "enable to contact etcd server"
        end
      end
    end

    #
    # real_servers:: endpoint
    # return an array of hashes containing
    # ip and port for each member supplying a service
    #
    # ex:
    # [
    #   { "ip" =>  "10.10.10.10", "port" => 8000 },
    #   { "ip" =>  "10.10.10.11", "port" => 8101 }
    # ]
    def real_servers endpoint
      results = Array.new
      boxes = members endpoint
      unless boxes.nil? or boxes.empty?
        boxes.each do |box, data|
          results << { 'ip' => data['ip'], 'port' => data['port'] }
        end
      end
      results
    end


    # find servers using chef!
    def locate_etcd_servers

      query = "(chef_environment:#{node.chef_environment} "
      query << "AND recipes:etcd) "
      query << "OR (chef_environment:#{node.chef_environment} "
      query << "AND recipes:ktc-etcd)"
      etcd_servers = search(:node, query)

      puts "#### etcd servers: #{etcd_servers} ####"

      etcd_servers.each do |k|
        node.default["etcd"]["servers"][k["fqdn"]]["ip"] = k["etcd"]["ip"]
        node.default["etcd"]["servers"][k["fqdn"]]["port"] = k["etcd"]["port"]
      end
      etcd_servers
    end


    # Register a service with etcd
    # service_name String name of the service
    # data Hash containing the service data
    def register service_name, data
      data.each do |k, v|
        begin
          service = "/openstack/services/#{service_name}"
          path = "#{service}/members/#{node["fqdn"]}/#{k}"
          puts "adding key #{path}"
          client.set(path, v)
        rescue
          puts "enable to contact etcd server"
        end
      end
    end


    # obtain service information from etcd
    # service_name String name of service to retreive info on
    # return Hash keys are the nodes names, value are data
    def members service_name
      base_path = "/openstack/services/#{service_name}/members"
      begin
        members = client.get(base_path)
        # if only one endpoint is returns ep will be a Mash, more than one, an Array
        if members.class == Hashie::Mash
          return _member_data members
        elsif member.class == Array
          nodes = Hash.new
          members.each do |a|
            nodes.merge!(_member_data(a))
          end
          return nodes
        end
      rescue
        puts "unable to contact etcd server"
      end
    end

    def get_endpoint name
      # if ha_disabled is set pull the member config directly
      # instead of from the endpoint
      if not node["ha_disabled"].nil?
        begin
          m = members(name)
          return m.values[0]
        rescue
          Chef::Log.info("error getting service endpoint")
        end
      else
        begin
          ep = Hash.new
          base_path = "/openstack/services/#{name}/endpoint"
          %w/
            ip
            port
            proto
            uri
          /.each do |k|
            ep[k] = client.get("#{base_path}/#{k}").value
          end
          return ep
        rescue
          Chef::Log.info("error getting service endpoint")
        end
      end
      return {}
    end

    # common service template with some defaults
    def get_openstack_service_template ip, port
      d = Hash.new
      d["ip"] = ip
      d["port"] = port
      d["proto"] = "http"
      return d
    end

    private

    #
    # fetch extra member data from a path in etcd
    #
    def _member_data base
      data = Hash.new
      member = base["key"].split("/").last
      ep = client.get(base["key"])
      ep.each do |k|
        data[k["key"].split("/").last] = k.value
      end
      return { member => data }
    end


  end
end
