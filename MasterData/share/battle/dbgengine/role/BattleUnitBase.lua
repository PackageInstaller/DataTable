local System = require("System.System")
local BattleEntity = require("Battle.Ecs.BattleEntity")
local BattlePropertyServer = require("Battle.DbgEngine.BattlePropertyServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local BattleRoleData = require("Battle.DbgEngine.DataCenter.BattleRoleData")
local BattleCmdServer = require("Battle.DbgEngine.Cmd.BattleCmdServer")
local TagManagerComp = require("Battle.DbgEngine.Role.Component.TagManagerComp")
local BP = bc.BattleProperty
local BattleUnitUtil = require("Battle.Util.BattleUnitUtil")
local BattleUnitBase, Super = System.NewClass("BattleUnitBase", BattleEntity)

function BattleUnitBase:ctor(battleEngine, roleData)
  Super.ctor(self)
  self.battleEngine = battleEngine
  if roleData.data then
    self.data = roleData.data
    self.data.uid = battleEngine:GenObjUid(self, roleData.uid)
  else
    self.data = BattleRoleData.Create(roleData)
    self.data.uid = battleEngine:GenObjUid(self, roleData.uid)
  end
  self.uid = self.data.uid
  self.camp = roleData.camp
  self.originRoleData = roleData
  self.level = roleData.level or 1
  self.tid = roleData.tid
  self.property = self:AddBattleComponent(BattlePropertyServer, roleData.properties)
  self.tagManager = self:AddBattleComponent(TagManagerComp, self.data.tags)
  self:Init()
  self:RegisterCallbacks()
end

function BattleUnitBase:Init()
  self:OnInit()
end

function BattleUnitBase:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBoutBegin, self.OnBoutBegin, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBoutEnd, self.OnBoutEnd, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBattleEnd, self.OnBattleEnd, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterCreateSkillPhase, self.OnAfterCreateSkillPhase, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseCard, self.OnAfterUseCard, self)
end

function BattleUnitBase:IsAI()
  return self.originRoleData.isAI
end

function BattleUnitBase:UnregisterCallbacks()
  self.battleEngine:UnregisterAllEventsByTarget(self)
end

function BattleUnitBase:Serialize()
  local skillId, skillLevel = self:GetSkillIdAndLevel()
  local cmdServer = self:GetSkillCmd(skillId, skillLevel)
  local skillArgs, descArgs
  if cmdServer then
    skillArgs, descArgs = cmdServer:GetSkillArgs()
  end
  local silverKeyAwakeArgs, silverKeyAwakeDescArgs
  local silverKeyAwakeTid, silverKeyAwakeLevel = self:GetSilverKeyAwakeSkill()
  local silverKeyAwakeCmdServer = self:GetSkillCmd(silverKeyAwakeTid, silverKeyAwakeLevel)
  if silverKeyAwakeCmdServer then
    silverKeyAwakeArgs, silverKeyAwakeDescArgs = silverKeyAwakeCmdServer:GetSkillArgs()
  end
  local data = {
    uid = self.uid,
    tid = self.tid,
    camp = self.camp,
    properties = self.property:Serialize(),
    roleType = self.roleType,
    keeperSkill = skillId,
    level = self.level,
    schoolArgs = self.schoolCompPVE and self.schoolCompPVE:GetSchoolArgs(),
    schoolSpecialArgs = self.schoolCompPVE and self.schoolCompPVE:GetSchoolSpecialArgs(),
    schoolMap = self.schoolCompPVE and self.schoolCompPVE:GetSchoolMap(),
    skillArgs = skillArgs,
    descArgs = descArgs,
    intention = self.monsterBehaviorComp and self.monsterBehaviorComp:GetIntention(),
    damageInfo = self.monsterBehaviorComp and self.monsterBehaviorComp:GetDamageInfo() or {},
    monsterBehaviorData = self.monsterBehaviorComp and self.monsterBehaviorComp:Serialize() or nil,
    silverKeyAwakeArgs = silverKeyAwakeArgs,
    silverKeyAwakeDescArgs = silverKeyAwakeDescArgs
  }
  for k, v in pairs(self.data) do
    if type(v) == "table" then
      data[k] = table.deepclone(v)
    else
      data[k] = v
    end
  end
  return data
end

function BattleUnitBase:OnSnapShot()
  local skillId, skillLevel = self:GetSkillIdAndLevel()
  local cmdServer = self:GetSkillCmd(skillId, skillLevel)
  local skillArgs, descArgs
  if cmdServer then
    skillArgs, descArgs = cmdServer:GetSkillArgs()
  end
  local silverKeyAwakeArgs, silverKeyAwakeDescArgs
  local silverKeyAwakeTid, silverKeyAwakeLevel = self:GetSilverKeyAwakeSkill()
  local silverKeyAwakeCmdServer = self:GetSkillCmd(silverKeyAwakeTid, silverKeyAwakeLevel)
  if silverKeyAwakeCmdServer then
    silverKeyAwakeArgs, silverKeyAwakeDescArgs = silverKeyAwakeCmdServer:GetSkillArgs()
  end
  return {
    uid = self.uid,
    tid = self.tid,
    camp = self.camp,
    properties = self.property:Serialize(),
    roleType = self.roleType,
    keeperSkill = skillId,
    level = self.level,
    schoolArgs = self.schoolCompPVE and self.schoolCompPVE:GetSchoolArgs() or nil,
    schoolSpecialArgs = self.schoolCompPVE and self.schoolCompPVE:GetSchoolSpecialArgs() or nil,
    schoolMap = self.schoolCompPVE and self.schoolCompPVE:GetSchoolMap() or nil,
    skillArgs = skillArgs,
    descArgs = descArgs,
    monsterBehaviorData = self.monsterBehaviorComp and self.monsterBehaviorComp:OnSnapShot() or nil,
    silverKeyAwakeArgs = silverKeyAwakeArgs,
    silverKeyAwakeDescArgs = silverKeyAwakeDescArgs,
    data = self.data
  }
end

function BattleUnitBase:OnRecover(snapshotData)
  self.tagManager._initTagState = true
  if self.monsterBehaviorComp and snapshotData.monsterBehaviorData then
    self.monsterBehaviorComp:OnRecover(snapshotData.monsterBehaviorData)
  end
end

function BattleUnitBase:IsRoleType(roleType, orRoleType)
  return self.roleType == roleType or self.roleType == orRoleType
end

function BattleUnitBase:ChangeFsmState(newState, config)
  self.battleEngine.recordMgr:OnRoleChangeFsmState(self.uid, self.data.fsmState, newState, config)
  self.data.fsmState = newState
end

function BattleUnitBase:IsDead()
  return self.data.fsmState == bc.AwakerFsmState.Dead
end

function BattleUnitBase:HpIs0()
  return self:GetProperty(BP.hp) <= 0
end

function BattleUnitBase:AfterInit()
  if self.battleEngine:IsPVP() then
    self:AfterInit_PVP()
  end
  if self.battleEngine:IsPVE() then
    self:AfterInit_PVE()
  end
end

function BattleUnitBase:AfterInit_PVP()
  self:OnAfterInit_PVP()
end

function BattleUnitBase:AfterInit_PVE()
  self:OnAfterInit_PVE()
end

function BattleUnitBase:GetCamp()
  return self.camp
end

function BattleUnitBase:BeHit(attackConfig)
  local damageVal = attackConfig.damageVal
  local orgDamageVal = damageVal
  local isPreventActiveDamage = BattleUnitUtil.CheckPreventActiveDamage(self, attackConfig)
  local convertDamageVal = 0
  local pvp_death_resist = false
  local isBlockedAllDamage = false
  local isBlockedDamage = false
  local blockedDamage = 0
  local immued = false
  local damageSubType = attackConfig.damageSubType
  local blockLose = 0
  if self:ImmueDamage(attackConfig) then
    immued = true
    self.battleEngine:LogBattleWithTab("%s 免疫伤害，受到 %s 点伤害", self:GetBattleLogName(), damageVal)
    damageVal = 0
  else
    local blockSnapshot = self:GetProperty(BP.block)
    local damageBeforeShield = damageVal
    if blockSnapshot > 0 and damageBeforeShield > 0 then
      local blockAfterValue
      damageVal, blockedDamage, blockLose, isBlockedDamage, isBlockedAllDamage, blockAfterValue = BattleUnitUtil.CalcBlockedDamage(damageBeforeShield, damageSubType, blockSnapshot)
      local extraData = {
        castRoleUid = attackConfig.castRoleUid,
        reason = bc.PropertyChangeReason.BlockLose,
        cmdServerUid = attackConfig.fromCmdServerUid,
        castValue = orgDamageVal
      }
      self:SetProperty(BP.block, blockAfterValue, extraData)
    else
      damageVal = math.ceil(damageVal)
    end
  end
  local d = {
    castRoleUid = attackConfig.castRoleUid,
    reason = bc.PropertyChangeReason.Damage,
    cmdServerUid = attackConfig.fromCmdServerUid,
    castValue = orgDamageVal
  }
  if immued then
    d.reason = bc.PropertyChangeReason.DamageImmue
  elseif isBlockedAllDamage then
    d.reason = bc.PropertyChangeReason.DamageBlock
  elseif attackConfig.isCrit then
    d.reason = bc.PropertyChangeReason.DamageCrit
  end
  local hp = self:GetProperty(BP.hp)
  if isPreventActiveDamage then
    damageVal, convertDamageVal = BattleUnitUtil.ApplyPreventBeActiveDamageRetainHp(self, damageVal, hp)
  end
  damageVal, pvp_death_resist = BattleUnitUtil.ApplyIncomingDamageLimitsBeforeHpLoss(self, damageVal, hp, d)
  local curHp = self:SubProperty(BP.hp, damageVal, d)
  local realDamage = hp - curHp
  local overflowDamage
  if curHp <= 0 then
    overflowDamage = orgDamageVal - blockedDamage - hp
  end
  local loseHpConfig = {
    castRoleUid = attackConfig.castRoleUid,
    destRoleUid = self.uid,
    targetRoleUid = self.uid,
    changeVal = damageVal,
    curHp = curHp,
    curMaxHp = self:GetProperty(BP.max_hp),
    hpChangeReason = d.reason,
    immueDamage = immued,
    originVal = orgDamageVal,
    oldHp = hp,
    isCrit = attackConfig.isCrit,
    skillConfigId = attackConfig.skillConfigId,
    damageType = attackConfig.damageType,
    damageSubType = attackConfig.damageSubType,
    isBlockedDamage = isBlockedDamage,
    isBlockedAllDamage = isBlockedAllDamage,
    castDamage = attackConfig.damageVal,
    realDamage = realDamage,
    blockedDamage = blockedDamage,
    unBlockedDamage = realDamage,
    blockLose = blockLose,
    overflowDamage = overflowDamage,
    stateId = attackConfig.stateId,
    fromCmdServerUid = attackConfig.fromCmdServerUid,
    pvp_death_resist = pvp_death_resist,
    isPreventActiveDamage = isPreventActiveDamage,
    convertDamageVal = convertDamageVal,
    ignoreStats = attackConfig.ignoreStats
  }
  self.battleEngine.recordMgr:OnBeHit(self.uid, loseHpConfig)
  self:TryChangeToBeHitState(attackConfig, loseHpConfig, isBlockedAllDamage, immued, isPreventActiveDamage)
  self:DoDamageEvent(loseHpConfig)
  return loseHpConfig
end

function BattleUnitBase:TryChangeToBeHitState(attackConfig, loseHpConfig, isBlockedAllDamage, immued, forceBeHit)
  local shouldChangeState = false
  local isSilentBeHitDamage = attackConfig.damageType == bc.DamageType.Passive or attackConfig.damageType == bc.DamageType.Pure or attackConfig.damageType == bc.DamageType.Fixed
  if self.battleEngine:IsPVP() then
    shouldChangeState = not isSilentBeHitDamage or 1 == attackConfig.enterBeHit
  else
    shouldChangeState = (not isSilentBeHitDamage or 1 == attackConfig.enterBeHit) and (forceBeHit or not isBlockedAllDamage and not immued)
  end
  if shouldChangeState then
    self:ChangeFsmState(bc.AwakerFsmState.BeHit, loseHpConfig)
  end
end

function BattleUnitBase:DoDamageEvent(loseHpConfig)
  if self.battleEngine:IsBattleFinish() then
    return
  end
  if loseHpConfig.isPreventActiveDamage then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.DoPreventedActiveDamage, loseHpConfig)
    self.battleEngine:CreateEventEffect(BattleLogicEvent.PreventBeActiveDamage, loseHpConfig)
  end
  if loseHpConfig.damageType == bc.DamageType.Active then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.DoDamage, loseHpConfig)
  elseif loseHpConfig.damageType == bc.DamageType.Passive then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.DoDamage, loseHpConfig)
  elseif loseHpConfig.damageType == bc.DamageType.Pure then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.DoDamage, loseHpConfig)
  elseif loseHpConfig.damageType == bc.DamageType.Fixed then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.DoDamage, loseHpConfig)
  elseif loseHpConfig.damageType == bc.DamageType.Tentacle then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.TentacleAttack, loseHpConfig)
    self.battleEngine:CreateEventEffect(BattleLogicEvent.AttackedByTentacle, loseHpConfig)
    self.battleEngine:CreateEventEffect(BattleLogicEvent.DoTentacleDamage, loseHpConfig)
  end
  self.battleEngine:CreateEventEffect(BattleLogicEvent.BeDamage, loseHpConfig)
  if loseHpConfig.pvp_death_resist then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.PVPDeathResist, loseHpConfig)
  end
  self:CheckDeathEvent(loseHpConfig.castRoleUid, loseHpConfig.fromCmdServerUid, loseHpConfig.hpChangeReason, loseHpConfig)
  if self:GetProperty(bc.BattleProperty.hp) <= 0 then
    if loseHpConfig.damageType == bc.DamageType.Active then
      self.battleEngine:CreateEventEffect(BattleLogicEvent.ActiveDamageKill, loseHpConfig)
    end
    if loseHpConfig.damageType == bc.DamageType.Fixed then
      self.battleEngine:CreateEventEffect(BattleLogicEvent.FixedDamageKill, loseHpConfig)
    end
    if loseHpConfig.isCrit then
      self.battleEngine:CreateEventEffect(BattleLogicEvent.CritKill, loseHpConfig)
    end
    if loseHpConfig.damageType == bc.DamageType.Passive and BattleUtilServer.IsFightBackState(self.battleEngine, loseHpConfig.stateId) then
      self.battleEngine:CreateEventEffect(BattleLogicEvent.FightBackKill, loseHpConfig)
    end
  end
end

function BattleUnitBase:ImmueDamage(attackConfig)
  if attackConfig.damageSubType == bc.DamageSubType.Puncture and self:GetProperty(BP.immue_puncture_damage) > 0 then
    return true
  end
  if attackConfig.damageType == bc.DamageType.Active and (self:GetProperty(BP.immue_active_damage) > 0 or self:GetProperty(BP.immue_damage) > 0) then
    if attackConfig.damageSubType == bc.DamageSubType.Puncture then
      return false
    end
    return true
  end
  if attackConfig.damageType == bc.DamageType.Passive and (self:GetProperty(BP.immue_passive_damage) > 0 or self:GetProperty(BP.immue_damage) > 0) then
    if attackConfig.damageSubType == bc.DamageSubType.Puncture then
      return false
    end
    return true
  end
  if attackConfig.damageType == bc.DamageType.Fixed and (self:GetProperty(BP.immue_fixed_damage) > 0 or self:GetProperty(BP.immue_damage) > 0) then
    if attackConfig.damageSubType == bc.DamageSubType.Puncture then
      return false
    end
    return true
  end
  if attackConfig.damageType == bc.DamageType.Tentacle and (self:GetProperty(BP.immue_tentacle_damage) > 0 or self:GetProperty(BP.immue_damage) > 0) then
    if attackConfig.damageSubType == bc.DamageSubType.Puncture then
      return false
    end
    return true
  end
  if attackConfig.damageType == bc.DamageType.Pure and (self:GetProperty(BP.immue_pure_damage) > 0 or self:GetProperty(BP.immue_damage) > 0) then
    if attackConfig.damageSubType == bc.DamageSubType.Puncture then
      return false
    end
    return true
  end
  return false
end

function BattleUnitBase:CheckDeathEvent(castRoleUid, fromCmdServerUid, hpChangeReason, loseHpConfig)
  if not self:PreCheckDeathEvent() then
    return
  end
  if self:GetProperty(bc.BattleProperty.hp) > 0 then
    return
  end
  if self:IsDead() then
    return
  end
  local effectMgr = self.battleEngine.effectMgr
  local dDEffectType = bc.BattleEffectType.BERoleDeadlyDamage
  local dDEffectConfig = {
    effectType = dDEffectType,
    roleUid = self.uid,
    castRoleUid = castRoleUid,
    fromCmdServerUid = fromCmdServerUid,
    hpChangeReason = hpChangeReason,
    castDamage = loseHpConfig and loseHpConfig.castDamage,
    overflowDamage = loseHpConfig and loseHpConfig.overflowDamage
  }
  effectMgr:CreateEffect(dDEffectConfig)
  local effectType = bc.BattleEffectType.BERoleDie
  local effectConfig = {
    effectType = effectType,
    roleUid = self.uid,
    fromCmdServerUid = fromCmdServerUid,
    hpChangeReason = hpChangeReason
  }
  effectMgr:CreateEffect(effectConfig)
end

function BattleUnitBase:RoleDie(deadConfig)
  self.battleEngine:LogBattleWithTab("%s 死亡", self:GetBattleLogName())
  self:ChangeFsmState(bc.AwakerFsmState.Dead, deadConfig)
  local eventData = {
    roleUid = self.uid
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.RoleDead, eventData)
end

function BattleUnitBase:OnPropertyChanged(propertyName, preValue, curValue, extraData)
  if propertyName == BP.hp or propertyName == BP.max_hp then
    self:OnPropertyChange_Hp(propertyName, preValue, curValue, extraData)
  end
  if propertyName == BP.block then
    self:OnPropertyChange_Block(propertyName, preValue, curValue, extraData)
  end
  if propertyName == BP.ban_pvp_weapon then
    self:OnPropertyChange_BanPVPWeapon(propertyName, preValue, curValue, extraData)
  end
  if propertyName == BP.monster_hide and self:IsRoleType(bc.RoleType.Monster) then
    self.battleEngine.roleMgr:MonsterHide(self.uid, curValue)
  end
  self:OnPropertyChange_BattleLog(propertyName, preValue, curValue, extraData)
end

function BattleUnitBase:OnPropertyChange_Hp(propertyName, preValue, curValue, extraData)
  local eventData = {
    uid = self.uid,
    oldValue = preValue,
    newValue = curValue,
    castRoleUid = extraData.castRoleUid
  }
  if propertyName == BP.hp then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.RoleHpChanged, eventData)
  end
  eventData.max_hp = self:GetProperty(BP.max_hp)
  eventData.hp = self:GetProperty(BP.hp)
  eventData.propertyName = propertyName
  self.battleEngine:CreateEventEffect(BattleLogicEvent.RoleHpperChanged, eventData)
end

function BattleUnitBase:OnPropertyChange_Block(_, _, curValue, extraData)
  local eventData = {
    castRoleUid = extraData.castRoleUid,
    targetRoleUid = self.uid,
    castValue = extraData.castValue,
    cmdServerUid = extraData.cmdServerUid,
    curValue = curValue
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.BlockChange, eventData)
end

function BattleUnitBase:OnPropertyChange_BattleLog(propertyName, preValue, curValue, _)
  local DT = self.battleEngine.battleDT
  if DT.BattleApi[propertyName] and preValue ~= curValue then
    preValue = preValue or 0
    local name = self:GetBattleLogName()
    local deltaVal = curValue - preValue
    if deltaVal >= 0 then
      deltaVal = "+" .. deltaVal
    end
    self.battleEngine:LogBattleWithTab("属性变化：%s [ %s ] %s (%s -> %s)", name, DT.BattleApi[propertyName].CnID, deltaVal, preValue, curValue)
    if bc.TentacleNameConvert[propertyName] then
      local val = self:GetProperty(bc.TentacleNameConvert[propertyName])
      local pName = DT.BattleApi[bc.TentacleNameConvert[propertyName]].CnID
      self.battleEngine:LogBattleWithTab("%s [ %s ] 变为 %s", name, pName, val)
    end
  end
end

function BattleUnitBase:OnPropertyChange_BanPVPWeapon(_, preValue, curValue, extraData)
  local action
  if 0 == preValue and curValue > 0 then
    action = bc.BanPVPWeaponAction.Ban
  elseif preValue > 0 and 0 == curValue then
    action = bc.BanPVPWeaponAction.Release
  else
    return
  end
  local stateList = self.battleEngine.stateMgr:GetStateListByOwnerUid(self.uid)
  for _, state in ipairs(stateList) do
    if not state.isDeleted and state.configData.TypeLabel == "WeaponState" then
      state:BanPropertyAndTrigger(action)
    end
  end
  local eventData = {
    castRoleUid = extraData.castRoleUid,
    targetRoleUid = self.uid,
    curValue = curValue,
    action = action
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.BanPVPWeaponAction, eventData)
end

function BattleUnitBase:ModifyHp(modifyConfig)
  local value = modifyConfig.modifyVal
  local oldHp = self:GetProperty(BP.hp)
  local pvp_death_resist
  if self:GetProperty(BP.pvp_death_resist) > 0 and value < 0 and oldHp <= math.abs(value) then
    value = (oldHp - 1) * -1
    pvp_death_resist = true
  end
  local reason = bc.PropertyChangeReason.AttrModify
  local extraData = {
    castRoleUid = modifyConfig.castRoleUid,
    reason = reason,
    castValue = modifyConfig.modifyVal,
    cmdServerUid = modifyConfig.cmdServerUid
  }
  local curHp = self:ChangeProperty(BP.hp, value, extraData)
  self.battleEngine:CreateEventEffect(BattleLogicEvent.ModifyHp, modifyConfig)
  local loseHpConfig = {
    castRoleUid = modifyConfig.castRoleUid,
    destRoleUid = modifyConfig.destRoleUid,
    targetRoleUid = self.uid,
    changeVal = value,
    curHp = curHp,
    curMaxHp = self:GetProperty(BP.max_hp),
    hpChangeReason = reason,
    originVal = modifyConfig.modifyVal,
    oldHp = oldHp,
    pvp_death_resist = pvp_death_resist
  }
  if loseHpConfig.pvp_death_resist then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.PVPDeathResist, loseHpConfig)
  end
  if self:GetProperty(BP.hp) <= 0 then
    self:CheckDeathEvent(loseHpConfig.castRoleUid, loseHpConfig.fromCmdServerUid, loseHpConfig.hpChangeReason)
  end
end

function BattleUnitBase:UseSkill(skillId, skillLevel, beforeEffType, afterEffType, targetUids)
  if not skillId then
    skillId, skillLevel = self:GetSkillIdAndLevel()
  end
  local DT = self.battleEngine.battleDT
  
  local function preFunc()
    local skillConfig = DT.Skill[skillId]
    self.battleEngine:LogBattleWithTab("%s 释放技能: %s 等级: %s", self:GetBattleLogName(), skillConfig.CnID, skillLevel)
    self.battleEngine.roleMgr:SetCurCaster(self.uid)
    self:CreateSkillEffect(skillId, skillLevel, beforeEffType, afterEffType, targetUids)
  end
  
  local finishCb = {
    func = function()
    end,
    data = {}
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleUnitBase:InitSkillCmdServer(skillId, skillLevel, attachPostParam, forceCmdServer)
  local cmdServer = forceCmdServer or self:GetSkillCmd(skillId, skillLevel)
  if not cmdServer then
    return nil
  end
  cmdServer.attachPostParam = attachPostParam
  if cmdServer:HasMemberValue("ForceSuperUltiSkill") then
    local forceSuper = tonumber(cmdServer:GetMemberValue("ForceSuperUltiSkill")) or 0
    if 1 == forceSuper then
      cmdServer.cmdParser:SetMemberValue("SuperUtliSkill", 1)
    end
  end
  if cmdServer.cmdParser:GetSkillType() and self:IsRoleType(bc.RoleType.Awaker) and self:CanUseSuperUtlSkill() then
    cmdServer.cmdParser:SetMemberValue("SuperUtliSkill", 1)
  end
  return cmdServer
end

function BattleUnitBase:CreateSkillTargetEffects(skillId, skillLevel, cmdServer, targetUids)
  local skillConfig = self.battleEngine.battleDT.Skill[skillId]
  if targetUids then
    local targetList = {}
    for _, targetUid in ipairs(targetUids) do
      table.insert(targetList, self.battleEngine:GetObj(targetUid))
    end
    cmdServer:SetUpperTargets(targetList)
    return
  end
  local caster = self.battleEngine:GetObj(self.uid)
  local breakSkillLevel, potencyLevel
  if caster and caster:IsRoleType(bc.RoleType.Awaker) then
    breakSkillLevel, potencyLevel = caster:GetBreakSkillAndPotencyLevel()
  end
  local targetType = self.battleEngine:GetSkillTargetType(self.uid, skillId, skillLevel, breakSkillLevel, potencyLevel)
  if skillConfig.OverLimitUtlSkillTarget and 1 == cmdServer.cmdParser:IsSuperUtlSkill() then
    targetType = skillConfig.OverLimitUtlSkillTarget
  end
  local targetEffectConfig = {
    effectType = bc.BattleEffectType.BEGenerateTargets,
    cmdServer = cmdServer,
    targetType = targetType,
    castRoleUid = self.uid,
    cancelable = true
  }
  self.battleEngine.effectMgr:CreateEffect(targetEffectConfig)
end

function BattleUnitBase:CreateSkillBeforeEffects(skillId, skillLevel, beforeEffType, cmdServer, keeperSkill)
  local cardArgs, descArgs = cmdServer:GetSkillArgs()
  local skillToCard = {
    configId = skillId,
    showCost = "",
    level = skillLevel,
    descArgs = descArgs,
    cardArgs = cardArgs,
    deck = bc.CardDeck.NoneDeck,
    properties = {},
    uid = -1,
    roleUid = self.uid,
    ownerUid = self.uid,
    camp = self.camp,
    stateList = {}
  }
  local beforeEffectConfig = {
    effectType = beforeEffType,
    skillId = skillId,
    castRoleUid = self.uid,
    level = skillLevel,
    skillToCard = skillToCard,
    cmdServer = cmdServer,
    keeperSkill = keeperSkill or self.curKeeperSkill
  }
  self.battleEngine.effectMgr:CreateEffect(beforeEffectConfig)
end

function BattleUnitBase:CreateSkillExecutePhaseEffects(skillId, skillLevel, cmdServer)
  local skillConfig = self.battleEngine.battleDT.Skill[skillId]
  if skillConfig.PreCmd then
    local preCmdServer = self:GetSkillCmd(skillId, skillLevel, true)
    local preCmdEffectConfig = {
      effectType = bc.BattleEffectType.BECreateSkillPhase,
      castRoleUid = self.uid,
      cmdServer = preCmdServer,
      skipPhase = true
    }
    self.battleEngine.effectMgr:CreateEffect(preCmdEffectConfig)
  end
  local skillEffectConfig = {
    effectType = bc.BattleEffectType.BECreateSkillPhase,
    castRoleUid = self.uid,
    cmdServer = cmdServer
  }
  self.battleEngine.effectMgr:CreateEffect(skillEffectConfig)
end

function BattleUnitBase:CreateSkillAfterEffects(skillId, skillLevel, afterEffType, cmdServer, attachPostParam, keeperSkill)
  local endEffectConfig = {
    effectType = afterEffType,
    skillId = skillId,
    castRoleUid = self.uid,
    level = skillLevel,
    cmdServer = cmdServer,
    keeperSkill = keeperSkill or self.curKeeperSkill
  }
  self.battleEngine.effectMgr:CreateEffect(endEffectConfig)
  if attachPostParam then
    local attachEventData = {
      executorUid = self.uid,
      cmdServerUid = cmdServer.uid,
      skillTid = skillId
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.AfterAttachPostAction, attachEventData)
  end
end

function BattleUnitBase:CreateSkillEffect(skillId, skillLevel, beforeEffType, afterEffType, targetUids, attachPostParam, forceCmdServer, keeperSkill)
  local cmdServer = self:InitSkillCmdServer(skillId, skillLevel, attachPostParam, forceCmdServer)
  if not cmdServer then
    return
  end
  self:CreateSkillTargetEffects(skillId, skillLevel, cmdServer, targetUids)
  beforeEffType = beforeEffType or self:GetBeforeSkillEffectType()
  self:CreateSkillBeforeEffects(skillId, skillLevel, beforeEffType, cmdServer, keeperSkill)
  self:CreateSkillExecutePhaseEffects(skillId, skillLevel, cmdServer)
  afterEffType = afterEffType or self:GetAfterSkillEffectType()
  self:CreateSkillAfterEffects(skillId, skillLevel, afterEffType, cmdServer, attachPostParam, keeperSkill)
end

function BattleUnitBase:GetSkillCmd(skillId, skillLevel, isPre)
  if not skillId or 0 == skillId then
    return
  end
  local skillConfig = self.battleEngine.battleDT.Skill[skillId]
  local cmdField = "CmdList"
  local cmdCtorData = {}
  cmdCtorData.skillLevel = skillLevel
  cmdCtorData.skillConfigId = skillId
  cmdCtorData.cmdId = skillConfig.CmdList
  if isPre then
    cmdCtorData.cmdId = skillConfig.PreCmd
    cmdField = "PreCmd"
  end
  if skillConfig.IsPVP then
    local ctorData = {
      castRoleUid = self.uid,
      skillConfigId = skillId,
      skillLevel = skillLevel
    }
    cmdCtorData.cmdId = self.battleEngine:GetValByCondList(ctorData, skillId, cmdField)
  end
  cmdCtorData.castRoleUid = self.uid
  do return BattleCmdServer, self.battleEngine end
  return BattleCmdServer, self.battleEngine, cmdCtorData, ctorData, skillId, cmdField
end

function BattleUnitBase:GainBlock(value, configValue, extraData)
  value = math.max(value, 0)
  self:ChangeProperty(BP.block, value, extraData)
  if value > 0 then
    local eventData = {
      castRoleUid = extraData.castRoleUid,
      targetRoleUid = self.uid,
      castValue = value,
      cmdServerUid = extraData.cmdServerUid
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.DoBlock, eventData)
    self.battleEngine:CreateEventEffect(BattleLogicEvent.BeBlock, eventData)
  end
end

function BattleUnitBase:ReplaceClientTarget(cmdServer, targetUids)
  if self.battleEngine:IsPVP() and targetUids then
    local data = cmdServer:GetTargetOnlyGenerate()
    if data and data.replaceClientTarget then
      return data.targetUids
    end
  end
  return false
end

function BattleUnitBase:CanUseCard(cardUid, targetUids, replaceUids)
  local card = self.battleEngine:GetObj(cardUid)
  if not card or card.deck ~= bc.CardDeck.HandDeck then
    self.battleEngine:Warn("ERROR: 试图使用不在手上卡牌", cardUid)
    return false, bc.CardFailedReason.NotInHand
  end
  if card:CardTypeMatch(bc.SkillType.Keeper_Skill) then
    local player = self.battleEngine.roleMgr:GetPlayer(self.camp)
    do return player.CanUseHandKeeperSkill, player end
    return player.CanUseHandKeeperSkill, player, card, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  if not card:JudgeCost() then
    return false, bc.CardFailedReason.Useless
  end
  if card:GetProperty(BP.useless) and card:GetProperty(BP.useless) > 0 then
    return false, bc.CardFailedReason.Useless
  end
  if self:GetProperty(BP.card_useless) and self:GetProperty(BP.card_useless) > 0 then
    return false, bc.CardFailedReason.Useless
  end
  local cmdId = card:GetCmdId()
  if not cmdId then
    return false, bc.CardFailedReason.Useless
  end
  if self:IsDead() then
    return false, bc.CardFailedReason.Dead
  end
  local player = self.battleEngine.roleMgr:GetPlayer(self.camp)
  local coma = self:GetProperty(BP.PVPComa)
  local immueComa = self:GetProperty(BP.PVPImmue_Coma)
  if coma and coma > 0 and (not immueComa or 0 == immueComa) then
    return false, bc.CardFailedReason.Coma
  end
  local forbitUseCard = self:GetProperty(BP.forbit_use_card)
  if forbitUseCard and forbitUseCard > 0 then
    return false, bc.CardFailedReason.Useless
  end
  forbitUseCard = player:GetProperty(BP.forbit_use_card)
  if forbitUseCard and forbitUseCard > 0 then
    return false, bc.CardFailedReason.Useless
  end
  local forbitStrike = self:GetProperty(BP.forbit_strike_card)
  local playerforbitStrike = player:GetProperty(BP.forbit_strike_card)
  if card:CardTypeMatch(bc.SkillType.Card_Strike) and (forbitStrike > 0 or playerforbitStrike > 0) then
    return false, bc.CardFailedReason.Useless
  end
  if not card:IsXCost() then
    local cost = card:GetUseCost()
    if player:EnergyEnough(cost) then
      card:ResetAllowIgnoreCost()
    elseif not card:AllowIgnoreCost() then
      return false, bc.CardFailedReason.NoEnergy
    end
  end
  if self.battleEngine:IsPVP() and targetUids and not replaceUids then
    local cmdServer = card:GetCardCmdServer()
    local ret = cmdServer:CheckClientTargets(targetUids)
    if not ret then
      self.battleEngine.gameplay:SetTargetModel(player.uid, bc.PVPTargetModel.Server)
      return ret, bc.CardFailedReason.TargetNotMatch
    end
  end
  return true
end

function BattleUnitBase:IsCardHardBlockedFromPlay(card)
  if card:GetProperty(BP.useless) and card:GetProperty(BP.useless) > 0 then
    return true
  end
  if self.battleEngine.stateMgr:HasStateByStateIds(card.uid, {81340}) then
    return true
  end
  if self:GetProperty(BP.card_useless) and self:GetProperty(BP.card_useless) > 0 then
    return true
  end
  return false
end

function BattleUnitBase:AppendUseCardEffectChain(cardUid, targetUids)
  local curCamp = self.camp
  local card = self.battleEngine:GetObj(cardUid)
  if not card then
    self.battleEngine:Warn("使用卡牌失敗：找不到卡牌", cardUid)
    return false
  end
  if card:CardTypeMatch(bc.SkillType.Keeper_Skill) then
    do return self.AppendUseKeeperFromHandChain, self, cardUid end
    return self.AppendUseKeeperFromHandChain, self, cardUid, targetUids, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  if self:IsCardHardBlockedFromPlay(card) then
    local cmdServerEarly = card:GetCardCmdServer()
    if cmdServerEarly then
      cmdServerEarly:SetMemberValue("ForceConsumeMode", nil)
    end
    self.battleEngine:Warn("打牌链已阻止：卡牌封印/无用或唤醒体禁卡 cardUid=%s", cardUid)
    return false
  end
  self.battleEngine.roleMgr:SetCurCaster(self.uid)
  self.battleEngine.cardMgr:SetCurUseCard(card, self.uid)
  local cmdServer = card:GetCardCmdServer()
  if targetUids then
    local targetList = {}
    for _, targetUid in ipairs(targetUids) do
      table.insert(targetList, self.battleEngine:GetObj(targetUid))
    end
    cmdServer:SetUpperTargets(targetList)
  else
    local targetEffectConfig = {
      effectType = bc.BattleEffectType.BEGenerateTargets,
      cmdServer = cmdServer,
      targetType = card:GetCmdTarget(),
      camp = curCamp,
      castRoleUid = self.uid,
      cancelable = true,
      clientTargetUids = targetUids
    }
    self.battleEngine.effectMgr:CreateEffect(targetEffectConfig)
  end
  local beforeEffectConfig = {
    effectType = bc.BattleEffectType.BEBeforeUseCard,
    castRoleUid = self.uid,
    cardUid = cardUid,
    cmdServer = cmdServer
  }
  self.battleEngine.effectMgr:CreateEffect(beforeEffectConfig)
  local preCmdServer = card:GetCardPreCmdServer()
  if preCmdServer then
    local preCmdEffectConfig = {
      effectType = bc.BattleEffectType.BECreateSkillPhase,
      castRoleUid = self.uid,
      cmdServer = preCmdServer,
      cardUid = cardUid,
      skipPhase = true
    }
    self.battleEngine.effectMgr:CreateEffect(preCmdEffectConfig)
  end
  local cardEffectConfig = {
    effectType = bc.BattleEffectType.BECreateSkillPhase,
    castRoleUid = self.uid,
    cmdServer = cmdServer,
    cardUid = cardUid
  }
  self.battleEngine.effectMgr:CreateEffect(cardEffectConfig)
  local endEffectConfig = {
    effectType = bc.BattleEffectType.BEAfterUseCard,
    castRoleUid = self.uid,
    cardUid = cardUid,
    camp = curCamp
  }
  self.battleEngine.effectMgr:CreateEffect(endEffectConfig)
  return true
end

function BattleUnitBase:AppendUseKeeperFromHandChain(cardUid, targetUids)
  local card = self.battleEngine:GetObj(cardUid)
  if not card then
    self.battleEngine:Warn("手牌钥令打出失败：找不到卡牌", cardUid)
    return false
  end
  local player = self.battleEngine.roleMgr:GetPlayer(self.camp)
  if not player then
    return false
  end
  local skillId = card.tid
  local skillLevel = card.level or 1
  local skillCfg = self.battleEngine.battleDT.Skill[skillId]
  if not skillCfg then
    self.battleEngine:Warn("手牌钥令打出失败：无技能配置 tid=%s", skillId)
    return false
  end
  local ForceConsumeMode = bc.ForceConsumeMode
  local handKeeperSkillParam = card.data.handKeeperSkillParam or {}
  local consumeMode = handKeeperSkillParam.handKeeperFree and ForceConsumeMode.IgnoreCost or ForceConsumeMode.FullPay
  local countAfter = handKeeperSkillParam.handKeeperCountAfter or 0
  local keeperSkill = player:CreateKeeperSkill(skillId, {
    randUnlockSourceId = handKeeperSkillParam.randUnlockSourceId,
    isBlankMemory = handKeeperSkillParam.isBlankMemory
  })
  local cmdServer = player:GetSkillCmd(skillId, skillLevel)
  if not cmdServer then
    self.battleEngine:Warn("手牌钥令打出失败：无 cmdServer tid=%s", skillId)
    return false
  end
  cmdServer:SetMemberValue("ForceConsumeMode", consumeMode)
  cmdServer:SetMemberValue("ForceCountAfter", countAfter)
  cmdServer:SetMemberValue("HandKeeperClearCurCard", 1)
  if self.battleEngine:IsPVE() and handKeeperSkillParam.randUnlockSourceId ~= nil and keeperSkill then
    player:OnSelectRandUnlockKeeperSkillPack(handKeeperSkillParam.randUnlockSourceId, {keeperSkill})
  end
  self.battleEngine.roleMgr:SetCurCaster(player.uid)
  self.battleEngine.cardMgr:SetCurUseCard(card, player.uid)
  self.battleEngine:LogBattleWithTab("%s 打出手牌钥令: %s 等级: %s 免费:%s 计次:%s", player:GetBattleLogName(), skillCfg.CnID, skillLevel, handKeeperSkillParam.handKeeperFree and 1 or 0, countAfter)
  cmdServer:SetMemberValue("banAfterUseKeeperSkill", handKeeperSkillParam.banAfterUseKeeperSkill)
  player:CreateSkillEffect(skillId, skillLevel, bc.BattleEffectType.BEUseKeeperSkill, bc.BattleEffectType.BEAfterUseKeeperSkill, targetUids, nil, cmdServer, keeperSkill)
  local consumedDeckExp = cmdServer.cmdParser:GenerateCardDeckExp(bc.CardDeck.ConsumedDeck)
  self.battleEngine.effectMgr:CreateEffect({
    effectType = bc.BattleEffectType.BEMoveCard,
    castRoleUid = player.uid,
    cmdServer = cmdServer,
    targets = {card},
    params = {consumedDeckExp}
  })
  return true
end

function BattleUnitBase:UseCard(cardUid, targetUids)
  local function preFunc()
    self:AppendUseCardEffectChain(cardUid, targetUids)
  end
  
  local finishCb = {}
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleUnitBase:UseAttachPostCard(skillTid, skillLevel, attachPostParam)
  local camp = self:GetCamp()
  local destCard = bc.CardDeck.NoneDeck
  local cardInfo = {
    tid = skillTid,
    deck = destCard,
    camp = camp,
    owner = self,
    level = skillLevel
  }
  local tempCard = self.battleEngine.cardMgr:CreateCardByInfo(cardInfo)
  local cmdServer = tempCard:GetCardCmdServer()
  if cmdServer then
    cmdServer.attachPostParam = attachPostParam
  end
  self.battleEngine.recordMgr:OnAddNewCard({
    tempCard:Serialize()
  }, destCard, true, self.camp)
  self.battleEngine.cardMgr:SetCurUseCard(tempCard, self.uid)
  local targetEffectConfig = {
    effectType = bc.BattleEffectType.BEGenerateTargets,
    cmdServer = cmdServer,
    targetType = tempCard:GetCmdTarget(),
    camp = camp,
    castRoleUid = self.uid,
    cancelable = true,
    clientTargetUids = {}
  }
  self.battleEngine.effectMgr:CreateEffect(targetEffectConfig)
  local beforeEffectConfig = {
    effectType = bc.BattleEffectType.BEBeforeUseCard,
    castRoleUid = self.uid,
    cardUid = tempCard.uid,
    cmdServer = cmdServer
  }
  self.battleEngine.effectMgr:CreateEffect(beforeEffectConfig)
  local preCmdServer = tempCard:GetCardPreCmdServer()
  if preCmdServer then
    local preCmdEffectConfig = {
      effectType = bc.BattleEffectType.BECreateSkillPhase,
      castRoleUid = self.uid,
      cmdServer = preCmdServer,
      cardUid = tempCard.uid,
      skipPhase = true
    }
    self.battleEngine.effectMgr:CreateEffect(preCmdEffectConfig)
  end
  local cardEffectConfig = {
    effectType = bc.BattleEffectType.BECreateSkillPhase,
    castRoleUid = self.uid,
    cmdServer = cmdServer,
    cardUid = tempCard.uid
  }
  self.battleEngine.effectMgr:CreateEffect(cardEffectConfig)
  local endEffectConfig = {
    effectType = bc.BattleEffectType.BEAfterUseCard,
    castRoleUid = self.uid,
    cardUid = tempCard.uid,
    camp = self.camp
  }
  self.battleEngine.effectMgr:CreateEffect(endEffectConfig)
  return true
end

function BattleUnitBase:Heal(baseValue, extraData)
  local hp = self:GetProperty(BP.hp)
  local oldHp = hp
  hp = math.ceil(hp + baseValue)
  local maxHP = self:GetProperty(BP.max_hp)
  local overFlowHeal = math.max(0, hp - maxHP)
  hp = math.min(hp, maxHP)
  self:SetProperty(BP.hp, hp, extraData)
  local realHeal = hp - oldHp
  return realHeal, overFlowHeal
end

function BattleUnitBase:SetMonsterAnimIdx(animIdx)
  self.data.animIdx = animIdx
end

function BattleUnitBase:GetDamagePer2MonsterType(target)
  local DT = self.battleEngine.battleDT
  local monsterConfig = DT.MonsterConfig[target.tid]
  if not monsterConfig then
    return 0
  end
  local property = 0
  for _, propertyName in pairs(bc.DamagePer2MonsterType) do
    local apiCfg = DT.BattleApi[propertyName]
    if string.find(apiCfg.Data, monsterConfig.BattleTag) then
      property = property + (self:GetProperty(propertyName) or 0)
    end
  end
  return property
end

function BattleUnitBase:GetDamagePer2BuffEnemy(target)
  if self.battleEngine.stateMgr:HasStateByType(target.uid, bc.BuffType.Buff) then
    local damage_per2buff_enemy = self:GetProperty(BP.damage_per2buff_enemy) or 0
    return damage_per2buff_enemy
  end
  return 0
end

function BattleUnitBase:GetDamagePer2DebuffEnemy(target)
  if self.battleEngine.stateMgr:HasStateByType(target.uid, bc.BuffType.Debuff) then
    local damage_per2debuff_enemy = self:GetProperty(BP.damage_per2debuff_enemy) or 0
    return damage_per2debuff_enemy
  end
  return 0
end

function BattleUnitBase:GetDamagePer2Block(target)
  if target:GetProperty(BP.block) > 0 then
    local damage_per2block_enemy = self:GetProperty(BP.damage_per2block_enemy)
    return damage_per2block_enemy
  end
  return 0
end

function BattleUnitBase:GetDamagePer2BlockBarrier(target)
  local propertyName = BP.damage_per2block_barrier
  local property = self:GetProperty(propertyName) or 0
  if target:GetProperty(BP.block) > 0 then
    return property
  end
  local DT = self.battleEngine.battleDT
  local apiCfg = DT.BattleApi[propertyName]
  local stateList = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
  if self.battleEngine.stateMgr:HasStateByStateIds(target.uid, stateList) then
    return property
  end
  return 0
end

function BattleUnitBase:GetDamagePer2HasState(target)
  local rate = 1
  local properties = self:GetDamagePer2HasStateValue(target)
  for _, v in pairs(properties) do
    rate = rate * (1 + v / 100)
  end
  return rate
end

function BattleUnitBase:GetDamagePer2HasStateValue(target)
  local ret = {}
  local DT = self.battleEngine.battleDT
  local specialProperties = self.battleEngine.battleDT:GetOriginalConstant("DamagePer2HasState", {})
  for _, propertyName in ipairs(specialProperties) do
    local apiCfg = DT.BattleApi[propertyName]
    if not apiCfg or not apiCfg.Data then
    else
      local stateList = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
      if self.battleEngine.stateMgr:HasStateByStateIds(target.uid, stateList) then
        local property = self:GetProperty(propertyName) or 0
        if property > 0 then
          ret[propertyName] = property
        end
      end
    end
  end
  return ret
end

function BattleUnitBase:GetTotalDamagePer2HasState(target, ret)
  local properties = self:GetDamagePer2HasStateValue(target)
  for propertyName, v in pairs(properties) do
    ret[propertyName] = (ret[propertyName] or 0) + v
  end
  return ret
end

function BattleUnitBase:GetCardTargetChange()
end

function BattleUnitBase:UpdateSkillArgs()
  local skillId, skillLevel = self:GetSkillIdAndLevel()
  local cmdServer = self:GetSkillCmd(skillId, skillLevel)
  if not cmdServer then
    return
  end
  local skillArgs, descArgs = cmdServer:GetSkillArgs()
  self.battleEngine.recordMgr:OnSkillArgs(self.uid, skillArgs, descArgs)
end

function BattleUnitBase:UpdateSilverKeyAwakeArgs()
  local skillId, skillLevel = self:GetSilverKeyAwakeSkill()
  local cmdServer = self:GetSkillCmd(skillId, skillLevel)
  if not cmdServer then
    return
  end
  local skillArgs, descArgs = cmdServer:GetSkillArgs()
  self.battleEngine.recordMgr:OnSilverKeyAwakeArgs(self.uid, skillArgs, descArgs)
end

function BattleUnitBase:GetProperty(...)
  do return self.property.GetProperty, self.property, ... end
  return self.property.GetProperty, self.property, ...
end

function BattleUnitBase:ChangeProperty(...)
  do return self.property.ChangeProperty, self.property, ... end
  return self.property.ChangeProperty, self.property, ...
end

function BattleUnitBase:AddProperty(...)
  do return self.property.AddProperty, self.property, ... end
  return self.property.AddProperty, self.property, ...
end

function BattleUnitBase:SubProperty(...)
  do return self.property.SubProperty, self.property, ... end
  return self.property.SubProperty, self.property, ...
end

function BattleUnitBase:SetProperty(...)
  do return self.property.SetProperty, self.property, ... end
  return self.property.SetProperty, self.property, ...
end

function BattleUnitBase:OnBoutBegin()
  if self.battleEngine:IsPVP() then
    self:OnBoutBegin_PVP()
  end
  if self.battleEngine:IsPVE() then
    self:OnBoutBegin_PVE()
  end
end

function BattleUnitBase:OnBoutEnd()
  if self.battleEngine:IsPVP() then
    self:OnBoutEnd_PVP()
  end
  if self.battleEngine:IsPVE() then
    self:OnBoutEnd_PVE()
  end
end

function BattleUnitBase:OnBattleEnd()
  if self.battleEngine:IsPVP() then
    self:OnBattleEnd_PVP()
  end
  if self.battleEngine:IsPVE() then
    self:OnBattleEnd_PVE()
  end
end

function BattleUnitBase:GetBattleFieldPos()
  if not self.data.battleFieldPos then
    return
  end
  return self.data.battleFieldPos
end

function BattleUnitBase:SetBattleFieldPos(pos)
  if not self.data.battleFieldPos then
    return
  end
  self.data.battleFieldPos = pos
end

function BattleUnitBase:GetSchoolConfigId()
  return self.schoolConfigId
end

function BattleUnitBase:Respawn()
  if self.battleEngine:IsPVP() then
    self:Respawn_PVP()
  end
  if self.battleEngine:IsPVE() then
    self:Respawn_PVE()
  end
end

function BattleUnitBase:GetData(key)
  return self.data[key]
end

function BattleUnitBase:CalcStateLayerLimit(stateId, layer)
  local DT = self.battleEngine.battleDT
  for key, limitPropertyName in pairs(bc.StateLayerLimit) do
    local apiCfg = DT.BattleApi[limitPropertyName]
    if not apiCfg or not apiCfg.Data then
    else
      local ids = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
      for _, id in ipairs(ids) do
        if stateId == id then
          local layerLimit = self:GetProperty(limitPropertyName) or 0
          local staticsPropertyName = bc.StateLayerStatics[key]
          local layerStatics = self:GetProperty(staticsPropertyName) or 0
          if layerLimit > 0 then
            local limit = math.max(layerLimit - layerStatics, 0)
            layer = math.min(layer, limit)
            return math.ceil(layer)
          end
        end
      end
    end
  end
  do return math.ceil end
  return math.ceil, layer, pairs(bc.StateLayerLimit)
end

function BattleUnitBase:CalcStateLayerLimitTotal(stateId, layer)
  local DT = self.battleEngine.battleDT
  for key, limitPropertyName in pairs(bc.StateLayerLimitTotal) do
    local apiCfg = DT.BattleApi[limitPropertyName]
    if not apiCfg or not apiCfg.Data then
    else
      local ids = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
      for _, id in ipairs(ids) do
        if stateId == id then
          local layerLimit = self:GetProperty(limitPropertyName) or 0
          if layerLimit > 0 then
            local state = self.battleEngine.stateMgr:GetState(self, stateId)
            local curLayer = not (not state or state.isDeleted) and state.data.layer or 0
            local limit = math.max(layerLimit - curLayer, 0)
            layer = math.min(layer, limit)
            return math.ceil(layer)
          end
        end
      end
    end
  end
  do return math.ceil end
  return math.ceil, layer, pairs(bc.StateLayerLimitTotal)
end

function BattleUnitBase:SubTentacle(subNum, extraData)
  local subTypeList = {}
  local SubOrder = extraData.SubOrder or {
    bc.TentacleChangeType.Bout,
    bc.TentacleChangeType.Battle,
    bc.TentacleChangeType.Copy
  }
  for _, subType in ipairs(SubOrder) do
    local p = bc.ChangeType2PropertyName[subType]
    local num = self:GetProperty(p)
    if 0 == num then
    elseif subNum <= num then
      self.property:SubProperty(p, subNum, extraData)
      for _ = 1, subNum do
        table.insert(subTypeList, subType)
      end
      break
    else
      self.property:SubProperty(p, num, extraData)
      subNum = subNum - num
      for _ = 1, num do
        table.insert(subTypeList, subType)
      end
    end
  end
  return subTypeList
end

function BattleUnitBase:ChangeName(name)
end

function BattleUnitBase:OnInit()
end

function BattleUnitBase:OnAfterInit_PVE()
end

function BattleUnitBase:OnAfterInit_PVP()
end

function BattleUnitBase:HasHpBar()
end

function BattleUnitBase:GainPassiveUltiEnergy()
end

function BattleUnitBase:GainUltiEnergy(value, extraData)
end

function BattleUnitBase:RestoreFullUltiEnergy()
end

function BattleUnitBase:GetBattleLogName()
end

function BattleUnitBase:CanUseUltiSkill()
  return false
end

function BattleUnitBase:CanUseKeeperSkill()
  return false
end

function BattleUnitBase:EnergyEnough(value)
  return false
end

function BattleUnitBase:GetSkillIdAndLevel()
end

function BattleUnitBase:GetSilverKeyAwakeSkill()
end

function BattleUnitBase:GetBeforeSkillEffectType()
end

function BattleUnitBase:GetAfterSkillEventId()
end

function BattleUnitBase:OnBoutBegin_PVP()
end

function BattleUnitBase:OnBoutBegin_PVE()
end

function BattleUnitBase:OnBoutEnd_PVP()
end

function BattleUnitBase:OnBoutEnd_PVE()
end

function BattleUnitBase:OnBattleEnd_PVP()
end

function BattleUnitBase:OnBattleEnd_PVE()
end

function BattleUnitBase:GetID()
end

function BattleUnitBase:Respawn_PVE()
end

function BattleUnitBase:Respawn_PVP()
end

function BattleUnitBase:IsDeathResist()
  return false
end

function BattleUnitBase:GetPlayer()
  return self
end

function BattleUnitBase:PreCheckDeathEvent()
  return false
end

function BattleUnitBase:GetSpineName()
  return
end

function BattleUnitBase:NeedAfterPhase()
  return false
end

function BattleUnitBase:OnAfterCreateSkillPhase()
end

function BattleUnitBase:OnAfterUseCard()
end

function BattleUnitBase:GetTargetType()
  self.battleEngine:Error("子类需要实现这个方法")
  return
end

function BattleUnitBase:GetDimensionFixPer()
  if self.camp == bc.BattleCamp.Camp1 then
    local player = self:GetPlayer()
    return player and player:GetProperty(bc.BattleProperty.dimension_fix_per)
  end
  return 0
end

function BattleUnitBase:GetTentacleDamage()
  local curDmg = self:GetProperty(BP.tentacle_dmg) or 0
  local baseDamage = self:GetProperty(BP.tentacle_base_dmg) or 0
  local basic_damage_per = self:GetProperty(BP.basic_damage_per) or 0
  curDmg = curDmg + baseDamage * (1 + basic_damage_per / 100) * (1 + self:GetProperty(BP.i_basic_damage_per) / 100)
  if self.battleEngine:IsPVE() then
    local weakPer = self:GetProperty(BP.weak_per) or 0
    local tentacleDmgPer = self:GetProperty(BP.tentacle_dmg_per) or 0
    local insideDmgPer = self:GetProperty(BP.i_damage_per) or 0
    local insideDmgPer1 = self:GetProperty(BP.i_damage_per1) or 0
    local insideDmgPer2 = self:GetProperty(BP.i_damage_per2) or 0
    local insideDmgPer3 = self:GetProperty(BP.i_damage_per3) or 0
    local insideDmgPer4 = self:GetProperty(BP.i_damage_per4) or 0
    local insideDmgPer5 = self:GetProperty(BP.i_damage_per5) or 0
    local insideDmgPer6 = self:GetProperty(BP.i_damage_per6) or 0
    local insideDmgPer7 = self:GetProperty(BP.i_damage_per7) or 0
    local insideDmgPer8 = self:GetProperty(BP.i_damage_per8) or 0
    local player = self.battleEngine.roleMgr:GetPlayer(self.camp)
    local dimension_fix_per = self:GetDimensionFixPer()
    local targetVulnPer = player:GetProperty(BP.vulnerable_per) or 0
    curDmg = math.max(1, math.ceil(curDmg * (1 - weakPer / 100) * (1 + targetVulnPer / 100) * (1 + insideDmgPer / 100) * (1 + insideDmgPer1 / 100) * (1 + insideDmgPer2 / 100) * (1 + insideDmgPer3 / 100) * (1 + insideDmgPer4 / 100) * (1 + insideDmgPer5 / 100) * (1 + insideDmgPer6 / 100) * (1 + insideDmgPer7 / 100) * (1 + insideDmgPer8 / 100) * (1 + dimension_fix_per / 100) * (1 + tentacleDmgPer / 100)))
  end
  return curDmg
end

function BattleUnitBase:GetUnlockedKeeperSkillInfos()
  return {}
end

function BattleUnitBase:GetPowerStateLayer()
  local powerStateId = self.battleEngine.battleDT.GetConstant("powerState")
  local powerStateTempId = self.battleEngine.battleDT.GetConstant("powerStateTemp")
  local powerState = self.battleEngine.stateMgr:GetState(self, powerStateId)
  local powerStateTemp = self.battleEngine.stateMgr:GetState(self, powerStateTempId)
  local layer = not (not powerState or powerState.isDeleted) and powerState.data.layer or 0
  local layerTemp = not (not powerStateTemp or powerStateTemp.isDeleted) and powerStateTemp.data.layer or 0
  return layer + layerTemp
end

return BattleUnitBase
