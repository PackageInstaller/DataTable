local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:isQte() then
    self.QTECasting = true
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  if self.QTECasting and npc == self.npc then
    local hero1 = get_scene_hero_by_poskey(21)
    local hero2 = get_scene_hero_by_poskey(22)
    cast_magic(self.npc, hero1, 617133201, 1)
    cast_magic(self.npc, hero2, 617133201, 1)
    self.QTECasting = false
  end
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 6171331)
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

return M
