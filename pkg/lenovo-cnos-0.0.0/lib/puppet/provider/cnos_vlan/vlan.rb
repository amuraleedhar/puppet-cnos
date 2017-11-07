require 'puppet/type'
#require 'LenovoCheflib'
#require 'LenovoCheflib/vlan'

Puppet::Type.type(:cnos_vlan).provide :vlan do
 desc 'Manage Vlan on Lenovo CNOS. Requires LenovoCheflib'

 confine :feature => :LenovoCheflib
 

 def admin_state=(value)
     conn = Connect.new('./file.yml')
     params = {"admin_state" => value}
     Vlan.update(conn, resource[:vlan_id], params)
 end

 def create
     conn = Connect.new('./file.yml')
     params = {"vlan_id" => resource[:vlan_id],
	       "vlan_name" => resource[:vlan_name],
               "admin_state" => resource[:admin_state]
              }
     Vlan.create(conn, params)
 end

 def exists?
     conn = Connect.new('./file.yml')
     resp = Vlan.get_vlan_prop(conn, resource[:vlan_id])
     resp != nil
 end

 def destroy
     conn = Connect.new('./file.yml')
     Vlan.delete_vlan(conn, resource[:vlan_id])
 end
end
