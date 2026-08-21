local ENABLE_DEBUG = false
local MSG_HANDLE_COUNT = 5000
local OP_BIND = 1
local OP_UNBIND = 2
local M = {}
local mq_mt = {}
M._mq_mt = mq_mt
mq_mt.__index = mq_mt

function mq_mt:mq_init()
  self.v_dispatching = {}
  self.v_mq = {}
  self.v_sz = 0
  self.v_msg_handler = {}
  if ENABLE_DEBUG then
    self.v_debug_idx_to_trace = {}
  end
  self.v_unhandled_handler = {}
  self.v_unhandled_ud = {}
  self.v_freelist = {}
  self.v_freesize = 0
  self.v_handle_to_index = {}
  self.v_next_handle = 1
  self.v_handle_to_msgtype = {}
  self.v_pending_ops = {0}
  self.v_pending_flag = false
  self.v_pending_dirty = false
  self.v_stat_new = 0
  self.v_stat_reuse = 0
  self.v_stat_recycle = 0
  self.v_bind_count = 0
  self.v_debug_dispatching_sz = 0
end

function mq_mt:mq_register(msgtype)
  self.v_msg_handler[msgtype] = {0}
end

local param_key = {
  [1] = "mm_type",
  [2] = "mm_obj",
  [3] = "mm_x",
  [4] = "mm_y"
}
local meta = {
  __newindex = function(tb, k, v)
    local is_exist = false
    for i, v in ipairs(param_key) do
      if v == k then
        is_exist = true
      end
    end
    if not is_exist then
      Log.Error("不能对msg对象的任意字段赋值，你尝试去赋值", k, debug.traceback())
    end
    rawset(tb, k, v)
  end
}

function mq_mt:_mq_newmsg()
  local i = self.v_freesize
  if i > 0 then
    self.v_stat_reuse = self.v_stat_reuse + 1
    self.v_freesize = i - 1
    return self.v_freelist[i]
  end
  self.v_stat_new = self.v_stat_new + 1
  local msg = {
    mm_type = 0,
    mm_obj = false,
    mm_x = false,
    mm_y = false
  }
  if UNITY_EDITOR and GAME_DEBUG then
    setmetatable(msg, meta)
  end
  return msg
end

local Freqs = {}
local FreqTimes = {}
local StatInterval = 10
local StatCount = 10

local function check_msg_freq(msgtype)
  local now = os.time()
  local freq_time = FreqTimes[msgtype]
  if not freq_time then
    FreqTimes[msgtype] = now
    freq_time = now
  end
  local count = Freqs[msgtype] or 0
  if now - freq_time >= 10 then
    FreqTimes[msgtype] = now
    freq_time = now
    count = 0
  end
  Freqs[msgtype] = count + 1
  if now - freq_time <= StatInterval and count + 1 >= StatCount then
    Log.Error("too much msg: ", msgtype, Global.const.Id2Name[msgtype], debug.traceback())
    FreqTimes[msgtype] = nil
    Freqs[msgtype] = nil
  end
end

function mq_mt:mq_publish2(msgtype)
  local msg = self:_mq_newmsg()
  msg.mm_type = assert(msgtype, "msgtype is nil")
  local i = self.v_sz + 1
  self.v_mq[i] = msg
  self.v_sz = i
  return msg
end

function mq_mt:_mq_pend_op(op, p1, p2, p3, p4)
  local t = self.v_pending_ops
  local n = t[1]
  local i = 1 + n * 5
  t[i + 1] = op
  t[i + 2] = p1
  t[i + 3] = p2
  t[i + 4] = p3
  t[i + 5] = p4
  self.v_pending_dirty = true
  t[1] = n + 1
  return
end

function mq_mt:_mq_exec_pendings()
  local t = self.v_pending_ops
  local n = t[1]
  for index = 0, n - 1 do
    local i = 1 + index * 5
    local op, p1, p2, p3, p4 = t[i + 1], t[i + 2], t[i + 3], t[i + 4], t[i + 5]
    t[i + 1], t[i + 2], t[i + 3], t[i + 4], t[i + 5] = nil, nil, nil, nil, nil
    if op == OP_BIND then
      self:_mq_bind_aux(p1, p2, p3, p4)
    elseif op == OP_UNBIND then
      self:_mq_unbind(p1, p2)
    else
      error("[MSGQUEUE] unknown op:" .. tostring(op))
    end
  end
  t[1] = 0
end

function mq_mt:_mq_bind_aux(msgtype, handler, ud, handle)
  local list = self.v_msg_handler[msgtype]
  local count = list[1]
  local idx = count + 1
  if idx <= MSG_HANDLE_COUNT then
    list[3 * idx - 1] = handler
    list[3 * idx] = ud
    list[3 * idx + 1] = handle
    list[1] = idx
    self.v_handle_to_index[handle] = idx
    if ENABLE_DEBUG then
      if not self.v_debug_idx_to_trace[msgtype] then
        self.v_debug_idx_to_trace[msgtype] = {}
      end
      local record = {}
      record.trace = debug.traceback()
      record.is_in_game = TowerMgr and TowerMgr:get_tower() ~= nil
      self.v_debug_idx_to_trace[msgtype][handle] = record
    end
  else
    error("[MSGQUEUE] bind failed! msgtype:" .. tostring(msgtype))
  end
end

function mq_mt:mq_bind(msgtype, handler, ud)
  assert(handler)
  local handle = self.v_next_handle
  assert(not self.v_handle_to_msgtype[handle])
  self.v_handle_to_msgtype[handle] = msgtype
  self.v_next_handle = handle + 1
  if self.v_pending_flag then
    self:_mq_pend_op(OP_BIND, msgtype, handler, ud, handle)
    return handle
  else
    self.v_bind_count = self.v_bind_count + 1
    if self.v_const_name_set then
      local name = self.v_const_name_set[msgtype]
      if name then
        if not self.v_debug_name[name] then
          self.v_debug_name[name] = 0
        end
        self.v_debug_name[name] = self.v_debug_name[name] + 1
      end
    end
    self:_mq_bind_aux(msgtype, handler, ud, handle)
    return handle
  end
end

function mq_mt:mq_unbind(handle)
  assert(handle)
  assert(self.v_handle_to_msgtype[handle])
  local msgtype = self.v_handle_to_msgtype[handle]
  self.v_handle_to_msgtype[handle] = nil
  self:_mq_unbind(msgtype, handle)
end

function mq_mt:_mq_unbind(msgtype, handle)
  if self.v_pending_flag then
    return self:_mq_pend_op(OP_UNBIND, msgtype, handle)
  end
  local list = self.v_msg_handler[msgtype]
  local idx = assert(self.v_handle_to_index[handle])
  local count = list[1]
  self.v_handle_to_index[handle] = nil
  local del_index = 3 * idx + 1
  local last_index = 3 * count + 1
  if last_index ~= del_index then
    list[del_index - 2] = list[last_index - 2]
    list[del_index - 1] = list[last_index - 1]
    list[del_index] = list[last_index]
    self.v_handle_to_index[list[last_index]] = idx
  end
  list[last_index - 2] = nil
  list[last_index - 1] = nil
  list[last_index] = nil
  list[1] = count - 1
  self.v_bind_count = self.v_bind_count - 1
  if ENABLE_DEBUG and self.v_debug_idx_to_trace[msgtype] then
    self.v_debug_idx_to_trace[msgtype][handle] = nil
  end
  if self.v_const_name_set then
    local name = self.v_const_name_set[msgtype]
    if name and self.v_debug_name[name] then
      self.v_debug_name[name] = self.v_debug_name[name] - 1
    end
  end
end

function mq_mt:mq_dispatch()
  self.v_dispatching, self.v_mq = self.v_mq, self.v_dispatching
  local dispatching_sz = self.v_sz
  self.v_debug_dispatching_sz = dispatching_sz
  self.v_sz = 0
  local mq = self.v_dispatching
  local msg_handler = self.v_msg_handler
  self.v_pending_flag = true
  for i = 1, dispatching_sz do
    local msg = mq[i]
    local msgtype = msg.mm_type
    local list = msg_handler[msgtype]
    if nil ~= list then
      local n = list[1]
      if n > 0 then
        for j = 1, n do
          local handler = list[3 * j - 1]
          local ud = list[3 * j]
          handler(ud, msg)
        end
      else
        local h = self.v_unhandled_handler[msgtype]
        if h then
          h(self.v_unhandled_ud[msgtype], msg)
        end
      end
      self:_recycle_msg(msg)
    end
  end
  self.v_pending_flag = false
  if self.v_pending_dirty then
    self.v_pending_dirty = false
    self:_mq_exec_pendings()
  end
end

function mq_mt:mq_clear_freelist()
  local list = self.v_freelist
  for i = 1, self.v_freesize do
    local msg = list[i]
    msg.mm_type = 0
    msg.mm_obj = false
    msg.mm_x = false
    msg.mm_y = false
  end
end

function mq_mt:mq_clear()
  self.v_sz = 0
  local handlers = self.v_msg_handler
  for msgtype, _ in pairs(handlers) do
    handlers[msgtype] = {0}
  end
  local uhandlers = self.v_unhandled_handler
  local unhandled_ud = self.v_unhandled_ud
  for msgtype, _ in pairs(uhandlers) do
    uhandlers[msgtype] = nil
    unhandled_ud[msgtype] = nil
  end
  self.v_bind_count = 0
end

function mq_mt:mq_report()
  return self.v_bind_count
end

function mq_mt:_recycle_msg(msg)
  msg.mm_type = 0
  msg.mm_obj = false
  msg.mm_x = false
  msg.mm_y = false
  local i = self.v_freesize + 1
  self.v_freelist[i] = msg
  self.v_freesize = i
  self.v_stat_recycle = self.v_stat_recycle + 1
end

function M.mq_create_ex(entries, name_set)
  local mq = M.mq_create(name_set)
  mq:mq_init()
  for i = 1, #entries do
    mq:mq_register(entries[i])
  end
  return mq
end

local function FormatDateTimeNow()
  local cDateTime = os.date("*t")
  local strDateTime = string.format("%04d%02d%02d-%02d%02d%02d", tostring(cDateTime.year), tostring(cDateTime.month), tostring(cDateTime.day), tostring(cDateTime.hour), tostring(cDateTime.min), tostring(cDateTime.sec))
  return strDateTime
end

function mq_mt:print_curr()
  local mq = self.v_dispatching
  local msg_str = ""
  for i = 1, self.v_debug_dispatching_sz do
    local msg = mq[i]
    if nil == msg then
      break
    end
    local msgtype = msg.mm_type
    msg_str = msg_str .. Const.get_type_name(msgtype) .. "\n"
  end
  Global.log.Warning(msg_str)
end

function mq_mt:debug_presnapshot()
  if not ENABLE_DEBUG then
    Log.Error("debug_presnapshot: ENABLE_DEBUG is false")
    return
  end
  self.v_presnapshot = UtilTable.copy_table(self.v_debug_idx_to_trace)
end

function mq_mt:debug_postsnapshot()
  if not ENABLE_DEBUG then
    Log.Error("debug_postsnapshot: ENABLE_DEBUG is false")
    return
  end
  local save_path = "./leak_msgs.txt"
  local fs = io.open(save_path, "w")
  for msgtype, records in pairs(self.v_debug_idx_to_trace) do
    local msg_name = Const.get_type_name(msgtype)
    for handle, record in pairs(records) do
      if not self.v_presnapshot[msgtype] or not self.v_presnapshot[msgtype][handle] then
        local log_msg = "leak msg_name: " .. msg_name .. ", msgtype: " .. tostring(msgtype) .. ", handle: " .. handle .. ", is_in_game: " .. tostring(record.is_in_game) .. ", trace: " .. record.trace
        Log.Info(log_msg)
        fs:write(log_msg .. "\n")
      end
    end
  end
  fs:close()
  Log.Info("leak msgs saved in: ", save_path)
end

function mq_mt:print_debug_msg_handler(target_type, target_idx)
  if not ENABLE_DEBUG then
    Log.Error("print_debug_msg_handler: ENABLE_DEBUG is false")
    return
  end
  for msgtype, list in pairs(self.v_msg_handler) do
    local count = list[1]
    local msg_name = Const.get_type_name(msgtype)
    if (nil == target_type or target_type == msg_name) and self.v_debug_idx_to_trace[msgtype] then
      for handle, record in pairs(self.v_debug_idx_to_trace[msgtype]) do
        if nil == target_idx or target_idx == handle then
          Log.Info("msg_name: " .. msg_name .. ", msgtype: " .. tostring(msgtype) .. ", handle: " .. handle .. ", is_in_game: " .. tostring(record.is_in_game) .. ", trace: " .. record.trace)
        end
      end
    end
  end
end

function M.mq_create(const_name_set)
  local raw = {
    v_dispatching = false,
    v_mq = false,
    v_sz = false,
    v_msg_handler = false,
    v_unhandled_handler = false,
    v_unhandled_ud = false,
    v_recycle_handler = false,
    v_handle_to_msgtype = false,
    v_freelist = false,
    v_freesize = false,
    v_stat_new = false,
    v_stat_reuse = false,
    v_stat_recycle = false,
    v_pending_ops = false,
    v_pending_flag = false,
    v_pending_dirty = false,
    v_handle_to_index = false,
    v_next_handle = false,
    v_debug_name = {},
    v_const_name_set = const_name_set
  }
  local self = setmetatable(raw, mq_mt)
  self:mq_init()
  return self
end

return M
