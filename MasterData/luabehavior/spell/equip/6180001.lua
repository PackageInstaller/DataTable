local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
  self.casttime = 1
  self.cast = false
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:isSkill() then
    self.cast = true
  end
end

function M:after_damage_target(caster, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skillId, missile)
  if self.cast then
    self.cast = false
    self.casttime = self.casttime + 1
    if self.casttime > 3 then
      self.casttime = 1
      local role = self.npc:get_behavior()
      local target = role.target
      cast_missile_new(self.npc, target, nil, nil, 32202080201)
    end
  end
end

function M:on_skact_end(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:isSkill() then
    self.cast = false
  end
end

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_END, self.npc, self.on_skact_end, self)
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BREAK, self.npc, self.on_skact_end, self)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_END, self.npc, self)
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BREAK, self.npc, self)
end

return M
