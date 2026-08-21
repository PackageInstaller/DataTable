local M = Util.create_class()
local tool = import("common.tool")

function M:_init()
end

function M:on_born_behavior()
  local unit = self.npc:get_behavior()
  if not unit then
    return
  end
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
  tool.insert(unit, "onPdashSlomo", self.onPerfectDash)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:isDashInput() then
    self.isdash = true
  end
end

function M:on_self_before_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  if self.isdash then
    self.isdash = false
    local role = self.npc:get_behavior()
    local skill = role.skills[skill_id]
    local roleAct = skill and skill.skAct
    if not roleAct then
      return
    end
    if roleAct:isDash() and not roleAct:isPerfect() then
      cast_magic(self.npc, self.npc, 4033680101, 1)
      cast_magic(self.npc, self.npc, 4033680102, 1)
    end
  end
end

function M.onPerfectDash(role)
  tool:abortMagicToTeam(4033680101)
  tool:abortMagicToTeam(4033680102)
end

function M:on_remove()
  local unit = self.npc:get_behavior()
  if not unit then
    return
  end
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
  tool.remove(unit, "onPdashSlomo", self.onPerfectDash)
end

return M
