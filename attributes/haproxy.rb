include_attribute 'haproxy'

default['haproxy']['enable_default_http'] = true
default['haproxy']['enable_stats_socket'] = true

default['haproxy']['stats_socket_user'] = 'haproxy'
default['haproxy']['stats_socket_group'] = 'haproxy'

# process monitoring
default['haproxy']['processes'] = [
  { 'name' =>  'haproxy', 'shortname' =>  'haproxy' }
]
