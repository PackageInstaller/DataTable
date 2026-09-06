local Battler = require("logic.manager.experimental.types.battler")
local ProjectileEffect = require("logic.manager.experimental.types.projectileeffect")
local DM_Battle = class("DM_Battle")

function DM_Battle:Ctor()
  self._battle = NekoData.Data.battle
  self:Clear()
  self._battle.arenaEnemysName = {}
end

function DM_Battle:Clear()
  if self._battle.leftBattlers then
    for k, v in pairs(self._battle.leftBattlers) do
      v:Destroy()
    end
    for k, v in pairs(self._battle.leftBattlers) do
      self._battle.leftBattlers[k] = nil
    end
  end
  if self._battle.leftBattlersSummon then
    for k, v in pairs(self._battle.leftBattlersSummon) do
      v:Destroy()
    end
    for k, v in pairs(self._battle.leftBattlersSummon) do
      self._battle.leftBattlersSummon[k] = nil
    end
  end
  if self._battle.rightBattlersSummon then
    for k, v in pairs(self._battle.rightBattlersSummon) do
      v:Destroy()
    end
    for k, v in pairs(self._battle.rightBattlersSummon) do
      self._battle.rightBattlersSummon[k] = nil
    end
  end
  if self._battle.leftPartners then
    for k, v in pairs(self._battle.leftPartners) do
      v:Destroy()
    end
    for k, v in pairs(self._battle.leftPartners) do
      self._battle.leftPartners[k] = nil
    end
  end
  if self._battle.ownSideRolesInfo then
    for k, v in pairs(self._battle.ownSideRolesInfo) do
      self._battle.ownSideRolesInfo[k] = nil
    end
  end
  if self._battle.enemySideRolesInfo then
    for k, v in pairs(self._battle.enemySideRolesInfo) do
      self._battle.enemySideRolesInfo[k] = nil
    end
  end
  if self._battle.rightBattlers then
    for k, v in pairs(self._battle.rightBattlers) do
      v:Destroy()
    end
    for k, v in pairs(self._battle.rightBattlers) do
      self._battle.rightBattlers[k] = nil
    end
  end
  if self._battle.projectileEffects then
    for k, v in pairs(self._battle.projectileEffects) do
      v:Destroy()
    end
    for k, v in pairs(self._battle.projectileEffects) do
      self._battle.projectileEffects[k] = nil
    end
  end
  if self._battle.fixedEffects then
    for k, v in pairs(self._battle.fixedEffects) do
      self._battle.fixedEffects[k] = nil
    end
  end
  self._battle.leftBattlers = {}
  self._battle.leftPartners = {}
  self._battle.ownSideRolesInfo = {}
  self._battle.enemySideRolesInfo = {}
  self._battle.rightBattlers = {}
  self._battle.projectileEffects = {}
  self._battle.fixedEffects = {}
  self._battle.power1 = 0
  self._battle.power1Max = 210
  self._battle.power2 = 0
  self._battle.power2Max = 210
  self._battle.battleId = 0
  self._battle.battleType = 0
  self._battle.controller = nil
  self._battle.autoBattleInfo = nil
  self._battle.tmpAutoBattleInfo = nil
  self._battle.leftBattlersSummon = {}
  self._battle.rightBattlersSummon = {}
  self._battle.sceneEffect = {}
  self._battle.currentBattleInjury = {}
  self._battle.currentBattleTreatment = {}
  self._battle.currentBattleDamage = {}
  self._battle.entityBuffList = {}
  if self._battle.defaultModeAutoBattleSkillInfo then
    for _, v in ipairs(self._battle.defaultModeAutoBattleSkillInfo) do
      if v.loadTimeTask then
        GameTimer.RemoveTask(v.loadTimeTask)
        v.loadTimeTask = nil
      end
    end
    while self._battle.defaultModeAutoBattleSkillInfo[#self._battle.defaultModeAutoBattleSkillInfo] do
      self._battle.defaultModeAutoBattleSkillInfo[#self._battle.defaultModeAutoBattleSkillInfo] = nil
    end
  end
  if self._battle.optionalModeAutoBattleSkillInfo then
    for _, v in ipairs(self._battle.optionalModeAutoBattleSkillInfo) do
      if v.loadTimeTask then
        GameTimer.RemoveTask(v.loadTimeTask)
        v.loadTimeTask = nil
      end
    end
    while self._battle.optionalModeAutoBattleSkillInfo[#self._battle.optionalModeAutoBattleSkillInfo] do
      self._battle.optionalModeAutoBattleSkillInfo[#self._battle.optionalModeAutoBattleSkillInfo] = nil
    end
  end
  CS.PixelNeko.P1.Scene.Battle.BattleSceneHelper.ReleaseAllAsset()
end

function DM_Battle:AddSceneEffectData(gameObject)
  table.insert(self._battle.sceneEffect, gameObject)
end

function DM_Battle:ClearSceneEffects()
  if self._battle.sceneEffect then
    for _, v in pairs(self._battle.sceneEffect) do
      CS.PixelNeko.Common.GameObjectHelper.DestroyObject(v)
    end
  end
  self._battle.sceneEffect = {}
end

function DM_Battle:ClearProjectileEffects()
  if self._battle.projectileEffects then
    for k, v in pairs(self._battle.projectileEffects) do
      v:Destroy()
    end
  end
  self._battle.projectileEffects = {}
end

function DM_Battle:AddLeftBattler(entityId, attribute, gameObject, isInitial)
  if not self._battle.leftBattlers[entityId] then
    local battler = Battler.Create()
    battler:Init(entityId, attribute, gameObject, isInitial)
    self._battle.leftBattlers[entityId] = battler
    return battler
  end
end

function DM_Battle:AddLeftPartnet(entityId, attribute, gameObject)
  if not self._battle.leftPartners[entityId] then
    local battler = Battler.Create()
    battler:Init(entityId, attribute, gameObject)
    self._battle.leftPartners[entityId] = battler
    return battler
  end
end

function DM_Battle:AddLeftBattlerSummon(entityId, attribute, gameObject)
  if not self._battle.leftBattlersSummon[entityId] then
    local battler = Battler.Create()
    battler:Init(entityId, attribute, gameObject)
    self._battle.leftBattlersSummon[entityId] = battler
  end
end

function DM_Battle:AddRightBattlerSummon(entityId, attribute, gameObject)
  if not self._battle.rightBattlersSummon[entityId] then
    local battler = Battler.Create()
    battler:Init(entityId, attribute, gameObject)
    self._battle.rightBattlersSummon[entityId] = battler
  end
end

function DM_Battle:ChangeLeftBattlerGameObject(entityId, gameObject)
  if self._battle.leftBattlers[entityId] then
    self._battle.leftBattlers[entityId]:SetGameObject(gameObject)
  end
end

function DM_Battle:ChangeLeftBattler(entityid, gameObject)
  local battler = self._battle.leftBattlers[entityid]
  battler = battler or self._battle.leftBattlersSummon[entityid]
  if battler then
    battler:SetGameObject(gameObject)
  end
end

function DM_Battle:ChangeRightBattler(entityid, gameObject)
  local battler = self._battle.rightBattlers[entityid]
  battler = battler or self._battle.rightBattlersSummon[entityid]
  if battler then
    battler:SetGameObject(gameObject)
  end
end

function DM_Battle:OnAddOwnSideRolesInfo(protocol)
  if not self._battle.ownSideRolesInfo[protocol.entityid] then
    local attribute = {}
    attribute.id = protocol.attribute.id
    attribute.key = protocol.attribute.key
    attribute.hp = protocol.attribute.hp
    attribute.hpmax = protocol.attribute.hpmax
    attribute.onceequipskills = {}
    self._battle.ownSideRolesInfo[protocol.entityid] = attribute
  end
end

function DM_Battle:OnAddEnemySideRolesInfo(protocol)
  if not self._battle.enemySideRolesInfo[protocol.entityid] then
    local attribute = {}
    attribute.id = protocol.attribute.id
    attribute.key = protocol.attribute.key
    attribute.hp = protocol.attribute.hp
    attribute.hpmax = protocol.attribute.hpmax
    self._battle.enemySideRolesInfo[protocol.entityid] = attribute
  end
end

function DM_Battle:AddOnceUseEquipSkill(entityId, skillid)
  local attribute = self._battle.ownSideRolesInfo[entityId]
  if attribute then
    table.insert(attribute.onceequipskills, skillid)
  end
end

function DM_Battle:OnRefreshBothSideRolesInfo(protocol)
  local attribute = self._battle.ownSideRolesInfo[protocol.entityId]
  if attribute then
    self._battle.ownSideRolesInfo[protocol.entityId].hp = protocol.currentHp
  else
    attribute = self._battle.enemySideRolesInfo[protocol.entityId]
    if attribute then
      self._battle.enemySideRolesInfo[protocol.entityId].hp = protocol.currentHp
    end
  end
end

function DM_Battle:AddRightBattler(entityId, attribute, gameObject, isInitial)
  if not self._battle.rightBattlers[entityId] then
    local battler = Battler.Create()
    battler:Init(entityId, attribute, gameObject, isInitial)
    self._battle.rightBattlers[entityId] = battler
    if isInitial and self._battle.controller and battler:IsBoss() and self._battle.controller._bsc_isBossViolent then
      battler:SetViolentState(true)
    end
  else
    LogError("DM_Battle", "战斗单位已存在")
  end
end

function DM_Battle:AddProjectileEffect(entityId, playerEntityId, skillId, camp, gameObject)
  if not self._battle.projectileEffects[entityId] then
    local battler = ProjectileEffect.Create()
    battler:Init(entityId, playerEntityId, skillId, camp, gameObject)
    self._battle.projectileEffects[entityId] = battler
  end
end

function DM_Battle:RemoveEntity(entityId)
  if self._battle.rightBattlers[entityId] then
    self._battle.rightBattlers[entityId]:Destroy()
    self._battle.rightBattlers[entityId] = nil
  elseif self._battle.leftBattlers[entityId] then
    self._battle.leftBattlers[entityId]:Destroy()
    self._battle.leftBattlers[entityId] = nil
  elseif self._battle.leftBattlersSummon[entityId] then
    self._battle.leftBattlersSummon[entityId]:Destroy()
    self._battle.leftBattlersSummon[entityId] = nil
  elseif self._battle.rightBattlersSummon[entityId] then
    self._battle.rightBattlersSummon[entityId]:Destroy()
    self._battle.rightBattlersSummon[entityId] = nil
  elseif self._battle.leftPartners[entityId] then
    self._battle.leftPartners[entityId]:Destroy()
    self._battle.leftPartners[entityId] = nil
  elseif self._battle.projectileEffects[entityId] then
    self._battle.projectileEffects[entityId]:Destroy()
    self._battle.projectileEffects[entityId] = nil
  else
    LogError("DM_Battle", "需要移除的对象不存在" .. entityId)
  end
end

function DM_Battle:SetBattlePower(power1, power1Max, power2, power2Max)
  power2 = power2 or 0
  power2Max = power2Max or 0
  self._battle.power1 = power1
  self._battle.power1Max = power1Max
  self._battle.power2 = power2
  self._battle.power2Max = power2Max
end

function DM_Battle:SetBattleId(battleId, controller, battleType)
  self._battle.battleId = battleId
  self._battle.battleType = battleType
  self._battle.controller = controller
end

function DM_Battle:SetAutoBattleInfo(info)
  self._battle.autoBattleInfo = info
  self._battle.tmpAutoBattleInfo = clone(info)
end

function DM_Battle:RecordCurrentBattleInjury(recorder)
  self._battle.currentBattleInjury[recorder.entityId] = recorder
end

function DM_Battle:RecordCurrentBattleTreatment(recorder)
  self._battle.currentBattleTreatment[recorder.entityId] = recorder
end

function DM_Battle:RecordCurrentBattleDamage(recorder)
  self._battle.currentBattleDamage[recorder.entityId] = recorder
end

function DM_Battle:SetArenaEnemysName(info)
  self._battle.arenaEnemysName = {}
  for k, v in ipairs(info) do
    self._battle.arenaEnemysName[v.battleId] = v.enemyUserData.userName
  end
end

function DM_Battle:SetSeasonData(data)
  self._battle.SeasonData = data
  NekoData.BehaviorManager.BM_Team:SetSeasonPvpTeam(3000, data.attackTeam)
  NekoData.BehaviorManager.BM_Team:SetSeasonPvpTeam(3100, data.defendTeam)
end

function DM_Battle:SetSeasonNotify(data)
  self._battle.SeasonNotify = data
end

return DM_Battle
