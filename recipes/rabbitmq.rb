node.run_state[:active_passive] ||= Array.new
node.run_state[:avtive_passive].push :rabbitmq

include_recipe "ktc-openstack-ha::_active_passive"
