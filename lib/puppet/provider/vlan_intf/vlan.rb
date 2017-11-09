require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/vlan'


Puppet::Type.type(:cnos_vlan).provide :vlan do
 desc 'Manage Vlan on Lenovo CNOS. Requires cnos-rbapi'

 #confine :feature => :LenovoCheflib
 confine operatingsystem: [:ubuntu]
 
 #mk_resource_methods
 conn = Connect.new('./config.yml')

 def self.instances
     conn = Connect.new('./config.yml')
     resp = Vlan.get_all_vlan(conn)
     return 'no vlans' if !resp
     resp.each do  |item|
      puts item['vlan_id']
      provider_val = {:name => item['vlan_id'], :vlan_name => item['vlan_name'],:ensure => :present}
      provider_val[:admin_state] = item['admin_state']
      puts provider_val
      new(provider_val)
     end
 end
 
 def bridgeport_mode
     conn = Connect.new('./config.yml')
     resp = Vlan.get_vlan_prop_intf(conn, resource[:if_name])
     resp['bridgeport_mode']
 end 
 
 def pvid
     conn = Connect.new('./config.yml')
     resp = Vlan.get_vlan_prop_intf(conn, resource[:if_name])
     resp['pvid']
 end 
 
 def vlans
     conn = Connect.new('./config.yml')
     resp = Vlan.get_vlan_prop_intf(conn, resource[:if_name])
     resp['vlans']
 end 

 def bridgeport_mode=(value)
     conn = Connect.new('./config.yml')
     params = {'pvid' => resource[:pvid], 
               'bridgeport_mode' => resource[:bridgeport_mode],
               'vlans' => [2], 
               'if_name' => resource[:if_name]}
     resp = Vlan.update_vlan_intf(conn, resource[:if_name], params)
   #@property_hash[:admin_state] = value
 end
 
 def pvid=(value)
     conn = Connect.new('./config.yml')
     params = {'pvid' => resource[:pvid], 
               'bridgeport_mode' => resource[:bridgeport_mode],
               'vlans' => [2], 
               'if_name' => resource[:if_name]}
     resp = Vlan.update_vlan_intf(conn, resource[:if_name], params)
   #@property_hash[:vlan_name] = value
 end 
 
 def vlans=(value)
     conn = Connect.new('./config.yml')
     params = {'pvid' => resource[:pvid], 
               'bridgeport_mode' => resource[:bridgeport_mode],
               'vlans' => [2], 
               'if_name' => resource[:if_name]}
     resp = Vlan.update_vlan_intf(conn, resource[:if_name], params)
   #@property_hash[:vlan_name] = value
 end 
end
