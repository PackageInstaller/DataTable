local Base = require("manager.fight.collider.collider")
local TypeSkillArea = typeof(CS.SkillArea)
local Vec3 = require("base.vec3")
local M = Util.create_child_mt(Base)
local _max = math.max
local _min = math.min
local _floor = math.floor
local _rotate_vec2 = require("base.mathx").rotate_vec2

function M:on_to_background(msg)
  if Util.is_destroy(msg.mm_obj) or msg.mm_obj.uuid ~= self.v_char.uuid then
    return
  end
  local area_trans = self.v_area_trans or self.v_shape_area_trans
  if area_trans then
    area_trans.gameObject:SetActive(false)
    self.v_area_trans_visible = false
  end
end

function M:_init(char, radius)
  Base._init(self, char)
  Util.bind_msg(self, Const.MSG_HERO_GO_BACKGORUND, self.on_to_background, self)
  self.v_radius = radius
  self.v_radius_p2 = radius * radius
  self.v_posx = 0
  self.v_posz = 0
  self.v_area_trans_visible = false
end

function M:is_circle()
  return true
end

function M:get_radius()
  return self.v_radius * self.v_char.model_scale
end

function M:get_height()
  return self.v_height * self.v_char.model_scale
end

function M:get_pos2()
  return self.v_posx, self.v_posz
end

function M:refesh_pos()
  local px, pz = self.v_char:get_pos2()
  self.v_posx, self.v_posz = self:cal_temp_pos(px, pz)
end

function M:cal_temp_pos(temp_x, temp_z)
  local px, pz = temp_x, temp_z
  local offset_x, offset_z = self.v_char:get_radius_offset_pos()
  local model_scele = self.v_char.model_scale
  local tx, tz = _rotate_vec2(offset_x * model_scele, offset_z * model_scele, self.v_char:get_dir())
  return px + tx, pz + tz
end

function M:check_point(other_collider, tx, tz)
  self:refesh_pos()
  local x, z = other_collider:cal_temp_pos(tx, tz)
  local dx, dz = self.v_posx - x, self.v_posz - z
  local dist = self:get_radius() + other_collider:get_radius()
  return dx * dx + dz * dz <= dist * dist
end

function M:create_debug_area()
  if self.v_char.gameobj and not self.v_char.gameobj:IsNull() then
    local obj = ResMgr:create_skill_area_obj()
    obj:ResetAttr()
    local skill_area_component = obj:GetComponent(TypeSkillArea)
    local radius = self:get_radius()
    local cs_collider = self.v_char:is_role() and self.v_char:get_collider()
    local height = (cs_collider and cs_collider.height or 1) * self.v_char.model_scale
    if Global.show_skill_area_type == Config.SHOW_SKILL_AREA_TYPE.MESH then
      obj.transform:SetLocalPositionA(0, 1, 0)
      local outline_width = _max(0.05, radius * 0.15 / 20)
      local segments = _floor(_max(50, radius * 10))
      skill_area_component:CreateCircle(radius, segments, outline_width, false)
      self.v_area_trans = obj.transform
    elseif Global.show_skill_area_type == Config.SHOW_SKILL_AREA_TYPE.SHAPE then
      self.v_shape_area_trans = obj.transform
      Util.VEC3_TEMP:Set(radius * 2, height - radius, radius * 2)
      skill_area_component:ShowCapsule(Util.VEC3_TEMP)
      obj.transform:SetParent(self.v_char.transform)
      obj.transform:SetLocalPositionA(0, 0, 0)
    end
    if self.v_char:is_hero() then
      self.v_area_trans_visible = self.v_char:check_background()
    else
      self.v_area_trans_visible = true
    end
    obj.gameObject:SetActive(self.v_area_trans_visible)
  end
end

function M:update()
  if not UNITY_EDITOR or Global.show_skill_area_type == Config.SHOW_SKILL_AREA_TYPE.NONE then
    return
  end
  self:update_area_trans()
end

function M:update_area_trans()
  local area_trans
  if Global.show_skill_area_type == Config.SHOW_SKILL_AREA_TYPE.MESH then
    if not Util.is_nil(self.v_shape_area_trans) then
      ResMgr:destroy_gameobj(self.v_shape_area_trans)
      self.v_shape_area_trans = nil
    end
    if Util.is_nil(self.v_area_trans) then
      self:create_debug_area()
    else
      area_trans = self.v_area_trans
    end
    if area_trans then
      local px, pz = self.v_char:get_pos2()
      local x, z = self:cal_temp_pos(px, pz)
      area_trans:SetLocalPositionA(x, 1, z)
    end
  elseif Global.show_skill_area_type == Config.SHOW_SKILL_AREA_TYPE.SHAPE then
    if not Util.is_nil(self.v_area_trans) then
      ResMgr:destroy_gameobj(self.v_area_trans)
      self.v_area_trans = nil
    end
    if Util.is_nil(self.v_shape_area_trans) then
      self:create_debug_area()
    else
      area_trans = self.v_shape_area_trans
    end
  end
  if area_trans and not self.v_area_trans_visible then
    area_trans.gameObject:SetActive(true)
    self.v_area_trans_visible = true
  end
end

function M:on_destroy()
  if not Util.is_nil(self.v_area_trans) then
    ResMgr:destroy_gameobj(self.v_area_trans)
    self.v_area_trans = nil
  end
  if not Util.is_nil(self.v_shape_area_trans) then
    ResMgr:destroy_gameobj(self.v_shape_area_trans)
    self.v_shape_area_trans = nil
  end
  Util.unbind_all_msg(self)
end

return M
