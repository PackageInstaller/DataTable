local M = Util.create_class()
local tool = import("common.tool")
local rolebase = import("character.base.role_base")

function M:_init(npc)
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local cur_hp = get_npc_attr(self.npc, 1)
  local max_hp = get_npc_attr(self.npc, 4)
  local percent = cur_hp / max_hp
  if percent < 0.4 and not check_magic(self.npc, 61707351) then
    local level = get_ability_level(40021) or 1
    cast_magic(self.npc, self.npc, 61707351, level)
  end
end

return M
