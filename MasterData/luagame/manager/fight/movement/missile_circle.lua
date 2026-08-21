local Base = require("manager.fight.movement.missile_movement")
local mathx = require("base.mathx")
local _min = math.min
local deg2rad = mathx.Deg2Rad
local rad2deg = mathx.Rad2Deg
local _sin = math.sin
local _cos = math.cos
local _bezier = mathx.bezier_3d_2o
local M = Util.create_child_mt(Base)
local MOVEMENT = {
  TO_CIRCLE = 1,
  IN_CIRCLE = 2,
  DECELERATE = 3,
  KEEP_CIRCLE = 4,
  OUT_CIRCLE = 5,
  FINISH = 6
}

function M:_init(missile, lineparams)
  Base._init(self, missile)
  local params = lineparams or self.missile_cfg.lineparams
  self:set_params(params)
end

local function _circle_curve(self, x0, z0, x1, z1, t, curve_offset)
  local dir_x, dir_z = Util.normalize2(x1 - x0, z1 - z0)
  local distance = mathx.distance2(x0, z0, x1, z1)
  local normal_x, normal_z = mathx.rotate_vec2(dir_x, dir_z, -90 * self.v_dir)
  local half_dist = distance * 0.5
  local half_x, half_z = x0 + dir_x * half_dist, z0 + dir_z * half_dist
  local ex_x, ex_z = half_x + normal_x * distance * curve_offset, half_z + normal_z * distance * curve_offset
  local x, _, z = _bezier(x0, 0, z0, ex_x, 0, ex_z, x1, 0, z1, t)
  return x, z
end

local function _acc_move_center_to_target(self, dt)
  self.v_acc_time = self.v_acc_time + dt
  local move_dist = 0.5 * self.v_acc * dt * dt
  local center_x, center_z
  local target = self.v_missile:get_target()
  if target:is_hero() then
    center_x, center_z = Global.hero:get_pos2()
  else
    local center_pos = self.v_missile:get_pos_or_target_pos()
    center_x, center_z = center_pos.x, center_pos.z
  end
  local dir_x, dir_z = Util.normalize2(center_x - self.v_center_pos.x, center_z - self.v_center_pos.z)
  self.v_center_pos.x, self.v_center_pos.z = self.v_center_pos.x + dir_x * move_dist, self.v_center_pos.z + dir_z * move_dist
  if mathx.almost_equal(self.v_center_pos.x, self.v_center_pos.z, center_x, center_z) then
    self.v_acc_time = 0
  end
end

local function _to_circle(self, dt)
  _acc_move_center_to_target(self, dt)
  self.v_cur_time = self.v_cur_time + dt
  local half_radius = self.v_circle_radius * 0.5
  local d_rad = self.v_cur_time / self.v_to_circle_time * 180 * deg2rad * self.v_dir
  local cur_rad = self.v_start_rad + d_rad
  local dx = _sin(d_rad) * half_radius
  local dz = _cos(d_rad) * half_radius - half_radius
  dx, dz = mathx.rotate_vec2(dx, dz, self.v_start_rad * rad2deg)
  self.v_missile:set_pos2(self.v_center_pos.x + dx, self.v_center_pos.z + dz)
  if self.v_cur_time > self.v_to_circle_time then
    self.v_movement_type = MOVEMENT.IN_CIRCLE
    self.v_cur_time = 0
    self.v_cur_rad = cur_rad
  end
end

local function _in_circle(self, dt)
  _acc_move_center_to_target(self, dt)
  self.v_cur_time = self.v_cur_time + dt
  local cur_rad = self.v_cur_rad + self.v_cur_time * self.v_circle_speed * self.v_dir
  local dx = _sin(cur_rad) * self.v_circle_radius
  local dz = _cos(cur_rad) * self.v_circle_radius
  self.v_missile:set_pos2(self.v_center_pos.x + dx, self.v_center_pos.z + dz)
  if self.v_cur_time > self.v_circle_time then
    self.v_movement_type = MOVEMENT.DECELERATE
    self.v_cur_time = 0
    self.v_cur_rad = cur_rad
  end
end

local function _dec_circle(self, dt)
  self.v_cur_time = self.v_cur_time + dt
  local cur_speed = self.v_circle_speed + self.v_out_dec * self.v_cur_time
  local cur_rad = self.v_cur_rad + self.v_cur_time * cur_speed * self.v_dir
  local dx = _sin(cur_rad) * self.v_circle_radius
  local dz = _cos(cur_rad) * self.v_circle_radius
  self.v_missile:set_pos2(self.v_center_pos.x + dx, self.v_center_pos.z + dz)
  if self.v_cur_time > self.v_out_dec_time then
    self.v_movement_type = MOVEMENT.KEEP_CIRCLE
    self.v_cur_time = 0
    self.v_cur_rad = cur_rad
    self.v_out_speed = cur_speed
    self.v_end_x = self.v_center_pos.x + self.v_end_offset_x
    self.v_end_z = self.v_center_pos.z + self.v_end_offset_z
  end
end

local function _keep_in_circle(self, dt)
  self.v_cur_time = self.v_cur_time + dt
  local cur_rad = self.v_cur_rad + self.v_cur_time * self.v_out_speed * self.v_dir
  local dx = _sin(cur_rad) * self.v_circle_radius
  local dz = _cos(cur_rad) * self.v_circle_radius
  local x, z = self.v_center_pos.x + dx, self.v_center_pos.z + dz
  local dist = mathx.dist_vec2A(self.v_end_x, self.v_end_z, x, z)
  self.v_missile:set_pos2(x, z)
  local dir = dist - self.v_dist
  local can_out = dir * self.v_can_out_dir <= 0
  self.v_can_out_dir = dir
  if can_out or dir >= self.v_circle_radius * 2 then
    self.v_movement_type = MOVEMENT.OUT_CIRCLE
    self.v_cur_time = 0
    self.v_cur_rad = cur_rad
    self.v_out_start_x = self.v_center_pos.x + dx
    self.v_out_start_z = self.v_center_pos.z + dz
  end
end

local function _out_circle(self, dt)
  self.v_cur_time = self.v_cur_time + dt
  local speed = self.v_out_speed + self.v_out_acc * self.v_cur_time
  local t = self.v_cur_time * speed
  t = _min(t, 1)
  local dx, dz = _circle_curve(self, self.v_out_start_x, self.v_out_start_z, self.v_end_x, self.v_end_z, t, 0.5)
  self.v_missile:set_pos2(dx, dz)
  if t >= 1 then
    self.v_movement_type = MOVEMENT.FINISH
    self.v_cur_time = 0
  end
end

function M:update()
  local dt = GlobalTimeMgr:get_dt_time()
  if self.v_movement_type == MOVEMENT.TO_CIRCLE then
    _to_circle(self, dt)
  elseif self.v_movement_type == MOVEMENT.IN_CIRCLE then
    _in_circle(self, dt)
  elseif self.v_movement_type == MOVEMENT.DECELERATE then
    _dec_circle(self, dt)
  elseif self.v_movement_type == MOVEMENT.KEEP_CIRCLE then
    _keep_in_circle(self, dt)
  elseif self.v_movement_type == MOVEMENT.OUT_CIRCLE then
    _out_circle(self, dt)
  elseif self.v_is_destroy_after_move_finish then
    self.v_missile:destroy()
  end
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

function M:set_params(params)
  if not params then
    return
  end
  local x, z = params.x, params.z
  if not x and not z then
    if not params[2] then
      return
    end
    self.v_acc = params[1] or 0
    local start_deg = params[2][1] or 0
    self.v_start_rad = deg2rad * (start_deg + self.v_missile:get_dir())
    self.v_to_circle_time = params[2][2] or 1
    self.v_circle_radius = params[3][1] or 1
    self.v_circle_speed = params[3][2] or 0
    self.v_circle_time = params[3][3] or 0
    self.v_out_dec = params[4][1] or 0
    self.v_out_dec_time = params[4][2] or 0
    self.v_out_acc = params[5][1] or 0
    self.v_center_pos = Util.VEC3_TEMP.New()
    self.v_center_pos:SetA(self.v_missile:get_pos_or_target_pos())
    self.v_end_offset_x = params[5][2] or 0
    self.v_end_offset_z = params[5][3] or 0
    self.v_cur_time = self.v_cur_time or 0
    self.v_acc_time = self.v_acc_time or 0
    self.v_movement_type = MOVEMENT.TO_CIRCLE
    local is_anti_clock_wise = 1 == params[6]
    self.v_dir = is_anti_clock_wise and -1 or 1
    self.v_is_destroy_after_move_finish = 1 == params[7]
    self.v_dist = params[8] or 1
    self.v_can_out_dir = 1
    return
  end
  self.v_end_x, self.v_end_z = self.v_center_pos.x + x, self.v_center_pos.z + z
end

return M
