local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local target_kind = get_role_kind(target)
  if 2 ~= target_kind and 3 ~= target_kind and 4 ~= target_kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if not skAct then
    return
  end
  if rogueMgr.magic_6171225 and skAct and skAct:isAtk() then
    return
  end
  if rogueMgr.magic_6171231 and skAct and skAct:isQte() then
    return
  end
  if check_magic(self.npc, rogueMgr.fragment_effect_magic) then
    return
  end
  local fragment_num = get_magic_num(self.npc, rogueMgr.fragment_magic)
  if fragment_num <= 0 then
    return
  else
    rogueMgr.fragment_level = math.ceil(fragment_num / 3)
    rogueMgr.fragment_effect_magic_num = fragment_num
    cast_magic(self.npc, self.npc, rogueMgr.fragment_effect_magic, rogueMgr.fragment_level)
    abort_magic_by_id(self.npc, rogueMgr.fragment_magic)
  end
end

return M
