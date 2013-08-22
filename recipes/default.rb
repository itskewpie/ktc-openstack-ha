#
# Cookbook Name:: ktc-openstack-ha
# Recipe:: default
#
include_recipe "keepalived"
include_recipe "sysctl::attribute_driver"
include_recipe "ktc-utils"

etcd = KTC::Etcd.new run_context
etcd.register_vips( node[:vips] )

#
# setup a VRRP instance on public int
#  right now we aren't using any other int
#  when we need  something on all we can iterate through interface_mapping
#  and build there

# use the ip of the interfaceon ass the  ID
iface = "eth0"
if node.has_key? "interface_mapping"
  iface = node["interface_mapping"]["private"]
end

if_ip = KTC::Network.if_addr( node, iface )
router_id = KTC::Network.last_octet if_ip

keepalived_vrrp "public-openstack-ha" do
  interface iface
  virtual_router_id router_id
  virtual_ipaddress KTC::Vips.addresses node[:vips], "public"
end

# roll over and setup these vips
#  as virtual  servers
KTC::Vips.on_network( "public", node[:vips]).each do |vip|
  keepalived_virtual_server vip do
    vs_listen_ip vip[:ip]
    vs_listen_port vip[:port].to_s
    lb_algo vip[:algo] || "rr"
    lb_kind vip[:kind] || "nat"
    vs_protocol vip[:proto] || "tcp"
    real_servers etcd.real_servers( vip ) || {}
  end
end
