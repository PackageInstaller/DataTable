local CBossRush = BeanManager.GetTableByName("dungeonselect.cbossrush")
local CBattleConfig = BeanManager.GetTableByName("battle.cbattleconstcfg")
local CBattleInfo = BeanManager.GetTableByName("battle.cbattleinfo")
local attr1 = tonumber(CBattleConfig:GetRecorder(1).attr)
local attr2 = tonumber(CBattleConfig:GetRecorder(2).attr)
local BM_Battle = class("BM_Battle")

function BM_Battle:Ctor()
  self._battle = NekoData.Data.battle
end

function BM_Battle:GetLeftBattlers()
  return self._battle.leftBattlers
end

function BM_Battle:GetLeftBattlersSummon()
  return self._battle.leftBattlersSummon
end

function BM_Battle:GetRightBattlersSummon()
  return self._battle.rightBattlersSummon
end

function BM_Battle:GetOwnSideRolesInfo()
  return self._battle.ownSideRolesInfo
end

function BM_Battle:GetEnemySideRolesInfo()
  return self._battle.enemySideRolesInfo
end

function BM_Battle:GetRightBattlers()
  return self._battle.rightBattlers
end

function BM_Battle:GetProjectileEffects()
  return self._battle.projectileEffects
end

function BM_Battle:GetBattlerByEntityId(entityId)
  if self._battle.leftBattlers[entityId] then
    return self._battle.leftBattlers[entityId]
  end
  if self._battle.rightBattlers[entityId] then
    return self._battle.rightBattlers[entityId]
  end
end

function BM_Battle:GetPartnerByEntityId(entityId)
  if self._battle.leftPartners[entityId] then
    return self._battle.leftPartners[entityId]
  end
end

function BM_Battle:GetPartners()
  return self._battle.leftPartners
end

function BM_Battle:GetBattlerSummonByEntityId(entityId)
  if self._battle.leftBattlersSummon[entityId] then
    return self._battle.leftBattlersSummon[entityId]
  end
  if self._battle.rightBattlersSummon[entityId] then
    return self._battle.rightBattlersSummon[entityId]
  end
end

function BM_Battle:GetProjectileEffectByEntityId(entityId)
  if self._battle.projectileEffects[entityId] then
    return self._battle.projectileEffects[entityId]
  end
end

function BM_Battle:GetPower1()
  if self._battle.power1 % attr1 > 0 then
    return self._battle.power1 / attr1, self._battle.power1Max // attr1
  else
    return self._battle.power1 // attr1, self._battle.power1Max // attr1
  end
end

function BM_Battle:GetPower2()
  if self._battle.power2 % attr2 > 0 then
    return self._battle.power2 / attr2, self._battle.power2Max // attr2
  else
    return self._battle.power2 // attr2, self._battle.power2Max // attr2
  end
end

function BM_Battle:GetBattleId()
  return self._battle.battleId
end

function BM_Battle:GetBattleType()
  return self._battle.battleType
end

function BM_Battle:IsBossRush()
  local allIds = CBossRush:GetAllIds()
  for i = 1, #allIds do
    local recorder = CBossRush:GetRecorder(allIds[i])
    if recorder.bossbattleID == self._battle.battleId then
      return true
    end
  end
  return false
end

function BM_Battle:SendProtocolToLogicWorld(protocol)
  self._battle.controller:BSC_SendProtocolToLogicWorld(protocol)
end

function BM_Battle:IsDeadAnimationPlayEnd()
  for k, v in pairs(self._battle.leftBattlers) do
    if not v:IsAlive() then
      return false
    end
  end
  for k, v in pairs(self._battle.rightBattlers) do
    if not v:IsAlive() then
      return false
    end
  end
  return true
end

function BM_Battle:SetBattlerPosition(entityId, posX, posY)
  local battler = self:GetBattlerByEntityId(entityId)
  battler = battler or self:GetPartnerByEntityId(entityId)
  if battler then
    battler:SetPosition(posX, posY)
  end
end

function BM_Battle:SetProjectileEffectPosition(entityId, posX, posY, posZ)
  local pEffect = self:GetProjectileEffectByEntityId(entityId)
  if pEffect then
    pEffect:SetPosition(posX, posY, posZ)
  end
end

function BM_Battle:GetTempAutoBattleInfo()
  return self._battle.tmpAutoBattleInfo
end

function BM_Battle:GetAutoBattleInfo()
  return self._battle.autoBattleInfo
end

function BM_Battle:GetDefaultModeAutoBattleSkillInfo()
  return self._battle.defaultModeAutoBattleSkillInfo or {}
end

function BM_Battle:SaveDefaultModeAutoBattleSkillInfo(skillInfo)
  for _, v in ipairs(self._battle.defaultModeAutoBattleSkillInfo or {}) do
    if v.loadTimeTask then
      GameTimer.RemoveTask(v.loadTimeTask)
      v.loadTimeTask = nil
    end
  end
  if self._battle.defaultModeAutoBattleSkillInfo then
    while self._battle.defaultModeAutoBattleSkillInfo[#self._battle.defaultModeAutoBattleSkillInfo] do
      self._battle.defaultModeAutoBattleSkillInfo[#self._battle.defaultModeAutoBattleSkillInfo] = nil
    end
  end
  self._battle.defaultModeAutoBattleSkillInfo = skillInfo
end

function BM_Battle:GetOptionalModeAutoBattleSkillInfo()
  return self._battle.optionalModeAutoBattleSkillInfo or {}
end

function BM_Battle:SaveOptionalModeAutoBattleSkillInfo(skillInfo)
  for _, v in ipairs(self._battle.optionalModeAutoBattleSkillInfo or {}) do
    if v.loadTimeTask then
      GameTimer.RemoveTask(v.loadTimeTask)
      v.loadTimeTask = nil
    end
  end
  if self._battle.optionalModeAutoBattleSkillInfo then
    while self._battle.optionalModeAutoBattleSkillInfo[#self._battle.optionalModeAutoBattleSkillInfo] do
      self._battle.optionalModeAutoBattleSkillInfo[#self._battle.optionalModeAutoBattleSkillInfo] = nil
    end
  end
  self._battle.optionalModeAutoBattleSkillInfo = skillInfo
end

function BM_Battle:GetCurrentBattleInjury()
  return self._battle.currentBattleInjury
end

function BM_Battle:GetCurrentBattleTreatment()
  return self._battle.currentBattleTreatment
end

function BM_Battle:GetCurrentBattleDamage()
  return self._battle.currentBattleDamage
end

function BM_Battle:GetArenaEnemyNameByBattleID(battleId)
  return self._battle.arenaEnemysName[battleId]
end

function BM_Battle:RecordEntityBuff(data)
  local exist = false
  for entityId, v in pairs(self._battle.entityBuffList) do
    if entityId == data.entityid then
      exist = true
      if data.counttime == 0 then
        v.buffList[data.buffid] = nil
        break
      end
      if data.counttime then
        if not v.buffList[data.buffid] then
          v.buffList[data.buffid] = {}
        end
        v.buffList[data.buffid].counttime = data.counttime
      end
      break
    end
  end
  if not exist then
    local battler = self:GetBattlerByEntityId(data.entityid) or self:GetBattlerSummonByEntityId(data.entityid)
    if battler and not battler:IsTypeStyle() then
      return
    end
    self._battle.entityBuffList[data.entityid] = {
      battler = battler,
      buffList = {}
    }
    if data.counttime and data.counttime ~= 0 then
      self._battle.entityBuffList[data.entityid].buffList[data.buffid] = {}
      self._battle.entityBuffList[data.entityid].buffList[data.buffid].counttime = data.counttime
      self._battle.entityBuffList[data.entityid].buffList[data.buffid].stacklayer = data.stacklayer
    end
  end
end

function BM_Battle:GetEntityBuff()
  return self._battle.entityBuffList
end

function BM_Battle:IsLoseSettle(Id)
  return CBattleInfo:GetRecorder(Id).defeatResult == 1
end

function BM_Battle:GetSeasonData()
  return self._battle.SeasonData
end

function BM_Battle:GetSeasonNotify()
  return self._battle.SeasonNotify
end

return BM_Battle
