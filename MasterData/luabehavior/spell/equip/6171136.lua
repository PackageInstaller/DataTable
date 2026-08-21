local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
  self.level = get_ability_level(10022) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(10022) or 1
end

function M:after_damage(npc, target, magic_id, damage_sign)
  if get_come_on_hero() ~= self.npc or check_npc_die(self.npc) then
    return
  end
  if (1 == get_role_kind(target) or 5 == get_role_kind(target)) and (2 == get_role_kind(npc) or 3 == get_role_kind(npc) or 4 == get_role_kind(npc)) then
    local shield = get_npc_shield(self.npc)
    if shield and shield > 0.5 then
      cast_magic(self.npc, npc, rogueMgr.fanji, self.level)
    end
  end
end

function M:_init(npc)
end

return M
