-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/battler.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleSceneHelper = ((((CS.PixelNeko).P1).Scene).Battle).BattleSceneHelper
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local AnimationEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local GameObjectHelper = ((CS.PixelNeko).Common).GameObjectHelper
local attrInfo = {"hp", "hpmax", "atk", "def", "mdef", "physicalbonus", "magicbonus", "physicalreduce", "magicreduce", "physicalcritrate", "physicalcritdegree", "attackspeed", "physicalevasion", "physicallifesteal", "magiclifesteal", "physicalblock", "magicblock", "physicaldefbreak", "magicdefbreak", "critrateresistance", "critdegreeresistance", "damagereduce"}
local def = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
local Battler = class("Battler")
Battler.Ctor = function(self)
  -- function num : 0_0
  self._entityId = 0
  self._attribute = {}
  self._gameObject = nil
  self._transform = nil
  self._disappearEventHandler = 0
  self._disappearAnimationEnd = false
  self._hpBarAnimationState = false
  self._skillPowerCostReduce = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._skillPowerCostReduce).order = 0
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._skillPowerCostReduce).chaos = 0
  self._currentBattleDamage = 0
  self._currentBattleTreatment = 0
  self._currentBattleInjury = 0
  self._onceUseEquipSKillList = {}
  self._skillCDList = {}
  self._visibleCount = 0
  self._hitpointVisibleCount = 0
end

Battler.Destroy = function(self)
  -- function num : 0_1 , upvalues : GameObjectHelper
  if self._gameObject then
    (GameObjectHelper.DestroyObject)(self._gameObject)
    self._gameObject = nil
    self._transform = nil
  end
end

Battler.Init = function(self, entityId, attribute, gameObject, isInitial)
  -- function num : 0_2
  self._entityId = entityId
  self._attribute = attribute
  self._gameObject = gameObject
  self._transform = gameObject.transform
  self._isInitialPlayer = isInitial or 0
end

Battler.Update = function(self)
  -- function num : 0_3
end

Battler.RefreshAttribute = function(self, attribute)
  -- function num : 0_4 , upvalues : _ENV, attrInfo
  for _,v in pairs(attrInfo) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

    if (self._attribute)[v] and attribute[v] then
      (self._attribute)[v] = attribute[v]
    end
  end
end

Battler.RefreshCurrentBattleDamage = function(self, damage)
  -- function num : 0_5
  self._currentBattleDamage = self._currentBattleDamage + damage
end

Battler.RefreshskillPowerCostReduce = function(self, order, chaos)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self._skillPowerCostReduce).order = order
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._skillPowerCostReduce).chaos = chaos
end

Battler.GetskillPowerCostReduceOrder = function(self)
  -- function num : 0_7
  return (self._skillPowerCostReduce).order
end

Battler.GetskillPowerCostReduceChaos = function(self)
  -- function num : 0_8
  return (self._skillPowerCostReduce).chaos
end

Battler.RefreshCurrentBattleInjury = function(self, injury)
  -- function num : 0_9
  self._currentBattleInjury = self._currentBattleInjury + injury
end

Battler.RefreshCurrentBattleTreatment = function(self, treatment)
  -- function num : 0_10
  self._currentBattleTreatment = self._currentBattleTreatment + treatment
end

Battler.GetCurrentBattleDamage = function(self)
  -- function num : 0_11
  return self._currentBattleDamage
end

Battler.GetCurrentBattleInjury = function(self)
  -- function num : 0_12
  return self._currentBattleInjury
end

Battler.GetCurrentBattleTreatment = function(self)
  -- function num : 0_13
  return self._currentBattleTreatment
end

Battler.OnDeadDisappearEvent = function(self, floatValue, intValue, stringValue, objectValue, clipName)
  -- function num : 0_14 , upvalues : AnimationEventTriggerHelper, _ENV
  self._disappearAnimationEnd = true
  ;
  (AnimationEventTriggerHelper.RemoveAnimationEventListener)(self._gameObject, self._disappearEventHandler)
  self._disappearEventHandler = 0
  ;
  ((NekoData.DataManager).DM_Battle):RemoveEntity(self._entityId)
end

Battler.GetAttribute = function(self)
  -- function num : 0_15
  return self._attribute
end

Battler.GetConfigId = function(self)
  -- function num : 0_16
  return (self._attribute).id
end

Battler.DestroyPointEffectByName = function(self, slotName, effectname)
  -- function num : 0_17 , upvalues : TransformStaticFunctions, GameObjectHelper
  local effectGameObject = (TransformStaticFunctions.GetChild)(self._transform, slotName .. "/" .. effectname .. "(Clone)(Clone)")
  if effectGameObject then
    (GameObjectHelper.DestroyObject)(effectGameObject)
  end
end

Battler.GetKey = function(self)
  -- function num : 0_18
  return (self._attribute).key
end

Battler.IsRole = function(self)
  -- function num : 0_19
  do return (self._attribute).id >= 1 and (self._attribute).id < 10000 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Battler.IsAlive = function(self)
  -- function num : 0_20
  do return (self._attribute).hp > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Battler.IsBoss = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if (self._attribute).id >= 10000 then
    local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
    local r = CMonsterConfigTable:GetRecorder((self._attribute).id)
    if r.bossOrNot ~= 1 then
      do
        do return not r end
        do return false end
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
end

Battler.GetSkillList = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
  local list = {}
  for i,v in ipairs((self._attribute).skilllist) do
    if (CSkillTable:GetRecorder(v)).type ~= 5 then
      (table.insert)(list, v)
    end
  end
  if #list > 2 then
    for i = 2, #list do
      list[i] = nil
    end
  end
  do
    return list
  end
end

Battler.SetSkillIsInCD = function(self, skillId, isInCD)
  -- function num : 0_23
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if not (self._skillCDList)[skillId] then
    (self._skillCDList)[skillId] = {}
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._skillCDList)[skillId]).isInCD = isInCD
  end
end

Battler.GetSkillIsInCD = function(self, skillId)
  -- function num : 0_24
  local StateType = {notInCD = 0, inCD = 1}
  if ((self._skillCDList)[skillId]).isInCD ~= StateType.inCD then
    do return not (self._skillCDList)[skillId] end
    do return false end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

Battler.SetSkillCountTime = function(self, skillId, countTime)
  -- function num : 0_25
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if not (self._skillCDList)[skillId] then
    (self._skillCDList)[skillId] = {}
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._skillCDList)[skillId]).countTime = countTime
  end
end

Battler.GetSkillCountTime = function(self, skillId)
  -- function num : 0_26
  if not ((self._skillCDList)[skillId]).countTime then
    do return not (self._skillCDList)[skillId] or 0 end
    do return 0 end
  end
end

Battler.SetSkillAutoCDTime = function(self, skillId, autoClickTime)
  -- function num : 0_27
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if not (self._skillCDList)[skillId] then
    (self._skillCDList)[skillId] = {}
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._skillCDList)[skillId]).autoCDTime = autoClickTime
  end
end

Battler.GetSkillAutoCDTime = function(self, skillId)
  -- function num : 0_28
  if not ((self._skillCDList)[skillId]).autoCDTime then
    do return not (self._skillCDList)[skillId] or 0 end
    do return 0 end
  end
end

Battler.GetBossHpStage = function(self)
  -- function num : 0_29
  return (self._attribute).bosshpstage
end

Battler.SetBossHpStage = function(self, bosshpstage)
  -- function num : 0_30
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._attribute).bosshpstage = bosshpstage
end

Battler.GetEntityId = function(self)
  -- function num : 0_31
  return self._entityId
end

Battler.GetCollaborativeSkillNum = function(self)
  -- function num : 0_32 , upvalues : _ENV
  return (math.max)((self._attribute).comborate1, (self._attribute).comborate2)
end

Battler.IfSkillIsEnergy = function(self, skillId)
  -- function num : 0_33 , upvalues : _ENV
  local skillList = self:GetSkillList()
  for index,id in ipairs(skillList) do
    if index == 1 then
      if (self._attribute).comborate1 <= 0 then
        do return skillId ~= id end
        do break end
        if (self._attribute).comborate2 <= 0 then
          do
            do return index ~= 2 end
            do break end
            -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  do return false end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

Battler.GetSoulQuantity = function(self)
  -- function num : 0_34 , upvalues : _ENV
  if (self._attribute).id >= 10000 then
    local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
    local r = CMonsterConfigTable:GetRecorder((self._attribute).id)
    if r then
      return r.soulQuantity
    end
  end
  do
    return 0
  end
end

Battler.GetGameObject = function(self)
  -- function num : 0_35
  return self._gameObject
end

Battler.IsLeftCamp = function(self)
  -- function num : 0_36 , upvalues : def
  do return (self._attribute).camp == def.LeftFighter end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Battler.IsRightCamp = function(self)
  -- function num : 0_37 , upvalues : def
  do return (self._attribute).camp == def.RightFighter end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Battler.GetCamp = function(self)
  -- function num : 0_38
  return (self._attribute).camp
end

Battler.GetSlotPosition = function(self, slotName)
  -- function num : 0_39 , upvalues : TransformStaticFunctions
  local x, y, z = (TransformStaticFunctions.GetPosition)(self._transform)
  do
    if slotName then
      local slotGameObject = (TransformStaticFunctions.GetChild)(self._transform, slotName)
      if slotGameObject then
        x = (TransformStaticFunctions.GetPosition)(slotGameObject)
      end
    end
    return x, y, z
  end
end

Battler.SetPosition = function(self, posX, posY, posZ)
  -- function num : 0_40 , upvalues : TransformStaticFunctions
  if not posZ then
    posZ = (self._attribute).z
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._attribute).x = posX
  if self._gameObject then
    (TransformStaticFunctions.SetPosition)(self._gameObject, (self._attribute).x / 1000, (self._attribute).y / 1000, (self._attribute).z / 1000)
  end
end

Battler.GetPosition = function(self)
  -- function num : 0_41
  return (self._attribute).x, (self._attribute).y, (self._attribute).z
end

Battler.SetGameObject = function(self, gameObject)
  -- function num : 0_42 , upvalues : GameObjectHelper
  if self._gameObject then
    (GameObjectHelper.DestroyObject)(self._gameObject)
    self._gameObject = nil
    self._transform = nil
  end
  self._gameObject = gameObject
  self._transform = gameObject.transform
end

Battler.SetHP = function(self, hp, hpmax)
  -- function num : 0_43
  if not hpmax then
    hpmax = (self._attribute).hpmax
  end
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._attribute).hp = hp
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._attribute).hpmax = hpmax
end

Battler.GetHp = function(self)
  -- function num : 0_44
  return (self._attribute).hp
end

Battler.GetHpMax = function(self)
  -- function num : 0_45
  return (self._attribute).hpmax
end

Battler.PlayAnimation = function(self, animationName, ignorePriority)
  -- function num : 0_46 , upvalues : AnimationHelper, TransformStaticFunctions, _ENV
  if self._gameObject then
    local playingAnimationPriority = (AnimationHelper.GetBattleAnimationPriority)(self._gameObject, self:GetCurrentAnimatiionClipName())
    local addAnimationPriority = (AnimationHelper.GetBattleAnimationPriority)(self._gameObject, animationName)
    if playingAnimationPriority <= addAnimationPriority or ignorePriority then
      (AnimationHelper.PlayAnimation)(self._gameObject, animationName, -1, 0)
      if animationName == "DeadDisappear" and (self._attribute).id == 1 and self:IsHaveAlternate() then
        (TransformStaticFunctions.SetLayer)(self._gameObject, Layers.InvisibleLayerID)
      end
      if animationName == "DeadDisappear" then
        do
          ((TransformStaticFunctions.GetChild)(self._transform, "HitPoint_Body")):SetActive(not (TransformStaticFunctions.GetChild)(self._transform, "HitPoint_Body"))
          ;
          ((TransformStaticFunctions.GetChild)(self._transform, "HitPoint_Head")):SetActive(animationName ~= "DeadDisappear")
          -- DECOMPILER ERROR: 4 unprocessed JMP targets
        end
      end
    end
  end
end

Battler.GetCurrentAnimatiionClipName = function(self)
  -- function num : 0_47 , upvalues : AnimationHelper
  local animationName = (AnimationHelper.GetCurrentAnimatiionClipName)(self._gameObject)
  return animationName
end

Battler.SetGameObjectActive = function(self, flag)
  -- function num : 0_48
  (self._gameObject):SetActive(flag)
end

Battler.PlayEffect = function(self, packageName, effectName, slotName, angle)
  -- function num : 0_49 , upvalues : TransformStaticFunctions, BattleSceneHelper
  if self._gameObject then
    local slotGameObject = (TransformStaticFunctions.GetChild)(self._transform, slotName)
    local effectGameObject = (BattleSceneHelper.CreateEffect)(packageName, effectName, slotGameObject)
    do
      if angle then
        local angleX, angleY, angleZ = (TransformStaticFunctions.GetWorldEuler)(effectGameObject)
        ;
        (TransformStaticFunctions.SetWorldEuler)(effectGameObject, angleX, angleY, angle)
      end
      do return effectGameObject end
    end
  end
end

Battler.SetHpBarAnimationState = function(self, state)
  -- function num : 0_50
  self._hpBarAnimationState = state
end

Battler.GetHpBarAnimationState = function(self)
  -- function num : 0_51
  return self._hpBarAnimationState
end

Battler.GetShapeRecorder = function(self)
  -- function num : 0_52
  return {assetBundleName = (self._attribute).assetbundlename, prefabName = (self._attribute).prefabname}
end

Battler.IsInitialPlayer = function(self)
  -- function num : 0_53
  local initialTagType = {Not = 0, Is = 1}
  do return self._isInitialPlayer == initialTagType.Is end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Battler.IsHaveAlternate = function(self)
  -- function num : 0_54
  do return (self._attribute).havealternate == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Battler.GetNameTextId = function(self)
  -- function num : 0_55
  return (self._attribute).nameTextId
end

Battler.SetNameTextId = function(self, nameTextId)
  -- function num : 0_56
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._attribute).nameTextId = nameTextId
end

Battler.SetGameObjectVisible = function(self, visible)
  -- function num : 0_57 , upvalues : TransformStaticFunctions, _ENV
  local SpriteShowType = {None = -1, Show = 1, Hide = 0, OnlyHideHitPoint = 2, OnlyShowHitPoint = 3}
  local preVisibleCount = self._visibleCount
  local preHitpointVisibleCount = self._hitpointVisibleCount
  if visible == SpriteShowType.Show then
    self._visibleCount = self._visibleCount + 1
  else
    if visible == SpriteShowType.Hide then
      self._visibleCount = self._visibleCount - 1
    else
      if visible == SpriteShowType.OnlyShowHitPoint then
        self._hitpointVisibleCount = self._hitpointVisibleCount + 1
      else
        if visible == SpriteShowType.OnlyHideHitPoint then
          self._hitpointVisibleCount = self._hitpointVisibleCount - 1
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC44: Unhandled construct in 'MakeBoolean' P1

  if self._visibleCount >= 0 and preVisibleCount < 0 then
    (TransformStaticFunctions.SetLayer)(self._gameObject, Layers.NewDemoFighterLayerID)
  end
  if self._visibleCount < 0 and preVisibleCount >= 0 then
    (TransformStaticFunctions.SetLayer)(self._gameObject, Layers.InvisibleLayerID)
  end
  -- DECOMPILER ERROR at PC65: Unhandled construct in 'MakeBoolean' P1

  if self._hitpointVisibleCount >= 0 and preHitpointVisibleCount < 0 then
    local child = (TransformStaticFunctions.GetChild)(self._transform, "HitPoint")
    local childList, len = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetFirstOrderChildren)(child.gameObject)
    for i = 0, len - 1 do
      local gameObj = childList[i]
      if gameObj then
        (TransformStaticFunctions.SetLayer)(gameObj, Layers.NewDemoFighterLayerID)
      end
    end
    child = (TransformStaticFunctions.GetChild)(self._transform, "HitPoint_Head")
    childList = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetFirstOrderChildren)(child.gameObject)
    for i = 0, len - 1 do
      local gameObj = childList[i]
      if gameObj then
        (TransformStaticFunctions.SetLayer)(gameObj, Layers.NewDemoFighterLayerID)
      end
    end
    child = (TransformStaticFunctions.GetChild)(self._transform, "HitPoint_Bottom")
    -- DECOMPILER ERROR at PC124: Overwrote pending register: R7 in 'AssignReg'

    childList = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetFirstOrderChildren)(child.gameObject)
    for i = 0, len - 1 do
      local gameObj = childList[i]
      if gameObj then
        (TransformStaticFunctions.SetLayer)(gameObj, Layers.NewDemoFighterLayerID)
      end
    end
    child = (TransformStaticFunctions.GetChild)(self._transform, "HitPoint_Body")
    -- DECOMPILER ERROR at PC151: Overwrote pending register: R7 in 'AssignReg'

    childList = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetFirstOrderChildren)(child.gameObject)
    for i = 0, len - 1 do
      local gameObj = childList[i]
      if gameObj then
        (TransformStaticFunctions.SetLayer)(gameObj, Layers.NewDemoFighterLayerID)
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC174: Overwrote pending register: R7 in 'AssignReg'

    if self._hitpointVisibleCount < 0 and preHitpointVisibleCount >= 0 then
      local child = (TransformStaticFunctions.GetChild)(self._transform, len)
      local childList, len = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetFirstOrderChildren)(child.gameObject)
      for i = 0, len - 1 do
        local gameObj = childList[i]
        if gameObj then
          (TransformStaticFunctions.SetLayer)(gameObj, Layers.InvisibleLayerID)
        end
      end
      child = (TransformStaticFunctions.GetChild)(self._transform, "HitPoint_Head")
      childList = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetFirstOrderChildren)(child.gameObject)
      for i = 0, len - 1 do
        local gameObj = childList[i]
        if gameObj then
          (TransformStaticFunctions.SetLayer)(gameObj, Layers.InvisibleLayerID)
        end
      end
      child = (TransformStaticFunctions.GetChild)(self._transform, "HitPoint_Bottom")
      -- DECOMPILER ERROR at PC235: Overwrote pending register: R7 in 'AssignReg'

      childList = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetFirstOrderChildren)(child.gameObject)
      for i = 0, len - 1 do
        local gameObj = childList[i]
        if gameObj then
          (TransformStaticFunctions.SetLayer)(gameObj, Layers.InvisibleLayerID)
        end
      end
      child = (TransformStaticFunctions.GetChild)(self._transform, "HitPoint_Body")
      -- DECOMPILER ERROR at PC262: Overwrote pending register: R7 in 'AssignReg'

      childList = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetFirstOrderChildren)(child.gameObject)
      for i = 0, len - 1 do
        local gameObj = childList[i]
        if gameObj then
          (TransformStaticFunctions.SetLayer)(gameObj, Layers.InvisibleLayerID)
        end
      end
    end
  end
end

Battler.GetLevel = function(self)
  -- function num : 0_58
  return (self._attribute).level
end

Battler.GetExclusiveLevel = function(self)
  -- function num : 0_59
  return (self._attribute).exclusiveLevel
end

Battler.IsTypeStyle = function(self)
  -- function num : 0_60 , upvalues : _ENV
  if self:IsRole() then
    return true
  else
    local monsterRecord = (((BattleECS.Utility).DataUtility).cMonsterCfgTable)[self:GetConfigId()]
    if monsterRecord.typeStyle ~= 0 then
      do
        do return not monsterRecord end
        LogErrorFormat("Battler", "monster id %s is not exist in cmonsterconfig", self:GetConfigId())
        do return true end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
end

Battler.SetFatherEntityId = function(self, entityid)
  -- function num : 0_61
  self._fatherEntityId = entityid
end

Battler.GetFatherEntityId = function(self)
  -- function num : 0_62
  return self._fatherEntityId or 0
end

Battler.GetViolentState = function(self)
  -- function num : 0_63
  return self._violentState
end

Battler.SetViolentState = function(self, state)
  -- function num : 0_64
  self._violentState = state
end

return Battler

