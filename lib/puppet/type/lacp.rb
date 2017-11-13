Puppet::Type.newtype(:lacp) do
 desc ' = {
	    Manage Lacp on Lenovo cnos.

	    Example:
	     lacp {"lacp":
             sys_prio => <sys_prio>
       	    }
          }'

 #Parameters
 newparam(:title, namevar: true) do
   desc 'name of parameter'
 end
 
 #Properties 
 newproperty(:sys_prio) do
  desc 'integer from 1-65535'
   
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
