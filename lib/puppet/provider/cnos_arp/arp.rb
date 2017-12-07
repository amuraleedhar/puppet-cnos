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
require 'cnos-rbapi/arp'
require 'yaml'

Puppet::Type.type(:cnos_arp).provide :arp do
  desc 'Manage Arp on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  def ageout_time
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    resp = Arp.get_arp_intf_prop(conn, resource[:if_name])
    resp['ageout_time']
  end

  def ageout_time=(value)
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    params = { 'if_name' => resource[:if_name], 'ageout_time' => resource[:ageout_time] }
    resp = Arp.set_arp_intf_prop(conn, resource[:if_name], params)
  end
end
