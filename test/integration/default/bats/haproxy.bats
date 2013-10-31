# vim: ft=sh:

@test "haproxy should be running" {
  ps -ef | grep -q [h]aproxy
}

@test "haproxy config should be created" {
  [ -f /etc/haproxy/haproxy.cfg ]
}

@test "identity-api balancer port configured" {
  /bin/netstat -tan | grep LISTEN | grep -q 10.0.2.50:5000
}

@test "identity-admin balancer port configured" {
  /bin/netstat -tan | grep LISTEN | grep -q 10.0.2.50:35357
}

@test "compute-api balancer port configured" {
  /bin/netstat -tan | grep LISTEN | grep -q 10.0.2.50:8774
}

@test "compute-ec2-api balancer port configured" {
  /bin/netstat -tan | grep LISTEN | grep -q 10.0.2.50:8773
}

@test "compute-xvpvnc balancer port configured" {
  /bin/netstat -tan | grep LISTEN | grep -q 10.0.2.50:6081
}

@test "compute-novnc balancer port configured" {
  /bin/netstat -tan | grep LISTEN | grep -q 10.0.2.50:6080
}

@test "network-api balancer port configured" {
  /bin/netstat -tan | grep LISTEN | grep -q 10.0.2.50:9696
}

@test "volume-api balancer port configured" {
  /bin/netstat -tan | grep LISTEN | grep -q 10.0.2.50:8776
}

@test "metering-api balancer port configured" {
  /bin/netstat -tan | grep LISTEN | grep -q 10.0.2.50:8777
}
