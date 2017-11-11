require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/ip_intf'


Puppet::Type.type(:ip_intf).provide :ip_intf do
 desc 'Manage IP interfaces on Lenovo CNOS. Requires cnos-rbapi'

 confine operatingsystem: [:ubuntu]
 
 def bridge_port
     conn = Connect.new('./config.yml')
     resp = Ipintf.get_ip_prop_intf(conn, resource[:if_name])
     resp['bridge_port']
 end

 def mtu
     conn = Connect.new('./config.yml')
     resp = Ipintf.get_ip_prop_intf(conn, resource[:if_name])
     resp['mtu']
 end
 
 def ip_addr
     conn = Connect.new('./config.yml')
     resp = Ipintf.get_ip_prop_intf(conn, resource[:if_name])
     resp['ip_addr']
 end 
 
 def ip_prefix_len
     conn = Connect.new('./config.yml')
     resp = Ipintf.get_ip_prop_intf(conn, resource[:if_name])
     resp['ip_prefix_len']
 end 
 
 def admin_state
     conn = Connect.new('./config.yml')
     resp = Ipintf.get_ip_prop_intf(conn, resource[:if_name])
     resp['admin_state']
 end 
 
 def bridge_port
     conn = Connect.new('./config.yml')
     resp = Ipintf.get_ip_prop_intf(conn, resource[:if_name])
     resp['vrf_name']
 end
 
 def bridge_port=(value)
     conn = Connect.new('./config.yml')
     params = {'if_name' => resource[:if_name],
               'vrf_name' => resource[:vrf_name],
               'bridge_port' => resource[:bridge_port] 
              } 
     resp = Ipintf.update_ip_prop_intf(conn, resource[:if_name], params)
 end 
 
 def mtu=(value)
     conn = Connect.new('./config.yml')
     params = {'if_name' => resource[:if_name],
               'vrf_name' => resource[:vrf_name],
               'mtu' => resource[:mtu] 
              } 
     resp = Ipintf.update_ip_prop_intf(conn, resource[:if_name], params)
 end
 
 def ip_addr=(value)
     conn = Connect.new('./config.yml')
     params = {'if_name' => resource[:if_name],
               'vrf_name' => resource[:vrf_name],
               'ip_addr' => resource[:ip_addr] 
              } 
     resp = Ipintf.update_ip_prop_intf(conn, resource[:if_name], params)
 end 
 
 def ip_prefix_len=(value)
     conn = Connect.new('./config.yml')
     params = {'if_name' => resource[:if_name],
               'vrf_name' => resource[:vrf_name],
               'ip_prefix_len' => resource[:ip_prefix_len] 
              } 
     resp = Ipintf.update_ip_prop_intf(conn, resource[:if_name], params)
 end 
 
 def ip_prefix_len=(value)
     conn = Connect.new('./config.yml')
     params = {'if_name' => resource[:if_name],
               'vrf_name' => resource[:vrf_name],
               'admin_state' => resource[:admin_state] 
              } 
     resp = Ipintf.update_ip_prop_intf(conn, resource[:if_name], params)
 end 

end 
