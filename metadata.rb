name              "ktc-openstack-ha"
maintainer        "KT Cloudware, Inc."
maintainer_email  "chamankang@kt.com"
description       "Wrapper cookbook for rcb's openstack-ha"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.6"
supports          "ubuntu"

depends "haproxy"
depends "keepalived"

recipe "default", ""
