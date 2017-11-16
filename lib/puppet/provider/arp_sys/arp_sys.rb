require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/arp'


Puppet::Type.type(:arp_sys).provide :arp_sys do
 desc 'Manage Arp_sys on Lenovo CNOS. Requires cnos-rbapi'

 confine operatingsystem: [:ubuntu]

 def ageout_time
     conn = Connect.new('./config.yml')
     resp = Arp.get_arp_sys_prop(conn)
     resp['ageout_time']
 end


 def ageout_time=(value)
     conn = Connect.new('./config.yml')
     params = {'ageout_time' => resource[:ageout_time]}
     resp = Arp.set_arp_sys_prop(conn, params)
 end
end

