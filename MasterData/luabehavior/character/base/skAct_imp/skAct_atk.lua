local skActBase = import("character.base.base_role_skillAction")
local atkBase = Util.create_child_mt(skActBase)
atkBase._atkBase = atkBase
atkBase.atkBase = atkBase

function atkBase.setClass(customAtkBase, actBases)
  local ret = customAtkBase or atkBase
  local newParent = actBases.common
  if newParent ~= skActBase and ret == atkBase then
    ret = {}
  end
  if ret ~= atkBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.atkBase = ret.atkBase or ret
    UtilTable.fill_table(atkBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function atkBase.new(customAtkBase, role, _cfg)
  local act = setmetatable({}, customAtkBase)
  act.base = customAtkBase
  act.type = Const.SKILL_ACTION_TYPE.ATK
  customAtkBase:_init(act, role, _cfg)
  return act
end

function atkBase._init(customAtkBase, atk, role, _cfg)
  atk.atkBase = customAtkBase
  customAtkBase.skActBase:_init(atk, role, _cfg)
  local cfg = _cfg or {}
  local trans = atk.trans
  trans.prio = cfg.TransPrio or 1
  trans.inertia = cfg.TransInertia or 1
end

function atkBase.isCommon()
end

function atkBase.isAtk()
  return true
end

return atkBase
