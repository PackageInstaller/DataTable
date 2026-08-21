local Conn = require("network.sconn.conn")
local Sconn = require("network.sconn.sconn")
local Defines = require("network.sconn.defines")
local Account = require("gamelogic.account.account")
local ShareRes = require("utils.share_res")
local UnitySystemInfo = UnityEngine.SystemInfo
local HEARTBEAT_INTERVAL = 5
local TIMEOUT_MASK_INTERVAL = 5
local conn_mt = {}
conn_mt.__index = conn_mt

function conn_mt.new()
  local o = {}
  setmetatable(o, conn_mt)
  o:_init()
  return o
end

function conn_mt:_init()
  self.v_gatesvr_idx = 1
  local cfg = {}
  self.v_sconn = Sconn.create(cfg, self)
  self.v_last_ping_send = 0
  self.v_recv_from_heartbeat = true
  self.v_timeout_timestamp = math.maxinteger
end

function conn_mt:name()
  return "大厅"
end

function conn_mt:get_login_request()
  local mac_address = UnitySystemInfo.deviceUniqueIdentifier
  local login_token = Account:get_login_token()
  local device_type = Account:get_device_type()
  local platform = Account:get_platform()
  local account = Account:get_account()
  local body = {
    token = login_token,
    device_type = device_type,
    platform = platform,
    account_id = account,
    is_reconnect = false,
    client_version = Util.get_version_str(),
    res_version = ShareRes.get_res_version(),
    mac_address = mac_address
  }
  if SDKManager:is_use_sdk() then
    SDKManager:add_login_request_params(body)
  end
  return body
end

function conn_mt:is_fs_conn()
  return false
end

function conn_mt:set_reconnect_cb(v)
  self.v_reconnect_cb = v
end

function conn_mt:set_connected_cb(v)
  self.v_connected_cb = v
end

function conn_mt:on_retry_newconnect(sock)
  if Global.connect_info.WWW then
    local cnt = Account:get_gatesvrs_count()
    self.v_gatesvr_idx = self.v_gatesvr_idx % cnt + 1
    local s_address_info, ipv6_ip = Account:get_gatesvr_address(self.v_gatesvr_idx)
    local address_info = Util.split_str(s_address_info, ":")
    local host, port = address_info[1], address_info[2]
    local host_addr, resolve_err = Conn.resolve(host, ipv6_ip)
    if resolve_err then
      return false, resolve_err
    end
    sock.o_host_addr = host_addr
    sock.o_port = port
    Log.Info("变更目标gatesvr地址:", sock.o_host_addr, sock.o_port)
  end
  return true
end

function conn_mt:on_reconnect(sock)
  if self.v_reconnect_cb then
    return self.v_reconnect_cb()
  end
  return true
end

function conn_mt:on_login_cb(ok, resp)
  if self.v_connected_cb then
    self.v_connected_cb(ok, resp, false)
  end
end

function conn_mt:on_recover_cb(ok, resp)
  if self.v_connected_cb then
    self.v_connected_cb(ok, resp, true)
  end
end

function conn_mt:update()
  if self.v_sconn then
    self.v_sconn:update()
  end
  if not self.v_recv_from_heartbeat and Global.real_time - self.v_timeout_timestamp > TIMEOUT_MASK_INTERVAL then
    UIMgr:get_ui("ui_reconnect_panel"):ui_show()
  end
end

function conn_mt:on_update(state)
  if state == Defines.STATE_FORWARD and Global.real_time - self.v_last_ping_send >= HEARTBEAT_INTERVAL then
    self.v_last_ping_send = Global.real_time
    if self.v_recv_from_heartbeat then
      self.v_timeout_timestamp = Global.real_time
    end
    self.v_recv_from_heartbeat = false
    Network:call("c2gs_heartbeat", E, function()
      self.v_recv_from_heartbeat = true
      UIMgr:try_hide_ui("ui_reconnect_panel")
    end)
  end
end

function conn_mt:send_msg(data, proto_id)
  self.v_sconn:send_msg(data, proto_id)
end

function conn_mt:close()
  if self.v_sconn then
    self.v_sconn:close()
    self.v_sconn = nil
  end
end

function conn_mt:on_throw_error(...)
  Network:handle_connect_error()
end

local function connect(host, port, ipv6_ip)
  local c = conn_mt.new()
  local sock, err = c.v_sconn:connect(host, port, ipv6_ip)
  if not sock then
    return nil, err
  end
  return c
end

return {connect_host = connect}
