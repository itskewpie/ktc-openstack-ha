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
    end
  end
end

