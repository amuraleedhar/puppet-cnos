Puppet::Type.newtype(:cnos_vlan) do
 desc ' = {
	    Manage Vlans on Lenovo cnos.

	    Example:
	     cnos_vlan {1:
	     vlan_name => vlan1,
	     admin_state => up,   
       	    }
          }'
 ensurable

 #Parameters
 newparam(:vlan_id, namevar: true) do
  desc 'vlan_id an integer from 2-3999'

  munge do |value|
        value.to_i
  end
  
  validate do |value|
	unless value.to_i.between?(2, 3999)
	  fail "value not within limit (2-3999)"
	end
  end

 end

 #Properties 
 newproperty(:vlan_name) do
  desc 'string 32 characters long'
 end 
 
 newproperty(:admin_state) do
  desc 'one of up or down'
 end 

end
