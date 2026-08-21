local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if true == is_showup then
    cast_magic(get_god_npc(), get_god_npc(), 66605301)
  end
end

return M
