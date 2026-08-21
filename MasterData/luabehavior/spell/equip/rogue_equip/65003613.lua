local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_frame()
  if get_npc_attr(self.npc, 1) == get_npc_attr(self.npc, 4) and not check_magic(self.npc, 65003612) then
    cast_magic(self.npc, self.npc, 65003612, 0)
  elseif get_npc_attr(self.npc, 1) ~= get_npc_attr(self.npc, 4) and check_magic(self.npc, 65003612) then
    abort_magic_by_id(self.npc, 65003612)
  end
end

return M
