name              "ktc-openstack-ha"
maintainer        "KT Cloudware, Inc."
maintainer_email  "chamankang@kt.com"
description       "Wrapper cookbook for rcb's openstack-ha"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.12'
supports          "ubuntu"

depends "haproxy"
# hard lock here
depends "keepalived", "= 1.0.5"
depends "etcd"
depends "services"
depends "sysctl"
depends "ktc-utils"
