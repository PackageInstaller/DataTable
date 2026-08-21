local M = Util.create_class()

function M:_init()
  self.recoverStaty = false
  self.recoverNum = 0
  self.nowTime = 0
  self.intervalTime = 0
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and is_showup then
    cast_magic(self.npc, self.npc, 4033210101, 1)
    cast_magic(self.npc, self.npc, 4033210102, 1)
    self.recoverStaty = true
    self.intervalTime = self.nowTime + 1
    self.recoverNum = 0
  elseif npc == self.npc and not is_showup then
    self.recoverStaty = false
    abort_magic_by_id(self.npc, 4033210102)
  end
end

function M:on_frame()
  self.nowTime = get_npc_time(self.npc)
  if self.recoverStaty and self.nowTime >= self.intervalTime then
    cast_magic(self.npc, self.npc, 4033210103, 1)
    self.intervalTime = self.nowTime + 1
    self.recoverNum = self.recoverNum + 1
    if self.recoverNum >= 5 then
      self.recoverNum = 0
      self.recoverStaty = false
      abort_magic_by_id(self.npc, 4033210102)
    end
  end
end

return M
