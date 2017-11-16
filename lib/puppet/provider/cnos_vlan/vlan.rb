require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/vlan'

Puppet::Type.type(:cnos_vlan).provide :vlan do
 desc 'Manage Vlan on Lenovo CNOS. Requires cnos-rbapi'

 #confine :feature => :LenovoCheflib
 confine operatingsystem: [:ubuntu]
 
 mk_resource_methods
 conn = Connect.new('./config.yml')

 def self.instances
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
     vlans = instances
     resources.keys.each do |name|
	     if provider = vlans.find { |vlan| vlan.name == name }
		resources[name].provider = provider
	     end
     end
 end
=begin
 def initilialize(value={})
     super(value)
     @property_flush = {}
 end
=end
 def flush
     if @property_hash != {}
       conn = Connect.new('./config.yml')
       params = {'vlan_name' => resource[:vlan_name], 
                 'admin_state' => resource[:admin_state]}
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
     @property_hash.clear
 end

 def exists?
     @property_hash[:ensure] == :present
 end

 def destroy
     Vlan.delete_vlan(conn, resource[:vlan_id])
     @property_hash.clear
 end
end
