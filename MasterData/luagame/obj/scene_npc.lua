local Base = require("obj.npc")
local M = Util.create_child_mt(Base)

function M:_init(...)
  Base._init(self, ...)
  self.v_scene_npc_status = 0
end

function M:on_destroy_luaobj()
  self.v_penetrable = nil
  self:on_disable()
end

function M:need_ui_hp()
  return false
end

function M:need_simple_shadow()
  return false
end

function M:can_destroy_gameobj()
  return false
end

function M:need_load_gameobj()
  return false
end

function M:is_scene_npc()
  return true
end

function M:set_scene_npc_status(status)
  if self.v_scene_npc_status == status then
    return
  end
  self.v_scene_npc_status = status
  local request_info = {
    obj_name = self:get_local_name(),
    status = status
  }
  Network:call("c2gs_set_scene_npc_status", request_info, nil)
end

function M:get_scene_npc_status()
  return self.v_scene_npc_status or 0
end

function M:set_penetrable(penetrable)
  self.v_penetrable = penetrable
end

function M:is_penetrable()
  return self.v_penetrable
end

function M:update()
  if self:is_real_finish_init() then
    self.skill_mgr:update()
    self.magic_mgr:update()
  end
end

function M:low_update()
end

function M:late_update()
end

function M:is_need_land_height()
  return false
end

return M
