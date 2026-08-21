local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
  self.curr_time = 0
  local level = get_ability_level(10018) or 1
  if level and level > 1 then
    self.cd = 1.5
  else
    self.cd = 3
  end
end

function M:on_room_change(npc)
  local level = get_ability_level(10018) or 1
  if level and level > 1 then
    self.cd = 1.5
  else
    self.cd = 3
  end
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if get_npc_time(self.npc) > self.curr_time + self.cd and 7 == damage_sign then
    tool:castMagicToTeam(rogueMgr.shoushi)
    self.curr_time = get_npc_time(self.npc)
  end
end

function M:_init(npc)
end

return M
