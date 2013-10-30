# setup mkd_stag vips
return unless chef_environment == "mkd_stag"
# we want to override defaults
include_attribute "ktc-openstack-ha::default"

default[:vips][:tags] = {
  api: "20.0.1.253",
  mysql: "20.0.1.252"
}
