local M = Util.create_class()
local up_current_time = 0
local up_cd = 0.5
local down_current_time = 0
local down_cd = 0.5

function M:_init(npc)
  team_hero_list = {
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22),
    get_come_on_hero()
  }
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if npc == get_come_on_hero() and get_npc_time(self.npc) > up_current_time + up_cd then
    cast_magic(npc, get_scene_hero_by_poskey(21), 61706022)
    cast_magic(npc, get_scene_hero_by_poskey(22), 61706022)
    up_current_time = get_npc_time(self.npc)
  end
  if (npc == get_scene_hero_by_poskey(21) or npc == get_scene_hero_by_poskey(22)) and get_npc_time(self.npc) > down_current_time + down_cd then
    cast_magic(npc, get_come_on_hero(), 61706021)
    down_current_time = get_npc_time(self.npc)
  end
end

function M:on_start()
end

return M
