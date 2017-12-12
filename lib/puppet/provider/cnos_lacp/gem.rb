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
require 'cnos-rbapi/lacp'
require 'yaml'

Puppet::Type.type(:cnos_lacp).provide :gem do
  desc 'Manage Lacp on Lenovo CNOS. Requires cnos-rbapi'

  def sys_prio
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    resp = Lacp.get_lacp(conn)
    resp['sys_prio']
  end

  def sys_prio=(value)
    param = YAML.load_file('./config.yml')
    conn = Connect.new(param)
    params = { 'sys_prio' => resource[:sys_prio] }
    resp = Lacp.update_lacp(conn, params)
  end
end
