local M = Util.create_class()

function M:_init(npc)
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  set_can_searched(npc, false)
  time_scale_immune(npc, true)
  enable_shadow(npc, false)
  cast_skill(npc, npc, 300201301, nil, nil)
  npc.search = {}
  set_can_searched(npc, false)
end

return M
