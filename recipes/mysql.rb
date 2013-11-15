node.run_state[:active_passive] ||= []
node.run_state[:active_passive].push :mysql

include_recipe "ktc-openstack-ha::_active_passive"
