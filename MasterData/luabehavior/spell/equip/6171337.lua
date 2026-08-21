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
  if get_npc_attr(self.npc, 2) < 100 and self.showup then
    cast_magic(self.npc, self.npc, rogueMgr.relay, 1)
    self.showup = false
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if npc ~= self.npc then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:isQte() then
    cast_magic(self.npc, self.npc, 617133601, 1)
    self.QTECast = true
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  if self.QTECast then
    abort_magic_by_id(self.npc, 617133601)
    self.QTECast = false
  end
end

function M:on_hero_showup_or_back(behavior, npc, is_showup, by_ult_change)
  if is_showup then
    self.showup = true
  end
end

function M:on_start()
  local role = self.npc:get_behavior()
  if role then
    tool.insert(role, "onRampageStart", self.rampage)
  end
end

function M:rampage()
  cast_magic(self.npc, self.npc, rogueMgr.relay, 1)
  cast_magic(self.npc, self.npc, rogueMgr.relay, 1)
  cast_magic(self.npc, self.npc, rogueMgr.relay, 1)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
  local role = self.npc:get_behavior()
  if role then
    tool.remove(role, "onRampageStart", self.rampage)
  end
end

return M
