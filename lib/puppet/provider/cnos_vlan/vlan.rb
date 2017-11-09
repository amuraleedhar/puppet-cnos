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
      provider_val = {:name => item['vlan_id'], :vlan_name => item['vlan_name'],:ensure => :present}
      provider_val[:admin_state] = item['admin_state']
      puts provider_val
      new(provider_val)
     end
 end
 def self.prefetch(resources)
     vlans = instances
     resources.keys.each do |name|
	     if provider = vlans.find { |vlan| vlan.name == name }
		resources[name].provider = provider
	     end
     end
 end
 
 def admin_state
     #conn = Connect.new('./config.yml')
     #resp = Vlan.get_vlan_prop(conn, resource[:vlan_id])
     #resp['admin_state']
     @property_hash[:admin_state]
 end 
 
 def vlan_name
     #conn = Connect.new('./config.yml')
     #resp = Vlan.get_vlan_prop(conn, resource[:vlan_id])
     #resp['vlan_name']
     @property_hash[:vlan_name]
     
 end 

 def admin_state=(value)
     conn = Connect.new('./config.yml')
     params = {'vlan_name' => resource[:vlan_name], 
               'admin_state' => resource[:admin_state]}
     resp = Vlan.update_vlan(conn, resource[:vlan_id], params)
     @property_hash[:admin_state] = value
 end
 
 def vlan_name=(value)
     conn = Connect.new('./config.yml')
     params = {'vlan_name' => resource[:vlan_name], 
               'admin_state' => resource[:admin_state]}
     resp = Vlan.update_vlan(conn, resource[:vlan_id], params)
     @property_hash[:vlan_name] = value
 end
 
 def create
     conn = Connect.new('./config.yml')
     params = {"vlan_id" => resource[:vlan_id],
	       "vlan_name" => resource[:vlan_name],
               "admin_state" => resource[:admin_state]
              }
     Vlan.create_vlan(conn, params)
 end

 def exists?
     #conn = Connect.new('./config.yml')
     @property_hash[:ensure] == :present
     #resp = Vlan.get_vlan_prop(conn, resource[:vlan_id])
     #resp != nil
 end

 def destroy
     Vlan.delete_vlan(conn, resource[:vlan_id])
 end
end
