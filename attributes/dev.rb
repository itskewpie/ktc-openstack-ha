# setup dev vips
return  unless  chef_environment == "dev"
# we want to override defaults
include_attribute "ktc-openstack-ha::default"

default[:vips] = {
  "identity-api" => {
    ip: "10.1.1.3",
    port: 5000
  },
  "identity-admin" => {
    ip: "10.1.1.3",
    port: 35357
  },
  "compute-api" => {
    ip: "10.1.1.3",
    port: 8774
  },
  "compute-ec2-api" => {
    ip: "10.1.1.3",
    port: 8773
  },
  "compute-ec2-admin" => {
    ip: "10.1.1.3",
    port: 8775
  },
  "compute-xvpvnc" => {
    ip: "10.1.1.3",
    port: 6081,
    algo: "sh"
  },
  "compute-novnc" => {
    ip: "10.1.1.3",
    port: 6080,
    algo: "sh"
  },
  "network-api" => {
    ip: "10.1.1.3",
    port: 9696
  },
  "image-api" => {
    ip: "10.1.1.3",
    port: 9292
  },
  "image-registry" => {
    ip: "10.1.1.3",
    port: 9191
  },
  "volume-api" => {
    ip: "10.1.1.3",
    port: 8776
  },
  "metering-api" => {
    ip: "10.1.1.3",
    port: 8777
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
