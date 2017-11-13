Puppet::Type.newtype(:vlag_health) do
 desc ' = {
	    Manage Vlag Health on Lenovo cnos.

	    Example:
	     lacp {"vlaghealth":
                        "keepalive_interval": 10,
			"retry_interval": 30,
			"peer_ip": "10.240.177.120",
			"vrf": "default",
			"keepalive_attempts": 3
           
       	    }
          }'

 #Parameters
 newparam(:title, namevar: true) do
   desc 'name of parameter'
 end
 
 #Properties 
 newproperty(:peer_ip) do
  desc 'ip address'
 end
 
 newproperty(:vrf) do
  desc 'vrf context string'
 end

 newproperty(:keepalive_attempts) do
  desc 'No of keepalive attempts'
   
  munge do |value|
        value.to_i
  end
  
  validate do |value|
   unless value.to_i.between?(1, 24)
    fail "value not within limit (1-24)"
   end
  end 
 
 end 
 
 newproperty(:keepalive_interval) do
  desc 'No of keepalive interval'
   
  munge do |value|
        value.to_i
  end
  
  validate do |value|
   unless value.to_i.between?(2, 300)
    fail "value not within limit (2-300)"
   end
  end 
 
 end 
 
 newproperty(:retry_interval) do
  desc 'No of keepalive attempts'
   
  munge do |value|
        value.to_i
  end
  
  validate do |value|
   unless value.to_i.between?(1, 300)
    fail "value not within limit (1-300)"
   end
  end 
 
 end 
end
