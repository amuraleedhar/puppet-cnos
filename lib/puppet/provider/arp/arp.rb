require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/arp'


Puppet::Type.type(:arp).provide :arp do
 desc 'Manage Arp on Lenovo CNOS. Requires cnos-rbapi'

 confine operatingsystem: [:ubuntu]
 
 def ageout_time
     conn = Connect.new('./config.yml')
     resp = Arp.get_arp_intf_prop(conn, resource[:if_name])
     resp['ageout_time']
 end
 

 def ageout_time=(value)
     conn = Connect.new('./config.yml')
     params = {'if_name' => resource[:if_name], 'ageout_time' => resource[:ageout_time]} 
     resp = Arp.set_arp_intf_prop(conn, resource[:if_name], params)
 end 
end 
