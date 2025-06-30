-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/utility/buffutility.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BuffUtility = {}
local AttrTypeEnum = (BattleClientProtocolManager.GetBeanDef)("data.attrtype")
local FirstAttrTypeNameList = {"defend", "bonus", "reduce", "block", "defbreak", "extradmg"}
local StaticAttrTypeNameList = {"staticmaxhp", "staticattack", "staticdefend", "staticmagicdef", "staticcritrate", "staticcritdegree"}
local OtherAttrTypeNameList = {"atktimes", "atknums", "continualbuffatktimes", "evolution", "exclusivelv"}
BuffUtility.InsertEntityDifferentBuff = function(...)
  -- function num : 0_0 , upvalues : _ENV, BuffUtility
  local args = {...}
  local data = args[1]
  local buffid = data.buffid
  local enermyentity = data.enermyentity
  local bComponent = enermyentity:GetComponent((BattleECS.Components).BuffComponent)
  local record = (((BattleECS.Utility).DataUtility).cBuffCfgTable)[buffid]
  if record then
    if record.delayFrame == 0 then
      (BuffUtility.CreateBuffObject)(data)
    else
      if record.redelay == 0 then
        (table.insert)(bComponent._delayBuffList, {data = data, delayFrame = record.delayFrame, actualFrame = 0})
      else
        if record.redelay == 1 then
          local dontHasBuff = true
          for _,v in ipairs(bComponent._delayBuffList) do
            if (v.data).buffid == data.buffid then
              v.actualFrame = 0
              dontHasBuff = false
              break
            end
          end
          do
            do
              if dontHasBuff then
                (table.insert)(bComponent._delayBuffList, {data = data, delayFrame = record.delayFrame, actualFrame = 0})
              end
              LogErrorFormat("Buff", "buffid %s wrong ccbuffconfig.redelay %s", data.buffid, record.redelay)
              ;
              (BuffUtility.CreateBuffObject)(data)
            end
          end
        end
      end
    end
  end
end

BuffUtility.CreateBuffObject = function(data)
  -- function num : 0_1 , upvalues : _ENV, BuffUtility
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
  local TypeComponent = (BattleECS.Components).TypeComponent
  local entityTypeCom = entity:GetComponent(TypeComponent)
  local enemyEntityTypeCom = enermyEntity:GetComponent(TypeComponent)
  if battleWorld._guardBuffLeftEntityid ~= 0 or battleWorld._guardBuffRightEntityid ~= 0 then
    local camp = entityTypeCom._camp
    local friendHasGuardBuffEntity = nil
    if camp == (TypeComponent.CampType).Left then
      friendHasGuardBuffEntity = nil
      for i,e in ipairs(battleWorld._entitys) do
        if e._entityId == battleWorld._guardBuffLeftEntityid then
          friendHasGuardBuffEntity = e
          break
        end
      end
    else
      do
        if camp == (TypeComponent.CampType).Right then
          friendHasGuardBuffEntity = nil
          for i,e in ipairs(battleWorld._entitys) do
            if e._entityId == battleWorld._guardBuffRightEntityid then
              friendHasGuardBuffEntity = e
              break
            end
          end
        end
        do
          do
            if friendHasGuardBuffEntity and not (((BattleECS.Utility).Utility).IsRoleDead)(friendHasGuardBuffEntity) and (BuffUtility.IsDisposableDamageBuff)(buffid) then
              entity = friendHasGuardBuffEntity
            end
            if not (((BattleECS.Utility).Utility).IsRoleDead)(entity) or (((BattleECS.Utility).Utility).IsRoleDead)(entity) and buffid == 10006 then
              local component = entity:GetComponent((BattleECS.Components).BuffComponent)
              if component then
                local isHas = (BuffUtility.IsHasCurrentBuff)(entity, buffid)
                if not isHas then
                  do
                    if entityTypeCom and enemyEntityTypeCom and entityTypeCom._camp ~= enemyEntityTypeCom._camp and buffid ~= 20000 and (((BattleECS.Utility).BuffUtility).GetBuffLimiteType)(buffid) & 2 ~= 0 then
                      local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenEntityHasBeenHittedByLimitSkillBuff)(entity, battleWorld._randomPcg)
                      for _,v in ipairs(skillList) do
                        (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(entity, v, entity)
                      end
                      if #skillList ~= 0 then
                        LogInfoFormat("BuffUtility", "buff id %s 未加上; 因为 entityid %s 含有连携类型为19的buff", buffid, entity._entityId)
                        return 
                      end
                    end
                    if (BuffUtility.IsHasCanNotJoinBuff)(entity, buffid) then
                      LogInfoFormat("BuffUtility", "entityid %s buffid免疫:%s", entity._entityId, buffid)
                      local DamageType = {DontShowMiss = 7}
                      local buffCom = entity:GetComponent((BattleECS.Components).BuffComponent)
                      local hasDontShowMissBuff = false
                      for _,v in ipairs(buffCom._buffList) do
                        if v.buffId == 20099 and (entity:GetComponent((BattleECS.Components).TypeComponent))._roleID == 13 then
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
                      do
                        do
                          if hasDontShowMissBuff then
                            (((BattleECS.Utility).ProtocolUtility).SendDamageMissProtocol)(entity._entityId, DamageType.DontShowMiss, battleWorld)
                          else
                            ;
                            (((BattleECS.Utility).ProtocolUtility).SendDamageMissProtocol)(entity._entityId, 5, battleWorld)
                          end
                          ;
                          (((BattleECS.Utility).BuffUtility).ClearYingXiBuff)(enermyEntity, skillid)
                          if (BuffUtility.ChangeBuffEffectCount)(entity, buffid) then
                            (((BattleECS.Utility).ProtocolUtility).SendDamageMissProtocol)(entity._entityId, 4, battleWorld)
                            ;
                            (((BattleECS.Utility).BuffUtility).ClearYingXiBuff)(enermyEntity, skillid)
                          else
                            local buffObject = (((BattleECS.Buff).Buff).Create)({buffid = buffid, buffparamter = buffParamter, entity = entity, enermyentity = enermyEntity, skillid = skillid, battleworld = battleWorld, rad = rad, damagetransformparamter = damagetransformparamter, isplayattackedeffect = isPlayAttackedEffect, isconnect = isconnect, originalBuffId = originalBuffId, fixedpointAttrValue = fixedpointAttrValue})
                            local alwaysHaveThisBuff = false
                            for i,v in ipairs(component._buffList) do
                              -- DECOMPILER ERROR at PC288: Confused about usage of register: R25 in 'UnsetPending'

                              if v.buffId == buffid then
                                ((component._buffList)[i]).buffObj = buffObject
                                alwaysHaveThisBuff = true
                                break
                              end
                            end
                            do
                              if not alwaysHaveThisBuff then
                                (table.insert)(component._buffList, {buffId = buffid, buffObj = buffObject})
                              end
                              buffObject:SetBuffContinuedTime(0)
                              local mutexList = ((BuffUtility.GetBuffMutexByGroup)(buffid))
                              do
                                local deleteBuffNum = nil
                                if buffid == 10013 then
                                  deleteBuffNum = 0
                                end
                                for _,v in ipairs(mutexList) do
                                  local cancelBuffList = (BuffUtility.RemoveEntityBuffByBuffType)(entity, v)
                                  for _,bId in ipairs(cancelBuffList) do
                                    local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerWhenBuffIsCancelled)(entity, bId, battleWorld._randomPcg)
                                    for _,sId in ipairs(skillList) do
                                      (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(entity, sId, entity)
                                    end
                                  end
                                  if deleteBuffNum then
                                    deleteBuffNum = deleteBuffNum + 1
                                  end
                                end
                                mutexList = (BuffUtility.GetBuffMuteByBuffid)(buffid)
                                for _,v in ipairs(mutexList) do
                                  local cancelBuffList = (BuffUtility.RemoveEntityBuff)(entity, v)
                                  for _,bId in ipairs(cancelBuffList) do
                                    local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerWhenBuffIsCancelled)(entity, bId, battleWorld._randomPcg)
                                    for _,sId in ipairs(skillList) do
                                      (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(entity, sId, entity)
                                    end
                                  end
                                  if deleteBuffNum then
                                    deleteBuffNum = deleteBuffNum + 1
                                  end
                                end
                                if deleteBuffNum then
                                  (enermyEntity:GetComponent((BattleECS.Components).BuffComponent))._dispelbuffnum = deleteBuffNum
                                end
                                local buffObject = nil
                                for _,v in ipairs(component._buffList) do
                                  if v.buffId == buffid then
                                    buffObject = v.buffObj
                                    break
                                  end
                                end
                                do
                                  local OverRideType = {Cover = 0, RespectivelyShow = 1, Overlay = 2, OverlayWithoutRefreshTime = 3}
                                  local buffOverRideType = (BuffUtility.GetBuffOverRideType)(buffid)
                                  if not (((BattleECS.Utility).DataUtility).cIBuffCfgTable)[buffid] and buffOverRideType == OverRideType.Cover then
                                    buffObject:ClearBuffAdditionalAttribute()
                                  end
                                  buffObject:SetEnermyEntity(enermyEntity)
                                  buffObject:SetSkillid(skillid)
                                  buffObject:SetOriginalBuffId(originalBuffId or buffid)
                                  buffObject:SetBuffParam(buffParamter)
                                  if (((BattleECS.Utility).DataUtility).cIBuffCfgTable)[buffid] then
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
                                    if (buffOverRideType == OverRideType.Overlay or buffOverRideType == OverRideType.OverlayWithoutRefreshTime) and buffObject:GetStackTimes() > 1 then
                                      buffObject:SetStackTimes(buffObject:GetStackTimes() - 1)
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

BuffUtility.GetSpecialRoundBuffTargetEntityList = function(entity, battleWorld, rankType, rankNum)
  -- function num : 0_2 , upvalues : _ENV
  local camp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
  local list = {}
  if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
    for _,v in ipairs(battleWorld._leftPlayerList) do
      if not (((BattleECS.Utility).Utility).IsRoleDead)(v) then
        (table.insert)(list, v)
      end
    end
    for _,v in ipairs(battleWorld._leftPlayerSummonList) do
      if not (((BattleECS.Utility).Utility).IsRoleDead)(v) then
        (table.insert)(list, v)
      end
    end
  else
    do
      if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
        for _,v in ipairs(battleWorld._rightPlayerList) do
          if not (((BattleECS.Utility).Utility).IsRoleDead)(v) then
            (table.insert)(list, v)
          end
        end
        for _,v in ipairs(battleWorld._rightPlayerSummonList) do
          if not (((BattleECS.Utility).Utility).IsRoleDead)(v) then
            (table.insert)(list, v)
          end
        end
      end
      do
        if (table.nums)(list) > 1 then
          if rankType == 1 then
            (table.sort)(list, function(a, b)
    -- function num : 0_2_0 , upvalues : _ENV
    do return (a:GetComponent((BattleECS.Components).HpComponent))._currentHp < (b:GetComponent((BattleECS.Components).HpComponent))._currentHp end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
          else
            if rankType == 2 then
              (table.sort)(list, function(a, b)
    -- function num : 0_2_1 , upvalues : _ENV
    do return (b:GetComponent((BattleECS.Components).HpComponent))._currentHp < (a:GetComponent((BattleECS.Components).HpComponent))._currentHp end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
            else
              if rankType == 3 then
                (table.sort)(list, function(a, b)
    -- function num : 0_2_2 , upvalues : _ENV
    if ((b:GetComponent((BattleECS.Components).PositionComponent))._position).x >= ((a:GetComponent((BattleECS.Components).PositionComponent))._position).x then
      do return (a:GetComponent((BattleECS.Components).TypeComponent))._camp ~= (((BattleECS.Components).TypeComponent).CampType).Left end
      do return ((a:GetComponent((BattleECS.Components).PositionComponent))._position).x < ((b:GetComponent((BattleECS.Components).PositionComponent))._position).x end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
              else
                if rankType == 4 then
                  (table.sort)(list, function(a, b)
    -- function num : 0_2_3 , upvalues : _ENV
    if ((a:GetComponent((BattleECS.Components).PositionComponent))._position).x >= ((b:GetComponent((BattleECS.Components).PositionComponent))._position).x then
      do return (a:GetComponent((BattleECS.Components).TypeComponent))._camp ~= (((BattleECS.Components).TypeComponent).CampType).Left end
      do return ((b:GetComponent((BattleECS.Components).PositionComponent))._position).x < ((a:GetComponent((BattleECS.Components).PositionComponent))._position).x end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
                else
                  if rankType == 5 then
                    local long = (table.nums)(list) + 1
                    local random = (battleWorld._randomPcg)(1, long)
                    while list[random] and rankNum < (table.nums)(list) do
                      (table.remove)(list, random)
                      random = (battleWorld._randomPcg)(1, long)
                    end
                  else
                    do
                      if rankType == 6 then
                        list = {}
                        ;
                        (table.insert)(list, entity)
                      else
                        if rankType == 8 then
                          (table.sort)(list, function(a, b)
    -- function num : 0_2_4 , upvalues : _ENV
    do return (a:GetComponent((BattleECS.Components).HpComponent))._currentHp / (a:GetComponent((BattleECS.Components).HpComponent))._maxHp < (b:GetComponent((BattleECS.Components).HpComponent))._currentHp / (b:GetComponent((BattleECS.Components).HpComponent))._maxHp end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
                        else
                          if rankType == 9 then
                            (table.sort)(list, function(a, b)
    -- function num : 0_2_5 , upvalues : _ENV
    do return (b:GetComponent((BattleECS.Components).HpComponent))._currentHp / (b:GetComponent((BattleECS.Components).HpComponent))._maxHp < (a:GetComponent((BattleECS.Components).HpComponent))._currentHp / (a:GetComponent((BattleECS.Components).HpComponent))._maxHp end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
                          end
                        end
                      end
                      if rankType ~= 5 then
                        local removeList = {}
                        for k = #list, 1, -1 do
                          if rankNum < k then
                            (table.insert)(removeList, k)
                          end
                        end
                        for _,k in ipairs(removeList) do
                          (table.remove)(list, k)
                        end
                      end
                      do
                        return list
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

BuffUtility.RemoveEntityBuffByBuffType = function(entity, buffType)
  -- function num : 0_3 , upvalues : _ENV, BuffUtility
  local buffList = {}
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = (component._buffList)[i]
      if v and buffType == (BuffUtility.GetBuffType)(v.buffId) then
        (table.insert)(buffList, v.buffId)
        ;
        (table.insert)(removeBuffIdList, v.buffId)
      end
    end
    for i = #component._buffList, 1, -1 do
      local v = (component._buffList)[i]
      if v and buffType == (BuffUtility.GetBuffType)(v.buffId) then
        (v.buffObj):Destroy()
      end
    end
    local removeList = {}
    for _,removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = (component._buffList)[i]
        if v.buffId == removingBuffId then
          (table.insert)(removeList, i)
        end
      end
    end
    for _,i in ipairs(removeList) do
      (table.remove)(component._buffList, i)
    end
  end
  do
    return buffList
  end
end

BuffUtility.RemoveEntityBuff = function(entity, buffid)
  -- function num : 0_4 , upvalues : _ENV
  local buffList = {}
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = (component._buffList)[i]
      if v and v.buffId == buffid then
        (table.insert)(buffList, v.buffId)
        ;
        (table.insert)(removeBuffIdList, v.buffId)
      end
    end
    for i = #component._buffList, 1, -1 do
      local v = (component._buffList)[i]
      if v and v.buffId == buffid then
        (v.buffObj):Destroy()
      end
    end
    local removeList = {}
    for _,removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = (component._buffList)[i]
        if v.buffId == removingBuffId then
          (table.insert)(removeList, i)
        end
      end
    end
    for _,i in ipairs(removeList) do
      (table.remove)(component._buffList, i)
    end
  end
  do
    return buffList
  end
end

BuffUtility.RemoveEntityBuffBySkillID = function(entity, skillid)
  -- function num : 0_5 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = (component._buffList)[i]
      if v and (v.buffObj):GetBuffSkillID() == skillid and (v.buffObj):GetBuffClassName() and (v.buffObj):GetBuffClassName() == "areabuff" then
        (table.insert)(removeBuffIdList, v.buffId)
      end
    end
    for i = #component._buffList, 1, -1 do
      local v = (component._buffList)[i]
      if v and (v.buffObj):GetBuffSkillID() == skillid and (v.buffObj):GetBuffIsDamagedTriggerContinue() then
        (v.buffObj):SetBuffTotalTime(1)
        ;
        (v.buffObj):SetBuffContinuedTime(1)
      end
      if v and (v.buffObj):GetBuffSkillID() == skillid and (v.buffObj):GetBuffClassName() and (v.buffObj):GetBuffClassName() == "areabuff" then
        (v.buffObj):Destroy()
      end
    end
    local removeList = {}
    for _,removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = (component._buffList)[i]
        if v.buffId == removingBuffId then
          (table.insert)(removeList, i)
        end
      end
    end
    for _,i in ipairs(removeList) do
      (table.remove)(component._buffList, i)
    end
  end
end

BuffUtility.ChangeBuffEffectCount = function(entity, buffid)
  -- function num : 0_6 , upvalues : _ENV, BuffUtility
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      if (v.buffObj):GetBuffEffectCountTotal() and (v.buffObj):GetBuffEffectCount() < (v.buffObj):GetBuffEffectCountTotal() and (BuffUtility.IsCancelBecauseEffectCount)(v.buffObj, buffid) then
        (v.buffObj):SetBuffEffectCount((v.buffObj):GetBuffEffectCount() + 1)
        return true
      end
    end
  end
  do
    return false
  end
end

BuffUtility.IsEntityHasBreakBuff = function(entity)
  -- function num : 0_7 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      if (v.buffObj):GetBuffClassName() and (v.buffObj):GetBuffClassName() == "breakbuff" then
        return true
      end
    end
  end
  do
    return false
  end
end

BuffUtility.IsCancelBecauseEffectCount = function(buffObject, inserbuffid)
  -- function num : 0_8 , upvalues : _ENV
  local bufflist = buffObject:GetEffectBuffList()
  for _,v in ipairs(bufflist) do
    if v == inserbuffid then
      return true
    end
  end
  return false
end

BuffUtility.ClearEntityBuffList = function(entity)
  -- function num : 0_9 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = (component._buffList)[i]
      if v and v.buffId ~= 20000 then
        (v.buffObj):Destroy()
        ;
        (table.insert)(removeBuffIdList, v.buffId)
      end
    end
    local removeList = {}
    for _,removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = (component._buffList)[i]
        if v.buffId == removingBuffId then
          (table.insert)(removeList, i)
        end
      end
    end
    for _,i in ipairs(removeList) do
      (table.remove)(component._buffList, i)
    end
    component._delayBuffList = {}
  end
end

BuffUtility.IsHasYingXiContinueBuff = function(entity)
  -- function num : 0_10 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      if v.buffId == 20045 or v.buffId == 20151 or v.buffId == 20152 or v.buffId == 20153 or v.buffId == 20154 then
        return true, v.buffObj
      end
    end
  end
  do
    return false
  end
end

BuffUtility.ClearDeadEntityBuff = function(entity)
  -- function num : 0_11 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = (component._buffList)[i]
      if v and v.buffId ~= 20000 and v.buffId ~= 20168 then
        local buffConfig = (((BattleECS.Utility).DataUtility).cBuffCfgTable)[v.buffId]
        if buffConfig then
          if buffConfig.removeType == 0 or buffConfig.removeType == 1 then
            (v.buffObj):Destroy()
            ;
            (table.insert)(removeBuffIdList, v.buffId)
          else
            if buffConfig.removeType == 6 then
              (v.buffObj):SetBuffIsEffect(false)
            end
          end
        else
          ;
          (v.buffObj):Destroy()
          ;
          (table.insert)(removeBuffIdList, v.buffId)
        end
      end
    end
    local removeList = {}
    for _,removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = (component._buffList)[i]
        if v.buffId == removingBuffId then
          (table.insert)(removeList, i)
        end
      end
    end
    for _,i in ipairs(removeList) do
      (table.remove)(component._buffList, i)
    end
    component._delayBuffList = {}
  end
end

BuffUtility.RevivePlayerBuffState = function(entity)
  -- function num : 0_12 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      local buffConfig = (((BattleECS.Utility).DataUtility).cBuffCfgTable)[v.buffId]
      if buffConfig and buffConfig.removeType == 6 then
        (v.buffObj):SetBuffIsEffect(true)
      end
    end
  end
end

BuffUtility.ClearBattleEndEntityBuff = function(entity)
  -- function num : 0_13 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = (component._buffList)[i]
      local buffConfig = (((BattleECS.Utility).DataUtility).cBuffCfgTable)[v.buffId]
      -- DECOMPILER ERROR at PC36: Unhandled construct in 'MakeBoolean' P1

      if v and v.buffId ~= 20000 and buffConfig and (buffConfig.removeType == 0 or buffConfig.removeType == 1) then
        (v.buffObj):Destroy()
        ;
        (table.insert)(removeBuffIdList, v.buffId)
      end
      ;
      (v.buffObj):Destroy()
      ;
      (table.insert)(removeBuffIdList, v.buffId)
    end
    local removeList = {}
    for _,removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = (component._buffList)[i]
        if v.buffId == removingBuffId then
          (table.insert)(removeList, i)
        end
      end
    end
    for _,i in ipairs(removeList) do
      (table.remove)(component._buffList, i)
    end
    component._delayBuffList = {}
  end
end

BuffUtility.RemoveBuffWithClassName = function(entity, className)
  -- function num : 0_14 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    local removeBuffIdList = {}
    for i = #component._buffList, 1, -1 do
      local v = (component._buffList)[i]
      if v and (v.buffObj):GetBuffClassName() and (v.buffObj):GetBuffClassName() == className then
        (v.buffObj):Destroy()
        ;
        (table.insert)(removeBuffIdList, v.buffId)
      end
    end
    local removeList = {}
    for _,removingBuffId in ipairs(removeBuffIdList) do
      for i = #component._buffList, 1, -1 do
        local v = (component._buffList)[i]
        if v.buffId == removingBuffId then
          (table.insert)(removeList, i)
        end
      end
    end
    for _,i in ipairs(removeList) do
      (table.remove)(component._buffList, i)
    end
  end
end

BuffUtility.SetEntityBuffEffectState = function(entity, buffid, isEffect)
  -- function num : 0_15 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      if v.buffId == buffid then
        (v.buffObj):SetBuffIsEffect(isEffect)
      end
    end
  end
end

BuffUtility.GetEntityBuffEffectState = function(entity, buffid)
  -- function num : 0_16 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      if v.buffId == buffid then
        return (v.buffObj):GetBuffIsEffect()
      end
    end
  end
  do
    return false
  end
end

BuffUtility.IsCanBeChosenInDifferentCampSkill = function(entity)
  -- function num : 0_17 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      local temp = (v.buffObj):GetBuffInfluenceEntityIsCanBeChosenBySkillState()
      if temp == 1 or temp == 3 then
        return false
      end
    end
  end
  do
    return true
  end
end

BuffUtility.IsCanBeChosenInSameCampSkill = function(entity)
  -- function num : 0_18 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      local temp = (v.buffObj):GetBuffInfluenceEntityIsCanBeChosenBySkillState()
      if temp == 2 or temp == 3 then
        return false
      end
    end
  end
  do
    return true
  end
end

BuffUtility.GetBuffType = function(buffid)
  -- function num : 0_19 , upvalues : _ENV
  local buffConfig = (((BattleECS.Utility).DataUtility).cBuffCfgTable)[buffid]
  if buffConfig then
    return buffConfig.buffType
  end
  return -1
end

BuffUtility.GetBuffOverRideType = function(buffid)
  -- function num : 0_20 , upvalues : _ENV
  local buffConfig = (((BattleECS.Utility).DataUtility).cBuffCfgTable)[buffid]
  if buffConfig then
    return buffConfig.overrideSelfType
  end
end

BuffUtility.IsHasCanNotJoinBuff = function(entity, buffid)
  -- function num : 0_21 , upvalues : _ENV, BuffUtility
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      local buffType = (BuffUtility.GetBuffType)(v.buffId)
      local buffConfig = (((BattleECS.Utility).DataUtility).cBuffConficsTable)[buffType]
      if buffConfig then
        local buffidstrlist = (string.split)(buffConfig.immunebuff, ";")
        local bufftypestrlisyt = (string.split)(buffConfig.immunebuffGroud, ";")
        for _,value in ipairs(buffidstrlist) do
          if tonumber(buffid) == tonumber(value) then
            return true
          end
        end
        for _,value in ipairs(bufftypestrlisyt) do
          if tonumber((BuffUtility.GetBuffType)(tonumber(buffid))) == tonumber(value) then
            return true
          end
        end
      end
      do
        buffConfig = (((BattleECS.Utility).DataUtility).cBuffConficsTable)[v.buffId]
        if buffConfig then
          local buffidstrlist = (string.split)(buffConfig.immunebuff, ";")
          local bufftypestrlisyt = (string.split)(buffConfig.immunebuffGroud, ";")
          for _,value in ipairs(buffidstrlist) do
            if tonumber(buffid) == tonumber(value) then
              return true
            end
          end
          for _,value in ipairs(bufftypestrlisyt) do
            if tonumber((BuffUtility.GetBuffType)(tonumber(buffid))) == tonumber(value) then
              return true
            end
          end
        end
        do
          -- DECOMPILER ERROR at PC121: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  return false
end

BuffUtility.GetBuffMutexByGroup = function(buffid)
  -- function num : 0_22 , upvalues : BuffUtility, _ENV
  local buffType = (BuffUtility.GetBuffType)(buffid)
  local buffConfig = (((BattleECS.Utility).DataUtility).cBuffConficsTable)[buffType]
  local list = {}
  if buffConfig then
    for _,v in ipairs((string.split)(buffConfig.cancelbuffGroud, ";")) do
      (table.insert)(list, tonumber(v))
    end
  end
  do
    buffConfig = (((BattleECS.Utility).DataUtility).cBuffConficsTable)[buffid]
    if buffConfig then
      for _,v in ipairs((string.split)(buffConfig.cancelbuffGroud, ";")) do
        (table.insert)(list, tonumber(v))
      end
    end
    do
      return list
    end
  end
end

BuffUtility.GetBuffMuteByBuffid = function(buffid)
  -- function num : 0_23 , upvalues : BuffUtility, _ENV
  local buffType = (BuffUtility.GetBuffType)(buffid)
  local buffConfig = (((BattleECS.Utility).DataUtility).cBuffConficsTable)[buffType]
  local list = {}
  if buffConfig then
    for _,v in ipairs((string.split)(buffConfig.cancelbuff, ";")) do
      (table.insert)(list, tonumber(v))
    end
  end
  do
    buffConfig = (((BattleECS.Utility).DataUtility).cBuffConficsTable)[buffid]
    if buffConfig then
      for _,v in ipairs((string.split)(buffConfig.cancelbuff, ";")) do
        (table.insert)(list, tonumber(v))
      end
    end
    do
      return list
    end
  end
end

BuffUtility.IsRoleHasCanNotUseSkillBuff = function(entity, effecttype, skillid)
  -- function num : 0_24 , upvalues : _ENV
  local EffectType = {AttackSkill = 1, UseSkill = 2, Both = 3}
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      local buffConfig = (((BattleECS.Utility).DataUtility).cBuffCfgTable)[v.buffId]
      if buffConfig then
        local limit = buffConfig.limitoperations
        if limit == 3 or limit == 7 then
          return true
        else
          if limit == 1 then
            if skillid then
              local skillConfig = (((BattleECS.Utility).DataUtility).cskillTable)[skillid]
              if skillConfig and skillConfig.effecttype == 1 then
                return true
              end
            else
              do
                if effecttype == EffectType.AttackSkill or effecttype == EffectType.Both then
                  return true
                end
                if limit == 2 then
                  if skillid then
                    local skillConfig = (((BattleECS.Utility).DataUtility).cskillTable)[skillid]
                    if skillConfig and skillConfig.effecttype == 2 then
                      return true
                    end
                  else
                    do
                      if effecttype == EffectType.UseSkill or effecttype == EffectType.Both then
                        return true
                      end
                      do
                        local VisibleType = {GreySkillCell = 4}
                        if buffConfig.hideOptions and buffConfig.hideOptions & VisibleType.GreySkillCell ~= 0 then
                          return true
                        end
                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return false
end

BuffUtility.IsRoleHasCanNotAttackSkillBuff = function(entity)
  -- function num : 0_25 , upvalues : _ENV, BuffUtility
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      if (BuffUtility.GetBuffLimiteType)(v.buffId) == 7 then
        return true
      end
    end
  end
  do
    return false
  end
end

BuffUtility.IsRoleHasCanNotActiveMoveBuff = function(entity)
  -- function num : 0_26 , upvalues : _ENV, BuffUtility
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      if (BuffUtility.GetBuffLimiteType)(v.buffId) == 7 then
        return true
      end
    end
  end
  do
    return false
  end
end

BuffUtility.IsRoleHasInterruptedSKillBuff = function(entity, skillid)
  -- function num : 0_27 , upvalues : _ENV, BuffUtility
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      -- DECOMPILER ERROR at PC38: Unhandled construct in 'MakeBoolean' P1

      if (((BattleECS.Utility).Utility).IsAttackSkill)(skillid) and ((BuffUtility.GetBuffLimiteType)(v.buffId) == 1 or (BuffUtility.GetBuffLimiteType)(v.buffId) == 3 or (BuffUtility.GetBuffLimiteType)(v.buffId) == 7 or v.buffId == 10004) then
        return true
      end
      if (((BattleECS.Utility).Utility).IsUseSkill)(skillid) and ((BuffUtility.GetBuffLimiteType)(v.buffId) == 2 or (BuffUtility.GetBuffLimiteType)(v.buffId) == 3 or (BuffUtility.GetBuffLimiteType)(v.buffId) == 7 or v.buffId == 10004) then
        return true
      end
    end
  end
  do
    return false
  end
end

BuffUtility.IsHasCurrentBuff = function(entity, buffid)
  -- function num : 0_28 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      if v.buffId == buffid then
        return true, v.buffObj
      end
    end
  end
  do
    return false
  end
end

BuffUtility.GetSKillBuffList = function(skillid)
  -- function num : 0_29 , upvalues : _ENV
  if (((BattleECS.Utility).DataUtility).CSkillFriendBuffValueTable)[skillid] or not (((BattleECS.Utility).DataUtility).CSkillEnemyBuffValueTable)[skillid] then
    return {}, {}
  end
end

BuffUtility.IsSkillHasReviveBuff = function(skillid)
  -- function num : 0_30 , upvalues : BuffUtility, _ENV
  local ourlist = (BuffUtility.GetSKillBuffList)(skillid)
  for _,v in ipairs(ourlist) do
    if v.buffid == 10006 then
      return true
    else
      if v.buffid == 20168 then
        return true
      end
    end
  end
  return false
end

BuffUtility.IsSkillHasPowerChangeOnceBuff = function(skillid)
  -- function num : 0_31 , upvalues : BuffUtility, _ENV
  local ourlist = (BuffUtility.GetSKillBuffList)(skillid)
  for _,v in ipairs(ourlist) do
    if v.buffid == 10011 then
      return true, v
    end
  end
  return false
end

BuffUtility.GetSkillOverFlowTreatmentBuffInfo = function(skillid)
  -- function num : 0_32 , upvalues : _ENV
  local skillConfig = (((BattleECS.Utility).DataUtility).cskillTable)[skillid]
  local info = nil
  if (((BattleECS.Utility).DataUtility).CSkillFriendBuffValueTable)[skillid] then
    for _,v in ipairs((((BattleECS.Utility).DataUtility).CSkillFriendBuffValueTable)[skillid]) do
      if v.buffid == 20106 then
        info = {}
        info.buffid = v.buffid
        info.buffparamater = v.buffvalues
      end
    end
  end
  do
    return info
  end
end

BuffUtility.IsSkillHasInterreptBuff = function(skillid)
  -- function num : 0_33 , upvalues : BuffUtility, _ENV
  local ourlist = (BuffUtility.GetSKillBuffList)(skillid)
  for _,v in ipairs(ourlist) do
    if v.buffid == 10004 then
      return true
    end
  end
  return false
end

local IsHasTriggerFunction = function(buffList, randomFunc, buffLinkType, buffId)
  -- function num : 0_34 , upvalues : _ENV
  local skillList = {}
  for _,v in ipairs(buffList) do
    if buffId ~= nil and v.buffId ~= buffId then
      local cbufflinkskillRecord = nil
      local cbufflinkskillRecord = (((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable)[v.buffId]
      if cbufflinkskillRecord then
        local record = (string.split)(cbufflinkskillRecord.conditionid, ";")
        for _,value in ipairs(record) do
          if value == buffLinkType and (v.buffObj):IsTriggerCDOver() then
            local random = randomFunc(1, 100)
            local rate = (v.buffObj):GetBUffTriggerRate()
            local effectTime = (v.buffObj):GetLinkSkillEffectTime()
            local totalEffectTime = (v.buffObj):GetLinkSkillEffectTotalTime()
            local triggerLinkSkillFlag = random <= rate
            if totalEffectTime and totalEffectTime <= effectTime then
              triggerLinkSkillFlag = false
            end
            if triggerLinkSkillFlag then
              (v.buffObj):SetLinkSkillEffectTime(effectTime + 1)
              ;
              (v.buffObj):ResetTriggerCDCountTime()
              ;
              (table.insert)(skillList, {skillid = tonumber(cbufflinkskillRecord.skillid), buff = v.buffObj, skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)})
            end
          end
        end
      end
      -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
  do return skillList end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

BuffUtility.IsHasTriggerBuffWhenRoleDead = function(entity, randomFunc)
  -- function num : 0_35 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    local buffList = {}
    for _,v in ipairs(component._buffList) do
      (table.insert)(buffList, {buffId = v.buffId, buffObj = v.buffObj})
    end
    ;
    (table.sort)(buffList, function(a, b)
    -- function num : 0_35_0
    do return (a.buffObj):GetBuffContinuedTime() < (b.buffObj):GetBuffContinuedTime() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    for k,v in ipairs(buffList) do
      local cbufflinkskillRecord = (((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable)[v.buffId]
      if cbufflinkskillRecord then
        local record = (string.split)(cbufflinkskillRecord.conditionid, ";")
        for _,value in ipairs(record) do
          if value == "1" and (v.buffObj):IsTriggerCDOver() then
            local random = randomFunc(1, 100)
            local rate = (v.buffObj):GetBUffTriggerRate()
            local effectTime = (v.buffObj):GetLinkSkillEffectTime()
            local totalEffectTime = (v.buffObj):GetLinkSkillEffectTotalTime()
            local triggerLinkSkillFlag = random <= rate
            if totalEffectTime and totalEffectTime <= effectTime then
              triggerLinkSkillFlag = false
            end
            if triggerLinkSkillFlag then
              (v.buffObj):SetLinkSkillEffectTime(effectTime + 1)
              ;
              (v.buffObj):ResetTriggerCDCountTime()
              ;
              (table.insert)(skillList, {skillid = tonumber(cbufflinkskillRecord.skillid), skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)})
            end
          end
        end
      end
    end
  end
  do return skillList end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

BuffUtility.IsHasTriggerBuffWhenShieldNumberChangeZeroAndSameToBuffID = function(entity, buffid, randomFunc)
  -- function num : 0_36 , upvalues : _ENV, IsHasTriggerFunction
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  do
    if component then
      local buffList = {}
      for _,v in ipairs(component._buffList) do
        if v.buffId == buffid then
          (table.insert)(buffList, {buffId = v.buffId, buffObj = v.buffObj})
        end
      end
      return IsHasTriggerFunction(buffList, randomFunc, "16")
    end
    return skillList
  end
end

BuffUtility.IsHasTriggerBuffWhenShieldBuffEnd = function(entity, buffid, randomFunc)
  -- function num : 0_37 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillOnEntityList = {}
  local skillOnEnemyEntityList = {}
  if component then
    local buffList = {}
    for _,v in ipairs(component._buffList) do
      if v.buffId == buffid then
        (table.insert)(buffList, {buffId = v.buffId, buffObj = v.buffObj})
      end
    end
    local cbufflinkskillRecord, record, random, rate, effectTime, totalEffectTime, triggerLinkSkillFlag, divideSkillId, divideSkillGroupId = nil, nil, nil, nil, nil, nil, nil, nil, nil
    for _,v in ipairs(buffList) do
      cbufflinkskillRecord = (((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable)[v.buffId]
      if cbufflinkskillRecord then
        record = (string.split)(cbufflinkskillRecord.conditionid, ";")
        for _,value in ipairs(record) do
          if value == "22" and (v.buffObj):IsTriggerCDOver() then
            random = randomFunc(1, 100)
            rate = (v.buffObj):GetBUffTriggerRate()
            effectTime = (v.buffObj):GetLinkSkillEffectTime()
            totalEffectTime = (v.buffObj):GetLinkSkillEffectTotalTime()
            triggerLinkSkillFlag = random <= rate
            if totalEffectTime and totalEffectTime <= effectTime then
              triggerLinkSkillFlag = false
            end
            if triggerLinkSkillFlag then
              (v.buffObj):SetLinkSkillEffectTime(effectTime + 1)
              ;
              (v.buffObj):ResetTriggerCDCountTime()
              divideSkillId = (string.split)(cbufflinkskillRecord.skillid, ",")
              divideSkillGroupId = (string.split)(cbufflinkskillRecord.skillgroupid, ",")
              if #divideSkillId > 1 then
                (table.insert)(skillOnEnemyEntityList, {skillid = tonumber(divideSkillId[1]), buff = v.buffObj, skillgroupid = nil})
                ;
                (table.insert)(skillOnEntityList, {skillid = tonumber(divideSkillId[2]), buff = v.buffObj, skillgroupid = nil})
              elseif #divideSkillGroupId > 1 then
                (table.insert)(skillOnEnemyEntityList, {skillid = nil, buff = v.buffObj, skillgroupid = tonumber(divideSkillGroupId[1])})
                ;
                (table.insert)(skillOnEntityList, {skillid = nil, buff = v.buffObj, skillgroupid = tonumber(divideSkillGroupId[2])})
              end
            end
          end
        end
      end
    end
  end
  do return skillOnEnemyEntityList, skillOnEntityList end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

BuffUtility.IsHasTriggerBuffWhenRoleKillEnermy = function(entity)
  -- function num : 0_38 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    for _,v in ipairs(component._buffList) do
      local cbufflinkskillRecord = nil
      local cbufflinkskillRecord = (((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable)[v.buffId]
      if cbufflinkskillRecord then
        local record = (string.split)(cbufflinkskillRecord.conditionid, ";")
        for _,value in ipairs(record) do
          if value == "12" and (v.buffObj):IsTriggerCDOver() then
            (table.insert)(skillList, {skillid = tonumber(cbufflinkskillRecord.skillid), buff = v.buffObj, skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)})
          end
        end
      end
    end
  end
  do
    return skillList
  end
end

BuffUtility.IsHasTriggerBuffWhenParnterUseSkillCostPower = function(entity, randomFunc)
  -- function num : 0_39 , upvalues : _ENV, IsHasTriggerFunction
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "15")
  end
  return skillList
end

BuffUtility.IsHasTriggerBuffWhenPartnerDead = function(entity, randomFunc)
  -- function num : 0_40 , upvalues : _ENV, IsHasTriggerFunction
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "14")
  end
  return skillList
end

BuffUtility.IsHasTriggerBuffWhenRoleTreateRemoveDebuff = function(entity, randomFunc)
  -- function num : 0_41 , upvalues : _ENV, IsHasTriggerFunction
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "11")
  end
  return skillList
end

BuffUtility.IsHasTriggerBuffWhenRoleDamagedToDead = function(entity, randomFunc)
  -- function num : 0_42 , upvalues : _ENV, IsHasTriggerFunction
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "8")
  end
  return skillList
end

BuffUtility.IsHasTriggerBuffWhenBreakOutPower = function(entity, randomFunc)
  -- function num : 0_43 , upvalues : _ENV, IsHasTriggerFunction
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "23")
  end
  return skillList
end

BuffUtility.IsHasTriggerBuffWhenRoleDamaged = function(entity, randomFunc)
  -- function num : 0_44 , upvalues : _ENV, IsHasTriggerFunction
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "4")
  end
  return skillList
end

BuffUtility.IsHasTriggerBuffWhenRoleUseSKill = function(entity)
  -- function num : 0_45 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    for _,v in ipairs(component._buffList) do
      local cbufflinkskillRecord = nil
      local cbufflinkskillRecord = (((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable)[v.buffId]
      if cbufflinkskillRecord then
        local record = (string.split)(cbufflinkskillRecord.conditionid, ";")
        for _,value in ipairs(record) do
          if value == "3" and (v.buffObj):IsTriggerCDOver() then
            (table.insert)(skillList, {skillid = tonumber(cbufflinkskillRecord.skillid), buff = v.buffObj, skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)})
          end
        end
      end
    end
  end
  do
    return skillList
  end
end

BuffUtility.IsHasDebuff = function(entity)
  -- function num : 0_46 , upvalues : _ENV, BuffUtility
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      local bufftype = (BuffUtility.GetBuffType)((v.buffObj):GetBuffID())
      if bufftype == 3 or bufftype == 5 then
        return true
      end
    end
  end
  do
    return false
  end
end

BuffUtility.IsHasShieldbuff = function(entity)
  -- function num : 0_47 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      local buffClassName = (v.buffObj):GetBuffClassName()
      if buffClassName == "shieldbuff" then
        return true
      end
    end
  end
  do
    return false
  end
end

BuffUtility.IsEntityHasTheClassNameBuff = function(entity, className)
  -- function num : 0_48 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local count = 0
  if component then
    for _,v in ipairs(component._buffList) do
      if (v.buffObj):GetBuffClassName() == className then
        count = count + 1
      end
    end
  end
  do
    return count
  end
end

BuffUtility.IsHasTriggerBuffWhenRoleDamagedMoreEqualNumber = function(entity)
  -- function num : 0_49 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    for _,v in ipairs(component._buffList) do
      local cbufflinkskillRecord = nil
      local cbufflinkskillRecord = (((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable)[v.buffId]
      if cbufflinkskillRecord then
        local record = (string.split)(cbufflinkskillRecord.conditionid, ";")
        for _,value in ipairs(record) do
          if value == "6" and (v.buffObj):IsTriggerCDOver() then
            (table.insert)(skillList, {skillid = tonumber(cbufflinkskillRecord.skillid), buff = v.buffObj, skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)})
          end
        end
      end
    end
  end
  do
    return skillList
  end
end

BuffUtility.IsHasTriggerBuffWhenRoleAttackHit = function(entity, randomFunc)
  -- function num : 0_50 , upvalues : _ENV, IsHasTriggerFunction
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "2")
  end
  return skillList
end

BuffUtility.IsHasTriggerBuffWhenRoleAttackHeal = function(entity, randomFunc)
  -- function num : 0_51 , upvalues : _ENV, IsHasTriggerFunction
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "17")
  end
  return skillList
end

BuffUtility.IsHasTriggerBuffWhenRoleCrit = function(entity, randomFunc)
  -- function num : 0_52 , upvalues : _ENV, IsHasTriggerFunction
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "21")
  end
  return skillList
end

BuffUtility.IsHasTriggerBuffWhenRoleUseSkillHit = function(entity)
  -- function num : 0_53 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    for _,v in ipairs(component._buffList) do
      local cbufflinkskillRecord = nil
      local cbufflinkskillRecord = (((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable)[v.buffId]
      if cbufflinkskillRecord then
        local record = (string.split)(cbufflinkskillRecord.conditionid, ";")
        for _,value in ipairs(record) do
          if value == "13" and (v.buffObj):IsTriggerCDOver() then
            (table.insert)(skillList, {skillid = tonumber(cbufflinkskillRecord.skillid), buff = v.buffObj, skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)})
          end
        end
      end
    end
  end
  do
    return skillList
  end
end

BuffUtility.IsHasTriggerBuffWhenRoleUseSkillHeal = function(entity)
  -- function num : 0_54 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    for _,v in ipairs(component._buffList) do
      local cbufflinkskillRecord = nil
      local cbufflinkskillRecord = (((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable)[v.buffId]
      if cbufflinkskillRecord then
        local record = (string.split)(cbufflinkskillRecord.conditionid, ";")
        for _,value in ipairs(record) do
          if value == "18" and (v.buffObj):IsTriggerCDOver() then
            (table.insert)(skillList, {skillid = tonumber(cbufflinkskillRecord.skillid), buff = v.buffObj, skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)})
          end
        end
      end
    end
  end
  do
    return skillList
  end
end

BuffUtility.IsHasTriggerBuffWhenRoleAttackToEnermyDead = function(entity)
  -- function num : 0_55 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    for _,v in ipairs(component._buffList) do
      local cbufflinkskillRecord = nil
      local cbufflinkskillRecord = (((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable)[v.buffId]
      if cbufflinkskillRecord then
        local record = (string.split)(cbufflinkskillRecord.conditionid, ";")
        for _,value in ipairs(record) do
          if value == "7" and (v.buffObj):IsTriggerCDOver() then
            local effectTime = (v.buffObj):GetLinkSkillEffectTime()
            local totalEffectTime = (v.buffObj):GetLinkSkillEffectTotalTime()
            local triggerLinkSkillFlag = true
            if totalEffectTime and totalEffectTime <= effectTime then
              triggerLinkSkillFlag = false
            end
            if triggerLinkSkillFlag then
              (v.buffObj):SetLinkSkillEffectTime(effectTime + 1)
              ;
              (table.insert)(skillList, {skillid = tonumber(cbufflinkskillRecord.skillid), skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)})
            end
          end
        end
      end
    end
  end
  do
    return skillList
  end
end

BuffUtility.IsHasTriggerBuffWhenCDComeToZero = function(entity, randomFunc, buffId)
  -- function num : 0_56 , upvalues : _ENV, IsHasTriggerFunction
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "5", buffId)
  end
  return skillList
end

BuffUtility.IsHasTriggerBuffWhenEntityHasBeenHittedByLimitSkillBuff = function(entity, randomFunc)
  -- function num : 0_57 , upvalues : _ENV, IsHasTriggerFunction
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local skillList = {}
  if component then
    return IsHasTriggerFunction(component._buffList, randomFunc, "19")
  end
  return skillList
end

BuffUtility.IsHasTriggerWhenBuffIsCancelled = function(entity, buffId, randomFunc)
  -- function num : 0_58 , upvalues : _ENV
  local skillList = {}
  local cbufflinkskillRecord = (((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable)[buffId]
  if cbufflinkskillRecord then
    local record = (string.split)(cbufflinkskillRecord.conditionid, ";")
    for _,value in ipairs(record) do
      if value == "20" then
        (table.insert)(skillList, {skillid = tonumber(cbufflinkskillRecord.skillid), skillgroupid = tonumber(cbufflinkskillRecord.skillgroupid)})
      end
    end
  end
  do
    return skillList
  end
end

BuffUtility.IsHasBluePowerUsingChangeBuff = function(entity)
  -- function num : 0_59 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      if v.buffId == 20057 then
        return true
      end
    end
  end
  do
    return false
  end
end

BuffUtility.IsHasCanNotBeBlowedBuff = function(entity)
  -- function num : 0_60 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  if component then
    for _,v in ipairs(component._buffList) do
      if v.buffId == 20116 then
        return true
      end
    end
  end
  do
    return false
  end
end

BuffUtility.SetBuffListToOwnCampEntityBySkillID = function(entity, enermyEntity, skillid, battleWorld)
  -- function num : 0_61 , upvalues : BuffUtility, _ENV
  local ourlist = (BuffUtility.GetSKillBuffList)(skillid)
  for _,v in ipairs(ourlist) do
    if tonumber(v.buffid) ~= 10006 and tonumber(v.buffid) ~= 20106 then
      (BuffUtility.InsertEntityDifferentBuff)({entity = entity, enermyentity = enermyEntity, buffid = tonumber(v.buffid), buffparamter = v.buffvalues, skillid = skillid, battleworld = battleWorld})
    end
  end
end

BuffUtility.IsNormalOrSelectiveMonster = function(monsterid)
  -- function num : 0_62 , upvalues : _ENV
  local config = (((BattleECS.Utility).DataUtility).cMonsterCfgTable)[monsterid]
  if config.MonsterStyle ~= 3 and config.MonsterStyle ~= 2 then
    do return not config end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BuffUtility.IsExceptNormalOrSelectiveMonster = function(monsterid)
  -- function num : 0_63 , upvalues : _ENV
  local config = (((BattleECS.Utility).DataUtility).cMonsterCfgTable)[monsterid]
  if config.MonsterStyle == 3 or config.MonsterStyle == 2 then
    do return not config end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BuffUtility.GetBossBonusValueAll = function(entity)
  -- function num : 0_64 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local value = 0
  if component then
    for _,v in ipairs(component._buffList) do
      value = value + (v.buffObj):GetBUffBossBonusValue()
    end
  end
  do
    if fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[120]).attr) < value then
      value = fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[120]).attr)
    end
    if value < fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[119]).attr) then
      value = fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[119]).attr)
    end
    return value
  end
end

BuffUtility.GetMonsterBonusValueAll = function(entity)
  -- function num : 0_65 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local value = 0
  if component then
    for _,v in ipairs(component._buffList) do
      value = value + (v.buffObj):GetBUffMonsterBonusValue()
    end
  end
  do
    if fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[120]).attr) < value then
      value = fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[120]).attr)
    end
    if value < fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[119]).attr) then
      value = fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[119]).attr)
    end
    return value
  end
end

BuffUtility.GetEntityElementAdditionDmg = function(battleWorld, entity, elemet)
  -- function num : 0_66 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).BuffComponent)
  local elementNum = battleWorld:GetElementNumFromLeftLine(elemet)
  local result = fixedpoint_zero
  if component then
    for _,v in ipairs(component._buffList) do
      local value = (v.buffObj):GetBuffElementypeValue()
      if value.elementype == elemet or elemet == 4 then
        if value.elementnum == fixedpoint_zero or value.elementnum <= elementNum then
          result = result + value.elementdmg
        else
          if elemet == 4 and value.elementnum <= battleWorld:GetElementNumFromLeftLine(value.elementype) + 1 then
            result = result + value.elementdmg
          end
        end
      end
    end
  end
  do
    return result
  end
end

BuffUtility.SetBuffListToEnemyCampEntityBySkillID = function(entity, enermyEntity, skillid, battleWorld, rad)
  -- function num : 0_67 , upvalues : _ENV, BuffUtility
  if not enermyEntity or not entity then
    LogErrorFormat("BuffUtility", "skillid %s enermyentity %s entity %s, buff add failed", skillid, enermyEntity, entity)
    return 
  end
  local _, enemylist = (BuffUtility.GetSKillBuffList)(skillid)
  for _,v in ipairs(enemylist) do
    local defend = entity:GetComponent((BattleECS.Components).DefenseComponent)
    local attack = enermyEntity:GetComponent((BattleECS.Components).AttackComponent)
    if (BuffUtility.GetBuffDamageType)(tonumber(v.buffid)) == "PhysicalDamage" then
      local hitRate = attack._hitRate - defend._attackMiss - defend._physicalEvasion
      if hitRate < 0 then
        local random = (battleWorld._randomPcg)(0, 1)
        if random <= -hitRate then
          (((BattleECS.Utility).ProtocolUtility).SendDamageMissProtocol)(entity._entityId, 4, battleWorld)
          ;
          (((BattleECS.Utility).BuffUtility).ClearYingXiBuff)(enermyEntity, skillid)
          return 
        end
      end
    else
      do
        if (BuffUtility.GetBuffDamageType)(tonumber(v.buffid)) == "MagicDamage" then
          local hitRate = attack._hitRate - defend._attackMiss - defend._magicEvasion
          if hitRate < 0 then
            local random = (battleWorld._randomPcg)(0, 1)
            if random <= -hitRate then
              (((BattleECS.Utility).ProtocolUtility).SendDamageMissProtocol)(entity._entityId, 4, battleWorld)
              ;
              (((BattleECS.Utility).BuffUtility).ClearYingXiBuff)(enermyEntity, skillid)
              return 
            end
          end
        end
        do
          do
            ;
            (BuffUtility.InsertEntityDifferentBuff)({entity = entity, enermyentity = enermyEntity, buffid = tonumber(v.buffid), buffparamter = v.buffvalues, skillid = skillid, battleworld = battleWorld, rad = rad})
            -- DECOMPILER ERROR at PC118: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC118: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC118: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC118: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

BuffUtility.IsDisposableDamageBuff = function(buffid)
  -- function num : 0_68 , upvalues : _ENV
  local record = (((BattleECS.Utility).DataUtility).cIBuffCfgTable)[buffid]
  if record and (string.find)(record.classname, "Damage") then
    return true
  end
  return false
end

BuffUtility.GetBuffDamageType = function(buffid)
  -- function num : 0_69 , upvalues : _ENV
  local record = (((BattleECS.Utility).DataUtility).cIBuffCfgTable)[buffid]
  if record then
    return record.classname
  end
end

BuffUtility.GetBuffLimiteType = function(buffid)
  -- function num : 0_70 , upvalues : _ENV
  local buffConfig = (((BattleECS.Utility).DataUtility).cBuffCfgTable)[buffid]
  if buffConfig then
    return buffConfig.limitoperations
  end
  return 0
end

BuffUtility.GetBuffChangeSKillID = function(entity, skillid, battleWorld)
  -- function num : 0_71 , upvalues : _ENV
  for _,v in ipairs((entity:GetComponent((BattleECS.Components).BuffComponent))._buffList) do
    local aSkillRecord = (((BattleECS.Utility).DataUtility).cSkillChangeTable)[skillid]
    if aSkillRecord then
      local changeSkillId = aSkillRecord[tonumber(v.buffId)]
      if changeSkillId then
        local skillConfig = (((BattleECS.Utility).DataUtility).cSkillCostTable)[changeSkillId]
        if skillConfig then
          local skillComponent = entity:GetComponent((BattleECS.Components).SkillComponent)
          local redCost = skillConfig.OrderCost
          local blueCost = skillConfig.ChaosCost
          ;
          (((BattleECS.Utility).Utility).SetEntitySkillComponentCostPower)(entity, changeSkillId, redCost, blueCost)
          if skillConfig.pureCost ~= "" then
            local record = {}
            record.skillComponentB = skillComponent
            record.skillComponentA = skillComponent
            record.world = battleWorld
            record.formulaString = skillConfig.pureCost
            record.skillid = changeSkillId
            record.camp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
            redCost = (((BattleECS.Utility).BuffUtility).NewAnalysisFormulaPowerCost)(record)
            ;
            (((BattleECS.Utility).Utility).SetEntitySkillComponentCostPower)(entity, changeSkillId, redCost, blueCost)
          end
        end
        do
          do
            do return changeSkillId end
            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  return skillid
end

BuffUtility.ResetPowerCostValue = function(entity)
  -- function num : 0_72 , upvalues : _ENV
  local buffComponent = entity:GetComponent((BattleECS.Components).BuffComponent)
  buffComponent._orderPowerCost = fixedpoint_zero
  buffComponent._chaosPowerCost = fixedpoint_zero
end

BuffUtility.ClearYingXiBuff = function(entity, skillid)
  -- function num : 0_73 , upvalues : _ENV
  local isHas, buffobj = (((BattleECS.Utility).BuffUtility).IsHasYingXiContinueBuff)(entity)
  if isHas and (entity:GetComponent((BattleECS.Components).TypeComponent))._isImaged and (((BattleECS.Utility).Utility).IsAttackSkill)(skillid) then
    local time = (((BattleECS.Utility).Utility).GetMonsterOrRoleMagicOrAttackEndFraps)(entity, skillid)
    if buffobj:GetBuffTotalTime() > 999 then
      buffobj:SetBuffTotalTime(time + 1)
      buffobj:SetBuffContinuedTime(1)
    end
  end
end

BuffUtility.GetSkinBuffChangeEffectId = function(curPrefabName, buffEffectId)
  -- function num : 0_74 , upvalues : _ENV
  local skinChangeRecorder = (((BattleECS.Utility).DataUtility).cSkinBuffEffectChangeTable)[buffEffectId]
  if skinChangeRecorder then
    for index,shapeId in ipairs(skinChangeRecorder.shapeid) do
      local shapeRecorder = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[tonumber(shapeId)]
      if shapeRecorder and shapeRecorder.prefabName == curPrefabName then
        buffEffectId = tonumber((skinChangeRecorder.effectid)[index])
        break
      end
    end
  end
  do
    return buffEffectId
  end
end

BuffUtility.AddSkillSectionEndBuffParameter = function(entity, skillId)
  -- function num : 0_75 , upvalues : _ENV, BuffUtility
  local buffComponent = entity:GetComponent((BattleECS.Components).BuffComponent)
  for _,inV in ipairs(buffComponent._skillsectionendbuffSnapShoot) do
    LogInfoFormat("BuffUtility", "buffid %s AddSkillSectionEndBuffParameter skillid %s", inV.buffId, skillId)
    for _,param in ipairs(inV.paParams) do
      (inV.buffObj):NumbericalCalculation(param)
    end
    if buffComponent._skillsectionendbuffSkillId == 0 then
      buffComponent._skillsectionendbuffSkillId = skillId
      buffComponent._skillsectionendbuffSkillEffect = {}
      local ourlist, enemylist = (BuffUtility.GetSKillBuffList)(skillId)
      for _,v in ipairs(ourlist) do
        (table.insert)(buffComponent._skillsectionendbuffSkillEffect, {buffid = v.buffid, effect = false})
      end
      for _,v in ipairs(enemylist) do
        (table.insert)(buffComponent._skillsectionendbuffSkillEffect, {buffid = v.buffid, effect = false})
      end
    end
  end
  buffComponent._skillsectionendbuffSnapShoot = {}
end

BuffUtility.SetSkillsectionendbuffSkillEffect = function(entity, buffid)
  -- function num : 0_76 , upvalues : _ENV
  local buffComponent = entity:GetComponent((BattleECS.Components).BuffComponent)
  if buffComponent then
    for _,v in ipairs(buffComponent._skillsectionendbuffSkillEffect) do
      if v.buffid == buffid then
        v.effect = true
        break
      end
    end
  end
end

BuffUtility.ProcessFormulaString = function(buffid, skillid, formulaString)
  -- function num : 0_77 , upvalues : _ENV, AttrTypeEnum, FirstAttrTypeNameList, StaticAttrTypeNameList, OtherAttrTypeNameList
  local splitIndex = (string.find)(formulaString, "=")
  if not splitIndex then
    LogErrorFormat("buffutility", "ProcessFormulaString buffid %s skillid %s formula has no [ = ]", buffid, skillid)
  end
  local returnValue = (string.sub)(formulaString, 1, splitIndex - 1)
  local formula = (string.sub)(formulaString, splitIndex + 1, (string.len)(formulaString))
  local cfgFormula = ""
  for _,v in ipairs(((BattleECS.Utility).DataUtility).cSkillFormulaCfgTable) do
    if (string.find)(formula, "f." .. (v.record).FormulaName) then
      cfgFormula = (v.record).Formula .. "," .. (v.record).BaseDamageFormula
      break
    end
  end
  do
    local attrResult = {}
    for _,attrIdv in ipairs(((BattleECS.Utility).DataUtility).soreCattr) do
      for _,v in ipairs(attrIdv) do
        if v.id ~= AttrTypeEnum.DEFEND then
          local attrname = (v.record).attrname
          local attrnamea = attrname .. "a"
          local attrnameb = attrname .. "b"
          local id = (v.record).id
          if not (string.find)(formula, attrnamea) then
            attrResult[attrnamea] = (string.find)(cfgFormula, attrnamea)
            if not (string.find)(formula, attrnameb) then
              attrResult[attrnameb] = (string.find)(cfgFormula, attrnameb)
              if v.id == AttrTypeEnum.ORDER_PWR or v.id == AttrTypeEnum.CHAOS_PWR or v.id == AttrTypeEnum.ORDER_COST_REDUCE or v.id == AttrTypeEnum.CHAOS_COST_REDUCE then
                if not (string.find)(formula, attrname) then
                  attrResult[attrname] = (string.find)(cfgFormula, attrname)
                  if v.id == AttrTypeEnum.ORDER_COST or v.id == AttrTypeEnum.CHAOS_COST or v.id == AttrTypeEnum.DISPEL_BUFF_NUM then
                    if not (string.find)(formula, attrname) then
                      do
                        attrResult[attrname] = (string.find)(cfgFormula, attrname)
                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC161: LeaveBlock: unexpected jumping out IF_STMT

                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    for _,v in ipairs(FirstAttrTypeNameList) do
      local attrnamea = v .. "a"
      local attrnameb = v .. "b"
      if not (string.find)(formula, attrnamea) then
        attrResult[attrnamea] = (string.find)(cfgFormula, attrnamea)
        if not (string.find)(formula, attrnameb) then
          do
            attrResult[attrnameb] = (string.find)(cfgFormula, attrnameb)
            -- DECOMPILER ERROR at PC201: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC201: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC201: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC201: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    for _,v in ipairs(StaticAttrTypeNameList) do
      local attrnamea = v .. "a"
      local attrnameb = v .. "b"
      if not (string.find)(formula, attrnamea) then
        attrResult[attrnamea] = (string.find)(cfgFormula, attrnamea)
        if not (string.find)(formula, attrnameb) then
          do
            attrResult[attrnameb] = (string.find)(cfgFormula, attrnameb)
            -- DECOMPILER ERROR at PC239: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC239: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC239: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC239: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    for _,v in ipairs(OtherAttrTypeNameList) do
      if not (string.find)(formula, v) then
        do
          attrResult[v] = (string.find)(cfgFormula, v)
          -- DECOMPILER ERROR at PC258: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC258: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    return returnValue, formula, attrResult
  end
end

BuffUtility.NewAnalysisFormula = function(...)
  -- function num : 0_78 , upvalues : _ENV, AttrTypeEnum, FirstAttrTypeNameList, StaticAttrTypeNameList, OtherAttrTypeNameList
  local args = {...}
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
  for _,v in ipairs((((BattleECS.Utility).DataUtility).soreCattr)[1]) do
    if v.id ~= AttrTypeEnum.DEFEND then
      local attrname = (v.record).attrname
      local attrnamea = attrname .. "a"
      local attrnameb = attrname .. "b"
      local id = (v.record).id
      if attrResult[attrnamea] or attrResult[attrnameb] then
        findAttrInFormula = true
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R33 in 'UnsetPending'

        if id == 10 then
          (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = hpComponnetA._currentHp
          -- DECOMPILER ERROR at PC68: Confused about usage of register: R33 in 'UnsetPending'

          ;
          (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = hpComponnetB._currentHp
        else
          -- DECOMPILER ERROR at PC77: Confused about usage of register: R33 in 'UnsetPending'

          if id == 20 then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = hpComponnetA._maxHp
            -- DECOMPILER ERROR at PC83: Confused about usage of register: R33 in 'UnsetPending'

            ;
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = hpComponnetB._maxHp
          else
            -- DECOMPILER ERROR at PC92: Confused about usage of register: R33 in 'UnsetPending'

            if id == 30 then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._attack
              -- DECOMPILER ERROR at PC98: Confused about usage of register: R33 in 'UnsetPending'

              ;
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._attack
            else
              -- DECOMPILER ERROR at PC107: Confused about usage of register: R33 in 'UnsetPending'

              if id == 60 then
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = defenComponentA._magicDefense
                -- DECOMPILER ERROR at PC113: Confused about usage of register: R33 in 'UnsetPending'

                ;
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = defenComponentB._magicDefense
              else
                -- DECOMPILER ERROR at PC122: Confused about usage of register: R33 in 'UnsetPending'

                if id == 80 then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = hpComponnetA._lastDamage
                  -- DECOMPILER ERROR at PC128: Confused about usage of register: R33 in 'UnsetPending'

                  ;
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = hpComponnetB._lastDamage
                else
                  -- DECOMPILER ERROR at PC137: Confused about usage of register: R33 in 'UnsetPending'

                  if id == 90 then
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._attackDamageAddition
                    -- DECOMPILER ERROR at PC143: Confused about usage of register: R33 in 'UnsetPending'

                    ;
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._attackDamageAddition
                  else
                    -- DECOMPILER ERROR at PC152: Confused about usage of register: R33 in 'UnsetPending'

                    if id == 100 then
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = defenComponentA._attackDefenseAddition
                      -- DECOMPILER ERROR at PC158: Confused about usage of register: R33 in 'UnsetPending'

                      ;
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = defenComponentB._attackDefenseAddition
                    else
                      -- DECOMPILER ERROR at PC167: Confused about usage of register: R33 in 'UnsetPending'

                      if id == 110 then
                        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._magicDamageAddition
                        -- DECOMPILER ERROR at PC173: Confused about usage of register: R33 in 'UnsetPending'

                        ;
                        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._magicDamageAddition
                      else
                        -- DECOMPILER ERROR at PC182: Confused about usage of register: R33 in 'UnsetPending'

                        if id == 120 then
                          (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = defenComponentA._magicDefenseAddition
                          -- DECOMPILER ERROR at PC188: Confused about usage of register: R33 in 'UnsetPending'

                          ;
                          (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = defenComponentB._magicDefenseAddition
                        else
                          -- DECOMPILER ERROR at PC197: Confused about usage of register: R33 in 'UnsetPending'

                          if id == 130 then
                            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._attackCritRate
                            -- DECOMPILER ERROR at PC203: Confused about usage of register: R33 in 'UnsetPending'

                            ;
                            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._attackCritRate
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  for _,v in ipairs((((BattleECS.Utility).DataUtility).soreCattr)[2]) do
    local attrname = (v.record).attrname
    local attrnamea = attrname .. "a"
    local attrnameb = attrname .. "b"
    local id = (v.record).id
    if attrResult[attrnamea] or attrResult[attrnameb] then
      findAttrInFormula = true
      -- DECOMPILER ERROR at PC238: Confused about usage of register: R33 in 'UnsetPending'

      if id == 190 then
        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._attackSuckBlood
        -- DECOMPILER ERROR at PC244: Confused about usage of register: R33 in 'UnsetPending'

        ;
        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._attackSuckBlood
      else
        -- DECOMPILER ERROR at PC253: Confused about usage of register: R33 in 'UnsetPending'

        if id == 200 then
          (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._magicSuckBlood
          -- DECOMPILER ERROR at PC259: Confused about usage of register: R33 in 'UnsetPending'

          ;
          (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._magicSuckBlood
        else
          -- DECOMPILER ERROR at PC268: Confused about usage of register: R33 in 'UnsetPending'

          if id == 210 then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = defenComponentA._attackInjuryReduceNumber
            -- DECOMPILER ERROR at PC274: Confused about usage of register: R33 in 'UnsetPending'

            ;
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = defenComponentB._attackInjuryReduceNumber
          else
            -- DECOMPILER ERROR at PC283: Confused about usage of register: R33 in 'UnsetPending'

            if id == 220 then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = defenComponentA._magicInjuryReduceNumber
              -- DECOMPILER ERROR at PC289: Confused about usage of register: R33 in 'UnsetPending'

              ;
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = defenComponentB._magicInjuryReduceNumber
            else
              -- DECOMPILER ERROR at PC301: Confused about usage of register: R33 in 'UnsetPending'

              if id == 230 then
                if attrResult[attrnamea] then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = hpComponnetA._totalDamage
                  ;
                  (((BattleECS.Utility).Utility).ClearEntityHpComponentTotalDamege)(enermyentity)
                end
                -- DECOMPILER ERROR at PC316: Confused about usage of register: R33 in 'UnsetPending'

                if attrResult[attrnameb] then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = hpComponnetB._totalDamage
                  ;
                  (((BattleECS.Utility).Utility).ClearEntityHpComponentTotalDamege)(entity)
                end
              else
                -- DECOMPILER ERROR at PC331: Confused about usage of register: R33 in 'UnsetPending'

                if id == 250 then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._attackDefBreak
                  -- DECOMPILER ERROR at PC337: Confused about usage of register: R33 in 'UnsetPending'

                  ;
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._attackDefBreak
                else
                  -- DECOMPILER ERROR at PC346: Confused about usage of register: R33 in 'UnsetPending'

                  if id == 260 then
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._magicDefBreak
                    -- DECOMPILER ERROR at PC352: Confused about usage of register: R33 in 'UnsetPending'

                    ;
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._magicDefBreak
                  else
                    -- DECOMPILER ERROR at PC361: Confused about usage of register: R33 in 'UnsetPending'

                    if id == 270 then
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._attackCritDefense
                      -- DECOMPILER ERROR at PC367: Confused about usage of register: R33 in 'UnsetPending'

                      ;
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._attackCritDefense
                    else
                      -- DECOMPILER ERROR at PC376: Confused about usage of register: R33 in 'UnsetPending'

                      if id == 290 then
                        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._attackAddition
                        -- DECOMPILER ERROR at PC382: Confused about usage of register: R33 in 'UnsetPending'

                        ;
                        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._attackAddition
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  for _,v in ipairs((((BattleECS.Utility).DataUtility).soreCattr)[3]) do
    local attrname = (v.record).attrname
    local attrnamea = attrname .. "a"
    local attrnameb = attrname .. "b"
    local id = (v.record).id
    if attrResult[attrnamea] or attrResult[attrnameb] then
      findAttrInFormula = true
      -- DECOMPILER ERROR at PC417: Confused about usage of register: R33 in 'UnsetPending'

      if id == 300 then
        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._magicAddition
        -- DECOMPILER ERROR at PC423: Confused about usage of register: R33 in 'UnsetPending'

        ;
        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._magicAddition
      else
        -- DECOMPILER ERROR at PC432: Confused about usage of register: R33 in 'UnsetPending'

        if id == 310 then
          (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._treatmentAddition
          -- DECOMPILER ERROR at PC438: Confused about usage of register: R33 in 'UnsetPending'

          ;
          (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._treatmentAddition
        else
          -- DECOMPILER ERROR at PC447: Confused about usage of register: R33 in 'UnsetPending'

          if id == 350 then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._skillDamageBonus
            -- DECOMPILER ERROR at PC453: Confused about usage of register: R33 in 'UnsetPending'

            ;
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._skillDamageBonus
          else
            -- DECOMPILER ERROR at PC462: Confused about usage of register: R33 in 'UnsetPending'

            if id == 360 then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._skillTreeteBonus
              -- DECOMPILER ERROR at PC468: Confused about usage of register: R33 in 'UnsetPending'

              ;
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._skillTreeteBonus
            else
              -- DECOMPILER ERROR at PC482: Confused about usage of register: R33 in 'UnsetPending'

              if id == 370 then
                if (hpComponnetA._skillListOnceDamage)[skillid] then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = (hpComponnetA._skillListOnceDamage)[skillid]
                  -- DECOMPILER ERROR at PC484: Confused about usage of register: R33 in 'UnsetPending'

                  ;
                  (hpComponnetA._skillListOnceDamage)[skillid] = 0
                else
                  -- DECOMPILER ERROR at PC490: Confused about usage of register: R33 in 'UnsetPending'

                  ;
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = 0
                end
                -- DECOMPILER ERROR at PC501: Confused about usage of register: R33 in 'UnsetPending'

                if (hpComponnetB._skillListOnceDamage)[skillid] then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = (hpComponnetB._skillListOnceDamage)[skillid]
                  -- DECOMPILER ERROR at PC503: Confused about usage of register: R33 in 'UnsetPending'

                  ;
                  (hpComponnetB._skillListOnceDamage)[skillid] = 0
                else
                  -- DECOMPILER ERROR at PC509: Confused about usage of register: R33 in 'UnsetPending'

                  ;
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = 0
                end
              else
                -- DECOMPILER ERROR at PC518: Confused about usage of register: R33 in 'UnsetPending'

                if id == 400 then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = buffComponentA._dispelbuffnum
                else
                  -- DECOMPILER ERROR at PC527: Confused about usage of register: R33 in 'UnsetPending'

                  if id == 410 then
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = typeComponentB._monsterType
                  else
                    -- DECOMPILER ERROR at PC536: Confused about usage of register: R33 in 'UnsetPending'

                    if id == 430 then
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = skillComponentA._comboNumber
                      -- DECOMPILER ERROR at PC542: Confused about usage of register: R33 in 'UnsetPending'

                      ;
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = skillComponentB._comboNumber
                    else
                      -- DECOMPILER ERROR at PC551: Confused about usage of register: R33 in 'UnsetPending'

                      if id == 450 then
                        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = skillComponentA._isHasPassiveSkillParamter
                        -- DECOMPILER ERROR at PC557: Confused about usage of register: R33 in 'UnsetPending'

                        ;
                        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = skillComponentB._isHasPassiveSkillParamter
                      else
                        -- DECOMPILER ERROR at PC573: Confused about usage of register: R33 in 'UnsetPending'

                        if id == 460 then
                          if (((BattleECS.Utility).BuffUtility).IsHasDebuff)(enermyentity) then
                            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = 1
                          else
                            -- DECOMPILER ERROR at PC579: Confused about usage of register: R33 in 'UnsetPending'

                            ;
                            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = 0
                          end
                          -- DECOMPILER ERROR at PC592: Confused about usage of register: R33 in 'UnsetPending'

                          if (((BattleECS.Utility).BuffUtility).IsHasDebuff)(entity) then
                            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = 1
                          else
                            -- DECOMPILER ERROR at PC598: Confused about usage of register: R33 in 'UnsetPending'

                            ;
                            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = 0
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  for _,v in ipairs((((BattleECS.Utility).DataUtility).soreCattr)[4]) do
    local attrname = (v.record).attrname
    local attrnamea = attrname .. "a"
    local attrnameb = attrname .. "b"
    local id = (v.record).id
    if attrResult[attrnamea] or attrResult[attrnameb] then
      findAttrInFormula = true
      -- DECOMPILER ERROR at PC633: Confused about usage of register: R33 in 'UnsetPending'

      if id == 490 then
        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = skillComponentA._bossComboNumber
        -- DECOMPILER ERROR at PC639: Confused about usage of register: R33 in 'UnsetPending'

        ;
        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = skillComponentB._bossComboNumber
      else
        -- DECOMPILER ERROR at PC648: Confused about usage of register: R33 in 'UnsetPending'

        if id == 500 then
          (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._attackCritLevel
          -- DECOMPILER ERROR at PC654: Confused about usage of register: R33 in 'UnsetPending'

          ;
          (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._attackCritLevel
        else
          -- DECOMPILER ERROR at PC663: Confused about usage of register: R33 in 'UnsetPending'

          if id == 510 then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._attackCritDegreeLevel
            -- DECOMPILER ERROR at PC669: Confused about usage of register: R33 in 'UnsetPending'

            ;
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._attackCritDegreeLevel
          else
            -- DECOMPILER ERROR at PC678: Confused about usage of register: R33 in 'UnsetPending'

            if id == 750 then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = typeComponentA._level
              -- DECOMPILER ERROR at PC684: Confused about usage of register: R33 in 'UnsetPending'

              ;
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = typeComponentB._level
            else
              -- DECOMPILER ERROR at PC693: Confused about usage of register: R33 in 'UnsetPending'

              if id == 530 then
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = attackComponnetA._healingPower
                -- DECOMPILER ERROR at PC699: Confused about usage of register: R33 in 'UnsetPending'

                ;
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = attackComponnetB._healingPower
              else
                -- DECOMPILER ERROR at PC708: Confused about usage of register: R33 in 'UnsetPending'

                if id == 830 then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = defenComponentA._attackCritDegreeDefense
                  -- DECOMPILER ERROR at PC714: Confused about usage of register: R33 in 'UnsetPending'

                  ;
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = defenComponentB._attackCritDegreeDefense
                else
                  -- DECOMPILER ERROR at PC723: Confused about usage of register: R33 in 'UnsetPending'

                  if id == 650 then
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = buffComponentA._attackTime
                    -- DECOMPILER ERROR at PC729: Confused about usage of register: R33 in 'UnsetPending'

                    ;
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = buffComponentB._attackTime
                  else
                    -- DECOMPILER ERROR at PC738: Confused about usage of register: R33 in 'UnsetPending'

                    if id == 1060 then
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = defenComponentA._damageReduce
                      -- DECOMPILER ERROR at PC744: Confused about usage of register: R33 in 'UnsetPending'

                      ;
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = defenComponentB._damageReduce
                    else
                      -- DECOMPILER ERROR at PC753: Confused about usage of register: R33 in 'UnsetPending'

                      if id == 1070 then
                        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = typeComponentA._runelv
                        -- DECOMPILER ERROR at PC759: Confused about usage of register: R33 in 'UnsetPending'

                        ;
                        (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = typeComponentB._runelv
                      else
                        -- DECOMPILER ERROR at PC775: Confused about usage of register: R33 in 'UnsetPending'

                        if id == 740 then
                          if (((BattleECS.Utility).BuffUtility).IsHasShieldbuff)(enermyentity) then
                            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = 1
                          else
                            -- DECOMPILER ERROR at PC781: Confused about usage of register: R33 in 'UnsetPending'

                            ;
                            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = 0
                          end
                          -- DECOMPILER ERROR at PC794: Confused about usage of register: R33 in 'UnsetPending'

                          if (((BattleECS.Utility).BuffUtility).IsHasShieldbuff)(entity) then
                            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = 1
                          else
                            -- DECOMPILER ERROR at PC800: Confused about usage of register: R33 in 'UnsetPending'

                            ;
                            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = 0
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  for _,v in ipairs((((BattleECS.Utility).DataUtility).soreCattr)[5]) do
    local attrname = (v.record).attrname
    local id = (v.record).id
    if attrResult[attrname] then
      findAttrInFormula = true
      -- DECOMPILER ERROR at PC865: Confused about usage of register: R31 in 'UnsetPending'

      if v.id == AttrTypeEnum.ORDER_PWR or v.id == AttrTypeEnum.CHAOS_PWR or v.id == AttrTypeEnum.ORDER_COST_REDUCE or v.id == AttrTypeEnum.CHAOS_COST_REDUCE then
        if id == 330 then
          if (enermyentity:GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrname] = (((BattleECS.Utility).DataUtility).GetPowerGridFunc)(battleworld._redPower, (((BattleECS.Utility).DataUtility).PowerType).Red)
          else
            -- DECOMPILER ERROR at PC884: Confused about usage of register: R31 in 'UnsetPending'

            if (enermyentity:GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrname] = 0
            end
          end
        else
          -- DECOMPILER ERROR at PC916: Confused about usage of register: R31 in 'UnsetPending'

          if id == 340 then
            if (enermyentity:GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrname] = (((BattleECS.Utility).DataUtility).GetPowerGridFunc)(battleworld._bluePower, (((BattleECS.Utility).DataUtility).PowerType).Blue)
            else
              -- DECOMPILER ERROR at PC935: Confused about usage of register: R31 in 'UnsetPending'

              if (enermyentity:GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrname] = 0
              end
            end
          else
            -- DECOMPILER ERROR at PC945: Confused about usage of register: R31 in 'UnsetPending'

            if id == 470 then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrname] = (skillComponentB._skillCostPowerReduceList).order
            else
              -- DECOMPILER ERROR at PC955: Confused about usage of register: R31 in 'UnsetPending'

              if id == 480 then
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrname] = (skillComponentB._skillCostPowerReduceList).chaos
              end
            end
          end
        end
      end
      if v.id == AttrTypeEnum.ORDER_COST or v.id == AttrTypeEnum.CHAOS_COST then
        if id == 380 then
          if not skillComponentA or not skillComponentA._skillCostPowerList or not (skillComponentA._skillCostPowerList)[skillid] then
            LogErrorFormat("BuffUtility", "attrname %s skillid %s entityid %s enermyentityid %s", attrname, skillid, entity._entityId, enermyentity._entityId)
          else
            -- DECOMPILER ERROR at PC991: Confused about usage of register: R31 in 'UnsetPending'

            ;
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrname] = ((skillComponentA._skillCostPowerList)[skillid]).red
          end
        else
          -- DECOMPILER ERROR at PC1002: Confused about usage of register: R31 in 'UnsetPending'

          if id == 390 then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrname] = ((skillComponentA._skillCostPowerList)[skillid]).blue
          end
        end
      end
    end
  end
  for _,v in ipairs((((BattleECS.Utility).DataUtility).soreCattr)[#((BattleECS.Utility).DataUtility).soreCattr]) do
    local attrname = (v.record).attrname
    local attrnamea = attrname .. "a"
    local attrnameb = attrname .. "b"
    if attrResult[attrnamea] or attrResult[attrnameb] then
      findAttrInFormula = true
      -- DECOMPILER ERROR at PC1044: Confused about usage of register: R32 in 'UnsetPending'

      ;
      (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnamea] = (buffComponentA._buffnum)[(v.record).ablEffctName] or fixedpoint_zero
      -- DECOMPILER ERROR at PC1056: Confused about usage of register: R32 in 'UnsetPending'

      ;
      (((BattleECS.Utility).DataUtility).BattleFormulaVariables)[attrnameb] = (buffComponentB._buffnum)[(v.record).ablEffctName] or fixedpoint_zero
    end
  end
  for _,v in ipairs(FirstAttrTypeNameList) do
    if attrResult[v .. "a"] then
      findAttrInFormula = true
      -- DECOMPILER ERROR at PC1081: Confused about usage of register: R29 in 'UnsetPending'

      if v == "reduce" then
        if buffid == 10000 or buffid == 10016 then
          (((BattleECS.Utility).DataUtility).BattleFormulaVariables).reducea = defenComponentA._attackDefenseAddition
        else
          -- DECOMPILER ERROR at PC1092: Confused about usage of register: R29 in 'UnsetPending'

          if buffid == 10001 or buffid == 10017 then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables).reducea = defenComponentA._magicDefenseAddition
          else
            -- DECOMPILER ERROR at PC1099: Confused about usage of register: R29 in 'UnsetPending'

            ;
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables).reducea = defenComponentA._attackDefenseAddition
          end
        end
      else
        -- DECOMPILER ERROR at PC1112: Confused about usage of register: R29 in 'UnsetPending'

        if v == "block" then
          if buffid == 10000 or buffid == 10016 then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables).blocka = defenComponentA._attackInjuryReduceNumber
          else
            -- DECOMPILER ERROR at PC1123: Confused about usage of register: R29 in 'UnsetPending'

            if buffid == 10001 or buffid == 10017 then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables).blocka = defenComponentA._magicInjuryReduceNumber
            else
              -- DECOMPILER ERROR at PC1130: Confused about usage of register: R29 in 'UnsetPending'

              ;
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables).blocka = defenComponentA._attackInjuryReduceNumber
            end
          end
        else
          -- DECOMPILER ERROR at PC1143: Confused about usage of register: R29 in 'UnsetPending'

          if v == "defbreak" then
            if buffid == 10000 or buffid == 10016 then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defbreaka = attackComponnetA._attackDefBreak
            else
              -- DECOMPILER ERROR at PC1154: Confused about usage of register: R29 in 'UnsetPending'

              if buffid == 10001 or buffid == 10017 then
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defbreaka = attackComponnetA._magicDefBreak
              else
                -- DECOMPILER ERROR at PC1161: Confused about usage of register: R29 in 'UnsetPending'

                ;
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defbreaka = attackComponnetA._attackDefBreak
              end
            end
          else
            -- DECOMPILER ERROR at PC1174: Confused about usage of register: R29 in 'UnsetPending'

            if v == "extradmg" then
              if buffid == 10000 or buffid == 10016 then
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables).extradmga = attackComponnetA._attackAddition
              else
                -- DECOMPILER ERROR at PC1185: Confused about usage of register: R29 in 'UnsetPending'

                if buffid == 10001 or buffid == 10017 then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables).extradmga = attackComponnetA._magicAddition
                else
                  -- DECOMPILER ERROR at PC1192: Confused about usage of register: R29 in 'UnsetPending'

                  ;
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables).extradmga = attackComponnetA._attackAddition
                end
              end
            else
              -- DECOMPILER ERROR at PC1207: Confused about usage of register: R29 in 'UnsetPending'

              if v == "bonus" then
                if buffid == 10000 or buffid == 10002 or buffid == 10016 then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables).bonusa = attackComponnetA._attackDamageAddition
                else
                  -- DECOMPILER ERROR at PC1222: Confused about usage of register: R29 in 'UnsetPending'

                  if buffid == 10001 or buffid == 10003 or buffid == 10010 or buffid == 10017 then
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables).bonusa = attackComponnetA._magicDamageAddition
                  else
                    -- DECOMPILER ERROR at PC1229: Confused about usage of register: R29 in 'UnsetPending'

                    ;
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables).bonusa = attackComponnetA._attackDamageAddition
                  end
                end
              else
                -- DECOMPILER ERROR at PC1242: Confused about usage of register: R29 in 'UnsetPending'

                if v == "defend" then
                  if buffid == 10000 or buffid == 10016 then
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defenda = defenComponentA._attackDefense
                  else
                    -- DECOMPILER ERROR at PC1253: Confused about usage of register: R29 in 'UnsetPending'

                    if buffid == 10001 or buffid == 10017 then
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defenda = defenComponentA._magicDefense
                    else
                      -- DECOMPILER ERROR at PC1260: Confused about usage of register: R29 in 'UnsetPending'

                      ;
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defenda = defenComponentA._attackDefense
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if attrResult[v .. "b"] then
      findAttrInFormula = true
      -- DECOMPILER ERROR at PC1279: Confused about usage of register: R29 in 'UnsetPending'

      if v == "reduce" then
        if buffid == 10000 or buffid == 10016 then
          (((BattleECS.Utility).DataUtility).BattleFormulaVariables).reduceb = defenComponentB._attackDefenseAddition
        else
          -- DECOMPILER ERROR at PC1290: Confused about usage of register: R29 in 'UnsetPending'

          if buffid == 10001 or buffid == 10017 then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables).reduceb = defenComponentB._magicDefenseAddition
          else
            -- DECOMPILER ERROR at PC1297: Confused about usage of register: R29 in 'UnsetPending'

            ;
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables).reduceb = defenComponentB._attackDefenseAddition
          end
        end
      else
        -- DECOMPILER ERROR at PC1310: Confused about usage of register: R29 in 'UnsetPending'

        if v == "block" then
          if buffid == 10000 or buffid == 10016 then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables).blockb = defenComponentB._attackInjuryReduceNumber
          else
            -- DECOMPILER ERROR at PC1321: Confused about usage of register: R29 in 'UnsetPending'

            if buffid == 10001 or buffid == 10017 then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables).blockb = defenComponentB._magicInjuryReduceNumber
            else
              -- DECOMPILER ERROR at PC1328: Confused about usage of register: R29 in 'UnsetPending'

              ;
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables).blockb = defenComponentB._attackInjuryReduceNumber
            end
          end
        else
          -- DECOMPILER ERROR at PC1341: Confused about usage of register: R29 in 'UnsetPending'

          if v == "defbreak" then
            if buffid == 10000 or buffid == 10016 then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defbreakb = attackComponnetB._attackDefBreak
            else
              -- DECOMPILER ERROR at PC1352: Confused about usage of register: R29 in 'UnsetPending'

              if buffid == 10001 or buffid == 10017 then
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defbreakb = attackComponnetB._magicDefBreak
              else
                -- DECOMPILER ERROR at PC1359: Confused about usage of register: R29 in 'UnsetPending'

                ;
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defbreakb = attackComponnetB._attackDefBreak
              end
            end
          else
            -- DECOMPILER ERROR at PC1372: Confused about usage of register: R29 in 'UnsetPending'

            if v == "extradmg" then
              if buffid == 10000 or buffid == 10016 then
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables).extradmgb = attackComponnetB._attackAddition
              else
                -- DECOMPILER ERROR at PC1383: Confused about usage of register: R29 in 'UnsetPending'

                if buffid == 10001 or buffid == 10017 then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables).extradmgb = attackComponnetB._magicAddition
                else
                  -- DECOMPILER ERROR at PC1390: Confused about usage of register: R29 in 'UnsetPending'

                  ;
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables).extradmgb = attackComponnetB._attackAddition
                end
              end
            else
              -- DECOMPILER ERROR at PC1405: Confused about usage of register: R29 in 'UnsetPending'

              if v == "bonus" then
                if buffid == 10000 or buffid == 10002 or buffid == 10016 then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables).bonusb = attackComponnetB._attackDamageAddition
                else
                  -- DECOMPILER ERROR at PC1420: Confused about usage of register: R29 in 'UnsetPending'

                  if buffid == 10001 or buffid == 10003 or buffid == 10010 or buffid == 10017 then
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables).bonusb = attackComponnetB._magicDamageAddition
                  else
                    -- DECOMPILER ERROR at PC1427: Confused about usage of register: R29 in 'UnsetPending'

                    ;
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables).bonusb = attackComponnetB._attackDamageAddition
                  end
                end
              else
                -- DECOMPILER ERROR at PC1451: Confused about usage of register: R29 in 'UnsetPending'

                if v == "defend" then
                  if buffid == 10000 or buffid == 10016 then
                    if (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(enermyentity, 20067) then
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defendb = defenComponentB._attackDefense * 8 // 10
                    else
                      -- DECOMPILER ERROR at PC1458: Confused about usage of register: R29 in 'UnsetPending'

                      ;
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defendb = defenComponentB._attackDefense
                    end
                  else
                    -- DECOMPILER ERROR at PC1469: Confused about usage of register: R29 in 'UnsetPending'

                    if buffid == 10001 or buffid == 10017 then
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defendb = defenComponentB._magicDefense
                    else
                      -- DECOMPILER ERROR at PC1476: Confused about usage of register: R29 in 'UnsetPending'

                      ;
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables).defendb = defenComponentB._attackDefense
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  for _,v in ipairs(StaticAttrTypeNameList) do
    if attrResult[v .. "a"] then
      findAttrInFormula = true
      -- DECOMPILER ERROR at PC1497: Confused about usage of register: R29 in 'UnsetPending'

      if v == "staticmaxhp" then
        (((BattleECS.Utility).DataUtility).BattleFormulaVariables).staticmaxhpa = hpComponnetA._basicMaxHp
      else
        -- DECOMPILER ERROR at PC1506: Confused about usage of register: R29 in 'UnsetPending'

        if v == "staticattack" then
          (((BattleECS.Utility).DataUtility).BattleFormulaVariables).staticattacka = attackComponnetA._basicAttack
        else
          -- DECOMPILER ERROR at PC1515: Confused about usage of register: R29 in 'UnsetPending'

          if v == "staticdefend" then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables).staticdefenda = defenComponentA._basicAttackDefense
          else
            -- DECOMPILER ERROR at PC1524: Confused about usage of register: R29 in 'UnsetPending'

            if v == "staticmagicdef" then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables).staticmagicdefa = defenComponentA._basicMagicDefense
            else
              -- DECOMPILER ERROR at PC1533: Confused about usage of register: R29 in 'UnsetPending'

              if v == "staticcritrate" then
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables).staticcritratea = attackComponnetA._basicAttackCritRate
              else
                -- DECOMPILER ERROR at PC1542: Confused about usage of register: R29 in 'UnsetPending'

                if v == "staticcritdegree" then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables).staticcritdegreea = attackComponnetA._basicAttackCritDegree
                end
              end
            end
          end
        end
      end
    end
    if attrResult[v .. "b"] then
      findAttrInFormula = true
      -- DECOMPILER ERROR at PC1557: Confused about usage of register: R29 in 'UnsetPending'

      if v == "staticmaxhp" then
        (((BattleECS.Utility).DataUtility).BattleFormulaVariables).staticmaxhpb = hpComponnetB._basicMaxHp
      else
        -- DECOMPILER ERROR at PC1566: Confused about usage of register: R29 in 'UnsetPending'

        if v == "staticattack" then
          (((BattleECS.Utility).DataUtility).BattleFormulaVariables).staticattackb = attackComponnetB._basicAttack
        else
          -- DECOMPILER ERROR at PC1575: Confused about usage of register: R29 in 'UnsetPending'

          if v == "staticdefend" then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables).staticdefendb = defenComponentB._basicAttackDefense
          else
            -- DECOMPILER ERROR at PC1584: Confused about usage of register: R29 in 'UnsetPending'

            if v == "staticmagicdef" then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables).staticmagicdefb = defenComponentB._basicMagicDefense
            else
              -- DECOMPILER ERROR at PC1593: Confused about usage of register: R29 in 'UnsetPending'

              if v == "staticcritrate" then
                (((BattleECS.Utility).DataUtility).BattleFormulaVariables).staticcritrateb = attackComponnetB._basicAttackCritRate
              else
                -- DECOMPILER ERROR at PC1602: Confused about usage of register: R29 in 'UnsetPending'

                if v == "staticcritdegree" then
                  (((BattleECS.Utility).DataUtility).BattleFormulaVariables).staticcritdegreeb = attackComponnetB._basicAttackCritDegree
                end
              end
            end
          end
        end
      end
    end
  end
  for _,v in ipairs(OtherAttrTypeNameList) do
    if attrResult[v] then
      findAttrInFormula = true
      if v == "atktimes" then
        for _,e in ipairs(battleworld._entitys) do
          local skillEffectComponent = e:GetComponent((BattleECS.Components).SkillEffectComponent)
          -- DECOMPILER ERROR at PC1638: Confused about usage of register: R35 in 'UnsetPending'

          if skillEffectComponent and skillEffectComponent._skillID == skillid and skillEffectComponent._useSkillEntityID == enermyentity._entityId then
            (((BattleECS.Utility).DataUtility).BattleFormulaVariables).atktimes = skillEffectComponent._typeMineEffectAtkEffectTime
            break
          end
        end
      else
        do
          if v == "atknums" then
            local skillComponent = enermyentity:GetComponent((BattleECS.Components).SkillComponent)
            -- DECOMPILER ERROR at PC1657: Confused about usage of register: R30 in 'UnsetPending'

            if skillComponent then
              (((BattleECS.Utility).DataUtility).BattleFormulaVariables).atknums = skillComponent._hittedEntityNumber
            end
          else
            do
              if v == "continualbuffatktimes" then
                for _,v in ipairs(buffComponentB._buffList) do
                  -- DECOMPILER ERROR at PC1675: Confused about usage of register: R34 in 'UnsetPending'

                  if v.buffId == originalBuffid then
                    (((BattleECS.Utility).DataUtility).BattleFormulaVariables).continualbuffatktimes = (v.buffObj):GetBuffTimeCellEffectTimes()
                  end
                end
              else
                do
                  if v == "evolution" then
                    local TypeComponent = enermyentity:GetComponent((BattleECS.Components).TypeComponent)
                    -- DECOMPILER ERROR at PC1693: Confused about usage of register: R30 in 'UnsetPending'

                    if TypeComponent then
                      (((BattleECS.Utility).DataUtility).BattleFormulaVariables).evolution = TypeComponent._evolutionLevel
                    end
                  else
                    do
                      do
                        if v == "exclusivelv" then
                          local TypeComponent = enermyentity:GetComponent((BattleECS.Components).TypeComponent)
                          -- DECOMPILER ERROR at PC1709: Confused about usage of register: R30 in 'UnsetPending'

                          if TypeComponent then
                            (((BattleECS.Utility).DataUtility).BattleFormulaVariables).exclusivelv = TypeComponent._exclusiveLevel
                          end
                        end
                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC1710: LeaveBlock: unexpected jumping out IF_STMT

                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  local funcResult = fixedpoint_zero
  local baseDamageResult, friendFunc = nil, nil
  if (((BattleECS.Utility).DataUtility).CSkillFriendBuffValuesFunc)[skillid] and ((((BattleECS.Utility).DataUtility).CSkillFriendBuffValuesFunc)[skillid])[originalBuffid] then
    friendFunc = (((((BattleECS.Utility).DataUtility).CSkillFriendBuffValuesFunc)[skillid])[originalBuffid])[returnValue]
  end
  local enemyFunc = nil
  if (((BattleECS.Utility).DataUtility).CSkillEnemyBuffValuesFunc)[skillid] and ((((BattleECS.Utility).DataUtility).CSkillEnemyBuffValuesFunc)[skillid])[originalBuffid] then
    enemyFunc = (((((BattleECS.Utility).DataUtility).CSkillEnemyBuffValuesFunc)[skillid])[originalBuffid])[returnValue]
  end
  local RelationType = {Friend = 1, Enemy = 2}
  local relation = RelationType.Friend
  if (entity:GetComponent((BattleECS.Components).TypeComponent))._camp ~= (enermyentity:GetComponent((BattleECS.Components).TypeComponent))._camp then
    relation = RelationType.Enemy
  end
  if relation == RelationType.Friend and friendFunc then
    funcResult = friendFunc()
  else
    -- DECOMPILER ERROR at PC1795: Overwrote pending register: R25 in 'AssignReg'

    if relation == RelationType.Enemy and enemyFunc then
      funcResult = enemyFunc()
    else
      if not findAttrInFormula then
        funcResult = fixedpoint(formula)
      else
        LogErrorFormat("BuffUtility", "function loading failed skillid %s originalBuffid %s buffValue %s", skillid, originalBuffid, formula)
      end
    end
  end
  if not (fixedpoint.judgetype)(funcResult) then
    funcResult = fixedpoint(funcResult)
  end
  -- DECOMPILER ERROR at PC1833: Overwrote pending register: R25 in 'AssignReg'

  if baseDamageResult and not (fixedpoint.judgetype)(baseDamageResult) then
    return funcResult, returnValue, baseDamageResult
  end
end

BuffUtility.NewAnalysisFormulaPowerCost = function(...)
  -- function num : 0_79 , upvalues : _ENV, AttrTypeEnum
  local args = {...}
  local data = args[1]
  local formulaString = data.formulaString
  local skillid = data.skillid
  local battleworld = data.world
  local skillComponentA = data.skillComponentA
  local skillComponentB = data.skillComponentB
  local formula = formulaString
  for _,v in ipairs((((BattleECS.Utility).DataUtility).soreCattr)[5]) do
    local attrname = (v.record).attrname
    local id = (v.record).id
    local i = 0
    if v.id == AttrTypeEnum.ORDER_PWR or v.id == AttrTypeEnum.CHAOS_PWR or v.id == AttrTypeEnum.ORDER_COST_REDUCE or v.id == AttrTypeEnum.CHAOS_COST_REDUCE then
      i = 0
      while 1 do
        while 1 do
          while 1 do
            while 1 do
              while 1 do
                while 1 do
                  i = (string.find)(formula, attrname, i + 1)
                  -- DECOMPILER ERROR at PC74: Confused about usage of register: R16 in 'UnsetPending'

                  if i ~= nil then
                    if id == 330 then
                      if data.camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                        (((BattleECS.Utility).DataUtility).SkillCostFormulaVariables)[attrname] = (((BattleECS.Utility).DataUtility).GetPowerGridFunc)(battleworld._redPower, (((BattleECS.Utility).DataUtility).PowerType).Red)
                        -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

                      end
                    end
                  end
                end
                -- DECOMPILER ERROR at PC88: Confused about usage of register: R16 in 'UnsetPending'

                if data.camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                  (((BattleECS.Utility).DataUtility).SkillCostFormulaVariables)[attrname] = 0
                end
              end
              -- DECOMPILER ERROR at PC115: Confused about usage of register: R16 in 'UnsetPending'

              if id == 340 then
                if data.camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                  (((BattleECS.Utility).DataUtility).SkillCostFormulaVariables)[attrname] = (((BattleECS.Utility).DataUtility).GetPowerGridFunc)(battleworld._bluePower, (((BattleECS.Utility).DataUtility).PowerType).Blue)
                  -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
            -- DECOMPILER ERROR at PC129: Confused about usage of register: R16 in 'UnsetPending'

            if data.camp == (((BattleECS.Components).TypeComponent).CampType).Right then
              (((BattleECS.Utility).DataUtility).SkillCostFormulaVariables)[attrname] = 0
            end
          end
          -- DECOMPILER ERROR at PC139: Confused about usage of register: R16 in 'UnsetPending'

          if id == 470 then
            (((BattleECS.Utility).DataUtility).SkillCostFormulaVariables)[attrname] = (skillComponentB._skillCostPowerReduceList).order
            -- DECOMPILER ERROR at PC140: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC140: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
        -- DECOMPILER ERROR at PC149: Confused about usage of register: R16 in 'UnsetPending'

        if id == 480 then
          (((BattleECS.Utility).DataUtility).SkillCostFormulaVariables)[attrname] = (skillComponentB._skillCostPowerReduceList).chaos
        end
      end
    end
    if v.id == AttrTypeEnum.ORDER_COST or v.id == AttrTypeEnum.CHAOS_COST then
      i = 0
      while 1 do
        while 1 do
          i = (string.find)(formula, attrname, i + 1)
          -- DECOMPILER ERROR at PC178: Confused about usage of register: R16 in 'UnsetPending'

          if i ~= nil then
            if id == 380 then
              (((BattleECS.Utility).DataUtility).SkillCostFormulaVariables)[attrname] = ((skillComponentA._skillCostPowerList)[skillid]).red
              -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
        -- DECOMPILER ERROR at PC189: Confused about usage of register: R16 in 'UnsetPending'

        if id == 390 then
          (((BattleECS.Utility).DataUtility).SkillCostFormulaVariables)[attrname] = ((skillComponentA._skillCostPowerList)[skillid]).blue
        end
      end
    end
  end
  local redResult, blueResult = fixedpoint_zero, fixedpoint_zero
  local redFunc, blueFunc = nil, nil
  if (((BattleECS.Utility).DataUtility).CSkillCostCfgFunc)[skillid] and ((((BattleECS.Utility).DataUtility).CSkillCostCfgFunc)[skillid])[(((BattleECS.Utility).DataUtility).PowerType).Red] then
    redFunc = ((((BattleECS.Utility).DataUtility).CSkillCostCfgFunc)[skillid])[(((BattleECS.Utility).DataUtility).PowerType).Red]
  end
  if redFunc then
    redResult = redFunc()
  else
    LogErrorFormat("BuffUtility", "function loading failed skillid %s powertype %s formula %s, table is ccostskill", skillid, (((BattleECS.Utility).DataUtility).PowerType).Red, formula)
  end
  if not (fixedpoint.judgetype)(redResult) then
    redResult = fixedpoint(redResult)
  end
  if (((BattleECS.Utility).DataUtility).CSkillCostCfgFunc)[skillid] and ((((BattleECS.Utility).DataUtility).CSkillCostCfgFunc)[skillid])[(((BattleECS.Utility).DataUtility).PowerType).Blue] then
    blueFunc = ((((BattleECS.Utility).DataUtility).CSkillCostCfgFunc)[skillid])[(((BattleECS.Utility).DataUtility).PowerType).Blue]
  end
  if blueFunc then
    blueResult = blueFunc()
  else
    LogErrorFormat("BuffUtility", "function loading failed skillid %s powertype %s formula %s, table is ccostskill", skillid, (((BattleECS.Utility).DataUtility).PowerType).Blue, formula)
  end
  if not (fixedpoint.judgetype)(blueResult) then
    blueResult = fixedpoint(blueResult)
  end
  return redResult, blueResult
end

BuffUtility.CanAddGlobalBuffBuff = function(entity, buffId, battleWorld)
  -- function num : 0_80 , upvalues : _ENV
  local record = (((BattleECS.Utility).DataUtility).cGlobalBuffConfigTable)[buffId]
  if record then
    if record.limit == "" then
      return true
    end
    local limits = (string.split)(record.limit, ";")
    for _,v in ipairs(limits) do
      local limitNum = tonumber(v)
      if limitNum >= 1001 and limitNum < 1008 then
        limitNum = limitNum % 1000
        local typeComponent = entity:GetComponent((BattleECS.Components).TypeComponent)
        if typeComponent and typeComponent._roleVocationType == limitNum then
          return true
        end
      else
        do
          if limitNum >= 2001 and limitNum < 2008 then
            local vocation = limitNum % 2000
            if battleWorld:GetVocationNumFromLeftLine(vocation) > 0 then
              return true
            end
          else
            do
              if limitNum >= 3001 and limitNum < 3004 then
                local limitNum = limitNum % 3000
                local typeComponent = entity:GetComponent((BattleECS.Components).TypeComponent)
                if (typeComponent and typeComponent._roleElementType == limitNum) or typeComponent._roleElementType == 4 then
                  return true
                end
              end
              do
                -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
end

return BuffUtility

