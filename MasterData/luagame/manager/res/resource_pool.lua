local Util = require("utils.util")
local Lru = require("manager.res.res_lru_new")
local _tinsert = table.insert
local M = Util.create_class()
local DEBU_POOL = false

function M:_init(pool_name, long_keep_count, max_count, is_effect, is_res, resource_root, res_type)
  local root = Global.res_mgr:create_emptygameobj(pool_name, true, true)
  root.transform:SetParent(resource_root.transform, true)
  max_count = max_count or long_keep_count
  self.v_lru = Lru:new(long_keep_count, max_count, is_res, res_type)
  self.v_root_transform = root.transform
  self.v_is_effect = is_effect
  self.v_is_res = is_res
  self.v_name = pool_name
  self.root = root.transform
  self.used_count = 0
  self.max_used_count = -1
  self.res_traceback = {}
  if self.v_is_effect then
    self.v_effect_pools = {}
    self.v_owners = {}
  end
  self.v_active_objs = setmetatable({}, {__mode = "k"})
  if DEBU_POOL then
    self.DEBUG_RELEASE_OBJ = {}
    self.DEBUG_USE_OBJ = {}
  end
end

function M:is_pool_full()
  return self.v_lru:is_full()
end

function M:is_almost_full()
  return self.v_lru:is_almost_full()
end

function M:extra_long_count(new_Count)
  self.v_lru:extra_long_count(new_Count)
end

function M:clear_extra_long_count()
  self.v_lru:clear_extra_long_count()
end

function M:set_release_obj_callback(callback)
  self.v_release_obj_callback = callback
end

function M:_set_res_callback(path, session, traceback)
  if Global.memory_debug then
    if not self.res_traceback[path] then
      self.res_traceback[path] = {}
    end
    self.res_traceback[path][session] = traceback
  end
end

function M:on_load_res(path, res, session, traceback)
  self.v_lru:push(path, res)
  self:_set_res_callback(path, session, traceback)
end

function M:set_max_used_count(count)
  self.max_used_count = count
end

function M:on_use_obj(gameobj, cid)
  self.v_active_objs[gameobj] = true
  self.used_count = self.used_count + 1
  if DEBU_POOL then
    self.DEBUG_USE_OBJ[gameobj.name] = (self.DEBUG_USE_OBJ[gameobj.name] or 0) + 1
  end
end

function M:on_used_res(path, session, traceback)
  self.v_lru:inc_count(path)
  self:_set_res_callback(path, session, traceback)
end

function M:on_release_res(path, session)
  self.v_lru:dec_count(path)
  self:_set_res_callback(path, session, nil)
end

function M:pop_from_free_list(res_name)
  return self.v_lru:try_pop(res_name)
end

function M:get_from_free_list(path)
  return self.v_lru:try_get(path)
end

function M:iterate_and_reset_lru(force)
  self.v_lru:iterate_and_destroy(force)
end

function M:get_lru()
  return self.v_lru
end

function M:clear()
  self.v_lru:clear()
  if self.used_count > 0 and DEBU_POOL then
    Log.Error(self.v_name .. " exist not released objs! count: ", UtilTable.hash_lenth(self.v_active_objs))
    for name, count in pairs(self.DEBUG_USE_OBJ) do
      local released = false
      if self.DEBUG_RELEASE_OBJ[name] ~= count then
        local use_count = count
        local release_count = self.DEBUG_RELEASE_OBJ[name] or 0
        Log.Error(self.v_name .. " not released obj: ", name, ". not release count: ", use_count - release_count)
      end
    end
    UtilTable.clear_map(self.DEBUG_RELEASE_OBJ)
    UtilTable.clear_map(self.DEBUG_USE_OBJ)
  end
  self.used_count = 0
  if self.v_effect_pools then
    for _, pool in pairs(self.v_effect_pools) do
      for _, owner_pool in pairs(pool) do
        for _, obj in pairs(owner_pool) do
          ResPoolMgr:on_destroy_gameobj(obj)
          ResMgr:destroy_gameobj(obj)
        end
      end
    end
    self.v_effect_pools = {}
    self.v_owners = {}
  end
  self:clear_extra_long_count()
  self.v_active_objs = setmetatable({}, Global.config.KEY_WEAK_METATABLE)
end

function M:release_obj(obj, path)
  if self.v_active_objs[obj] == nil then
    return
  end
  self.v_lru:push(path, obj)
  self.v_active_objs[obj] = nil
  self.used_count = self.used_count - 1
  if self.v_release_obj_callback then
    self.v_release_obj_callback(obj)
  end
  if DEBU_POOL then
    self.DEBUG_RELEASE_OBJ[obj.name] = (self.DEBUG_RELEASE_OBJ[obj.name] or 0) + 1
  end
end

function M:on_destroy_logicobj(cid)
  if not self.v_effect_pools or not self.v_owners[cid] then
    return
  end
  self.v_owners[cid] = nil
  for _, pools in pairs(self.v_effect_pools) do
    if pools[cid] then
      for _, obj in pairs(pools[cid]) do
        ResMgr:destroy_gameobj(obj)
        ResPoolMgr:on_destroy_gameobj(obj)
      end
      pools[cid] = nil
    end
  end
end

function M:is_effect_pool()
  return self.v_is_effect
end

function M:is_res_pool()
  return self.v_is_res
end

function M:get_name()
  return self.v_name
end

function M:is_simple()
  return false
end

return M
