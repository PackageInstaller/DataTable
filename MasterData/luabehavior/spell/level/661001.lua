local M = Util.create_class()

function M:_init()
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if true ~= is_showup then
    return
  end
  cast_magic(npc, npc, 66100101)
end

return M
