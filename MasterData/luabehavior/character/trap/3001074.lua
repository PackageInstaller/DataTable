local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  set_npc_ignore_sync_area(npc, false)
  set_npc_status(npc, 3, true)
end

return M
