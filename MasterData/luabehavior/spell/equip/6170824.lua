local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_start()
  self.level = get_ability_level(50015) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(50015) or 1
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if not check_npc_die(target) then
    local kind = get_role_kind(target)
    if (2 == kind or 3 == kind or 4 == kind) and not check_magic(target, 61708242) then
      for i = 2, 6 do
        if check_element_ab_state(target, i) then
          cast_magic(self.npc, target, 61708242)
          cast_magic(self.npc, target, 61708241, self.level)
          return
        end
      end
    end
  end
end

return M
