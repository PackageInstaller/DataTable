local M = Util.create_class()
local tool = import("common.tool")
local roleTool = import("common.role_tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local kind = get_role_kind(target)
  if kind < 2 or kind > 4 then
    return
  end
  local hero1 = get_scene_hero_by_poskey(21)
  local hero2 = get_scene_hero_by_poskey(22)
  local ground_num = 0
  if is_hero_in_ground(hero1) then
    ground_num = ground_num + 1
  end
  if is_hero_in_ground(hero2) then
    ground_num = ground_num + 1
  end
  if 0 == ground_num then
    return
  end
  cast_magic(self.npc, self.npc, 61713221, ground_num)
end

return M
