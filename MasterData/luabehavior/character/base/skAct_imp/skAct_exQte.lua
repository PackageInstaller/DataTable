local qteBase = import("character.base.skAct_imp.skAct_qte")
local exQteBase = Util.create_child_mt(qteBase)
exQteBase._exQteBase = exQteBase
exQteBase.exQteBase = exQteBase

function exQteBase.setClass(customExQteBase, actBases)
  local ret = customExQteBase or exQteBase
  local newParent = actBases.qte
  if newParent ~= qteBase and ret == exQteBase then
    ret = {}
  end
  if ret ~= exQteBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.exQteBase = ret.exQteBase or ret
    UtilTable.fill_table(exQteBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function exQteBase.new(customExQteBase, role, _cfg)
  local exQte = setmetatable({}, customExQteBase)
  exQte.base = customExQteBase
  exQte.type = Const.SKILL_ACTION_TYPE.EX_QTE
  customExQteBase:_init(exQte, role, _cfg)
  return exQte
end

function exQteBase._init(customExQteBase, exQte, role, _cfg)
  exQte.qteBase = customExQteBase
  customExQteBase.qteBase:_init(exQte, role, _cfg)
  local cfg = _cfg or {}
  local trans = exQte.trans
  trans.prio = cfg.TransPrio or 5
  trans.inertia = cfg.TransInertia or 5
end

function exQteBase.isExQte()
  return true
end

function exQteBase.showUpPos(exQte)
  local role = exQte.role
  if role.target then
    return exQte.qteMgr.showUpPos_byTarget(exQte)
  else
    return exQte.qteMgr.showUpPos_byRole(exQte)
  end
end

return exQteBase
