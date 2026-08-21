local M = Util.create_class()

function M:_init()
end

function M:on_start()
  if get_come_on_hero() == self.npc then
    cast_magic(self.npc, self.npc, 4033570101, 1)
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and is_showup then
    cast_magic(self.npc, self.npc, 4033570101, 1)
  elseif npc == self.npc and not is_showup then
    abort_magic_by_id(self.npc, 4033570101)
  end
end

function M:on_frame()
end

return M
