local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:on_start()
  tool:castMagicToTeam(rogueMgr.fragment_control)
  self:get_level()
end

function M:on_npc_hp_zero(npc, attacker, magic_id, missile_id, missile)
  if self.npc ~= get_come_on_hero() then
    return
  end
  local kind = get_role_kind(npc)
  if kind >= 2 and kind <= 4 then
    local per = math.random()
    if per > 0.5 then
      rogueMgr.random_cast_fragment(rogueMgr, npc, 1, 4)
    end
  end
end

function M:on_room_change(npc)
  self:get_level()
end

function M:get_level()
  self.level = get_ability_level(70012)
  if 1 == self.level then
    self.possibility = 0.5
  else
    self.possibility = 0.7
  end
end

return M
