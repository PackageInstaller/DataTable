local M = Util.create_class()

function M:_init()
  self.target = nil
end

function M:on_frame()
  if self.target == nil then
    self.target = search_npc(self.npc, 4, 12, nil, 1)
  end
  if self.target then
    if not check_npc_distance(self.npc, self.target, 6, 1) and not check_magic(self.npc, 6021017) then
      cast_magic(self.npc, self.npc, 6021017, 1)
      cast_magic(self.npc, self.npc, 6021001, 1)
    else
      abort_magic_by_id(self.npc, 6021017)
      abort_magic_by_id(self.npc, 6021001)
    end
  end
end

return M
