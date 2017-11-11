require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/lag'
require 'pry'

Puppet::Type.type(:lag).provide :lag do
 desc 'Manage lag on Lenovo CNOS. Requires cnos-rbapi'

 #confine :feature => :LenovoCheflib
 confine operatingsystem: [:ubuntu]
 
 #mk_resource_methods

 def self.instances
     provider_val = []
     conn = Connect.new('./config.yml')
     resp = Lag.get_all_lag(conn)
     return 'no vlags' if !resp
     resp.each do  |item|
      provider_val << new(name: item['lag_id'],
                      interfaces: item['interfaces'],
                      min_links: item['min_links'],
                      ensure: :present,)
     end
     return provider_val
 end
 
 def self.prefetch(resources)
     lags = instances
     puts lags
     resources.keys.each do |name|
	     if provider = lags.find { |lag| lag.name == name }
		resources[name].provider = provider
	     end
     end
 end
 
 def interfaces
     @property_hash[:interfaces]
 end 
 
 def min_links
     @property_hash[:min_links]
 end 
 
 def interfaces=(value)
     conn = Connect.new('./config.yml')
     params = {'lag_id' => resource[:lag_id], 
               'interfaces' => resource[:interfaces]}
     resp = Lag.update_lag(conn, resource[:lag_id], params)
     @property_hash[:interfaces] = value
 end
 
 def min_links=(value)
     conn = Connect.new('./config.yml')
     params = {'lag_id' => resource[:lag_id], 
               'min_links' => resource[:min_links]}
     resp = Lag.update_lag(conn, resource[:lag_id], params)
     @property_hash[:min_links] = value
 end
 
 def create
     conn = Connect.new('./config.yml')
     Lag.create_lag(conn, resource[:lag_id],  resource[:interfaces])
 end

 def exists?
     @property_hash[:ensure] == :present
 end

 def destroy
     conn = Connect.new('./config.yml')
     Lag.delete_lag(conn, resource[:lag_id])
 end
end
