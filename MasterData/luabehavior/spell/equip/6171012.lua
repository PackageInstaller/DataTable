local M = Util.create_class()
local hero = get_come_on_hero()

function M:_init(npc)
end

function M:on_start()
  self.level = get_ability_level(60017) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(60017) or 1
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.npc ~= get_come_on_hero() then
    return
  end
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skact = info and info.skAct
  local kind_num = get_magic_kind_num(self.npc, 61710)
  if skact and skact:deemAtk() and kind_num > 0 then
    cast_magic(self.npc, self.npc, 61710121, self.level)
  end
end

return M
