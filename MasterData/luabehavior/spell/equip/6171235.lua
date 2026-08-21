local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= get_come_on_hero() then
    return
  end
  if act == act.role.baseActs.wander then
    cast_magic(act.role.npc, act.role.npc, self.magic_id)
  else
    abort_magic_by_id(act.role.npc, self.magic_id)
  end
end

function M:on_room_change(npc)
  self:get_level()
end

function M:on_start()
  self:get_level()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:get_level()
  self.level = get_ability_level(70013)
  if 1 == self.level then
    self.magic_id = 61712351
  else
    self.magic_id = 61712352
  end
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6171235)
  if 0 == num then
    unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
  end
end

return M
