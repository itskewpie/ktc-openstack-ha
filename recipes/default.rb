#
# Cookbook Name:: ktc-openstack-ha
# Recipe:: default
#
include_recipe "keepalived"
include_recipe "etcd"
include_recipe "sysctl::attribute_driver"

node[:vips].each do |vip|
  # create keepalived instances

end
