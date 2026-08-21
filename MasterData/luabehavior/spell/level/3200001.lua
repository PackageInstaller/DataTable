local M = Util.create_class()

function M:_init(npc)
  self.god1 = add_npc_by_pos_key(1, 3001024, "M1", 0, 0, "M1", 0, 0, 2, 1)
  self.pos1 = get_npc_pos(self.god1)
  create_scene_effect("Fx_Transmit2", self.pos1, 999, "LanDian")
end

return M
