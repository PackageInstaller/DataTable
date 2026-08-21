local M = Util.create_class()

function M:_init()
  self.cast_time = 0
  self.cd = 0
  self.duration = 3
  self.acting_time = 0
  self.actskill = 0
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651110011)
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local target_kind = get_role_kind(target)
  if 2 ~= target_kind and 3 ~= target_kind and 4 ~= target_kind and 8 ~= target_kind and 9 ~= target_kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:isSkillInput() then
    self.acting_time = get_npc_time(self.npc) + self.duration
  end
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local target_kind = get_role_kind(target)
  if 2 ~= target_kind and 3 ~= target_kind and 4 ~= target_kind and 8 ~= target_kind and 9 ~= target_kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct.type == "atk" and get_npc_time(self.npc) <= self.acting_time then
    self.actskill = skill_id
    cast_magic(self.npc, self.npc, 651110012, self.level)
  end
end

function M:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  if skill_id == self.actskill then
    if check_magic(self.npc, 651110012) then
      abort_magic_by_id(self.npc, 651110012)
    end
    self.acting_time = 0
  end
end

return M
