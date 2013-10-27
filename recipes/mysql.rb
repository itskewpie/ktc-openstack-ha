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
KTC::Vips.vips = node[:vips]

ip = node[:vips][:tags][:mysql]
endpoint = Services::Endpoint.new "mysql",
  ip: ip,
  port: node[:vips][:endpoints][:mysql][:port],
  proto: "tcp"
endpoint.save

#
# setup a VRRP instance on public int
#  right now we aren't using any other int
#  when we need  something on all we can iterate through interface_mapping
#  and build there
keepalived_vrrp "public-mysql" do
  interface KTC::Network.if_lookup "private"
  virtual_router_id KTC::Network.last_octet(KTC::Network.address "private")
  #virtual_ipaddress KTC::Vips.addresses "public"
  virtual_ipaddress [ ip ]
end
