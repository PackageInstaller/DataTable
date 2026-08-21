local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:on_start()
  rogueMgr.magic_6171231 = true
  tool:castMagicToTeam(rogueMgr.fragment_control)
  self.level = get_ability_level(70009)
  if self.level > 1 then
    self.possibility = 0.7
  else
    self.possibility = 0.5
  end
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if not skAct or not skAct:isQte() then
    return
  end
  local per1, per2 = tool:randByTime(1, self.possibility)
  if per2 then
    rogueMgr.random_cast_fragment(rogueMgr, self.npc, 1, 3)
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(70009)
  if self.level > 1 then
    self.possibility = 0.7
  else
    self.possibility = 0.5
  end
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6171231)
  if 0 == num then
    rogueMgr.magic_6171231 = false
  end
end

return M
