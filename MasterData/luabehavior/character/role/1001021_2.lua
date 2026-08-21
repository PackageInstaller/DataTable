local M = Util.create_class()
local CommonRole = import("common.role")

function M:_init(npc)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if target ~= self.npc then
    return
  end
  if 1 == get_role_kind(npc) then
    cast_magic(npc, npc, 1021060, 0)
  end
end

return M
