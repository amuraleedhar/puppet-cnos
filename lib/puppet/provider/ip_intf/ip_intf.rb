require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/ip_intf'


Puppet::Type.type(:ip_intf).provide :ip_intf do
 desc 'Manage IP interfaces on Lenovo CNOS. Requires cnos-rbapi'

 confine operatingsystem: [:ubuntu]

 mk_resource_methods
 
 def self.instances
     provider_val = []
     conn = Connect.new('./config.yml')
     resp = Ipintf.get_ip_prop_all(conn)
     return 'no ip_intf' if !resp
     resp.each do  |item|
      provider_val << new(name: item['if_name'],
                      vrf_name: item['vrf_name'],
                      bridge_port: item['bridge_port'],
                      mtu: item['mtu'],
                      ip_addr: item['ip_addr'],
                      ip_prefix_len: item[:ip_prefix_len],
                      admin_state: item[:admin_state],
                      ensure: :present,)
     end
     return provider_val
 end

 def self.prefetch(resources)
     ip_intfs = instances
     resources.keys.each do |name|
	     if provider = ip_intfs.find { |ip_intf| ip_intf.name == name }
		resources[name].provider = provider
	     end
     end
 end

 def initilialize(value={})
     super(value)
     @property_flush = {}
 end
 
 def flush 
     if @property_hash
       conn = Connect.new('./config.yml')
       params = {'if_name' => resource[:if_name], 
                 'bridge_port' => resource[:bridge_port],
                 'mtu' => resource[:mtu],
                 'ip_addr' => resource[:ip_addr],
                 'ip_prefix_len' => resource[:ip_prefix_len],
                 'vrf_name' => resource[:vrf_name],
                 'admin_state' => resource[:admin_state]
                }
       resp = Ipintf.update_ip_prop_intf(conn, resource[:if_name], params)
     end
     @property_hash = resource.to_hash
 end
 
 def exists?
     @property_hash[:ensure] == :present
 end

end 
