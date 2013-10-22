include_attribute "ktc-utils"

default[:vips] = {
  # overide this example
  "mysql" => {
    ip: "10.0.2.50",
    port: 3306
  }
}
