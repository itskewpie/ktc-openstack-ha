#
# vim: set ft=ruby:
#

chef_api "https://chefdev.mkd2.ktc", node_name: "cookbook", client_key: ".cookbook.pem"

metadata

group "integration" do
  cookbook "etcd"
  cookbook "ktc-monitor"
  cookbook "ktc-testing"
end
