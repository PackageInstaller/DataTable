local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local Base = require("gamelogic.base_system")
local SimpleTagBase = require("gamelogic.fight.simple_tag_base")
local GlobalTimeScaleTag = require("gamelogic.fight.global_time_scale_tag")
local DOUBLY_LINKED_LIST = require("utils.doubly_linked_list")
local POOL_STR = "simple_tag_class_pool"
local POOL_TABLE = {}
local M = Util.create_child_mt(Base)
local SIMPLE_TAG_TYPE = Config.SIMPLE_TAG_TYPE
local TAG_TYPE_TO_CLASS_NAME = {
  [SIMPLE_TAG_TYPE.NORMAL] = SimpleTagBase,
  [SIMPLE_TAG_TYPE.GLOBAL_TIME_SCALE] = GlobalTimeScaleTag
}
local SIMPLE_TAG_TIMER_TYPE = Config.SIMPLE_TAG_TIMER_TYPE
local NEXT_TIMER_UPDATE_TIME = {}

local function binary_search(search_table, target_index)
  local low = 1
  local high = #search_table
  while low <= high do
    local mid = math.floor((low + high) / 2)
    local current = search_table[mid]
    if current.index == target_index then
      return mid
    elseif target_index > current.index then
      low = mid + 1
    else
      high = mid - 1
    end
  end
  return nil
end

local function remove_element(tag_list, remove_index)
  local search_index = binary_search(tag_list, remove_index)
  if search_index then
    table.remove(tag_list, search_index)
  else
    for i = 1, #tag_list do
      if tag_list[i].index == remove_index then
        table.remove(tag_list, i)
        break
      end
    end
    Log.Error("二分查询获取到的索引为空, 请检查逻辑代码", debug.traceback())
  end
end

local function get_tag_object(tag_type, index, ...)
  local pool = POOL_TABLE[tag_type]
  if not pool then
    local pool_name = POOL_STR .. tag_type
    local class_base = TAG_TYPE_TO_CLASS_NAME[tag_type] or SimpleTagBase
    POOL_TABLE[tag_type] = LuaObjPoolMgr.get_pool(pool_name) or LuaObjPoolMgr.register(pool_name, 20, class_base)
    pool = POOL_TABLE[tag_type]
  end
  return pool:new_obj(tag_type, index, ...)
end

local function release_tag_object(tag_object)
  if not tag_object then
    Log.Error("尝试释放空对象", tag_object.tag_type, debug.traceback())
    return
  end
  local pool = POOL_TABLE[tag_object.tag_type]
  if not pool then
    Log.Error("释放类型不存在", tag_object.tag_type, debug.traceback())
    return
  end
  pool:destroy_obj(tag_object)
end

local function get_current_time(timer_type)
  if timer_type == SIMPLE_TAG_TIMER_TYPE.GLOBAL_TIME_SCALE then
    return GlobalTimeMgr:get_time()
  elseif timer_type == SIMPLE_TAG_TIMER_TYPE.UNSCALE then
    return Global.time
  end
end

function M:init_sys()
  Base.init_sys(self)
  self.v_index_to_tag_map = {}
  self.v_tag_type_to_linked_list = {}
  self.v_role_uuid_to_linked_list = {}
  self.v_timer_type_to_linked_list = {}
  self.v_mark_remove_tag_list = {}
end

function M:enter_tower()
  self:clear_all_tag()
end

function M:exit_tower()
  self:clear_all_tag()
end

function M:update()
  local need_low_update = Global.low_update
  if need_low_update then
    self:low_update()
  end
end

function M:update_role_scale_timer(linked_list)
  local timer_type = SIMPLE_TAG_TIMER_TYPE.ROLE_TIME_SCALE
  local update_time = NEXT_TIMER_UPDATE_TIME[timer_type]
  local has_update, next_interval
  local start_node = linked_list:get_node_by_idx(1)
  while start_node do
    local tag_object = start_node.data
    if tag_object then
      local role = SceneMgr:pick_by_uuid(tag_object.role_uuid)
      if Util.is_destroy(role) then
        self:remove_tag(tag_object.index)
      end
      if not tag_object:is_mark_remove() then
        local cur_time = role.time_mgr:get_time()
        if update_time <= cur_time then
          has_update = true
          if has_update then
            tag_object:update_timer(cur_time)
          end
          if not tag_object:is_timer_done() then
            next_interval = math.min(next_interval or math.huge, tag_object:get_end_time())
          end
        end
      end
    end
    start_node = start_node.next
  end
  if has_update then
    NEXT_TIMER_UPDATE_TIME[timer_type] = next_interval
  end
end

function M:update_normal_scale_timer(linked_list, timer_type)
  local update_time = NEXT_TIMER_UPDATE_TIME[timer_type]
  local next_interval
  local cur_time = get_current_time(timer_type)
  if update_time < cur_time then
    local start_node = linked_list:get_node_by_idx(1)
    while start_node do
      local tag_object = start_node.data
      if tag_object and not tag_object:is_mark_remove() then
        tag_object:update_timer(update_time)
        if not tag_object:is_timer_done() then
          next_interval = math.min(next_interval or math.huge, tag_object:get_end_time())
        end
      end
      start_node = start_node.next
    end
    NEXT_TIMER_UPDATE_TIME[timer_type] = next_interval
  end
end

function M:low_update()
  self.v_lock_remove = true
  for timer_type, linked_list in pairs(self.v_timer_type_to_linked_list) do
    local update_time = NEXT_TIMER_UPDATE_TIME[timer_type]
    if update_time then
      if timer_type == SIMPLE_TAG_TIMER_TYPE.ROLE_TIME_SCALE then
        self:update_role_scale_timer(linked_list)
      elseif timer_type ~= SIMPLE_TAG_TIMER_TYPE.NONE then
        self:update_normal_scale_timer(linked_list, timer_type)
      end
    end
  end
  self.v_lock_remove = false
  self:update_mark_remove_tag()
end

function M:add_tag(tag_type, ...)
  local index = Util.get_index()
  local tag = get_tag_object(tag_type, index, ...)
  self.v_index_to_tag_map[index] = tag
  local linked_list = self.v_tag_type_to_linked_list[tag_type]
  if not linked_list then
    linked_list = DOUBLY_LINKED_LIST:new(true)
    self.v_tag_type_to_linked_list[tag_type] = linked_list
  end
  linked_list:insert_tail(tag)
  return tag
end

local function try_remove_tag_from_linked_list(type_linked_list, key, tag_object)
  local linked_list = type_linked_list[key]
  local next_tag
  if linked_list then
    linked_list:remove_node_by_value(tag_object)
    next_tag = linked_list:get_node_val_by_idx(1)
    if not next_tag then
      linked_list:on_destroy()
      type_linked_list[key] = nil
    end
  end
end

function M:remove_tag(index)
  local tag_object = self.v_index_to_tag_map[index]
  if Util.is_destroy(tag_object) then
    return
  end
  if self.v_lock_remove then
    self.v_mark_remove_tag_list[#self.v_mark_remove_tag_list + 1] = tag_object
    tag_object:set_mark_remove()
    return
  end
  local tag_type = tag_object.tag_type
  try_remove_tag_from_linked_list(self.v_tag_type_to_linked_list, tag_type, tag_object)
  local timer_type = tag_object.timer_type
  if timer_type then
    try_remove_tag_from_linked_list(self.v_timer_type_to_linked_list, timer_type, tag_object)
  end
  local uuid = tag_object.role_uuid
  if uuid then
    local type_linked_list = self.v_role_uuid_to_linked_list[uuid]
    if type_linked_list then
      try_remove_tag_from_linked_list(type_linked_list, tag_type, tag_object)
      if not next(type_linked_list) then
        self.v_role_uuid_to_linked_list[uuid] = nil
      end
    end
  end
  release_tag_object(tag_object)
  self.v_index_to_tag_map[index] = nil
end

function M:tag_add_timer(role, tag, timer_type, timer_duration)
  if timer_type then
    local end_time, cur_time
    if timer_type ~= SIMPLE_TAG_TIMER_TYPE.ROLE_TIME_SCALE and timer_type ~= SIMPLE_TAG_TIMER_TYPE.NONE then
      cur_time = get_current_time(timer_type)
    elseif role then
      cur_time = role.time_mgr:get_time()
    else
      return
    end
    end_time = cur_time + timer_duration
    tag:set_timer_info(timer_type, end_time)
    local next_update_time = NEXT_TIMER_UPDATE_TIME[timer_type]
    if not next_update_time or end_time < next_update_time then
      NEXT_TIMER_UPDATE_TIME[timer_type] = end_time
    end
    local linked_list = self.v_timer_type_to_linked_list[timer_type]
    linked_list = linked_list or self.v_timer_type_to_linked_list[timer_type]
    linked_list:insert_tail(tag)
  end
end

function M:add_role_tag(role, tag_type, timer_type, timer_duration, ...)
  if Util.is_destroy(role) or not role:is_role() then
    return
  end
  local uuid = role.uuid
  local tag = self:add_tag(tag_type, ...)
  tag:set_role_info(uuid)
  self:tag_add_timer(role, tag, timer_type, timer_duration)
  local type_linked_list = self.v_role_uuid_to_linked_list[uuid]
  if not type_linked_list then
    self.v_role_uuid_to_linked_list[uuid] = {}
    type_linked_list = self.v_role_uuid_to_linked_list[uuid]
  end
  local linked_list = type_linked_list[tag_type]
  if not linked_list then
    type_linked_list[tag_type] = DOUBLY_LINKED_LIST:new(true)
    linked_list = type_linked_list[tag_type]
  end
  linked_list:insert_tail(tag)
  return tag
end

function M:get_tag_count_by_type(tag_type)
  local linked_list = self.v_tag_type_to_linked_list[tag_type]
  return linked_list and linked_list:get_length() or 0
end

function M:get_frist_tag_by_type(tag_type)
  local linked_list = self.v_tag_type_to_linked_list[tag_type]
  if linked_list then
    return linked_list:get_node_val_by_idx(1)
  end
end

function M:get_last_tag_by_type(tag_type)
  local linked_list = self.v_tag_type_to_linked_list[tag_type]
  if linked_list then
    return linked_list:get_node_val_by_idx(linked_list:get_length())
  end
end

function M:clear_role_tag(role)
  self.v_lock_remove = true
  local uuid = role.uuid
  local type_linked_list = self.v_role_uuid_to_linked_list[uuid]
  if type_linked_list then
    for _, linked_list in pairs(type_linked_list) do
      local start_node = linked_list:get_node_by_idx(1)
      while start_node do
        local tag_object = linked_list:get_node_val_by_idx(1)
        self:remove_tag(tag_object.index)
        linked_list:remove_head()
        start_node = start_node.next
      end
    end
  end
  self.v_lock_remove = false
  self:update_mark_remove_tag()
end

function M:update_mark_remove_tag()
  for key, tag in pairs(self.v_mark_remove_tag_list) do
    self:remove_tag(tag.index)
    self.v_mark_remove_tag_list[key] = nil
  end
end

function M:clear_all_tag()
  for tag_type, linked_list in pairs(self.v_tag_type_to_linked_list) do
    linked_list:on_destroy()
    self.v_tag_type_to_linked_list[tag_type] = nil
  end
  for timer_type, linked_list in pairs(self.v_timer_type_to_linked_list) do
    linked_list:on_destroy()
    self.v_tag_type_to_linked_list[timer_type] = nil
  end
  for uuid, type_linked_list in pairs(self.v_role_uuid_to_linked_list) do
    for tag_type, linked_list in pairs(type_linked_list) do
      linked_list:on_destroy()
      self.type_linked_list[tag_type] = nil
    end
    self.v_role_uuid_to_linked_list[uuid] = nil
  end
  for _, tag_obj in pairs(self.v_index_to_tag_map) do
    release_tag_object(tag_obj)
  end
  self.v_index_to_tag_map = {}
  self.v_role_uuid_to_obj_list = {}
  for _, pool in pairs(POOL_TABLE) do
    pool:release_active_objs()
    pool:release_free_objs()
  end
end

return M
