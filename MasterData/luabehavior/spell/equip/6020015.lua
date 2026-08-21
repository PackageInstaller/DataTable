local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.target = nil
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 12, nil, 1)
end

function M:on_frame()
  if not self.npc then
    return
  end
  if 2 ~= self.magic_set and get_npc_attr(self.npc, 1) / get_npc_attr(self.npc, 4) <= 0.3 then
    self.magic_set = 1
  end
  if check_magic(self.npc, 6021018) and get_npc_attr(self.npc, 1) / get_npc_attr(self.npc, 4) > 0.3 then
    cast_magic(self.npc, self.npc, 6021037, 1)
  end
  if 1 == self.magic_set and not check_magic(self.npc, 6021018) then
    cast_magic(self.npc, self.npc, 6021018, 1)
    self.magic_set = 2
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, damage_val)
  if npc ~= self.npc then
    return
  end
end

return M
