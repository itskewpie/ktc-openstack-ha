#
# vim: set ft=ruby:
#
site :opscode

metadata

cookbook "keepalived",
  github: "spheromak/keepalived",
  branch: "integration"

cookbook 'ktc-etcd',
  github: 'cloudware-cookbooks/ktc-etcd',
  branch: 'develop'

cookbook "ktc-utils",
  github: "cloudware-cookbooks/ktc-utils",
  branch: "develop"

cookbook "openstack-common",
  github: "stackforge/cookbook-openstack-common"

cookbook "services",
  github: "spheromak/services-cookbook"

cookbook "sysctl",
  github: "onehealth-cookbooks/sysctl"

group "integration" do
  cookbook "ktc-testing",
    github: "cloudware-cookbooks/ktc-testing"
end
