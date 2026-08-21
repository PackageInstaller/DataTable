local M = Util.create_class()

function M:_init(npc)
  cast_magic(npc, npc, 60540081, 0)
end

return M
