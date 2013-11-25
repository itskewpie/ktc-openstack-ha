#
# Cookbook Name:: ktc-openstack-ha
# Recipe:: default
#
include_recipe "sysctl"
include_recipe "services"
include_recipe "keepalived"

# we install this here cause keepalive doens't
package "ipvsadm"

# initialize the Services (etc) connection
Services::Connection.new run_context: run_context

# setup Network class
KTC::Network.node = node

# iterate over the api specific vips and build the endpoint for each service
endpoints = []
node[:vips][:endpoints].each do |name, ep|
  if ep[:tag].eql?("api")
    proto = ep[:proto] || "tcp"
    endpoint = Services::Endpoint.new name,
      ip: node[:vips][:tags][:api],
      port: ep[:port],
      proto: proto
    endpoint.save
    endpoints.push endpoint
  end
end

keepalived_chkscript "haproxy" do
  script "haproxy status"
  interval 5
  action :create
  not_if { File.exists?('/etc/keepalived/conf.d/script_haproxy.conf') }
end

# setup a VRRP instance on vip from attrs
keepalived_vrrp "public-openstack-ha" do
  nopreempt true
  interface KTC::Network.if_lookup "private"
  priority KTC::Network.last_octet(node[:ipaddress])
  virtual_router_id KTC::Network.last_octet(node[:vips][:tags][:api])
  virtual_ipaddress [node[:vips][:tags][:api]]
end

# roll over and setup these vips as virtual servers
endpoints.each do |ep|
  # load service from etcd
  lb_service = Services::Service.new(ep.name)

  haproxy_lb ep.name do
    bind "#{ep.ip}:#{ep.port}"
    balance "roundrobin"
    mode "http"
    servers lb_service.members.map {
      |m| "#{m.name} #{m.ip}:#{m.port} weight #{m.weight} maxconn 500 check"
    }
  end
end

include_recipe "haproxy"

# process monitoring and sensu-check config
processes = node[:keepalived][:processes] + node[:haproxy][:processes]

processes.each do |process|
  sensu_check "check_process_#{process[:name]}" do
    command "check-procs.rb -c 10 -w 10 -C 1 -W 1 -p #{process[:name]}"
    handlers ["default"]
    standalone true
    interval 30
  end
end

ktc_collectd_processes "openstack-ha-processes" do
  input processes
end
