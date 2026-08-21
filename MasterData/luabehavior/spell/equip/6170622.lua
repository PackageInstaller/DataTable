local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  if check_magic(self.npc, rogueMgr.weilai) then
    local info = missile and get_missile_skill_action_info(missile)
    local skAct = info and info.skAct
    if skAct and not skAct:isAtk() then
      local level = get_ability_level(20013) or 1
      if level > 1 then
        cast_magic(self.npc, self.npc, 61706222, 1)
      else
        cast_magic(self.npc, self.npc, 61706221, 1)
      end
      abort_magic_by_id(self.npc, rogueMgr.weilai, 1)
    end
  end
end

function M:on_start()
end

function M:_init(npc)
end

return M
