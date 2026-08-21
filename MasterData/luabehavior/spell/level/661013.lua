local M = Util.create_class()

function M:_init()
  self.come_on_hero = nil
end

function M:on_start()
  self.come_on_hero = get_come_on_hero()
end

function M:on_hero_showup_or_back(npc, is_showup)
  if true == is_showup then
    self.come_on_hero = get_come_on_hero()
  end
end

function M:on_npc_born(npc)
  if self.npc ~= self.come_on_hero then
    return
  end
  local npc_kind = get_role_kind(npc)
  if npc_kind >= 2 and npc_kind <= 4 or 7 == npc_kind then
    cast_magic(npc, npc, 66101301)
  end
end

return M
