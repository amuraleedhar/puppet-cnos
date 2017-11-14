require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/vrrp'

Puppet::Type.type(:vrrp).provide :vrrp do
 desc 'Manage VRRP on Lenovo CNOS. Requires cnos-rbapi'

 #confine :feature => :LenovoCheflib
 confine operatingsystem: [:ubuntu]
 
 #mk_resource_methods
 conn = Connect.new('./config.yml')

 def self.instances
     provider_val = []
     conn = Connect.new('./config.yml')
     resp = Vrrp.get_vrrp_prop_all(conn)
     return 'no vrrp' if !resp
     resp.each do  |item|
      provider_val << new(name: item['vr_id'],
                      vr_id: item['vr_id'],
                      if_name: item['if_name'],
                      ensure: :present, 
                      ip_addr: item['ip_addr'],
                      ad_intvl: item['ad_intvl'],
                      preempt: item['preempt'],
                      prio: item['prio'],
                      admin_state: item['admin_state'],
		      oper_state: item['oper_state'],
                      track_if: item['track_if'],
                      accept_mode: item['accept_mode'],
                      switch_back_delay: item['switch_back_delay'],
                      v2_compt: item['v2_compt'])
     end
     return provider_val
 end
 
 def self.prefetch(resources)
     vrrps = instances
     resources.keys.each do |name|
	     if provider = vrrps.find { |vrrp| vrrp.name == name }
		resources[name].provider = provider
	     end
     end
 end
 
 def vr_id
     @property_hash[:vr_id]
 end 

 def if_name
     @property_hash[:if_name]
 end
 
 def ip_addr
     @property_hash[:ip_addr]
 end 
 
 def ad_intvl
     @property_hash[:ad_intvl]
 end 

 def preempt
     @property_hash[:preempt]
 end 
 
 def prio
     @property_hash[:prio]
 end 

 def admin_state
     @property_hash[:admin_state]
 end 

 def oper_state
     @property_hash[:oper_state]
 end 

 def track_if
     @property_hash[:track_if]
 end 

 def accept_mode
     @property_hash[:accept_mode]
 end 
 
 def switch_back_delay
     @property_hash[:switch_back_delay]
 end 

 def v2_compt
     @property_hash[:v2_compt]
 end 

 def ad_intvl=(value)
     conn = Connect.new('./config.yml')
     params = {'vr_id' => resource[:vr_id], 
               'if_name' => resource[:if_name],
               'ad_intvl' => resource[:ad_intvl]
               }
     resp = Vrrp.update_vrrp_intf_vrid(conn, resource[:if_name], resource[:vr_id], params)
     @property_hash[:ad_intvl] = value
 end

 def ip_addr=(value)
     conn = Connect.new('./config.yml')
     params = {'vr_id' => resource[:vr_id], 
               'if_name' => resource[:if_name],
               'ip_addr' => resource[:ip_addr]
               }
     resp = Vrrp.update_vrrp_intf_vrid(conn, resource[:if_name], resource[:vr_id], params)
     @property_hash[:ip_addr] = value
 end
 
 def prio=(value)
     conn = Connect.new('./config.yml')
     params = {'vr_id' => resource[:vr_id], 
               'if_name' => resource[:if_name],
               'prio' => resource[:prio]
               }
     resp = Vrrp.update_vrrp_intf_vrid(conn, resource[:if_name], resource[:vr_id], params)
     @property_hash[:prio] = value
 end

 def track_if=(value)
     conn = Connect.new('./config.yml')
     params = {'vr_id' => resource[:vr_id], 
               'if_name' => resource[:if_name],
               'track_if' => resource[:track_if]
               }
     resp = Vrrp.update_vrrp_intf_vrid(conn, resource[:if_name], resource[:vr_id], params)
     @property_hash[:track_if] = value
 end

 def preempt=(value)
     conn = Connect.new('./config.yml')
     params = {'vr_id' => resource[:vr_id], 
               'if_name' => resource[:if_name],
               'preempt' => resource[:preempt]
               }
     resp = Vrrp.update_vrrp_intf_vrid(conn, resource[:if_name], resource[:vr_id], params)
     @property_hash[:preempt] = value
 end

 def admin_state=(value)
     conn = Connect.new('./config.yml')
     params = {'vr_id' => resource[:vr_id], 
               'if_name' => resource[:if_name],
               'admin_state' => resource[:admin_state]
               }
     resp = Vrrp.update_vrrp_intf_vrid(conn, resource[:if_name], resource[:vr_id], params)
     @property_hash[:admin_state] = value
 end
 
 def switch_back_delay=(value)
     conn = Connect.new('./config.yml')
     params = {'vr_id' => resource[:vr_id], 
               'if_name' => resource[:if_name],
               'switch_back_delay' => resource[:switch_back_delay]
               }
     resp = Vrrp.update_vrrp_intf_vrid(conn, resource[:if_name], resource[:vr_id], params)
     @property_hash[:switch_back_delay] = value
 end

 def accept_mode=(value)
     conn = Connect.new('./config.yml')
     params = {'vr_id' => resource[:vr_id], 
               'if_name' => resource[:if_name],
               'accept_mode' => resource[:accept_mode]
               }
     resp = Vrrp.update_vrrp_intf_vrid(conn, resource[:if_name], resource[:vr_id], params)
     @property_hash[:accept_mode] = value
 end

 def v2_compt=(value)
     conn = Connect.new('./config.yml')
     params = {'vr_id' => resource[:vr_id], 
               'if_name' => resource[:if_name],
               'v2_compt' => resource[:v2_compt]
               }
     resp = Vrrp.update_vrrp_intf_vrid(conn, resource[:if_name], resource[:vr_id], params)
     @property_hash[:v2_compt] = value
 end
 
 def create
     conn = Connect.new('./config.yml')
     params = {"if_name" => resource[:if_name],
	       "vr_id" => resource[:vr_id],
               "ip_addr" => resource[:ip_addr],
               "ad_intvl" => resource[:ad_intvl],
               "preempt" => resource[:preempt],
               "prio" => resource[:prio],
               "admin_state" => resource[:admin_state],
               "track_if" => resource[:track_if],
               "accept_mode" => resource[:accept_mode],
               "switch_back_delay" => resource[:switch_back_delay],
               "v2_compt" => resource[:v2_compt]
              }
     puts params
     Vrrp.create_vrrp_intf(conn, resource[:if_name], params)
 end

 def exists?
     @property_hash[:ensure] == :present
 end

 def destroy
     conn = Connect.new('./config.yml')
     Vrrp.del_vrrp_intf_vrid(conn, resource[:if_name], resource[:vr_id])
 end
end
