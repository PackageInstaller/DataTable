local M = Util.create_class()

function M:_init()
  self.target = nil
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 12, nil, 1)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, is_crit)
  if target ~= self.npc then
    return
  end
  if check_magic(npc, 399931) then
    cast_magic(self.npc, npc, 6031018, 1)
  end
end

return M
