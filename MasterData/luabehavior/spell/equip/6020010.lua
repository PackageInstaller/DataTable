local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.target = nil
  self.magic_timer = 0
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 12, nil, 1)
end

function M:on_frame()
  self:search_target()
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, damage_val)
  if npc ~= self.npc then
    return
  end
  if 6021039 == magic_id then
    return
  end
  if math.floor(get_npc_attr(self.target, 1) / get_npc_attr(self.target, 4)) <= 0.9 and 1 == damage_sign then
    cast_magic(self.npc, self.target, 6021039, 1)
  end
end

return M
