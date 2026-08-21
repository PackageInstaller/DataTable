local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect()
  local parms_data
  if type(self.cfg[1]) == "string" then
    local curve_file_name = self.cfg[1]
    local orientation_type = self.cfg[2]
    local rx, ry, rz = self.cfg[4], self.cfg[5], self.cfg[6]
    local following_target = 1 == self.cfg[10]
    local prop = self.cfg[11] or 1
    local duration = self.cfg.Duration
    local remove_correction = 1 == self.cfg[12]
    local force_handle_rotation = 1 == self.cfg[13]
    parms_data = {
      curve_file_name = curve_file_name,
      following_target = following_target,
      rx = rx,
      ry = ry,
      rz = rz,
      prop = prop,
      duration = duration,
      remove_correction = remove_correction,
      magic_id = self.magic_id,
      orientation_type = orientation_type,
      force_handle_rotation = force_handle_rotation
    }
  else
    local px, py, pz = self.cfg[1], self.cfg[2], self.cfg[3]
    local rx, ry, rz = self.cfg[4], self.cfg[5], self.cfg[6]
    local ease_in, ease_out = self.cfg[7], self.cfg[8]
    local cordinate = self.cfg[9]
    local following_target = 1 == self.cfg[10]
    local prop = self.cfg[11] or 1
    local remove_correction = 1 == self.cfg[12]
    local force_handle_rotation = 1 == self.cfg[13]
    local duration = self.cfg.Duration
    parms_data = {
      px = px,
      py = py,
      pz = pz,
      rx = rx,
      ry = ry,
      rz = rz,
      ease_in = ease_in,
      ease_out = ease_out,
      cordinate = cordinate,
      following_target = following_target,
      prop = prop,
      remove_correction = remove_correction,
      duration = duration,
      magic_id = self.magic_id,
      force_handle_rotation = force_handle_rotation
    }
  end
  if self.owner:is_hero() then
    if Global.hero == self.owner then
      Global.camera:start_pos_rotation_offset(parms_data)
    end
  else
    Global.camera:start_pos_rotation_offset(parms_data)
  end
end

function M:on_remove(magic_map)
  if next(magic_map) == nil then
    Global.camera:stop_pos_rotation_offset()
  end
end

return M
