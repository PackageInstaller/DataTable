local M = Util.create_class()
local tool = import("common.tool")
local roleTool = import("common.role_tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if not act:isQteInput() then
    return
  end
  self.isQte = true
  cast_magic(self.npc, self.npc, 61713241)
  if act:isExQte() then
    self.isExQte = true
  end
end

function M:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  if not self.isQte then
    return
  end
  abort_magic_by_id(self.npc, 61713241)
  self.isQte = false
  if self.isExQte then
    self.isExQte = false
    cast_magic(self.npc, self.npc, 61713241)
  end
end

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

return M
