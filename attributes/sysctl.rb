include_attribute "sysctl"

default[:sysctl][:values][:'net.ipv4.ip_nonlocal_bind'] = 1
