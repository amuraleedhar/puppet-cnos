Puppet::Type.newtype(:vlag) do
 desc ' = {
	    Manage Vlags on Lenovo cnos.

	    Example:
	     cnos_vlag {1:
	     port_aggregator => <port_aggregator>,
	     status => enable/disable,   
       	    }
          }'
 ensurable

 #Parameters
 newparam(:inst_id, namevar: true) do
  desc 'inst_id an integer from 2-3999'

  munge do |value|
        value.to_i
  end
   
  validate do |value|
	unless value.to_i.between?(1, 64)
	  fail "value not within limit (1-64)"
	end
  end

 end

 #Properties 
 newproperty(:port_aggregator) do
  desc 'string 32 characters long'
  
  munge do |value|
        value.to_i
  end
   
  validate do |value|
	unless value.to_i.between?(1, 4096)
	  fail "value not within limit (1-4096)"
	end
  end
 end 
 
 newproperty(:status) do
  desc 'one of up or down'
  newvalues(:enable, :disable)
 end
end 
