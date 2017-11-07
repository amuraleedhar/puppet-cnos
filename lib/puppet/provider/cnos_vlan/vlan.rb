require 'puppet/type'
require 'LenovoCheflib'
require 'LenovoCheflib/vlan'


Puppet::Type.type(:cnos_vlan).provide :vlan do
 desc 'Manage Vlan on Lenovo CNOS. Requires LenovoCheflib'

 #confine :feature => :LenovoCheflib
 confine operatingsystem: [:ubuntu]
 
 mk_resource_methods
=begin 
 def self.instances
     conn = Connect.new('./config.yml')
     resp = Vlan.get_all_vlan(conn)
     return 'no vlans' if !resp
     resp.each do  |item|
      provider_val = {vlan_name: item[:vlan_id], vlanid: item[:vlan_id], ensure: :present }
      provider_val[:admin_state] = item[:admin_state]
      new(provider_val)
     end
 end
=end

 def admin_state=(value)
    val = value
    @property_hash[:admin_state] = value
 end

 def vlan_name=(value)
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
     conn = Connect.new('./config.yml')
     resp = Vlan.get_vlan_prop(conn, resource[:vlan_id])
     resp != nil
 end

 def destroy
     conn = Connect.new('./config.yml')
     Vlan.delete_vlan(conn, resource[:vlan_id])
 end
end
