local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleEntity = require("Battle.Ecs.BattleEntity")
local BattleCmdServer = require("Battle.DbgEngine.Cmd.BattleCmdServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattlePropertyServer = require("Battle.DbgEngine.BattlePropertyServer")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local BattleCardData = require("Battle.DbgEngine.DataCenter.BattleCardData")
local BattleCmdParser = require("Battle.DbgEngine.Cmd.BattleCmdParser")
local BP = bc.BattleProperty
local BattleCardServer, Super = System.NewClass("BattleCardServer", BattleEntity)

function BattleCardServer:ctor(battleEngine, config)
  Super.ctor(self)
  self.battleEngine = battleEngine
  if config.data then
    self.data = config.data
    self.data.uid = battleEngine:GenObjUid(self, config.uid)
  else
    self.data = BattleCardData.Create(config)
    self.data.uid = battleEngine:GenObjUid(self, config.uid)
  end
  if config.cardTypes then
    self.data.cardTypes = table.clone(config.cardTypes)
  end
  self.uid = self.data.uid
  self.tid = self.data.tid
  self.srcLevel = config.level
  self.level = config.level
  self.isOrigin = config.isOrigin
  self.property = self:AddBattleComponent(BattlePropertyServer, config.properties or {})
  self.camp = config.camp
  self.createCardArgs = config.cardArgs or {}
  self.enternal = config.enternal or bc.CardEnternalType.None
  if config.specialOwnerUid and config.specialOwnerUid > 0 then
    self.specialOwner = self.battleEngine:GetObj(config.specialOwnerUid)
  else
    self.specialOwner = config.owner
  end
  if not self.battleEngine.recovering then
    self:DoInitNotRecovering(config)
  end
end

function BattleCardServer:DoInitNotRecovering(config)
  local skipInitState = config.skipInitState
  if config.stateUids and config.stateUids[0] and next(config.stateUids[0]) ~= nil or config.stateList and nil ~= next(config.stateList) then
    skipInitState = true
  end
  self:InitByConfigId(config.tid, skipInitState)
  if skipInitState and config.stateList then
    for _, stateData in ipairs(config.stateList) do
      if stateData.isDeleted then
      else
        local args = {
          stateId = stateData.stateId,
          castRoleUid = self.owner and self.owner.uid,
          layer = stateData.layer,
          stateParams = stateData.stateParams,
          skipOnAdd = stateData.skipOnAdd,
          skillLevel = self.level,
          skipInitProperty = stateData.skipInitProperty,
          source = stateData.source
        }
        self.battleEngine.stateMgr:CreateState(self, args)
      end
    end
  end
  local changeData = {
    changeReason = bc.CardDeckReason.Init
  }
  self:ChangeCardDeck(config.deck or bc.CardDeck.NoneDeck, changeData)
end

function BattleCardServer:InitOwner()
  local roleMgr = self.battleEngine.roleMgr
  local player = roleMgr:GetPlayer(self.camp)
  if self.configData.AwakerID then
    if self.specialOwner then
      self.owner = self.specialOwner
    else
      local awaker = roleMgr:GetAwakerByTid(self.configData.AwakerID, self.camp)
      if not awaker and self.data.fromCardUid then
        local card = self.battleEngine.cardMgr:GetCardByUid(self.data.fromCardUid)
        if card then
          awaker = card.owner
          self.data.performSkillId = card.data.performSkillId
        end
      end
      self.owner = awaker or player
    end
  else
    self.owner = player
  end
end

function BattleCardServer:InitByConfigId(tid, skipInitState)
  self.configData = self.battleEngine.battleDT.Skill[tid]
  if not self.configData then
    error("no card" .. tid)
  end
  self.data.tid = tid
  self.tid = tid
  self:InitOwner()
  local castRoleUid = self.owner.uid
  local cfgCost = self:GetCfgCost()
  local cost
  if BattleUtilServer.IsVariableCostCfg(cfgCost) then
    cost = bc.VariableCostSentinel
  else
    cost = tonumber(cfgCost)
  end
  if cost then
    local extraData = {
      castRoleUid = castRoleUid,
      reason = bc.PropertyChangeReason.AttrModify
    }
    self.property:SetProperty(BP.card_origin_cost, cost, extraData)
  end
  self:InitCmdServer()
  if not skipInitState then
    local stateParams = self.cmdServer:GetSkillConfigTQList("StatePara") or {}
    local existStates = self.cmdServer:GetSkillConfigTQList("ExistState") or {}
    local stateLayer = self.cmdServer:GetSkillConfigTQList("StateLayer") or {}
    local sp = {}
    for _, param in ipairs(stateParams) do
      table.insert(sp, math.ceil(self.cmdServer:GetValueByCmd(param)))
    end
    for i, stateId in ipairs(existStates or {}) do
      local addLayer = stateLayer[i] or 1
      local createArgs = {
        stateId = stateId,
        castRoleUid = castRoleUid,
        stateParams = sp,
        skillLevel = self.level,
        layer = addLayer,
        source = {
          {
            tid = self.tid,
            sourceType = "ExistState",
            layer = addLayer
          }
        }
      }
      self.battleEngine.stateMgr:CreateState(self, createArgs)
    end
  end
  self:UpdateCardArgs()
end

function BattleCardServer:InitCmdServer()
  local tid = self.data.tid
  local castRoleUid = self.owner.uid
  local preCmdId = self:GetPreCmdId()
  if preCmdId then
    local cmdCtorData = {}
    cmdCtorData.skillLevel = self.level
    cmdCtorData.skillConfigId = tid
    cmdCtorData.cmdId = preCmdId
    cmdCtorData.cardUid = self.uid
    cmdCtorData.isPreCmd = true
    cmdCtorData.castRoleUid = castRoleUid
    cmdCtorData.createCardArgs = table.deepclone(self.createCardArgs)
    self.preCmdServer = BattleCmdServer(self.battleEngine, cmdCtorData)
  end
  local cmdCtorData = {}
  cmdCtorData.skillLevel = self.level
  cmdCtorData.skillConfigId = tid
  cmdCtorData.cmdId = self:GetCmdId()
  cmdCtorData.cardUid = self.uid
  cmdCtorData.castRoleUid = castRoleUid
  cmdCtorData.createCardArgs = table.deepclone(self.createCardArgs)
  self.cmdServer = BattleCmdServer(self.battleEngine, cmdCtorData)
  self.cmdServer:GetSkillArgs()
end

function BattleCardServer:Serialize(skipStatePorperty)
  local stateList = {}
  local list = self.battleEngine.stateMgr:GetStateListByOwnerUid(self.uid)
  for _, state in ipairs(list) do
    table.insert(stateList, state:Serialize(skipStatePorperty))
  end
  local data = {
    uid = self.uid,
    tid = self.data.tid,
    configId = self.data.tid,
    deck = self.deck,
    runes = self.data.runes,
    cardArgs = self.cardArgs,
    descArgs = self.descArgs,
    createCardArgs = self.createCardArgs,
    cost = self:GetCurCost(),
    stateList = stateList,
    level = self.level,
    properties = self.property:Serialize(),
    camp = self.camp,
    ownerUid = self.owner.uid,
    composeCardUids = self.data.composeCardUids,
    randomseed = self.data.randomseed,
    performSkillId = self.data.performSkillId,
    specialOwnerUid = self.specialOwner and self.specialOwner.uid or nil,
    enternal = self.enternal or bc.CardEnternalType.None
  }
  return data
end

function BattleCardServer:OnSnapShot()
  return {
    uid = self.uid,
    tid = self.data.tid,
    configId = self.data.tid,
    deck = self.deck,
    level = self.level,
    isOrigin = self.isOrigin,
    properties = self.property:Serialize(),
    camp = self.camp,
    ownerUid = self.owner.uid,
    specialOwnerUid = self.specialOwner and self.specialOwner.uid,
    shuffled = self.shuffled,
    enternal = self.enternal or bc.CardEnternalType.None,
    cardArgs = self.createCardArgs,
    stateList = nil,
    skipInitState = true,
    data = self.data
  }
end

function BattleCardServer:OnRecover(data)
  self.configData = self.battleEngine.battleDT.Skill[self.data.tid]
  self.owner = self.battleEngine:GetObj(data.ownerUid)
  self.deck = data.deck
  self.shuffled = data.shuffled
  self.enternal = data.enternal or bc.CardEnternalType.None
  self:InitCmdServer()
  self:UpdateCardArgs()
end

function BattleCardServer:GetFixedCost()
  if self:IsXCost() then
    return nil
  end
  do return bc.GetActiveCardFixedCost end
  return bc.GetActiveCardFixedCost, function(propertyName)
    do return self.GetProperty, self end
    return self.GetProperty, self, propertyName
  end
end

function BattleCardServer:GetCostDelta()
  local cardCostDelta = self:GetProperty(BP.card_cost) or 0
  local awakerCostFix = 0
  local cardTypes = self:GetType()
  local battleUnit = self.owner
  if battleUnit:IsRoleType(bc.RoleType.Awaker) then
    for _, cardType in ipairs(cardTypes) do
      local fixAttrName = bc.CardType2Fix[cardType]
      if fixAttrName then
        awakerCostFix = awakerCostFix + (battleUnit:GetProperty(fixAttrName) or 0)
      end
    end
    if self:IsCmdCard() then
      awakerCostFix = awakerCostFix + (battleUnit:GetProperty(BP.awaker_card_cost_fix) or 0)
    end
    local matchSkillType = true
    local limitSkillTypes = {
      bc.SkillType.Card_Strike,
      bc.SkillType.Card_Defend,
      bc.SkillType.Card_Skill
    }
    for _, cardType in ipairs(cardTypes) do
      if not table.contains(limitSkillTypes, cardType) then
        matchSkillType = false
        break
      end
    end
    if matchSkillType then
      awakerCostFix = awakerCostFix + (battleUnit:GetProperty(BP.awaker_cmdcard_notextend_cost_fix) or 0)
    end
  end
  return cardCostDelta + awakerCostFix
end

function BattleCardServer:GetCostHarmonize()
  local costHarmonize = 0
  local battleUnit = self.owner
  if battleUnit:IsRoleType(bc.RoleType.Awaker) then
    if self:IsCmdCard() then
      costHarmonize = costHarmonize + (battleUnit:GetProperty(BP.Awaker_slow_cmd_card_cost_fix) or 0)
    end
    costHarmonize = costHarmonize + (battleUnit:GetProperty(BP.Awaker_slow_card_cost_fix) or 0)
  end
  return costHarmonize
end

function BattleCardServer:GetBaseCost()
  if self:CardTypeMatch(bc.SkillType.Keeper_Skill) then
    return self:GetHandKeeperCost() or 0
  end
  local fixedCost = self:GetFixedCost()
  if nil ~= fixedCost then
    return fixedCost
  end
  local cfgCost = self:GetCfgCost()
  if not cfgCost then
    return 0
  end
  if self:IsXCost() then
    return bc.VariableCostSentinel
  end
  local originCost = self:GetProperty(BP.card_origin_cost) or 0
  do return math.max, 0 end
  return math.max, 0, originCost + self:GetCostDelta(), self
end

function BattleCardServer:GetCurCost()
  do return self.GetBaseCost end
  return self.GetBaseCost, self
end

function BattleCardServer:GetHandKeeperCost()
  if not self:CardTypeMatch(bc.SkillType.Keeper_Skill) then
    return nil
  end
  local handKeeperSkillParam = self.data.handKeeperSkillParam
  if handKeeperSkillParam and handKeeperSkillParam.handKeeperFree then
    return 0
  end
  local player = self:GetPlayer()
  if not player or not player.GetKeeperSkillCost then
    return 0
  end
  do return player.GetKeeperSkillCost end
  return player.GetKeeperSkillCost, player
end

function BattleCardServer:SetupHandKeeperData(handKeeperSkillParam, castRoleUid)
  self.data.handKeeperSkillParam = handKeeperSkillParam
  local originCost = self:GetHandKeeperCost() or 0
  local extraData = {
    castRoleUid = castRoleUid or self.owner and self.owner.uid,
    reason = bc.PropertyChangeReason.AttrModify
  }
  self.property:SetProperty(BP.card_origin_cost, originCost, extraData)
  if (handKeeperSkillParam.handKeeperCountAfter or 0) > 0 then
    self.property:SetProperty(BP.keeper_skill_card_add_times_on_use, handKeeperSkillParam.handKeeperCountAfter, extraData)
  end
end

function BattleCardServer:GetCardAffixesIdList()
  return {}
end

function BattleCardServer:Dispose()
  local stateList = self.battleEngine.stateMgr:GetStateListByOwnerUid(self.uid)
  Super.Dispose(self)
  self.battleEngine:UnregisterAllEventsByTarget(self)
  for _, state in ipairs(stateList) do
    state:LifeEnd()
  end
end

function BattleCardServer:AddRune(enchantId)
  if not enchantId or enchantId <= 0 then
    return
  end
  if not self.data.runes then
    self.data.runes = {}
  end
  table.insert(self.data.runes, enchantId)
end

function BattleCardServer:GetConfigData()
  return self.configData
end

function BattleCardServer:UpdateCardArgs()
  local cfgCost = self:GetCfgCost()
  local castRoleUid = self.owner.uid
  if not self:IsXCost() and cfgCost and not tonumber(cfgCost) then
    local cost = self.cmdServer:GetValueByCmd(cfgCost)
    local extraData = {
      castRoleUid = castRoleUid,
      reason = bc.PropertyChangeReason.AttrModify
    }
    self.property:SetProperty(BP.card_origin_cost, cost, extraData)
  end
  local cardArgs, descArgs = self.cmdServer:GetSkillArgs()
  if not self.cardArgs then
    self.cardArgs = cardArgs
    self.descArgs = descArgs
  else
    for index, value in ipairs(cardArgs) do
      if value ~= self.cardArgs[index] then
        self.cardArgs = cardArgs
        self.descArgs = descArgs
      end
    end
    for index, value in ipairs(descArgs.curValues) do
      if value ~= self.descArgs.curValues[index] then
        self.cardArgs = cardArgs
        self.descArgs = descArgs
      end
    end
    for index, value in ipairs(descArgs.baseValues) do
      if value ~= self.descArgs.baseValues[index] then
        self.cardArgs = cardArgs
        self.descArgs = descArgs
      end
    end
  end
  return self.cardArgs, self.descArgs
end

function BattleCardServer:GetVariableCostMode()
  do return BattleUtilServer.ParseVariableCost, self:GetCfgCost() end
  return BattleUtilServer.ParseVariableCost, self:GetCfgCost()
end

function BattleCardServer:IsXCost()
  local mode = self:GetVariableCostMode()
  return mode ~= bc.VariableCostMode.None
end

function BattleCardServer:ResolveVariableConsumeCost(energy)
  energy = energy or 0
  local mode, limit = self:GetVariableCostMode()
  if mode == bc.VariableCostMode.BurnAll then
    return energy
  end
  if mode == bc.VariableCostMode.Limit then
    do return math.min, limit end
    return math.min, limit, energy
  end
  return nil
end

function BattleCardServer:IsNoCost()
  local cfgCost = self:GetCfgCost()
  if not cfgCost then
    return true
  end
  return false
end

function BattleCardServer:JudgeCost()
  if self.battleEngine:IsPVE() and self:IsNoCost() then
    return false
  end
  return true
end

function BattleCardServer:GetNeedBreakThroughAndPotency(btConfig)
  if not self.configData.AwakerID then
    return 0
  end
  local awaker = self:GetOwnerAwaker()
  if not awaker then
    return 0
  end
  local breakSkillLevel, potencyLevel = awaker:GetBreakSkillAndPotencyLevel()
  do return BattleUtilServer.GetMatchTQ, btConfig, breakSkillLevel end
  return BattleUtilServer.GetMatchTQ, btConfig, breakSkillLevel, potencyLevel
end

function BattleCardServer:GetBreakAndPotency()
  local breakSkillLevel, potencyLevel = 0, 0
  local awaker = self:GetOwnerAwaker()
  if awaker then
    breakSkillLevel, potencyLevel = awaker:GetBreakSkillAndPotencyLevel()
  end
  return breakSkillLevel, potencyLevel
end

function BattleCardServer:GetCfgCost()
  local breakSkillLevel, potencyLevel = self:GetBreakAndPotency()
  do return BattleUtilServer.GetTQText, self.configData.Cost, breakSkillLevel end
  return BattleUtilServer.GetTQText, self.configData.Cost, breakSkillLevel, potencyLevel
end

function BattleCardServer:CardTypeMatch(cardTypes)
  if type(cardTypes) ~= "table" then
    cardTypes = {cardTypes}
  end
  local myTypes = self:GetType()
  for _, cardType in ipairs(cardTypes) do
    if table.contains(myTypes, cardType) then
      return true
    end
  end
  return false
end

function BattleCardServer:CardTagMatch(cardTags)
  if type(cardTags) ~= "table" then
    cardTags = {cardTags}
  end
  local breakSkillLevel, potencyLevel = self:GetBreakAndPotency()
  local myTags = BattleUtilServer.GetTQList(self.configData.SkillTag, breakSkillLevel, potencyLevel) or {}
  for _, cardTag in ipairs(cardTags) do
    if table.contains(myTags, cardTag) then
      return true
    end
  end
  return false
end

function BattleCardServer:GetType()
  if self.data.cardTypes then
    return self.data.cardTypes
  end
  local breakSkillLevel, potencyLevel = self:GetBreakAndPotency()
  local cardTypes = BattleUtilServer.GetTQList(self.configData.Type, breakSkillLevel, potencyLevel) or {}
  if type(cardTypes) ~= "table" then
    cardTypes = {cardTypes}
  end
  cardTypes = table.clone(cardTypes)
  local cardTypeFix = self:GetProperty(BP.card_type_strike)
  if cardTypeFix and cardTypeFix > 0 and not table.contains(cardTypes, bc.SkillType.Card_Strike) then
    table.insert(cardTypes, bc.SkillType.Card_Strike)
  end
  if self:IsFromAttachPost() and not table.contains(cardTypes, bc.SkillType.Card_AttachPost) then
    table.insert(cardTypes, bc.SkillType.Card_AttachPost)
  end
  return cardTypes
end

function BattleCardServer:GetSkillSlot()
  if self.configData then
    return self.configData.Slot
  end
end

function BattleCardServer:GetCmdId()
  if self.configData.IsPVP then
    local ctorData = {
      castRoleUid = self.owner.uid,
      skillConfigId = self:GetID(),
      skillLevel = self.level
    }
    do return self.battleEngine.GetValByCondList, self.battleEngine, ctorData, (self:GetID()) end
    return self.battleEngine.GetValByCondList, self.battleEngine, ctorData, self:GetID(), "CmdList"
  end
  local breakSkillLevel, potencyLevel = self:GetBreakAndPotency()
  local ret = BattleUtilServer.GetTQText(self.configData.CmdList, breakSkillLevel, potencyLevel)
  if not ret then
    return
  end
  do return tonumber end
  return tonumber, ret, potencyLevel
end

function BattleCardServer:GetPreCmdId()
  local breakSkillLevel, potencyLevel = self:GetBreakAndPotency()
  local ret = BattleUtilServer.GetTQText(self.configData.PreCmd, breakSkillLevel, potencyLevel)
  if not ret then
    return
  end
  do return tonumber end
  return tonumber, ret, potencyLevel
end

function BattleCardServer:IsCmdCard()
  local cardTypes = self:GetType()
  for _, cardType in ipairs(cardTypes or {}) do
    if cardType == bc.SkillType.Card_Strike or cardType == bc.SkillType.Card_Defend or cardType == bc.SkillType.Card_Extend or cardType == bc.SkillType.Card_Skill then
      return true
    end
  end
  return false
end

function BattleCardServer:GetUseCost()
  if self:CardTypeMatch(bc.SkillType.Keeper_Skill) then
    return self:GetHandKeeperCost() or 0
  end
  if self.battleEngine:IsPVP() and self:IsNoCost() and self:GetFixedCost() == nil then
    return 0
  end
  local baseCost = self:GetBaseCost()
  if baseCost == bc.VariableCostSentinel then
    return bc.VariableCostSentinel
  end
  do return math.max, 0 end
  return math.max, 0, baseCost + self:GetCostHarmonize(), self
end

function BattleCardServer:ResetAllowIgnoreCost()
  self.allowIgnoreCost = 0
  self.battleEngine:DebugS("ResetAllowIgnoreCost {cardTid}", self.tid)
end

function BattleCardServer:AllowIgnoreCost()
  self:ResetAllowIgnoreCost()
  local breakSkillLevel, potencyLevel = self:GetBreakAndPotency()
  local allowIgnoreCostList = BattleUtilServer.GetTQList(self.configData.AllowIgnoreCost, breakSkillLevel, potencyLevel) or {}
  local cfgAllowIgnoreCost = allowIgnoreCostList and allowIgnoreCostList[1]
  if not cfgAllowIgnoreCost then
    self.battleEngine:InfoS("AllowIgnoreCost no tq type {cfg}", table.tostring(self.configData.AllowIgnoreCost))
    if self.configData.AllowIgnoreCost and "table" == type(self.configData.AllowIgnoreCost) and self.configData.AllowIgnoreCost[1] and 1 == self.configData.AllowIgnoreCost[1] then
      cfgAllowIgnoreCost = 1
    end
  end
  self.battleEngine:InfoS("AllowIgnoreCost {cfgAllowIgnoreCost}", table.tostring(cfgAllowIgnoreCost))
  if not cfgAllowIgnoreCost then
    return false
  end
  if 1 == cfgAllowIgnoreCost then
    self.allowIgnoreCost = 1
  elseif type(cfgAllowIgnoreCost) == "string" and self.cmdServer:GetValueByCmd(cfgAllowIgnoreCost) then
    self.allowIgnoreCost = 1
  end
  self.battleEngine:InfoS("AllowIgnoreCost {allowIgnoreCost}", table.tostring(self.allowIgnoreCost))
  return self.allowIgnoreCost and 1 == self.allowIgnoreCost
end

function BattleCardServer:GetSchoolConfigId()
  local awakerID = self.configData.AwakerID
  if not awakerID then
    return
  end
  local DT = self.battleEngine.battleDT
  return DT.AwakerConfig[awakerID].School
end

function BattleCardServer:GetID()
  return self.configData.ID
end

function BattleCardServer:GetUid()
  return self.data.uid
end

function BattleCardServer:HasEnchant(Tid)
  for _, v in pairs(self.data.runes) do
    if v == Tid then
      return true
    end
  end
  return false
end

function BattleCardServer:SaveOriginData()
  local stateDataList = {}
  local list = self.battleEngine.stateMgr:GetStateListByOwnerUid(self.uid)
  for _, state in ipairs(list) do
    if not state.isDeleted then
      table.insert(stateDataList, state:Serialize())
    end
  end
  self.data.savedOriginData = {
    cardArgs = table.deepclone(self.cardArgs or {}),
    stateDataList = stateDataList or {},
    runes = table.deepclone(self.data.runes),
    level = self.level,
    specialOwnerUid = self.specialOwner and self.specialOwner.uid,
    performSkillId = self.data.performSkillId
  }
end

function BattleCardServer:GetKeepStateFlags(changeType, runeKeepType)
  local CardChangeType2KeepStateFlags = bc.CardChangeType2KeepStateFlags
  local keepStateFlags = CardChangeType2KeepStateFlags[changeType]
  if runeKeepType == bc.RuneKeepType.Both then
    keepStateFlags = keepStateFlags | bc.KeepStateFlags.KeepOriginRune
    keepStateFlags = keepStateFlags | bc.KeepStateFlags.KeepNewRune
  elseif runeKeepType == bc.RuneKeepType.KeepOrigin then
    keepStateFlags = keepStateFlags | bc.KeepStateFlags.KeepOriginRune
    keepStateFlags = keepStateFlags & ~bc.KeepStateFlags.KeepNewRune
  elseif runeKeepType == bc.RuneKeepType.KeepNew then
    keepStateFlags = keepStateFlags | bc.KeepStateFlags.KeepNewRune
    keepStateFlags = keepStateFlags & ~bc.KeepStateFlags.KeepOriginRune
  end
  return keepStateFlags
end

function BattleCardServer:ChangeConfigByCmd(targetCard, changeArgs)
  if self:GetProperty(bc.BattleProperty.Forcedretention) > 0 then
    return
  end
  local revertType = changeArgs.revertType
  local specialOwner = changeArgs.specialOwner or self.specialOwner
  local performSkillId = changeArgs.performSkillId or self.data.performSkillId
  self:RevertChange(revertType)
  if not self.data.savedOriginData then
    self:SaveOriginData()
  end
  local changeType = changeArgs.changeType
  local isPlayEffect = changeArgs.isPlayEffect
  local runeKeepType = changeArgs.runeKeepType
  local keepStateFlags = self:GetKeepStateFlags(changeType, runeKeepType)
  local list = self.battleEngine.stateMgr:GetStateListByOwnerUid(self.uid)
  for _, state in ipairs(list) do
    if state.isDeleted then
    else
      local sourceType = state.source[1] and state.source[1].sourceType
      local keep = false
      if "Enchant" == sourceType then
        keep = keepStateFlags & bc.KeepStateFlags.KeepOriginRune > 0
      elseif "ExistState" == sourceType then
        keep = keepStateFlags & bc.KeepStateFlags.KeepOriginExist > 0
      else
        keep = keepStateFlags & bc.KeepStateFlags.KeepOriginExtral > 0
      end
      if not keep and "ExistState" == sourceType then
        state:SubLayer(state.source[1].layer)
      elseif not keep then
        state:LifeEnd()
      end
    end
  end
  self.createCardArgs = targetCard.createCardArgs or {}
  self.level = targetCard.level
  self.specialOwner = specialOwner
  if performSkillId and performSkillId > 0 then
    self.data.performSkillId = performSkillId
  else
    self.data.performSkillId = nil
  end
  self:InitByConfigId(targetCard.data.tid, true)
  if keepStateFlags & bc.KeepStateFlags.KeepNewAll > 0 then
    local targetStateList = self.battleEngine.stateMgr:GetStateListByOwnerUid(targetCard.uid)
    for _, state in ipairs(targetStateList) do
      if state.isDeleted then
      else
        local sourceType = state.source[1] and state.source[1].sourceType
        local keep = false
        if "Enchant" == sourceType then
          keep = keepStateFlags & bc.KeepStateFlags.KeepNewRune > 0
        elseif "ExistState" == sourceType then
          keep = keepStateFlags & bc.KeepStateFlags.KeepNewExist > 0
        else
          keep = keepStateFlags & bc.KeepStateFlags.KeepNewExtral > 0
        end
        if keep then
          local createArgs = {
            stateId = state.stateId,
            layer = state.data.layer,
            castRoleUid = state.castRoleUid,
            stateParams = table.deepclone(state.stateParams),
            skillLevel = state.skillLevel,
            source = table.deepclone(state.source)
          }
          self.battleEngine.stateMgr:CreateState(self, createArgs)
        end
      end
    end
  end
  local stateList = {}
  local new_list = self.battleEngine.stateMgr:GetStateListByOwnerUid(self.uid)
  for _, state in ipairs(new_list) do
    table.insert(stateList, state:Serialize())
  end
  local runes = {}
  if keepStateFlags & bc.KeepStateFlags.KeepOriginRune > 0 then
    for _, runesId in pairs(self.data.runes or {}) do
      table.insert(runes, runesId)
    end
  end
  if keepStateFlags & bc.KeepStateFlags.KeepNewRune > 0 then
    for _, runesId in pairs(targetCard.data.runes or {}) do
      table.insert(runes, runesId)
    end
  end
  self.data.runes = runes
  self:UpdateCardArgs()
  local data = {
    cardUid = self.uid,
    configId = self.data.tid,
    tid = self.data.tid,
    cost = self:GetCurCost(),
    deck = self.deck,
    level = self.level,
    properties = self.property:Serialize(),
    stateList = stateList,
    cardArgs = self.cardArgs,
    runes = self.data.runes,
    descArgs = self.descArgs,
    ownerUid = self.owner.uid,
    isPlayEffect = isPlayEffect
  }
  self.battleEngine.recordMgr:OnChangeCard(data)
  self.battleEngine:CreateEventEffect(BattleLogicEvent.CardChange, {
    cardUid = self.uid
  })
  local eventData = {
    cardUid = self.uid
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.CardChangeByCmdAfter, table.clone(eventData))
end

function BattleCardServer:RevertChange(revertType)
  if not self.data.savedOriginData then
    return
  end
  revertType = revertType or bc.RevertType.SavedOrigin
  local stateMgr = self.battleEngine.stateMgr
  if revertType == bc.RevertType.SavedOrigin then
    local list = stateMgr:GetStateListByOwnerUid(self.uid)
    for _, state in pairs(list) do
      state:LifeEnd()
    end
  else
    local state_list = stateMgr:GetStateListByOwnerUid(self.uid)
    for _, state in ipairs(state_list) do
      local sourceType = state.source[1] and state.source[1].sourceType
      if not state.isDeleted and "ExistState" == sourceType then
        state:SubLayer(state.source[1].layer)
      end
    end
  end
  local savedOriginData = self.data.savedOriginData
  self.level = savedOriginData.level
  self.specialOwner = self.battleEngine:GetObj(savedOriginData.specialOwnerUid)
  self.data.performSkillId = savedOriginData.performSkillId
  if revertType == bc.RevertType.SavedOrigin then
    self.data.runes = savedOriginData.runes
    for _, stateData in ipairs(savedOriginData.stateDataList) do
      stateMgr:CreateState(self, stateData)
    end
    self:InitByConfigId(self.data.srcConfigId, true)
  else
    self:InitByConfigId(self.data.srcConfigId, false)
  end
  self:UpdateCardArgs()
  self.createCardArgs = savedOriginData.cardArgs or {}
  local stateList = {}
  local new_list = stateMgr:GetStateListByOwnerUid(self.uid)
  for _, state in ipairs(new_list) do
    table.insert(stateList, state:Serialize())
  end
  local data = {
    cardUid = self.uid,
    configId = self.data.tid,
    tid = self.data.tid,
    cost = self:GetCurCost(),
    deck = self.deck,
    level = self.level,
    properties = self.property:Serialize(),
    stateList = stateList,
    cardArgs = self.cardArgs,
    runes = self.data.runes,
    descArgs = self.descArgs,
    ownerUid = self.owner.uid
  }
  self.battleEngine.recordMgr:OnChangeCard(data)
  self.battleEngine:CreateEventEffect(BattleLogicEvent.CardChange, {
    cardUid = self.uid
  })
end

function BattleCardServer:OnPropertyChanged(propertyName, preValue, curValue, extraData)
  if propertyName == BP.card_use_times then
    if curValue <= 0 then
      local changeData = {
        changeReason = bc.CardDeckReason.TimesRunOut,
        castRoleUid = extraData.castRoleUid,
        targetDeck = bc.CardDeck.ConsumedDeck
      }
      self.battleEngine.cardMgr:MoveCardToDeck(self, changeData)
    end
  elseif bc.IsCardCostAffectProperty(propertyName) then
    local eventData = {
      uid = self.uid,
      oldValue = preValue,
      newValue = curValue,
      castRoleUid = extraData and extraData.castRoleUid
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.CardCostChanged, eventData)
  end
end

function BattleCardServer:GetOwner()
  return self.owner
end

function BattleCardServer:GetOwnerUid()
  return self.owner.uid
end

function BattleCardServer:CheckHighlight()
  local breakSkillLevel, potencyLevel = self:GetBreakAndPotency()
  local glowCondition = BattleUtilServer.GetTQText(self.configData.GlowCond, breakSkillLevel, potencyLevel)
  if not glowCondition then
    return false
  end
  if not self.cmdServer then
    return false
  end
  local result = self.cmdServer:CheckCondition(glowCondition)
  if not result or 0 == result then
    return false
  end
  return true
end

function BattleCardServer:GetOwnerAwaker()
  if self.specialOwner and self.specialOwner:IsRoleType(bc.RoleType.Awaker) then
    return self.specialOwner
  end
  if self.configData.AwakerID then
    do return self.battleEngine.roleMgr.GetAwakerByTid, self.battleEngine.roleMgr, self.configData.AwakerID end
    return self.battleEngine.roleMgr.GetAwakerByTid, self.battleEngine.roleMgr, self.configData.AwakerID, self.camp
  end
end

function BattleCardServer:GetOriginOwner()
  if self.configData.AwakerID then
    do return self.battleEngine.roleMgr.GetAwakerByTid, self.battleEngine.roleMgr, self.configData.AwakerID end
    return self.battleEngine.roleMgr.GetAwakerByTid, self.battleEngine.roleMgr, self.configData.AwakerID, self.camp
  end
end

function BattleCardServer:ChangeCardDeck(newDeck, changeData)
  changeData = changeData or {}
  local changeReason = changeData.changeReason
  local castRoleUid = changeData.castRoleUid
  if self.deck == newDeck then
    return
  end
  local oldDeck = self.deck
  self.deck = newDeck
  local eventData = {
    cardUid = self.uid,
    oldDeck = oldDeck,
    newDeck = newDeck,
    castRoleUid = castRoleUid
  }
  if changeReason ~= bc.CardDeckReason.Init then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.CardDeckChange, table.clone(eventData))
  end
  local cardEventData = {
    cardUid = self.uid,
    castRoleUid = castRoleUid,
    changeReason = changeReason
  }
  if oldDeck == bc.CardDeck.DrawDeck and newDeck == bc.CardDeck.HandDeck then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.CardOnDraw, cardEventData)
  end
  if changeReason ~= bc.CardDeckReason.Init and oldDeck ~= bc.CardDeck.UsingDeck and newDeck == bc.CardDeck.GraveyardDeck then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.CardOnDrop, cardEventData)
  end
  if changeReason ~= bc.CardDeckReason.Init and newDeck == bc.CardDeck.ConsumedDeck then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.CardOnConsume, cardEventData)
  end
  local DT = self.battleEngine.battleDT
  local oldName = DT.BattleApi[oldDeck] and DT.BattleApi[oldDeck].CnID or "无"
  local newName = DT.BattleApi[newDeck] and DT.BattleApi[newDeck].CnID or "无"
  self.battleEngine:LogBattleWithTab("%s 移动: %s -> %s", self:GetBattleLogName(), oldName, newName)
  self.battleEngine.cardMgr:RemoveHighlight(self.uid)
end

function BattleCardServer:RecordDamageTargets(targetUid)
  table.insert(self.data.damageTargets, targetUid)
end

function BattleCardServer:GetDamageTargets()
  return self.data.damageTargets
end

function BattleCardServer:GetSkillTarget()
  if not self.cmdServer then
    return
  end
  do return self.cmdServer.GetUpperTargets end
  return self.cmdServer.GetUpperTargets, self.cmdServer
end

function BattleCardServer:ClearDamageTargets()
  self.data.damageTargets = {}
end

function BattleCardServer:GetBattleLogName()
  local name = self.cmdServer:GetSkillConfigTQText("Name") or "无名称"
  name = name:match("%|(.*)") or name
  local str = "[卡牌-%s(%s)-%s]"
  do return string.format, str, self.configData.CnID, name end
  return string.format, str, self.configData.CnID, name, self.uid
end

function BattleCardServer:GetProperty(propertyName)
  do return self.property.GetProperty, self.property end
  return self.property.GetProperty, self.property, propertyName
end

function BattleCardServer:ChangeProperty(propertyName, value, extraData)
  do return self.property.ChangeProperty, self.property, propertyName, value end
  return self.property.ChangeProperty, self.property, propertyName, value, extraData
end

function BattleCardServer:AddProperty(propertyName, value, extraData)
  do return self.property.AddProperty, self.property, propertyName, value end
  return self.property.AddProperty, self.property, propertyName, value, extraData
end

function BattleCardServer:SubProperty(propertyName, value, extraData)
  do return self.property.SubProperty, self.property, propertyName, value end
  return self.property.SubProperty, self.property, propertyName, value, extraData
end

function BattleCardServer:SetProperty(...)
  do return self.property.SetProperty, self.property, ... end
  return self.property.SetProperty, self.property, ...
end

function BattleCardServer:GetCardCmdServer()
  return self.cmdServer
end

function BattleCardServer:GetCardPreCmdServer()
  return self.preCmdServer
end

function BattleCardServer:IsFromAttachPost()
  if self.cmdServer and self.cmdServer:IsAttachPost() then
    return true
  end
  return false
end

function BattleCardServer:ClearCmdServerStats()
  if self.preCmdServer then
    self.preCmdServer:ClearStats()
  end
  if self.cmdServer then
    self.cmdServer:ClearStats()
  end
end

function BattleCardServer:AddConsumeEnergyStats(realCost)
  if self.preCmdServer then
    self.preCmdServer:AddStats(bc.StatsKey.ConsumeEnergy, realCost)
  end
  if self.cmdServer then
    self.cmdServer:AddStats(bc.StatsKey.ConsumeEnergy, realCost)
  end
end

function BattleCardServer:GetCamp()
  return self.camp
end

function BattleCardServer:IsRoleType()
  return false
end

function BattleCardServer:GetCfgCmdTarget()
  local castRoleUid = self.owner.uid
  local skillId = self:GetID()
  local skillLevel = self.level
  local breakSkillLevel, potencyLevel = self:GetBreakAndPotency()
  do return self.battleEngine.GetSkillTargetType, self.battleEngine, castRoleUid, skillId, skillLevel, breakSkillLevel end
  return self.battleEngine.GetSkillTargetType, self.battleEngine, castRoleUid, skillId, skillLevel, breakSkillLevel, potencyLevel
end

function BattleCardServer:GetCmdTarget()
  local banTargetChange = self:GetProperty(BP.card_ban_target_change)
  if banTargetChange and banTargetChange > 0 then
    do return self.GetCfgCmdTarget end
    return self.GetCfgCmdTarget, self, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  for cardType, propertyList in pairs(bc.CardTargetChange) do
    if self:CardTypeMatch(cardType) then
      for _, propertyName in pairs(propertyList) do
        if self.owner:GetProperty(propertyName) > 0 then
          local apiCfg = self.battleEngine.battleDT.BattleApi[propertyName]
          return apiCfg.Data
        end
      end
    end
  end
  do return self.GetCfgCmdTarget end
  return self.GetCfgCmdTarget, self, pairs(bc.CardTargetChange)
end

function BattleCardServer:GetPlayer()
  do return self.owner.GetPlayer end
  return self.owner.GetPlayer, self.owner
end

return BattleCardServer
