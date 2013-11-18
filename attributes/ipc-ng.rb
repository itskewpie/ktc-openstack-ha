# setup ipc_stag vips
return unless chef_environment == "ipc-ng"
# we want to override defaults
include_attribute "ktc-openstack-ha::default"

default[:vips][:tags] = {
  rabbitmq: "10.9.12.34",
  mysql: "10.9.12.35",
  api: "10.9.12.36"
}
