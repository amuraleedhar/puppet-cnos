require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/lacp'

Puppet::Type.type(:lacp).provide :lacp do
  desc 'Manage Lacp on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  def sys_prio
    conn = Connect.new('./config.yml')
    resp = Lacp.get_lacp(conn)
    resp['sys_prio']
  end

  def sys_prio=(value)
    conn = Connect.new('./config.yml')
    params = { 'sys_prio' => resource[:sys_prio] }
    resp = Lacp.update_lacp(conn, params)
  end
end
