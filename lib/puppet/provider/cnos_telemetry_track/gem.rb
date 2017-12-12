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
require 'yaml'

Puppet::Type.type(:cnos_telemetry_track).provide :gem do
  desc 'Manage BST Tracking on Lenovo CNOS. Requires cnos-rbapi'

  mk_resource_methods

  def self.instances
    provider_val = []
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    resp = Telemetry.get_bst_tracking(conn)
    return 'no bst feature' if !resp
    provider_val << new(name: 'telemetry_tracking',
                        ensure: :present,
                        track_peak_stats: resp['track-peak-stats'],
                        track_device: resp['track-device'],
                        track_ingress_port_priority_group: resp['track-ingress-port-priority-group'],
                        track_ingress_port_service_pool: resp['track-ingress-port-service-pool'],
                        track_ingress_service_pool: resp['track-ingress-service-pool'],
                        track_egress_port_service_pool: resp['track-egress-port-service-pool'],
                        track_egress_service_pool: resp['track-egress-service-pool'],
                        track_egress_rqe_queue: resp['track-egress-rqe-queue'],
                        track_egress_uc_queue: resp['track-egress-uc-queue'],
                        track_egress_cpu_queue: resp['track-egress-cpu-queue'],
                        track_egress_mc_queue: resp['track-egress-mc-queue'])
    return provider_val
  end

  def self.prefetch(resources)
    feature = instances
    resources.keys.each do |name|
      if provider = feature.find { |feature| TRUE }
        resources[name].provider = provider
      end
    end
  end

  def exists?
    @property_hash[:ensure] == :present
    return true
  end

  def params_setup
    params =
      {
        "track-egress-port-service-pool" => resource[:track_egress_port_service_pool],
        "track-egress-uc-queue" => resource[:track_egress_uc_queue],
        "track-egress-rqe-queue" => resource[:track_egress_cpu_queue],
        "track-egress-cpu-queue" => resource[:track_egress_cpu_queue],
        "track-ingress-port-service-pool" => resource[:track_ingress_port_service_pool],
        "track-ingress-service-pool" => resource[:track_ingress_service_pool],
        "track-egress-mc-queue" => resource[:track_egress_mc_queue],
        "track-peak-stats" => resource[:track_peak_stats],
        "track-ingress-port-priority-group" => resource[:track_ingress_port_priority_group],
        "track-egress-service-pool" => resource[:track_egress_service_pool],
        "track-device" => resource[:track_device]
      }
    return params
  end

  def flush
    if @property_hash
      param = YAML.load_file('./config.yml')
      conn = Connect.new(param)
      params = params_setup
      Telemetry.set_bst_tracking(conn, params)
    end
    @property_hash = resource.to_hash
  end
end
