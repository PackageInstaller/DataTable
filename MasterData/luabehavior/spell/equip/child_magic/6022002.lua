local M = Util.create_class()

function M:_init()
  self.magic_set_1 = 0
  self.magic_set_2 = 0
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc == self.npc then
    return
  end
  if 0 == self.magic_set_1 then
    cast_magic(self.npc, npc, 6021023, 1)
    self.magic_set_1 = 1
  end
  if 0 == self.magic_set_2 then
    cast_magic(self.npc, npc, 6021022, 1)
    self.magic_set_2 = 1
  end
end

return M
