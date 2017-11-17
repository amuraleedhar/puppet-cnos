require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/telemetry'

Puppet::Type.type(:sys).provide :system do
  desc 'Manage System properties on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  def heartbeat_enable
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_sys_feature(conn)
    resp['heartbeat-enable']
  end

  def msg_interval
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_sys_feature(conn)
    resp['msg-interval']
  end

  def heartbeat_enable=(value)
    conn = Connect.new('./config.yml')
    params = { 'heartbeat-enable' => resource[:heartbeat_enable],
               'msg-interval' => resource[:msg_interval] }
    resp = Telemetry.set_sys_feature(conn, params)
  end

  def msg_interval=(value)
    conn = Connect.new('./config.yml')
    params = { 'heartbeat-enable' => resource[:heartbeat_enable],
               'msg-interval' => resource[:msg_interval] }
    resp = Telemetry.set_sys_feature(conn, params)
  end
end
