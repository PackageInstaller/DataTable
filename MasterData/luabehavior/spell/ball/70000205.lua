local M = Util.create_class()

function M:_init()
  self.magicStaty = false
end

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
  if self.npc == get_come_on_hero() then
    self.magicStaty = 5
  end
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if self.magicStaty and (act.type == "atk" or act.type == "heavy") then
    self.magicStaty = self.magicStaty - 1
    cast_magic(self.npc, self.npc, 7000020501, 1)
    if 0 == self.magicStaty then
      self.magicStaty = false
    end
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  if npc == self.npc then
    abort_magic_by_id(self.npc, 7000020501, 1)
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and is_showup then
    self.magicStaty = 5
  end
end

return M
