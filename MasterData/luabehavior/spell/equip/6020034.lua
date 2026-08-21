local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:on_room_change(npc)
  if npc ~= self.npc then
    return
  end
  if get_npc_attr(self.npc, 3) / get_npc_attr(self.npc, 6) > 0 and get_npc_attr(self.npc, 3) / get_npc_attr(self.npc, 6) < 0.75 then
    cast_magic(self.npc, self.npc, 6021051, 1)
    cast_magic(self.npc, self.npc, 6021050, 1)
  end
  if get_npc_attr(self.npc, 3) / get_npc_attr(self.npc, 6) >= 0.75 and get_npc_attr(self.npc, 3) / get_npc_attr(self.npc, 6) < 1 then
    cast_magic(self.npc, self.npc, 6021052, 1)
    cast_magic(self.npc, self.npc, 6021050, 1)
  end
end

return M
