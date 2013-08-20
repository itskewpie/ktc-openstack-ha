default["ha"]["extra_services"]["nova-metadata"] = {
  "namespace" => "nova",
  "service" => "metadata",
  "service_type" => "",
  "lb_mode" => "http",
  "lb_algorithm" => "roundrobin",
  "lb_options" => [
    "forwardfor",
    "httplog"
  ],
  "vrid" => 0,
  "vip_network" => "public"
}
default["ha"]["services"]["keystone-service-api"] = {
  "namespace" => "keystone",
  "service" => "service-api",
  "service_type" => "identity",
  "lb_mode" => "http",
  "lb_algorithm" => "roundrobin",
  "lb_options" => ["forwardfor", "httpchk", "httplog"],
  "ssl_lb_options" => ["ssl-hello-chk"]
}
default["ha"]["services"]["nova-api"] = {
  "namespace" => "nova",
  "service" => "api",
  "service_type" => "compute",
  "lb_mode" => "http",
  "lb_algorithm" => "roundrobin",
  "lb_options" => ["forwardfor", "httpchk", "httplog"],
  "ssl_lb_options" => ["ssl-hello-chk"]
}
default["ha"]["services"]["nova-ec2-public"] = {
  "namespace" => "nova",
  "service" => "ec2-public",
  "service_type" => "ec2",
  "lb_mode" => "http",
  "lb_algorithm" => "roundrobin",
  "lb_options" => [],
  "ssl_lb_options" => ["ssl-hello-chk"]
}
default["ha"]["services"]["cinder-api"] = {
  "namespace" => "cinder",
  "service" => "api",
  "service_type" => "volume",
  "lb_mode" => "http",
  "lb_algorithm" => "roundrobin",
  "lb_options" => ["forwardfor", "httpchk", "httplog"],
  "ssl_lb_options" => ["ssl-hello-chk"]
}
default["ha"]["services"]["glance-api"] = {
  "namespace" => "glance",
  "service" => "api",
  "service_type" => "image",
  "lb_mode" => "http",
  "lb_algorithm" => "roundrobin",
  "lb_options" => ["forwardfor", "httpchk", "httplog"],
  "ssl_lb_options" => ["ssl-hello-chk"]
}
default["ha"]["services"]["swift-proxy"] = {
  "namespace" => "swift",
  "service" => "proxy",
  "service_type" => "object-store",
  "lb_mode" => "http",
  "lb_algorithm" => "roundrobin",
  "lb_options" => [],
  "ssl_lb_options" => ["ssl-hello-chk"]
}
default["ha"]["services"]["glance-registry"] = {
  "namespace" => "glance",
  "service" => "registry",
  "service_type" => "image",
  "lb_mode" => "http",
  "lb_algorithm" => "roundrobin",
  "lb_options" => [],
  "ssl_lb_options" => ["ssl-hello-chk"]
}
default["ha"]["services"]["nova-novnc-proxy"] = {
  "namespace" => "nova",
  "service" => "novnc-proxy",
  "service_type" => "compute",
  "lb_mode" => "tcp",
  "lb_algorithm" => "source",
  "lb_options" => [],
  "ssl_lb_options" => ["ssl-hello-chk"]
}
default["ha"]["services"]["nova-xvpvnc-proxy"] = {
  "namespace" => "nova",
  "service" => "xvpvnc-proxy",
  "service_type" => "compute",
  "lb_mode" => "tcp",
  "lb_algorithm" => "source",
  "lb_options" => [],
  "ssl_lb_options" => ["ssl-hello-chk"]
}
default["ha"]["services"]["horizon-dash"] = {
  "namespace" => "horizon",
  "service" => "dash",
  "service_type" => "dash",
  "lb_mode" => "http",
  "lb_algorithm" => "roundrobin",
  "lb_options" => ["forwardfor", "httpchk", "httplog"],
  "ssl_lb_options" => ["ssl-hello-chk"]
}
default["ha"]["services"]["horizon-dash_ssl"] = {
  "namespace" => "horizon",
  "service" => "dash_ssl",
  "service_type" => "dash",
  "lb_mode" => "tcp",
  "lb_algorithm" => "source",
  "lb_options" => ["ssl-hello-chk"],
  "ssl_lb_options" => ["ssl-hello-chk"]
}
default["ha"]["services"]["ceilometer-api"] = {
  "namespace" => "ceilometer",
  "service" => "api",
  "service_type" => "metering",
  "lb_mode" => "http",
  "lb_algorithm" => "roundrobin",
  "lb_options" => ["forwardfor", "httpchk", "httplog"],
  "ssl_lb_options" => ["ssl-hello-chk"]
}

if node["nova"]["network"]["provider"] == "quantum"
  default["ha"]["services"]["quantum-server"] = {
    "namespace" => "quantum",
    "service" => "api",
    "service_type" => "network",
    "lb_mode" => "http",
    "lb_algorithm" => "roundrobin",
    "lb_options" => ["forwardfor", "httpchk", "httplog"],
    "ssl_lb_options" => ["ssl-hello-chk"],
  }
end
