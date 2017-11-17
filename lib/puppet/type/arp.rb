Puppet::Type.newtype(:arp) do
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
