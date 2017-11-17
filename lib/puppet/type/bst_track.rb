Puppet::Type.newtype(:bst_track) do
  desc ' = {
 	    Manage bst tracking on Lenovo cnos.

 	    Example:
 	     bst_track {"bst":
                     "track-egress-port-service-pool": 1,
 		    "track-egress-uc-queue": 1,
 		    "track-egress-rqe-queue": 1,
 		    "track-egress-cpu-queue": 1,
 		    "track-ingress-port-service-pool": 1,
 		    "track-ingress-service-pool": 1,
 		    "track-egress-mc-queue": 1,
 		    "track-peak-stats": 0,
 		    "track-ingress-port-priority-group": 1,
 		    "track-egress-service-pool": 1,
 		    "track-device": 1
        	    }
           }'

  # Parameters
  newparam(:bst_track, namevar: true) do
    desc 'setting bst tracking - should be "bst"'
    newvalues("bst", "bst_track")
  end

  # Properties
  newproperty(:track_peak_stats) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_ingress_port_priority_group) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_ingress_port_service_pool) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_ingress_service_pool) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_egress_port_service_pool) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_egress_service_pool) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_egress_uc_queue) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_egress_rqe_queue) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_egress_cpu_queue) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_egress_mc_queue) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_device) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end
end
