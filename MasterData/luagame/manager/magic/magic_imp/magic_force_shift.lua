local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)
local FORCE_UPDATE_DIR = {IN = 1, OUT = 2}
local FORCE_UPDATE_CENTER = {
  MISSILE = 1,
  CASTER = 2,
  NOT_MISSILE_TYPE = 3,
  MISSILE_PROJECTION_RIGHT = 4,
  MISSILE_PROJECTION_FORWARD = 5,
  BEHAVIOR_DEFINED = 6
}

local function _get_missile_projection_pos(attacker, owner, center_type, missile)
  local missile_trans = missile.transform
  local projectio_dir = center_type == FORCE_UPDATE_CENTER.MISSILE_PROJECTION_RIGHT and missile_trans.right or missile_trans.forward
  local begin_pos
  local owner_pos = owner:get_pos_vec3()
  local missile_pos = missile:get_pos_vec3()
  local dir = Util.VEC3_TEMP
  dir:Set(owner_pos.x - missile_pos.x, 0, owner_pos.z - missile_pos.z)
  local right = dir.New()
  right:SetA(projectio_dir.normalized)
  local dot_product = dir.Dot(right, dir)
  local projection = right * (dot_product / right:SqrMagnitude())
  begin_pos = missile_pos + projection
  return begin_pos
end

local function _get_pos_and_dir(attacker, owner, center_type, missile, magic_id)
  local begin_pos, force_dir
  if center_type == FORCE_UPDATE_CENTER.MISSILE then
    begin_pos = missile:get_pos_vec3()
  elseif center_type == FORCE_UPDATE_CENTER.CASTER then
    begin_pos = missile.v_owner:get_pos_vec3()
  elseif center_type == FORCE_UPDATE_CENTER.NOT_MISSILE_TYPE then
    begin_pos = attacker:get_pos_vec3()
    force_dir = owner:get_pos_vec3() - attacker:get_pos_vec3()
  elseif center_type == FORCE_UPDATE_CENTER.MISSILE_PROJECTION_RIGHT then
    begin_pos = _get_missile_projection_pos(attacker, owner, center_type, missile)
  elseif center_type == FORCE_UPDATE_CENTER.MISSILE_PROJECTION_FORWARD then
    begin_pos = _get_missile_projection_pos(attacker, owner, center_type, missile)
  elseif center_type == FORCE_UPDATE_CENTER.BEHAVIOR_DEFINED then
    local behavior = attacker:get_behavior()
    local func = behavior and behavior.force_shift_magic_init
    if func then
      begin_pos, force_dir = func(behavior, magic_id, owner)
      if not begin_pos then
        Log.Errorf("behavior get force shift error, begin position is nil magic_id: %s, behavior file: %s, %s", magic_id, behavior.file_id, debug.traceback())
      end
    else
      Log.Error("force_shift_magic_init is lost", debug.traceback())
      begin_pos = attacker:get_pos_vec3()
      force_dir = owner:get_pos_vec3() - attacker:get_pos_vec3()
    end
  else
    begin_pos = missile:get_pos_vec3()
    force_dir = missile:get_dir_vec()
  end
  return begin_pos, force_dir
end

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect()
  local missile = self.owner_missile
  local begin_pos, force_dir = _get_pos_and_dir(self.magic_info.attacker, self.owner, self.cfg.CenterType, missile, self.magic_id)
  local dir_flag = 1
  if self.cfg.DirType == FORCE_UPDATE_DIR.IN then
    dir_flag = -1
  end
  local armor_atk_lv, ignore_armor
  if missile then
    armor_atk_lv = self.cfg.ArmorAtkLevel
  else
    armor_atk_lv = 1
    ignore_armor = 1
  end
  local break_length = self.cfg.BreakLength
  local speed = self.cfg.Speed
  local acceleration = self.cfg.Acceleration
  local allow_slide = not Util.is_empty(self.cfg.AllowSlide) and self.cfg.AllowSlide >= 0
  if begin_pos then
    self.owner.role_move_ctrl:set_force_shift(speed, dir_flag, break_length, begin_pos, force_dir, ignore_armor, armor_atk_lv, acceleration, allow_slide, self.magic_info.attacker.uuid, self.magic_id)
  end
end

function M:on_remove(magic_map)
  if next(magic_map) == nil then
    self.owner.role_move_ctrl:stop_force_shift()
  end
end

return M
