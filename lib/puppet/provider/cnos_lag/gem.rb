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
require 'cnos-rbapi/lag'
require 'yaml'

Puppet::Type.type(:cnos_lag).provide :gem do
  desc 'Manage lag on Lenovo CNOS. Requires cnos-rbapi'

  def params_setup
    params = {}
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    params['lag_id'] = resource[:lag_id]
    if resource[:min_links] != nil
      params['min_links'] = resource[:min_links]
    end
    if resource[:interfaces] != nil
      params['interfaces'] = resource[:interfaces]
    end
    return params
  end

  def interfaces
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    params = params_setup
    resp = Lag.get_lag_prop(conn, resource[:lag_id])
    resp['interfaces']
  end

  def min_links
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    params = params_setup
    resp = Lag.get_lag_prop(conn, resource[:lag_id])
    resp['min_links']
  end

  def min_links=(value)
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    params = params_setup
    resp = Lag.update_lag(conn, resource[:lag_id], params)
  end

  def interfaces=(value)
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    params = params_setup
    resp = Lag.update_lag(conn, resource[:lag_id], params)
  end

  def create
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    Lag.create_lag(conn, resource[:lag_id], resource[:interfaces])
  end

  def exists?
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    resp = Lag.get_lag_prop(conn, resource[:lag_id])
    resp != nil
  end

  def destroy
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    Lag.delete_lag(conn, resource[:lag_id])
  end
end
