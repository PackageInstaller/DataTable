local Base = require("manager.fight.movement.missile_movement")
local Quat = require("base.quat")
local UnityQuat = UnityEngine.Quaternion
local Vec3 = require("base.vec3")
local M = Util.create_child_mt(Base)

function M:_init(missile, lineparams)
  Base._init(self, missile)
  local params = lineparams or self.missile_cfg.lineparams
  self.temp_tar_vec = Vec3.New()
  self:set_params(params)
end

function M:set_params(params)
  local cfg = self.missile_cfg
  self.v_speed = params[1] or 0
  local start_height = params[2] or 0
  self.v_st_dir_deg = params[3] or 0
  self.v_st_pitch_deg = params[4] or 0
  self.st_turn_time = cfg.Delay + (params[5] or 0) * cfg.LiveTime
  self.v_max_deg = params[6] or 0
  self.v_target_height = params[7] or 0
  self.v_speed_acc = params[8] or 0
  self.v_ignore_axial = params[9]
  self.v_target_pos_offset = params[10]
  self.v_track_attach_point = params[11]
  self.v_pause_track_dist = Util.is_more_than_zero(params[12]) and params[12] or nil
  self.v_lerp_t = self.v_max_deg / 360
  local trans = self.v_missile:get_transform()
  self.v_missile_trans = trans
  local rx, ry, rz = trans:GetEulerAnglesA3()
  local target_dir = ry + self.v_st_dir_deg
  self.v_missile:set_dir(target_dir)
  trans:SetEuler(rx + self.v_st_pitch_deg, target_dir, rz)
  local self_pos = self.v_missile:get_pos_vec3()
  self.v_missile:set_pos(self_pos.x, self_pos.y + start_height, self_pos.z)
end

function M:change_move_params(params)
  self:set_params(params)
end

function M:update()
  local missile = self.v_missile
  local dt = self.v_missile.v_owner:get_missile_dt()
  local self_pos = self.v_missile:get_pos_vec3()
  if missile:get_time() < self.st_turn_time then
    local dir_x, dir_y, dir_z = self.v_missile_trans:GetForwardA()
    local move_dt = dt * self.v_speed * self.v_time_scale
    missile:set_pos(self_pos.x + dir_x * move_dt, self_pos.y + dir_y * move_dt, self_pos.z + dir_z * move_dt)
    return
  end
  local trans = self.v_missile_trans
  local tar_pos_x, tar_pos_y, tar_pos_z
  local use_attach_point = false
  if self.v_track_attach_point and not Util.is_destroy(missile.v_target) then
    local attach_point = missile.v_target:get_setting_point(self.v_track_attach_point)
    if attach_point then
      tar_pos_x, tar_pos_y, tar_pos_z = attach_point:GetPositionA()
      use_attach_point = true
    end
  end
  if not use_attach_point then
    local tar_pos = missile:get_pos_or_target_pos()
    tar_pos_x, tar_pos_y, tar_pos_z = tar_pos:Get()
  end
  if self.v_target_pos_offset then
    tar_pos_x = tar_pos_x + (self.v_target_pos_offset[1] or 0)
    tar_pos_y = tar_pos_y + (self.v_target_pos_offset[2] or 0)
    tar_pos_z = tar_pos_z + (self.v_target_pos_offset[3] or 0)
  end
  if self.v_pause_track_dist and Vec3.DistanceA(tar_pos_x, tar_pos_y, tar_pos_z, self_pos.x, self_pos.y, self_pos.z) <= self.v_pause_track_dist then
    return
  end
  local tar_vec_x, tar_vec_y, tar_vec_z = tar_pos_x - self_pos.x, tar_pos_y - self_pos.y, tar_pos_z - self_pos.z
  tar_vec_y = self.v_target_height + tar_vec_y
  tar_vec_x, tar_vec_y, tar_vec_z = Vec3.NormalizeA(tar_vec_x, tar_vec_y, tar_vec_z)
  local oex, oey, oez
  if self.v_ignore_axial then
    oex, oey, oez = trans:GetEulerAnglesA3()
  end
  local _, _, _, nex, ney, nez = trans:ForwardLerp(tar_vec_x, tar_vec_y, tar_vec_z, self.v_lerp_t * dt)
  if self.v_ignore_axial then
    local is_change = false
    if Util.is_more_than_zero(self.v_ignore_axial[1]) then
      nex = oex
      is_change = true
    end
    if Util.is_more_than_zero(self.v_ignore_axial[2]) then
      ney = oey
      is_change = true
    end
    if Util.is_more_than_zero(self.v_ignore_axial[3]) then
      nez = oez
      is_change = true
    end
    if true == is_change then
      trans:SetEuler(nex, ney, nez)
    end
  end
  Vec3.GetRotatedVector(nex, ney, nez, nil, Util.VEC3_TEMP)
  local dx, dy, dz = Util.VEC3_TEMP:Get()
  local move_dt = dt * self.v_speed * self.v_time_scale * self.v_missile:get_owner_time_scale()
  missile:set_pos(self_pos.x + dx * move_dt, self_pos.y + dy * move_dt, self_pos.z + dz * move_dt)
  self.v_speed = self.v_speed + self.v_speed_acc * dt
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

return M
