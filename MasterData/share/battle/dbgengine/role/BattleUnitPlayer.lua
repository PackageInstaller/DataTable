local System = require("System.System")
local BattleUnitBase = require("Battle.DbgEngine.Role.BattleUnitBase")
local BattleConst = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local SchoolCompPVE = require("Battle.DbgEngine.Role.Component.SchoolCompPVE")
local SchoolCompPVP = require("Battle.DbgEngine.Role.Component.SchoolCompPVP")
local BattleStatsMgrPVP = require("Battle.DbgEngine.Stats.BattleStatsMgrPVP")
local BattleKeeperSkillServer = require("Battle.DbgEngine.Card.BattleKeeperSkillServer")
local BattleCmdParser = require("Battle.DbgEngine.Cmd.BattleCmdParser")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local bc = require("Battle.BattleConst")
local BP = BattleConst.BattleProperty
local BattleUnitPlayer, Super = System.NewClass("BattleUnitPlayer", BattleUnitBase)

function BattleUnitPlayer:ctor(battleEngine, roleData)
  Super.ctor(self, battleEngine, roleData)
  if self.battleEngine:IsPVE() then
    self.schoolCompPVE = self:AddBattleComponent(SchoolCompPVE, self.battleEngine)
  end
end

function BattleUnitPlayer:OnInit()
  self.roleType = BattleConst.RoleType.Player
end

function BattleUnitPlayer:CreateKeeperSkill(keeperSkillId, extraConfig)
  if not keeperSkillId then
    return
  end
  local skillInfo = {
    uid = self.battleEngine:GenUid(),
    tid = keeperSkillId,
    isBlankMemory = extraConfig and extraConfig.isBlankMemory,
    randUnlockSourceId = extraConfig and extraConfig.randUnlockSourceId
  }
  local keeperSkill = BattleKeeperSkillServer(self.battleEngine, skillInfo)
  return keeperSkill
end

function BattleUnitPlayer:CreateUnlockedKeeperSkills()
  self.unlockedKeeperSkillList = {}
  self.unlockedKeeperSkillMap = {}
  for _, itemId in ipairs(self.data.unlockedKeeperSkillItems or {}) do
    local itemCfg = self.battleEngine.battleDT.Item[itemId]
    if not itemCfg then
    elseif not itemCfg.SpParam or next(itemCfg.SpParam) == nil then
    else
      local keeperSkillId = tonumber(itemCfg.SpParam[1])
      local keeperSkill = self:CreateKeeperSkill(keeperSkillId)
      if keeperSkill then
        table.insert(self.unlockedKeeperSkillList, keeperSkill)
      end
    end
  end
end

function BattleUnitPlayer:GetUnlockedKeeperSkillInfos(exceptUnlocked, num, curKeeperSkillId, exceptSelectedSourceId, exceptOrigin, fillBlank)
  local ret = {}
  local skillId, _ = self:GetKeeperSkillIdAndChangeType()
  local list = table.clone(self.unlockedKeeperSkillList)
  if 1 == fillBlank then
    local DT = self.battleEngine.battleDT
    local blankMemorySkillIdList = string.split(DT.BattleApi.KeeperSkillBlankMemory.Data, ",") or {}
    for _, blankKeeperSkillId in ipairs(blankMemorySkillIdList) do
      local blankKeeperSkill = self:CreateKeeperSkill(tonumber(blankKeeperSkillId), {isBlankMemory = true})
      if blankKeeperSkill then
        table.insert(list, blankKeeperSkill)
      end
    end
  end
  BattleUtilServer.Shuffle(self.battleEngine, list)
  curKeeperSkillId = curKeeperSkillId or skillId
  local selected = {}
  if exceptSelectedSourceId then
    selected = self.data.selectedKeeperSkill[exceptSelectedSourceId] or {}
  end
  for _, keeperSkill in ipairs(list) do
    if num <= 0 then
      break
    end
    local tid = keeperSkill:GetData("tid")
    if 1 == exceptOrigin and tid == self.data.skillId then
    elseif (1 == exceptUnlocked or tid ~= curKeeperSkillId) and not table.contains(selected, tid) then
      table.insert(ret, keeperSkill:GetClientInfo())
      num = num - 1
    end
  end
  table.sort(ret, function(a, b)
    return a.tid < b.tid
  end)
  return ret
end

function BattleUnitPlayer:OnSelectKeeperSkills(sourceId, selectIds)
  if not self.data.selectedKeeperSkill[sourceId] then
    self.data.selectedKeeperSkill[sourceId] = {}
  end
  for _, selectId in ipairs(selectIds) do
    if not table.contains(self.data.selectedKeeperSkill[sourceId], selectId) then
      table.insert(self.data.selectedKeeperSkill[sourceId], selectId)
    end
  end
end

function BattleUnitPlayer:OnSelectRandUnlockKeeperSkillPack(sourceId, keeperSkillList)
  if not (sourceId and keeperSkillList) or not next(keeperSkillList) then
    return
  end
  if not self.data.randUnlockKeeperSkillUsed then
    self.data.randUnlockKeeperSkillUsed = {}
  end
  if not self.data.randUnlockKeeperSkillUsed[sourceId] then
    self.data.randUnlockKeeperSkillUsed[sourceId] = {}
  end
  local usedKeeperSkillIdList = self.data.randUnlockKeeperSkillUsed[sourceId]
  for _, keeperSkill in ipairs(keeperSkillList) do
    if keeperSkill.data and keeperSkill.data.isBlankMemory then
    else
      local keeperSkillId = keeperSkill:GetData("tid")
      if not table.contains(usedKeeperSkillIdList, keeperSkillId) then
        table.insert(usedKeeperSkillIdList, keeperSkillId)
      end
    end
  end
end

function BattleUnitPlayer:GetUnlockedKeeperSkillInfo(uid)
  for _, keeperSkill in ipairs(self.unlockedKeeperSkillList) do
    if keeperSkill:GetData("uid") == uid then
      return keeperSkill
    end
  end
end

function BattleUnitPlayer:OnAfterInit_PVE()
  local extraData = {
    castRoleUid = self.uid,
    reason = BattleConst.PropertyChangeReason.AttrModify
  }
  self:ChangeProperty(BP.max_energy, BattleConst.BattleAttrConst.Energy, extraData)
  local maxKeeperEnergyBase = self:GetProperty(BP.max_keeper_energy) or 0
  if 0 == maxKeeperEnergyBase then
    self:ChangeProperty(BP.max_keeper_energy, BattleConst.BattleAttrConst.MaxKeeperEnergy, extraData)
  end
  local DT = self.battleEngine.battleDT
  self:ChangeProperty(BP.bout_skill_times, 1, extraData)
  self.data.boutSkillTimes = 0
  self.data.oceanModel = BattleConst.OceanModel.OceanModel1
  self:CreateUnlockedKeeperSkills()
  local skillId, _ = self:GetKeeperSkillIdAndChangeType()
  self.curKeeperSkill = self:CreateKeeperSkill(skillId)
end

function BattleUnitPlayer:OnAfterInit_PVP()
  self.battleStats = self:AddBattleComponent(BattleStatsMgrPVP, self.battleEngine)
end

function BattleUnitPlayer:ResetBoutSkillTimes()
  self.data.boutSkillTimes = 0
end

function BattleUnitPlayer:HasHpBar()
  do return self.battleEngine.IsPVE end
  return self.battleEngine.IsPVE, self.battleEngine
end

function BattleUnitPlayer:GetBattleLogName()
  local name = "[阵营%s-玩家]"
  do return string.format, name end
  return string.format, name, self.camp
end

function BattleUnitPlayer:GetKeeperSkillIdAndChangeType()
  local skillId = self.data.skillId
  local changeType = BattleConst.KeeperSkillChangeType.Permanent
  if self.data.keeperSkillIdMap and next(self.data.keeperSkillIdMap) then
    local priority
    for p, info in pairs(self.data.keeperSkillIdMap) do
      if (not priority or p > priority) and 0 ~= info.tid then
        priority = p
        skillId = info.tid
        changeType = info.changeType
      end
    end
  end
  return skillId, changeType
end

function BattleUnitPlayer:GetSkillIdAndLevel()
  local skillId, _ = self:GetKeeperSkillIdAndChangeType()
  return skillId, self.data.skillLevel
end

function BattleUnitPlayer:ChangeSkill(skillId, changeType, priority)
  local oldSkillId, oldChangeType = self:GetKeeperSkillIdAndChangeType()
  self.data.keeperSkillIdMap[priority] = {tid = skillId, changeType = changeType}
  local curSkillId, _ = self:GetKeeperSkillIdAndChangeType()
  if oldSkillId ~= curSkillId then
    self.curKeeperSkill = self:CreateKeeperSkill(curSkillId)
  end
  if oldSkillId ~= curSkillId or oldChangeType ~= changeType then
    self.battleEngine.recordMgr:OnChangeKeeperSkill(curSkillId, changeType)
  end
end

function BattleUnitPlayer:ResetKeeperSkillByChangeType(changeTypes, runningSkillId)
  if type(changeTypes) ~= "table" then
    changeTypes = {changeTypes}
  end
  if self.data.keeperSkillIdMap and next(self.data.keeperSkillIdMap) then
    for p, info in pairs(self.data.keeperSkillIdMap) do
      if table.contains(changeTypes, info.changeType) and (not runningSkillId or runningSkillId == info.tid) then
        info.tid = 0
      end
    end
  end
end

function BattleUnitPlayer:ResetKeeperSkillAndSync(changeTypes, runningSkillId)
  local oldSkillId, oldChangeType = self:GetKeeperSkillIdAndChangeType()
  self:ResetKeeperSkillByChangeType(changeTypes, runningSkillId)
  local curSkillId, changeType = self:GetKeeperSkillIdAndChangeType()
  if oldSkillId ~= curSkillId then
    self.curKeeperSkill = self:CreateKeeperSkill(curSkillId)
  end
  if oldSkillId ~= curSkillId or oldChangeType ~= changeType then
    self.battleEngine.recordMgr:OnChangeKeeperSkill(curSkillId, changeType)
  end
end

function BattleUnitPlayer:OnUseKeeperSkill(skillId)
  self:ResetKeeperSkillAndSync({
    BattleConst.KeeperSkillChangeType.Temp,
    BattleConst.KeeperSkillChangeType.Bout
  }, skillId)
end

function BattleUnitPlayer:OnUseDimensionSkill(skillId)
end

function BattleUnitPlayer:GetBeforeSkillEffectType()
  return BattleConst.BattleEffectType.BEUseKeeperSkill
end

function BattleUnitPlayer:GetAfterSkillEffectType()
  return BattleConst.BattleEffectType.BEAfterUseKeeperSkill
end

function BattleUnitPlayer:UseSkill(skillId, skillLevel, beforeEffType, afterEffType, targetUids)
  if not skillId then
    skillId, skillLevel = self:GetSkillIdAndLevel()
  end
  beforeEffType = beforeEffType or self:GetBeforeSkillEffectType()
  afterEffType = afterEffType or self:GetAfterSkillEffectType()
  local DT = self.battleEngine.battleDT
  local skillConfig = DT.Skill[skillId]
  
  local function preFunc()
    self.battleEngine.roleMgr:SetCurCaster(self.uid)
    self.battleEngine:LogBattleWithTab("%s 释放技能: %s 等级: %s", self:GetBattleLogName(), skillConfig.CnID, skillLevel)
    local cmdServer = self:GetSkillCmd(skillId, skillLevel)
    self:CreateSkillTargetEffects(skillId, skillLevel, cmdServer, targetUids)
    self:CreateSkillBeforeEffects(skillId, skillLevel, beforeEffType, cmdServer)
    self:CreateSkillExecutePhaseEffects(skillId, skillLevel, cmdServer)
    self:CreateSkillAfterEffects(skillId, skillLevel, afterEffType, cmdServer, nil)
  end
  
  local finishCb = {
    func = function()
    end,
    data = {}
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleUnitPlayer:EnergyEnough(value)
  if not value then
    return true
  end
  local energy = self:GetProperty(BP.energy)
  if value > energy then
    return false
  end
  return true
end

function BattleUnitPlayer:OnBoutBegin_PVE()
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  if self.camp ~= curCamp then
    return
  end
  local extraData = {
    castRoleUid = self.uid,
    reason = BattleConst.PropertyChangeReason.AttrModify
  }
  self:SetProperty(BP.bout_dskill_use_times, 0, extraData)
  self.data.boutSkillTimes = 0
  self.battleEngine.recordMgr:OnSkillTimesChange(self.uid, 0)
  self.data.silverKeyAwakeTimes = 0
  self.battleEngine.recordMgr:OnSilverKeyAwakeTimesChange(self.uid, 0)
  self.data.chaosType2SkillTimes = 0
  self.battleEngine.recordMgr:OnChaosType2SkillTimesChange(self.uid, 0)
  self.data.chaosType2Skill2Times = 0
  self.battleEngine.recordMgr:OnChaosType2Skill2TimesChange(self.uid, 0)
  self.data.boutBloodRecoverTimes = 0
  self.battleEngine.recordMgr:OnBloodRecoverTimesChange(self.uid, 0)
  local blockReserverValue = self:GetProperty(BP.block_reserve) or 0
  local isExtraBout = self.battleEngine.boutMgr:GetIsExtraBout()
  local isKeepBlock = blockReserverValue > 0 or isExtraBout
  local oldValue = self:GetProperty(BP.block)
  self.battleEngine.statsMgr:RecordBlock(oldValue)
  if not isKeepBlock then
    local extraData = {
      castRoleUid = self.uid,
      reason = BattleConst.PropertyChangeReason.BlockReset
    }
    self.property:SetProperty(BP.block, 0, extraData)
  end
  local baseEnergy = self:GetProperty(BP.max_energy)
  local extraData = {
    castRoleUid = self.uid,
    reason = BattleConst.PropertyChangeReason.AttrModify,
    castValue = baseEnergy,
    overflowValue = 0,
    deltaValue = baseEnergy,
    curValue = baseEnergy,
    isBoutBegin = true
  }
  self:ChangeProperty(BP.energy, baseEnergy, extraData)
  self.battleEngine:CreateEventEffect(BattleLogicEvent.GainEnergy, extraData)
  self:ResetOceanModel()
end

function BattleUnitPlayer:OnBoutEnd_PVE()
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  if self.camp ~= curCamp then
    return
  end
  self:GainPassiveUltiEnergy()
  local extraData = {
    castRoleUid = self.uid,
    reason = BattleConst.PropertyChangeReason.AttrSet
  }
  self.property:SetProperty(BP.bout_tentacle_count, 0, extraData)
  local curBoutMax = self:GetProperty(BP.bout_max_tentacle_count)
  local effectType = BattleConst.BattleEffectType.BEChangeMaxTentacleCount
  local effectConfig = {
    effectType = effectType,
    targets = {self},
    params = {
      curBoutMax * -1,
      1
    },
    castRoleUid = self.uid
  }
  self.battleEngine.effectMgr:CreateEffect(effectConfig)
  self:ResetEnergy()
  self:ResetKeeperSkillAndSync(BattleConst.KeeperSkillChangeType.Bout)
end

function BattleUnitPlayer:GetType()
  return "PlayerRole"
end

function BattleUnitPlayer:OnBattleEnd_PVE()
  if self.camp ~= BattleConst.BattleCamp.Camp1 then
    return
  end
  self:ResetEnergy()
  local changeTypes = {
    BattleConst.KeeperSkillChangeType.Temp,
    BattleConst.KeeperSkillChangeType.Battle,
    BattleConst.KeeperSkillChangeType.Bout
  }
  self:ResetKeeperSkillAndSync(changeTypes)
end

function BattleUnitPlayer:PreCheckDeathEvent()
  do return self.battleEngine.IsPVE end
  return self.battleEngine.IsPVE, self.battleEngine
end

function BattleUnitPlayer:GetSkillCmd(skillId, skillLevel, isPre)
  if self.curKeeperSkill and self.curKeeperSkill.data.tid == skillId then
    if isPre then
      return self.curKeeperSkill.preCmdServer
    end
    return self.curKeeperSkill.cmdServer
  end
  do return Super.GetSkillCmd, self, skillId, skillLevel end
  return Super.GetSkillCmd, self, skillId, skillLevel, isPre
end

function BattleUnitPlayer:GetAwakerList()
  do return self.battleEngine.roleMgr.GetRoleTypeListByCamp, self.battleEngine.roleMgr, self.camp end
  return self.battleEngine.roleMgr.GetRoleTypeListByCamp, self.battleEngine.roleMgr, self.camp, BattleConst.RoleType.Awaker
end

function BattleUnitPlayer:ConsumeEnergy(value, data, castRoleUid)
  local energy = self:GetProperty(BP.energy)
  if value == bc.VariableCostSentinel then
    value = energy
    data.castValue = value
  end
  local extraData = table.clone(data)
  extraData.isSilent = true
  extraData.realCost = value
  energy = self.property:SubProperty(BP.energy, value, extraData) or 0
  self.battleEngine:CreateEventEffect(BattleLogicEvent.ConsumeEnergy, extraData)
  local changeValue = -value
  local reason = "CardCost"
  self.battleEngine.recordMgr:OnPropertyChanged(self.uid, BP.energy, changeValue, energy, reason)
  return value
end

function BattleUnitPlayer:ConsumeEnergyToHp(value, damage, castRoleUid)
  local modifyConfig = {
    castRoleUid = castRoleUid,
    destRoleUid = self.uid,
    modifyVal = math.ceil(value * damage * -1),
    isCrit = false
  }
  self:ModifyHp(modifyConfig)
  return value
end

function BattleUnitPlayer:GetSilverKeyAwakeSkill()
  local DT = self.battleEngine.battleDT
  local tid = DT.GetConstant("SilverKeyAwakeSkill")
  return tid, 1
end

function BattleUnitPlayer:GetChaosType2Skill()
  local DT = self.battleEngine.battleDT
  local tid = DT.GetConstant("ChaosType2Skill")
  return tid, 1
end

function BattleUnitPlayer:GetChaosType2Skill2()
  local DT = self.battleEngine.battleDT
  local tid = DT.GetConstant("ChaosType2Skill2")
  return tid, 1
end

function BattleUnitPlayer:GetKeeperSkillBaseCost()
  local maxKeeperEnergyBase = self:GetProperty(BP.max_keeper_energy) or 0
  if maxKeeperEnergyBase > 0 then
    return maxKeeperEnergyBase
  end
  return BattleConst.BattleAttrConst.MaxKeeperEnergy
end

function BattleUnitPlayer:GetKeeperSkillCost()
  local cost = self:GetKeeperSkillBaseCost()
  local costPer = self:GetProperty(BP.keeper_energy_cost_per) or 0
  do return math.ceil end
  return math.ceil, cost * (1 + costPer / 100)
end

function BattleUnitPlayer:CanUseSilverKeyAwake()
  local usedTimes = self.data.silverKeyAwakeTimes or 0
  if usedTimes >= 1 then
    return false, "超过次数"
  end
  local DT = self.battleEngine.battleDT
  local stateId = DT.GetConstant("SilverKeyAwakeState")
  if not self.battleEngine.stateMgr:HasStateByStateIds(self.uid, {stateId}) then
    return false, "未拥有状态"
  end
  local keeperEnergy = self:GetProperty(BP.keeper_energy)
  local cost = self:GetKeeperSkillCost()
  if keeperEnergy < cost then
    return false, "能量不足"
  end
  return true
end

function BattleUnitPlayer:CanUseChaosType2Skill()
  if (self:GetProperty(bc.RoleProperty.is_chaos_type2) or 0) <= 0 then
    return false
  end
  local skillId, _ = self:GetChaosType2Skill()
  if not skillId then
    return false
  end
  local usedTimes = self.data.chaosType2SkillTimes or 0
  if usedTimes >= 1 then
    return false, "超过次数"
  end
  local keeperEnergy = self:GetProperty(BP.keeper_energy)
  local cost = self:GetKeeperSkillCost()
  if keeperEnergy < cost then
    return false, "能量不足"
  end
  return true
end

function BattleUnitPlayer:CanUseChaosType2Skill2()
  if (self:GetProperty(bc.RoleProperty.is_chaos_type2) or 0) <= 0 then
    return false
  end
  local skillId, _ = self:GetChaosType2Skill2()
  if not skillId then
    return false
  end
  local usedTimes = self.data.chaosType2Skill2Times or 0
  if usedTimes >= 1 then
    return false, "超过次数"
  end
  local keeperEnergy = self:GetProperty(BP.keeper_energy)
  local cost = self:GetKeeperSkillCost()
  if keeperEnergy < cost then
    return false, "能量不足"
  end
  return true
end

function BattleUnitPlayer:CanUseKeeperSkill()
  if (self:GetProperty(bc.RoleProperty.is_chaos_type2) or 0) > 0 then
    return false
  end
  local skillId, _ = self:GetSkillIdAndLevel()
  if not skillId then
    return false
  end
  local timesLimit = self:GetProperty(BP.bout_skill_times)
  local times = self.data.boutSkillTimes or 0
  if timesLimit and timesLimit <= times then
    return false
  end
  local keeperEnergy = self:GetProperty(BP.keeper_energy)
  local cost = self:GetKeeperSkillCost()
  if keeperEnergy < cost then
    return false
  end
  return true
end

function BattleUnitPlayer:CanUseHandKeeperSkill(card)
  local cost = self:GetKeeperSkillCost()
  local handKeeperSkillParam = card.data.handKeeperSkillParam or {}
  if handKeeperSkillParam.handKeeperFree then
    cost = 0
  end
  local keeperEnergy = self:GetProperty(BP.keeper_energy) or 0
  if cost > keeperEnergy then
    return false, bc.CardFailedReason.NoEnergy
  end
  if (handKeeperSkillParam.handKeeperCountAfter or 0) > 0 then
    local timesLimit = self:GetProperty(BP.bout_skill_times)
    local times = self.data.boutSkillTimes or 0
    if timesLimit and timesLimit <= times then
      return false, bc.CardFailedReason.LimitUse
    end
  end
  return true
end

function BattleUnitPlayer:CanUseDimensionSkill()
  local use_times = self:GetProperty(BP.bout_dskill_use_times)
  if use_times > 0 then
    return false
  end
  local cardList = self.battleEngine.cardMgr:GetCardListByDeck(BattleConst.CardDeck.DimensionDeck)
  if 0 == #cardList then
    return false
  end
  local isExtraBout = self.battleEngine.boutMgr:GetIsExtraBout()
  if isExtraBout then
    return false
  end
  local cond = self.battleEngine.battleDT.BattleApi.DimensionAbilityCond.Data
  if cond then
    local ctorData = {
      castRoleUid = self.uid
    }
    local cmdParser = BattleCmdParser(self.battleEngine, ctorData)
    local ret = cmdParser:GetValueByCmd(cond)
    if not ret then
      return false
    end
  end
  return true
end

function BattleUnitPlayer:UpdateSchoolArgs()
  if self.schoolCompPVE then
    self.schoolCompPVE:UpdateSchoolArgs()
    self.schoolCompPVE:UpdateSchoolSpecialArgs()
  end
end

function BattleUnitPlayer:ResetEnergy()
  local overflowEnergy = self:GetProperty(BP.energy)
  self.battleEngine.statsMgr:SetOverFlowEnergy(overflowEnergy)
  local extraData = {
    castRoleUid = self.uid,
    reason = BattleConst.PropertyChangeReason.AttrModify
  }
  self.property:SetProperty(BP.energy, 0, extraData)
end

function BattleUnitPlayer:GetDeathResitCoff()
  local coefficientPlus = (self:GetProperty(BP.death_resist_coefficient_plus) or 0) / 100
  local coff = 1 - (self.battleEngine.battleDT.GetConstant("Death_resist_coefficient", 0.5) - coefficientPlus)
  return coff
end

function BattleUnitPlayer:GetCurDeathResist()
  local deathResist = self:GetProperty(BP.death_resist)
  local deathResistTimes = self:GetProperty(BP.death_resist_times)
  local coff = self:GetDeathResitCoff()
  return deathResist * coff ^ deathResistTimes
end

function BattleUnitPlayer:IsDeathResist()
  if self.battleEngine:IsPVP() then
    return
  end
  if self.battleEngine:IsPVE() then
    local curDeathResist = self:GetCurDeathResist() or 0
    if self.camp == BattleConst.BattleCamp.Camp1 and self.data.lives <= 1 and self.battleEngine:IsPrologueStage() then
      return true
    end
    local rand = self.battleEngine.rand:random(10000)
    if rand < curDeathResist * 100 then
      return true
    end
  end
end

function BattleUnitPlayer:DeathResist(isActive)
  local extraData = {
    castRoleUid = self.uid,
    reason = BattleConst.PropertyChangeReason.AttrSet
  }
  if not isActive then
    self.property:SetProperty(BP.hp, 1, extraData)
  end
  extraData.reason = BattleConst.PropertyChangeReason.AttrModify
  local times = self:ChangeProperty(BP.death_resist_times, 1, extraData)
  self.battleEngine.recordMgr:OnPropertyChanged(self.uid, BP.death_resist_times, 1, times)
  self.battleEngine.recordMgr:OnDeathResist(self.uid)
end

function BattleUnitPlayer:GetTeamOccMaster()
  local val = 0
  local awakerList = self:GetAwakerList()
  for _, awaker in ipairs(awakerList) do
    val = val + awaker:GetProperty(BP.occupation_master)
  end
  val = val + self:GetProperty(BP.occupation_master)
  do return math.ceil end
  return math.ceil, val, BP.occupation_master, ipairs(awakerList)
end

function BattleUnitPlayer:GetTeamLevel()
  local level = 0
  local awakerList = self:GetAwakerList()
  local awakerNum = 0
  for _, awaker in ipairs(awakerList) do
    level = level + (awaker.level or 0)
    awakerNum = awakerNum + 1
  end
  do return math.ceil end
  return math.ceil, level / awakerNum, ipairs(awakerList)
end

function BattleUnitPlayer:GetTeamAtk()
  local atk = 0
  local awakerList = self:GetAwakerList()
  for _, awaker in ipairs(awakerList) do
    local baseAtk = awaker.property:GetProperty(BP.atk)
    local atkPct = awaker.property:GetProperty(BP.atk_per) or 0
    atk = atk + baseAtk * (1 + atkPct / 100)
  end
  do return math.ceil end
  return math.ceil, atk / #awakerList, ipairs(awakerList)
end

function BattleUnitPlayer:SwapAwakerToFront(awaker)
  local pos = awaker:GetBattleFieldPos()
  if 1 == pos then
    return false
  end
  local frontAwaker = self:GetAwakerByPos(1)
  if not frontAwaker then
    return false
  end
  frontAwaker:SetBattleFieldPos(pos)
  awaker:SetBattleFieldPos(1)
  self.battleEngine.recordMgr:OnSwapAwaker(awaker.uid, frontAwaker.uid)
  return true
end

function BattleUnitPlayer:GetAwakerByPos(pos)
  local awakerList = self:GetAwakerList()
  for _, awaker in ipairs(awakerList) do
    if awaker:GetBattleFieldPos() == pos then
      return awaker
    end
  end
  return nil
end

function BattleUnitPlayer:Respawn_PVE()
  local DT = self.battleEngine.battleDT
  local time = 2.5
  if self.battleEngine.isIntro and self.camp == BattleConst.BattleCamp.Camp1 then
    time = 2.5
  end
  self.data.lives = self.data.lives - self.battleEngine:GetData("respawnCost")
  self.deadTimes = (self.deadTimes or 0) + 1
  if self.data.lives <= 0 then
    self.battleEngine:Warn("role respawn with no lives ")
  end
  self.battleEngine.recordMgr:OnRespawn(self.uid, self.deadTimes)
  self.data.respawnedNum = self.data.respawnedNum + 1
  self.battleEngine:AddPassTime(time)
  local stateId = DT.Constant.RespawnImmueState.Data[1]
  local createArgs = {
    stateId = stateId,
    castRoleUid = self.uid
  }
  self.battleEngine.stateMgr:CreateState(self, createArgs)
  local modifyConfig = {
    castRoleUid = self.uid,
    destRoleUid = self.uid,
    modifyVal = self:GetProperty(BP.max_hp),
    ignoreStats = true
  }
  self:ModifyHp(modifyConfig)
  local awakerList = self:GetAwakerList()
  for _, awaker in ipairs(awakerList) do
    awaker:RestoreFullUltiEnergy()
  end
  local extraData = {
    castRoleUid = self.uid,
    reason = BattleConst.PropertyChangeReason.AttrModify
  }
  local addValue = self.property:GetMaxKeeperEnergy()
  if addValue > 0 then
    self:SetProperty(BP.keeper_energy, addValue, extraData)
  end
end

function BattleUnitPlayer:GainEnergy(value, castRoleUid, cmdServerUid)
  local extraData = {
    castRoleUid = castRoleUid,
    reason = BattleConst.PropertyChangeReason.AttrModify,
    castValue = value,
    cmdServerUid = cmdServerUid
  }
  local newValue = self.property:ChangeProperty(BP.energy, value, extraData)
  local eventData = {
    castRoleUid = castRoleUid,
    castValue = value,
    deltaValue = value,
    curValue = newValue
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.GainEnergy, eventData)
end

function BattleUnitPlayer:GetTargetType()
  return BattleConst.ObjType.TypePlayer
end

function BattleUnitPlayer:GetShowTentacleDamage()
  local curDmg = self:GetProperty(BP.tentacle_dmg) or 0
  local baseDamage = self:GetProperty(BP.tentacle_base_dmg) or 0
  local basic_damage_per = self:GetProperty(BP.basic_damage_per) or 0
  if self.battleEngine:IsPVP() then
    local awakerList = self:GetAwakerList()
    for _, awaker in ipairs(awakerList) do
      curDmg = awaker:GetProperty(BP.tentacle_dmg) + curDmg
    end
  end
  if self.battleEngine:IsPVE() then
    local tentacleDmgPer = self:GetProperty(BP.tentacle_dmg_per) or 0
    local insideBasicDmgPer, awakerNum = 0, 0
    for _, awaker in ipairs(self:GetAwakerList()) do
      insideBasicDmgPer = insideBasicDmgPer + (awaker:GetProperty(BP.i_basic_damage_per) or 0)
      awakerNum = awakerNum + 1
    end
    if awakerNum > 0 then
      insideBasicDmgPer = insideBasicDmgPer / awakerNum
    end
    curDmg = math.max(1, math.ceil((baseDamage * (1 + basic_damage_per / 100) * (1 + insideBasicDmgPer / 100) + curDmg) * (1 + tentacleDmgPer / 100)))
  end
  self.battleEngine:DebugS("GetShowTentacleDamage {curDmg}", curDmg)
  return curDmg
end

function BattleUnitPlayer:GetTentacleDamage()
  local curDmg = self:GetProperty(BP.tentacle_dmg) or 0
  local baseDamage = self:GetProperty(BP.tentacle_base_dmg) or 0
  local basic_damage_per = self:GetProperty(BP.basic_damage_per) or 0
  if self.battleEngine:IsPVP() then
    local awakerList = self:GetAwakerList()
    for _, awaker in ipairs(awakerList) do
      curDmg = awaker:GetProperty(BP.tentacle_dmg) + curDmg
    end
  end
  if self.battleEngine:IsPVE() then
    local powerStateLayer = self:GetPowerStateLayer()
    local powerAddPer = self.battleEngine.battleDT.GetConstant("TentacleDamageForPowerPercent") or 0
    local weakPer = self:GetProperty(BP.weak_per) or 0
    local tentacleDmgPer = self:GetProperty(BP.tentacle_dmg_per) or 0
    local insideBasicDmgPer, insideDmgPer, insideDmgPer1, insideDmgPer2, insideDmgPer3, insideDmgPer4, insideDmgPer5, insideDmgPer6, insideDmgPer7, insideDmgPer8, awakerNum = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    local dimension_fix_per = self:GetDimensionFixPer()
    for _, awaker in ipairs(self:GetAwakerList()) do
      insideBasicDmgPer = insideBasicDmgPer + (awaker:GetProperty(BP.i_basic_damage_per) or 0)
      insideDmgPer = insideDmgPer + (awaker:GetProperty(BP.i_damage_per) or 0)
      insideDmgPer1 = insideDmgPer1 + (awaker:GetProperty(BP.i_damage_per1) or 0)
      insideDmgPer2 = insideDmgPer2 + (awaker:GetProperty(BP.i_damage_per2) or 0)
      insideDmgPer3 = insideDmgPer3 + (awaker:GetProperty(BP.i_damage_per3) or 0)
      insideDmgPer4 = insideDmgPer4 + (awaker:GetProperty(BP.i_damage_per4) or 0)
      insideDmgPer5 = insideDmgPer5 + (awaker:GetProperty(BP.i_damage_per5) or 0)
      insideDmgPer6 = insideDmgPer6 + (awaker:GetProperty(BP.i_damage_per6) or 0)
      insideDmgPer7 = insideDmgPer7 + (awaker:GetProperty(BP.i_damage_per7) or 0)
      insideDmgPer8 = insideDmgPer8 + (awaker:GetProperty(BP.i_damage_per8) or 0)
      awakerNum = awakerNum + 1
    end
    if awakerNum > 0 then
      insideBasicDmgPer = insideBasicDmgPer / awakerNum
      insideDmgPer = insideDmgPer / awakerNum
      insideDmgPer1 = insideDmgPer1 / awakerNum
      insideDmgPer2 = insideDmgPer2 / awakerNum
      insideDmgPer3 = insideDmgPer3 / awakerNum
      insideDmgPer4 = insideDmgPer4 / awakerNum
      insideDmgPer5 = insideDmgPer5 / awakerNum
      insideDmgPer6 = insideDmgPer6 / awakerNum
      insideDmgPer7 = insideDmgPer7 / awakerNum
      insideDmgPer8 = insideDmgPer8 / awakerNum
    end
    local oldDmg = curDmg
    curDmg = math.max(1, math.ceil((baseDamage * (1 + basic_damage_per / 100) * (1 + insideBasicDmgPer / 100) + curDmg + powerStateLayer * (1 + powerAddPer / 100)) * (1 - weakPer / 100) * (1 + insideDmgPer / 100) * (1 + insideDmgPer1 / 100) * (1 + insideDmgPer2 / 100) * (1 + insideDmgPer3 / 100) * (1 + insideDmgPer4 / 100) * (1 + insideDmgPer5 / 100) * (1 + insideDmgPer6 / 100) * (1 + insideDmgPer7 / 100) * (1 + insideDmgPer8 / 100) * (1 + dimension_fix_per / 100) * (1 + tentacleDmgPer / 100)))
    self.battleEngine:DebugS("GetTentacleDamage {oldDmg} {curDmg} {baseDamage} {basic_damage_per} {insideBasicDmgPer} {powerStateLayer} {powerAddPer} {awakerNum}", oldDmg, curDmg, baseDamage, basic_damage_per, insideBasicDmgPer, powerStateLayer, powerAddPer, awakerNum)
  end
  return curDmg
end

function BattleUnitPlayer:GetTimeoutTimes()
  return self.data.timeoutTimes or 0
end

function BattleUnitPlayer:AddTimeoutTimes()
  if not self.data.boutAct then
    self.data.timeoutTimes = (self.data.timeoutTimes or 0) + 1
  end
end

function BattleUnitPlayer:SetBoutAct(boutAct)
  self.data.boutAct = boutAct
end

function BattleUnitPlayer:ClearTimeoutTimes()
  self.data.timeoutTimes = 0
  self:SetBoutAct(true)
end

function BattleUnitPlayer:CanSwitchOceanModel(model)
  if self.schoolCompPVE and not self.schoolCompPVE:IsSchoolID(bc.SchoolID.DEEP_SEA) then
    return false
  end
  if self.data.boutTentacleSwitched then
    return false
  end
  if model == self.data.oceanModel then
    return false
  end
  local conds = {}
  if model == BattleConst.OceanModel.OceanModel3 then
    local c3 = self.battleEngine.battleDT.BattleApi.OceanModel3Cond
    if c3 and c3.Data then
      table.insert(conds, c3.Data)
    end
    local c4 = self.battleEngine.battleDT.BattleApi.OceanModel4Cond
    if c4 and c4.Data then
      table.insert(conds, c4.Data)
    end
  elseif model == BattleConst.OceanModel.OceanModel2 then
    local c2 = self.battleEngine.battleDT.BattleApi.OceanModel2Cond
    if c2 and c2.Data then
      table.insert(conds, c2.Data)
    end
  end
  if #conds > 0 then
    local ctorData = {
      castRoleUid = self.uid
    }
    local cmdParser = BattleCmdParser(self.battleEngine, ctorData)
    for _, cond in ipairs(conds) do
      local ret = cmdParser:GetValueByCmd(cond)
      if not ret then
        return false
      end
    end
  end
  return true
end

function BattleUnitPlayer:SwitchOceanModel(model)
  local oldModel = self.data.oceanModel
  self.data.boutTentacleSwitched = true
  self.data.oceanModel = model
  local skillId = self.battleEngine.battleDT.GetConstant(model)
  local beforeEffType = BattleConst.BattleEffectType.BEBeforeUseOtherSkill
  local afterEffType = BattleConst.BattleEffectType.BEAfterUseOtherSkill
  local DT = self.battleEngine.battleDT
  
  local function preFunc()
    local skillConfig = DT.Skill[skillId]
    self.battleEngine:LogBattleWithTab("%s 释放技能: %s 等级: %s", self:GetBattleLogName(), skillConfig.CnID, 1)
    self.battleEngine.roleMgr:SetCurCaster(self.uid)
    self.battleEngine.recordMgr:OnSwitchOceanModel(model)
    self:CreateSkillEffect(skillId, 1, beforeEffType, afterEffType)
    self.battleEngine:CreateEventEffect(BattleLogicEvent.OceanModeChange, {
      oldModel = oldModel,
      model = self.data.oceanModel
    })
  end
  
  local finishCb = {
    func = function()
    end,
    data = {}
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleUnitPlayer:ResetOceanModel()
  self.data.boutTentacleSwitched = false
  local oldModel = self.data.oceanModel
  local model = BattleConst.OceanModel.OceanModel1
  self.data.oceanModel = model
  self.battleEngine.recordMgr:OnSwitchOceanModel(model)
  self.battleEngine:CreateEventEffect(BattleLogicEvent.OceanModeChange, {
    oldModel = oldModel,
    model = self.data.oceanModel
  })
end

function BattleUnitPlayer:CanBloodRecoverSkill()
  if self.schoolCompPVE and not self.schoolCompPVE:IsSchoolID(bc.SchoolID.BLOOD) then
    return false
  end
  local cond = self.battleEngine.battleDT.BattleApi.BloodAbilityCond.Data
  if cond then
    local ctorData = {
      castRoleUid = self.uid
    }
    local cmdParser = BattleCmdParser(self.battleEngine, ctorData)
    local ret = cmdParser:GetValueByCmd(cond)
    if not ret then
      self.battleEngine:InfoS("BattleUnitPlayer:CanBloodRecoverSkill 条件不满足")
      return false
    end
  end
  local DT = self.battleEngine.battleDT
  local argCfg = DT.GetConstant("BloodHealCount")
  if argCfg then
    local ctorData = {
      castRoleUid = self.uid
    }
    local cmdParser = BattleCmdParser(self.battleEngine, ctorData)
    local val = cmdParser:GetValueByCmd(argCfg) or 0
    if val <= 0 then
      return false
    end
  end
  if self.data.boutBloodRecoverTimes >= BattleConst.BoutBloodSkillMaxTimes then
    return false
  end
  return true
end

function BattleUnitPlayer:BloodRecoverSkill(constanId)
  local skillId = self.battleEngine.battleDT.GetConstant(constanId)
  local beforeEffType = BattleConst.BattleEffectType.BEBeforeUseOtherSkill
  local afterEffType = BattleConst.BattleEffectType.BEAfterUseBloodRecoverSkill
  local DT = self.battleEngine.battleDT
  
  local function preFunc()
    local skillConfig = DT.Skill[skillId]
    self.battleEngine:LogBattleWithTab("%s 释放技能: %s 等级: %s", self:GetBattleLogName(), skillConfig.CnID, 1)
    self.battleEngine.roleMgr:SetCurCaster(self.uid)
    self.data.boutBloodRecoverTimes = self.data.boutBloodRecoverTimes + 1
    self.battleEngine.recordMgr:OnBloodRecoverTimesChange(self.uid, self.data.boutBloodRecoverTimes)
    self:CreateSkillEffect(skillId, 1, beforeEffType, afterEffType)
  end
  
  local finishCb = {
    func = function()
    end,
    data = {}
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleUnitPlayer:DimensionalSkill()
  self.battleEngine:InfoS("BattleUnitPlayer:DimensionalSkill")
  local skillId = self.battleEngine.battleDT.GetConstant("TranscendentCmd")
  local beforeEffType = BattleConst.BattleEffectType.BEBeforeUseOtherSkill
  local afterEffType = BattleConst.BattleEffectType.BEAfterUseSpecialDimension
  local DT = self.battleEngine.battleDT
  
  local function preFunc()
    local skillConfig = DT.Skill[skillId]
    self.battleEngine:LogBattleWithTab("%s 释放技能: %s 等级: %s", self:GetBattleLogName(), skillConfig.CnID, 1)
    self.battleEngine.roleMgr:SetCurCaster(self.uid)
    self:CreateSkillEffect(skillId, 1, beforeEffType, afterEffType)
  end
  
  local finishCb = {
    func = function()
    end,
    data = {}
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleUnitPlayer:OnSnapShot()
  local baseSnapshot = Super.OnSnapShot(self)
  local unlockedKeeperSkillList = {}
  if self.unlockedKeeperSkillList then
    for _, keeperSkill in ipairs(self.unlockedKeeperSkillList) do
      table.insert(unlockedKeeperSkillList, {
        uid = keeperSkill.data.uid,
        tid = keeperSkill.data.tid
      })
    end
  end
  local curKeeperSkillData
  if self.curKeeperSkill then
    curKeeperSkillData = {
      uid = self.curKeeperSkill.data.uid,
      tid = self.curKeeperSkill.data.tid
    }
  end
  baseSnapshot.unlockedKeeperSkillList = unlockedKeeperSkillList
  baseSnapshot.curKeeperSkill = curKeeperSkillData
  return baseSnapshot
end

function BattleUnitPlayer:OnRecover(snapshotData)
  Super.OnRecover(self, snapshotData)
  if self.schoolCompPVE then
    self.schoolCompPVE:InitSchoolData()
  end
  self:SetProperty(BP.rewind_bout, self.battleEngine.snapshotMgr:GetMaxRewindBout(), {
    reason = bc.PropertyChangeReason.AttrSet
  })
  if snapshotData.unlockedKeeperSkillList then
    self.unlockedKeeperSkillList = {}
    for _, skillInfo in ipairs(snapshotData.unlockedKeeperSkillList) do
      local skillConfig = {
        uid = skillInfo.uid,
        tid = skillInfo.tid
      }
      local keeperSkill = BattleKeeperSkillServer(self.battleEngine, skillConfig)
      if keeperSkill then
        table.insert(self.unlockedKeeperSkillList, keeperSkill)
      end
    end
  end
  if snapshotData.curKeeperSkill then
    local skillId, _ = self:GetKeeperSkillIdAndChangeType()
    if skillId == snapshotData.curKeeperSkill.tid then
      local skillConfig = {
        uid = snapshotData.curKeeperSkill.uid,
        tid = snapshotData.curKeeperSkill.tid
      }
      self.curKeeperSkill = BattleKeeperSkillServer(self.battleEngine, skillConfig)
    end
  end
end

return BattleUnitPlayer
