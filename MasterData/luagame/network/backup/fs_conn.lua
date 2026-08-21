local KCP = require("kcp")
local Conn = require("network.sconn.conn")
local UdpConn = require("network.sconn.udp_conn")
local BufferQueue = require("network.sconn.buffer_queue")
local Latency = require("network.latency")
local Proto = require("cs_share.proto")
local Network_sproto = require("network.network_sproto")
local SecretWrap = require("network.secret_wrap")
local pack_data = BufferQueue.pack_data
local _sformat = string.format
local DEF_MSG_HEADER_LEN = 2
local DEF_MSG_ENDIAN = "big"
local SOCK_STATE_IDLE = 0
local SOCK_STATE_NEWCONNECT = 1
local SOCK_STATE_RECONNECT = 2
local SOCK_STATE_FORWARD = 3
local SOCK_STATE_CLOSE = 4
local sock_states_text = {
  [SOCK_STATE_IDLE] = "idle",
  [SOCK_STATE_NEWCONNECT] = "newconnect",
  [SOCK_STATE_RECONNECT] = "reconnect",
  [SOCK_STATE_FORWARD] = "forward",
  [SOCK_STATE_CLOSE] = "close"
}
local CONN_STATE_INIT = 0
local CONN_STATE_LOGINNING = 1
local CONN_STATE_LOGINED = 2
local CONN_STATE_QUIT = 3
local PROTOCOL_MODE_TCP = "tcp"
local PROTOCOL_MODE_KCP = "kcp"
local PROTOCOL_TYPE_UDP = 0
local PROTOCOL_TYPE_KCP = 1
local HEARTBEAT_INTERVAL = 5
local KCP_HANDSHAKE_TIMEOUT = 5
local MAX_CONNECT_INTERVAL = 3
local MAX_RECONNECT_TIME = 4
local RECONNECT_INTERVAL = {
  3,
  3,
  3
}
local KCP_FPS = 33
local KCP_UPDATE_MSEC = 1000 / KCP_FPS
local MAX_PROTO_CACHE_SIZE = 1000
local _floor = math.floor
local _tconcat = table.concat
local _spack = string.pack
local ENCODE_TBL = {}

local function pack_udp_data(uuid, proto_type, data)
  ENCODE_TBL[1] = _spack(">I8", uuid)
  ENCODE_TBL[2] = _spack("B", proto_type)
  ENCODE_TBL[3] = data
  return _tconcat(ENCODE_TBL, "")
end

local kcp_obj_mt = {}
kcp_obj_mt.__index = kcp_obj_mt

function kcp_obj_mt.new(uuid, cobj, dispatch_cb)
  local o = {}
  setmetatable(o, kcp_obj_mt)
  o:_init(uuid, cobj, dispatch_cb)
  return o
end

function kcp_obj_mt:_init(uuid, cobj, dispatch_cb)
  self.v_uuid = uuid
  self.v_cobj = cobj
  self.v_cobj:lkcp_wndsize(256, 256)
  self.v_cobj:lkcp_nodelay(1, 10, 2, 1)
  self.v_dispatch_cb = dispatch_cb
  self.v_next_check_ts = 0
  self.v_next_update_ts = 0
  self.v_latency_obj = Latency.new(_sformat("role<%s> kcp", uuid))
end

function kcp_obj_mt:check_update(now)
  if now <= self.v_next_update_ts then
    return
  end
  self.v_cobj:lkcp_update(now)
  self.v_next_update_ts = self.v_cobj:lkcp_check(now)
end

function kcp_obj_mt:update(now)
  if now < self.v_next_check_ts then
    return
  end
  self.v_next_check_ts = now + KCP_UPDATE_MSEC
  self:check_update(now)
end

function kcp_obj_mt:send(data)
  self.v_cobj:lkcp_send(data)
  self.v_next_update_ts = 0
end

function kcp_obj_mt:recv(pkg)
  self.v_cobj:lkcp_input(pkg)
  self.v_next_update_ts = 0
  local cobj = self.v_cobj
  while true do
    local len, data = cobj:lkcp_recv()
    if len <= 0 then
      break
    end
    self.v_dispatch_cb(data)
  end
end

function kcp_obj_mt:flush()
  self.v_cobj:lkcp_flush()
end

function kcp_obj_mt:release()
  self.v_cobj = nil
end

function kcp_obj_mt:get_latency_obj()
  return self.v_latency_obj
end

local conn_mt = {}
conn_mt.__index = conn_mt

function conn_mt.new(info)
  local o = {}
  setmetatable(o, conn_mt)
  o:_init(info)
  return o
end

function conn_mt:_init(info)
  self.v_tcp_state = SOCK_STATE_IDLE
  self.v_tcp_sock = false
  self.v_reconnect_time = 0
  self.v_connect_start_time = 0
  self.v_udp_state = SOCK_STATE_IDLE
  self.v_udp_sock = false
  self.v_login_cb = false
  self.v_reconnect_cb = false
  self.v_logined_num = 0
  self.v_fs_token = assert(info.fs_token)
  self.v_kcp_token = false
  self.v_login_token = false
  self.v_begin_handshake_kcp_ts = 0
  self.v_kcp_obj = false
  self.v_protocol_mode = PROTOCOL_MODE_TCP
  self.v_state = CONN_STATE_INIT
  self.v_last_hb_time = 0
  self.v_out = {}
  self.v_latency_obj = Latency.new(_sformat("role<%s> tcp", Global.player_uuid))
  self.v_proto_cache = Proto.new_proto_cache(MAX_PROTO_CACHE_SIZE)
  self.tcp_secret_wraper = SecretWrap:new()
  self.kcp_secret_wraper = SecretWrap:new()
  self.udp_secret_wraper = SecretWrap:new()
end

function conn_mt:set_login_cb(v)
  self.v_login_cb = v
end

function conn_mt:set_reconnect_cb(v)
  self.v_reconnect_cb = v
end

function conn_mt:set_connect_error_cb(v)
  self.v_connect_error_cb = v
end

function conn_mt:clear_kcp()
  if self.v_kcp_obj then
    if self.v_udp_sock then
      self.v_kcp_obj:flush()
      self.v_udp_sock:update()
    end
    self.v_kcp_obj:release()
    self.v_kcp_obj = false
  end
  if self.v_udp_sock then
    self.v_udp_state = SOCK_STATE_CLOSE
    self.v_udp_sock:close()
    self.v_udp_sock = false
  end
  self.v_protocol_mode = PROTOCOL_MODE_TCP
  self.v_begin_handshake_kcp_ts = 0
end

function conn_mt:connect(host, port)
  local sock, err = Conn.connect_host(host, port)
  if not sock then
    Log.Error(string.format("tcp connect %s:%s failed, %s", host, port, err))
    return nil, err
  end
  self.v_state = CONN_STATE_LOGINNING
  self.v_connect_start_time = Global.real_time
  self.v_tcp_sock = sock
  self.v_tcp_state = SOCK_STATE_NEWCONNECT
  Log.Info(string.format("start tcp connect %s:%s", host, port))
  return sock
end

function conn_mt:check_valid_reconnect(network_err)
  if self.v_tcp_state ~= SOCK_STATE_FORWARD and self.v_tcp_state ~= SOCK_STATE_NEWCONNECT and self.v_tcp_state ~= SOCK_STATE_RECONNECT then
    local err = string.format("fs conn error state switch `%s` to reconnect", sock_states_text[self.v_tcp_state])
    Log.Error(err)
    return false, err
  end
  if self.v_reconnect_time > MAX_RECONNECT_TIME then
    Log.Error("network reconnect fs failed, reach max time", self.v_reconnect_time)
    Network:quit_fs()
    return false, "reconnect max time"
  end
  local interval = RECONNECT_INTERVAL[self.v_reconnect_time] or MAX_CONNECT_INTERVAL
  if self.v_connect_start_time > 0 and self.v_connect_start_time + interval > Global.real_time then
    return false, "connecting"
  end
  return true
end

function conn_mt:reconnect()
  self:clear_kcp()
  self.v_tcp_state = SOCK_STATE_RECONNECT
  self.v_state = CONN_STATE_LOGINNING
  self.v_connect_start_time = Global.real_time
  self.v_reconnect_time = self.v_reconnect_time + 1
  self.v_last_hb_time = 0
  Log.Info("FS尝试重连中, 次数:", self.v_reconnect_time)
  if self.v_reconnect_cb then
    self.v_reconnect_cb()
  end
  local addr = self.v_tcp_sock.o_host_addr
  local port = self.v_tcp_sock.o_port
  local success, err = self.v_tcp_sock:new_connect(addr, port)
  if not success then
    Log.Error("FS重连失败,", self.v_reconnect_time, err)
    return false, err
  end
  return true
end

function conn_mt:handshake_fs()
  Network:call("c2gs_handshake_fs", {
    token = self.v_fs_token
  }, function(ok, resp)
    Log.Info("handshake_fs reply", ok, resp)
    if ok and 0 == resp.errcode then
      self.v_kcp_token = resp.kcp_token
      self.v_login_token = resp.login_token
      self:login_fs(PROTOCOL_MODE_TCP)
    else
      Network:quit_fs()
    end
  end)
end

function conn_mt:connect_udp(host, port)
  self.v_begin_handshake_kcp_ts = Global.real_time
  local sock, err = UdpConn.connect_host(host, port)
  if not sock then
    Log.Error(string.format("udp connect %s:%s failed, %s", host, port, err))
    return nil, err
  end
  self.v_udp_sock = sock
  self.v_udp_state = SOCK_STATE_NEWCONNECT
  Log.Info(string.format("start udp connect %s:%s", host, port))
  return sock
end

function conn_mt:handshake_kcp()
  Log.Info("start handshake kcp")
  Network:call("c2gs_handshake_kcp", {
    token = self.v_kcp_token
  }, function(ok, resp)
    Log.Info("handshake_kcp reply", ok, resp)
    if ok and 0 == resp.errcode then
      if 0 == self.v_begin_handshake_kcp_ts then
        Log.Info("handshake_kcp reply timeout.")
        return
      end
      self:login_fs(resp.protocol or PROTOCOL_MODE_KCP)
    else
      Network:quit_fs()
    end
  end)
end

function conn_mt:init_client_key()
  local client_key = self.tcp_secret_wraper:new_client_key()
  self.kcp_secret_wraper:copy_client_key(self.tcp_secret_wraper)
  return client_key
end

function conn_mt:init_secret_key(server_enc_dhKey)
  self.tcp_secret_wraper:init_secret_key(server_enc_dhKey, true)
  self.kcp_secret_wraper:init_secret_key(server_enc_dhKey, true)
end

function conn_mt:login_fs(protocol_mode)
  Log.Info("start login fs", protocol_mode)
  self.v_begin_handshake_kcp_ts = 0
  self.v_logined_num = self.v_logined_num + 1
  local is_reconnect = self.v_logined_num > 1
  Network:call("c2gs_login_fs", {
    token = self.v_login_token,
    protocol = protocol_mode,
    is_reconnect = is_reconnect,
    client_rproto_recv_num = self.v_proto_cache:get_recv_num(),
    client_dh_key = self:init_client_key()
  }, function(ok, resp)
    Log.Info("login_fs reply", ok, resp)
    if ok and 0 == resp.errcode then
      self:init_secret_key(resp.server_dh_key)
      self.v_state = CONN_STATE_LOGINED
      local succ, cache = self.v_proto_cache:peek_unack_pkgs(resp.server_rproto_recv_num)
      if succ then
        if #cache > 0 then
          Network:call("c2gs_restore_reliable_proto", {flag = 0})
          for _, v in ipairs(cache) do
            local proto_name, data = v[1], v[2]
            self:send_msg(proto_name, data)
          end
          Network:call("c2gs_restore_reliable_proto", {flag = 1})
        end
        Log.Info("restore reliable proto done", resp.server_rproto_recv_num, self.v_proto_cache:get_send_num(), self.v_proto_cache:get_cache_size())
      else
        Log.Error("restore reliable proto failed", resp.server_rproto_recv_num, self.v_proto_cache:get_send_num(), self.v_proto_cache:get_cache_size())
      end
    end
    if self.v_login_cb then
      self.v_login_cb(is_reconnect, resp and resp.errcode or -2)
    end
  end)
  if protocol_mode == PROTOCOL_MODE_KCP then
    local kcp_session = os.time()
    local cobj = KCP.lkcp_create(Global.player_uuid, kcp_session, function(buf)
      local pkg = pack_udp_data(Global.player_uuid, PROTOCOL_TYPE_KCP, buf)
      self.v_udp_sock:send(pkg)
    end)
    self.v_kcp_obj = kcp_obj_mt.new(Global.player_uuid, cobj, function(data)
      Network:dispatch(data, self.kcp_secret_wraper)
    end)
  else
    self:clear_kcp()
  end
  self.v_protocol_mode = protocol_mode
end

function conn_mt:update()
  if not self.v_tcp_sock then
    return false
  end
  local success, err, status = self.v_tcp_sock:update()
  if not success then
    self:handle_socket_err(err)
    return false, err
  end
  if self.v_tcp_state == SOCK_STATE_NEWCONNECT or self.v_tcp_state == SOCK_STATE_RECONNECT then
    self.v_tcp_state = SOCK_STATE_FORWARD
    Log.Info("TCP连接建立成功, ", self.v_reconnect_time)
    self.v_reconnect_time = 0
    self.v_connect_start_time = 0
    self:handshake_fs()
  end
  local count = self.v_tcp_sock:recv_msg(self.v_out)
  for i = 1, count do
    local data = self.v_out[i]
    Network:dispatch(data, self.tcp_secret_wraper)
  end
  if self.v_udp_sock then
    local success, err, status = self.v_udp_sock:update()
    if success then
      if self.v_udp_state == SOCK_STATE_NEWCONNECT then
        self.v_udp_state = SOCK_STATE_FORWARD
        self:handshake_kcp()
      end
    else
      Log.Info("fs udp update failed:", success, err, status, self.v_udp_state)
    end
    local count = self.v_udp_sock:recv(self.v_out)
    for i = 1, count do
      local data = self.v_out[i]
      if self.v_kcp_obj then
        self.v_kcp_obj:recv(data)
      else
        Network:dispatch(data, self.udp_secret_wraper)
      end
    end
    if self.v_kcp_obj then
      local now = _floor(Global.real_time * 1000)
      self.v_kcp_obj:update(now)
    end
  end
  if self.v_begin_handshake_kcp_ts > 0 and Global.real_time - self.v_begin_handshake_kcp_ts >= KCP_HANDSHAKE_TIMEOUT then
    self:login_fs(PROTOCOL_MODE_TCP)
  end
  if self.v_state == CONN_STATE_LOGINED and Global.real_time - self.v_last_hb_time >= HEARTBEAT_INTERVAL then
    self.v_last_hb_time = Global.real_time
    self.v_latency_obj:start()
    Network:call("c2gs_heartbeat_fs", {
      client_rproto_recv_num = self.v_proto_cache:get_recv_num()
    }, function(ok, resp)
      if not ok then
        return
      end
      self.v_latency_obj:stop()
      if 0 == resp.errcode then
        if not self.v_proto_cache:peer_recv_ack(resp.server_rproto_recv_num) then
          Log.Error("recv peer reliable proto ack err", resp.server_rproto_recv_num, self.v_proto_cache:get_send_num())
          Network:quit_fs()
        end
        Network:call("c2gs_heartbeat_fs_ack", E)
      end
    end)
    if self.v_protocol_mode == PROTOCOL_MODE_KCP then
      if self.v_kcp_obj then
        self.v_kcp_obj:get_latency_obj():start()
      end
      Network:call("c2gs_kcp_heartbeat", E, function(ok, resp)
        if not ok then
          return
        end
        if self.v_kcp_obj then
          self.v_kcp_obj:get_latency_obj():stop()
        end
        if 0 == resp.errcode then
          Network:call("c2gs_kcp_heartbeat_ack", E)
        end
      end)
    end
  end
  return true
end

function conn_mt:handle_socket_err(err)
  if self:check_valid_reconnect(err) then
    self.tcp_secret_wraper:clear()
    self.kcp_secret_wraper:clear()
    self.udp_secret_wraper:clear()
    self:reconnect()
  end
end

function conn_mt:send_msg(proto_name, data, proto_id)
  local mode = Network_sproto:get_protocol_mode(proto_name) or self.v_protocol_mode
  proto_id = proto_id or Network_sproto:get_proto_id(proto_name)
  if "tcp" == mode then
    if self.v_tcp_sock and self.v_tcp_state == SOCK_STATE_FORWARD then
      data = self.tcp_secret_wraper:pack_c2s(data, proto_id)
      local pkg = pack_data(data, DEF_MSG_HEADER_LEN, DEF_MSG_ENDIAN)
      self.v_tcp_sock:send(pkg)
    else
      Log.Error("fs send tcp msg failed:", proto_name, sock_states_text[self.v_tcp_state])
      return false
    end
  elseif "udp" == mode then
    if self.v_udp_sock and self.v_udp_state == SOCK_STATE_FORWARD then
      data = self.udp_secret_wraper:pack_c2s(data, proto_id)
      local pkg = pack_udp_data(Global.player_uuid, PROTOCOL_TYPE_UDP, data)
      self.v_udp_sock:send(pkg)
    else
      Log.Error("fs send udp msg failed:", proto_name, sock_states_text[self.v_udp_state])
      return false
    end
  elseif self.v_kcp_obj then
    data = self.kcp_secret_wraper:pack_c2s(data, proto_id)
    self.v_kcp_obj:send(data)
  else
    Log.Error("fs send kcp msg failed:", proto_name, self.v_state)
    return false
  end
  return true
end

function conn_mt:close()
  self.v_state = CONN_STATE_QUIT
  self:clear_kcp()
  if self.v_tcp_sock then
    self.v_tcp_state = SOCK_STATE_CLOSE
    self.v_tcp_sock:update()
    self.v_tcp_sock:close()
    self.v_tcp_sock = false
  end
  self.v_proto_cache:clear_cache()
end

function conn_mt:latency_dump()
  self.v_latency_obj:dump()
  if self.v_kcp_obj then
    self.v_kcp_obj:get_latency_obj():dump()
  end
end

function conn_mt:get_proto_cache()
  return self.v_proto_cache
end

local function connect(info)
  local c = conn_mt.new(info)
  local host, port = string.match(info.fs_addr, "(%g+):(%g+)")
  print("connect fsconn: ", host, port)
  port = _floor(port)
  local sock, err = c:connect(host, port)
  if not sock then
    return nil, err
  end
  return c
end

return {connect_host = connect}
