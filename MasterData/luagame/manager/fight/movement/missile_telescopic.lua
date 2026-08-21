local Base = require("manager.fight.movement.missile_movement")
local Vec3 = require("base.vec3")
local M = Util.create_child_mt(Base)

function M:_init(missile, lineparams)
  Base._init(self, missile)
  if self.missile_cfg.Shape ~= Config.MISSILE_SHAPE.RECT or self.missile_cfg.BornPosition ~= Config.MISSILE_BORN_POS_TYPE.BYBRONPOS then
    Log.Error("子弹类型为17是Shape必须为矩形（1）， BornPosition必须为4 ,missile_id = ", self.missile_cfg.Id)
    return
  end
  local param = lineparams or self.missile_cfg.lineparams
  self:set_params(param)
  local born_pos = self.v_missile:get_born_pos()
  if not born_pos then
    Log.Error("子弹类型为17的子弹born_pos获取失败 ,missile_id = ", self.missile_cfg.Id)
  end
  local target_pos = self.v_missile:get_pos_or_target_pos()
  if not target_pos then
    Log.Error("子弹类型为17的子弹target_pos获取失败 ,missile_id = ", self.missile_cfg.Id)
  end
  self.v_scale_x, self.v_scale_y, self.v_scale_z = 1, 1, 1
  self.v_dist = Vec3.Distance(born_pos, target_pos)
  self:set_scale()
  self.v_missile:update_collider()
end

function M:set_params(params)
  self.v_scale_z_mult = params[1] or 1
end

function M:update()
  self:set_scale()
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

function M:set_scale()
  local z = self.v_dist * self.v_scale_z_mult
  if self.v_scale_z ~= z then
    local x, y, _ = self.v_missile.transform:GetLocalScaleA3()
    self.v_missile:set_size_z(z)
    local effect_trans = self.v_missile:get_effect_trans()
    if effect_trans then
      effect_trans:SetLocalScaleA(x, y, z)
    end
    self.v_scale_x = x
    self.v_scale_y = y
    self.v_scale_z = z
  end
end

return M
