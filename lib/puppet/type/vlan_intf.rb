Puppet::Type.newtype(:vlan_intf) do
 desc ' = {
	    Manage Vlan_intf on Lenovo cnos.

	    Example:
	     vlan_intf {"<if_name>":
	     bridgeport_mode => access/trunk,
	     pvid => "<pvid>",
             vlans => ["<vlan_id>"]   
       	    }
          }'
 #Parameters
 newparam(:if_name, namevar: true) do
  desc 'Ethernet interface name'
 end

 #Properties 
 newproperty(:bridgeport_mode) do
  newvalues(:access, :trunk)
  desc 'one of access/trunk'
 end 
 
 newproperty(:pvid) do
  desc 'integer from 1-3999'
  
  munge do |value|
        value.to_i
  end
 end 
 
 newproperty(:vlans, :array_matching => :all) do
  desc 'VLAN memberships'
 end 

end
