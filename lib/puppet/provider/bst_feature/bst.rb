require 'puppet/type'
require 'cnos-rbapi'
require 'cnos-rbapi/telemetry'

Puppet::Type.type(:bst_feature).provide :bst_feature do
  desc 'Manage BST feature on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  def bst_enable
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['bst-enable']
  end

  def send_async_reports
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['send-async-reports']
  end

  def collection_interval
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['collection-interval']
  end

  def trigger_rate_limit_interval
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['trigger-rate-limit-interval']
  end

  def trigger_rate_limit
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['trigger-rate-limit']
  end

  def send_snapshot_on_trigger
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['send-snapshot-on-trigger']
  end

  def async_full_report
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    resp['async-full-report']
  end
 
  def params_setup
    params = {}
    params =
      {
        "collection-interval" => resource[:collection_interval],
        "send-async-reports" => resource[:send_async_reports],
        "send-snapshot-on-trigger" => resource[:send_snapshot_on_trigger],
        "trigger-rate-limit" => resource[:trigger_rate_limit],
        "async-full-report" => resource[:async_full_report],
        "trigger-rate-limit-interval" => resource[:trigger_rate_limit_interval],
        "bst-enable" => resource[:bst_enable]
      }
   return params
  end

  def bst_enable=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    puts params
    resp = Telemetry.set_bst_feature(conn, params)
  end

  def send_async_reports=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_feature(conn, params)
  end

  def collection_interval=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_feature(conn, params)
  end

  def trigger_rate_limit_interval=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_feature(conn, params)
  end

  def send_snapshot_on_trigger=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_feature(conn, params)
  end

  def async_full_report=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_feature(conn, params)
  end

  def trigger_rate_limit=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_feature(conn, params)
  end
end
