local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
  self.casttime = 0
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skillId, missile)
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  local curTime = get_npc_time(self.npc)
  if skAct and (skAct:isAtk() or skAct:isHeavy()) and curTime > self.casttime then
    local role = self.npc:get_behavior()
    local target = role.target
    cast_missile_new(self.npc, target, nil, nil, 32202080101)
    self.casttime = curTime + 2
  end
end

function M:on_start()
end

function M:on_remove()
end

return M
