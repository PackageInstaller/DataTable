local Base = require("manager.fight.movement.missile_linear")
local Vec3 = require("base.vec3")
local M = Util.create_child_mt(Base)

function M:_init(missile)
  Base._init(self, missile)
  self.v_target = self.v_missile:get_target()
  self.v_target_pos = self.v_missile:get_target_pos()
end

local temp_vec3 = Vec3.New()

function M:update()
  if self.v_target then
    self.v_target_pos = self.v_target:get_pos_vec3()
  end
  temp_vec3:SetA(self.v_target_pos)
  temp_vec3:Sub(self.v_missile:get_pos_vec3())
  local distance = temp_vec3:Magnitude()
  local update_dist = self:_get_speed() * self.v_missile:get_time()
  if distance <= update_dist then
    self.v_missile:set_pos_vec(self.v_target_pos)
  end
end

return M
