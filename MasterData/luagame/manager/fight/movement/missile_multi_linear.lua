local Base = require("manager.fight.movement.missile_movement")
local Vec3 = require("base.vec3")
local M = Util.create_child_mt(Base)

function M:_init(missile, lineparams)
  Base._init(self, missile)
  self.v_live_time = self.missile_cfg.LiveTime
  self.v_elapse = 0
  local line_params = lineparams or self.missile_cfg.lineparams
  self:set_params(line_params)
end

function M:set_params(params)
  self.v_speed_params = params[1]
  self.v_acc_params = params[2]
end

function M:change_move_params(speed_params, acc_params)
  self.v_speed_params = speed_params or {}
  self.v_acc_params = acc_params or {}
end

local temp_vec3 = Vec3.New()

function M:update()
  local dt = GlobalTimeMgr:get_dt_time()
  self.v_elapse = self.v_elapse + dt
  local left = self.v_live_time - self.v_elapse
  local pos = self.v_missile:get_pos_vec3()
  local dir = self.v_missile:get_dir_vec()
  temp_vec3:SetA(dir)
  temp_vec3:Mul(dt * self:_get_speed(left))
  temp_vec3:Add(pos)
  self.v_missile:set_pos_vec(temp_vec3)
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

function M:_get_speed(left)
  return (self:_get_base_speed(left) + self:_get_acc(left) * self.v_missile:get_time()) * self.v_time_scale * self.v_missile:get_owner_time_scale()
end

local function decode_param(param, left)
  if not next or not next(param) then
    return 0
  end
  local t = 0
  local size = #param
  for i = size, 1, -2 do
    t = t + param[i]
    if left < t then
      return param[i - 1]
    end
  end
  return param[1]
end

function M:_get_acc(left)
  return decode_param(self.v_acc_params, left)
end

function M:_get_base_speed(left)
  return decode_param(self.v_speed_params, left)
end

function M:set_speed(speed)
  self.v_speed = speed
end

return M
