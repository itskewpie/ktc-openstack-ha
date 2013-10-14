# vim: ft=sh:

@test "keepalived should be running" {
  ps -ef  | grep -q [k]eepalived
}

@test "vrrp config should be created" {
  [ -f /etc/keepalived/conf.d/vrrp_PUBLIC-OPENSTACK-HA.conf ]
}

@test "vrrp config should have the vip" {
}

