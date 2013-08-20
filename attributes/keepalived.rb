# keepalived defaults
#
include_attribute "keepalived"

# the routers are on their own vlan
default["keepalived"]["global"]["router_id"] = ipaddress.split(".")[3].to_i

