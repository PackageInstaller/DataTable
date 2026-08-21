local Base = require("manager.fight.movement.missile_movement")
local Vec3 = require("base.vec3")
local M = Util.create_child_mt(Base)

function M:_init(missile, lineparams)
  Base._init(self, missile)
  local line_params = lineparams or self.missile_cfg.lineparams
  self:set_params(line_params)
  self.v_live_time = self.missile_cfg.LiveTime
  self.v_elapse = 0
end

function M:set_params(params)
  self.move_speed = params[1]
  self.trun_speed = params[2]
  self.move_acc = params[3]
  self.trun_acc = params[4]
  local _, y, _ = self.v_missile.transform:GetPositionA()
  self.start_h = params[5][1] + y
  self.end_h = params[5][2] + y
end

local temp_vec3 = Vec3.New()

function M:update()
  local dt = Global.delta_time
  self.v_elapse = self.v_elapse + dt
  self.move_speed = self.move_speed + self.move_acc * dt
  self.trun_speed = self.trun_speed + self.trun_acc * dt
  local dir_y = self.v_missile:get_dir()
  self.v_missile:set_target_dir(dir_y + self.trun_speed * dt, true)
  local dir = self.v_missile:get_dir_vec()
  local pos = self.v_missile:get_pos_vec3()
  local new_height = self.start_h + (self.end_h - self.start_h) * self.v_elapse / self.v_live_time
  temp_vec3:SetA(dir)
  temp_vec3:Mul(dt * self.move_speed * self.v_time_scale * self.v_missile:get_owner_time_scale())
  temp_vec3:Add(pos)
  temp_vec3.y = new_height
  self.v_missile:set_pos_vec(temp_vec3)
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

return M
