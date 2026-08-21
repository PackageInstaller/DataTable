local Base = require("obj.functional_npc.functional_npc")
local M = Util.create_child_mt(Base)

function M:_init(...)
  Base._init(self, ...)
end

function M:presetup(...)
  Base.presetup(self)
end

function M:setup(...)
  Base.setup(self, ...)
end

function M:on_init_gameobj(...)
  Base.on_init_gameobj(self, ...)
  self.v_head_obj = self.gameobj.transform:FindChild("Head")
  self:check_init_box_state()
end

function M:update()
  Base.update(self)
end

function M:on_destroy_luaobj()
  Base.on_destroy_luaobj(self)
  self.v_head_obj:SetActive(false)
  self.v_head_obj = nil
end

function M:on_destroy()
  Base.on_destroy(self)
end

function M:check_init_box_state()
  local is_get_thing_end = InitBoxMgr:is_get_thing_end()
  if not self.v_head_obj or self.v_head_obj:IsNull() then
    return
  end
  self.v_head_obj:SetActive(not is_get_thing_end)
end

return M
