# setup ipc_stag vips
return unless chef_environment == "ipc_stag"
# we want to override defaults
include_attribute "ktc-openstack-ha::default"

default[:vips] = {
  "tags" => {
    mysql: "10.9.241.35",
    api: "10.9.241.36"
  }
}
