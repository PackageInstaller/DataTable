local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 == kind or 3 == kind or 4 == kind and not check_npc_die(target) and not check_magic(target, rogueMgr.baojin) then
    local info = missile and get_missile_skill_action_info(missile)
    local skAct = info and info.skAct
    if skAct and skAct:deemUlt() then
      local per1, per2 = tool:randByTime(0.3, rogueMgr.baojin_possible)
      if per2 then
        cast_magic(self.npc, target, rogueMgr.baojin)
      end
    end
  end
end

function M:on_start()
  if not rogueMgr.baojin_possible then
    rogueMgr.baojin_possible = 0.3
  end
  rogueMgr.baojin_magic = true
  if not check_magic(get_god_npc(), 61708001) then
    cast_magic(self.npc, get_god_npc(), 61708001)
  end
  self.level = get_ability_level(50012) or 1
  if self.level > 1 then
    rogueMgr.baojin_possible = 0.5
  end
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6170821)
  if 0 == num then
    rogueMgr.baojin_magic = false
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(50012) or 1
  if self.level > 1 then
    rogueMgr.baojin_possible = 0.5
  end
end

return M
