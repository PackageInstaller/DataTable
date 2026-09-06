local BattleSceneHelper = CS.PixelNeko.P1.Scene.Battle.BattleSceneHelper
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local AnimationEventTriggerHelper = CS.PixelNeko.Animation.EventTriggerHelper
local GameObjectHelper = CS.PixelNeko.Common.GameObjectHelper
local attrInfo = {
  "hp",
  "hpmax",
  "atk",
  "def",
  "mdef",
  "physicalbonus",
  "magicbonus",
  "physicalreduce",
  "magicreduce",
  "physicalcritrate",
  "physicalcritdegree",
  "attackspeed",
  "physicalevasion",
  "physicallifesteal",
  "magiclifesteal",
  "physicalblock",
  "magicblock",
  "physicaldefbreak",
  "magicdefbreak",
  "critrateresistance",
  "critdegreeresistance",
  "damagereduce"
}
local def = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
local Battler = class("Battler")

function Battler:Ctor()
  self._entityId = 0
  self._attribute = {}
  self._gameObject = nil
  self._transform = nil
  self._disappearEventHandler = 0
  self._disappearAnimationEnd = false
  self._hpBarAnimationState = false
  self._skillPowerCostReduce = {}
  self._skillPowerCostReduce.order = 0
  self._skillPowerCostReduce.chaos = 0
  self._currentBattleDamage = 0
  self._currentBattleTreatment = 0
  self._currentBattleInjury = 0
  self._onceUseEquipSKillList = {}
  self._skillCDList = {}
  self._visibleCount = 0
  self._hitpointVisibleCount = 0
end

function Battler:Destroy()
  if self._gameObject then
    GameObjectHelper.DestroyObject(self._gameObject)
    self._gameObject = nil
    self._transform = nil
  end
end

function Battler:Init(entityId, attribute, gameObject, isInitial)
  self._entityId = entityId
  self._attribute = attribute
  self._gameObject = gameObject
  self._transform = gameObject.transform
  self._isInitialPlayer = isInitial or 0
end

function Battler:Update()
end

function Battler:RefreshAttribute(attribute)
  for _, v in pairs(attrInfo) do
    if self._attribute[v] and attribute[v] then
      self._attribute[v] = attribute[v]
    end
  end
end

function Battler:RefreshCurrentBattleDamage(damage)
  self._currentBattleDamage = self._currentBattleDamage + damage
end

function Battler:RefreshskillPowerCostReduce(order, chaos)
  self._skillPowerCostReduce.order = order
  self._skillPowerCostReduce.chaos = chaos
end

function Battler:GetskillPowerCostReduceOrder()
  return self._skillPowerCostReduce.order
end

function Battler:GetskillPowerCostReduceChaos()
  return self._skillPowerCostReduce.chaos
end

function Battler:RefreshCurrentBattleInjury(injury)
  self._currentBattleInjury = self._currentBattleInjury + injury
end

function Battler:RefreshCurrentBattleTreatment(treatment)
  self._currentBattleTreatment = self._currentBattleTreatment + treatment
end

function Battler:GetCurrentBattleDamage()
  return self._currentBattleDamage
end

function Battler:GetCurrentBattleInjury()
  return self._currentBattleInjury
end

function Battler:GetCurrentBattleTreatment()
  return self._currentBattleTreatment
end

function Battler:OnDeadDisappearEvent(floatValue, intValue, stringValue, objectValue, clipName)
  self._disappearAnimationEnd = true
  AnimationEventTriggerHelper.RemoveAnimationEventListener(self._gameObject, self._disappearEventHandler)
  self._disappearEventHandler = 0
  NekoData.DataManager.DM_Battle:RemoveEntity(self._entityId)
end

function Battler:GetAttribute()
  return self._attribute
end

function Battler:GetConfigId()
  return self._attribute.id
end

function Battler:DestroyPointEffectByName(slotName, effectname)
  local effectGameObject = TransformStaticFunctions.GetChild(self._transform, slotName .. "/" .. effectname .. "(Clone)(Clone)")
  if effectGameObject then
    GameObjectHelper.DestroyObject(effectGameObject)
  end
end

function Battler:GetKey()
  return self._attribute.key
end

function Battler:IsRole()
  return self._attribute.id >= 1 and self._attribute.id < 10000
end

function Battler:IsAlive()
  return self._attribute.hp > 0
end

function Battler:IsBoss()
  if self._attribute.id >= 10000 then
    local CMonsterConfigTable = BeanManager.GetTableByName("npc.cmonsterconfig")
    local r = CMonsterConfigTable:GetRecorder(self._attribute.id)
    if r then
      return r.bossOrNot == 1
    end
  end
  return false
end

function Battler:GetSkillList()
  local CSkillTable = BeanManager.GetTableByName("skill.cskill")
  local list = {}
  for i, v in ipairs(self._attribute.skilllist) do
    if CSkillTable:GetRecorder(v).type ~= 5 then
      table.insert(list, v)
    end
  end
  if 2 < #list then
    for i = 2, #list do
      list[i] = nil
    end
  end
  return list
end

function Battler:SetSkillIsInCD(skillId, isInCD)
  self._skillCDList[skillId] = self._skillCDList[skillId] or {}
  self._skillCDList[skillId].isInCD = isInCD
end

function Battler:GetSkillIsInCD(skillId)
  local StateType = {notInCD = 0, inCD = 1}
  if self._skillCDList[skillId] then
    return self._skillCDList[skillId].isInCD == StateType.inCD
  else
    return false
  end
end

function Battler:SetSkillCountTime(skillId, countTime)
  self._skillCDList[skillId] = self._skillCDList[skillId] or {}
  self._skillCDList[skillId].countTime = countTime
end

function Battler:GetSkillCountTime(skillId)
  if self._skillCDList[skillId] then
    return self._skillCDList[skillId].countTime or 0
  else
    return 0
  end
end

function Battler:SetSkillAutoCDTime(skillId, autoClickTime)
  self._skillCDList[skillId] = self._skillCDList[skillId] or {}
  self._skillCDList[skillId].autoCDTime = autoClickTime
end

function Battler:GetSkillAutoCDTime(skillId)
  if self._skillCDList[skillId] then
    return self._skillCDList[skillId].autoCDTime or 0
  else
    return 0
  end
end

function Battler:GetBossHpStage()
  return self._attribute.bosshpstage
end

function Battler:SetBossHpStage(bosshpstage)
  self._attribute.bosshpstage = bosshpstage
end

function Battler:GetEntityId()
  return self._entityId
end

function Battler:GetCollaborativeSkillNum()
  return math.max(self._attribute.comborate1, self._attribute.comborate2)
end

function Battler:IfSkillIsEnergy(skillId)
  local skillList = self:GetSkillList()
  for index, id in ipairs(skillList) do
    if skillId == id then
      if index == 1 then
        do return self._attribute.comborate1 > 0 end
        break
      end
      if index == 2 then
        return 0 < self._attribute.comborate2
      end
      break
    end
  end
  return false
end

function Battler:GetSoulQuantity()
  if self._attribute.id >= 10000 then
    local CMonsterConfigTable = BeanManager.GetTableByName("npc.cmonsterconfig")
    local r = CMonsterConfigTable:GetRecorder(self._attribute.id)
    if r then
      return r.soulQuantity
    end
  end
  return 0
end

function Battler:GetGameObject()
  return self._gameObject
end

function Battler:IsLeftCamp()
  return self._attribute.camp == def.LeftFighter
end

function Battler:IsRightCamp()
  return self._attribute.camp == def.RightFighter
end

function Battler:GetCamp()
  return self._attribute.camp
end

function Battler:GetSlotPosition(slotName)
  local x, y, z = TransformStaticFunctions.GetPosition(self._transform)
  if slotName then
    local slotGameObject = TransformStaticFunctions.GetChild(self._transform, slotName)
    if slotGameObject then
      x, y, z = TransformStaticFunctions.GetPosition(slotGameObject)
    end
  end
  return x, y, z
end

function Battler:SetPosition(posX, posY, posZ)
  posZ = posZ or self._attribute.z
  self._attribute.x, self._attribute.y, self._attribute.z = posX, posY, posZ
  if self._gameObject then
    TransformStaticFunctions.SetPosition(self._gameObject, self._attribute.x / 1000, self._attribute.y / 1000, self._attribute.z / 1000)
  end
end

function Battler:GetPosition()
  return self._attribute.x, self._attribute.y, self._attribute.z
end

function Battler:SetGameObject(gameObject)
  if self._gameObject then
    GameObjectHelper.DestroyObject(self._gameObject)
    self._gameObject = nil
    self._transform = nil
  end
  self._gameObject = gameObject
  self._transform = gameObject.transform
end

function Battler:SetHP(hp, hpmax)
  hpmax = hpmax or self._attribute.hpmax
  self._attribute.hp = hp
  self._attribute.hpmax = hpmax
end

function Battler:GetHp()
  return self._attribute.hp
end

function Battler:GetHpMax()
  return self._attribute.hpmax
end

function Battler:PlayAnimation(animationName, ignorePriority)
  if self._gameObject then
    local playingAnimationPriority = AnimationHelper.GetBattleAnimationPriority(self._gameObject, self:GetCurrentAnimatiionClipName())
    local addAnimationPriority = AnimationHelper.GetBattleAnimationPriority(self._gameObject, animationName)
    if playingAnimationPriority <= addAnimationPriority or ignorePriority then
      AnimationHelper.PlayAnimation(self._gameObject, animationName, -1, 0)
      if animationName == "DeadDisappear" and self._attribute.id == 1 and self:IsHaveAlternate() then
        TransformStaticFunctions.SetLayer(self._gameObject, Layers.InvisibleLayerID)
      end
      if TransformStaticFunctions.GetChild(self._transform, "HitPoint_Body") then
        TransformStaticFunctions.GetChild(self._transform, "HitPoint_Body"):SetActive(animationName ~= "DeadDisappear")
      end
      TransformStaticFunctions.GetChild(self._transform, "HitPoint_Head"):SetActive(animationName ~= "DeadDisappear")
    end
  end
end

function Battler:GetCurrentAnimatiionClipName()
  local animationName = AnimationHelper.GetCurrentAnimatiionClipName(self._gameObject)
  return animationName
end

function Battler:SetGameObjectActive(flag)
  self._gameObject:SetActive(flag)
end

function Battler:PlayEffect(packageName, effectName, slotName, angle)
  if self._gameObject then
    local slotGameObject = TransformStaticFunctions.GetChild(self._transform, slotName)
    local effectGameObject = BattleSceneHelper.CreateEffect(packageName, effectName, slotGameObject)
    if angle then
      local angleX, angleY, angleZ = TransformStaticFunctions.GetWorldEuler(effectGameObject)
      TransformStaticFunctions.SetWorldEuler(effectGameObject, angleX, angleY, angle)
    end
    return effectGameObject
  end
end

function Battler:SetHpBarAnimationState(state)
  self._hpBarAnimationState = state
end

function Battler:GetHpBarAnimationState()
  return self._hpBarAnimationState
end

function Battler:GetShapeRecorder()
  return {
    assetBundleName = self._attribute.assetbundlename,
    prefabName = self._attribute.prefabname
  }
end

function Battler:IsInitialPlayer()
  local initialTagType = {Not = 0, Is = 1}
  return self._isInitialPlayer == initialTagType.Is
end

function Battler:IsHaveAlternate()
  return self._attribute.havealternate == 1
end

function Battler:GetNameTextId()
  return self._attribute.nameTextId
end

function Battler:SetNameTextId(nameTextId)
  self._attribute.nameTextId = nameTextId
end

function Battler:SetGameObjectVisible(visible)
  local SpriteShowType = {
    None = -1,
    Show = 1,
    Hide = 0,
    OnlyHideHitPoint = 2,
    OnlyShowHitPoint = 3
  }
  local preVisibleCount = self._visibleCount
  local preHitpointVisibleCount = self._hitpointVisibleCount
  if visible == SpriteShowType.Show then
    self._visibleCount = self._visibleCount + 1
  elseif visible == SpriteShowType.Hide then
    self._visibleCount = self._visibleCount - 1
  elseif visible == SpriteShowType.OnlyShowHitPoint then
    self._hitpointVisibleCount = self._hitpointVisibleCount + 1
  elseif visible == SpriteShowType.OnlyHideHitPoint then
    self._hitpointVisibleCount = self._hitpointVisibleCount - 1
  end
  if 0 <= self._visibleCount then
    if preVisibleCount < 0 then
      TransformStaticFunctions.SetLayer(self._gameObject, Layers.NewDemoFighterLayerID)
    end
  elseif 0 > self._visibleCount and 0 <= preVisibleCount then
    TransformStaticFunctions.SetLayer(self._gameObject, Layers.InvisibleLayerID)
  end
  if 0 <= self._hitpointVisibleCount then
    if preHitpointVisibleCount < 0 then
      local child = TransformStaticFunctions.GetChild(self._transform, "HitPoint")
      local childList, len = CS.PixelNeko.Lua.TransformStaticFunctions.GetFirstOrderChildren(child.gameObject)
      for i = 0, len - 1 do
        local gameObj = childList[i]
        if gameObj then
          TransformStaticFunctions.SetLayer(gameObj, Layers.NewDemoFighterLayerID)
        end
      end
      child = TransformStaticFunctions.GetChild(self._transform, "HitPoint_Head")
      childList, len = CS.PixelNeko.Lua.TransformStaticFunctions.GetFirstOrderChildren(child.gameObject)
      for i = 0, len - 1 do
        local gameObj = childList[i]
        if gameObj then
          TransformStaticFunctions.SetLayer(gameObj, Layers.NewDemoFighterLayerID)
        end
      end
      child = TransformStaticFunctions.GetChild(self._transform, "HitPoint_Bottom")
      childList, len = CS.PixelNeko.Lua.TransformStaticFunctions.GetFirstOrderChildren(child.gameObject)
      for i = 0, len - 1 do
        local gameObj = childList[i]
        if gameObj then
          TransformStaticFunctions.SetLayer(gameObj, Layers.NewDemoFighterLayerID)
        end
      end
      child = TransformStaticFunctions.GetChild(self._transform, "HitPoint_Body")
      childList, len = CS.PixelNeko.Lua.TransformStaticFunctions.GetFirstOrderChildren(child.gameObject)
      for i = 0, len - 1 do
        local gameObj = childList[i]
        if gameObj then
          TransformStaticFunctions.SetLayer(gameObj, Layers.NewDemoFighterLayerID)
        end
      end
    end
  elseif 0 > self._hitpointVisibleCount and 0 <= preHitpointVisibleCount then
    local child = TransformStaticFunctions.GetChild(self._transform, "HitPoint")
    local childList, len = CS.PixelNeko.Lua.TransformStaticFunctions.GetFirstOrderChildren(child.gameObject)
    for i = 0, len - 1 do
      local gameObj = childList[i]
      if gameObj then
        TransformStaticFunctions.SetLayer(gameObj, Layers.InvisibleLayerID)
      end
    end
    child = TransformStaticFunctions.GetChild(self._transform, "HitPoint_Head")
    childList, len = CS.PixelNeko.Lua.TransformStaticFunctions.GetFirstOrderChildren(child.gameObject)
    for i = 0, len - 1 do
      local gameObj = childList[i]
      if gameObj then
        TransformStaticFunctions.SetLayer(gameObj, Layers.InvisibleLayerID)
      end
    end
    child = TransformStaticFunctions.GetChild(self._transform, "HitPoint_Bottom")
    childList, len = CS.PixelNeko.Lua.TransformStaticFunctions.GetFirstOrderChildren(child.gameObject)
    for i = 0, len - 1 do
      local gameObj = childList[i]
      if gameObj then
        TransformStaticFunctions.SetLayer(gameObj, Layers.InvisibleLayerID)
      end
    end
    child = TransformStaticFunctions.GetChild(self._transform, "HitPoint_Body")
    childList, len = CS.PixelNeko.Lua.TransformStaticFunctions.GetFirstOrderChildren(child.gameObject)
    for i = 0, len - 1 do
      local gameObj = childList[i]
      if gameObj then
        TransformStaticFunctions.SetLayer(gameObj, Layers.InvisibleLayerID)
      end
    end
  end
end

function Battler:GetLevel()
  return self._attribute.level
end

function Battler:GetExclusiveLevel()
  return self._attribute.exclusiveLevel
end

function Battler:IsTypeStyle()
  if self:IsRole() then
    return true
  else
    local monsterRecord = BattleECS.Utility.DataUtility.cMonsterCfgTable[self:GetConfigId()]
    if monsterRecord then
      return monsterRecord.typeStyle == 0
    else
      LogErrorFormat("Battler", "monster id %s is not exist in cmonsterconfig", self:GetConfigId())
    end
    return true
  end
end

function Battler:SetFatherEntityId(entityid)
  self._fatherEntityId = entityid
end

function Battler:GetFatherEntityId()
  return self._fatherEntityId or 0
end

function Battler:GetViolentState()
  return self._violentState
end

function Battler:SetViolentState(state)
  self._violentState = state
end

return Battler
