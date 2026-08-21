local M = Util.create_class()

function M:_init(npc)
  self.npc = npc
  self.energy = get_npc_attr(self.npc, 2)
end

function M:on_frame()
  local current_energy = get_npc_attr(self.npc, 2)
  if current_energy < self.energy then
    cast_magic(self.npc, self.npc, 60530101, 0)
  end
  self.energy = current_energy
end

return M
