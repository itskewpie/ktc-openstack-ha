node.run_state[:active_passive] ||= Array.new
node.run_state[:avtive_passive].push :mysql

include_recipe "ktc-openstack-ha::_active_passive"
