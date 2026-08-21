local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect()
  local px, py, pz = self.cfg[1], self.cfg[2], self.cfg[3]
  local ease_in, ease_out = self.cfg[4], self.cfg[5]
  local cordinate = self.cfg[6]
  local following_target = 1 == self.cfg[7]
  local prop = self.cfg[8] or 1
  local remove_correction = 1 == self.cfg[9]
  local duration = self.cfg.Duration
  local parms_data = {
    px = px,
    py = py,
    pz = pz,
    ease_in = ease_in,
    ease_out = ease_out,
    cordinate = cordinate,
    following_target = following_target,
    prop = prop,
    remove_correction = remove_correction,
    duration = duration,
    magic_id = self.magic_id
  }
  if self.owner:is_hero() then
    if Global.hero == self.owner then
      Global.camera:start_pos_offset(parms_data)
    end
  else
    Global.camera:start_pos_offset(parms_data)
  end
end

function M:on_remove(magic_map)
  if next(magic_map) == nil then
    Global.camera:stop_pos_offset()
  end
end

return M
