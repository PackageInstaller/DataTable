local System = require("System.System")
local BattleEntity = require("Battle.Ecs.BattleEntity")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local BattleCmdServer = require("Battle.DbgEngine.Cmd.BattleCmdServer")
local BattleCmdParser = require("Battle.DbgEngine.Cmd.BattleCmdParser")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleStateData = require("Battle.DbgEngine.DataCenter.BattleStateData")
local TRIGGER_NUM = 6
local BP = bc.BattleProperty
local BattleStateServer, Super = System.NewClass("BattleStateServer", BattleEntity)

function BattleStateServer:ctor(owner, createArgs)
  Super.ctor(self, owner)
  self.owner = owner
  self.battleEngine = owner.battleEngine
  if createArgs.data then
    self.data = createArgs.data
    self.data.uid = self.battleEngine:GenObjUid(self, createArgs.uid)
  else
    self.data = BattleStateData.Create(createArgs)
    self.data.uid = self.battleEngine:GenObjUid(self, createArgs.uid)
  end
  self.uid = self.data.uid
  self.stateId = createArgs.stateId
  self.castRoleUid = createArgs.castRoleUid
  self.stateType = createArgs.stateType
  self.source = createArgs.source or {}
  self.properties = {}
  self.special_properties = {}
  self.skillLevel = createArgs.skillLevel or 1
  self:InitCmdParser()
  self.configData = self.battleEngine.battleDT.State[self.stateId]
  self.eventPriority = self.configData.TriggerPriority
  if self.configData.MaxLayer and not createArgs.isRecover then
    local maxLayer = math.ceil(self.cmdServer:GetValueByCmd(self.configData.MaxLayer))
    self.data.layer = math.min(maxLayer, self.data.layer)
  end
  self:InitStateParams(createArgs)
  if createArgs.createArgs then
    self.createArgs = createArgs.createArgs
  else
    self.createArgs = table.deepclone(createArgs)
  end
  self:InitTrigger()
  self:LogBattleLayer(0, self.data.layer)
end

function BattleStateServer:InitCmdParser()
  local ctorData = {
    stateUid = self.uid,
    stateId = self.stateId,
    castRoleUid = self.castRoleUid,
    skillLevel = self.skillLevel
  }
  if System.is(self.owner, BattleCardServer) then
    ctorData.cardUid = self.owner.uid
  end
  self.cmdServer = BattleCmdServer(self.battleEngine, ctorData)
end

function BattleStateServer:InitStateParams(createArgs)
  self.stateParams = {}
  if type(createArgs.stateParams) == "table" then
    for _, param in ipairs(createArgs.stateParams) do
      table.insert(self.stateParams, self.cmdServer:GetValueByCmd(param))
    end
  elseif type(createArgs.stateParams) == "string" then
    self.stateParams = self.cmdServer:GetValueListByCmd(createArgs.stateParams)
  elseif type(createArgs.stateParams) == "number" then
    self.stateParams = {
      createArgs.stateParams
    }
  end
end

function BattleStateServer:GetBuff()
  return self.configData.IsBuff
end

function BattleStateServer:LogBattleLayer(oldLayer, newLayer)
  local deltaLayer = newLayer - oldLayer
  if deltaLayer >= 0 then
    deltaLayer = "+" .. deltaLayer
  end
  self.battleEngine:LogBattleWithTab("%s 的 %s [%s] 状态层数 %s (%s -> %s)", self:GetOwnerName(), self.configData.CnID, self.uid, deltaLayer, oldLayer, newLayer)
end

function BattleStateServer:GetOwnerName()
  do return self.owner.GetBattleLogName end
  return self.owner.GetBattleLogName, self.owner
end

function BattleStateServer:Dispose()
  Super.Dispose(self)
  self:DisposeTrigger()
end

function BattleStateServer:DisposeTrigger()
  if self.layerTriggerList then
    for _, layerTrigger in ipairs(self.layerTriggerList) do
      layerTrigger:Dispose()
    end
  end
  if self.effectTriggerList then
    for _, effectTrigger in ipairs(self.effectTriggerList) do
      effectTrigger:Dispose()
    end
  end
  if self.lifeTriggerList then
    for _, lifeTrigger in ipairs(self.lifeTriggerList) do
      lifeTrigger:Dispose()
    end
  end
end

function BattleStateServer:Serialize(skipStatePorperty)
  local data = {}
  data.ownerUid = self.owner.uid
  data.roleUid = self.owner.uid
  data.stateUid = self.uid
  data.stateId = self.stateId
  data.layer = self.data.layer
  data.castRoleUid = self.castRoleUid
  data.stateType = self.stateType
  data.stateParams = table.deepclone(self.stateParams)
  data.source = table.deepclone(self.createArgs.source or {})
  data.nameArgs, data.descArgs = self:GetArgs()
  data.skillLevel = self.skillLevel
  data.skipInitProperty = skipStatePorperty
  data.isDeleted = self.isDeleted
  return data
end

function BattleStateServer:OnSnapShot()
  return {
    ownerUid = self.owner.uid,
    uid = self.uid,
    stateId = self.stateId,
    castRoleUid = self.castRoleUid,
    stateType = self.stateType,
    skillLevel = self.skillLevel,
    isDeleted = self.isDeleted,
    source = self.source,
    stateParams = self.stateParams,
    properties = self.properties,
    special_properties = self.special_properties,
    createArgs = self.createArgs,
    data = self.data
  }
end

function BattleStateServer:OnRecover(data)
  self.isDeleted = data.isDeleted
  self.properties = data.properties or {}
  self.special_properties = data.special_properties or {}
end

function BattleStateServer:GetLayer()
  return self.data.layer
end

function BattleStateServer:GetArgs()
  local nameArgs = self:GetDescArgs(self.configData.Name)
  local desc = self.configData.Desc
  desc = self.source and self.source[1] and self.source[1].sourceType == "Weapon" and self.configData.WeaponDesc or desc
  local descArgs = self:GetDescArgs(desc)
  return nameArgs, descArgs
end

function BattleStateServer:SerializeToSvr(skipInitProperty)
  local data = table.deepclone(self.createArgs) or {}
  data.stateId = self.stateId
  data.layer = self.data.layer
  data.stateType = self.stateType
  data.stateParams = table.deepclone(self.stateParams)
  data.uid = self.uid
  data.ownerData = {
    uid = self.owner.uid
  }
  if self.stateType == bc.StateType.Role then
    data.ownerData.targetType = "PlayerRole"
  elseif self.stateType == bc.StateType.Awaker then
    data.ownerData.targetType = "Awaker"
  elseif self.stateType == bc.StateType.Card then
    data.ownerData.targetType = "Card"
  end
  data.source = table.deepclone(self.createArgs.source or {})
  data.isDeleted = self.isDeleted
  data.skillLevel = self.skillLevel
  data.casterLayerList = table.deepclone(self.data.casterLayerList)
  return data
end

function BattleStateServer:CalcSpecialValue(propertyName)
  if bc.StateSpecialProperty[propertyName] and self.castRoleUid then
    local caster = self.battleEngine:GetObj(self.castRoleUid)
    if not caster then
      self.battleEngine:Error("计算属性特殊提升失败，找不到施法者", propertyName, self.castRoleUid)
      return 0
    end
    local specialValue = caster:GetProperty(bc.StateSpecialProperty[propertyName])
    if caster:IsRoleType(bc.RoleType.Awaker) and self.battleEngine:IsPVE() then
      local player = caster:GetPlayer()
      specialValue = player:GetProperty(bc.StateSpecialProperty[propertyName])
    end
    local oldSpecial = self.special_properties[propertyName]
    if not oldSpecial or specialValue > oldSpecial then
      self.special_properties[propertyName] = specialValue
    end
    return self.special_properties[propertyName] or 0
  end
  return 0
end

function BattleStateServer:ChangeOwnerProperty(propertyName, value, extraData)
  if self:IsBan() and not extraData.ignoreBan then
    return
  end
  local apiCfg = self.battleEngine.battleDT.BattleApi[propertyName]
  local isAwakerProperty = apiCfg and apiCfg.ApiType == bc.ApiType.AWAKER_ATTR
  if isAwakerProperty and self.owner:IsRoleType(bc.RoleType.Player) and self.battleEngine:IsPVE() then
    local awakerList = self.owner:GetAwakerList()
    for _, awaker in ipairs(awakerList) do
      awaker:ChangeProperty(propertyName, value, extraData)
    end
  else
    self.owner.property:ChangeProperty(propertyName, value, extraData)
  end
end

function BattleStateServer:InitProperty()
  for propertyName, valueStr in pairs(self.configData.ExistProperty or {}) do
    local k = propertyName
    local changeByLayer = false
    if string.find(valueStr, "ChangedLayer") then
      changeByLayer = true
    end
    local value = self.cmdServer:GetValueByCmd(valueStr)
    if not value then
      self.battleEngine:Error("InitProperty failed: ", self.stateId, propertyName, valueStr)
      return
    end
    local special_value = self:CalcSpecialValue(propertyName)
    value = math.ceil(value + special_value)
    if not self.createArgs.skipInitProperty then
      local extraData = {
        castRoleUid = self.castRoleUid,
        reason = bc.PropertyChangeReason.AttrModify
      }
      self:ChangeOwnerProperty(propertyName, value, extraData)
    end
    self.properties[propertyName] = {value = value, changeByLayer = changeByLayer}
    if self.owner:is(BattleCardServer) and propertyName == bc.BattleProperty.card_cost then
      local cost = self.owner:GetCurCost()
      self.battleEngine.recordMgr:OnModifyCardCost(self.owner.deck, self.owner.uid, value, cost)
    end
  end
end

function BattleStateServer:RemoveProperty(ignoreBan)
  local extraData = {
    castRoleUid = self.castRoleUid,
    reason = bc.PropertyChangeReason.AttrModify,
    ignoreBan = ignoreBan
  }
  for propertyName, info in pairs(self.properties) do
    self:ChangeOwnerProperty(propertyName, info.value * -1, extraData)
    if self.owner:is(BattleCardServer) and propertyName == bc.BattleProperty.card_cost then
      local cost = self.owner:GetCurCost()
      self.battleEngine.recordMgr:OnModifyCardCost(self.owner.deck, self.owner.uid, info.value * -1, cost)
    end
  end
end

function BattleStateServer:UpdatePropertyWhenLayerChanges(changedLayer)
  local extraData = {
    castRoleUid = self.castRoleUid,
    reason = bc.PropertyChangeReason.AttrModify
  }
  for propertyName, valueStr in pairs(self.configData.ExistProperty or {}) do
    local k = propertyName
    local addSpecialValue
    if changedLayer > 0 and bc.StateSpecialProperty[propertyName] then
      local oldSpecial = self.special_properties[propertyName]
      local specialValue = self:CalcSpecialValue(propertyName)
      addSpecialValue = math.max(0, specialValue - oldSpecial)
    end
    local info = self.properties[propertyName]
    local changedValue
    if addSpecialValue then
      changedValue = addSpecialValue
    elseif info.changeByLayer then
      changedValue = math.ceil(self.cmdServer:GetValueByCmd(valueStr))
      goto lbl_57
      goto lbl_93
      ::lbl_57::
      self:ChangeOwnerProperty(propertyName, changedValue, extraData)
      self.properties[propertyName].value = self.properties[propertyName].value + changedValue
      if self.owner:is(BattleCardServer) and propertyName == bc.BattleProperty.card_cost then
        local cost = self.owner:GetCurCost()
        self.battleEngine.recordMgr:OnModifyCardCost(self.owner.deck, self.owner.uid, changedValue, cost)
      end
    end
    ::lbl_93::
  end
end

function BattleStateServer:InitTrigger()
  self:InitLayerTrigger()
  for i = 1, TRIGGER_NUM do
    self:InitEffectTrigger(i)
  end
  self:InitLifeTrigger()
end

function BattleStateServer:GetCondition(condition)
  local cond, sub = string.gsub(condition, "%[Enemy%]", "")
  local isEnemy = false
  if 0 ~= sub then
    isEnemy = true
  end
  local params = string.split(cond, ".")
  local triggerName, triggerPara = params[1], params[2]
  local triggerCbParams = {
    triggerPara = triggerPara,
    isEnemy = isEnemy,
    triggerName = triggerName,
    triggerFullName = cond
  }
  return triggerCbParams
end

function BattleStateServer:InitLayerTrigger()
  if not self.configData.ReduceCond or self.configData.ReduceCond == "" or next(self.configData.ReduceCond) == nil then
    return
  end
  self.layerTriggerList = {}
  local triggerCallback = self.TriggerReduce
  local triggerType = bc.StateTriggerType.Layer
  for _, reduceCondition in ipairs(self.configData.ReduceCond) do
    if string.contains(reduceCondition, "BST") then
      local triggerCbParams = self:GetCondition(reduceCondition)
      local triggerClass = require("Battle.DbgEngine.State.Trigger." .. triggerCbParams.triggerName)
      table.insert(self.layerTriggerList, triggerClass(self, triggerCallback, triggerCbParams, triggerType))
    end
  end
end

function BattleStateServer:InitLifeTrigger()
  if not self.configData.ClearCond or next(self.configData.ClearCond) == nil then
    return
  end
  self.lifeTriggerList = {}
  local triggerCallback = self.TriggerLife
  local triggerType = bc.StateTriggerType.Life
  for _, clearCondition in ipairs(self.configData.ClearCond) do
    if string.contains(clearCondition, "BST") then
      local triggerCbParams = self:GetCondition(clearCondition)
      local triggerClass = require("Battle.DbgEngine.State.Trigger." .. triggerCbParams.triggerName)
      table.insert(self.lifeTriggerList, triggerClass(self, triggerCallback, triggerCbParams, triggerType))
    end
  end
end

function BattleStateServer:InitEffectTrigger(idx)
  local condKey = "TriggerCond" .. idx
  if not self.configData[condKey] or self.configData[condKey] == "" then
    return
  end
  local triggerCb = self.Trigger
  if not self.effectTriggerList then
    self.effectTriggerList = {}
  end
  local triggerType = bc.StateTriggerType.Effect
  for _, triggerCondition in ipairs(self.configData[condKey]) do
    if string.contains(triggerCondition, "BST") then
      local triggerCbParams = self:GetCondition(triggerCondition)
      triggerCbParams.idx = idx
      local triggerClass = require("Battle.DbgEngine.State.Trigger." .. triggerCbParams.triggerName)
      table.insert(self.effectTriggerList, triggerClass(self, triggerCb, triggerCbParams, triggerType))
    end
  end
end

function BattleStateServer:AfterInit()
  self:InitProperty()
end

function BattleStateServer:TriggerReduce()
  if self.owner:GetProperty(BP.monster_hide) > 0 then
    self.battleEngine:Warn("TriggerReduce : monster_hide", self.configData.CnID)
    return
  end
  if self.isDeleted then
    return
  end
  self:SubLayer(1)
end

function BattleStateServer:TriggerLife()
  if self.owner:GetProperty(BP.monster_hide) > 0 then
    self.battleEngine:Warn("TriggerLife : monster_hide", self.configData.CnID)
    return
  end
  if self.isDeleted then
    return
  end
  local ctorData = {
    stateUid = self.uid,
    stateId = self.stateId,
    skillLevel = self.skillLevel,
    castRoleUid = self:GetCasterUid()
  }
  local cmdParser = BattleCmdParser(self.battleEngine, ctorData)
  if self.configData.ClearJudgement then
    local result = cmdParser:GetValueByCmd(self.configData[self.configData.ClearJudgement])
    if not result then
      return
    end
  end
  self:LifeEnd()
end

function BattleStateServer:GetCasterUid()
  local stateCfg = self.battleEngine.battleDT.State[self.stateId]
  if stateCfg.Owner == "StateCaster" then
    return self.castRoleUid
  end
  if self.owner:is(BattleCardServer) then
    do return self.owner.GetOwnerUid end
    return self.owner.GetOwnerUid, self.owner, BattleCardServer
  end
  return self.owner.uid
end

function BattleStateServer:Trigger(triggerParams, triggerData)
  if self.owner:GetProperty(BP.monster_hide) > 0 then
    self.battleEngine:Warn("Trigger : monster_hide", self.configData.CnID)
    return
  end
  if self.isDeleted and not triggerData.ignoreDeleted then
    return
  end
  if not self.owner:is(BattleCardServer) and self.owner:IsDead() and self.configData.DeathHandling == bc.StateDeathHandling.NonWipe_ProhibitTrigger then
    return
  end
  local DT = self.battleEngine.battleDT
  if self:IsBan() then
    local allowTriggerList = string.split(DT.BattleApi.BanPVPWeaponTrigger.Data, ",")
    if not table.contains(allowTriggerList, triggerParams.triggerFullName) then
      return
    end
  end
  local idx = triggerParams.idx
  local cmdKey = "TriggerCmd" .. idx
  local targetKey = "TriggerTarget" .. idx
  local paramKey = "TriggerPara" .. idx
  local condKey = "Judgement" .. idx
  if not self.configData[cmdKey] then
    return
  end
  local cmd = tonumber(self.configData[cmdKey])
  local castRoleUid = self:GetCasterUid()
  if not self["triggerCmd" .. idx] then
    local cmdCtorData = {}
    cmdCtorData.cmdId = cmd
    cmdCtorData.stateUid = self.uid
    cmdCtorData.stateId = self.stateId
    cmdCtorData.skillLevel = self.skillLevel
    cmdCtorData.castRoleUid = castRoleUid
    cmdCtorData.configPara = self.configData[paramKey]
    cmdCtorData.isTrigger = true
    self["triggerCmd" .. idx] = BattleCmdServer(self.battleEngine, cmdCtorData)
  end
  local cmdServer = self["triggerCmd" .. idx]
  cmdServer.cmdParser:ClearMemberValues()
  cmdServer.triggerData = triggerData
  local cmdCfg = self.battleEngine.battleDT.Cmd[cmd]
  if not cmdCfg then
    self.battleEngine:Error("状态触发指令异常 读取不到指令配置", self.stateId, cmdKey, cmd)
    return
  end
  local result = true
  if self.configData[condKey] then
    result = cmdServer:CheckCondition(self.configData[condKey])
  end
  self.battleEngine:Debug("Check Trigger:", self.stateId, condKey, self.configData[condKey], result)
  if not result or 0 == result then
    self.battleEngine:LogBattleWithTab("执行指令: %s 失败", cmdCfg.CnID)
    return
  end
  local ignoreDeadStr = triggerData.ignoreDead and "是" or "否"
  self.battleEngine:LogBattleWithTab("\t创建指令: %s 等待执行 忽视对象死亡:%s", cmdCfg.CnID, ignoreDeadStr)
  if self.source and self.source[1] and self.source[1].sourceType == "Relic" then
    local relicTid = self.source[1].tid
    self.battleEngine.recordMgr:OnRelicEffect(relicTid)
  end
  local targetEffectConfig = {
    effectType = bc.BattleEffectType.BEGenerateTargets,
    cmdServer = cmdServer,
    targetType = self.configData[targetKey],
    castRoleUid = castRoleUid
  }
  self.battleEngine.effectMgr:CreateEffect(targetEffectConfig)
  local stateEffectConfig = {
    effectType = bc.BattleEffectType.BECreateSkillPhase,
    cmdServer = cmdServer,
    triggerData = triggerData
  }
  self.battleEngine.effectMgr:CreateEffect(stateEffectConfig)
  local eventData = {
    stateUid = self.uid
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.StateTriggerEnd, eventData)
end

function BattleStateServer:AddLayer(createArgs)
  local addLayer = createArgs.layer or 1
  local castRoleUid = createArgs.castRoleUid
  local oldCastRoleUid = self.castRoleUid
  self.castRoleUid = castRoleUid
  if self.createArgs then
    self.createArgs.castRoleUid = castRoleUid
  end
  local cmdCasterRoleUid = self:GetCasterUid()
  for idx = 1, TRIGGER_NUM do
    local cmdServer = self["triggerCmd" .. idx]
    if cmdServer then
      cmdServer:UpdateCasterRoleUid(cmdCasterRoleUid)
    end
  end
  local oldLayer = self.data.layer
  local maxLayer = math.ceil(self.cmdServer:GetValueByCmd(self.configData.MaxLayer))
  if maxLayer <= self.data.layer then
    if castRoleUid and castRoleUid ~= oldCastRoleUid then
      local nameArgs, descArgs = self:GetArgs()
      self.battleEngine.recordMgr:OnChangeStateLayer({
        ownerUid = self.owner.uid,
        roleUid = self.owner.uid,
        stateUid = self.uid,
        stateId = self.stateId,
        oldLayer = oldLayer,
        newLayer = self.data.layer,
        castRoleUid = self.castRoleUid,
        stateType = self.stateType,
        updateCaster = true,
        nameArgs = nameArgs,
        descArgs = descArgs
      })
    end
    return
  end
  self.data.layer = math.min(maxLayer, self.data.layer + addLayer)
  self.data.changedLayer = self.data.layer - oldLayer
  if castRoleUid and self.data.changedLayer > 0 then
    self.data.casterLayerList = self.data.casterLayerList or {}
    self.data.casterLayerList[castRoleUid] = (self.data.casterLayerList[castRoleUid] or 0) + self.data.changedLayer
  end
  local sourceType = createArgs.source and createArgs.source[1] and createArgs.source[1].sourceType
  for _, source in ipairs(self.source) do
    if source.sourceType == sourceType then
      source.layer = (source.layer or 0) + self.data.changedLayer
    end
  end
  self:UpdatePropertyWhenLayerChanges(self.data.changedLayer)
  local nameArgs, descArgs = self:GetArgs()
  self.nameArgs = nameArgs
  self.descArgs = descArgs
  local data = {
    ownerUid = self.owner.uid,
    roleUid = self.owner.uid,
    stateUid = self.uid,
    stateId = self.stateId,
    oldLayer = oldLayer,
    newLayer = self.data.layer,
    castRoleUid = self.castRoleUid,
    stateType = self.stateType,
    updateCaster = true,
    nameArgs = self.nameArgs,
    descArgs = self.descArgs
  }
  self.battleEngine.recordMgr:OnChangeStateLayer(data)
  self:LogBattleLayer(oldLayer, self.data.layer)
  if self.data.layer <= 0 then
    self:LifeEnd()
  end
end

function BattleStateServer:SubLayerBySource(sourceType, tid, camp)
  self.battleEngine:InfoS("SubLayerBySource {uid} {stateId} {sourceType} {tid}", self.uid, self.stateId, sourceType, tid)
  local layer = 0
  camp = camp or bc.BattleCamp.Camp1
  if self.source and next(self.source) then
    for _, source in ipairs(self.source) do
      local sourceCamp = source.camp or bc.BattleCamp.Camp1
      if source.sourceType == sourceType and source.tid == tid and sourceCamp == camp then
        layer = source.layer
        break
      end
    end
  end
  if layer > 0 then
    self:SubLayer(layer)
  end
end

function BattleStateServer:SubLayer(layer, casterLayer2SubValueList)
  self.battleEngine:DebugS("SubLayer {uid} {stateId} {layer}", self.uid, self.stateId, layer)
  local oldLayer = self.data.layer
  self.data.layer = math.max(0, self.data.layer - layer)
  local nameArgs, descArgs = self:GetArgs()
  self.nameArgs = nameArgs
  self.descArgs = descArgs
  local data = {
    ownerUid = self.owner.uid,
    roleUid = self.owner.uid,
    stateUid = self.uid,
    stateId = self.stateId,
    oldLayer = oldLayer,
    newLayer = self.data.layer,
    castRoleUid = self.castRoleUid,
    stateType = self.stateType,
    updateCaster = false,
    nameArgs = self.nameArgs,
    descArgs = self.descArgs
  }
  self.data.changedLayer = self.data.layer - oldLayer
  self:UpdatePropertyWhenLayerChanges(self.data.changedLayer)
  if self.data.changedLayer < 0 and self.data.casterLayerList then
    self:_ReduceCasterLayers(-self.data.changedLayer, casterLayer2SubValueList)
  end
  self.battleEngine.recordMgr:OnChangeStateLayer(data)
  self:LogBattleLayer(oldLayer, self.data.layer)
  if self.data.layer <= 0 then
    self:LifeEnd()
  end
end

function BattleStateServer:LifeEnd(showText)
  if self.isDeleted then
    return
  end
  self.isDeleted = true
  if self.battleEngine.stateMgr:IsTeamUniqueState(self.stateId) then
    self.battleEngine.roleMgr:RemoveUniqueStateRole(self.owner.camp, self.stateId, self.uid)
  end
  self:RemoveProperty()
  self.battleEngine.recordMgr:OnDelState(self.owner.uid, self.uid, self.stateType, showText)
  local ownerName = self.owner:GetBattleLogName()
  self.battleEngine:LogBattleWithTab("%s 的 %s [%s] 层数移除", ownerName, self.configData.CnID, self.uid)
  local eventData = {
    stateUid = self.uid
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.StateLifeEnd, eventData)
end

function BattleStateServer:GetType()
  return self.configData.IsBuff
end

function BattleStateServer:GetBaseArgs()
  local stateCfg = self.battleEngine.battleDT.State[self.stateId]
  local baseArgs = {}
  for i, v in ipairs(self.stateParams) do
    baseArgs["StateArg" .. i] = v
  end
  if stateCfg.DescPara and next(stateCfg.DescPara) ~= nil then
    local descParas = self.cmdServer.cmdParser:GetValueByCmdList(stateCfg.DescPara)
    for i, v in ipairs(descParas) do
      baseArgs["DescArg" .. i] = v
    end
  end
  baseArgs.Layer = self.data.layer
  return baseArgs
end

function BattleStateServer:GetDescArgs(desc)
  if not desc then
    return
  end
  local baseArgs = self:GetBaseArgs()
  local descArgs = {
    curValues = {},
    baseValues = {}
  }
  for valueStr in string.gmatch(desc, "%b[]") do
    valueStr = string.match(valueStr, "%[(.+)]")
    local subStrs = string.split(valueStr, ":")
    local tagStr = #subStrs > 1 and subStrs[1] or nil
    local argName = subStrs[#subStrs]
    local value = baseArgs[argName] or 0
    if "Float" ~= tagStr then
      value = math.ceil(value)
    end
    local curValue, baseValue = value, value
    if "Damage" == tagStr then
      curValue, baseValue = self.cmdServer:__GetShowDamage(value)
    elseif "Block" == tagStr then
      curValue, baseValue = self.cmdServer:__GetShowBlock(value)
    elseif "Energy" == tagStr then
      curValue, baseValue = self.cmdServer:__GetShowUltiEnergy(value)
    elseif "Heal" == tagStr then
      curValue, baseValue = self.cmdServer:__GetShowHeal(value)
    elseif "Blood" == tagStr then
      curValue, baseValue = self.cmdServer:GetShowScarletBlood(baseValue)
    elseif "AttackTimes" == tagStr then
      curValue, baseValue = self.cmdServer:__GetAttackTimes(value)
    elseif "Poison" == tagStr then
      curValue, baseValue = self.cmdServer:__GetShowPoison(value)
    elseif "Counterattack" == tagStr then
      curValue, baseValue = self.cmdServer:__GetShowCounterattack(value)
    elseif "Exhaustion" == tagStr then
      curValue, baseValue = self.cmdServer:__GetShowExhaustion(value)
    elseif "Power" == tagStr then
      curValue, baseValue = self.cmdServer:__GetShowPower(value)
    elseif "TentaclePower" == tagStr then
      curValue, baseValue = self.cmdServer:__GetShowTentacle(value)
    elseif "Bleed" == tagStr then
      curValue, baseValue = self.cmdServer:__GetShowBleed(value)
    end
    table.insert(descArgs.curValues, curValue)
    table.insert(descArgs.baseValues, baseValue)
  end
  return descArgs
end

function BattleStateServer:UpdateStateArgs()
  local nameArgs, descArgs = self:GetArgs()
  if (not nameArgs or next(nameArgs.curValues) == nil) and (not descArgs or next(descArgs.curValues) == nil) then
    return
  end
  self.nameArgs = nameArgs
  self.descArgs = descArgs
  local data = {
    nameArgs = self.nameArgs,
    descArgs = self.descArgs
  }
  return data
end

function BattleStateServer:IsBan()
  if self.configData.TypeLabel ~= "WeaponState" then
    return false
  end
  local ban = self.owner:GetProperty(BP.ban_pvp_weapon)
  if ban and ban > 0 then
    return true
  end
  return false
end

function BattleStateServer:BanPropertyAndTrigger(action)
  if action == bc.BanPVPWeaponAction.Ban then
    do return self.BanPropertyAndTrigger_Ban end
    return self.BanPropertyAndTrigger_Ban, self
  end
  if action == bc.BanPVPWeaponAction.Release then
    do return self.BanPropertyAndTrigger_Release end
    return self.BanPropertyAndTrigger_Release, self
  end
end

function BattleStateServer:BanPropertyAndTrigger_Ban()
  local stateCfg = self.battleEngine.battleDT.State[self.stateId]
  self.battleEngine:LogBattleWithTab("状态 %s [%s] 被禁用", stateCfg.CnID, self.uid)
  self:RemoveProperty(true)
end

function BattleStateServer:BanPropertyAndTrigger_Release()
  local stateCfg = self.battleEngine.battleDT.State[self.stateId]
  self.battleEngine:LogBattleWithTab("状态 %s [%s] 解除禁用", stateCfg.CnID, self.uid)
  local extraData = {
    castRoleUid = self.castRoleUid,
    reason = bc.PropertyChangeReason.AttrModify
  }
  for propertyName, info in pairs(self.properties) do
    self:ChangeOwnerProperty(propertyName, info.value, extraData)
  end
end

function BattleStateServer:CalculateOwnership(value)
  local totalLayers = self:GetLayer()
  if totalLayers <= 0 or 0 == value then
    return {}
  end
  local result = {}
  for uid, layers in pairs(self.data.casterLayerList or {}) do
    if layers > 0 then
      result[uid] = math.floor(value * layers / totalLayers)
    end
  end
  return result
end

function BattleStateServer:_ReduceCasterLayers(deltaLayer, casterLayer2SubValueList)
  if casterLayer2SubValueList and next(casterLayer2SubValueList) then
    for uid, layers in pairs(casterLayer2SubValueList) do
      if layers > 0 and self.data.casterLayerList and self.data.casterLayerList[uid] then
        self.data.casterLayerList[uid] = math.max(0, self.data.casterLayerList[uid] - layers)
      end
    end
    return
  end
  local newMap = {}
  local totalReduction = 0
  local casters = {}
  local oldTotalLayer = self.data.layer + deltaLayer
  for uid, layers in pairs(self.data.casterLayerList) do
    if layers > 0 then
      table.insert(casters, {uid = uid, layers = layers})
    end
  end
  for i = 1, #casters do
    local uid = casters[i].uid
    local layers = casters[i].layers
    local reduction
    if i < #casters then
      reduction = math.floor(deltaLayer * layers / oldTotalLayer)
      totalReduction = totalReduction + reduction
    else
      reduction = deltaLayer - totalReduction
    end
    newMap[uid] = math.max(0, layers - reduction)
  end
  self.data.casterLayerList = newMap
end

return BattleStateServer
