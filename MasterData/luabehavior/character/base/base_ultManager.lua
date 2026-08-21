local ultMgr = Util.create_class()

function ultMgr.setUp(ultMgr)
  local ultMgr = ultMgr
  ultMgr.linkMgr = ComnMgr.LinkMgr
  ultMgr.tool = ComnMgr.RoleTool
  ultMgr.ultStates = {num = 0}
  ultMgr.stage = 0
  ultMgr.count = 0
  ultMgr.castRecord = {}
  ultMgr.closeUpRecord = {}
  ultMgr.isOn = false
  ultMgr.isInCloseUp = false
  ultMgr.lastCloseUpNpc = nil
  ultMgr.uiHideList = nil
  ultMgr.isComplete = false
  ultMgr.stack = {}
  do
    local ULT_CONFIG = Const.ULT_CONFIG
    ultMgr.pauseSelfMagic = ULT_CONFIG.PAUSE_ULT
    ultMgr.ultInvul = Const.ULT_INVUL
  end
end

function ultMgr.onUltBegin(mgr, ult)
  local isFirst = not ult:isUltFast()
  if isFirst then
    UtilTable.clear_map(mgr.closeUpRecord)
  end
  local role = ult.role
  mgr.count = mgr.count + 1
  table.insert(mgr.castRecord, role)
  mgr:pauseTimers()
  mgr:hideUI(ult.hideList, not isFirst)
  return mgr:incStage()
end

function ultMgr.onUltFastBegin(mgr, ultFast)
  if not mgr.isInCloseUp then
    return
  end
  local role = ultFast.role
  role:errorOutput("ultFast 在特写尚未结束时调用，冻结逻辑可能出现异常\n" .. mgr:errorMsg())
end

function ultMgr.errorMsg(mgr)
  local str = "终结技释放顺序及冻结magic状态为：\n"
  local record = mgr.castRecord
  local magic = mgr.pauseSelfMagic
  for _, member in ipairs(record) do
    str = str .. member.npc:get_name() .. ", " .. tostring(member:checkMagic(magic)) .. "\n"
  end
  str = str .. "终结技缓存顺序及冻结magic状态为：\n"
  local stack = mgr.stack
  local memeber
  for _, event in ipairs(stack) do
    memeber = event.role
    str = str .. memeber.npc:get_name() .. ", " .. tostring(memeber:checkMagic(magic)) .. "\n"
  end
  str = str .. "终结技特写顺序为及冻结magic状态为：\n"
  record = mgr.closeUpRecord
  for _, member in ipairs(record) do
    str = str .. member.npc:get_name() .. ", " .. tostring(member:checkMagic(magic)) .. "\n"
  end
  return str
end

function ultMgr.incStage(mgr)
  return mgr:setStage(mgr.stage + 1)
end

function ultMgr.clearStage(mgr)
  return mgr:setStage(0)
end

function ultMgr.setStage(mgr, stage)
  if stage < 0 then
    stage = 0
  end
  if stage > 3 then
    stage = 3
  end
  mgr.stage = stage
  mgr.isOn = 0 ~= stage
end

function ultMgr.hideUI(mgr, hideList, isHpVisible)
  local tool = mgr.tool
  tool:toggleUi(hideList, false, isHpVisible)
  mgr.uiHideList = hideList
  if not ultMgr:hasBackUlt() then
    return tool:toggleTeamHeads(false)
  end
end

function ultMgr.showUI(mgr, hideList)
  local tool = mgr.tool
  tool:toggleUi(hideList or mgr.uiHideList, true, true)
  tool:toggleTeamHeads(true)
end

function ultMgr.pauseTimers(mgr)
  set_timer_pause(true, true)
  mgr.linkMgr:pauseLinkTimer()
end

function ultMgr.tryTimers(mgr, tarAct)
  local pauseLevel, pauseLink = false, false
  if tarAct then
    pauseLevel, pauseLink = tarAct:needStopTimer()
  end
  if not pauseLevel then
    mgr.tool:tryLevelTimer()
  end
  if not pauseLink then
    mgr.linkMgr:tryLinkTimer()
  end
end

function ultMgr.onCloseUpEnd(mgr, ult)
  mgr.isInCloseUp = false
  abort_magic_by_id(ult.role.npc, mgr.pauseSelfMagic)
end

function ultMgr.onUltBefTime(mgr, ult)
  if not mgr.isInCloseUp then
    return
  end
  if mgr.lastCloseUpNpc == ult.role.npc then
    return
  end
  local npc = ult.role.npc
  return cast_magic(npc, npc, mgr.pauseSelfMagic)
end

function ultMgr.tryNextByMagic(nextUlt, caster)
  local role = nextUlt.unit
  if role.npc ~= caster then
    return
  end
  local roleAct = role.skAct
  if not roleAct:isUlt() then
    role:errorOutput("next ult magic casted out of ult, curAct is " .. roleAct.name)
    return
  end
  if role.ultMgr:popUlt() then
    role:toMelt()
  else
    roleAct:passLinkFrame()
  end
end

function ultMgr.onUltCastTime(mgr, ult)
  if mgr:hasCache() then
    return
  end
  if ult.role:isInControl() then
    mgr:showUI(ult.hideList)
  end
  mgr:tryCloseLink()
  mgr:tryTimers()
end

function ultMgr.tryCloseLink(mgr)
  local role = mgr.tool.curRole
  local roleAct = role.skAct
  if roleAct and roleAct:isUlt() and not roleAct.isCastOver and not roleAct.isOver then
    return
  end
  return mgr:closeLink()
end

function ultMgr.closeLink(mgr, isInit)
  mgr:clearStage()
  mgr.count = 0
  mgr.uiHideList = nil
  UtilTable.clear_list(mgr.castRecord)
  local stack = mgr.stack
  for _, event in ipairs(stack) do
    event.role.npc.by_ult_change = false
  end
  UtilTable.clear_map(stack)
  UtilTable.clear_map(mgr.closeUpRecord)
  local team = mgr.tool.team.role
  for _, role in pairs(team) do
    change_ult_effect(role.npc, 1)
    role.need_fast_ult = false
    role.need_ult = false
    role:abortMagic(mgr.ultInvul)
  end
end

function ultMgr.onUltBreak(mgr, ult, tarAct)
  local isCastOver = ult.isCastOver
  if tarAct and tarAct:isUlt() or tarAct:isUltEmpty() then
    if not isCastOver then
      ult.role:errorOutput("终结技在后摇以外的时间段内被新的终结技打断，", ult.name, tarAct.name)
    end
    return
  end
  if isCastOver then
    return
  end
  mgr:showUI(ult.hideList)
  mgr:tryCloseLink()
  mgr:tryTimers(tarAct)
end

function ultMgr.recordCloseUp(mgr, role)
  if not role then
    return
  end
  local record = mgr.closeUpRecord
  table.insert(record, role)
  record[role] = true
end

function ultMgr.isAllReady(mgr)
  return mgr.ultStates.num >= mgr.tool.team.num
end

function ultMgr.hasBackUlt(mgr)
  local ultStates = mgr.ultStates
  for i = 21, 22 do
    local teammate = get_scene_hero_by_poskey(i)
    local id = teammate and teammate.id
    if id and ultStates[id] then
      return true
    end
  end
end

function ultMgr.isCached(mgr, role)
  local stack = mgr.stack
  for _, event in ipairs(stack) do
    if event.role == role then
      return true
    end
  end
  return false
end

function ultMgr.hasCache(mgr)
  return #mgr.stack > 0
end

function ultMgr.isCloseUpDone(mgr, role)
  return mgr.closeUpRecord[role]
end

function ultMgr.getStage(mgr)
  return mgr.stage
end

function ultMgr.getCount(mgr)
  return mgr.count
end

function ultMgr.checkIsOn(mgr)
  return mgr.isOn
end

function ultMgr.onUltEnable(mgr, role)
  local states = mgr.ultStates
  local id = role.id
  if states[id] then
    return
  end
  local num = states.num + 1
  states.num = num
  states[id] = true
  if mgr:isAllReady() then
    mgr:on_all_ult_ready()
  end
end

function ultMgr.onUltDisable(mgr, role)
  local states = mgr.ultStates
  local id = role.id
  if not states[id] then
    return
  end
  states[id] = false
  local num = states.num - 1
  states.num = num
  if num < 0 then
    role:debugOutput("ultMgr.ultStates.num < 0 ")
    states.num = 0
  end
end

function ultMgr.on_all_ult_ready(mgr)
end

function ultMgr.reset(mgr)
  NextFrameMgr:add_next_update(mgr.doReset, mgr)
end

function ultMgr.doReset(mgr)
  if not mgr.isOn then
    mgr:closeLink(true)
  end
end

function ultMgr.cache(mgr, role, inputId)
  local stack = mgr.stack
  local event = {}
  event.role = role
  event.inputId = inputId
  table.insert(stack, event)
end

function ultMgr.tryCloseUp(mgr, role)
  if not mgr.isInCloseUp then
    return
  end
  local frontRole = mgr.tool.curRole
  if frontRole.npc == mgr.lastCloseUpNpc and frontRole.skAct.isBefOver then
    return
  end
  return mgr:startCloseUp(role)
end

function ultMgr.popCloseUp(mgr)
  local stack = mgr.stack
  for _, event in ipairs(stack) do
    mgr:startCloseUp(event.role)
  end
end

function ultMgr.startCloseUp(mgr, role)
  mgr.isInCloseUp = true
  mgr.lastCloseUpNpc = role and role.npc or get_come_on_hero()
  if not role then
    return
  end
  local ultEmpty = role.btns.ult.icon.hit:chooseSkAct()
  if not ultEmpty or not ultEmpty:isUltEmpty() then
    role:errorOutput("startCloseUp is called but ultEmpty is lost, result is " .. tostring(ultEmpty and ultEmpty.name) .. "\n" .. mgr:errorMsg())
    return
  end
  return ultEmpty:start()
end

function ultMgr.popUlt(mgr)
  local stack = mgr.stack
  local event = table.remove(stack, 1)
  if not event then
    return
  end
  local tool = mgr.tool
  local role = event.role
  if role:isInControl() then
    mgr:showUI()
    mgr:tryCloseLink()
    local skAct = role.skAct
    mgr:tryTimers(skAct)
    return role:errorOutput("调用popUlt但目标角色已经在场，请检查前置角色的tryNextUlt是否晚于castTime\n" .. mgr:errorMsg())
  end
  role.need_ult = true
  tool:changeRole(event.inputId, tool.curRole, event.role)
  role.need_ult = false
  local skAct = role.skAct
  if not skAct or not skAct:isUlt() then
    role:errorOutput("popUlt上场但上场动作不是ult，上场动作为" .. tostring(skAct and skAct.name) .. "\n" .. mgr:errorMsg())
    mgr:showUI()
    mgr:tryCloseLink()
    mgr:tryTimers(skAct)
  end
  return true
end

function ultMgr.on_destroy_mamager()
  ultMgr.tool = nil
  ultMgr.linkMgr = nil
  ultMgr.lastCloseUpNpc = nil
end

return ultMgr
