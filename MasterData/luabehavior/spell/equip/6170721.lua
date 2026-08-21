local M = Util.create_class()
local tool = import("common.tool")
local rolebase = import("character.base.role_base")

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  if self.level > 1 then
    if get_npc_attr(self.npc, 76) > 8000 then
      cast_magic(self.npc, self.npc, 61707212)
    end
  elseif get_npc_attr(self.npc, 76) > 10000 then
    cast_magic(self.npc, self.npc, 61707211)
  end
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if is_crit and damage_val < -0.5 then
    local hp_cur = get_npc_attr(self.npc, 1)
    local hp_max = get_npc_attr(self.npc, 4)
    local hp_per = hp_cur / hp_max
    if hp_per < 0.4 then
      cast_magic(self.npc, self.npc, 61707213, self.level)
    end
  end
end

function M:on_start()
  self.level = get_ability_level(40012) or 1
end

function M:on_room_change()
  self.level = get_ability_level(40012) or 1
end

function M:_init(npc)
end

return M
