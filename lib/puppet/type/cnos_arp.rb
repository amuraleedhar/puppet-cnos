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

Puppet::Type.newtype(:cnos_arp) do
  desc ' = {
 	    Manage ARP properties on Lenovo cnos.

 	    Example:
 	     arp {"<if_name>":
 	     ageout_time => <ageout_time>,
        	    }
           }'
  # Parameters
  newparam(:if_name, namevar: true) do
    desc 'Ethernet interface name'
  end

  # Properties
  newproperty(:ageout_time) do
    desc 'integer from 60-28800'

    munge do |value|
      value.to_i
    end
  end
end