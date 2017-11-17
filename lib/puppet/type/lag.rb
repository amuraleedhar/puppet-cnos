Puppet::Type.newtype(:lag) do
  desc ' = {
 	    Manage lags on Lenovo cnos.

 	    Example:
 	     lag {"<lag_id>":
              "interfaces": [
 		  {
 		    "if_name": "<if_name>",
 		    "lag_mode": "<lag_mode>",
 		    "lacp_prio": "<lacp_prio>",
 		    "lacp_timeout": "<lacp_timeout>"
 		  }
 		]

        	    }
           }'
  ensurable

  # Parameters
  newparam(:lag_id, namevar: true) do
    desc 'lag_id an integer from 1-4096'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(1, 4096)
        fail "value not within limit (1-4096)"
      end
    end
  end

  # Properties
  newproperty(:interfaces, array_matching: :all) do
    desc 'array of interfaces dictionary'

    def insync?(current)
      current.sort == should.sort
    end
  end

  newproperty(:min_links) do
    desc 'lag_id an integer from 1-4096'

    munge do |value|
      value.to_i
    end

    validate do |value|
       unless value.to_i.between?(1, 65535)
         fail "value not within limit (1-65535)"
       end
     end
  end
end
