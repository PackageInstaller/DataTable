local M = Util.create_class()
local tool = import("common.tool")

function M:_init(npc)
end

function M:on_room_change(npc)
  self.level = get_ability_level(30015) or 1
end

function M:on_start()
  self.level = get_ability_level(30015) or 1
  local enemies = search_npc(self.npc, 4, 30, nil, 0, true)
  if enemies then
    for _, enemy in pairs(enemies) do
      if not check_magic(enemy, 61709241) then
        cast_magic(self.npc, enemy, 61709241, self.level)
      end
    end
  end
end

function M:on_npc_born(npc)
  if not check_magic(npc, 61709241) and (2 == get_role_kind(npc) or 3 == get_role_kind(npc) or 4 == get_role_kind(npc)) then
    cast_magic(self.npc, npc, 61709241, self.level)
  end
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if 2 ~= get_role_kind(target) and 3 ~= get_role_kind(target) and 4 ~= get_role_kind(target) then
    return
  elseif 61709222 == magic_id and not check_magic(target, 61709242) then
    cast_magic(self.npc, target, 61709242, self.level)
  end
end

return M
