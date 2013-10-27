# vim: ft=sh:

@test "keepalived should be running" {
  ps -ef | grep -q [k]eepalived
}

@test "vrrp config should be created" {
  [ -f /etc/keepalived/conf.d/vrrp_PUBLIC-MYSQL.conf ]
}

@test "virtual ip is created" {
  /sbin/ip addr | grep -q 10.0.2.50
}
