local Util = require("utils.util")
local PRE_KEY = 1
local NEXT_KEY = 2
local PATH_KEY = 3
local TOUCH_TIME = 4
local COUNT_KEY = 5
local OBJ_KEY = 6
local LUA_OBJ_TBL_KEY = 7
local PATH_KEY = 8
local MAX_FREE_OBJ = 3
local RELEASE_TIME = 2
local CACHE_RES_RELEASE_TIME = 60
local MAX_CACHE_TIME = 150
local _insert = table.insert
local _floor = math.floor
local _max = math.max
local MAX_OBJPOOL_FREE_COUNT = 20
local LuaObjPool = Util.create_class()

function LuaObjPool:_init()
  self.v_free_objs = {}
  self.v_count = 0
end

function LuaObjPool:release(luaobj)
  if self.v_count >= MAX_OBJPOOL_FREE_COUNT or self.v_free_objs[luaobj] then
    return
  end
  luaobj[PATH_KEY] = nil
  luaobj[PRE_KEY] = nil
  luaobj[NEXT_KEY] = nil
  luaobj[OBJ_KEY] = nil
  luaobj[LUA_OBJ_TBL_KEY] = nil
  luaobj[COUNT_KEY] = nil
  self.v_count = self.v_count + 1
  self.v_free_objs[luaobj] = true
end

function LuaObjPool:pop()
  if self.v_count <= 0 then
    return {}
  else
    local luaobj = next(self.v_free_objs)
    self.v_free_objs[luaobj] = nil
    self.v_count = self.v_count - 1
    return luaobj
  end
end

local LUAOBJPOOL = LuaObjPool:new()
local Fifo = Util.create_class()

function Fifo:_init(lru, max_count)
  self.v_count = 0
  self.v_max_count = max_count
  self.v_almost_full_count = _floor(self.v_max_count * 2 / 3)
  self.v_lru = lru
  self.v_is_res = lru:is_res()
  self.v_head = nil
  self.v_tail = nil
end

function Fifo:clear()
  self.v_count = 0
  self.v_head = nil
  self.v_tail = nil
end

function Fifo:insert(path, obj)
  if self.v_count >= self.v_max_count and not self.v_is_res then
    self:pop()
  end
  local lua_obj = LUAOBJPOOL:pop()
  lua_obj[PATH_KEY] = path
  lua_obj[OBJ_KEY] = obj
  lua_obj[NEXT_KEY] = self.v_head
  lua_obj[PRE_KEY] = nil
  if not self.v_head then
    self.v_head = lua_obj
    self.v_tail = lua_obj
  else
    self.v_head[PRE_KEY] = lua_obj
    self.v_head = lua_obj
  end
  self.v_count = self.v_count + 1
  return lua_obj
end

function Fifo:pop()
  if self.v_count <= 0 then
    return
  end
  local lua_obj = self.v_tail
  self.v_tail = self.v_tail[PRE_KEY]
  if self.v_tail then
    self.v_tail[NEXT_KEY] = nil
  end
  self.v_count = self.v_count - 1
  if self.v_count <= 0 then
    self.v_head = nil
    self.v_tail = nil
  end
  self.v_lru:release_obj(lua_obj)
  LUAOBJPOOL:release(lua_obj)
end

function Fifo:remove(lua_obj)
  assert(self.v_count > 0)
  self.v_count = self.v_count - 1
  if self.v_count <= 0 then
    self.v_head = nil
    self.v_tail = nil
    LUAOBJPOOL:release(lua_obj)
    return
  end
  local pre_lua_obj = lua_obj[PRE_KEY]
  local next_lua_obj = lua_obj[NEXT_KEY]
  if pre_lua_obj then
    pre_lua_obj[NEXT_KEY] = next_lua_obj
  end
  if next_lua_obj then
    next_lua_obj[PRE_KEY] = pre_lua_obj
  end
  if lua_obj == self.v_tail then
    self.v_tail = pre_lua_obj
  elseif lua_obj == self.v_head then
    self.v_head = next_lua_obj
  end
  LUAOBJPOOL:release(lua_obj)
end

function Fifo:is_full()
  return self.v_count >= self.v_max_count
end

function Fifo:is_almost_full()
  return self.v_count >= self.v_almost_full_count
end

function Fifo:get_all(tbl)
  local cur = self.v_head
  while cur do
    _insert(tbl, {
      cur[PATH_KEY],
      cur[OBJ_KEY]
    })
    cur = cur[NEXT_KEY]
  end
end

local M = Util.create_class()

function M:_init(long_count, max_count, max_instantiate_count, is_res, res_type)
  self.v_long_count = long_count
  self.v_max_count = max_count
  self.v_almost_full_count = _floor(max_count * 2 / 3)
  self.v_is_res = is_res
  self.v_init_long_count = long_count
  self.v_fifo = Fifo:new(self, max_count)
  self.v_res_type = res_type or UnityGameObject
  self:_reset_value()
end

function M:extra_long_count(new_Count)
  self.v_extra_long_count = self.v_extra_long_count or 0
  self.v_extra_long_count = self.v_extra_long_count + new_Count
  self.v_long_count = _max(self.v_long_count, self.v_extra_long_count)
end

function M:clear_extra_long_count()
  self.v_extra_long_count = 0
  self.v_long_count = self.v_init_long_count
end

function M:_reset_value()
  self.v_head = nil
  self.v_tail = nil
  self.v_count = 0
  self.v_map = {}
end

function M:is_almost_full()
  return self.v_count >= self.v_almost_full_count or self.v_fifo:is_almost_full()
end

function M:is_full()
  return self.v_count >= self.v_long_count or self.v_fifo:is_full()
end

function M:push(res_name, obj)
  local lua_obj = self.v_fifo:insert(res_name, obj)
  local tuple = self.v_map[res_name]
  local is_new
  if not tuple then
    tuple = LUAOBJPOOL:pop()
    tuple[LUA_OBJ_TBL_KEY] = {}
    tuple[PATH_KEY] = res_name
    tuple[COUNT_KEY] = 0
    self.v_map[res_name] = tuple
    self.v_count = self.v_count + 1
    is_new = true
  end
  tuple[LUA_OBJ_TBL_KEY][lua_obj] = true
  tuple[COUNT_KEY] = tuple[COUNT_KEY] + 1
  self:set_head(tuple)
  if not self.v_is_res and is_new and self.v_count > self.v_max_count then
    self:remove(self.v_tail)
  end
end

function M:set_head(tuple)
  tuple[TOUCH_TIME] = Global.real_time
  if self.v_head == tuple then
    return
  end
  assert(self.v_count > 1 or not self.v_head)
  if not self.v_head then
    self.v_head = tuple
    self.v_tail = tuple
  elseif self.v_count > 1 then
    local pre_tuple = tuple[PRE_KEY]
    local next_tuple = tuple[NEXT_KEY]
    if pre_tuple then
      pre_tuple[NEXT_KEY] = next_tuple
    end
    if next_tuple then
      next_tuple[PRE_KEY] = pre_tuple
    end
    if self.v_tail == tuple then
      self.v_tail = pre_tuple
    end
    tuple[NEXT_KEY] = self.v_head
    tuple[PRE_KEY] = nil
    self.v_head[PRE_KEY] = tuple
    self.v_head = tuple
  end
end

function M:release_all_tuple_objs(tuple)
  local objs = tuple[LUA_OBJ_TBL_KEY]
  for lua_obj, _ in pairs(objs) do
    if self.v_is_res then
      Global.res_pool_mgr:on_res_unload(lua_obj[OBJ_KEY])
      ResMgr:unload_res(lua_obj[PATH_KEY], self.v_res_type)
    else
      Global.res_pool_mgr:release_from_lru(lua_obj[OBJ_KEY])
    end
    self.v_fifo:remove(lua_obj)
    objs[lua_obj] = nil
  end
end

function M:remove(tuple)
  assert(self.v_count > 0)
  self.v_count = self.v_count - 1
  if self.v_count <= 0 then
    self.v_head = nil
    self.v_tail = nil
    self.v_map[tuple[PATH_KEY]] = nil
    self:release_all_tuple_objs(tuple)
    LUAOBJPOOL:release(tuple)
    return
  end
  local pre_tuple = tuple[PRE_KEY]
  local next_tuple = tuple[NEXT_KEY]
  if pre_tuple then
    pre_tuple[NEXT_KEY] = next_tuple
  end
  if next_tuple then
    next_tuple[PRE_KEY] = pre_tuple
  end
  if tuple == self.v_tail then
    self.v_tail = pre_tuple
  elseif tuple == self.v_head then
    self.v_head = next_tuple
  end
  self.v_map[tuple[PATH_KEY]] = nil
  self:release_all_tuple_objs(tuple)
  LUAOBJPOOL:release(tuple)
end

function M:release_obj(lua_obj)
  local tuple = self.v_map[lua_obj[PATH_KEY]]
  assert(tuple, lua_obj[PATH_KEY])
  local obj_tbl = tuple[LUA_OBJ_TBL_KEY]
  obj_tbl[lua_obj] = nil
  Global.res_pool_mgr:release_from_lru(lua_obj[OBJ_KEY])
  if not next(obj_tbl) then
    self:remove(tuple)
  end
end

function M:try_pop(path)
  local tuple = self.v_map[path]
  if tuple then
    local objs = tuple[LUA_OBJ_TBL_KEY]
    local lua_obj = next(objs)
    if lua_obj then
      objs[lua_obj] = nil
      local obj = lua_obj[OBJ_KEY]
      self.v_fifo:remove(lua_obj)
      self:set_head(tuple)
      return obj
    end
  end
end

function M:try_get(path)
  local tuple = self.v_map[path]
  if tuple then
    local objs = tuple[LUA_OBJ_TBL_KEY]
    local lua_obj = next(objs)
    if lua_obj then
      self:set_head(tuple)
      return lua_obj[OBJ_KEY]
    end
  end
end

function M:get_all(tbl)
  self.v_fifo:get_all(tbl)
end

function M:inc_count(path)
  local tuple = self.v_map[path]
  if tuple then
    tuple[COUNT_KEY] = tuple[COUNT_KEY] + 1
    self:set_head(tuple)
  else
    Global.log.Error("error inc_count :" .. path)
  end
end

function M:dec_count(path)
  local tuple = self.v_map[path]
  if tuple then
    tuple[COUNT_KEY] = tuple[COUNT_KEY] - 1
    tuple[TOUCH_TIME] = Global.real_time
    if tuple[COUNT_KEY] <= 0 and self.v_count >= self.v_max_count then
      self:remove(tuple)
    end
  end
end

function M:iterate_and_destroy(force)
  local tuple = self.v_head
  local count = 0
  if self.v_is_res then
    while tuple do
      count = count + 1
      local tmp_tuple = tuple[NEXT_KEY]
      local release_time = count > self.v_long_count and RELEASE_TIME or CACHE_RES_RELEASE_TIME
      if tuple[COUNT_KEY] <= 0 and (release_time <= Global.real_time - tuple[TOUCH_TIME] or force) then
        self:remove(tuple)
      end
      tuple = tmp_tuple
    end
  else
    while tuple do
      count = count + 1
      local tmp_tuple = tuple[NEXT_KEY]
      if count > self.v_long_count and (Global.real_time - tuple[TOUCH_TIME] > MAX_CACHE_TIME or force) then
        self:remove(tuple)
      end
      tuple = tmp_tuple
    end
  end
end

function M:clear()
  local tuple = self.v_head
  while tuple do
    local tmp_next = tuple[NEXT_KEY]
    if self.v_is_res then
      if tuple[COUNT_KEY] <= 0 then
        self:remove(tuple)
      else
        Global.log.Info("----- res count error ----- ", tuple[PATH_KEY], " ", tuple[COUNT_KEY])
      end
    else
      for lua_obj, _ in pairs(tuple[LUA_OBJ_TBL_KEY]) do
        local obj = lua_obj[OBJ_KEY]
        ResPoolMgr:on_destroy_gameobj(obj)
        ResMgr:destroy_gameobj(obj)
      end
      LUAOBJPOOL:release(tuple[LUA_OBJ_TBL_KEY])
      tuple[LUA_OBJ_TBL_KEY] = nil
    end
    tuple = tmp_next
  end
  if not self.v_is_res then
    self:_reset_value()
    self.v_fifo:clear()
  end
end

function M:is_res()
  return self.v_is_res
end

return M
