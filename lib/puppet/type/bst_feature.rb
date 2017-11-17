Puppet::Type.newtype(:bst_feature) do
  desc ' = {
 	    Manage bst feature on Lenovo cnos.

 	    Example:
 	     bst_feature {"bst":
                  "bst­enable": 1,
 		 "send­async­reports": 1,
 		 "collection­interval": 300,
 		 "trigger­rate­limit": 5,
 		 "trigger­rate­limit­interval": 2,
 		 "send­snapshot­on­trigger": 1,
 		 "async­full­reports": 1,
        	    }
           }'

  # Parameters
  newparam(:bst_feature, namevar: true) do
    desc 'setting bst feature - should be "bst"'
    newvalues("bst", "bst_feature")
  end

  # Properties
  newproperty(:bst_enable) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:send_async_reports) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:async_full_report) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:collection_interval) do
    desc 'collection interval in seconds'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:trigger_rate_limit) do
    desc 'trigger rate limit'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(1, 5)
        fail "value not within limit (1-5)"
      end
    end
  end

  newproperty(:trigger_rate_limit_interval) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(10, 60)
        fail "value not within limit (10-60)"
      end
    end
  end

  newproperty(:send_snapshot_on_trigger) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:async_full_reports) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end
end
