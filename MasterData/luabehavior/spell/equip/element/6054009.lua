local M = Util.create_class()

function M:_init()
  self.magic_added = false
end

function M:on_frame()
  local max_energy = get_npc_attr(self.npc, 5)
  local current_energy = get_npc_attr(self.npc, 2)
  if max_energy <= current_energy and not self.magic_added then
    cast_magic(self.npc, self.npc, 60540091, 0)
    self.magic_added = true
  elseif max_energy > current_energy and self.magic_added then
    abort_magic_by_id(self.npc, 60540091, 1)
    self.magic_added = false
  end
end

return M
