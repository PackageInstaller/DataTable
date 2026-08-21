local M = Util.create_class()

function M:_init(npc)
end

function M:on_start()
  if not check_magic(get_god_npc(), 61706023) then
    cast_magic(get_god_npc(), get_god_npc(), 61706023)
  end
end

return M
