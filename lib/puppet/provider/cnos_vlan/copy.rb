require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/vlan'
require 'pry'

Puppet::Type.type(:cnos_vlan).provide :vlan do
 desc 'Manage Vlan on Lenovo CNOS. Requires cnos-rbapi'

 #confine :feature => :LenovoCheflib
 confine operatingsystem: [:ubuntu]
 
 #mk_resource_methods
 conn = Connect.new('./config.yml')

 def self.instances
     puts "inst"
     provider_val = []
     conn = Connect.new('./config.yml')
     resp = Vlan.get_all_vlan(conn)
     return 'no vlans' if !resp
     resp.each do  |item|
      provider_val << new(name: item['vlan_id'],
                      vlan_name: item['vlan_name'],
                      ensure: :present, 
                      admin_state: item['admin_state'])
     end
     return provider_val
 end
 
 def self.prefetch(resources)
     puts "pre"
     vlans = instances
     resources.keys.each do |name|
	     if provider = vlans.find { |vlan| vlan.name == name }
		resources[name].provider = provider
	     end
     end
 end

 def admin_state
     puts "state"
     #conn = Connect.new('./config.yml')
     #resp = Vlan.get_vlan_prop(conn, resource[:vlan_id])
     #resp['admin_state']
     puts @property_hash[:admin_state]
     @property_hash[:admin_state]
 end 
 
 def vlan_name
     puts "name"
     #conn = Connect.new('./config.yml')
     #resp = Vlan.get_vlan_prop(conn, resource[:vlan_id])
     #resp['vlan_name']
     puts @property_hash[:vlan_name]
     @property_hash[:vlan_name]
     
 end
 
 def initilialize(value={})
     super(value)
     @property_flush = {}
 end

 def admin_state=(value)
     puts "se state"
=begin     conn = Connect.new('./config.yml')
     params = {'vlan_name' => resource[:vlan_name], 
               'admin_state' => resource[:admin_state]}
=end     resp = Vlan.update_vlan(conn, resource[:vlan_id], params)
     puts value
     @property_flush[:admin_state] = value
 end
 
 def vlan_name=(value)
     puts "s state"
=begin     conn = Connect.new('./config.yml')
     params = {'vlan_name' => resource[:vlan_name], 
               'admin_state' => resource[:admin_state]}
=end     resp = Vlan.update_vlan(conn, resource[:vlan_id], params)
     puts vlan_name
     @property_flush[:vlan_name] = value
 end

 def flush
     puts "flush" 
     if @property_flush
       params = {'vlan_name' => resource[:vlan_name], 
                 'admin_state' => resource[:admin_state]}
       puts params
       resp = Vlan.update_vlan(conn, resource[:vlan_id], params)
     end
     @property_hash = resource.to_hash
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
