local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")

function M:_init(npc)
end

function M:cast_missile(dash, atkMis)
  if not atkMis then
    return
  end
  local attacker = get_missile_owner(atkMis)
  if not attacker then
    return
  end
  local kind = get_role_kind(attacker)
  if 2 == kind or 3 == kind or 4 == kind then
    change_abnormal_flag_count(attacker, 5, 1)
  end
end

function M:on_start()
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  tool.insert(role, "onPdashSlomo", self.cast_missile)
end

function M:on_remove()
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  tool.remove(role, "onPdashSlomo", self.cast_missile)
end

return M
