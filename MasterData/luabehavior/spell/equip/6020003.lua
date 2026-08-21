local M = Util.create_class()

function M:_init()
  self.target = nil
  self.magic_set = 0
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 12, nil, 1)
end

function M:on_frame()
  self:search_target()
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  if get_npc_attr(self.target, 1) == get_npc_attr(self.target, 4) then
    cast_magic(self.npc, self.npc, 6021048, 1)
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.target then
    self.target = nil
  end
end

return M
