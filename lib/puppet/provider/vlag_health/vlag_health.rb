require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/vlag'


Puppet::Type.type(:vlag_health).provide :vlag_health do
 desc 'Manage Vlag_health on Lenovo CNOS. Requires cnos-rbapi'

 confine operatingsystem: [:ubuntu]
 
 def peer_ip
     conn = Connect.new('./config.yml')
     resp = Vlag.get_vlag_health(conn)
     resp['peer_ip']
 end
 
 def keepalive_interval
     conn = Connect.new('./config.yml')
     resp = Vlag.get_vlag_health(conn)
     resp['keepalive_interval']
 end

 def retry_interval
     conn = Connect.new('./config.yml')
     resp = Vlag.get_vlag_health(conn)
     resp['retry_interval']
 end

 def keepalive_attempts
     conn = Connect.new('./config.yml')
     resp = Vlag.get_vlag_health(conn)
     resp['keepalive_attempts']
 end

 def vrf
     conn = Connect.new('./config.yml')
     resp = Vlag.get_vlag_health(conn)
     resp['vrf']
 end

 def peer_ip=(value)
     conn = Connect.new('./config.yml')
     params = {'peer_ip' => resource[:peer_ip]} 
     resp = Vlag.update_vlag_health(conn, params)
 end
  
 def vrf=(value)
     conn = Connect.new('./config.yml')
     params = {'vrf' => resource[:vrf]} 
     resp = Vlag.update_vlag_health(conn, params)
 end 
 
 def retry_interval=(value)
     conn = Connect.new('./config.yml')
     params = {'retry_interval' => resource[:retry_interval]} 
     resp = Vlag.update_vlag_health(conn, params)
 end
 
 def keepalive_interval=(value)
     conn = Connect.new('./config.yml')
     params = {'keepalive_interval' => resource[:keepalive_interval]} 
     resp = Vlag.update_vlag_health(conn, params)
 end 
 
 def keepalive_attempts=(value)
     conn = Connect.new('./config.yml')
     params = {'keepalive_attempts' => resource[:keepalive_attempts]} 
     resp = Vlag.update_vlag_health(conn, params)
 end 
end 
