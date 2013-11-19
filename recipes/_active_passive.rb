# Cookbook Name:: ktc-openstack-ha
# Recipe:: _active_passive.rb

include_recipe "sysctl"
include_recipe "services"
include_recipe "keepalived"

# we install this here cause keepalive doens't
package "ipvsadm"

# initialize the Services (etc) connection
Services::Connection.new run_context: run_context

node.run_state[:active_passive].each do |ap_service|

  ip = node[:vips][:tags][ap_service.to_sym]
  endpoint = Services::Endpoint.new ap_service.to_s,
    ip: ip,
    port: node[:vips][:endpoints][ap_service.to_sym][:port],
    proto: "tcp"
  endpoint.save

  # setup Network class
  KTC::Network.node = node

  # setup a VRRP instance on public int
  #  right now we aren't using any other int
  #  when we need  something on all we can iterate through interface_mapping
  #  and build there
  keepalived_vrrp "public-#{ap_service.to_s}" do
    interface KTC::Network.if_lookup "private"
    priority KTC::Network.last_octet(node[:ipaddress])
    virtual_router_id KTC::Network.last_octet(ip)
    virtual_ipaddress [ip]
  end
end
