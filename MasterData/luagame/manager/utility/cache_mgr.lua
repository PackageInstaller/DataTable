local ResMgr = Global.res_mgr
local Util = require("utils.util")
local DontDestroyOnLoad = UnityGameObject.DontDestroyOnLoad
local TemplateConfig = Global.template_config
local M = Util.create_class()

function M:_init()
  self.v_cache_data = {}
  self.v_cache_root = UnityGameObject()
  self.v_cache_root.name = "CacheRoot"
  self.v_cache_root:SetActive(false)
  ResMgr:dont_destroy_on_load(self.v_cache_root)
end

function M:set_parent(template_key, parent)
  assert(self.v_cache_data[template_key])
  self.v_cache_data[template_key].parent = parent
end

function M:has_cache_key(template_key)
  return self.v_cache_data[template_key]
end

function M:_register_template_by_config(template_key, config, parent)
  assert(template_key)
  assert(config)
  if self.v_cache_data[template_key] then
    return self.v_cache_data[template_key].template
  end
  local template = ResMgr:load_res(config.prefab_path, nil)
  assert(template, "prefab not exist " .. config.prefab_path)
  DontDestroyOnLoad(template)
  local cache = {}
  cache.config = config
  cache.template = template
  cache.is_from_prefab = false
  cache.object_list = {}
  cache.parent = parent
  self.v_cache_data[template_key] = cache
  return template
end

function M:register_template(template_key, parent)
  assert(template_key)
  if self.v_cache_data[template_key] then
    self:set_parent(template_key, parent)
    return self.v_cache_data[template_key].template
  end
  local config = TemplateConfig.template_cfg[template_key]
  assert(config, "have no template config" .. template_key)
  return self:_register_template_by_config(template_key, config, parent)
end

function M:register_exist_template(template_key, template, parent, capacity)
  assert(template_key)
  assert(not self.v_cache_data[template_key])
  assert(template)
  capacity = capacity or 10
  local cache = {}
  cache.config = {capacity = capacity}
  cache.template = template
  cache.object_list = {}
  cache.is_from_prefab = true
  cache.parent = parent
  self.v_cache_data[template_key] = cache
end

function M:register_exist_template_by_config(template_key, template, parent, config)
  assert(template_key)
  assert(not self.v_cache_data[template_key])
  assert(template)
  local cache = {}
  cache.config = config
  cache.template = template
  cache.object_list = {}
  cache.is_from_prefab = true
  cache.parent = parent
  self.v_cache_data[template_key] = cache
end

function M:unregister_template(template_key)
  assert(template_key)
  if self.v_cache_data[template_key] == nil then
    Global.log.Debug("invalid template:" .. template_key)
    return
  end
  local cache = self.v_cache_data[template_key]
  self:_unregister_by_cache(cache)
  self.v_cache_data[template_key] = nil
end

function M:unregister_all_template()
  for key, cache in ipairs(self.v_cache_data) do
    self:_unregister_by_cache(cache)
    self.v_cache_data[key] = nil
  end
end

function M:_unregister_by_cache(cache)
  assert(cache)
  self:_clear_object_list(cache.object_list)
  if not cache.is_from_prefab then
    ResMgr:unload_res(cache.config.prefab_path)
  end
end

function M:get_template(template_key)
  assert(template_key)
  assert(self.v_cache_data[template_key])
  local cache = self.v_cache_data[template_key]
  return cache.template
end

function M:pop_from_cache(template_key)
  assert(template_key)
  assert(self.v_cache_data[template_key])
  local cache = self.v_cache_data[template_key]
  local object_list = cache.object_list
  local object_count = #object_list
  local obj
  local is_reuse = false
  if object_count > 0 then
    obj = object_list[object_count]
    object_list[object_count] = nil
    is_reuse = true
    obj:SetActive(true)
    if cache.parent and obj:GetParent() ~= cache.parent then
      obj.transform:SetParent(cache.parent.transform, false)
    end
  else
    obj = ResMgr:instantiate(cache.template)
    DontDestroyOnLoad(obj.gameObject)
    obj:SetActive(true)
    if cache.parent then
      obj.transform:SetParent(cache.parent.transform, false)
    end
  end
  return obj, is_reuse
end

function M:push_to_cache(template_key, obj, change_parent)
  if Util.is_nil(obj) then
    return
  end
  assert(template_key)
  assert(obj)
  assert(self.v_cache_data[template_key])
  local cache = self.v_cache_data[template_key]
  local object_list = cache.object_list
  if cache.config.capacity == nil or #object_list < cache.config.capacity then
    if change_parent then
      obj.transform:SetParent(self.v_cache_root.tranform, false)
    else
      obj:SetActive(false)
    end
    table.insert(object_list, obj)
  else
    ResMgr:destroy_gameobj(obj)
  end
end

function M:raw_push_to_cache(template_key, obj)
  assert(template_key)
  assert(obj)
  assert(self.v_cache_data[template_key])
  local cache = self.v_cache_data[template_key]
  local object_list = cache.object_list
  table.insert(object_list, obj)
end

function M:raw_set_all_cache_active(template_key, is_active)
  assert(template_key)
  assert(self.v_cache_data[template_key])
  local cache = self.v_cache_data[template_key]
  local object_list = cache.object_list
  for _, obj in ipairs(object_list) do
    obj:SetActive(false)
  end
end

function M:get_cache_count(template_key)
  assert(template_key)
  assert(self.v_cache_data[template_key])
  local cache = self.v_cache_data[template_key]
  local object_list = cache.object_list
  return #object_list
end

function M:clear_cache(template_key)
  assert(template_key)
  if not self.v_cache_data[template_key] then
    Global.log.Debug("not in cache key::" .. template_key)
    return
  end
  assert(self.v_cache_data[template_key], template_key)
  local cache = self.v_cache_data[template_key]
  self:_clear_object_list(cache.object_list)
end

function M:clear_all_cache()
  for _, cache in ipairs(self.v_cache_data) do
    self:_clear_object_list(cache.object_list)
  end
end

function M:_clear_object_list(object_list)
  for i = #object_list, 1, -1 do
    ResMgr:destroy_gameobj(object_list[i])
    table.remove(object_list, i)
  end
end

function M:get_cache_root(...)
  return self.v_cache_root
end

return M
