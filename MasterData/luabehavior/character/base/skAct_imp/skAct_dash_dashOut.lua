local dashBase = import("character.base.skAct_imp.skAct_dash")
local dashOutBase = Util.create_child_mt(dashBase)
dashOutBase._dashOutBase = dashOutBase
dashOutBase.dashOutBase = dashOutBase

function dashOutBase.setClass(customDashOutBase, actBases)
  local ret = customDashOutBase or dashOutBase
  local newParent = actBases.dash
  if newParent ~= dashBase and ret == dashOutBase then
    ret = {}
  end
  if ret ~= dashOutBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.dashOutBase = ret.dashOutBase or ret
    UtilTable.fill_table(dashOutBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function dashOutBase.new(customDashOutBase, role, _cfg)
  local dashOut = setmetatable({}, customDashOutBase)
  dashOut.base = customDashOutBase
  dashOut.type = Const.SKILL_ACTION_TYPE.DASH_OUT
  customDashOutBase:_init(dashOut, role, _cfg)
  return dashOut
end

function dashOutBase._init(customDashOutBase, dashOut, role, _cfg)
  dashOut.dashOutBase = customDashOutBase
  customDashOutBase.dashBase:_init(dashOut, role, _cfg)
end

function dashOutBase.isDashOut()
  return true
end

function dashOutBase.isReady(dashOut)
  if not dashOut.dashBase.isReady(dashOut) then
    return false
  end
  local inputDir = get_joystick_target_pos(dashOut.role.npc)
  return math.abs(inputDir.x) < 0.01 and math.abs(inputDir.z) < 0.01
end

function dashOutBase.isCommon()
end

function dashOutBase.tarPos(dashOut)
  local role = dashOut.role
  role:searchTarget(dashOut.search)
  local target = role.target
  return target and get_npc_pos(target)
end

return dashOutBase
