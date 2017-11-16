require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/vlag'

Puppet::Type.type(:vlag).provide :vlag do
 desc 'Manage Vlag on Lenovo CNOS. Requires cnos-rbapi'

 #confine :feature => :LenovoCheflib
 confine operatingsystem: [:ubuntu]
 
 mk_resource_methods

 def self.instances
     provider_val = []
     conn = Connect.new('./config.yml')
     resp = Vlag.get_all_vlag(conn)
     return 'no vlags' if !resp
     resp.each do  |item|
      provider_val << new(name: item['inst_id'],
                      port_aggregator: item['port_aggregator'],
                      ensure: :present, 
                      status: item['status'])
     end
     return provider_val
 end
 
 def self.prefetch(resources)
     vlags = instances
     puts vlags
     resources.keys.each do |name|
	     if provider = vlags.find { |vlag| vlag.name == name }
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
       params = {'port_aggregator' => resource[:port_aggregator],
                 'status' => resource[:status]}
       resp = Vlag.update_vlag_inst(conn, resource[:inst_id], params)
     end
     @property_hash = resource.to_hash
 end
 
 def create
     conn = Connect.new('./config.yml')
     params = {"inst_id" => resource[:inst_id],
	       "port_aggregator" => resource[:port_aggregator],
               "status" => resource[:status]
              }
     Vlag.create_vlag_inst(conn, params)
 end

 def exists?
     @property_hash[:ensure] == :present
 end

 def destroy
     conn = Connect.new('./config.yml')
     Vlag.delete_vlag_inst(conn, resource[:inst_id])
 end
end
