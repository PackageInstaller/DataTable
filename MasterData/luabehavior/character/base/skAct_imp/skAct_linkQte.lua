local exQteBase = import("character.base.skAct_imp.skAct_exQte")
local linkQteBase = Util.create_child_mt(exQteBase)
linkQteBase._linkQteBase = linkQteBase
linkQteBase.linkQteBase = linkQteBase

function linkQteBase.setClass(customLinkQteBase, actBases)
  local ret = customLinkQteBase or linkQteBase
  local newParent = actBases.exQte
  if newParent ~= exQteBase and ret == linkQteBase then
    ret = {}
  end
  if ret ~= linkQteBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.linkQteBase = ret.linkQteBase or ret
    UtilTable.fill_table(linkQteBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function linkQteBase.new(customLinkQteBase, role, _cfg)
  local linkQte = setmetatable({}, customLinkQteBase)
  linkQte.base = customLinkQteBase
  linkQte.type = Const.SKILL_ACTION_TYPE.LINK_QTE
  customLinkQteBase:_init(linkQte, role, _cfg)
  return linkQte
end

function linkQteBase._init(customLinkQteBase, linkQte, role, _cfg)
  linkQte.linkQteBase = customLinkQteBase
  customLinkQteBase.exQteBase:_init(linkQte, role, _cfg)
  local cfg = _cfg or {}
  local trans = linkQte.trans
  trans.prio = cfg.TransPrio or 5
  trans.inertia = cfg.TransInertia or 5
end

function linkQteBase.initCopy(linkQte, copyBase)
  linkQte.exQteBase.initCopy(linkQte, copyBase)
  copyBase.trans.disable[linkQte.name] = true
end

function linkQteBase.isLinkQte()
  return true
end

function linkQteBase.isReady(linkQte, event)
  if not linkQte.linkMgr:isQteReady(linkQte, event) then
    return false
  end
  if event and event.isSwitch then
    return linkQte.exQteBase.isReady(linkQte)
  else
    return linkQte.skActBase.isReady(linkQte)
  end
end

function linkQteBase.start(linkQte, event)
  linkQte.role:set_switch_hero_enable(false)
  linkQte.linkMgr:onQteBegin(linkQte, event)
  linkQte.exQteBase.start(linkQte, event)
end

function linkQteBase.onCastTime(linkQte, retainCache, ignoreIcon)
  linkQte.role:set_switch_hero_enable(true)
  linkQte.exQteBase.onCastTime(linkQte, retainCache, ignoreIcon)
  return linkQte.linkMgr:onQteCastTime()
end

function linkQteBase.onBreak(linkQte, tarAct)
  if not linkQte.isCastOver and (not tarAct or not tarAct:isLinkQte()) then
    linkQte.role:set_switch_hero_enable(true)
  end
  linkQte.exQteBase.onBreak(linkQte, tarAct)
  return linkQte.linkMgr:onQteBreak(linkQte, tarAct)
end

function linkQteBase.onEnd(linkQte)
  if not linkQte.isCastOver then
    linkQte.role:set_switch_hero_enable(true)
  end
  linkQte.exQteBase.onEnd(linkQte)
  return linkQte.linkMgr:onQteEnd(linkQte)
end

function linkQteBase.onStay(linkQte)
  linkQte.linkMgr:try_link_fx_by_switch(linkQte)
  return linkQte.exQteBase.onStay(linkQte)
end

function linkQteBase.needStopTimer(linkQte)
  return false, not linkQte.isCastOver and not linkQte.isOver
end

return linkQteBase
