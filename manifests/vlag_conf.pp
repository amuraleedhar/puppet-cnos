cnos_vlag_conf { 'vlag_health':
  ensure        => 'present',
  priority      => 0,
  startup_delay => 120,
  status        => 'enable',
  tier_id       => 10,
}
