include_attribute "ktc-utils"

default[:vips] = {
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
}
