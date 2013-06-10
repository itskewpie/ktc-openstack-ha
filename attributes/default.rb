# Define KTC's own ha services as the extra_services that shouldn't be defined in the available_services. (eg. nova-metadata, mysql-db, rabbit-mq)
default["ha"]["extra_services"]["nova-metadata"] = {
          "role" => "nova-api-metadata",
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
