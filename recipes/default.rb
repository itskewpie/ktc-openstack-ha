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

# setup the vip data
# TODO: Vips prob belongs in KTC::Network
KTC::Vips.vips = node[:vips]

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

#
# setup a VRRP instance on public int
#  right now we aren't using any other int
#  when we need  something on all we can iterate through interface_mapping
#  and build there
keepalived_vrrp "public-openstack-ha" do
  interface KTC::Network.if_lookup "private"
  virtual_router_id KTC::Network.last_octet(KTC::Network.address "private")
  #virtual_ipaddress KTC::Vips.addresses "public"
  virtual_ipaddress [ node[:vips][:tags][:api] ]
end

# roll over and setup these vips
#  as virtual  servers
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
