require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/vlan_intf'

Puppet::Type.type(:vlan_intf).provide :vlan do
  desc 'Manage Vlan on Lenovo CNOS. Requires cnos-rbapi'

  # confine :feature => :LenovoCheflib
  confine operatingsystem: [:ubuntu]

  # mk_resource_methods
  conn = Connect.new('./config.yml')
=begin
 def self.instances
     puts "here"
    conn = Connect.new('./config.yml')
     provider_val = []
     conn = Connect.new('./config.yml')
     resp = VlanIntf.get_all_vlan_intf(conn)
     return 'no vlans' if !resp
     resp.each do  |item|
      provider_val << new(:name => item['if_name'],
                      :bridgeport_mode => item['bridgeport_mode'],
                      :ensure => :present,
                      :vlans => item['vlans'],
                      :pvid => item['pvid'])
     end
     return provider_val
 end

 def self.prefetch(resources)
     puts "here1"
     vlans = instances
     resources.keys.each do |name|
       if provider = vlans.find { |vlan| vlan.name == name }
    resources[name].provider = provider
       end
     end
 end
 def exists?
     puts "exists"
     conn = Connect.new('./config.yml')
     resp = VlanIntf.get_vlan_prop_intf(conn, resource[:if_name])
     resp == nil
 end
=end
  def bridgeport_mode
    conn = Connect.new('./config.yml')
    resp = VlanIntf.get_vlan_prop_intf(conn, resource[:if_name])
    resp['bridgeport_mode']
    # @property_hash[:bridgeport_mode]
  end

  def pvid
    conn = Connect.new('./config.yml')
    resp = VlanIntf.get_vlan_prop_intf(conn, resource[:if_name])
    resp['pvid']
    # @property_hash[:pvid]
  end

  def vlans
    conn = Connect.new('./config.yml')
    resp = VlanIntf.get_vlan_prop_intf(conn, resource[:if_name])
    resp['vlans']
    # @property_hash[:pvid]
  end

  def bridgeport_mode=(value)
    conn = Connect.new('./config.yml')
    params = { 'pvid' => resource[:pvid],
               'bridgeport_mode' => resource[:bridgeport_mode],
               'vlans' => resource[:vlans],
               'if_name' => resource[:if_name] }
    resp = VlanIntf.update_vlan_intf(conn, resource[:if_name], params)
    # @property_hash[:bridgeport_mode] = value
  end

  def pvid=(value)
    conn = Connect.new('./config.yml')
    params = { 'pvid' => resource[:pvid],
               'bridgeport_mode' => resource[:bridgeport_mode],
               'vlans' => resource[:vlans],
               'if_name' => resource[:if_name] }
    resp = VlanIntf.update_vlan_intf(conn, resource[:if_name], params)
    # @property_hash[:pvid] = value
  end

  def vlans=(value)
    conn = Connect.new('./config.yml')
    params = { 'pvid' => resource[:pvid],
               'bridgeport_mode' => resource[:bridgeport_mode],
               'vlans' => resource[:vlans],
               'if_name' => resource[:if_name] }
    puts params
    resp = VlanIntf.update_vlan_intf(conn, resource[:if_name], params)
    # @property_hash[:vlans] = value
  end
end
