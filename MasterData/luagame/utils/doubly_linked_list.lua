local Util = require("utils.util")
local M = Util.create_class()
local LUA_TBL_COUNT = 0
local LUA_TBLS = {}

local function pop_lua_tbl()
  if LUA_TBL_COUNT <= 0 then
    return {}
  end
  local tbl = LUA_TBLS[LUA_TBL_COUNT]
  LUA_TBLS[LUA_TBL_COUNT] = nil
  LUA_TBL_COUNT = LUA_TBL_COUNT - 1
  return tbl
end

local function push_lua_tbl(tbl)
  if LUA_TBL_COUNT >= 50 then
    return
  end
  LUA_TBL_COUNT = LUA_TBL_COUNT + 1
  LUA_TBLS[LUA_TBL_COUNT] = tbl
end

function M:_init(record_data_to_node)
  local head_node = self:create_node(0)
  self.v_head_pointer = head_node
  self.v_tail_pointer = head_node
  self.v_forech_node = nil
  if record_data_to_node then
    self.v_value_to_node_map = pop_lua_tbl()
  end
end

function M:insert_tail(info)
  local new_node = self:create_node(info)
  self.v_tail_pointer.next = new_node
  new_node.pre = self.v_tail_pointer
  self.v_tail_pointer = new_node
  self:add_length()
  if self.v_value_to_node_map then
    if self.v_value_to_node_map[info] then
      Log.Error("链表中插入相同数据导致映射失效，请检查逻辑代码", debug.traceback())
    end
    self.v_value_to_node_map[info] = new_node
  end
  return new_node
end

function M:remove_head()
  local now_node = self:get_node_by_idx(1)
  if not now_node then
    return
  end
  self:remove_node(now_node)
end

function M:remove_node(now_node)
  local pre_node = now_node.pre
  local next_node = now_node.next
  pre_node.next = next_node
  if next_node then
    next_node.pre = pre_node
  end
  if self.v_tail_pointer == now_node then
    self.v_tail_pointer = pre_node
  end
  if self.v_value_to_node_map and self.v_value_to_node_map[now_node.data] then
    self.v_value_to_node_map[now_node.data] = nil
  end
  now_node.data = nil
  now_node.pre = nil
  now_node.next = nil
  push_lua_tbl(now_node)
  self:reduce_length()
end

function M:remove_node_by_value(value)
  if not self.v_value_to_node_map then
    Log.Error("未创建data-node映射表，请检查逻辑代码", debug.traceback())
    return
  end
  local node = self.v_value_to_node_map[value]
  if node then
    self:remove_node(node)
  end
end

function M:get_node_by_idx(idx)
  if idx <= 0 or idx > self:get_length() then
    return false
  end
  local now_node = self.v_head_pointer
  for _ = 1, idx do
    now_node = now_node.next
  end
  return now_node
end

function M:get_node_val_by_idx(idx)
  if idx <= 0 or idx > self:get_length() then
    return false
  end
  local now_node = self.v_head_pointer
  for _ = 1, idx do
    now_node = now_node.next
  end
  return now_node.data
end

function M:add_length()
  self.v_head_pointer.data = self.v_head_pointer.data + 1
end

function M:reduce_length()
  self.v_head_pointer.data = self.v_head_pointer.data - 1
end

function M:create_node(info)
  local tb = pop_lua_tbl()
  tb.data = info
  return tb
end

function M:get_length()
  return self.v_head_pointer.data
end

function M:show_list()
  if self:get_length() <= 0 then
    return
  end
  local head_node = self.v_head_pointer
  while head_node.next do
    head_node = head_node.next
    Log.Error("now node :", head_node)
  end
end

function M:on_clear()
  local now_node = self.v_head_pointer.next
  while now_node do
    local next_node = now_node.next
    now_node.data = nil
    now_node.pre = nil
    now_node.next = nil
    push_lua_tbl(now_node)
    self:reduce_length()
    now_node = next_node
  end
  if self.v_value_to_node_map then
    UtilTable.clear_map(self.v_value_to_node_map)
  end
  self.v_forech_node = nil
end

function M:on_destroy()
  self:on_clear()
  if self.v_value_to_node_map then
    push_lua_tbl(self.v_value_to_node_map)
    self.v_value_to_node_map = nil
  end
end

function M:iterator_run_and_get_val()
  if self.v_forech_node.next then
    self.v_forech_node = self.v_forech_node.next
    return self.v_forech_node.data
  end
end

function M:begin_iterator()
  self.v_forech_node = self.v_head_pointer
end

return M
