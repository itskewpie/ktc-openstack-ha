name              "ktc-openstack-ha"
maintainer        "KT Cloudware, Inc."
maintainer_email  "chamankang@kt.com"
description       "Wrapper cookbook for rcb's openstack-ha"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "2.0.0"
supports          "ubuntu"

depends "haproxy",  "~> 1.5.0"
# hard lock here
depends "keepalived", "= 1.0.5"
depends "etcd"
depends "services"
depends "sysctl", "~> 0.3.3"
depends "ktc-utils", "~> 0.3.1"
