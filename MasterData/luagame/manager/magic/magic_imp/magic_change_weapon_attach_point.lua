local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect()
  if Util.is_destroy(self.owner) then
    return
  end
  local weapon_mgr = self.owner.weapon_mgr
  local is_reset_trans = Util.is_more_than_zero(self.cfg[3])
  weapon_mgr:change_weapon_attach_point(self.cfg[2], self.cfg[1], is_reset_trans)
end

function M:on_remove(magic_map)
  if Util.is_destroy(self.owner) then
    return
  end
  local weapon_mgr = self.owner.weapon_mgr
  weapon_mgr:reset_weapon_attach_point(self.cfg[2])
end

return M
