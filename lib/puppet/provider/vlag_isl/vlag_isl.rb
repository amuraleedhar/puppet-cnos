require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/vlag'

Puppet::Type.type(:vlag_isl).provide :vlag_isl do
  desc 'Manage Vlag on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  def port_aggregator
    conn = Connect.new('./config.yml')
    resp = Vlag.get_vlag_isl(conn)
    resp['port_aggregator']
  end

  def port_aggregator=(value)
    conn = Connect.new('./config.yml')
    params = { 'port_aggregator' => resource[:port_aggregator] }
    resp = Vlag.update_vlag_isl(conn, params)
  end
end
