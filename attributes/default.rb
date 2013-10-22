include_attribute "ktc-utils"

default[:vips] = {
  # overide this example
  example: {
    ip: "127.0.0.1",
    port: 1234,
    options: %w[ some option settings ],
    proto: "udp",
    mode: "http",
    algo: "sh",
    kind:  "tun",
    net:  "public"
  },
  "mysql" => {
    ip: "10.0.2.50",
    port: 3306
  }
}
