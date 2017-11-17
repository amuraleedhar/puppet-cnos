Puppet::Type.newtype(:arp_sys) do
  desc ' = {
 	    Manage Lacp on Lenovo cnos.

 	    Example:
 	     lacp {"arp_sys":
              ageout_time => ageout_time
        	    }
           }'

  # Parameters
  newparam(:title, namevar: true) do
    desc 'name of parameter'
  end

  # Properties
  newproperty(:ageout_time) do
    desc 'integer from 60-28800'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(60, 28800)
        fail "value not within limit (60-28800)"
      end
    end
  end
end
