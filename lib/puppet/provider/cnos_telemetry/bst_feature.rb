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
require 'cnos-rbapi/telemetry'

Puppet::Type.type(:cnos_telemetry).provide :bst_feature do
  desc 'Manage BST feature on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  def self.instances
    Puppet.debug(">>>>>>>instances")
    provider_val = []
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    return 'no vlans' if !resp
    resp.each do |item|
      Puppet.debug(item['vlan_id'])
      provider_val << new(name: 'bst',
                          bst_enable: item['bst_enable'],
                          ensure: :present,
                          send_async_reports: item['send_async_reports'],
                          collection_interval: item['collections-interval'],
                          trigger_rate_limit: item['trigger-rate-limit'],
                          trigger_rate_limit_interval: item['trigger-rate-limit-interval'],
                          send_snapshot_on_trigger: item['send_snapshot_on_trigger'],
                          async_full_reports: item['async_full_reports'])
    end
  end

  def self.prefetch(resources)
    Puppet.debug(">>>>>>>prefetch")
    resp = instances
    resources.keys.each do |name|
      if provider = resp.find { |vlan| vlan.name == name }
        resources[name].provider = provider
      end
    end
  end

=begin
  def bst_enable
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['bst-enable']
  end

  def send_async_reports
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['send-async-reports']
  end

  def collection_interval
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['collection-interval']
  end

  def trigger_rate_limit_interval
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['trigger-rate-limit-interval']
  end

  def trigger_rate_limit
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['trigger-rate-limit']
  end

  def send_snapshot_on_trigger
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['send-snapshot-on-trigger']
  end

  def async_full_report
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['async-full-report']
  end
=end
  def params_setup
    params = {}
    params =
      {
        "collection-interval" => resource[:collection_interval],
        "send-async-reports" => resource[:send_async_reports],
        "send-snapshot-on-trigger" => resource[:send_snapshot_on_trigger],
        "trigger-rate-limit" => resource[:trigger_rate_limit],
        "async-full-report" => resource[:async_full_report],
        "trigger-rate-limit-interval" => resource[:trigger_rate_limit_interval],
        "bst-enable" => resource[:bst_enable]
      }
    return params
  end

  def bst_enable=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    puts params
    resp = Telemetry.set_bst_feature(conn, params)
  end

  def send_async_reports=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_feature(conn, params)
  end

  def collection_interval=(value)
    Puppet.debug("interval")
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_feature(conn, params)
  end

  def trigger_rate_limit_interval=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_feature(conn, params)
  end

  def send_snapshot_on_trigger=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_feature(conn, params)
  end

  def async_full_report=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_feature(conn, params)
  end

  def trigger_rate_limit=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_feature(conn, params)
  end
end
