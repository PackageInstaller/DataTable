local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:deemAtk() and check_magic(self.npc, rogueMgr.kuangnu) and get_magic_num(self.npc, 61707331) < 5 then
    local level = get_ability_level(40019) or 1
    cast_magic(self.npc, self.npc, 61707331, level)
  end
end

function M:on_fate_book_battle_start()
  abort_magic_by_id(self.npc, 61707331)
end

function M:on_room_pass(room_id)
  abort_magic_by_id(self.npc, 61707331)
end

function M:_init(npc)
end

return M
