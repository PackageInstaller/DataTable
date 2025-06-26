-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_battle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBossRush = (BeanManager.GetTableByName)("dungeonselect.cbossrush")
local CBattleConfig = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local CBattleInfo = (BeanManager.GetTableByName)("battle.cbattleinfo")
local attr1 = tonumber((CBattleConfig:GetRecorder(1)).attr)
local attr2 = tonumber((CBattleConfig:GetRecorder(2)).attr)
local BM_Battle = class("BM_Battle")
BM_Battle.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._battle = (NekoData.Data).battle
end

BM_Battle.GetLeftBattlers = function(self)
  -- function num : 0_1
  return (self._battle).leftBattlers
end

BM_Battle.GetLeftBattlersSummon = function(self)
  -- function num : 0_2
  return (self._battle).leftBattlersSummon
end

BM_Battle.GetRightBattlersSummon = function(self)
  -- function num : 0_3
  return (self._battle).rightBattlersSummon
end

BM_Battle.GetOwnSideRolesInfo = function(self)
  -- function num : 0_4
  return (self._battle).ownSideRolesInfo
end

BM_Battle.GetEnemySideRolesInfo = function(self)
  -- function num : 0_5
  return (self._battle).enemySideRolesInfo
end

BM_Battle.GetRightBattlers = function(self)
  -- function num : 0_6
  return (self._battle).rightBattlers
end

BM_Battle.GetProjectileEffects = function(self)
  -- function num : 0_7
  return (self._battle).projectileEffects
end

BM_Battle.GetBattlerByEntityId = function(self, entityId)
  -- function num : 0_8
  if ((self._battle).leftBattlers)[entityId] then
    return ((self._battle).leftBattlers)[entityId]
  end
  if ((self._battle).rightBattlers)[entityId] then
    return ((self._battle).rightBattlers)[entityId]
  end
end

BM_Battle.GetPartnerByEntityId = function(self, entityId)
  -- function num : 0_9
  if ((self._battle).leftPartners)[entityId] then
    return ((self._battle).leftPartners)[entityId]
  end
end

BM_Battle.GetPartners = function(self)
  -- function num : 0_10
  return (self._battle).leftPartners
end

BM_Battle.GetBattlerSummonByEntityId = function(self, entityId)
  -- function num : 0_11
  if ((self._battle).leftBattlersSummon)[entityId] then
    return ((self._battle).leftBattlersSummon)[entityId]
  end
  if ((self._battle).rightBattlersSummon)[entityId] then
    return ((self._battle).rightBattlersSummon)[entityId]
  end
end

BM_Battle.GetProjectileEffectByEntityId = function(self, entityId)
  -- function num : 0_12
  if ((self._battle).projectileEffects)[entityId] then
    return ((self._battle).projectileEffects)[entityId]
  end
end

BM_Battle.GetPower1 = function(self)
  -- function num : 0_13 , upvalues : attr1
  if (self._battle).power1 % attr1 > 0 then
    return (self._battle).power1 / attr1, (self._battle).power1Max // attr1
  else
    return (self._battle).power1 // attr1, (self._battle).power1Max // attr1
  end
end

BM_Battle.GetPower2 = function(self)
  -- function num : 0_14 , upvalues : attr2
  if (self._battle).power2 % attr2 > 0 then
    return (self._battle).power2 / attr2, (self._battle).power2Max // attr2
  else
    return (self._battle).power2 // attr2, (self._battle).power2Max // attr2
  end
end

BM_Battle.GetBattleId = function(self)
  -- function num : 0_15
  return (self._battle).battleId
end

BM_Battle.GetBattleType = function(self)
  -- function num : 0_16
  return (self._battle).battleType
end

BM_Battle.IsBossRush = function(self)
  -- function num : 0_17 , upvalues : CBossRush
  local allIds = CBossRush:GetAllIds()
  for i = 1, #allIds do
    local recorder = CBossRush:GetRecorder(allIds[i])
    if recorder.bossbattleID == (self._battle).battleId then
      return true
    end
  end
  return false
end

BM_Battle.SendProtocolToLogicWorld = function(self, protocol)
  -- function num : 0_18
  ((self._battle).controller):BSC_SendProtocolToLogicWorld(protocol)
end

BM_Battle.IsDeadAnimationPlayEnd = function(self)
  -- function num : 0_19 , upvalues : _ENV
  for k,v in pairs((self._battle).leftBattlers) do
    if not v:IsAlive() then
      return false
    end
  end
  for k,v in pairs((self._battle).rightBattlers) do
    if not v:IsAlive() then
      return false
    end
  end
  return true
end

BM_Battle.SetBattlerPosition = function(self, entityId, posX, posY)
  -- function num : 0_20
  local battler = self:GetBattlerByEntityId(entityId)
  if not battler then
    battler = self:GetPartnerByEntityId(entityId)
  end
  if battler then
    battler:SetPosition(posX, posY)
  end
end

BM_Battle.SetProjectileEffectPosition = function(self, entityId, posX, posY, posZ)
  -- function num : 0_21
  local pEffect = self:GetProjectileEffectByEntityId(entityId)
  if pEffect then
    pEffect:SetPosition(posX, posY, posZ)
  end
end

BM_Battle.GetTempAutoBattleInfo = function(self)
  -- function num : 0_22
  return (self._battle).tmpAutoBattleInfo
end

BM_Battle.GetAutoBattleInfo = function(self)
  -- function num : 0_23
  return (self._battle).autoBattleInfo
end

BM_Battle.GetDefaultModeAutoBattleSkillInfo = function(self)
  -- function num : 0_24
  if not (self._battle).defaultModeAutoBattleSkillInfo then
    return {}
  end
end

BM_Battle.SaveDefaultModeAutoBattleSkillInfo = function(self, skillInfo)
  -- function num : 0_25 , upvalues : _ENV
  if not (self._battle).defaultModeAutoBattleSkillInfo then
    for _,v in ipairs({}) do
      if v.loadTimeTask then
        (GameTimer.RemoveTask)(v.loadTimeTask)
        v.loadTimeTask = nil
      end
    end
    do
      while 1 do
        -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

        if (self._battle).defaultModeAutoBattleSkillInfo and ((self._battle).defaultModeAutoBattleSkillInfo)[#(self._battle).defaultModeAutoBattleSkillInfo] then
          ((self._battle).defaultModeAutoBattleSkillInfo)[#(self._battle).defaultModeAutoBattleSkillInfo] = nil
          -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._battle).defaultModeAutoBattleSkillInfo = skillInfo
    end
  end
end

BM_Battle.GetOptionalModeAutoBattleSkillInfo = function(self)
  -- function num : 0_26
  if not (self._battle).optionalModeAutoBattleSkillInfo then
    return {}
  end
end

BM_Battle.SaveOptionalModeAutoBattleSkillInfo = function(self, skillInfo)
  -- function num : 0_27 , upvalues : _ENV
  if not (self._battle).optionalModeAutoBattleSkillInfo then
    for _,v in ipairs({}) do
      if v.loadTimeTask then
        (GameTimer.RemoveTask)(v.loadTimeTask)
        v.loadTimeTask = nil
      end
    end
    do
      while 1 do
        -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

        if (self._battle).optionalModeAutoBattleSkillInfo and ((self._battle).optionalModeAutoBattleSkillInfo)[#(self._battle).optionalModeAutoBattleSkillInfo] then
          ((self._battle).optionalModeAutoBattleSkillInfo)[#(self._battle).optionalModeAutoBattleSkillInfo] = nil
          -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._battle).optionalModeAutoBattleSkillInfo = skillInfo
    end
  end
end

BM_Battle.GetCurrentBattleInjury = function(self)
  -- function num : 0_28
  return (self._battle).currentBattleInjury
end

BM_Battle.GetCurrentBattleTreatment = function(self)
  -- function num : 0_29
  return (self._battle).currentBattleTreatment
end

BM_Battle.GetCurrentBattleDamage = function(self)
  -- function num : 0_30
  return (self._battle).currentBattleDamage
end

BM_Battle.GetArenaEnemyNameByBattleID = function(self, battleId)
  -- function num : 0_31
  return ((self._battle).arenaEnemysName)[battleId]
end

BM_Battle.RecordEntityBuff = function(self, data)
  -- function num : 0_32 , upvalues : _ENV
  local exist = false
  for entityId,v in pairs((self._battle).entityBuffList) do
    if entityId == data.entityid then
      exist = true
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R8 in 'UnsetPending'

      if data.counttime == 0 then
        (v.buffList)[data.buffid] = nil
        break
      end
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

      if data.counttime then
        if not (v.buffList)[data.buffid] then
          (v.buffList)[data.buffid] = {}
        end
        -- DECOMPILER ERROR at PC33: Confused about usage of register: R8 in 'UnsetPending'

        ;
        ((v.buffList)[data.buffid]).counttime = data.counttime
      end
      break
    end
  end
  do
    if not exist then
      if not self:GetBattlerByEntityId(data.entityid) then
        local battler = self:GetBattlerSummonByEntityId(data.entityid)
      end
      if battler and not battler:IsTypeStyle() then
        return 
      end
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self._battle).entityBuffList)[data.entityid] = {battler = battler, 
buffList = {}
}
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R4 in 'UnsetPending'

      if data.counttime and data.counttime ~= 0 then
        ((((self._battle).entityBuffList)[data.entityid]).buffList)[data.buffid] = {}
        -- DECOMPILER ERROR at PC84: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (((((self._battle).entityBuffList)[data.entityid]).buffList)[data.buffid]).counttime = data.counttime
        -- DECOMPILER ERROR at PC93: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (((((self._battle).entityBuffList)[data.entityid]).buffList)[data.buffid]).stacklayer = data.stacklayer
      end
    end
  end
end

BM_Battle.GetEntityBuff = function(self)
  -- function num : 0_33
  return (self._battle).entityBuffList
end

BM_Battle.IsLoseSettle = function(self, Id)
  -- function num : 0_34 , upvalues : CBattleInfo
  do return (CBattleInfo:GetRecorder(Id)).defeatResult == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Battle.GetSeasonData = function(self)
  -- function num : 0_35
  return (self._battle).SeasonData
end

BM_Battle.GetSeasonNotify = function(self)
  -- function num : 0_36
  return (self._battle).SeasonNotify
end

return BM_Battle

