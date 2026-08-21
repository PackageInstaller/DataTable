local Base = require("manager.fight.movement.missile_movement")
local Vec3 = require("base.vec3")
local Math = require("base.mathx")
local deg2rad = Math.Deg2Rad
local rad2deg = Math.Rad2Deg
local _sin = math.sin
local _cos = math.cos
local M = Util.create_child_mt(Base)

function M:_init(missile, lineparams)
  Base._init(self, missile)
  local params = lineparams or self.missile_cfg.lineparams
  self:set_params(params)
  local cur_pos = self.v_missile:get_pos_vec3()
  local tar_pos = self.v_missile:get_pos_or_target_pos()
  self.v_max_radius = Vec3.Distance(cur_pos, tar_pos)
  self.v_start_deg = -Math.get_angle2A(cur_pos.x - tar_pos.x, cur_pos.z - tar_pos.z) + 90
  self.v_max_live_time = self.missile_cfg.LiveTime
  self.v_tar_x, self.v_tar_z = tar_pos.x, tar_pos.z
end

function M:set_params(params)
  self.v_deg_speed = params[1] or 0
end

function M:update()
  local cur_live_time = self.v_missile:get_time()
  local cur_rad = (cur_live_time * self.v_deg_speed + self.v_start_deg) * deg2rad
  local cur_radius = Math.lerp_number(self.v_max_radius, 0, cur_live_time / self.v_max_live_time)
  self.v_missile:set_pos2(_sin(cur_rad) * cur_radius + self.v_tar_x, _cos(cur_rad) * cur_radius + self.v_tar_z)
  self.v_missile:set_target_dir(rad2deg * cur_rad, true)
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

return M
