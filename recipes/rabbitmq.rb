node.run_state[:active_passive] ||= []
node.run_state[:active_passive].push :rabbitmq

include_recipe "ktc-openstack-ha::_active_passive"
