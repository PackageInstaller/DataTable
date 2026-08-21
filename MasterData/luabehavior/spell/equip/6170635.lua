local M = Util.create_class()
local tool = import("common.tool")

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  if check_magic(target, 61706352) or 61706351 == magic_id or check_npc_die(target) then
    return
  end
  if get_magic_kind_num(target, 10) > 0 then
    cast_magic(self.npc, target, 61706351, self.level)
    cast_magic(self.npc, target, 61706352)
  end
end

function M:on_start()
  self.level = get_ability_level(20021) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(20021) or 1
end

function M:_init(npc)
end

return M
