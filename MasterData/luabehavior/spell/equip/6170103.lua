local M = Util.create_class()
local CommonMonster = import("common.monster")
local CommonRole = import("common.role")
local team_hero_list = {}
local ability = 20003
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

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 5 == get_skill_cfg(skill_id).SkillType and npc == self.npc and get_time() >= interval_time then
    cast_magic(self.npc, self.npc, 61701031, level)
    interval_time = get_time() + 5
  end
end

return M
