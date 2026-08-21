local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:on_fate_book_battle_start()
  self.SkillOver = false
end

function M:_init(npc)
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skillId, missile)
  if 1 == damage_sign then
    cast_magic(self.npc, self.npc, 618010201, 1)
  end
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skillId, missile)
  if 1 == damage_sign then
    if self.teammate2 then
      cast_magic(self.npc, self.teammate2, 618010202, 1)
    end
    if self.teammate3 then
      cast_magic(self.npc, self.teammate3, 618010202, 1)
    end
  end
end

function M:update_team_hero()
  self.teammate2 = get_scene_hero_by_poskey(21)
  self.teammate3 = get_scene_hero_by_poskey(22)
end

function M:on_start()
  self.update_team_hero(self)
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and is_showup then
    self.update_team_hero(self)
  end
end

function M:on_remove()
end

return M
