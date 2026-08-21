local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
  self.level = get_ability_level(10024) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(10024) or 1
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local shield = get_npc_shield(self.npc)
  if shield and shield > 0.5 and not check_magic(self.npc, 61711381) then
    cast_magic(self.npc, self.npc, 61711381, self.level)
  else
    abort_magic_by_id(self.npc, 61711381)
  end
end

function M:_init(npc)
end

return M
