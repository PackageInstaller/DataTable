local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, false)
end

return M
