local M = Util.create_class()

function M:_init()
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if not target then
    return
  end
  if 6021008 == magic_id then
    return
  end
  if npc ~= self.npc then
    return
  end
  local now_amor = get_npc_attr(target, 69)
  if now_amor > 0 then
    cast_magic(self.npc, target, 6021008, 1)
  end
end

return M
