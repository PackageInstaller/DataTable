local M = Util.create_class()
local tool = import("common.tool")

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc ~= self.npc then
    return
  end
  if (2 == get_role_kind(target) or 3 == get_role_kind(target) or 4 == get_role_kind(target)) and 61707032 ~= magic_id then
    local target_hp_max = get_npc_attr(target, 4)
    if 0 - damage_val > target_hp_max * 0.25 then
      cast_magic(self.npc, target, 61707032)
      cast_magic(self.npc, self.npc, 61707031)
    end
  end
end

function M:on_start()
end

function M:_init(npc)
end

return M
