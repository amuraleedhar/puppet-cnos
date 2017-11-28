#
# Copyright (C) 2017 Lenovo, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/vlan'

Puppet::Type.type(:cnos_vlan).provide :rest do
  desc 'Manage Vlan on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  mk_resource_methods
  conn = Connect.new('./config.yml')

  def self.instances
    Puppet.debug(">>>>>>>instances")
    provider_val = []
    conn = Connect.new('./config.yml')
    resp = Vlan.get_all_vlan(conn)
    return 'no vlans' if !resp
    resp.each do |item|
      Puppet.debug(item['vlan_id'])
      provider_val << new(name: item['vlan_id'].to_s,
                          vlan_name: item['vlan_name'],
                          ensure: :present,
                          admin_state: item['admin_state'])
    end
    provider_val.each do |pv|
     Puppet.debug(pv.inspect)
    end
    Puppet.debug(provider_val.class)
    return provider_val
  end

  def self.prefetch(resources)
    Puppet.debug(">>>>>>>prefetch")
    vlans = instances
    resources.keys.each do |name|
      if provider = vlans.find { |vlan| vlan.name == name }
        resources[name].provider = provider
      end
    end
  end

  def flush
    Puppet.debug(">>>>>>>flush")
    params = {}
    if @property_hash != {}
      puts @property_hash
      conn = Connect.new('./config.yml')
      if resource[:vlan_name] != nil
        params['vlan_name'] = resource[:vlan_name]
      end
      if resource[:admin_state] != nil
        params['admin_state'] = resource[:admin_state]
      end
      resp = Vlan.update_vlan(conn, resource[:vlan_id], params)
    end
    @property_hash = resource.to_hash
  end

  def create
    Puppet.debug(">>>>>>>create")
    conn = Connect.new('./config.yml')
    params = { "vlan_id" => resource[:vlan_id],
               "vlan_name" => resource[:vlan_name],
               "admin_state" => resource[:admin_state] }
    Vlan.create_vlan(conn, params)
    Puppet.notice(@property_hash.inspect)
    @property_hash.clear
    Puppet.notice(@property_hash.inspect)
  end

  def exists?
    Puppet.debug(">>>>>>>exists")
    @property_hash[:ensure] == :present
  end

  def destroy
    Vlan.delete_vlan(conn, resource[:vlan_id])
    @property_hash.clear
  end
end
