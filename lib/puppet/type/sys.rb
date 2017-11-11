Puppet::Type.newtype(:sys) do
 desc ' = {
	    Manage Vlans on Lenovo cnos.

	    Example:
	     system_feature {"sys":
	     heartbeat_enable => 1,
	     msg_interval => 10,   
       	    }
          }'

 #Parameters
 newparam(:sys_feature, namevar: true) do
  desc 'setting system feature - should be "sys"'
  newvalues("sys", "system")

 end

 #Properties 
 newproperty(:heartbeat_enable) do
  desc '0/1 for enable or disable'
  
  munge do |value|
        value.to_i
  end
   
 end 
 
 newproperty(:msg_interval) do
  desc 'determines interval of heartbeat message'
  
  munge do |value|
        value.to_i
  end
  
  validate do |value|
	unless value.to_i.between?(1, 600)
	  fail "value not within limit (1-600)"
	end
  end
 end 

end
