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

Puppet::Type.type(:cnos_arp_sys).provide :gem do
  desc 'Manage Arp_sys on Lenovo CNOS. Requires cnos-rbapi'

  def ageout_time
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    resp = Arp.get_arp_sys_prop(conn)
    resp['ageout_time']
  end

  def ageout_time=(value)
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    params = { 'ageout_time' => resource[:ageout_time] }
    resp = Arp.set_arp_sys_prop(conn, params)
  end
end
