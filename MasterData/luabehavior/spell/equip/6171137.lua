local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
  self.level = get_ability_level(10023) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(10023) or 1
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if get_npc_attr(self.npc, 4) - get_npc_attr(self.npc, 1) < 1 then
    local bool, num = tool:checkMagicToTeam(61711371)
    if 0 == num then
      cast_magic(self.npc, self.npc, 61711371, self.level)
    end
  end
end

function M:_init(npc)
end

return M
