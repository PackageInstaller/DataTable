local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:after_damage_self(npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(npc)
  if 2 == kind or 3 == kind or 4 == kind then
    rogueMgr.random_cast_fragment(rogueMgr, self.npc, self.level, 3)
  end
end

function M:on_start()
  self.level = get_ability_level(70004) or 1
  tool:castMagicToTeam(rogueMgr.fragment_control)
end

function M:on_room_change(npc)
  self.level = get_ability_level(70004) or 1
end

return M
