local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and is_showup and get_npc_attr(self.npc, 2) < get_npc_attr(self.npc, 5) then
    cast_magic(self.npc, self.npc, 4033550101, 1)
  end
end

return M
