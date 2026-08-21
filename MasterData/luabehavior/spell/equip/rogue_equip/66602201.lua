local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.magic_set = 0
  self.timer_set = 0
  self.blooding_set = 0
  self.over_timer = 0
end

function M:on_fate_book_battle_start()
  if self.hero_one and not check_magic(self.hero_one, 66602201) then
    cast_magic(self.npc, self.hero_one, 66602201, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 66602201) then
    cast_magic(self.npc, self.hero_two, 66602201, 0)
  end
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if get_npc_attr(self.npc, 1) >= get_npc_attr(self.npc, 4) * 0.5 then
    return
  end
  if check_npc_die(self.npc) then
    return
  end
  local kind = get_role_kind(target)
  if (2 == kind or 3 == kind or 4 == kind) and damage_val < -0.5 then
    local value = math.abs(damage_val)
    cast_magic(self.npc, self.npc, 66602203, math.ceil(0.01 * math.max(math.min(value, 99900), 1)))
  end
end

function M:on_frame()
  if get_npc_attr(self.npc, 1) < get_npc_attr(self.npc, 4) * 0.5 then
    return
  end
  if 0 == self.timer_set then
    self.over_timer = get_npc_time(self.npc) + 1
    self.timer_set = 1
  end
  local now_time = get_npc_time(self.npc)
  if now_time > self.over_timer and 1 == self.timer_set then
    self.over_timer = now_time + 1
    self.blooding_set = self.blooding_set + 1
    cast_magic(self.npc, self.npc, 66602202, 1)
  end
end

return M
