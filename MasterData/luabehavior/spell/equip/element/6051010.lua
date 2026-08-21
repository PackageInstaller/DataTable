local M = Util.create_class()

function M:_init(npc)
  self.npc = npc
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc == self.npc and (3 == damage_sign or 4 == damage_sign) then
    cast_magic(self.npc, self.npc, 60510101, 0)
  end
  if npc == self.npc and 1 == damage_sign then
    abort_magic_by_id(self.npc, 60510101, 1)
  end
end

return M
