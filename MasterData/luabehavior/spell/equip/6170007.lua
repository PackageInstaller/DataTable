local M = Util.create_class()
local team_hero_list = {}
local ability = 10007
local level = 1
local time = 0
local interval_time = 0

function M:_init(npc)
  team_hero_list = {
    get_come_on_hero(),
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22)
  }
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  if (61700051 == magic_id or 61700081 == magic_id) and (npc == team_hero_list[1] or npc == team_hero_list[2] or npc == team_hero_list[3]) then
    time = get_time()
    if time >= interval_time then
      interval_time = time + 1
      cast_magic(npc, target, 61700070 + level, 1)
    end
  end
end

return M
