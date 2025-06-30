-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/system/animationsystem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = require("ecs.system")
local AnimationSystem = strictclass("AnimationSystem", System)
AnimationSystem.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AnimationSystem, _ENV
  ((AnimationSystem.super).Ctor)(self, ...)
  self._utility = (BattleECS.Utility).Utility
  self._protocolUtility = (BattleECS.Utility).ProtocolUtility
  self._buffUtility = (BattleECS.Utility).BuffUtility
  self._animationUtility = (BattleECS.Utility).AnimationUtility
  self._dataUtility = (BattleECS.Utility).DataUtility
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).SkillComponent)
end

AnimationSystem.Destroy = function(self)
  -- function num : 0_1 , upvalues : AnimationSystem
  ((AnimationSystem.super).Destroy)(self)
end

AnimationSystem.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local SkillComponent = (BattleECS.Components).SkillComponent
  local SummonDataComponent = (BattleECS.Components).SummonDataComponent
  local HpComponent = (BattleECS.Components).HpComponent
  local TypeComponent = (BattleECS.Components).TypeComponent
  local RoleDeadCountComponent = (BattleECS.Components).RoleDeadCountComponent
  for _,entity in ipairs(self._entitys) do
    local skillComponentInstance = entity:GetComponent(SkillComponent)
    local typeComponentInstance = entity:GetComponent(TypeComponent)
    local currentEntitySkillID = skillComponentInstance._skillId
    skillComponentInstance._buffCastSkillId = 0
    if currentEntitySkillID ~= 0 then
      if ((self._utility).IsRoleDead)(entity) then
        LogInfoFormat("AnimationSystem", "entityid %s roleid %s is dead, skill not create", entity._entityId, (entity:GetComponent(TypeComponent))._roleID)
        skillComponentInstance._skillId = 0
        skillComponentInstance._isClickUseSkill = false
      else
        local skillInfo = nil
        for _,v in ipairs(skillComponentInstance._skillList) do
          if v.skillId == currentEntitySkillID then
            skillInfo = v
            break
          end
        end
        do
          if skillInfo then
            local HasTarget = true
            skillInfo.currentTime = 0
            local beforeRateOrChangeOriginalSkillId = currentEntitySkillID
            local isHasRateSkill, rateSkillId = ((self._utility).IsHasRateSkill)(self._world, currentEntitySkillID, {skillComponentA = skillComponentInstance, typeComponentA = typeComponentInstance})
            if isHasRateSkill then
              currentEntitySkillID = rateSkillId
            end
            currentEntitySkillID = ((self._buffUtility).GetBuffChangeSKillID)(entity, currentEntitySkillID, self._world)
            local isAttackSkill = ((self._utility).IsAttackSkill)(currentEntitySkillID)
            local judgeResult = (entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInSkillWithEndTime
            if isAttackSkill and judgeResult then
              LogInfoFormat("AnimationSystem", "普通攻击(effecttype 1) %s 被 其他非普通攻击技能(effecttype not 1) 抵消，释放失败", currentEntitySkillID)
              skillComponentInstance._skillId = 0
              skillComponentInstance._isClickUseSkill = false
              return 
            end
            local hittedEntityList = ((self._utility).GetSkillEffectEntity)(currentEntitySkillID, entity._entityId, self._world)
            if (table.nums)(hittedEntityList) == 0 then
              LogInfoFormat("AnimationSystem", "skill id %s has no target, using failed", currentEntitySkillID)
              HasTarget = false
              skillComponentInstance._skillId = 0
              skillComponentInstance._isClickUseSkill = false
              return 
            end
            if skillComponentInstance._isClickUseSkill then
              local red = (self._world)._redPower
              local blue = (self._world)._bluePower
              local flag, redcu, bluecu = ((self._utility).IsHasPowerToSkill)(entity, currentEntitySkillID, red, blue, self._world)
              if not flag then
                ((self._protocolUtility).SendSkillFail)(entity._entityId, currentEntitySkillID, ((self._utility).SkillUseFailedType).PowerNotEnough, self._world)
                LogInfoFormat("AnimationSystem", "实时判断能量不足 skillid %s", currentEntitySkillID)
                skillComponentInstance._skillId = 0
                skillComponentInstance._isClickUseSkill = false
                return 
              end
            end
            do
              ;
              ((self._protocolUtility).SendSkillBegin)(entity._entityId, beforeRateOrChangeOriginalSkillId, self._world)
              skillComponentInstance._buffCastSkillId = beforeRateOrChangeOriginalSkillId
              if ((self._utility).IsUseSkill)(currentEntitySkillID) then
                ((self._buffUtility).AddSkillSectionEndBuffParameter)(entity, currentEntitySkillID)
              end
              local skillList = ((self._buffUtility).IsHasTriggerBuffWhenRoleUseSKill)(entity)
              for _,skillStruct in ipairs(skillList) do
                if (skillStruct.buff):GetBuffSkillTriggerType() == 1 and ((self._utility).IsRoleFirstSkill)(entity, beforeRateOrChangeOriginalSkillId) then
                  local random = ((self._world)._randomPcg)(1, 100)
                  local effectTime = (skillStruct.buff):GetLinkSkillEffectTime()
                  local totalEffectTime = (skillStruct.buff):GetLinkSkillEffectTotalTime()
                  local triggerLinkSkillFlag = random <= (skillStruct.buff):GetBUffTriggerRate()
                  if totalEffectTime and totalEffectTime <= effectTime then
                    triggerLinkSkillFlag = false
                  end
                  if triggerLinkSkillFlag then
                    (skillStruct.buff):SetLinkSkillEffectTime(effectTime + 1)
                    ;
                    (skillStruct.buff):ResetTriggerCDCountTime()
                    ;
                    ((self._utility).SetSkillComponnetPassiveSkillList)(entity, skillStruct, entity)
                  end
                end
                if (skillStruct.buff):GetBuffSkillTriggerType() == 2 and ((self._utility).IsRoleSecondSkill)(entity, beforeRateOrChangeOriginalSkillId) then
                  local random = ((self._world)._randomPcg)(1, 100)
                  local effectTime = (skillStruct.buff):GetLinkSkillEffectTime()
                  local totalEffectTime = (skillStruct.buff):GetLinkSkillEffectTotalTime()
                  local triggerLinkSkillFlag = random <= (skillStruct.buff):GetBUffTriggerRate()
                  if totalEffectTime and totalEffectTime <= effectTime then
                    triggerLinkSkillFlag = false
                  end
                  if triggerLinkSkillFlag then
                    (skillStruct.buff):SetLinkSkillEffectTime(effectTime + 1)
                    ;
                    (skillStruct.buff):ResetTriggerCDCountTime()
                    ;
                    ((self._utility).SetSkillComponnetPassiveSkillList)(entity, skillStruct, entity)
                  end
                end
                if not ((self._utility).IsAttackSkill)(beforeRateOrChangeOriginalSkillId) then
                  local random = ((self._world)._randomPcg)(1, 100)
                  local effectTime = (skillStruct.buff):GetLinkSkillEffectTime()
                  local totalEffectTime = (skillStruct.buff):GetLinkSkillEffectTotalTime()
                  local triggerLinkSkillFlag = random <= (skillStruct.buff):GetBUffTriggerRate()
                  if totalEffectTime and totalEffectTime <= effectTime then
                    triggerLinkSkillFlag = false
                  end
                  if triggerLinkSkillFlag then
                    (skillStruct.buff):SetLinkSkillEffectTime(effectTime + 1)
                    ;
                    (skillStruct.buff):ResetTriggerCDCountTime()
                    ;
                    ((self._utility).SetSkillComponnetPassiveSkillList)(entity, skillStruct, entity)
                  end
                end
              end
              local component = entity:AddComponent(TypeComponent)
              do
                if component._summonName == "partner" then
                  local count = ((self._utility).GetMonsterOrRoleMagicOrAttackEndFraps)(entity, currentEntitySkillID)
                  if count ~= 0 then
                    component = entity:AddComponent(RoleDeadCountComponent)
                    component._maxCount = count
                  end
                end
                if ((self._utility).IsSkillNeedInitAnimationEventComponentInfo)(entity, currentEntitySkillID) then
                  ((self._animationUtility).InitMonsterOrRoleAnimationEventComponentRoleInSkillInfo)(entity, currentEntitySkillID)
                end
                if (entity:GetComponent(TypeComponent))._camp == (TypeComponent.CampType).Left then
                  for _,v in ipairs(skillComponentInstance._skillList) do
                    local canAccmulate = v.skillId == beforeRateOrChangeOriginalSkillId and v.activeSkillIndex == (SkillComponent.SkillIndexType).BigSkill and (self._world)._powerAccumulateState == ((self._world).PowerAccumulateStateType).Filling
                    -- DECOMPILER ERROR at PC398: Confused about usage of register: R30 in 'UnsetPending'

                    if canAccmulate then
                      (self._world)._accumulatePower = (self._world)._accumulatePower + 1
                      ;
                      ((self._protocolUtility).SendSBreakOutPowerNumber)(self._world)
                    end
                  end
                end
                if ((self._utility).SkillIsHasPowerExpended)(currentEntitySkillID) and HasTarget and (entity:GetComponent(TypeComponent))._summonName ~= "partner" and (entity:GetComponent(SkillComponent))._isCostPower and not ((self._dataUtility).cMonsterCfgTable)[(entity:GetComponent(TypeComponent))._roleID] then
                  ((self._utility).RecorderPowerCost)(self._world, currentEntitySkillID, entity)
                  if (entity:GetComponent(TypeComponent))._camp == (TypeComponent.CampType).Left then
                    ((self._protocolUtility).SendPowerCostProtocol)(self._world, currentEntitySkillID, entity)
                  end
                end
                if skillComponentInstance._isClickUseSkill then
                  ((self._utility).ClearSkillCurrentTime)(entity, beforeRateOrChangeOriginalSkillId)
                  local StateType = {notInCD = 0, inCD = 1}
                  ;
                  ((self._protocolUtility).SendActiveSkillStateChange)(entity._entityId, beforeRateOrChangeOriginalSkillId, StateType.inCD, self._world)
                  ;
                  ((self._utility).PlayRoleSkillVoice)(entity, beforeRateOrChangeOriginalSkillId, self._world)
                end
                if currentEntitySkillID == 201013 then
                  local ifIgnorePriority = {No = 0, Yes = 1}
                  ;
                  ((self._protocolUtility).SendBattlerPlayAnimationByNameProtocol)(entity, ((self._utility).GetSkillActionAtkAnimation)(currentEntitySkillID), ifIgnorePriority.No, self._world)
                  ;
                  ((self._protocolUtility).SendPlayAudio)(105, 1, self._world)
                  ;
                  ((self._protocolUtility).SendSkillStart)(201013, self._world)
                  ;
                  ((self._buffUtility).SetBuffListToOwnCampEntityBySkillID)(entity, entity, currentEntitySkillID, self._world)
                elseif ((self._utility).IsYingXiSkill)(currentEntitySkillID) then
                  if (table.nums)(hittedEntityList) == 0 then
                    return 
                  end
                  ;
                  ((self._buffUtility).SetBuffListToOwnCampEntityBySkillID)(entity, entity, currentEntitySkillID, self._world)
                  ;
                  (self._world):CreateSkillEntity(currentEntitySkillID, entity._entityId, 0, hittedEntityList)
                elseif ((self._utility).IsSkillHas10006Buff)(currentEntitySkillID) then
                  (self._world):CreateSkillEntity(currentEntitySkillID, entity._entityId, 0)
                elseif ((self._utility).IsYuZiZhaoHuan)(currentEntitySkillID) then
                  local component = entity:GetComponent(SummonDataComponent)
                  if component then
                    local buffdata = {}
                    local lengs = (table.nums)(component._yuziSummonData)
                    if lengs == 3 then
                      local monsteridTable = (string.split)((((self._dataUtility).cBattleConstCfgTable)[71]).attr, ";")
                      local random = ((self._world)._randomPcg)(1, 3)
                      local monsterid = tonumber(monsteridTable[random])
                      if monsterid and (component._yuziSummonData)[monsterid] then
                        local summon = nil
                        for i,e in ipairs((self._world)._entitys) do
                          if e._entityId == (component._yuziSummonData)[monsterid] then
                            summon = e
                            break
                          end
                        end
                        if summon then
                          ((self._utility).ChangeEntityCurrentHp)(summon, (summon:GetComponent(HpComponent))._maxHp)
                          local protocol = (BattleClientProtocolManager.CreateProtocol)("action.supdateroleattribute")
                          protocol.entityid = (component._yuziSummonData)[monsterid]
                          local hpComponent = summon:GetComponent(HpComponent)
                          -- DECOMPILER ERROR at PC633: Confused about usage of register: R33 in 'UnsetPending'

                          ;
                          (protocol.attribute).hp = (fixedpoint.tonumber)(hpComponent._maxHp)
                          -- DECOMPILER ERROR at PC639: Confused about usage of register: R33 in 'UnsetPending'

                          ;
                          (protocol.attribute).hpmax = (fixedpoint.tonumber)(hpComponent._maxHp)
                          ;
                          (self._world):InsertViewProtocolData(protocol)
                        end
                      end
                    else
                      local monsteridTable = (string.split)((((self._dataUtility).cBattleConstCfgTable)[71]).attr, ";")
                      local random = ((self._world)._randomPcg)(1, 3)
                      local monsterid = tonumber(monsteridTable[random])
                      if monsterid and (component._yuziSummonData)[monsterid] then
                        for _,v in ipairs(monsteridTable) do
                          if not (component._yuziSummonData)[tonumber(v)] then
                            monsterid = tonumber(v)
                            break
                          end
                        end
                      end
                      local ourlist = ((self._buffUtility).GetSKillBuffList)(currentEntitySkillID)
                      for _,v in ipairs(ourlist) do
                        if (string.find)(v.buffvalues, monsterid) then
                          buffdata.buffid = tonumber(v.buffid)
                          buffdata.buffvalues = v.buffvalues
                        end
                      end
                      local summonEntity = (self._world):CreateLeftPlayerSummon({name = "yuzi", monsterid = monsterid, buffdata = buffdata, skillid = currentEntitySkillID, useskillentityid = entity._entityId})
                      -- DECOMPILER ERROR at PC720: Confused about usage of register: R32 in 'UnsetPending'

                      ;
                      (component._yuziSummonData)[monsterid] = summonEntity._entityId
                      ;
                      (summonEntity:GetComponent(TypeComponent))._summonFatherEntityid = entity._entityId
                    end
                  end
                else
                  local recordIndex = 0
                  for _,v in ipairs(hittedEntityList) do
                    recordIndex = recordIndex + 1
                    if not ((self._utility).IsRouGuang)(currentEntitySkillID) then
                      if ((self._utility).IsYeRenBiaoJi)(currentEntitySkillID) then
                        ((self._buffUtility).SetBuffListToEnemyCampEntityBySkillID)(v, entity, currentEntitySkillID, self._world, 0)
                      else
                        (self._world):CreateSkillEntity(currentEntitySkillID, entity._entityId, recordIndex, hittedEntityList)
                      end
                    end
                  end
                  if not ((self._utility).IsSkillHasNoColliderEffect)(currentEntitySkillID) and not ((self._utility).IsMoLiZhenDang)(currentEntitySkillID) then
                    local ourBuffEntityList = ((self._utility).GetSkillOurCampEntityList)(currentEntitySkillID, entity._entityId, self._world)
                    if ourBuffEntityList then
                      for _,v in ipairs(ourBuffEntityList) do
                        if (self._world):GetCampWinState() == "" then
                          ((self._buffUtility).SetBuffListToOwnCampEntityBySkillID)(v, entity, currentEntitySkillID, self._world)
                        end
                      end
                    end
                  end
                  if (currentEntitySkillID == 201024 or currentEntitySkillID == 201066 or currentEntitySkillID == 201278) and ((self._animationUtility).IsNeedResetEntityAnimationEventComponentIsInChangePosition)(entity) and hittedEntityList[1] and not ((self._utility).IsRoleDead)(hittedEntityList[1]) then
                    ((self._animationUtility).IntegrateChangePositionData)(entity, "attackmove", hittedEntityList[1])
                  end
                  if ((self._utility).IsShiBuKeDang)(currentEntitySkillID) then
                    ((self._animationUtility).IntegrateChangePositionData)(entity, "char015magic")
                  end
                  if (table.nums)(hittedEntityList) ~= 0 and ((self._utility).IsNeedPlayPerformSkillAnimation)(currentEntitySkillID) then
                    local ifIgnorePriority = {No = 0, Yes = 1}
                    ;
                    ((self._protocolUtility).SendBattlerPlayAnimationByNameProtocol)(entity, ((self._utility).GetSkillActionAtkAnimation)(currentEntitySkillID), ifIgnorePriority.No, self._world)
                  end
                end
                if currentEntitySkillID == 201015 and ((self._buffUtility).IsHasCurrentBuff)(entity, 20014) then
                  ((self._protocolUtility).SendSkillEnd)(201013, self._world)
                  ;
                  ((self._buffUtility).SetEntityBuffEffectState)(entity, 20014, false)
                  ;
                  ((self._buffUtility).RemoveEntityBuff)(entity, 20014)
                end
                if ((self._utility).SkillIsHasPowerExpended)(currentEntitySkillID) and (entity:GetComponent(TypeComponent))._summonName ~= "partner" and (entity:GetComponent(SkillComponent))._isCostPower then
                  local camp = (entity:GetComponent(TypeComponent))._camp
                  if camp == (TypeComponent.CampType).Left then
                    for _,v in ipairs((self._world)._leftPlayerList) do
                      local skillList = ((self._buffUtility).IsHasTriggerBuffWhenParnterUseSkillCostPower)(v, (self._world)._randomPcg)
                      for _,skillStruct in ipairs(skillList) do
                        ((self._utility).SetSkillComponnetPassiveSkillList)(v, skillStruct, v)
                      end
                    end
                  end
                end
                skillComponentInstance._skillId = 0
                skillComponentInstance._isClickUseSkill = false
                ;
                ((self._utility).JudgeIfCanUseCoordinatedSkill)(entity, beforeRateOrChangeOriginalSkillId, self._world)
                ;
                ((self._utility).SetSkillIsCostPowerState)(entity, true)
                do
                  local cskillcameramoverecord = ((self._dataUtility).cSkillCameraMoveTable)[currentEntitySkillID]
                  if cskillcameramoverecord and cskillcameramoverecord.CameraMoveType ~= 0 then
                    ((self._protocolUtility).SendPlayBattleCameraAnimationName)(cskillcameramoverecord.CameraMoveType, cskillcameramoverecord.CameraMoveDelay, cskillcameramoverecord.CameraResetDelay, currentEntitySkillID, self._world)
                  end
                  local removeList = {}
                  for index = #skillComponentInstance._passiveSkillList, 1, -1 do
                    local pSkillStruct = (skillComponentInstance._passiveSkillList)[index]
                    local skillid = pSkillStruct.id
                    if (entity:GetComponent(TypeComponent))._camp == (TypeComponent.CampType).Left then
                      for _,v in ipairs(skillComponentInstance._skillList) do
                        local canAccmulate = v.skillId == skillid and v.activeSkillIndex == (SkillComponent.SkillIndexType).BigSkill and (self._world)._powerAccumulateState == ((self._world).PowerAccumulateStateType).Filling
                        -- DECOMPILER ERROR at PC1014: Confused about usage of register: R27 in 'UnsetPending'

                        if canAccmulate then
                          (self._world)._accumulatePower = (self._world)._accumulatePower + 1
                          ;
                          ((self._protocolUtility).SendSBreakOutPowerNumber)(self._world)
                        end
                      end
                    end
                    local isHasRateSkill, rateSkillId = ((self._utility).IsHasRateSkill)(self._world, skillid, {skillComponentA = skillComponentInstance, typeComponentA = typeComponentInstance})
                    if isHasRateSkill then
                      skillid = rateSkillId
                    end
                    skillid = ((self._buffUtility).GetBuffChangeSKillID)(entity, skillid, self._world)
                    if skillid == 201586 then
                      local bluePowerGridNum = ((self._dataUtility).GetPowerGridFunc)((self._world)._bluePower, ((self._dataUtility).PowerType).Blue)
                      if bluePowerGridNum >= 2 then
                        local getChaosPowerValue = bluePowerGridNum - 2
                        skillComponentInstance._bossComboNumber = fixedpoint(getChaosPowerValue)
                        ;
                        (self._world):AddBluePower(-getChaosPowerValue)
                      end
                    end
                    local usePassiveSkill = true
                    if ((self._utility).IsRoleDead)(entity) and not pSkillStruct.isRoleDeadAlsoCanUsePassiveSkill then
                      LogInfoFormat("AnimationSystem", "entityid %s roleid %s is dead, passiveskillid %s dont use", entity._entityId, (entity:GetComponent(TypeComponent))._roleID, skillid)
                      usePassiveSkill = false
                    end
                    if usePassiveSkill then
                      local isAttackSkill = ((self._utility).IsAttackSkill)(skillid)
                      local judgeResult = (entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInSkillWithEndTime
                      if isAttackSkill and judgeResult then
                        LogInfoFormat("AnimationSystem", "连携的 普通攻击(effecttype 1) %s 被 其他非普通攻击技能(effecttype not 1) 抵消，释放失败", skillid)
                        return 
                      end
                      do
                        if ((self._utility).IsNeedPlayPerformSkillAnimation)(skillid) and ((self._utility).IsPassiveSkill)(skillid) then
                          local ifIgnorePriority = {No = 0, Yes = 1}
                          ;
                          ((self._protocolUtility).SendBattlerPlayAnimationByNameProtocol)(entity, ((self._utility).GetSkillActionAtkAnimation)(skillid), ifIgnorePriority.No, self._world)
                        end
                        local hittedEntityList = ((self._utility).GetSkillEffectEntity)(skillid, entity._entityId, self._world)
                        local recordIndex = 0
                        do
                          do
                            local hasEffect = false
                            for _,v in ipairs(hittedEntityList) do
                              recordIndex = recordIndex + 1
                              hasEffect = (self._world):CreateSkillEntity(skillid, entity._entityId, recordIndex, hittedEntityList)
                            end
                            if not hasEffect then
                              LogInfoFormat("AnimationSystem", "连携技能 skillid %s 直接加buff", skillid)
                              local ourBuffEntityList = ((self._utility).GetSkillOurCampEntityList)(skillid, entity._entityId, self._world)
                              if ourBuffEntityList then
                                for _,v in ipairs(ourBuffEntityList) do
                                  if (self._world):GetCampWinState() == "" then
                                    ((self._buffUtility).SetBuffListToOwnCampEntityBySkillID)(v, entity, skillid, self._world)
                                  end
                                end
                                local campType = {AttackOrderToEmery = 1, AttackOrderToOur = 2}
                                if #ourBuffEntityList == 0 and ((self._utility).IfSkillTargetIsPassiveSkillTarget)(skillid, campType.AttackOrderToOur) and (self._world):GetCampWinState() == "" then
                                  ((self._buffUtility).SetBuffListToOwnCampEntityBySkillID)(pSkillStruct.target, entity, skillid, self._world)
                                end
                              end
                              local _, enermy = ((self._buffUtility).GetSKillBuffList)(skillid)
                              if (table.nums)(enermy) > 0 then
                                local hittedEntityList = ((self._utility).GetSkillEffectEntity)(skillid, entity._entityId, self._world)
                                for _,v in ipairs(hittedEntityList) do
                                  ((self._buffUtility).SetBuffListToEnemyCampEntityBySkillID)(v, entity, skillid, self._world, 0)
                                end
                                local campType = {AttackOrderToEmery = 1, AttackOrderToOur = 2}
                                if #hittedEntityList == 0 and ((self._utility).IfSkillTargetIsPassiveSkillTarget)(skillid, campType.AttackOrderToEmery) then
                                  ((self._buffUtility).SetBuffListToEnemyCampEntityBySkillID)(pSkillStruct.target, entity, skillid, self._world, 0)
                                end
                              end
                            else
                              LogInfoFormat("AnimationSystem", "连携技能 skillid %s 创建entity", skillid)
                            end
                            ;
                            (table.insert)(removeList, index)
                            -- DECOMPILER ERROR at PC1271: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC1271: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC1271: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC1271: LeaveBlock: unexpected jumping out IF_STMT

                          end
                        end
                      end
                    end
                  end
                  for _,index in ipairs(removeList) do
                    (table.remove)(skillComponentInstance._passiveSkillList, index)
                  end
                  -- DECOMPILER ERROR at PC1283: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC1283: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC1283: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC1283: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC1283: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC1283: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC1283: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC1283: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC1283: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC1283: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR: 58 unprocessed JMP targets
end

return AnimationSystem

