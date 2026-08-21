local ultBase = import("character.base.skAct_imp.skAct_ult")
local ultFastBase = Util.create_child_mt(ultBase)
ultFastBase._ultFastBase = ultFastBase
ultFastBase.ultFastBase = ultFastBase

function ultFastBase.setClass(customUltFastBase, actBases)
  local ret = customUltFastBase or ultFastBase
  local newParent = actBases.ult
  if newParent ~= ultBase and ret == ultFastBase then
    ret = {}
  end
  if ret ~= ultFastBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.ultFastBase = ret.ultFastBase or ret
    UtilTable.fill_table(ultFastBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function ultFastBase.new(customUltFastBase, role, _cfg)
  local ultFast = setmetatable({}, customUltFastBase)
  ultFast.base = customUltFastBase
  ultFast.type = Const.SKILL_ACTION_TYPE.ULT_FAST
  customUltFastBase:_init(ultFast, role, _cfg)
  return ultFast
end

function ultFastBase._init(customUltFastBase, ult, role, _cfg)
  ult.ultFastBase = customUltFastBase
  customUltFastBase.ultBase:_init(ult, role, _cfg)
end

function ultFastBase.isCommon()
end

function ultFastBase.isUltFast()
  return true
end

function ultFastBase.isReady(ult)
  if not ult.role.need_fast_ult then
    return false
  end
  if not ult.ultBase.isReady(ult) then
    return false
  end
  return true
end

function ultFastBase.start(ult, event)
  local role = ult.role
  role.need_fast_ult = false
  change_ult_effect(role.npc, 1)
  ult.ultMgr:onUltFastBegin(ult)
  return ult.ultBase.start(ult, event)
end

return ultFastBase
