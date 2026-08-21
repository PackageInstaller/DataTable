local M = Util.create_class()

function M:_init()
  self.MagicStaty = true
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if target == self.npc then
    local hp = get_npc_attr(self.npc, 1) / get_npc_attr(self.npc, 4)
    if hp <= 0.3 and self.MagicStaty then
      self.MagicStaty = false
      cast_magic(self.npc, self.npc, 4033110201, 1)
    end
  end
end

return M
