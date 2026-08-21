local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and is_showup then
    cast_magic(self.npc, self.npc, 4033510101, 1)
  end
end

return M
