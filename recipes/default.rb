#
# Cookbook Name:: ktc-openstack-ha
# Recipe:: default
#

chef_gem "chef-rewind"
require 'chef/rewind'

# Set all vrrp's state and priority according to there nodes' role(master or backup)
include_recipe "openstack-ha"
node["ha"]["available_services"].each do |s|
  role, ns, svc, svc_type, lb_mode, lb_algo, lb_opts =
    s["role"], s["namespace"], s["service"], s["service_type"],
    s["lb_mode"], s["lb_algorithm"], s["lb_options"]

  if listen_ip = rcb_safe_deref(node, "vips.#{ns}-#{svc}")
    if get_role_count(role) > 0
      vrrp_name = "vi_#{listen_ip.gsub(/\./, '_')}"
      rewind :keepalived_vrrp => vrrp_name do
        state node['keepalived']['instance_defaults']['state']
        priority node['keepalived']['instance_defaults']['priority']
      end
      rewind :haproxy_virtual_server => "#{ns}-#{svc}" do
        vs_listen_ip "0.0.0.0"
      end
    end
  end
end

# To avoid trying to run keystone_register for nova-metadata, we configure haproxy virtual server for nova-metadata here.
role, ns, svc, lb_mode, lb_algo, lb_opts = "nova-api-metadata", "nova", "metadata", "http", "roundrobin", [ "forwardfor", "httpchk", "httplog" ]

listen_ip = "0.0.0.0"
listen_port = rcb_safe_deref(node, "#{ns}.services.#{svc}.port") ? node[ns]["services"][svc]["port"] : get_realserver_endpoints(role, ns, svc)[0]["port"]
rs_list = get_realserver_endpoints(role, ns, svc).each.inject([]) { |output,x| output << x["host"] + ":" + x["port"].to_s }
rs_list.sort!
Chef::Log.debug "realserver list is #{rs_list}"

haproxy_virtual_server "#{ns}-#{svc}" do
  lb_algo lb_algo
  mode lb_mode
  options lb_opts
  vs_listen_ip listen_ip
  vs_listen_port listen_port.to_s
  real_servers rs_list
end

