local M = Util.create_class()
local BIND_TYPE = Config.BIND_LAUNCHER
local Vec3 = require("base.vec3")

local function _offset_by_dir(obj, pos, offset_x, offset_y, offset_z)
  local dir = obj:get_dir_vec()
  local dx, dy, dz = dir.x * offset_z, dir.y * offset_z, dir.z * offset_z
  local rx, ry, rz = dir.z * offset_x, dir.y * offset_x, -dir.x * offset_x
  local x, y, z = pos.x + dx + rx, pos.y + dy + ry + offset_y, pos.z + dz + rz
  return x, y, z
end

local InitHelper = {
  [BIND_TYPE.ALL] = function(movement, missile)
    missile:set_parent_tans(movement.v_char.transform, true)
  end,
  [BIND_TYPE.NONE] = function()
  end,
  [BIND_TYPE.ONLY_POS] = function(movement, missile)
  end,
  [BIND_TYPE.ONLY_ROTATION] = function(movement, missile)
    local char_pos = movement.v_char:get_pos_vec3()
    local offset_x, offset_y, offset_z = missile:get_offset()
    local x, y, z = _offset_by_dir(movement.v_char, char_pos, offset_x, offset_y, offset_z)
    movement.born_x = x
    movement.born_y = y
    movement.born_z = z
  end
}
local UpdateHelper = {
  [BIND_TYPE.ALL] = function()
  end,
  [BIND_TYPE.NONE] = function()
  end,
  [BIND_TYPE.ONLY_POS] = function(movement, missile)
    local char_pos = movement.v_char:get_pos_vec3()
    local offset_x, offset_y, offset_z = missile:get_offset()
    local x, y, z = _offset_by_dir(movement.v_char, char_pos, offset_x, offset_y, offset_z)
    missile:set_pos(x, y, z)
  end,
  [BIND_TYPE.ONLY_ROTATION] = function(movement, missile)
    missile:set_pos(movement.born_x, movement.born_y, movement.born_z)
    local x, y, z = movement.char_trans:GetEulerAnglesA()
    missile.transform:SetEuler(x, y, z)
  end
}
local UpdateMovement = {
  [2] = function(movement, ...)
    movement:update(...)
  end
}
local UpdateMovementParamPack = {
  [2] = function(self)
    local x, z = self.v_missile:get_pos2()
    local y = self.v_char:get_pos_height()
    return x, z, y
  end
}

function M:_init(missile, target_object)
  self.v_time_scale = 1
  self.v_speed = 1
  self:update_bind_target(target_object)
  self.v_missile = missile
  self.missile_cfg = missile.missile_cfg
  self.char_trans = self.v_char.transform
  self.v_bind_type = self.missile_cfg.BindLauncher
  InitHelper[self.v_bind_type](self, missile)
  if UpdateMovement[self.missile_cfg.LineType] then
    self.v_movement = Global.missile_movement_pool_mgr:new_obj(self.missile_cfg.LineType, missile)
  end
end

function M:update()
  if self.v_char:is_destroy() then
    self.v_missile:stop()
    return
  end
  UpdateHelper[self.v_bind_type](self, self.v_missile)
  if self.v_movement then
    UpdateMovement[self.missile_cfg.LineType](self.v_movement, self.v_missile:get_pos2())
  end
end

function M:on_destroy()
  if self.v_movement then
    Global.missile_movement_pool_mgr:release(self.missile_cfg.LineType, self.v_movement)
  end
end

function M:set_time_scale(time_scale)
  self.v_time_scale = time_scale
end

function M:update_bind_target(target_object)
  self.v_char = target_object
end

return M
