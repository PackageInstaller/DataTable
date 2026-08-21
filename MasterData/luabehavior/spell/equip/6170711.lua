local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_start()
  self.CD = get_npc_time(self.npc)
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:isAtk() and self.CD < get_npc_time(self.npc) and check_magic(self.npc, rogueMgr.kuangnu) then
    local num = get_magic_num(self.npc, rogueMgr.kuangnu)
    cast_magic(self.npc, target, 61707111, num)
    self.CD = get_npc_time(self.npc) + 2
  end
end

function M:on_fate_book_battle_start()
  local level = get_ability_level(40009) or 1
  if 1 == level then
    for i = 1, 1 do
      cast_magic(self.npc, self.npc, rogueMgr.kuangnu)
    end
  else
    for i = 1, 2 do
      cast_magic(self.npc, self.npc, rogueMgr.kuangnu)
    end
  end
end

return M
