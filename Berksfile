#
# vim: set ft=ruby:
#

chef_api "https://chefdev.mkd2.ktc", node_name: "cookbook", client_key: ".cookbook.pem"

site :opscode

metadata

cookbook "keepalived", github: "spheromak/keepalived", branch: "integration"
cookbook 'ktc-etcd'
cookbook "ktc-testing"
