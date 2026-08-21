local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc == self.npc then
    return
  end
  if target == self.npc then
    cast_magic(self.npc, self.npc, 6021030, 1)
  end
end

return M
