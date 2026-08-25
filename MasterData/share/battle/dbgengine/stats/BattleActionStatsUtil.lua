local bc = require("Battle.BattleConst")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local Util = {}
Util.STATE_CONCEPT_SUB_PREFIX = "统计_概念小类_"
Util.DEFAULT_STATE_CONCEPT_SUB = "未定义"
Util.stateTidToConceptSub = {}
Util.stateConceptMapInited = false

local function IsBattleActionStatsEnabled(battleEngine)
  if not battleEngine then
    return false
  end
  if battleEngine:IsServerBattle() then
    local ServerUtil = require("ServerUtil")
    if ServerUtil.GetEnv("public_server") then
      return false
    end
  end
  if not battleEngine:IsPVE() then
    return false
  end
  return true
end

function Util.RecordActionStats_Battle(battleEngine, valueCategory, valueSubCategory, value, cmdServerUid, targetRoleUid)
  if not IsBattleActionStatsEnabled(battleEngine) then
    return
  end
  if not (cmdServerUid and value) or 0 == value then
    return
  end
  local cmdServer = battleEngine:GetObj(cmdServerUid)
  if not cmdServer then
    return
  end
  local boutMgr = battleEngine.boutMgr
  local action, conceptMain, actionName = Util.__CalcBattleActionNameAndConceptMain(battleEngine, cmdServer)
  local versionStamp = battleEngine.snapshotMgr:GetVersionStamp(boutMgr:GetBoutNum() or 0)
  local baseMsg = {}
  baseMsg.bout = boutMgr:GetBoutNum() or 0
  baseMsg.actionIndex = boutMgr:GetCurActionIndex() or 0
  baseMsg.target = Util.__CalcBattleActionTarget(battleEngine, targetRoleUid)
  baseMsg.action = action
  baseMsg.actionName = actionName
  baseMsg.concept = conceptMain
  baseMsg.conceptSub = Util.__GetBehaviorConceptSub(battleEngine, cmdServer)
  baseMsg.effect = valueCategory
  baseMsg.effectSub = valueSubCategory
  baseMsg.version = versionStamp.version
  baseMsg.preVersion = versionStamp.preVersion
  if cmdServer.stateId or cmdServer.stateUid then
    Util.__RecordActionStats_Battle_State(battleEngine, cmdServer, baseMsg, value)
    return
  end
  Util.__RecordActionStats_Battle_Skill(battleEngine, cmdServer, baseMsg, value)
end

function Util.GetStatsRoleId(battleEngine, roleUid)
  local roleTid = 0
  if 0 ~= roleUid then
    local role = battleEngine:GetObj(roleUid)
    if not role then
      return
    end
    local player = role:GetPlayer()
    if not player then
      return
    end
    roleTid = roleUid == player.uid and 1 or role.tid
  end
  return roleTid
end

function Util.RecordActionStats_AddState(battleEngine, stateObj, createArgs)
  if not IsBattleActionStatsEnabled(battleEngine) then
    return
  end
  if not (battleEngine and stateObj) or not createArgs then
    return
  end
  local DT = battleEngine.battleDT
  local stateCfg = DT.State and DT.State[stateObj.stateId]
  if not stateCfg or not stateCfg.CnID then
    return
  end
  local value = createArgs.layer or 1
  if not value or 0 == value then
    return
  end
  local action, actionName, cmdServer
  local isSkillAction = false
  local isStateAction = false
  if createArgs.cmdServerUid then
    cmdServer = battleEngine:GetObj(createArgs.cmdServerUid)
  end
  if cmdServer and cmdServer.stateId then
    local cfg = DT.State[cmdServer.stateId]
    if cfg and cfg.CnID then
      action = cfg.CnID
      actionName = Util.GetConfigPlainName(battleEngine, cfg.Name, cmdServer)
      isStateAction = true
    end
  elseif cmdServer and cmdServer.skillConfigId then
    local cfg = DT.Skill[cmdServer.skillConfigId]
    if cfg and cfg.CnID then
      action = cfg.CnID
      actionName = Util.GetConfigPlainName(battleEngine, cfg.Name, cmdServer)
      isSkillAction = true
    end
  end
  if not action then
    action = stateCfg.CnID
    actionName = Util.GetConfigPlainName(battleEngine, stateCfg.Name, cmdServer)
    isStateAction = true
  end
  local boutMgr = battleEngine.boutMgr
  local targetRoleUid = stateObj.owner.uid
  local versionStamp = battleEngine.snapshotMgr:GetVersionStamp(boutMgr:GetBoutNum() or 0)
  local baseMsg = {}
  baseMsg.bout = boutMgr:GetBoutNum() or 0
  baseMsg.actionIndex = boutMgr:GetCurActionIndex() or 0
  baseMsg.target = Util.__CalcBattleActionTarget(battleEngine, targetRoleUid)
  baseMsg.action = action
  baseMsg.actionName = actionName
  baseMsg.version = versionStamp.version
  baseMsg.preVersion = versionStamp.preVersion
  if isSkillAction then
    baseMsg.concept = "行为"
    baseMsg.conceptSub = Util.__GetBehaviorConceptSub(battleEngine, cmdServer)
  elseif isStateAction then
    baseMsg.concept = "状态"
    if cmdServer then
      baseMsg.conceptSub = Util.__GetStateConceptSub(battleEngine, cmdServer)
    else
      baseMsg.conceptSub = Util.DEFAULT_STATE_CONCEPT_SUB
    end
  else
    baseMsg.concept = "未知"
    baseMsg.conceptSub = "未知"
  end
  baseMsg.effect = "施加状态"
  baseMsg.effectSub = stateCfg.CnID
  baseMsg.caster = Util.__CalcBattleActionRootOwner(battleEngine, cmdServer)
  baseMsg.value = value
  local logStr = string.format("行为统计：回合=%d 序号=%d 根归属=%s 目标=%s 操作=%s 操作名称=%s 概念大类=%s 概念小类=%s 数值大类=%s 数值小类=%s 数值=%s", baseMsg.bout or 0, baseMsg.actionIndex or 0, tostring(baseMsg.caster), tostring(baseMsg.target), tostring(baseMsg.action), tostring(baseMsg.actionName), tostring(baseMsg.concept), tostring(baseMsg.conceptSub), tostring(baseMsg.effect), tostring(baseMsg.effectSub), tostring(baseMsg.value))
  if battleEngine.LogBattleDetail then
    battleEngine:LogBattleDetail(baseMsg)
  end
end

function Util.GetConfigPlainName(battleEngine, condList, cmdServer)
  local name = ""
  if type(condList) == "table" and cmdServer then
    local matchResult
    local cmdParser = cmdServer.cmdParser
    for i = #condList, 1, -1 do
      local condCfg = condList[i]
      local cond = condCfg[1]
      if battleEngine:IsCondMatch(cmdParser, cond) then
        matchResult = condCfg[2]
        break
      end
    end
    name = matchResult
  else
    name = condList
  end
  name = name or "无"
  local plain = name:match("|(.+)$") or name
  plain = plain:match("^<(.*)>$") or plain
  plain = plain:match(".*:(.+)$") or plain
  plain = plain:gsub("^%s+", ""):gsub("%s+$", "")
  if plain and "" ~= plain then
    if plain:find("%%") then
      return "Name字段不规范"
    end
    return plain
  end
  if type(name) == "string" and name:find("%%") then
    return "Name字段不规范"
  end
  return name
end

function Util.__InitStateConceptSubMap(battleEngine)
  if Util.stateConceptMapInited then
    return
  end
  Util.stateConceptMapInited = true
  Util.stateTidToConceptSub = {}
  local battleDT = battleEngine.battleDT
  local conceptKeyStr = battleDT.BattleApi.statistic_state_concept_list.Data
  local code = "return {'" .. conceptKeyStr:gsub("%s*,%s*", "','") .. "'}"
  local conceptKeyList = load(code)()
  for _, conceptKey in ipairs(conceptKeyList) do
    local conceptCfg = battleDT.BattleApi[conceptKey]
    local name = conceptCfg.CnID
    name = name:gsub("^" .. Util.STATE_CONCEPT_SUB_PREFIX, "")
    local stateList = load("return " .. conceptCfg.Data)()
    for _, stateTid in ipairs(stateList) do
      local stateTidNumber = tonumber(stateTid)
      Util.stateTidToConceptSub[stateTidNumber] = name
    end
  end
end

function Util.__GetStateConceptSub(battleEngine, cmdServer)
  Util.__InitStateConceptSubMap(battleEngine)
  local stateTid = cmdServer.stateId
  if not stateTid and cmdServer.stateUid then
    local stateObj = battleEngine:GetObj(cmdServer.stateUid)
    if stateObj then
      stateTid = stateObj.stateId or stateObj.tid
    end
  end
  if not stateTid then
    return Util.DEFAULT_STATE_CONCEPT_SUB
  end
  return Util.stateTidToConceptSub[stateTid] or Util.DEFAULT_STATE_CONCEPT_SUB
end

function Util.__CalcBattleActionRootOwner(battleEngine, cmdServer)
  if not cmdServer or not cmdServer.castRoleUid then
    return "未知"
  end
  local caster = battleEngine:GetObj(cmdServer.castRoleUid)
  if not caster then
    return "未知"
  end
  if caster.GetBattleLogName then
    do return caster.GetBattleLogName end
    return caster.GetBattleLogName, caster
  end
  return "未知"
end

function Util.CalcStateOwnershipUidToValue(battleEngine, cmdServer, value)
  local ownershipUidToValue = {}
  if not cmdServer or not cmdServer.stateId then
    return ownershipUidToValue
  end
  local battleDT = battleEngine.battleDT
  local stateCfg = battleDT.State and battleDT.State[cmdServer.stateId]
  if not stateCfg then
    return ownershipUidToValue
  end
  if not stateCfg.Statistic or stateCfg.Statistic ~= "Enable" then
    return ownershipUidToValue
  end
  if stateCfg.StatisticOwner == "StateOwner" then
    local stateObj = cmdServer.stateUid and battleEngine:GetObj(cmdServer.stateUid)
    if not (stateObj and stateObj.owner) or not stateObj.owner.uid then
      return ownershipUidToValue
    end
    local ownerUnit = stateObj.owner
    if ownerUnit:is(BattleCardServer) then
      ownerUnit = ownerUnit:GetOwner()
    end
    ownershipUidToValue[ownerUnit.uid] = value
    return ownershipUidToValue
  end
  if stateCfg.StatisticOwner == "StateCaster" then
    local stateObj = cmdServer.stateUid and battleEngine:GetObj(cmdServer.stateUid)
    if not stateObj or not stateObj.CalculateOwnership then
      return ownershipUidToValue
    end
    local ownershipResult = stateObj:CalculateOwnership(value)
    if type(ownershipResult) ~= "table" then
      return ownershipUidToValue
    end
    for ownerUid, allocatedValue in pairs(ownershipResult) do
      if allocatedValue and 0 ~= allocatedValue then
        ownershipUidToValue[ownerUid] = (ownershipUidToValue[ownerUid] or 0) + allocatedValue
      end
    end
    return ownershipUidToValue
  end
  if stateCfg.StatisticOwner == "CmdCaster" then
    local ownerUid = cmdServer.castRoleUid
    if cmdServer.triggerData and cmdServer.triggerData.associator and next(cmdServer.triggerData.associator) then
      local associator = cmdServer.triggerData.associator[1]
      if associator and associator.uid then
        ownerUid = associator.uid
      end
    end
    if ownerUid then
      ownershipUidToValue[ownerUid] = value
    end
    return ownershipUidToValue
  end
  return ownershipUidToValue
end

function Util.__CalcBattleActionTarget(battleEngine, targetRoleUid)
  if not targetRoleUid then
    return "未知"
  end
  local target = battleEngine:GetObj(targetRoleUid)
  if not target then
    return "未知"
  end
  if target.GetBattleLogName then
    do return target.GetBattleLogName end
    return target.GetBattleLogName, target
  end
  return "未知"
end

function Util.__CalcBattleActionNameAndConceptMain(battleEngine, cmdServer)
  local battleDT = battleEngine.battleDT
  if cmdServer.skillConfigId then
    local skillCfg = battleDT.Skill[cmdServer.skillConfigId]
    local name = Util.GetConfigPlainName(battleEngine, skillCfg.Name, cmdServer)
    return skillCfg.CnID, "行为", name
  end
  if cmdServer.stateId then
    local stateCfg = battleDT.State[cmdServer.stateId]
    local name = Util.GetConfigPlainName(battleEngine, stateCfg.Name, cmdServer)
    return stateCfg.CnID, "状态", name
  end
  return "未知", "未知"
end

function Util.__GetBehaviorConceptSub(battleEngine, cmdServer)
  if cmdServer.stateId or cmdServer.stateUid then
    do return Util.__GetStateConceptSub, battleEngine end
    return Util.__GetStateConceptSub, battleEngine, cmdServer, nil, nil, nil, nil, nil, nil
  end
  local skillConfigId = cmdServer.skillConfigId
  if not skillConfigId then
    return "未知"
  end
  local battleDT = battleEngine.battleDT
  local skillCfg = battleDT.Skill[skillConfigId]
  if not skillCfg then
    return "无配置"
  end
  if 1 == cmdServer.cmdParser:IsSuperUtlSkill() then
    return "超限狂气爆发"
  end
  if cmdServer:IsAttachPost() then
    return "追击"
  end
  local slot = skillCfg.Slot
  if battleDT.CommonID[slot] and battleDT.CommonID[slot].CnID then
    local cnId = battleDT.CommonID[slot].CnID
    local suffix = cnId:match("槽位%.(.+)$")
    if suffix and suffix:startswith("衍生") then
      return "衍生"
    end
    return suffix or "其他"
  end
  if table.contains(skillCfg.Type, "Keeper_Skill") then
    return "钥令"
  end
  return "其他"
end

function Util.__RecordActionStats_Battle_Skill(battleEngine, cmdServer, baseMsg, value)
  local castRole = cmdServer.castRoleUid and battleEngine:GetObj(cmdServer.castRoleUid)
  if not castRole or castRole:GetCamp() ~= bc.BattleCamp.Camp1 then
    return
  end
  local msg = table.deepclone(baseMsg)
  msg.caster = Util.__CalcBattleActionRootOwner(battleEngine, cmdServer)
  msg.value = value
  local logStr = string.format("行为统计 ：回合=%d 序号=%d 根归属=%s 目标=%s 操作=%s 操作名称=%s 概念大类=%s 概念小类=%s 数值大类=%s 数值小类=%s 数值=%s", msg.bout or 0, msg.actionIndex or 0, tostring(msg.caster), tostring(msg.target), tostring(msg.action), tostring(msg.actionName), tostring(msg.concept), tostring(msg.conceptSub), tostring(msg.effect), tostring(msg.effectSub), tostring(msg.value))
  if battleEngine.LogBattleDetail then
    battleEngine:LogBattleDetail(msg)
  end
end

function Util.__RecordActionStats_Battle_State(battleEngine, cmdServer, baseMsg, value)
  local ownershipUidToValue = Util.CalcStateOwnershipUidToValue(battleEngine, cmdServer, value)
  if not ownershipUidToValue or not next(ownershipUidToValue) then
    return
  end
  for ownerUid, allocatedValue in pairs(ownershipUidToValue) do
    if allocatedValue > 0 then
      local ownerRole = battleEngine:GetObj(ownerUid)
      if ownerRole and ownerRole.GetCamp and ownerRole:GetCamp() == bc.BattleCamp.Camp1 then
        local msg = table.deepclone(baseMsg)
        msg.caster = ownerRole.GetBattleLogName and ownerRole:GetBattleLogName() or "未知"
        msg.value = allocatedValue
        local logStr = string.format("行为统计：回合=%d 序号=%d 根归属=%s 目标=%s 操作=%s 操作名称=%s 概念大类=%s 概念小类=%s 数值大类=%s 数值小类=%s 数值=%s", msg.bout or 0, msg.actionIndex or 0, tostring(msg.caster), tostring(msg.target), tostring(msg.action), tostring(msg.actionName), tostring(msg.concept), tostring(msg.conceptSub), tostring(msg.effect), tostring(msg.effectSub), tostring(msg.value))
        if battleEngine.LogBattleDetail then
          battleEngine:LogBattleDetail(msg)
        end
      end
    end
  end
end

return Util
