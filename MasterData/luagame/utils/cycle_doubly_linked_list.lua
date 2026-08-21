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

function M:_init()
  local head_node = self:create_node(0)
  self.v_head_pointer = head_node
  self.v_tail_pointer = head_node
end

function M:insert_tail(info)
  local new_node = self:create_node(info)
  self.v_tail_pointer.next = new_node
  new_node.pre = self.v_tail_pointer
  self.v_tail_pointer = new_node
  local now_first_node = self.v_head_pointer.next
  self.v_tail_pointer.next = now_first_node
  now_first_node.pre = self.v_tail_pointer
  self:add_length()
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
  next_node.pre = pre_node
  now_node.data = nil
  now_node.pre = nil
  now_node.next = nil
  push_lua_tbl(now_node)
  self:reduce_length()
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
end

return M
