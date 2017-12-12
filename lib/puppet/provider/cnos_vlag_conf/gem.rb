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
require 'cnos-rbapi/vlag'
require 'yaml'

Puppet::Type.type(:cnos_vlag_conf).provide :gem do
  desc 'Manage Vlag_conf on Lenovo CNOS. Requires cnos-rbapi'

  mk_resource_methods

  def self.instances
    provider_val = []
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    resp = Vlag.get_vlag_conf(conn)
    return 'no vlag conf' if !resp
    provider_val << new(name: 'vlag_health',
                        status: resp['status'],
                        priority: resp['priority'],
                        auto_recover: resp['auto_recover'],
                        startup_delay: resp['startup_delay'],
                        ensure: :present,
                        tier_id: resp['tier_id'])
    return provider_val
  end

  def self.prefetch(resources)
    vlag = instances
    resources.keys.each do |name|
      if provider = vlag.find { |vlag| TRUE }
        resources[name].provider = provider
      end
    end
  end

  def flush
    params = {}
    if @property_hash != {}
      param = YAML.load_file('./config.yml')
      conn = Connect.new(param)
      if resource[:status] != nil
        params['status'] = resource[:status]
      end
      if resource[:tier_id] != nil
        params['tier_id'] = resource[:tier_id]
      end
      if resource[:priority] != nil
        params['priority'] = resource[:priority]
      end
      if resource[:auto_recover] != nil
        params['auto_recover'] = resource[:auto_recover]
      end
      if resource[:startup_delay] != nil
        params['startup_delay'] = resource[:startup_delay]
      end
      resp = Vlag.update_vlag_conf(conn, params)
    end
    @property_hash = resource.to_hash
  end

  def exists?
    @property_hash[:ensure] == :present
    return true
  end

  def destroy
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    # restoring to default values since there is no delete
    @property_hash.clear
  end
end
