-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/utility/protocolutility.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolUtility = {}
ProtocolUtility.SendRoleSkillPowerReduce = function(entityid, order, chaos, battleWorld)
  -- function num : 0_0 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.supdateroleskillpowerreduce")
  protocol.entityid = entityid
  protocol.order = (fixedpoint.tonumber)(order)
  protocol.chaos = (fixedpoint.tonumber)(chaos)
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendDestroyEffectByName = function(camp, effectname, battleWorld)
  -- function num : 0_1 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sdestroyeffectbyname")
  protocol.camp = camp
  protocol.effectname = effectname
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendRoleCreate = function(entityid, type, attribute, buffs, isInitial, battleWorld)
  -- function num : 0_2 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.srolecreate")
  protocol.entityid = entityid
  protocol.type = type
  protocol.attribute = attribute
  protocol.buffs = buffs
  protocol.isinitial = isInitial or 0
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendBossEnterViolent = function(battleWorld)
  -- function num : 0_3 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sbossenterviolent")
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendPowerCostProtocol = function(battleWorld, skillid, entity)
  -- function num : 0_4 , upvalues : _ENV
  local skillConfig = (((BattleECS.Utility).DataUtility).cSkillCostTable)[skillid]
  if skillConfig then
    local skillComponent = entity:GetComponent((BattleECS.Components).SkillComponent)
    local redCost = skillConfig.OrderCost
    local blueCost = skillConfig.ChaosCost
    ;
    (((BattleECS.Utility).Utility).SetEntitySkillComponentCostPower)(entity, skillid, redCost, blueCost)
    do
      if skillConfig.pureCost ~= "" then
        local record = {}
        record.skillComponentB = skillComponent
        record.skillComponentA = skillComponent
        record.world = battleWorld
        record.formulaString = skillConfig.pureCost
        record.skillid = skillid
        record.camp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
        redCost = (((BattleECS.Utility).BuffUtility).NewAnalysisFormulaPowerCost)(record)
        ;
        (((BattleECS.Utility).Utility).SetEntitySkillComponentCostPower)(entity, skillid, redCost, blueCost)
      end
      local buffComponent = entity:GetComponent((BattleECS.Components).BuffComponent)
      local red = (fixedpoint.max)(redCost, 0) * fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[1]).attr)
      local blue = (fixedpoint.max)(blueCost, 0) * fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[2]).attr)
      local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sskillpowercost")
      protocol.entityid = entity._entityId
      protocol.skillid = skillid
      protocol.redchange = (fixedpoint.tonumber)(red)
      local redcurrent = (fixedpoint.max)(battleWorld._redPower - red, 0)
      protocol.redcurrent = (fixedpoint.tonumber)(redcurrent)
      battleWorld._redPower = redcurrent
      protocol.bluechange = (fixedpoint.tonumber)(blue)
      local bluecurrent = (fixedpoint.max)(battleWorld._bluePower - blue, 0)
      protocol.bluecurrent = (fixedpoint.tonumber)(bluecurrent)
      protocol.breakoutPower = battleWorld._accumulatePower
      protocol.breakoutPowerMax = battleWorld._accumulatePowerMax
      battleWorld._bluePower = bluecurrent
      battleWorld:InsertViewProtocolData(protocol)
      -- DECOMPILER ERROR at PC139: Confused about usage of register: R13 in 'UnsetPending'

      ;
      (buffComponent._isPowerCost).Order = false
      -- DECOMPILER ERROR at PC141: Confused about usage of register: R13 in 'UnsetPending'

      ;
      (buffComponent._isPowerCost).Chaos = false
      -- DECOMPILER ERROR at PC148: Confused about usage of register: R13 in 'UnsetPending'

      if red and red ~= fixedpoint_zero then
        (buffComponent._isPowerCost).Order = true
      end
      -- DECOMPILER ERROR at PC155: Confused about usage of register: R13 in 'UnsetPending'

      if blue and blue ~= fixedpoint_zero then
        (buffComponent._isPowerCost).Chaos = true
      end
      battleWorld._bluePower = battleWorld._bluePower + red
      battleWorld._bluePower = (math.min)(battleWorld._bluePower, battleWorld._bluePowerMax)
    end
  end
end

ProtocolUtility.IsSendRoleDeadAndDeleteBox2DPhysics = function(entity, damageFrom, damageNum, battleWorld)
  -- function num : 0_5 , upvalues : _ENV, ProtocolUtility
  if (entity:GetComponent((BattleECS.Components).HpComponent))._currentHp <= 0 then
    local damageFromEntity = nil
    for i,e in ipairs(battleWorld._entitys) do
      if e._entityId == damageFrom then
        damageFromEntity = e
        break
      end
    end
    do
      local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenRoleAttackToEnermyDead)(damageFromEntity)
      for _,v in ipairs(skillList) do
        (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(damageFromEntity, v, damageFromEntity)
      end
      local camp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
      if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
        for _,v in ipairs(battleWorld._leftPlayerList) do
          if entity._entityId ~= v._entityId then
            local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenPartnerDead)(v, battleWorld._randomPcg)
            for _,skillStruct in ipairs(skillList) do
              (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(v, skillStruct, v)
            end
          end
        end
      else
        do
          if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
            for _,v in ipairs(battleWorld._rightPlayerList) do
              if entity._entityId ~= v._entityId then
                local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenPartnerDead)(v, battleWorld._randomPcg)
                for _,skillStruct in ipairs(skillList) do
                  (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(v, skillStruct, v)
                end
              end
            end
          end
          do
            skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenRoleDead)(entity, battleWorld._randomPcg)
            local revived = false
            for _,skillStruct in ipairs(skillList) do
              if (((BattleECS.Utility).BuffUtility).IsSkillHasReviveBuff)(skillStruct.skillid) and not revived then
                if skillStruct.skillid == 512013 or skillStruct.skillid == 512014 then
                  local camp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
                  if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                    for _,v in ipairs(battleWorld._leftPlayerList) do
                      (((BattleECS.Utility).BuffUtility).SetBuffListToOwnCampEntityBySkillID)(v, entity, 512015, battleWorld)
                    end
                  else
                    do
                      if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                        for _,v in ipairs(battleWorld._rightPlayerList) do
                          (((BattleECS.Utility).BuffUtility).SetBuffListToOwnCampEntityBySkillID)(v, entity, 512015, battleWorld)
                        end
                      end
                      do
                        ;
                        (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(entity, skillStruct, entity, true)
                        revived = true
                        local flag, buffconfig = (((BattleECS.Utility).BuffUtility).IsSkillHasPowerChangeOnceBuff)(skillStruct.skillid)
                        if flag then
                          for _,v in ipairs((string.split)(buffconfig.buffvalues, ";")) do
                            local record = (string.split)(v, "=")
                            if record[1] == "orderpwr_value" then
                              battleWorld:AddRedPower(tonumber(record[2]))
                            else
                              if record[1] == "chaospwr_value" then
                                battleWorld:AddBluePower(tonumber(record[2]))
                              end
                            end
                          end
                        else
                          do
                            do
                              ;
                              (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(entity, skillStruct, entity, true)
                              -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_THEN_STMT

                              -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_THEN_STMT

                              -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_STMT

                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
            if revived then
              return 
            end
            ;
            (((BattleECS.Utility).PhysicsUtility).SetEntityPhyscisComponentAwake)(entity, false)
            ;
            (((BattleECS.Utility).Utility).RoleDeadClearComponentData)(entity)
            ;
            (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({entity = entity, enermyentity = damageFromEntity, buffid = 20000, buffparamter = "time=999999999", skillid = 0, battleworld = battleWorld})
            ;
            (((BattleECS.Utility).BuffUtility).ClearDeadEntityBuff)(entity)
            for _,v in ipairs(battleWorld._leftPlayerSummonList) do
              if (v:GetComponent((BattleECS.Components).TypeComponent))._summonName ~= "buff" and v._entityId == entity._entityId then
                (v:GetComponent((BattleECS.Components).TypeComponent))._isNeedDestroy = true
                ;
                (v:GetComponent((BattleECS.Components).PhysicsComponent))._isNeedReleaseBox = true
              end
            end
            for _,v in ipairs(battleWorld._rightPlayerSummonList) do
              if (v:GetComponent((BattleECS.Components).TypeComponent))._summonName ~= "buff" and v._entityId == entity._entityId then
                (v:GetComponent((BattleECS.Components).TypeComponent))._isNeedDestroy = true
                ;
                (v:GetComponent((BattleECS.Components).PhysicsComponent))._isNeedReleaseBox = true
              end
            end
            for _,v in ipairs(battleWorld._playerSkillEffectEntityList) do
              if v._entityId == entity._entityId then
                (v:GetComponent((BattleECS.Components).TypeComponent))._isNeedDestroy = true
                ;
                (v:GetComponent((BattleECS.Components).PhysicsComponent))._isNeedReleaseBox = true
              end
            end
            if (entity:GetComponent((BattleECS.Components).TypeComponent))._summonName == "yuzi" then
              local fatherEntity = nil
              for i,e in ipairs(battleWorld._entitys) do
                if e._entityId == (entity:GetComponent((BattleECS.Components).TypeComponent))._summonFatherEntityid then
                  fatherEntity = e
                  break
                end
              end
              do
                do
                  -- DECOMPILER ERROR at PC422: Confused about usage of register: R9 in 'UnsetPending'

                  if fatherEntity then
                    ((fatherEntity:GetComponent((BattleECS.Components).SummonDataComponent))._yuziSummonData)[(entity:GetComponent((BattleECS.Components).TypeComponent))._roleID] = nil
                  end
                  if (entity:GetComponent((BattleECS.Components).TypeComponent))._summonName == "buff" then
                    local fatherEntity = nil
                    for i,e in ipairs(battleWorld._entitys) do
                      if e._entityId == (entity:GetComponent((BattleECS.Components).TypeComponent))._summonFatherEntityid then
                        fatherEntity = e
                        break
                      end
                    end
                    do
                      if fatherEntity then
                        local fatherSummonData = (fatherEntity:GetComponent((BattleECS.Components).SummonDataComponent))._summonBuffData
                        local removeList = {}
                        for i = #fatherSummonData, 1, -1 do
                          local data = fatherSummonData[i]
                          if data.summonEntityId == entity._entityId then
                            local buffComponent = fatherEntity:GetComponent((BattleECS.Components).BuffComponent)
                            if buffComponent then
                              for i = #buffComponent._buffList, 1, -1 do
                                local v = (buffComponent._buffList)[i]
                                if v.buffId == data.buffId then
                                  (v.buffObj):Destroy()
                                  ;
                                  (table.remove)(buffComponent._buffList, i)
                                  break
                                end
                              end
                            end
                            do
                              do
                                ;
                                (table.insert)(removeList, i)
                                -- DECOMPILER ERROR at PC501: LeaveBlock: unexpected jumping out DO_STMT

                                -- DECOMPILER ERROR at PC501: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                -- DECOMPILER ERROR at PC501: LeaveBlock: unexpected jumping out IF_STMT

                              end
                            end
                          end
                        end
                        for _,i in ipairs(removeList) do
                          (table.remove)(fatherSummonData, i)
                        end
                      end
                      do
                        local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sroledead")
                        protocol.entityId = entity._entityId
                        protocol.damageFrom = damageFrom
                        battleWorld._lastDamageRoleId = (damageFromEntity:GetComponent((BattleECS.Components).TypeComponent))._roleID
                        protocol.damageNum = (fixedpoint.tonumber)(damageNum)
                        ;
                        (ProtocolUtility.SendPlayBattleVoice)((entity:GetComponent((BattleECS.Components).TypeComponent))._roleID, (((BattleECS.Utility).DataUtility).VoiceType).Attacked, nil, battleWorld)
                        LogInfoFormat("ProtocolUtility", "deadentityid:%s", entity._entityId)
                        battleWorld:InsertViewProtocolData(protocol)
                        local component = entity:GetComponent((BattleECS.Components).SummonDataComponent)
                        do
                          if component and component._alternateFighter then
                            local initialTagType = {Not = 0, Is = 1}
                            if (component._alternateFighter).camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                              LogInfoFormat("ProtocolUtility", "left alternate fighter role id : %s", (component._alternateFighter).id)
                              battleWorld:CreateLeftPlayer(component._alternateFighter, {isInitial = initialTagType.Is})
                              ;
                              (ProtocolUtility.SendPlayBattleVoice)((component._alternateFighter).id, (((BattleECS.Utility).DataUtility).VoiceType).BattleStart, nil, battleWorld)
                            end
                            if (component._alternateFighter).camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                              LogInfoFormat("ProtocolUtility", "right alternate fighter role id : %s", (component._alternateFighter).id)
                              battleWorld:CreateRightPlayer(component._alternateFighter, {isInitial = initialTagType.Is})
                            end
                          end
                          do return true end
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

ProtocolUtility.SendCreateBuffEffectProtocol = function(entity, point, packagename, effectname, rad, battleWorld)
  -- function num : 0_6 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.screatebuffeffect")
  protocol.entityid = entity._entityId
  protocol.point = point
  protocol.packagename = packagename
  protocol.effectname = effectname
  if rad then
    if (fixedpoint.judgetype)(rad) then
      rad = (fixedpoint.tonumber)(rad)
    end
    protocol.rad = (math.floor)(rad * 1000)
  else
    protocol.rad = 0
  end
  if (entity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
    protocol.isImaged = 1
  else
    protocol.isImaged = 0
  end
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendDestroyBuffEffectProtocol = function(entityid, point, effectname, battleWorld)
  -- function num : 0_7 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sdestroybuffeffect")
  protocol.entityid = entityid
  protocol.point = point
  protocol.effectname = effectname
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendBattlerPlayAnimationByNameProtocol = function(entity, name, ignorePriority, battleWorld)
  -- function num : 0_8 , upvalues : _ENV
  if entity:GetComponent((BattleECS.Components).FlySkillDataComponent) then
    return 
  end
  if name == "" then
    return 
  end
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sbattlerplayanimationbyname")
  protocol.entityid = entity._entityId
  protocol.name = name
  protocol.ignorePriority = ignorePriority or 0
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendDamageMissProtocol = function(entityid, damagetype, battleWorld)
  -- function num : 0_9 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sdamagemiss")
  protocol.entityid = entityid
  protocol.damegetype = damagetype
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendFixPointSkillAttackedInfo = function(damageFromEntityID, hittedEntity, skillid, damageNum, isPost, rad, isAnimation, battleWorld, damageType, isPlayAttackedEffect)
  -- function num : 0_10 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.screatefixpointskillattackedinfo")
  protocol.entityId = hittedEntity._entityId
  protocol.skillId = skillid
  protocol.damageFrom = damageFromEntityID
  if (fixedpoint.judgetype)(damageNum) then
    damageNum = (fixedpoint.tonumber)(damageNum)
  end
  protocol.damageNum = (math.floor)(damageNum)
  protocol.type = 2
  protocol.damageType = damageType
  protocol.currentHp = (fixedpoint.tonumber)((hittedEntity:GetComponent((BattleECS.Components).HpComponent))._currentHp)
  if not isPost then
    protocol.isPost = 1
  else
    protocol.isPost = 0
  end
  if (hittedEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
    protocol.isImaged = 1
  else
    protocol.isImaged = 0
  end
  if (fixedpoint.judgetype)(rad) then
    rad = (fixedpoint.tonumber)(rad)
  end
  protocol.rad = (math.floor)(rad * 1000)
  if isAnimation then
    protocol.isPlayHpBarAnimation = 1
  else
    protocol.isPlayHpBarAnimation = 0
  end
  protocol.isPlayAttackedEffect = isPlayAttackedEffect
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendSkillFail = function(entityid, skillid, type, battleWorld)
  -- function num : 0_11 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sskillfail")
  protocol.entityid = entityid
  protocol.skillid = skillid
  protocol.type = type
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendSkillStart = function(skillid, battleWorld)
  -- function num : 0_12 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sskillstart")
  protocol.skillid = skillid
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendSkillEnd = function(skillid, battleWorld)
  -- function num : 0_13 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sskillend")
  protocol.skillid = skillid
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SCreateSceneEffect = function(effectid, posx, posy, rad, camp, battleWorld, posZ)
  -- function num : 0_14 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.screatesceneeffect")
  protocol.effectid = effectid
  protocol.posX = (fixedpoint.tonumber)(posx)
  protocol.posY = (fixedpoint.tonumber)(posy)
  protocol.posZ = 0
  if posZ and (fixedpoint.judgetype)(posZ) then
    posZ = (fixedpoint.tonumber)(posZ)
  end
  protocol.posZ = posZ
  if (fixedpoint.judgetype)(rad) then
    rad = (fixedpoint.tonumber)(rad)
  end
  protocol.rad = rad
  protocol.camp = camp
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendBattlePowerShow = function(redMax, redCu, blueMax, blueCu, battleWorld)
  -- function num : 0_15 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sbattleworldpowershow")
  protocol.redMaxPower = (fixedpoint.tonumber)(redMax)
  protocol.redCurrentPower = (fixedpoint.tonumber)(redCu)
  protocol.blueMaxPower = (fixedpoint.tonumber)(blueMax)
  protocol.blueCurrentPower = (fixedpoint.tonumber)(blueCu)
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendBattleEnd = function(type, isjoin, battleWorld)
  -- function num : 0_16 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sbattleend")
  protocol.type = type
  protocol.isjoin = isjoin
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendBattleResult = function(battleresult, isjoin, battleWorld)
  -- function num : 0_17 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sbattleresult")
  protocol.type = battleresult
  protocol.isjoin = isjoin
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendFlySkill = function(entityid, x, y, z, effectid, playerentityid, rad, isimaged, battleWorld)
  -- function num : 0_18 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.screateflyskill")
  protocol.entityId = entityid
  protocol.posX = (fixedpoint.tonumber)(x)
  protocol.posY = (fixedpoint.tonumber)(y)
  protocol.posZ = (fixedpoint.tonumber)(z)
  protocol.effectid = effectid
  protocol.playerEntityId = playerentityid
  if (fixedpoint.judgetype)(rad) then
    rad = (fixedpoint.tonumber)(rad)
  end
  protocol.rad = rad
  protocol.isImaged = isimaged
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendUseSkill = function(skillid, entityid, isImaged, camp, battleWorld)
  -- function num : 0_19 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.suseskill")
  protocol.skillid = skillid
  protocol.entityid = entityid
  protocol.isImaged = isImaged
  protocol.camp = camp
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendChangeEntityHpCellVisible = function(entityid, visible, spritevisible, battleWorld)
  -- function num : 0_20 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.schangeentityhpcellvisible")
  protocol.entityid = entityid
  protocol.visible = visible
  protocol.spritevisible = spritevisible
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendUpdateRoleBuffs = function(entityid, buffid, time, battleWorld, stackTime)
  -- function num : 0_21 , upvalues : _ENV
  if (((BattleECS.Utility).DataUtility).cIBuffCfgTable)[buffid] then
    return 
  end
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.supdaterolebuffs")
  protocol.entityid = entityid
  protocol.buffid = buffid
  protocol.counttime = time
  protocol.stacklayer = stackTime or -1
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendSkillBegin = function(entityid, skillid, battleWorld)
  -- function num : 0_22 , upvalues : _ENV
  local record = (((BattleECS.Utility).DataUtility).cskillTable)[skillid]
  local type = record.spellType
  local lasttime = record.spellTime
  local skillAttr = record.attr
  local SkillShowCountDownType = {NotLoad = 0, LoadInterrupt = 1, ContinualInterrupt = 2, InfiniteInterrupt = 3, LoadNotInterrupt = 4, ContinualNotInterrupt = 5, InfiniteNotInterrupt = 6}
  if type == SkillShowCountDownType.NotLoad then
    return 
  end
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sskillbegin")
  protocol.entityid = entityid
  protocol.skillid = skillid
  protocol.type = type
  protocol.lasttime = lasttime
  protocol.skillattr = skillAttr
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendSkillInterrupted = function(entityid, skillid, battleWorld)
  -- function num : 0_23 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sskillinterrupted")
  protocol.entityid = entityid
  protocol.skillid = skillid
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendInvincibleStateChange = function(entityid, state, battleWorld)
  -- function num : 0_24 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sinvinciblestatechange")
  protocol.entityid = entityid
  protocol.state = state
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendShieldValueChange = function(entityid, buffId, shieldType, value, battleWorld)
  -- function num : 0_25 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sshieldvaluechange")
  protocol.entityid = entityid
  protocol.buffid = buffId
  protocol.shieldtype = shieldType
  if (fixedpoint.judgetype)(value) then
    value = (fixedpoint.tonumber)(value)
  end
  protocol.value = value
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendBossIsInWeakState = function(battleWorld)
  -- function num : 0_26 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sbossisinweakstate")
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendAccumulatePowerStateChange = function(state, battleWorld)
  -- function num : 0_27 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.saccumulatepowerstatechange")
  protocol.state = state
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendCollaborativeSkillNumChange = function(num, entityid, battleWorld)
  -- function num : 0_28 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.scollaborativeskillnumchange")
  protocol.num = (fixedpoint.tonumber)(num)
  protocol.entityid = entityid
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendSetClipRectForShiKongZhiMen = function(entityId, w, h, camp, effectName, battleWorld, clipState)
  -- function num : 0_29 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.ssetcliprectforshikongzhimen")
  protocol.entityid = entityId
  protocol.w = w
  protocol.h = h
  protocol.camp = camp
  protocol.objectname = effectName
  protocol.clipstate = tostring(clipState)
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendActiveSkillStateChange = function(entityId, skillId, isInCD, battleWorld)
  -- function num : 0_30 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sactiveskillstatechange")
  protocol.entityid = entityId
  protocol.skillid = skillId
  protocol.isInCD = isInCD
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendActorTimeSkillState = function(state, battleWorld)
  -- function num : 0_31 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sactortimeskillstate")
  protocol.state = state
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendPlayBattleVoice = function(roleId, voiceType, index, battleWorld)
  -- function num : 0_32 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.splaybattlevoice")
  protocol.roleId = roleId
  protocol.voiceType = voiceType
  protocol.index = index or -1
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendPlayAudio = function(audioId, audioValue, battleWorld)
  -- function num : 0_33 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.splayaudio")
  protocol.audioid = audioId
  protocol.audiovalue = audioValue
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendChangeAnimatorState = function(animatorType, param, value, battleWorld)
  -- function num : 0_34 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.schangeanimatorstate")
  protocol.animatorType = animatorType
  protocol.param = param
  protocol.value = value
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.ChangeEntityNameTextId = function(entityId, nameTextId, battleWorld)
  -- function num : 0_35 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.schangeentityname")
  protocol.entityId = entityId
  protocol.nameTextId = nameTextId
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendPlayBattleCameraAnimationName = function(cameraMoveType, moveDelayTime, resetDelayTime, skillId, battleWorld)
  -- function num : 0_36 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.splaybattlecameraanimationname")
  protocol.cameraMoveType = cameraMoveType
  protocol.moveDelayTime = moveDelayTime
  protocol.resetDelayTime = resetDelayTime
  protocol.skillId = skillId
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendShowOrderPowerSpecialUIEffect = function(effectType, powerIndex, battleWorld)
  -- function num : 0_37 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sshoworderpowerspecialuieffect")
  protocol.effectType = effectType
  protocol.powerGridIndex = powerIndex
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendSActionWithActiveSkill = function(entityId, enermyEntityId, skillId, battleWorld)
  -- function num : 0_38 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sactionwithactiveskill")
  protocol.entityId = entityId
  protocol.skillId = skillId
  protocol.enermyEntityId = enermyEntityId
  battleWorld:InsertViewProtocolData(protocol)
end

ProtocolUtility.SendSBreakOutPowerNumber = function(battleWorld)
  -- function num : 0_39 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sbreakoutpowernumber")
  protocol.breakoutPower = battleWorld._accumulatePower
  protocol.breakoutPowerMax = battleWorld._accumulatePowerMax
  battleWorld:InsertViewProtocolData(protocol)
end

return ProtocolUtility

