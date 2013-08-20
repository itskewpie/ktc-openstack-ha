#
# Cookbook Name:: ktc-openstack-ha
# Recipe:: default
#
include_recipe "keepalived"
include_recipe "etcd"

# makesure we can bind nonlocal IP's  (vips)
sysctl "net.ipv4.ip_nonlocal_bind" do
  value "1"
end

node[:vips].each do |vip|
  # create keepalived instance
end
