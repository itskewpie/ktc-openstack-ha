# setup mkd_stag vips
return unless  chef_environment == "mkd_stag"
# we want to override defaults
include_attribute "ktc-openstack-ha::default"

default[:vips] = {
  "tags" => {
    api: "20.0.1.253",
    mysql: "20.0.1.252"
  },
  "endpoints" => {
    "mysql" => {
      port: 3306,
      tag: "mysql"
    },
    "identity-api" => {
      port: 5000,
      tag: "api"
    },
    "identity-admin" => {
      port: 35357,
      tag: "api"
    },
    "compute-api" => {
      port: 8774,
      tag: "api"
    },
    "compute-ec2-api" => {
      port: 8773,
      tag: "api"
    },
    "compute-xvpvnc" => {
      port: 6081,
      tag: "api"
    },
    "compute-novnc" => {
      port: 6080,
      tag: "api"
    },
    "network-api" => {
      port: 9696,
      tag: "api"
    },
    "image-api" => {
      port: 9292,
      tag: "api"
    },
    "image-registry" => {
      port: 9191,
      tag: "api"
    },
    "volume-api" => {
      port: 8776,
      tag: "api"
    },
    "metering-api" => {
      port: 8777,
      tag: "api"
    }
  }

  # options and "mode" are ignored
  # untill we get some http proxy in front of those things that want it
  #
  # example: {
  #  ip: 127.0.0.1
  #  port: 1234
  #  options: %w[ some option settings ]
  #  proto: udp
  #  mode: "http"
  #  algo: sh
  #  kind:  tun
  #  net:  "management"
  # }
}
