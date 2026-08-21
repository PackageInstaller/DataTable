local Network_sproto = require("network.network_sproto")
local ZSConn = require("network.zs_conn")
local FSConn = require("network.fs_conn")
local WaitBlockMgr = require("network.network_block_mgr")
local Account = require("gamelogic.account.account")
local Proto = require("cs_share.proto")
local RPC_TIMEOUT = 60003
local PRINT_PROTO_FILTER = {gs2c_call_scene = true}
local M = {}

local function network_not_ready()
  if Util.is_client_only() then
    return
  end
  Log.Info("network not ready")
end

local LOST_BATTLE = 1049
local ERRORCODE_FUNCS = {
  [LOST_BATTLE] = function(error_info)
    TowerMgr:on_lost_battle(error_info)
    return true
  end
}

function M:_response_func(response, ud, callback)
  if response and not Util.is_errcode_empty(response.errcode) then
    local errro_code_func = ERRORCODE_FUNCS[response.errcode]
    Util.show_errcode(response.errcode, errro_code_func)
    if errro_code_func then
      return
    end
    if callback then
      callback[1](false, response)
    end
    return
  end
  if callback then
    callback[1](true, response)
  end
end

function M:init(callback, reconncect_cb)
  self:_reset()
  Network_sproto:init()
  local network_notify_cb = require("network.network_notify_cb")
  network_notify_cb.init()
  WaitBlockMgr:check_config_in_editor(self.v_notify_pool)
  local host, port, ipv6_ip, s_address_info
  local connect_info = Global.connect_info
  if connect_info.WWW then
    s_address_info, ipv6_ip = Account:get_fst_gatesvr_address()
    local address_info = Util.split_str(s_address_info, ":")
    host = address_info[1]
    port = address_info[2]
  else
    host = connect_info.IP
    port = connect_info.port or 80
  end
  Log.force_print("connect to server: ", host, port)
  local obj, err = ZSConn.connect_host(host, port, ipv6_ip)
  if not obj then
    Log.Error("网络初始化错误: ", err)
    local msg = "网络连接失败"
    if err then
      msg = msg .. ":" .. err
    end
    Util.show_error(msg)
  else
    self.v_conn = obj
    self.v_conn:set_connected_cb(callback)
    self.v_conn:set_reconnect_cb(reconncect_cb)
  end
end

function M:close()
  self:quit_fs()
  if self.v_conn then
    self.v_conn:close()
    self.v_conn = false
    MsgGame:mq_publish2(Const.MSG_NETWORK_CNT_CLOSE)
    self:_reset()
  end
end

function M:login_fs(info, callback, reconncet_cb)
  self:quit_fs()
  local obj, err = FSConn.connect_host(info)
  if not obj then
    Log.Error("FS网络初始化错误: ", err)
    callback(false, -1)
  else
    self.v_fs_conn = obj
    self.v_fs_conn:set_login_cb(callback)
    self.v_fs_conn:set_reconnect_cb(reconncet_cb)
    self.v_is_lock_fs = false
  end
end

function M:quit_fs()
  if self.v_fs_conn then
    self.v_fs_conn:close()
    self.v_fs_conn = nil
    self.v_is_lock_fs = false
    MsgGame:mq_publish2(Const.MSG_NETWORK_FIGHT_CNT_CLOSE)
  end
end

function M:promt_network_disconnect()
end

function M:handle_connect_error()
  self:close()
  self:promt_network_disconnect()
  Log.Error("network connect error")
end

function M:is_connected(...)
  return self.v_conn
end

function M:is_fs_connected(...)
  return self.v_fs_conn
end

function M:update()
  if Global.stop_update then
    return
  end
  if self.v_fs_conn then
    self.v_fs_conn:update()
  end
  if self.v_conn then
    self.v_conn:update()
  end
  self:check_timeout()
end

local tmp_list = {n = 0}

function M:check_timeout()
  if not self.v_timeout_pool then
    return
  end
  tmp_list.n = 0
  for session, deadline in pairs(self.v_timeout_pool) do
    if deadline <= Global.real_time then
      self.v_timeout_pool[session] = nil
      tmp_list.n = tmp_list.n + 1
      tmp_list[tmp_list.n] = session
    end
  end
  for i = 1, tmp_list.n do
    local session = tmp_list[i]
    local callback = self.v_response_pool[session]
    self.v_response_pool[session] = nil
    if callback then
      callback[1](false, {errcode = RPC_TIMEOUT})
    end
  end
end

function M:call_and_wait(proto_name, body, callback)
  self:call(proto_name, body, callback, true)
end

function M:call_no_waiting(proto_name, body, callback)
  self:call(proto_name, body, callback, false)
end

function M:lock_fs_call(is_lock)
  self.v_is_lock_fs = is_lock
end

function M:protect_call(proto_name, body, callback, timeout, timeout_tips)
  if nil == timeout_tips then
    timeout_tips = true
  end
  ScreenMaskMgr:open_one_tag(proto_name, timeout, nil, nil, timeout_tips, true)
  
  local function cb(...)
    if callback then
      callback(...)
    end
    ScreenMaskMgr:close_one_tag(proto_name)
  end
  
  self:call(proto_name, body, cb, timeout)
end

function M:call(proto_name, body, callback, timeout, need_wait)
  if not self.v_conn then
    network_not_ready()
    return
  end
  local has_response = Network_sproto:exist_response(proto_name)
  local server_session = has_response and self.v_session or nil
  local req_encode, proto_id = Network_sproto:encode(proto_name, body, server_session)
  local is_fs_proto = Network_sproto:is_fs_proto(proto_id)
  if is_fs_proto and self.v_is_lock_fs then
    return
  end
  if nil ~= callback then
    self.v_response_pool[self.v_session] = {
      callback,
      {proto_name = proto_name, body = body}
    }
    if timeout then
      self.v_timeout_pool[self.v_session] = Global.real_time + timeout
    end
  end
  local is_wait = WaitBlockMgr:check_wait_lock(proto_name)
  if is_wait then
    self.v_response_wait[self.v_session] = proto_name
  end
  self.v_session = self.v_session + 1
  if is_fs_proto then
    if self.v_fs_conn then
      self.v_fs_conn:send_msg(req_encode, proto_id)
    else
      Log.Error("send fs msg no conn:", proto_name, debug.traceback())
    end
  elseif self.v_conn then
    self.v_conn:send_msg(req_encode, proto_id)
  else
    Log.Error("send zs msg no conn:", proto_name, debug.traceback())
  end
end

function M:is_can_c2gs_call_scene()
  return Network:is_connected() and Network:is_fs_connected() and Network:is_fs_connected():get_is_forward()
end

function M:register_cb(proto_name, callback, is_show_debug)
  self.v_notify_pool[proto_name] = callback
  if nil == is_show_debug or true == is_show_debug then
    self.v_show_debug_map[proto_name] = true
  end
end

function M:dispatch(data, is_fs_msg)
  local r1, r2, r3, r4, r5 = Network_sproto:decode(data)
  if "RESPONSE" == r1 then
    M:_response(r2, r3, r4)
  elseif "REQUEST" == r1 then
    self:_request(r2, r3, r4, r5, is_fs_msg)
  end
  if r5 then
    Date.adjust_server_time_offset(r5.timestamp)
  end
end

function M:_response(session, body, ud)
  if nil ~= session then
    local callback = self.v_response_pool[session]
    self.v_response_pool[session] = nil
    if self.v_timeout_pool[session] then
      self.v_timeout_pool[session] = nil
    end
    if self.v_response_wait[session] then
      local proto_name = self.v_response_wait[session]
      self.v_response_wait[session] = nil
      WaitBlockMgr:check_wait_unlock(proto_name)
    end
    self:_response_func(body, ud, callback)
  end
end

function M:_request(proto_name, req_table, resp_func, ud, is_fs_msg)
  if UNITY_EDITOR then
    if UNITY_EDITOR and not PRINT_PROTO_FILTER[proto_name] and "gs2c_task_info" ~= proto_name then
      Log.Info("recv : ", proto_name, req_table)
    end
    local msg = "recv notify: " .. proto_name
    Util.add_debug_msg(msg, req_table)
  end
  WaitBlockMgr:check_wait_unlock(proto_name)
  local has_err = false
  if req_table and not Util.is_errcode_empty(req_table.errcode) then
    Util.show_errcode(req_table.errcode)
    has_err = true
  end
  local callback = self.v_notify_pool[proto_name]
  if callback then
    local rsp_table = callback(req_table, has_err)
    if resp_func then
      local rsp_encode = resp_func(rsp_table, {
        timestamp = Date.now()
      })
      local proto_id = Network_sproto:get_proto_id(proto_name)
      if is_fs_msg then
        if self.v_fs_conn then
          self.v_fs_conn:send_msg(rsp_encode, proto_id)
        else
          Log.Error("send fs msg no conn,", proto_name)
        end
      elseif self.v_conn then
        self.v_conn:send_msg(rsp_encode, proto_id)
      else
        Log.Error("send zs msg no conn,", proto_name)
      end
    end
  else
    Log.Error("没有注册协议回调函数, proto: " .. proto_name)
  end
end

function M:_reset()
  self.v_session = 0
  self.v_out = {}
  self.v_conn = false
  self.v_response_pool = {}
  self.v_response_wait = {}
  self.v_timeout_pool = {}
  self.v_notify_pool = {}
  self.v_show_debug_map = {}
  WaitBlockMgr:reset()
end

return M
