local M = Util.create_class()

function M:_init()
  self:reset()
end

function M:reset()
  self.v_data = {}
  self.v_dirty = false
end

function M:sync_s2c(key, value)
  assert(key)
  self.v_data[key] = value
  self.v_dirty = true
end

function M:update()
  if self.v_dirty then
    SceneMgr:c2gs_call_scene("set_sync_var", self.v_data)
    self.v_dirty = false
  end
end

function M:set_sync_var(key, value)
  assert(key)
  if self.v_data[key] == value then
    return
  end
  self.v_data[key] = value
  self.v_dirty = true
  if UNITY_EDITOR then
    Log.Info("当前共享数据变量：", self.v_data)
  end
end

function M:get_sync_var(key)
  return self.v_data[key]
end

return M
