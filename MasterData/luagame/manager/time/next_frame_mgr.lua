local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local NextTimePoolClass = Util.create_class()
local NEXT_TYPE = {
  NEXT_LOGIC_FRAME = 1,
  NEXT_FRAME = 2,
  NEXT_FRAME_ORDER = 3
}

function NextTimePoolClass:_init(time, func, arg1, arg2, arg3, arg4, arg5, next_type)
  self.time = time
  self.func = func
  self.arg1 = arg1
  self.arg2 = arg2
  self.arg3 = arg3
  self.arg4 = arg4
  self.arg5 = arg5
  self.next_type = next_type
  self.v_not_destroy = true
end

function NextTimePoolClass:on_destroy()
  self.time = nil
  self.func = nil
  self.arg1 = nil
  self.arg2 = nil
  self.arg3 = nil
  self.arg4 = nil
  self.arg5 = nil
  self.next_type = nil
  self.v_not_destroy = nil
end

function NextTimePoolClass:is_destroy()
  return not self.v_not_destroy
end

local M = Util.create_class()
local LOGIC_FRAME = Config.LOGIC_FRAME

function M:_init()
  self.v_pool_mgr = LuaObjPoolMgr.register("next_frame_mgr", 50, NextTimePoolClass)
  self.v_next_update_task_list = {}
  self.v_next_update_task_map = {}
end

function M:add(func, arg1, arg2, arg3, arg4, arg5)
  local time = GlobalTimeMgr:get_time() + LOGIC_FRAME
  local task = self.v_pool_mgr:new_obj(time, func, arg1, arg2, arg3, arg4, arg5, NEXT_TYPE.NEXT_LOGIC_FRAME)
  self.v_next_update_task_map[task] = true
end

function M:add_next_update(func, arg1, arg2, arg3, arg4, arg5)
  local time = GlobalTimeMgr:get_time()
  local task = self.v_pool_mgr:new_obj(time, func, arg1, arg2, arg3, arg4, arg5, NEXT_TYPE.NEXT_FRAME)
  self.v_next_update_task_map[task] = true
end

function M:add_next_update_order(func, arg1, arg2, arg3, arg4, arg5)
  local time = GlobalTimeMgr:get_time()
  local task = self.v_pool_mgr:new_obj(time, func, arg1, arg2, arg3, arg4, arg5, NEXT_TYPE.NEXT_FRAME_ORDER)
  table.insert(self.v_next_update_task_list, 1, task)
end

function M:update()
  local now_time = GlobalTimeMgr:get_time()
  local task
  for i = #self.v_next_update_task_list, 1, -1 do
    task = self.v_next_update_task_list[i]
    if task:is_destroy() then
      table.remove(self.v_next_update_task_list, i)
    elseif now_time > task.time then
      task.func(task.arg1, task.arg2, task.arg3, task.arg4, task.arg5)
      self.v_pool_mgr:destroy_obj(task)
      table.remove(self.v_next_update_task_list, i)
    end
  end
  for obj in pairs(self.v_next_update_task_map) do
    if obj:is_destroy() then
      self.v_next_update_task_map[obj] = nil
    elseif obj.next_type ~= NEXT_TYPE.NEXT_FRAME_ORDER and now_time >= obj.time then
      obj.func(obj.arg1, obj.arg2, obj.arg3, obj.arg4, obj.arg5)
      self.v_pool_mgr:destroy_obj(obj)
      self.v_next_update_task_map[obj] = nil
    end
  end
end

return M
