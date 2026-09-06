local BuffUtility = {}
local AttrTypeEnum = BattleClientProtocolManager.GetBeanDef("data.attrtype")
local FirstAttrTypeNameList = {
  "defend",
  "bonus",
  "reduce",
  "block",
  "defbreak",
  "extradmg"
}
local StaticAttrTypeNameList = {
  "staticmaxhp",
  "staticattack",
  "staticdefend",
  "staticmagicdef",
  "staticcritrate",
  "staticcritdegree"
}
local OtherAttrTypeNameList = {
  "atktimes",
  "atknums",
  "continualbuffatktimes",
  "evolution",
  "exclusivelv"
}

function BuffUtility.InsertEntityDifferentBuff(...)
  local args = {
    ...
  }
  local data = args[1]
  local buffid = data.buffid
  local enermyentity = data.enermyentity
  local bComponent = enermyentity:GetComponent(BattleECS.Components.BuffComponent)
  local record = BattleECS.Utility.DataUtility.cBuffCfgTable[buffid]
  if record then
    if record.delayFrame == 0 then
      BuffUtility.CreateBuffObject(data)
    elseif record.redelay == 0 then
      table.insert(bComponent._delayBuffList, {
        data = data,
        delayFrame = record.delayFrame,
        actualFrame = 0
      })
    elseif record.redelay == 1 then
      local dontHasBuff = true
      for _, v in ipairs(bComponent._delayBuffList) do
        if v.data.buffid == data.buffid then
          v.actualFrame = 0
          dontHasBuff = false
          break
        end
      end
      if dontHasBuff then
        table.insert(bComponent._delayBuffList, {
          data = data,
          delayFrame = record.delayFrame,
          actualFrame = 0
        })
      end
    else
      LogErrorFormat("Buff", "buffid %s wrong ccbuffconfig.redelay %s", data.buffid, record.redelay)
    end
  else
    BuffUtility.CreateBuffObject(data)
  end
end

function BuffUtility.CreateBuffObject(data)
  local entity = data.entity
  local buffid = data.buffid
  local enermyEntity = data.enermyentity
  local buffParamter = data.buffparamter
  local skillid = data.skillid
  local battleWorld = data.battleworld
  local originalBuffId = data.originalBuffId
  local rad = data.rad
  local damagetransformparamter = data.damagetransformparamter
  local fixedpointAttrValue = data.fixedpointAttrValue
  local isPlayAttackedEffect = data.isplayattackedeffect
  local isconnect = data.isconnect
  local TypeComponent = BattleECS.Components.TypeComponent
  local entityTypeCom = entity:GetComponent(TypeComponent)
  local enemyEntityTypeCom = enermyEntity:GetComponent(TypeComponent)
  if battleWorld._guardBuffLeftEntityid ~= 0 or battleWorld._guardBuffRightEntityid ~= 0 then
    local camp = entityTypeCom._camp
    local friendHasGuardBuffEntity
    if camp == TypeComponent.CampType.Left then
      friendHasGuardBuffEntity = nil
      for i, e in ipairs(battleWorld._entitys) do
        if e._entityId == battleWorld._guardBuffLeftEntityid then
          friendHasGuardBuffEntity = e
          break
        end
      end
    elseif camp == TypeComponent.CampType.Right then
      friendHasGuardBuffEntity = nil
      for i, e in ipairs(battleWorld._entitys) do
        if e._entityId == battleWorld._guardBuffRightEntityid then
          friendHasGuardBuffEntity = e
          break
        end
      end
    end
    if friendHasGuardBuffEntity and not BattleECS.Utility.Utility.IsRoleDead(friendHasGuardBuffEntity) and BuffUtility.IsDisposableDamageBuff(buffid) then
      entity = friendHasGuardBuffEntity
    end
  end
  if not BattleECS.Utility.Utility.IsRoleDead(entity) or BattleECS.Utility.Utility.IsRoleDead(entity) and buffid == 10006 then
    local component = entity:GetComponent(BattleECS.Components.BuffComponent)
    if component then
      local isHas = BuffUtility.IsHasCurrentBuff(entity, buffid)
      if not isHas then
        if entityTypeCom and enemyEntityTypeCom and entityTypeCom._camp ~= enemyEntityTypeCom._camp and buffid ~= 20000 and BattleECS.Utility.BuffUtility.GetBuffLimiteType(buffid) & 2 ~= 0 then
          local skillList = BattleECS.Utility.BuffUtility.IsHasTriggerBuffWhenEntityHasBeenHittedByLimitSkillBuff(entity, battleWorld._randomPcg)
          for _, v in ipairs(skillList) do
            BattleECS.Utility.Utility.SetSkillComponnetPassiveSkillList(entity, v, entity)
          end
          if #skillList ~= 0 then
            LogInfoFormat("BuffUtility", "buff id %s 未加上; 因为 entityid %s 含有连携类型为19的buff", buffid, entity._entityId)
            return
          end
        end
        if BuffUtility.IsHasCanNotJoinBuff(entity, buffid) then
          LogInfoFormat("BuffUtility", "entityid %s buffid免疫:%s", entity._entityId, buffid)
          local DamageType = {DontShowMiss = 7}
          local buffCom = entity:GetComponent(BattleECS.Components.BuffComponent)
          local hasDontShowMissBuff = false
          for _, v in ipairs(buffCom._buffList) do
            if v.buffId == 20099 and entity:GetComponent(BattleECS.Components.TypeComponent)._roleID == 13 then
              hasDontShowMissBuff = true
              break
            end
            if v.buffId == 20835 then
              hasDontShowMissBuff = true
              break
            end
            if buffid == 21820 or buffid == 21823 then
              hasDontShowMissBuff = true
              break
            end
          end
          if hasDontShowMissBuff then
            BattleECS.Utility.ProtocolUtility.SendDamageMissProtocol(entity._entityId, DamageType.DontShowMiss, battleWorld)
          else
            BattleECS.Utility.ProtocolUtility.SendDamageMissProtocol(entity._entityId, 5, battleWorld)
          end
          BattleECS.Utility.BuffUtility.ClearYingXiBuff(enermyEntity, skillid)
        elseif BuffUtility.ChangeBuffEffectCount(entity, buffid) then
          BattleECS.Utility.ProtocolUtility.SendDamageMissProtocol(entity._entityId, 4, battleWorld)
          BattleECS.Utility.BuffUtility.ClearYingXiBuff(enermyEntity, skillid)
        else
          local buffObject = BattleECS.Buff.Buff.Create({
            buffid = buffid,
            buffparamter = buffParamter,
            entity = entity,
            enermyentity = enermyEntity,
            skillid = skillid,
            battleworld = battleWorld,
            rad = rad,
            damagetransformparamter = damagetransformparamter,
            isplayattackedeffect = isPlayAttackedEffect,
            isconnect = isconnect,
            originalBuffId = originalBuffId,
            fixedpointAttrValue = fixedpointAttrValue
          })
          local alwaysHaveThisBuff = false
          for i, v in ipairs(component._buffList) do
            if v.buffId == buffid then
              component._buffList[i].buffObj = buffObject
              alwaysHaveThisBuff = true
              break
            end
          end
          if not alwaysHaveThisBuff then
            table.insert(component._buffList, {buffId = buffid, buffObj = buffObject})
          end
          buffObject:SetBuffContinuedTime(0)
          local mutexList = BuffUtility.GetBuffMutexByGroup(buffid)
          local deleteBuffNum
          if buffid == 10013 then
            deleteBuffNum = 0
          end
          for _, v in ipairs(mutexList) do
            local cancelBuffList = BuffUtility.RemoveEntityBuffByBuffType(entity, v)
            for _, bId in ipairs(cancelBuffList) do
              local skillList = BattleECS.Utility.BuffUtility.IsHasTriggerWhenBuffIsCancelled(entity, bId, battleWorld._randomPcg)
              for _, sId in ipairs(skillList) do
                BattleECS.Utility.Utility.SetSkillComponnetPassiveSkillList(entity, sId, entity)
              end
            end
            deleteBuffNum = deleteBuffNum and deleteBuffNum + 1
          end
          mutexList = BuffUtility.GetBuffMuteByBuffid(buffid)
          for _, v in ipairs(mutexList) do
            local cancelBuffList = BuffUtility.RemoveEntityBuff(entity, v)
            for _, bId in ipairs(cancelBuffList) do
              local skillList = BattleECS.Utility.BuffUtility.IsHasTriggerWhenBuffIsCancelled(entity, bId, battleWorld._randomPcg)
              for _, sId in ipairs(skillList) do
                BattleECS.Utility.Utility.SetSkillComponnetPassiveSkillList(entity, sId, entity)
              end
            end
            deleteBuffNum = deleteBuffNum and deleteBuffNum + 1
          end
          if deleteBuffNum then
            enermyEntity:GetComponent(BattleECS.Components.BuffComponent)._dispelbuffnum = deleteBuffNum
          end
        end
      else
        local buffObject
        for _, v in ipairs(component._buffList) do
          if v.buffId == buffid then
            buffObject = v.buffObj
            break
          end
        end
        local OverRideType = {
          Cover = 0,
          RespectivelyShow = 1,
          Overlay = 2,
          OverlayWithoutRefreshTime = 3
        }
        local buffOverRideType = BuffUtility.GetBuffOverRideType(buffid)
        if not BattleECS.Utility.DataUtility.cIBuffCfgTable[buffid] and buffOverRideType == OverRideType.Cover then
          buffObject:ClearBuffAdditionalAttribute()
        end
        buffObject:SetEnermyEntity(enermyEntity)
        buffObject:SetSkillid(skillid)
        buffObject:SetOriginalBuffId(originalBuffId or buffid)
        buffObject:SetBuffParam(buffParamter)
        if BattleECS.Utility.DataUtility.cIBuffCfgTable[buffid] then
          buffObject:InitContinueBuffInfo()
        else
          if buffOverRideType == OverRideType.RespectivelyShow or buffOverRideType == OverRideType.Overlay or buffOverRideType == OverRideType.OverlayWithoutRefreshTime then
            buffObject:SetStackTimesCur(buffObject:GetStackTimesCur() + 1)
          end
          if buffOverRideType == OverRideType.OverlayWithoutRefreshTime then
            buffObject:SetBuffContinuedTime(buffObject:GetBuffContinuedTime(), true, false, true)
          else
            buffObject:SetBuffContinuedTime(0, true)
          end
          buffObject:SetBuffEffectCount(0)
          if (buffOverRideType == OverRideType.Overlay or buffOverRideType == OverRideType.OverlayWithoutRefreshTime) and 1 < buffObject:GetStackTimes() then
            buffObject:SetStackTimes(buffObject:GetStackTimes() - 1)
          end
        end
      end
    end
  end
end

function BuffUtility.GetSpecialRoundBuffTargetEntityList(entity, battleWorld, rankType, rankNum)
  local camp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
  local list = {}
  if camp == BattleECS.Components.TypeComponent.CampType.Left then
    for _, v in ipairs(battleWorld._leftPlayerList) do
      if not BattleECS.Utility.Utility.IsRoleDead(v) then
        table.insert(list, v)
      end
    end
    for _, v in ipairs(battleWorld._leftPlayerSummonList) do
      if not BattleECS.Utility.Utility.IsRoleDead(v) then
        table.insert(list, v)
      end
    end
  elseif camp == BattleECS.Components.TypeComponent.CampType.Right then
    for _, v in ipairs(battleWorld._rightPlayerList) do
      if not BattleECS.Utility.Utility.IsRoleDead(v) then
        table.insert(list, v)
      end
    end
    for _, v in ipairs(battleWorld._rightPlayerSummonList) do
      if not BattleECS.Utility.Utility.IsRoleDead(v) then
        table.insert(list, v)
      end
    end
  end
  if table.nums(list) > 1 then
    if rankType == 1 then
      table.sort(list, function(a, b)
        return a:GetComponent(BattleECS.Components.HpComponent)._currentHp < b:GetComponent(BattleECS.Components.HpComponent)._currentHp
      end)
    elseif rankType == 2 then
      table.sort(list, function(a, b)
        return a:GetComponent(BattleECS.Components.HpComponent)._currentHp > b:GetComponent(BattleECS.Components.HpComponent)._currentHp
      end)
    elseif rankType == 3 then
      table.sort(list, function(a, b)
        if a:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Left then
          return a:GetComponent(BattleECS.Components.PositionComponent)._position.x > b:GetComponent(BattleECS.Components.PositionComponent)._position.x
        else
          return a:GetComponent(BattleECS.Components.PositionComponent)._position.x < b:GetComponent(BattleECS.Components.PositionComponent)._position.x
        end
      end)
    elseif rankType == 4 then
      table.sort(list, function(a, b)
        if a:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Left then
          return a:GetComponent(BattleECS.Components.PositionComponent)._position.x < b:GetComponent(BattleECS.Components.PositionComponent)._position.x
        else
          return a:GetComponent(BattleECS.Components.PositionComponent)._position.x > b:GetComponent(BattleECS.Components.PositionComponent)._position.x
        end
      end)
    elseif rankType == 5 then
      local long = table.nums(list) + 1
      local random = battleWorld._randomPcg(1, long)
      while list[random] and rankNum < table.nums(list) do
        table.remove(list, random)
        random = battleWorld._randomPcg(1, long)
      end
    elseif rankType == 6 then
      list = {}
      table.insert(list, entity)
    elseif rankType == 8 then
      table.sort(list, function(a, b)
        return a:GetComponent(BattleECS.Components.HpComponent)._currentHp / a:GetComponent(BattleECS.Components.HpComponent)._maxHp < b:GetComponent(BattleECS.Components.HpComponent)._currentHp / b:GetComponent(BattleECS.Components.HpComponent)._maxHp
      end)
    elseif rankType == 9 then
      table.sort(list, function(a, b)
        return a:GetComponent(BattleECS.Components.HpComponent)._currentHp / a:GetComponent(BattleECS.Components.HpComponent)._maxHp > b:GetComponent(BattleECS.Components.HpComponent)._currentHp / b:GetComponent(BattleECS.Components.HpComponent)._maxHp
      end)
    end
  end
  if rankType ~= 5 then
    local removeList = {}
    for k = #list, 1, -1 do
      if rankNum < k then
        table.insert(removeList, k)
      end
    end
    for _, k in ipairs(removeList) do
      table.remove(list, k)
    end
  end
  return list
end

function BuffUtility.RemoveEntityBuffByBuffType(entity, buffType)
  local buffList = {}
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = component._buffList[i]
      if v and buffType == BuffUtility.GetBuffType(v.buffId) then
        table.insert(buffList, v.buffId)
        table.insert(removeBuffIdList, v.buffId)
      end
    end
    for i = #component._buffList, 1, -1 do
      local v = component._buffList[i]
      if v and buffType == BuffUtility.GetBuffType(v.buffId) then
        v.buffObj:Destroy()
      end
    end
    local removeList = {}
    for _, removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = component._buffList[i]
        if v.buffId == removingBuffId then
          table.insert(removeList, i)
        end
      end
    end
    for _, i in ipairs(removeList) do
      table.remove(component._buffList, i)
    end
  end
  return buffList
end

function BuffUtility.RemoveEntityBuff(entity, buffid)
  local buffList = {}
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = component._buffList[i]
      if v and v.buffId == buffid then
        table.insert(buffList, v.buffId)
        table.insert(removeBuffIdList, v.buffId)
      end
    end
    for i = #component._buffList, 1, -1 do
      local v = component._buffList[i]
      if v and v.buffId == buffid then
        v.buffObj:Destroy()
      end
    end
    local removeList = {}
    for _, removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = component._buffList[i]
        if v.buffId == removingBuffId then
          table.insert(removeList, i)
        end
      end
    end
    for _, i in ipairs(removeList) do
      table.remove(component._buffList, i)
    end
  end
  return buffList
end

function BuffUtility.RemoveEntityBuffBySkillID(entity, skillid)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = component._buffList[i]
      if v and v.buffObj:GetBuffSkillID() == skillid and v.buffObj:GetBuffClassName() and v.buffObj:GetBuffClassName() == "areabuff" then
        table.insert(removeBuffIdList, v.buffId)
      end
    end
    for i = #component._buffList, 1, -1 do
      local v = component._buffList[i]
      if v and v.buffObj:GetBuffSkillID() == skillid and v.buffObj:GetBuffIsDamagedTriggerContinue() then
        v.buffObj:SetBuffTotalTime(1)
        v.buffObj:SetBuffContinuedTime(1)
      end
      if v and v.buffObj:GetBuffSkillID() == skillid and v.buffObj:GetBuffClassName() and v.buffObj:GetBuffClassName() == "areabuff" then
        v.buffObj:Destroy()
      end
    end
    local removeList = {}
    for _, removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = component._buffList[i]
        if v.buffId == removingBuffId then
          table.insert(removeList, i)
        end
      end
    end
    for _, i in ipairs(removeList) do
      table.remove(component._buffList, i)
    end
  end
end

function BuffUtility.ChangeBuffEffectCount(entity, buffid)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      if v.buffObj:GetBuffEffectCountTotal() and v.buffObj:GetBuffEffectCountTotal() > v.buffObj:GetBuffEffectCount() and BuffUtility.IsCancelBecauseEffectCount(v.buffObj, buffid) then
        v.buffObj:SetBuffEffectCount(v.buffObj:GetBuffEffectCount() + 1)
        return true
      end
    end
  end
  return false
end

function BuffUtility.IsEntityHasBreakBuff(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      if v.buffObj:GetBuffClassName() and v.buffObj:GetBuffClassName() == "breakbuff" then
        return true
      end
    end
  end
  return false
end

function BuffUtility.IsCancelBecauseEffectCount(buffObject, inserbuffid)
  local bufflist = buffObject:GetEffectBuffList()
  for _, v in ipairs(bufflist) do
    if v == inserbuffid then
      return true
    end
  end
  return false
end

function BuffUtility.ClearEntityBuffList(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = component._buffList[i]
      if v and v.buffId ~= 20000 then
        v.buffObj:Destroy()
        table.insert(removeBuffIdList, v.buffId)
      end
    end
    local removeList = {}
    for _, removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = component._buffList[i]
        if v.buffId == removingBuffId then
          table.insert(removeList, i)
        end
      end
    end
    for _, i in ipairs(removeList) do
      table.remove(component._buffList, i)
    end
    component._delayBuffList = {}
  end
end

function BuffUtility.IsHasYingXiContinueBuff(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      if v.buffId == 20045 or v.buffId == 20151 or v.buffId == 20152 or v.buffId == 20153 or v.buffId == 20154 then
        return true, v.buffObj
      end
    end
  end
  return false
end

function BuffUtility.ClearDeadEntityBuff(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = component._buffList[i]
      if v and v.buffId ~= 20000 and v.buffId ~= 20168 then
        local buffConfig = BattleECS.Utility.DataUtility.cBuffCfgTable[v.buffId]
        if buffConfig then
          if buffConfig.removeType == 0 or buffConfig.removeType == 1 then
            v.buffObj:Destroy()
            table.insert(removeBuffIdList, v.buffId)
          elseif buffConfig.removeType == 6 then
            v.buffObj:SetBuffIsEffect(false)
          end
        else
          v.buffObj:Destroy()
          table.insert(removeBuffIdList, v.buffId)
        end
      end
    end
    local removeList = {}
    for _, removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = component._buffList[i]
        if v.buffId == removingBuffId then
          table.insert(removeList, i)
        end
      end
    end
    for _, i in ipairs(removeList) do
      table.remove(component._buffList, i)
    end
    component._delayBuffList = {}
  end
end

function BuffUtility.RevivePlayerBuffState(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      local buffConfig = BattleECS.Utility.DataUtility.cBuffCfgTable[v.buffId]
      if buffConfig and buffConfig.removeType == 6 then
        v.buffObj:SetBuffIsEffect(true)
      end
    end
  end
end

function BuffUtility.ClearBattleEndEntityBuff(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = component._buffList[i]
      local buffConfig = BattleECS.Utility.DataUtility.cBuffCfgTable[v.buffId]
      if v and v.buffId ~= 20000 then
        if buffConfig then
          if buffConfig.removeType == 0 or buffConfig.removeType == 1 then
            v.buffObj:Destroy()
            table.insert(removeBuffIdList, v.buffId)
          end
        else
          v.buffObj:Destroy()
          table.insert(removeBuffIdList, v.buffId)
        end
      end
    end
    local removeList = {}
    for _, removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = component._buffList[i]
        if v.buffId == removingBuffId then
          table.insert(removeList, i)
        end
      end
    end
    for _, i in ipairs(removeList) do
      table.remove(component._buffList, i)
    end
    component._delayBuffList = {}
  end
end

function BuffUtility.RemoveBuffWithClassName(entity, className)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = component._buffList[i]
      if v and v.buffObj:GetBuffClassName() and v.buffObj:GetBuffClassName() == className then
        v.buffObj:Destroy()
        table.insert(removeBuffIdList, v.buffId)
      end
    end
    local removeList = {}
    for _, removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = component._buffList[i]
        if v.buffId == removingBuffId then
          table.insert(removeList, i)
        end
      end
    end
    for _, i in ipairs(removeList) do
      table.remove(component._buffList, i)
    end
  end
end

function BuffUtility.SetEntityBuffEffectState(entity, buffid, isEffect)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      if v.buffId == buffid then
        v.buffObj:SetBuffIsEffect(isEffect)
      end
    end
  end
end

function BuffUtility.GetEntityBuffEffectState(entity, buffid)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      if v.buffId == buffid then
        return v.buffObj:GetBuffIsEffect()
      end
    end
  end
  return false
end

function BuffUtility.IsCanBeChosenInDifferentCampSkill(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      local temp = v.buffObj:GetBuffInfluenceEntityIsCanBeChosenBySkillState()
      if temp == 1 or temp == 3 then
        return false
      end
    end
  end
  return true
end

function BuffUtility.IsCanBeChosenInSameCampSkill(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      local temp = v.buffObj:GetBuffInfluenceEntityIsCanBeChosenBySkillState()
      if temp == 2 or temp == 3 then
        return false
      end
    end
  end
  return true
end

function BuffUtility.GetBuffType(buffid)
  local buffConfig = BattleECS.Utility.DataUtility.cBuffCfgTable[buffid]
  if buffConfig then
    return buffConfig.buffType
  end
  return -1
end

function BuffUtility.GetBuffOverRideType(buffid)
  local buffConfig = BattleECS.Utility.DataUtility.cBuffCfgTable[buffid]
  if buffConfig then
    return buffConfig.overrideSelfType
  end
end

function BuffUtility.IsHasCanNotJoinBuff(entity, buffid)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      local buffType = BuffUtility.GetBuffType(v.buffId)
      local buffConfig = BattleECS.Utility.DataUtility.cBuffConficsTable[buffType]
      if buffConfig then
        local buffidstrlist = string.split(buffConfig.immunebuff, ";")
        local bufftypestrlisyt = string.split(buffConfig.immunebuffGroud, ";")
        for _, value in ipairs(buffidstrlist) do
          if tonumber(buffid) == tonumber(value) then
            return true
          end
        end
        for _, value in ipairs(bufftypestrlisyt) do
          if tonumber(BuffUtility.GetBuffType(tonumber(buffid))) == tonumber(value) then
            return true
          end
        end
      end
      buffConfig = BattleECS.Utility.DataUtility.cBuffConficsTable[v.buffId]
      if buffConfig then
        local buffidstrlist = string.split(buffConfig.immunebuff, ";")
        local bufftypestrlisyt = string.split(buffConfig.immunebuffGroud, ";")
        for _, value in ipairs(buffidstrlist) do
          if tonumber(buffid) == tonumber(value) then
            return true
          end
        end
        for _, value in ipairs(bufftypestrlisyt) do
          if tonumber(BuffUtility.GetBuffType(tonumber(buffid))) == tonumber(value) then
            return true
          end
        end
      end
    end
  end
  return false
end

function BuffUtility.GetBuffMutexByGroup(buffid)
  local buffType = BuffUtility.GetBuffType(buffid)
  local buffConfig = BattleECS.Utility.DataUtility.cBuffConficsTable[buffType]
  local list = {}
  if buffConfig then
    for _, v in ipairs(string.split(buffConfig.cancelbuffGroud, ";")) do
      table.insert(list, tonumber(v))
    end
  end
  buffConfig = BattleECS.Utility.DataUtility.cBuffConficsTable[buffid]
  if buffConfig then
    for _, v in ipairs(string.split(buffConfig.cancelbuffGroud, ";")) do
      table.insert(list, tonumber(v))
    end
  end
  return list
end

function BuffUtility.GetBuffMuteByBuffid(buffid)
  local buffType = BuffUtility.GetBuffType(buffid)
  local buffConfig = BattleECS.Utility.DataUtility.cBuffConficsTable[buffType]
  local list = {}
  if buffConfig then
    for _, v in ipairs(string.split(buffConfig.cancelbuff, ";")) do
      table.insert(list, tonumber(v))
    end
  end
  buffConfig = BattleECS.Utility.DataUtility.cBuffConficsTable[buffid]
  if buffConfig then
    for _, v in ipairs(string.split(buffConfig.cancelbuff, ";")) do
      table.insert(list, tonumber(v))
    end
  end
  return list
end

function BuffUtility.IsRoleHasCanNotUseSkillBuff(entity, effecttype, skillid)
  local EffectType = {
    AttackSkill = 1,
    UseSkill = 2,
    Both = 3
  }
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      local buffConfig = BattleECS.Utility.DataUtility.cBuffCfgTable[v.buffId]
      if buffConfig then
        local limit = buffConfig.limitoperations
        if limit == 3 or limit == 7 then
          return true
        elseif limit == 1 then
          if skillid then
            local skillConfig = BattleECS.Utility.DataUtility.cskillTable[skillid]
            if skillConfig and skillConfig.effecttype == 1 then
              return true
            end
          elseif effecttype == EffectType.AttackSkill or effecttype == EffectType.Both then
            return true
          end
        elseif limit == 2 then
          if skillid then
            local skillConfig = BattleECS.Utility.DataUtility.cskillTable[skillid]
            if skillConfig and skillConfig.effecttype == 2 then
              return true
            end
          elseif effecttype == EffectType.UseSkill or effecttype == EffectType.Both then
            return true
          end
        end
        local VisibleType = {GreySkillCell = 4}
        if buffConfig.hideOptions and buffConfig.hideOptions & VisibleType.GreySkillCell ~= 0 then
          return true
        end
      end
    end
  end
  return false
end

function BuffUtility.IsRoleHasCanNotAttackSkillBuff(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      if BuffUtility.GetBuffLimiteType(v.buffId) == 7 then
        return true
      end
    end
  end
  return false
end

function BuffUtility.IsRoleHasCanNotActiveMoveBuff(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      if BuffUtility.GetBuffLimiteType(v.buffId) == 7 then
        return true
      end
    end
  end
  return false
end

function BuffUtility.IsRoleHasInterruptedSKillBuff(entity, skillid)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      if BattleECS.Utility.Utility.IsAttackSkill(skillid) then
        if BuffUtility.GetBuffLimiteType(v.buffId) == 1 or BuffUtility.GetBuffLimiteType(v.buffId) == 3 or BuffUtility.GetBuffLimiteType(v.buffId) == 7 or v.buffId == 10004 then
          return true
        end
      elseif BattleECS.Utility.Utility.IsUseSkill(skillid) and (BuffUtility.GetBuffLimiteType(v.buffId) == 2 or BuffUtility.GetBuffLimiteType(v.buffId) == 3 or BuffUtility.GetBuffLimiteType(v.buffId) == 7 or v.buffId == 10004) then
        return true
      end
    end
  end
  return false
end

function BuffUtility.IsHasCurrentBuff(entity, buffid)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      if v.buffId == buffid then
        return true, v.buffObj
      end
    end
  end
  return false
end

function BuffUtility.GetSKillBuffList(skillid)
  return BattleECS.Utility.DataUtility.CSkillFriendBuffValueTable[skillid] or {}, BattleECS.Utility.DataUtility.CSkillEnemyBuffValueTable[skillid] or {}
end

function BuffUtility.IsSkillHasReviveBuff(skillid)
  local ourlist = BuffUtility.GetSKillBuffList(skillid)
  for _, v in ipairs(ourlist) do
    if v.buffid == 10006 then
      return true
    elseif v.buffid == 20168 then
      return true
    end
  end
  return false
end

function BuffUtility.IsSkillHasPowerChangeOnceBuff(skillid)
  local ourlist = BuffUtility.GetSKillBuffList(skillid)
  for _, v in ipairs(ourlist) do
    if v.buffid == 10011 then
      return true, v
    end
  end
  return false
end

function BuffUtility.GetSkillOverFlowTreatmentBuffInfo(skillid)
  local skillConfig = BattleECS.Utility.DataUtility.cskillTable[skillid]
  local info
  if BattleECS.Utility.DataUtility.CSkillFriendBuffValueTable[skillid] then
    for _, v in ipairs(BattleECS.Utility.DataUtility.CSkillFriendBuffValueTable[skillid]) do
      if v.buffid == 20106 then
        info = {}
        info.buffid = v.buffid
        info.buffparamater = v.buffvalues
      end
    end
  end
  return info
end

function BuffUtility.IsSkillHasInterreptBuff(skillid)
  local ourlist = BuffUtility.GetSKillBuffList(skillid)
  for _, v in ipairs(ourlist) do
    if v.buffid == 10004 then
      return true
    end
  end
  return false
end

local function IsHasTriggerFunction(buffList, randomFunc, buffLinkType, buffId)
  local skillList = {}
  for _, v in ipairs(buffList) do
    if buffId ~= nil and v.buffId ~= buffId then
    else
      local cbufflinkskillRecord
      local cbufflinkskillRecord = BattleECS.Utility.DataUtility.cBuffLinkSkillCfgTable[v.buffId]
      if cbufflinkskillRecord then
        local record = string.split(cbufflinkskillRecord.conditionid, ";")
        for _, value in ipairs(record) do
          if value == buffLinkType and v.buffObj:IsTriggerCDOver() then
            local random = randomFunc(1, 100)
            local rate = v.buffObj:GetBUffTriggerRate()
            local effectTime = v.buffObj:GetLinkSkillEffectTime()
            local totalEffectTime = v.buffObj:GetLinkSkillEffectTotalTime()
            local triggerLinkSkillFlag = random <= rate
            if totalEffectTime and effectTime >= totalEffectTime then
              triggerLinkSkillFlag = false
            end
            if triggerLinkSkillFlag then
              v.buffObj:SetLinkSkillEffectTime(effectTime + 1)
              v.buffObj:ResetTriggerCDCountTime()
              table.insert(skillList, {
                skillid = tonumber(cbufflinkskillRecord.skillid),
                buff = v.buffObj,
                skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)
              })
            end
          end
        end
      end
    end
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenRoleDead(entity, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    local buffList = {}
    for _, v in ipairs(component._buffList) do
      table.insert(buffList, {
        buffId = v.buffId,
        buffObj = v.buffObj
      })
    end
    table.sort(buffList, function(a, b)
      return a.buffObj:GetBuffContinuedTime() < b.buffObj:GetBuffContinuedTime()
    end)
    for k, v in ipairs(buffList) do
      local cbufflinkskillRecord = BattleECS.Utility.DataUtility.cBuffLinkSkillCfgTable[v.buffId]
      if cbufflinkskillRecord then
        local record = string.split(cbufflinkskillRecord.conditionid, ";")
        for _, value in ipairs(record) do
          if value == "1" and v.buffObj:IsTriggerCDOver() then
            local random = randomFunc(1, 100)
            local rate = v.buffObj:GetBUffTriggerRate()
            local effectTime = v.buffObj:GetLinkSkillEffectTime()
            local totalEffectTime = v.buffObj:GetLinkSkillEffectTotalTime()
            local triggerLinkSkillFlag = random <= rate
            if totalEffectTime and effectTime >= totalEffectTime then
              triggerLinkSkillFlag = false
            end
            if triggerLinkSkillFlag then
              v.buffObj:SetLinkSkillEffectTime(effectTime + 1)
              v.buffObj:ResetTriggerCDCountTime()
              table.insert(skillList, {
                skillid = tonumber(cbufflinkskillRecord.skillid),
                skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)
              })
            end
          end
        end
      end
    end
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenShieldNumberChangeZeroAndSameToBuffID(entity, buffid, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    local buffList = {}
    for _, v in ipairs(component._buffList) do
      if v.buffId == buffid then
        table.insert(buffList, {
          buffId = v.buffId,
          buffObj = v.buffObj
        })
      end
    end
    return IsHasTriggerFunction(buffList, randomFunc, "16")
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenShieldBuffEnd(entity, buffid, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillOnEntityList = {}
  local skillOnEnemyEntityList = {}
  if component then
    local buffList = {}
    for _, v in ipairs(component._buffList) do
      if v.buffId == buffid then
        table.insert(buffList, {
          buffId = v.buffId,
          buffObj = v.buffObj
        })
      end
    end
    local cbufflinkskillRecord, record, random, rate, effectTime, totalEffectTime, triggerLinkSkillFlag, divideSkillId, divideSkillGroupId
    for _, v in ipairs(buffList) do
      cbufflinkskillRecord = BattleECS.Utility.DataUtility.cBuffLinkSkillCfgTable[v.buffId]
      if cbufflinkskillRecord then
        record = string.split(cbufflinkskillRecord.conditionid, ";")
        for _, value in ipairs(record) do
          if value == "22" and v.buffObj:IsTriggerCDOver() then
            random = randomFunc(1, 100)
            rate = v.buffObj:GetBUffTriggerRate()
            effectTime = v.buffObj:GetLinkSkillEffectTime()
            totalEffectTime = v.buffObj:GetLinkSkillEffectTotalTime()
            triggerLinkSkillFlag = random <= rate
            if totalEffectTime and effectTime >= totalEffectTime then
              triggerLinkSkillFlag = false
            end
            if triggerLinkSkillFlag then
              v.buffObj:SetLinkSkillEffectTime(effectTime + 1)
              v.buffObj:ResetTriggerCDCountTime()
              divideSkillId = string.split(cbufflinkskillRecord.skillid, ",")
              divideSkillGroupId = string.split(cbufflinkskillRecord.skillgroupid, ",")
              if 1 < #divideSkillId then
                table.insert(skillOnEnemyEntityList, {
                  skillid = tonumber(divideSkillId[1]),
                  buff = v.buffObj,
                  skillgroupid = nil
                })
                table.insert(skillOnEntityList, {
                  skillid = tonumber(divideSkillId[2]),
                  buff = v.buffObj,
                  skillgroupid = nil
                })
              elseif 1 < #divideSkillGroupId then
                table.insert(skillOnEnemyEntityList, {
                  skillid = nil,
                  buff = v.buffObj,
                  skillgroupid = tonumber(divideSkillGroupId[1])
                })
                table.insert(skillOnEntityList, {
                  skillid = nil,
                  buff = v.buffObj,
                  skillgroupid = tonumber(divideSkillGroupId[2])
                })
              end
            end
          end
        end
      end
    end
  end
  return skillOnEnemyEntityList, skillOnEntityList
end

function BuffUtility.IsHasTriggerBuffWhenRoleKillEnermy(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    for _, v in ipairs(component._buffList) do
      local cbufflinkskillRecord
      local cbufflinkskillRecord = BattleECS.Utility.DataUtility.cBuffLinkSkillCfgTable[v.buffId]
      if cbufflinkskillRecord then
        local record = string.split(cbufflinkskillRecord.conditionid, ";")
        for _, value in ipairs(record) do
          if value == "12" and v.buffObj:IsTriggerCDOver() then
            table.insert(skillList, {
              skillid = tonumber(cbufflinkskillRecord.skillid),
              buff = v.buffObj,
              skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)
            })
          end
        end
      end
    end
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenParnterUseSkillCostPower(entity, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "15")
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenPartnerDead(entity, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "14")
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenRoleTreateRemoveDebuff(entity, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "11")
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenRoleDamagedToDead(entity, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "8")
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenBreakOutPower(entity, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "23")
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenRoleDamaged(entity, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "4")
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenRoleUseSKill(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    for _, v in ipairs(component._buffList) do
      local cbufflinkskillRecord
      local cbufflinkskillRecord = BattleECS.Utility.DataUtility.cBuffLinkSkillCfgTable[v.buffId]
      if cbufflinkskillRecord then
        local record = string.split(cbufflinkskillRecord.conditionid, ";")
        for _, value in ipairs(record) do
          if value == "3" and v.buffObj:IsTriggerCDOver() then
            table.insert(skillList, {
              skillid = tonumber(cbufflinkskillRecord.skillid),
              buff = v.buffObj,
              skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)
            })
          end
        end
      end
    end
  end
  return skillList
end

function BuffUtility.IsHasDebuff(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      local bufftype = BuffUtility.GetBuffType(v.buffObj:GetBuffID())
      if bufftype == 3 or bufftype == 5 then
        return true
      end
    end
  end
  return false
end

function BuffUtility.IsHasShieldbuff(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      local buffClassName = v.buffObj:GetBuffClassName()
      if buffClassName == "shieldbuff" then
        return true
      end
    end
  end
  return false
end

function BuffUtility.IsEntityHasTheClassNameBuff(entity, className)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local count = 0
  if component then
    for _, v in ipairs(component._buffList) do
      if v.buffObj:GetBuffClassName() == className then
        count = count + 1
      end
    end
  end
  return count
end

function BuffUtility.IsHasTriggerBuffWhenRoleDamagedMoreEqualNumber(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    for _, v in ipairs(component._buffList) do
      local cbufflinkskillRecord
      local cbufflinkskillRecord = BattleECS.Utility.DataUtility.cBuffLinkSkillCfgTable[v.buffId]
      if cbufflinkskillRecord then
        local record = string.split(cbufflinkskillRecord.conditionid, ";")
        for _, value in ipairs(record) do
          if value == "6" and v.buffObj:IsTriggerCDOver() then
            table.insert(skillList, {
              skillid = tonumber(cbufflinkskillRecord.skillid),
              buff = v.buffObj,
              skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)
            })
          end
        end
      end
    end
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenRoleAttackHit(entity, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "2")
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenRoleAttackHeal(entity, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "17")
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenRoleCrit(entity, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "21")
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenRoleUseSkillHit(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    for _, v in ipairs(component._buffList) do
      local cbufflinkskillRecord
      local cbufflinkskillRecord = BattleECS.Utility.DataUtility.cBuffLinkSkillCfgTable[v.buffId]
      if cbufflinkskillRecord then
        local record = string.split(cbufflinkskillRecord.conditionid, ";")
        for _, value in ipairs(record) do
          if value == "13" and v.buffObj:IsTriggerCDOver() then
            table.insert(skillList, {
              skillid = tonumber(cbufflinkskillRecord.skillid),
              buff = v.buffObj,
              skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)
            })
          end
        end
      end
    end
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenRoleUseSkillHeal(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    for _, v in ipairs(component._buffList) do
      local cbufflinkskillRecord
      local cbufflinkskillRecord = BattleECS.Utility.DataUtility.cBuffLinkSkillCfgTable[v.buffId]
      if cbufflinkskillRecord then
        local record = string.split(cbufflinkskillRecord.conditionid, ";")
        for _, value in ipairs(record) do
          if value == "18" and v.buffObj:IsTriggerCDOver() then
            table.insert(skillList, {
              skillid = tonumber(cbufflinkskillRecord.skillid),
              buff = v.buffObj,
              skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)
            })
          end
        end
      end
    end
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenRoleAttackToEnermyDead(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    for _, v in ipairs(component._buffList) do
      local cbufflinkskillRecord
      local cbufflinkskillRecord = BattleECS.Utility.DataUtility.cBuffLinkSkillCfgTable[v.buffId]
      if cbufflinkskillRecord then
        local record = string.split(cbufflinkskillRecord.conditionid, ";")
        for _, value in ipairs(record) do
          if value == "7" and v.buffObj:IsTriggerCDOver() then
            local effectTime = v.buffObj:GetLinkSkillEffectTime()
            local totalEffectTime = v.buffObj:GetLinkSkillEffectTotalTime()
            local triggerLinkSkillFlag = true
            if totalEffectTime and effectTime >= totalEffectTime then
              triggerLinkSkillFlag = false
            end
            if triggerLinkSkillFlag then
              v.buffObj:SetLinkSkillEffectTime(effectTime + 1)
              table.insert(skillList, {
                skillid = tonumber(cbufflinkskillRecord.skillid),
                skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)
              })
            end
          end
        end
      end
    end
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenCDComeToZero(entity, randomFunc, buffId)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "5", buffId)
  end
  return skillList
end

function BuffUtility.IsHasTriggerBuffWhenEntityHasBeenHittedByLimitSkillBuff(entity, randomFunc)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "19")
  end
  return skillList
end

function BuffUtility.IsHasTriggerWhenBuffIsCancelled(entity, buffId, randomFunc)
  local skillList = {}
  local cbufflinkskillRecord = BattleECS.Utility.DataUtility.cBuffLinkSkillCfgTable[buffId]
  if cbufflinkskillRecord then
    local record = string.split(cbufflinkskillRecord.conditionid, ";")
    for _, value in ipairs(record) do
      if value == "20" then
        table.insert(skillList, {
          skillid = tonumber(cbufflinkskillRecord.skillid),
          skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)
        })
      end
    end
  end
  return skillList
end

function BuffUtility.IsHasBluePowerUsingChangeBuff(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      if v.buffId == 20057 then
        return true
      end
    end
  end
  return false
end

function BuffUtility.IsHasCanNotBeBlowedBuff(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  if component then
    for _, v in ipairs(component._buffList) do
      if v.buffId == 20116 then
        return true
      end
    end
  end
  return false
end

function BuffUtility.SetBuffListToOwnCampEntityBySkillID(entity, enermyEntity, skillid, battleWorld)
  local ourlist = BuffUtility.GetSKillBuffList(skillid)
  for _, v in ipairs(ourlist) do
    if tonumber(v.buffid) ~= 10006 and tonumber(v.buffid) ~= 20106 then
      BuffUtility.InsertEntityDifferentBuff({
        entity = entity,
        enermyentity = enermyEntity,
        buffid = tonumber(v.buffid),
        buffparamter = v.buffvalues,
        skillid = skillid,
        battleworld = battleWorld
      })
    end
  end
end

function BuffUtility.IsNormalOrSelectiveMonster(monsterid)
  local config = BattleECS.Utility.DataUtility.cMonsterCfgTable[monsterid]
  if config then
    return config.MonsterStyle == 3 or config.MonsterStyle == 2
  end
  return false
end

function BuffUtility.IsExceptNormalOrSelectiveMonster(monsterid)
  local config = BattleECS.Utility.DataUtility.cMonsterCfgTable[monsterid]
  if config then
    return config.MonsterStyle ~= 3 and config.MonsterStyle ~= 2
  end
  return false
end

function BuffUtility.GetBossBonusValueAll(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local value = 0
  if component then
    for _, v in ipairs(component._buffList) do
      value = value + v.buffObj:GetBUffBossBonusValue()
    end
  end
  if value > fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[120].attr) then
    value = fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[120].attr)
  end
  if value < fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[119].attr) then
    value = fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[119].attr)
  end
  return value
end

function BuffUtility.GetMonsterBonusValueAll(entity)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local value = 0
  if component then
    for _, v in ipairs(component._buffList) do
      value = value + v.buffObj:GetBUffMonsterBonusValue()
    end
  end
  if value > fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[120].attr) then
    value = fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[120].attr)
  end
  if value < fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[119].attr) then
    value = fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[119].attr)
  end
  return value
end

function BuffUtility.GetEntityElementAdditionDmg(battleWorld, entity, elemet)
  local component = entity:GetComponent(BattleECS.Components.BuffComponent)
  local elementNum = battleWorld:GetElementNumFromLeftLine(elemet)
  local result = fixedpoint_zero
  if component then
    for _, v in ipairs(component._buffList) do
      local value = v.buffObj:GetBuffElementypeValue()
      if value.elementype == elemet or elemet == 4 then
        if value.elementnum == fixedpoint_zero or elementNum >= value.elementnum then
          result = result + value.elementdmg
        elseif elemet == 4 and value.elementnum <= battleWorld:GetElementNumFromLeftLine(value.elementype) + 1 then
          result = result + value.elementdmg
        end
      end
    end
  end
  return result
end

function BuffUtility.SetBuffListToEnemyCampEntityBySkillID(entity, enermyEntity, skillid, battleWorld, rad)
  if not enermyEntity or not entity then
    LogErrorFormat("BuffUtility", "skillid %s enermyentity %s entity %s, buff add failed", skillid, enermyEntity, entity)
    return
  end
  local _, enemylist = BuffUtility.GetSKillBuffList(skillid)
  for _, v in ipairs(enemylist) do
    local defend = entity:GetComponent(BattleECS.Components.DefenseComponent)
    local attack = enermyEntity:GetComponent(BattleECS.Components.AttackComponent)
    if BuffUtility.GetBuffDamageType(tonumber(v.buffid)) == "PhysicalDamage" then
      local hitRate = attack._hitRate - defend._attackMiss - defend._physicalEvasion
      if hitRate < 0 then
        local random = battleWorld._randomPcg(0, 1)
        if random <= -hitRate then
          BattleECS.Utility.ProtocolUtility.SendDamageMissProtocol(entity._entityId, 4, battleWorld)
          BattleECS.Utility.BuffUtility.ClearYingXiBuff(enermyEntity, skillid)
          return
        end
      end
    elseif BuffUtility.GetBuffDamageType(tonumber(v.buffid)) == "MagicDamage" then
      local hitRate = attack._hitRate - defend._attackMiss - defend._magicEvasion
      if hitRate < 0 then
        local random = battleWorld._randomPcg(0, 1)
        if random <= -hitRate then
          BattleECS.Utility.ProtocolUtility.SendDamageMissProtocol(entity._entityId, 4, battleWorld)
          BattleECS.Utility.BuffUtility.ClearYingXiBuff(enermyEntity, skillid)
          return
        end
      end
    end
    BuffUtility.InsertEntityDifferentBuff({
      entity = entity,
      enermyentity = enermyEntity,
      buffid = tonumber(v.buffid),
      buffparamter = v.buffvalues,
      skillid = skillid,
      battleworld = battleWorld,
      rad = rad
    })
  end
end

function BuffUtility.IsDisposableDamageBuff(buffid)
  local record = BattleECS.Utility.DataUtility.cIBuffCfgTable[buffid]
  if record and string.find(record.classname, "Damage") then
    return true
  end
  return false
end

function BuffUtility.GetBuffDamageType(buffid)
  local record = BattleECS.Utility.DataUtility.cIBuffCfgTable[buffid]
  if record then
    return record.classname
  end
end

function BuffUtility.GetBuffLimiteType(buffid)
  local buffConfig = BattleECS.Utility.DataUtility.cBuffCfgTable[buffid]
  if buffConfig then
    return buffConfig.limitoperations
  end
  return 0
end

function BuffUtility.GetBuffChangeSKillID(entity, skillid, battleWorld)
  for _, v in ipairs(entity:GetComponent(BattleECS.Components.BuffComponent)._buffList) do
    local aSkillRecord = BattleECS.Utility.DataUtility.cSkillChangeTable[skillid]
    if aSkillRecord then
      local changeSkillId = aSkillRecord[tonumber(v.buffId)]
      if changeSkillId then
        local skillConfig = BattleECS.Utility.DataUtility.cSkillCostTable[changeSkillId]
        if skillConfig then
          local skillComponent = entity:GetComponent(BattleECS.Components.SkillComponent)
          local redCost = skillConfig.OrderCost
          local blueCost = skillConfig.ChaosCost
          BattleECS.Utility.Utility.SetEntitySkillComponentCostPower(entity, changeSkillId, redCost, blueCost)
          if skillConfig.pureCost ~= "" then
            local record = {}
            record.skillComponentB = skillComponent
            record.skillComponentA = skillComponent
            record.world = battleWorld
            record.formulaString = skillConfig.pureCost
            record.skillid = changeSkillId
            record.camp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
            redCost, blueCost = BattleECS.Utility.BuffUtility.NewAnalysisFormulaPowerCost(record)
            BattleECS.Utility.Utility.SetEntitySkillComponentCostPower(entity, changeSkillId, redCost, blueCost)
          end
        end
        return changeSkillId
      end
    end
  end
  return skillid
end

function BuffUtility.ResetPowerCostValue(entity)
  local buffComponent = entity:GetComponent(BattleECS.Components.BuffComponent)
  buffComponent._orderPowerCost = fixedpoint_zero
  buffComponent._chaosPowerCost = fixedpoint_zero
end

function BuffUtility.ClearYingXiBuff(entity, skillid)
  local isHas, buffobj = BattleECS.Utility.BuffUtility.IsHasYingXiContinueBuff(entity)
  if isHas and entity:GetComponent(BattleECS.Components.TypeComponent)._isImaged and BattleECS.Utility.Utility.IsAttackSkill(skillid) then
    local time = BattleECS.Utility.Utility.GetMonsterOrRoleMagicOrAttackEndFraps(entity, skillid)
    if buffobj:GetBuffTotalTime() > 999 then
      buffobj:SetBuffTotalTime(time + 1)
      buffobj:SetBuffContinuedTime(1)
    end
  end
end

function BuffUtility.GetSkinBuffChangeEffectId(curPrefabName, buffEffectId)
  local skinChangeRecorder = BattleECS.Utility.DataUtility.cSkinBuffEffectChangeTable[buffEffectId]
  if skinChangeRecorder then
    for index, shapeId in ipairs(skinChangeRecorder.shapeid) do
      local shapeRecorder = BattleECS.Utility.DataUtility.cNPCShapeTable[tonumber(shapeId)]
      if shapeRecorder and shapeRecorder.prefabName == curPrefabName then
        buffEffectId = tonumber(skinChangeRecorder.effectid[index])
        break
      end
    end
  end
  return buffEffectId
end

function BuffUtility.AddSkillSectionEndBuffParameter(entity, skillId)
  local buffComponent = entity:GetComponent(BattleECS.Components.BuffComponent)
  for _, inV in ipairs(buffComponent._skillsectionendbuffSnapShoot) do
    LogInfoFormat("BuffUtility", "buffid %s AddSkillSectionEndBuffParameter skillid %s", inV.buffId, skillId)
    for _, param in ipairs(inV.paParams) do
      inV.buffObj:NumbericalCalculation(param)
    end
    if buffComponent._skillsectionendbuffSkillId == 0 then
      buffComponent._skillsectionendbuffSkillId = skillId
      buffComponent._skillsectionendbuffSkillEffect = {}
      local ourlist, enemylist = BuffUtility.GetSKillBuffList(skillId)
      for _, v in ipairs(ourlist) do
        table.insert(buffComponent._skillsectionendbuffSkillEffect, {
          buffid = v.buffid,
          effect = false
        })
      end
      for _, v in ipairs(enemylist) do
        table.insert(buffComponent._skillsectionendbuffSkillEffect, {
          buffid = v.buffid,
          effect = false
        })
      end
    end
  end
  buffComponent._skillsectionendbuffSnapShoot = {}
end

function BuffUtility.SetSkillsectionendbuffSkillEffect(entity, buffid)
  local buffComponent = entity:GetComponent(BattleECS.Components.BuffComponent)
  if buffComponent then
    for _, v in ipairs(buffComponent._skillsectionendbuffSkillEffect) do
      if v.buffid == buffid then
        v.effect = true
        break
      end
    end
  end
end

function BuffUtility.ProcessFormulaString(buffid, skillid, formulaString)
  local splitIndex = string.find(formulaString, "=")
  if not splitIndex then
    LogErrorFormat("buffutility", "ProcessFormulaString buffid %s skillid %s formula has no [ = ]", buffid, skillid)
  end
  local returnValue = string.sub(formulaString, 1, splitIndex - 1)
  local formula = string.sub(formulaString, splitIndex + 1, string.len(formulaString))
  local cfgFormula = ""
  for _, v in ipairs(BattleECS.Utility.DataUtility.cSkillFormulaCfgTable) do
    if string.find(formula, "f." .. v.record.FormulaName) then
      cfgFormula = v.record.Formula .. "," .. v.record.BaseDamageFormula
      break
    end
  end
  local attrResult = {}
  for _, attrIdv in ipairs(BattleECS.Utility.DataUtility.soreCattr) do
    for _, v in ipairs(attrIdv) do
      if v.id ~= AttrTypeEnum.DEFEND then
        local attrname = v.record.attrname
        local attrnamea = attrname .. "a"
        local attrnameb = attrname .. "b"
        local id = v.record.id
        attrResult[attrnamea] = string.find(formula, attrnamea) or string.find(cfgFormula, attrnamea)
        attrResult[attrnameb] = string.find(formula, attrnameb) or string.find(cfgFormula, attrnameb)
        if v.id == AttrTypeEnum.ORDER_PWR or v.id == AttrTypeEnum.CHAOS_PWR or v.id == AttrTypeEnum.ORDER_COST_REDUCE or v.id == AttrTypeEnum.CHAOS_COST_REDUCE then
          attrResult[attrname] = string.find(formula, attrname) or string.find(cfgFormula, attrname)
        end
        if v.id == AttrTypeEnum.ORDER_COST or v.id == AttrTypeEnum.CHAOS_COST or v.id == AttrTypeEnum.DISPEL_BUFF_NUM then
          attrResult[attrname] = string.find(formula, attrname) or string.find(cfgFormula, attrname)
        end
      end
    end
  end
  for _, v in ipairs(FirstAttrTypeNameList) do
    local attrnamea = v .. "a"
    local attrnameb = v .. "b"
    attrResult[attrnamea] = string.find(formula, attrnamea) or string.find(cfgFormula, attrnamea)
    attrResult[attrnameb] = string.find(formula, attrnameb) or string.find(cfgFormula, attrnameb)
  end
  for _, v in ipairs(StaticAttrTypeNameList) do
    local attrnamea = v .. "a"
    local attrnameb = v .. "b"
    attrResult[attrnamea] = string.find(formula, attrnamea) or string.find(cfgFormula, attrnamea)
    attrResult[attrnameb] = string.find(formula, attrnameb) or string.find(cfgFormula, attrnameb)
  end
  for _, v in ipairs(OtherAttrTypeNameList) do
    attrResult[v] = string.find(formula, v) or string.find(cfgFormula, v)
  end
  return returnValue, formula, attrResult
end

function BuffUtility.NewAnalysisFormula(...)
  local args = {
    ...
  }
  local data = args[1]
  local returnValue = data.returnValue
  local formula = data.formula
  local attrResult = data.attrResult
  local buffid = data.buffid
  local originalBuffid = data.originalBuffid
  local skillid = data.skillid
  local entity = data.entity
  local enermyentity = data.enermyentity
  local battleworld = data.world
  local attackComponnetA = data.attackComponnetA
  local hpComponnetA = data.hpComponnetA
  local defenComponentA = data.defenComponentA
  local typeComponentA = data.typeComponentA
  local skillComponentA = data.skillComponentA
  local buffComponentA = data.buffComponentA
  local attackComponnetB = data.attackComponnetB
  local hpComponnetB = data.hpComponnetB
  local defenComponentB = data.defenComponentB
  local typeComponentB = data.typeComponentB
  local skillComponentB = data.skillComponentB
  local buffComponentB = data.buffComponentB
  local findAttrInFormula = false
  for _, v in ipairs(BattleECS.Utility.DataUtility.soreCattr[1]) do
    if v.id ~= AttrTypeEnum.DEFEND then
      local attrname = v.record.attrname
      local attrnamea = attrname .. "a"
      local attrnameb = attrname .. "b"
      local id = v.record.id
      if attrResult[attrnamea] or attrResult[attrnameb] then
        findAttrInFormula = true
        if id == 10 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = hpComponnetA._currentHp
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = hpComponnetB._currentHp
        elseif id == 20 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = hpComponnetA._maxHp
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = hpComponnetB._maxHp
        elseif id == 30 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._attack
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._attack
        elseif id == 60 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = defenComponentA._magicDefense
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = defenComponentB._magicDefense
        elseif id == 80 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = hpComponnetA._lastDamage
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = hpComponnetB._lastDamage
        elseif id == 90 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._attackDamageAddition
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._attackDamageAddition
        elseif id == 100 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = defenComponentA._attackDefenseAddition
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = defenComponentB._attackDefenseAddition
        elseif id == 110 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._magicDamageAddition
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._magicDamageAddition
        elseif id == 120 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = defenComponentA._magicDefenseAddition
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = defenComponentB._magicDefenseAddition
        elseif id == 130 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._attackCritRate
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._attackCritRate
        end
      end
    end
  end
  for _, v in ipairs(BattleECS.Utility.DataUtility.soreCattr[2]) do
    local attrname = v.record.attrname
    local attrnamea = attrname .. "a"
    local attrnameb = attrname .. "b"
    local id = v.record.id
    if attrResult[attrnamea] or attrResult[attrnameb] then
      findAttrInFormula = true
      if id == 190 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._attackSuckBlood
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._attackSuckBlood
      elseif id == 200 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._magicSuckBlood
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._magicSuckBlood
      elseif id == 210 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = defenComponentA._attackInjuryReduceNumber
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = defenComponentB._attackInjuryReduceNumber
      elseif id == 220 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = defenComponentA._magicInjuryReduceNumber
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = defenComponentB._magicInjuryReduceNumber
      elseif id == 230 then
        if attrResult[attrnamea] then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = hpComponnetA._totalDamage
          BattleECS.Utility.Utility.ClearEntityHpComponentTotalDamege(enermyentity)
        end
        if attrResult[attrnameb] then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = hpComponnetB._totalDamage
          BattleECS.Utility.Utility.ClearEntityHpComponentTotalDamege(entity)
        end
      elseif id == 250 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._attackDefBreak
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._attackDefBreak
      elseif id == 260 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._magicDefBreak
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._magicDefBreak
      elseif id == 270 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._attackCritDefense
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._attackCritDefense
      elseif id == 290 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._attackAddition
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._attackAddition
      end
    end
  end
  for _, v in ipairs(BattleECS.Utility.DataUtility.soreCattr[3]) do
    local attrname = v.record.attrname
    local attrnamea = attrname .. "a"
    local attrnameb = attrname .. "b"
    local id = v.record.id
    if attrResult[attrnamea] or attrResult[attrnameb] then
      findAttrInFormula = true
      if id == 300 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._magicAddition
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._magicAddition
      elseif id == 310 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._treatmentAddition
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._treatmentAddition
      elseif id == 350 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._skillDamageBonus
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._skillDamageBonus
      elseif id == 360 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._skillTreeteBonus
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._skillTreeteBonus
      elseif id == 370 then
        if hpComponnetA._skillListOnceDamage[skillid] then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = hpComponnetA._skillListOnceDamage[skillid]
          hpComponnetA._skillListOnceDamage[skillid] = 0
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = 0
        end
        if hpComponnetB._skillListOnceDamage[skillid] then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = hpComponnetB._skillListOnceDamage[skillid]
          hpComponnetB._skillListOnceDamage[skillid] = 0
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = 0
        end
      elseif id == 400 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = buffComponentA._dispelbuffnum
      elseif id == 410 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = typeComponentB._monsterType
      elseif id == 430 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = skillComponentA._comboNumber
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = skillComponentB._comboNumber
      elseif id == 450 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = skillComponentA._isHasPassiveSkillParamter
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = skillComponentB._isHasPassiveSkillParamter
      elseif id == 460 then
        if BattleECS.Utility.BuffUtility.IsHasDebuff(enermyentity) then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = 1
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = 0
        end
        if BattleECS.Utility.BuffUtility.IsHasDebuff(entity) then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = 1
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = 0
        end
      end
    end
  end
  for _, v in ipairs(BattleECS.Utility.DataUtility.soreCattr[4]) do
    local attrname = v.record.attrname
    local attrnamea = attrname .. "a"
    local attrnameb = attrname .. "b"
    local id = v.record.id
    if attrResult[attrnamea] or attrResult[attrnameb] then
      findAttrInFormula = true
      if id == 490 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = skillComponentA._bossComboNumber
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = skillComponentB._bossComboNumber
      elseif id == 500 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._attackCritLevel
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._attackCritLevel
      elseif id == 510 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._attackCritDegreeLevel
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._attackCritDegreeLevel
      elseif id == 750 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = typeComponentA._level
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = typeComponentB._level
      elseif id == 530 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = attackComponnetA._healingPower
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = attackComponnetB._healingPower
      elseif id == 830 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = defenComponentA._attackCritDegreeDefense
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = defenComponentB._attackCritDegreeDefense
      elseif id == 650 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = buffComponentA._attackTime
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = buffComponentB._attackTime
      elseif id == 1060 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = defenComponentA._damageReduce
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = defenComponentB._damageReduce
      elseif id == 1070 then
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = typeComponentA._runelv
        BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = typeComponentB._runelv
      elseif id == 740 then
        if BattleECS.Utility.BuffUtility.IsHasShieldbuff(enermyentity) then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = 1
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = 0
        end
        if BattleECS.Utility.BuffUtility.IsHasShieldbuff(entity) then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = 1
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = 0
        end
      end
    end
  end
  for _, v in ipairs(BattleECS.Utility.DataUtility.soreCattr[5]) do
    local attrname = v.record.attrname
    local id = v.record.id
    if attrResult[attrname] then
      findAttrInFormula = true
      if v.id == AttrTypeEnum.ORDER_PWR or v.id == AttrTypeEnum.CHAOS_PWR or v.id == AttrTypeEnum.ORDER_COST_REDUCE or v.id == AttrTypeEnum.CHAOS_COST_REDUCE then
        if id == 330 then
          if enermyentity:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Left then
            BattleECS.Utility.DataUtility.BattleFormulaVariables[attrname] = BattleECS.Utility.DataUtility.GetPowerGridFunc(battleworld._redPower, BattleECS.Utility.DataUtility.PowerType.Red)
          elseif enermyentity:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Right then
            BattleECS.Utility.DataUtility.BattleFormulaVariables[attrname] = 0
          end
        elseif id == 340 then
          if enermyentity:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Left then
            BattleECS.Utility.DataUtility.BattleFormulaVariables[attrname] = BattleECS.Utility.DataUtility.GetPowerGridFunc(battleworld._bluePower, BattleECS.Utility.DataUtility.PowerType.Blue)
          elseif enermyentity:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Right then
            BattleECS.Utility.DataUtility.BattleFormulaVariables[attrname] = 0
          end
        elseif id == 470 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrname] = skillComponentB._skillCostPowerReduceList.order
        elseif id == 480 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrname] = skillComponentB._skillCostPowerReduceList.chaos
        end
      end
      if v.id == AttrTypeEnum.ORDER_COST or v.id == AttrTypeEnum.CHAOS_COST then
        if id == 380 then
          if not (skillComponentA and skillComponentA._skillCostPowerList) or not skillComponentA._skillCostPowerList[skillid] then
            LogErrorFormat("BuffUtility", "attrname %s skillid %s entityid %s enermyentityid %s", attrname, skillid, entity._entityId, enermyentity._entityId)
          else
            BattleECS.Utility.DataUtility.BattleFormulaVariables[attrname] = skillComponentA._skillCostPowerList[skillid].red
          end
        elseif id == 390 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables[attrname] = skillComponentA._skillCostPowerList[skillid].blue
        end
      end
    end
  end
  for _, v in ipairs(BattleECS.Utility.DataUtility.soreCattr[#BattleECS.Utility.DataUtility.soreCattr]) do
    local attrname = v.record.attrname
    local attrnamea = attrname .. "a"
    local attrnameb = attrname .. "b"
    if attrResult[attrnamea] or attrResult[attrnameb] then
      findAttrInFormula = true
      BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnamea] = buffComponentA._buffnum[v.record.ablEffctName] or fixedpoint_zero
      BattleECS.Utility.DataUtility.BattleFormulaVariables[attrnameb] = buffComponentB._buffnum[v.record.ablEffctName] or fixedpoint_zero
    end
  end
  for _, v in ipairs(FirstAttrTypeNameList) do
    if attrResult[v .. "a"] then
      findAttrInFormula = true
      if v == "reduce" then
        if buffid == 10000 or buffid == 10016 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.reducea = defenComponentA._attackDefenseAddition
        elseif buffid == 10001 or buffid == 10017 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.reducea = defenComponentA._magicDefenseAddition
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables.reducea = defenComponentA._attackDefenseAddition
        end
      elseif v == "block" then
        if buffid == 10000 or buffid == 10016 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.blocka = defenComponentA._attackInjuryReduceNumber
        elseif buffid == 10001 or buffid == 10017 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.blocka = defenComponentA._magicInjuryReduceNumber
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables.blocka = defenComponentA._attackInjuryReduceNumber
        end
      elseif v == "defbreak" then
        if buffid == 10000 or buffid == 10016 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.defbreaka = attackComponnetA._attackDefBreak
        elseif buffid == 10001 or buffid == 10017 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.defbreaka = attackComponnetA._magicDefBreak
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables.defbreaka = attackComponnetA._attackDefBreak
        end
      elseif v == "extradmg" then
        if buffid == 10000 or buffid == 10016 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.extradmga = attackComponnetA._attackAddition
        elseif buffid == 10001 or buffid == 10017 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.extradmga = attackComponnetA._magicAddition
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables.extradmga = attackComponnetA._attackAddition
        end
      elseif v == "bonus" then
        if buffid == 10000 or buffid == 10002 or buffid == 10016 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.bonusa = attackComponnetA._attackDamageAddition
        elseif buffid == 10001 or buffid == 10003 or buffid == 10010 or buffid == 10017 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.bonusa = attackComponnetA._magicDamageAddition
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables.bonusa = attackComponnetA._attackDamageAddition
        end
      elseif v == "defend" then
        if buffid == 10000 or buffid == 10016 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.defenda = defenComponentA._attackDefense
        elseif buffid == 10001 or buffid == 10017 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.defenda = defenComponentA._magicDefense
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables.defenda = defenComponentA._attackDefense
        end
      end
    end
    if attrResult[v .. "b"] then
      findAttrInFormula = true
      if v == "reduce" then
        if buffid == 10000 or buffid == 10016 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.reduceb = defenComponentB._attackDefenseAddition
        elseif buffid == 10001 or buffid == 10017 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.reduceb = defenComponentB._magicDefenseAddition
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables.reduceb = defenComponentB._attackDefenseAddition
        end
      elseif v == "block" then
        if buffid == 10000 or buffid == 10016 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.blockb = defenComponentB._attackInjuryReduceNumber
        elseif buffid == 10001 or buffid == 10017 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.blockb = defenComponentB._magicInjuryReduceNumber
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables.blockb = defenComponentB._attackInjuryReduceNumber
        end
      elseif v == "defbreak" then
        if buffid == 10000 or buffid == 10016 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.defbreakb = attackComponnetB._attackDefBreak
        elseif buffid == 10001 or buffid == 10017 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.defbreakb = attackComponnetB._magicDefBreak
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables.defbreakb = attackComponnetB._attackDefBreak
        end
      elseif v == "extradmg" then
        if buffid == 10000 or buffid == 10016 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.extradmgb = attackComponnetB._attackAddition
        elseif buffid == 10001 or buffid == 10017 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.extradmgb = attackComponnetB._magicAddition
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables.extradmgb = attackComponnetB._attackAddition
        end
      elseif v == "bonus" then
        if buffid == 10000 or buffid == 10002 or buffid == 10016 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.bonusb = attackComponnetB._attackDamageAddition
        elseif buffid == 10001 or buffid == 10003 or buffid == 10010 or buffid == 10017 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.bonusb = attackComponnetB._magicDamageAddition
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables.bonusb = attackComponnetB._attackDamageAddition
        end
      elseif v == "defend" then
        if buffid == 10000 or buffid == 10016 then
          if BattleECS.Utility.BuffUtility.IsHasCurrentBuff(enermyentity, 20067) then
            BattleECS.Utility.DataUtility.BattleFormulaVariables.defendb = defenComponentB._attackDefense * 8 // 10
          else
            BattleECS.Utility.DataUtility.BattleFormulaVariables.defendb = defenComponentB._attackDefense
          end
        elseif buffid == 10001 or buffid == 10017 then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.defendb = defenComponentB._magicDefense
        else
          BattleECS.Utility.DataUtility.BattleFormulaVariables.defendb = defenComponentB._attackDefense
        end
      end
    end
  end
  for _, v in ipairs(StaticAttrTypeNameList) do
    if attrResult[v .. "a"] then
      findAttrInFormula = true
      if v == "staticmaxhp" then
        BattleECS.Utility.DataUtility.BattleFormulaVariables.staticmaxhpa = hpComponnetA._basicMaxHp
      elseif v == "staticattack" then
        BattleECS.Utility.DataUtility.BattleFormulaVariables.staticattacka = attackComponnetA._basicAttack
      elseif v == "staticdefend" then
        BattleECS.Utility.DataUtility.BattleFormulaVariables.staticdefenda = defenComponentA._basicAttackDefense
      elseif v == "staticmagicdef" then
        BattleECS.Utility.DataUtility.BattleFormulaVariables.staticmagicdefa = defenComponentA._basicMagicDefense
      elseif v == "staticcritrate" then
        BattleECS.Utility.DataUtility.BattleFormulaVariables.staticcritratea = attackComponnetA._basicAttackCritRate
      elseif v == "staticcritdegree" then
        BattleECS.Utility.DataUtility.BattleFormulaVariables.staticcritdegreea = attackComponnetA._basicAttackCritDegree
      end
    end
    if attrResult[v .. "b"] then
      findAttrInFormula = true
      if v == "staticmaxhp" then
        BattleECS.Utility.DataUtility.BattleFormulaVariables.staticmaxhpb = hpComponnetB._basicMaxHp
      elseif v == "staticattack" then
        BattleECS.Utility.DataUtility.BattleFormulaVariables.staticattackb = attackComponnetB._basicAttack
      elseif v == "staticdefend" then
        BattleECS.Utility.DataUtility.BattleFormulaVariables.staticdefendb = defenComponentB._basicAttackDefense
      elseif v == "staticmagicdef" then
        BattleECS.Utility.DataUtility.BattleFormulaVariables.staticmagicdefb = defenComponentB._basicMagicDefense
      elseif v == "staticcritrate" then
        BattleECS.Utility.DataUtility.BattleFormulaVariables.staticcritrateb = attackComponnetB._basicAttackCritRate
      elseif v == "staticcritdegree" then
        BattleECS.Utility.DataUtility.BattleFormulaVariables.staticcritdegreeb = attackComponnetB._basicAttackCritDegree
      end
    end
  end
  for _, v in ipairs(OtherAttrTypeNameList) do
    if attrResult[v] then
      findAttrInFormula = true
      if v == "atktimes" then
        for _, e in ipairs(battleworld._entitys) do
          local skillEffectComponent = e:GetComponent(BattleECS.Components.SkillEffectComponent)
          if skillEffectComponent and skillEffectComponent._skillID == skillid and skillEffectComponent._useSkillEntityID == enermyentity._entityId then
            BattleECS.Utility.DataUtility.BattleFormulaVariables.atktimes = skillEffectComponent._typeMineEffectAtkEffectTime
            break
          end
        end
      elseif v == "atknums" then
        local skillComponent = enermyentity:GetComponent(BattleECS.Components.SkillComponent)
        if skillComponent then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.atknums = skillComponent._hittedEntityNumber
        end
      elseif v == "continualbuffatktimes" then
        for _, v in ipairs(buffComponentB._buffList) do
          if v.buffId == originalBuffid then
            BattleECS.Utility.DataUtility.BattleFormulaVariables.continualbuffatktimes = v.buffObj:GetBuffTimeCellEffectTimes()
          end
        end
      elseif v == "evolution" then
        local TypeComponent = enermyentity:GetComponent(BattleECS.Components.TypeComponent)
        if TypeComponent then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.evolution = TypeComponent._evolutionLevel
        end
      elseif v == "exclusivelv" then
        local TypeComponent = enermyentity:GetComponent(BattleECS.Components.TypeComponent)
        if TypeComponent then
          BattleECS.Utility.DataUtility.BattleFormulaVariables.exclusivelv = TypeComponent._exclusiveLevel
        end
      end
    end
  end
  local funcResult = fixedpoint_zero
  local baseDamageResult, friendFunc
  if BattleECS.Utility.DataUtility.CSkillFriendBuffValuesFunc[skillid] and BattleECS.Utility.DataUtility.CSkillFriendBuffValuesFunc[skillid][originalBuffid] then
    friendFunc = BattleECS.Utility.DataUtility.CSkillFriendBuffValuesFunc[skillid][originalBuffid][returnValue]
  end
  local enemyFunc
  if BattleECS.Utility.DataUtility.CSkillEnemyBuffValuesFunc[skillid] and BattleECS.Utility.DataUtility.CSkillEnemyBuffValuesFunc[skillid][originalBuffid] then
    enemyFunc = BattleECS.Utility.DataUtility.CSkillEnemyBuffValuesFunc[skillid][originalBuffid][returnValue]
  end
  local RelationType = {Friend = 1, Enemy = 2}
  local relation = RelationType.Friend
  if entity:GetComponent(BattleECS.Components.TypeComponent)._camp ~= enermyentity:GetComponent(BattleECS.Components.TypeComponent)._camp then
    relation = RelationType.Enemy
  end
  if relation == RelationType.Friend and friendFunc then
    funcResult, baseDamageResult = friendFunc()
  elseif relation == RelationType.Enemy and enemyFunc then
    funcResult, baseDamageResult = enemyFunc()
  elseif not findAttrInFormula then
    funcResult = fixedpoint(formula)
  else
    LogErrorFormat("BuffUtility", "function loading failed skillid %s originalBuffid %s buffValue %s", skillid, originalBuffid, formula)
  end
  if not fixedpoint.judgetype(funcResult) then
    funcResult = fixedpoint(funcResult)
  end
  if baseDamageResult and not fixedpoint.judgetype(baseDamageResult) then
    baseDamageResult = fixedpoint(baseDamageResult)
  end
  return funcResult, returnValue, baseDamageResult
end

function BuffUtility.NewAnalysisFormulaPowerCost(...)
  local args = {
    ...
  }
  local data = args[1]
  local formulaString = data.formulaString
  local skillid = data.skillid
  local battleworld = data.world
  local skillComponentA = data.skillComponentA
  local skillComponentB = data.skillComponentB
  local formula = formulaString
  for _, v in ipairs(BattleECS.Utility.DataUtility.soreCattr[5]) do
    local attrname = v.record.attrname
    local id = v.record.id
    local i = 0
    if v.id == AttrTypeEnum.ORDER_PWR or v.id == AttrTypeEnum.CHAOS_PWR or v.id == AttrTypeEnum.ORDER_COST_REDUCE or v.id == AttrTypeEnum.CHAOS_COST_REDUCE then
      i = 0
      while true do
        i = string.find(formula, attrname, i + 1)
        if i == nil then
          break
        end
        if id == 330 then
          if data.camp == BattleECS.Components.TypeComponent.CampType.Left then
            BattleECS.Utility.DataUtility.SkillCostFormulaVariables[attrname] = BattleECS.Utility.DataUtility.GetPowerGridFunc(battleworld._redPower, BattleECS.Utility.DataUtility.PowerType.Red)
          elseif data.camp == BattleECS.Components.TypeComponent.CampType.Right then
            BattleECS.Utility.DataUtility.SkillCostFormulaVariables[attrname] = 0
          end
        elseif id == 340 then
          if data.camp == BattleECS.Components.TypeComponent.CampType.Left then
            BattleECS.Utility.DataUtility.SkillCostFormulaVariables[attrname] = BattleECS.Utility.DataUtility.GetPowerGridFunc(battleworld._bluePower, BattleECS.Utility.DataUtility.PowerType.Blue)
          elseif data.camp == BattleECS.Components.TypeComponent.CampType.Right then
            BattleECS.Utility.DataUtility.SkillCostFormulaVariables[attrname] = 0
          end
        elseif id == 470 then
          BattleECS.Utility.DataUtility.SkillCostFormulaVariables[attrname] = skillComponentB._skillCostPowerReduceList.order
        elseif id == 480 then
          BattleECS.Utility.DataUtility.SkillCostFormulaVariables[attrname] = skillComponentB._skillCostPowerReduceList.chaos
        end
      end
    end
    if v.id == AttrTypeEnum.ORDER_COST or v.id == AttrTypeEnum.CHAOS_COST then
      i = 0
      while true do
        i = string.find(formula, attrname, i + 1)
        if i == nil then
          break
        end
        if id == 380 then
          BattleECS.Utility.DataUtility.SkillCostFormulaVariables[attrname] = skillComponentA._skillCostPowerList[skillid].red
        elseif id == 390 then
          BattleECS.Utility.DataUtility.SkillCostFormulaVariables[attrname] = skillComponentA._skillCostPowerList[skillid].blue
        end
      end
    end
  end
  local redResult, blueResult = fixedpoint_zero, fixedpoint_zero
  local redFunc, blueFunc
  if BattleECS.Utility.DataUtility.CSkillCostCfgFunc[skillid] and BattleECS.Utility.DataUtility.CSkillCostCfgFunc[skillid][BattleECS.Utility.DataUtility.PowerType.Red] then
    redFunc = BattleECS.Utility.DataUtility.CSkillCostCfgFunc[skillid][BattleECS.Utility.DataUtility.PowerType.Red]
  end
  if redFunc then
    redResult = redFunc()
  else
    LogErrorFormat("BuffUtility", "function loading failed skillid %s powertype %s formula %s, table is ccostskill", skillid, BattleECS.Utility.DataUtility.PowerType.Red, formula)
  end
  if not fixedpoint.judgetype(redResult) then
    redResult = fixedpoint(redResult)
  end
  if BattleECS.Utility.DataUtility.CSkillCostCfgFunc[skillid] and BattleECS.Utility.DataUtility.CSkillCostCfgFunc[skillid][BattleECS.Utility.DataUtility.PowerType.Blue] then
    blueFunc = BattleECS.Utility.DataUtility.CSkillCostCfgFunc[skillid][BattleECS.Utility.DataUtility.PowerType.Blue]
  end
  if blueFunc then
    blueResult = blueFunc()
  else
    LogErrorFormat("BuffUtility", "function loading failed skillid %s powertype %s formula %s, table is ccostskill", skillid, BattleECS.Utility.DataUtility.PowerType.Blue, formula)
  end
  if not fixedpoint.judgetype(blueResult) then
    blueResult = fixedpoint(blueResult)
  end
  return redResult, blueResult
end

function BuffUtility.CanAddGlobalBuffBuff(entity, buffId, battleWorld)
  local record = BattleECS.Utility.DataUtility.cGlobalBuffConfigTable[buffId]
  if record then
    if record.limit == "" then
      return true
    end
    local limits = string.split(record.limit, ";")
    for _, v in ipairs(limits) do
      local limitNum = tonumber(v)
      if 1001 <= limitNum and limitNum < 1008 then
        limitNum = limitNum % 1000
        local typeComponent = entity:GetComponent(BattleECS.Components.TypeComponent)
        if typeComponent and typeComponent._roleVocationType == limitNum then
          return true
        end
      elseif 2001 <= limitNum and limitNum < 2008 then
        local vocation = limitNum % 2000
        if battleWorld:GetVocationNumFromLeftLine(vocation) > 0 then
          return true
        end
      elseif 3001 <= limitNum and limitNum < 3004 then
        local limitNum = limitNum % 3000
        local typeComponent = entity:GetComponent(BattleECS.Components.TypeComponent)
        if typeComponent and typeComponent._roleElementType == limitNum or typeComponent._roleElementType == 4 then
          return true
        end
      end
    end
  end
end

return BuffUtility
