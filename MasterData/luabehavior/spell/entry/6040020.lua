local M = Util.create_class()

function M:_init()
  self.target = nil
  self.magic_set = 0
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if target == self.npc and get_npc_distance(target, 1, npc, true) <= 3 then
    cast_magic(self.npc, self.npc, 6040021, 0)
  end
end

return M
