local M = Util.create_class()

function M:_init(npc)
  set_npc_floating_text_hud_visible(npc, false)
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  set_npc_status(npc, 3, true)
  cast_skill(npc, nil, 300107201)
end

return M
