Puppet::Type.newtype(:vlag_isl) do
 desc ' = {
	    Manage vlag isl on Lenovo cnos.

	    Example:
	     lacp {"vlag_isl":
               port_aggregator => <port_aggregator> 
       	    }
          }'

 #Parameters
 newparam(:title, namevar: true) do
   desc 'name of parameter'
 end
 
 #Properties 
 newproperty(:port_aggregator) do
  desc 'integer from 1-4096'
   
  munge do |value|
        value.to_i
  end
  
  validate do |value|
   unless value.to_i.between?(1, 4096)
    fail "value not within limit (1-4096)"
   end
  end 
 
 end 
 
end
