# vim: ft=sh:

@test "haproxy should be running" {
  ps -ef | grep -q [h]aproxy
}

@test "haproxy config should be created" {
  [ -f /etc/haproxy/haproxy.cfg ]
}

@test "listening on vip ip and balancer port" {
  /bin/netstat -tan | grep LISTEN | grep -q 10.0.2.50:1234
}
