local M = Util.create_class()

function M:_init(npc)
  enable_shadow(npc, false)
  local can_searched = true
  local status0 = pcall(get_sync_var, "set_can_searched")
  if status0 and get_sync_var("set_can_searched") then
    can_searched = get_sync_var("set_can_searched")
  end
  set_can_searched(npc, can_searched)
  self.skill_born = 300203701
  self.skill_attack = 300203702
  self.skill_reload = 300203706
  self.skill_detect = 300203703
  self.skill_die = 300203704
  self.skill_normal_die = 300203705
  self.missile_detect = 30020370301
  self.search_range = 10.0
  self.stop_search = false
  self.target = nil
  self.retreat_time = 12
  local status = pcall(get_sync_var, "retreat_time")
  if status and get_sync_var("retreat_time") then
    self.retreat_time = get_sync_var("retreat_time")
  end
  self.start_time = get_npc_time(npc)
end

function M:on_npc_born(npc)
  if npc == self.npc then
    cast_skill(self.npc, nil, self.skill_born)
  end
end

function M:on_frame()
  if get_npc_time(self.npc) >= self.start_time + self.retreat_time and not self.stop_search then
    self.stop_search = true
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.skill_normal_die)
  end
end

function M:after_damage_self(npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  self.stop_search = true
  abort_skill(self.npc)
  cast_skill(self.npc, nil, self.skill_die)
  set_npc_dead(self.npc, nil, false)
end

function M:on_self_skill_end(skill_id, is_time_out, is_break)
  if skill_id == self.skill_born then
    cast_skill(self.npc, nil, self.skill_detect)
    change_missile_config(self.missile_detect, "SizeX", self.search_range, 0)
  elseif skill_id == self.skill_attack and not self.stop_search then
    cast_skill(self.npc, nil, self.skill_reload)
  elseif skill_id == self.skill_reload and not self.stop_search then
    cast_skill(self.npc, nil, self.skill_detect)
    change_missile_config(self.missile_detect, "SizeX", self.search_range, 0)
  elseif skill_id == self.skill_die then
    remove_npc(self.npc)
  elseif skill_id == self.skill_normal_die then
    remove_npc(self.npc)
  end
end

function M:on_self_skill_hit(skill_id, hit_target, hit_type, missile_cfg, missile)
  local target_player
  if not self.stop_search and skill_id == self.skill_detect then
    target_player = hit_target
  end
  if target_player and 5 ~= get_role_kind(target_player) and 6 ~= get_role_kind(target_player) then
    self.target = target_player
  else
    self.target = nil
  end
  if self.target and not self.stop_search then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill_attack)
    target_player = nil
  end
end

return M
