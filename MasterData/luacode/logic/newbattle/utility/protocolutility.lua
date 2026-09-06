local ProtocolUtility = {}

function ProtocolUtility.SendRoleSkillPowerReduce(entityid, order, chaos, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.supdateroleskillpowerreduce")
  protocol.entityid = entityid
  protocol.order = fixedpoint.tonumber(order)
  protocol.chaos = fixedpoint.tonumber(chaos)
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendDestroyEffectByName(camp, effectname, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sdestroyeffectbyname")
  protocol.camp = camp
  protocol.effectname = effectname
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendRoleCreate(entityid, type, attribute, buffs, isInitial, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.srolecreate")
  protocol.entityid = entityid
  protocol.type = type
  protocol.attribute = attribute
  protocol.buffs = buffs
  protocol.isinitial = isInitial or 0
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendBossEnterViolent(battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sbossenterviolent")
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendPowerCostProtocol(battleWorld, skillid, entity)
  local skillConfig = BattleECS.Utility.DataUtility.cSkillCostTable[skillid]
  if skillConfig then
    local skillComponent = entity:GetComponent(BattleECS.Components.SkillComponent)
    local redCost = skillConfig.OrderCost
    local blueCost = skillConfig.ChaosCost
    BattleECS.Utility.Utility.SetEntitySkillComponentCostPower(entity, skillid, redCost, blueCost)
    if skillConfig.pureCost ~= "" then
      local record = {}
      record.skillComponentB = skillComponent
      record.skillComponentA = skillComponent
      record.world = battleWorld
      record.formulaString = skillConfig.pureCost
      record.skillid = skillid
      record.camp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
      redCost, blueCost = BattleECS.Utility.BuffUtility.NewAnalysisFormulaPowerCost(record)
      BattleECS.Utility.Utility.SetEntitySkillComponentCostPower(entity, skillid, redCost, blueCost)
    end
    local buffComponent = entity:GetComponent(BattleECS.Components.BuffComponent)
    local red = fixedpoint.max(redCost, 0) * fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[1].attr)
    local blue = fixedpoint.max(blueCost, 0) * fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[2].attr)
    local protocol = BattleClientProtocolManager.CreateProtocol("action.sskillpowercost")
    protocol.entityid = entity._entityId
    protocol.skillid = skillid
    protocol.redchange = fixedpoint.tonumber(red)
    local redcurrent = fixedpoint.max(battleWorld._redPower - red, 0)
    protocol.redcurrent = fixedpoint.tonumber(redcurrent)
    battleWorld._redPower = redcurrent
    protocol.bluechange = fixedpoint.tonumber(blue)
    local bluecurrent = fixedpoint.max(battleWorld._bluePower - blue, 0)
    protocol.bluecurrent = fixedpoint.tonumber(bluecurrent)
    protocol.breakoutPower = battleWorld._accumulatePower
    protocol.breakoutPowerMax = battleWorld._accumulatePowerMax
    battleWorld._bluePower = bluecurrent
    battleWorld:InsertViewProtocolData(protocol)
    buffComponent._isPowerCost.Order = false
    buffComponent._isPowerCost.Chaos = false
    if red and red ~= fixedpoint_zero then
      buffComponent._isPowerCost.Order = true
    end
    if blue and blue ~= fixedpoint_zero then
      buffComponent._isPowerCost.Chaos = true
    end
    battleWorld._bluePower = battleWorld._bluePower + red
    battleWorld._bluePower = math.min(battleWorld._bluePower, battleWorld._bluePowerMax)
  end
end

function ProtocolUtility.IsSendRoleDeadAndDeleteBox2DPhysics(entity, damageFrom, damageNum, battleWorld)
  if entity:GetComponent(BattleECS.Components.HpComponent)._currentHp <= 0 then
    local damageFromEntity
    for i, e in ipairs(battleWorld._entitys) do
      if e._entityId == damageFrom then
        damageFromEntity = e
        break
      end
    end
    local skillList = BattleECS.Utility.BuffUtility.IsHasTriggerBuffWhenRoleAttackToEnermyDead(damageFromEntity)
    for _, v in ipairs(skillList) do
      BattleECS.Utility.Utility.SetSkillComponnetPassiveSkillList(damageFromEntity, v, damageFromEntity)
    end
    local camp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
    if camp == BattleECS.Components.TypeComponent.CampType.Left then
      for _, v in ipairs(battleWorld._leftPlayerList) do
        if entity._entityId ~= v._entityId then
          local skillList = BattleECS.Utility.BuffUtility.IsHasTriggerBuffWhenPartnerDead(v, battleWorld._randomPcg)
          for _, skillStruct in ipairs(skillList) do
            BattleECS.Utility.Utility.SetSkillComponnetPassiveSkillList(v, skillStruct, v)
          end
        end
      end
    elseif camp == BattleECS.Components.TypeComponent.CampType.Right then
      for _, v in ipairs(battleWorld._rightPlayerList) do
        if entity._entityId ~= v._entityId then
          local skillList = BattleECS.Utility.BuffUtility.IsHasTriggerBuffWhenPartnerDead(v, battleWorld._randomPcg)
          for _, skillStruct in ipairs(skillList) do
            BattleECS.Utility.Utility.SetSkillComponnetPassiveSkillList(v, skillStruct, v)
          end
        end
      end
    end
    skillList = BattleECS.Utility.BuffUtility.IsHasTriggerBuffWhenRoleDead(entity, battleWorld._randomPcg)
    local revived = false
    for _, skillStruct in ipairs(skillList) do
      if BattleECS.Utility.BuffUtility.IsSkillHasReviveBuff(skillStruct.skillid) then
        if not revived then
          if skillStruct.skillid == 512013 or skillStruct.skillid == 512014 then
            local camp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
            if camp == BattleECS.Components.TypeComponent.CampType.Left then
              for _, v in ipairs(battleWorld._leftPlayerList) do
                BattleECS.Utility.BuffUtility.SetBuffListToOwnCampEntityBySkillID(v, entity, 512015, battleWorld)
              end
            elseif camp == BattleECS.Components.TypeComponent.CampType.Right then
              for _, v in ipairs(battleWorld._rightPlayerList) do
                BattleECS.Utility.BuffUtility.SetBuffListToOwnCampEntityBySkillID(v, entity, 512015, battleWorld)
              end
            end
          end
          BattleECS.Utility.Utility.SetSkillComponnetPassiveSkillList(entity, skillStruct, entity, true)
          revived = true
        end
      else
        local flag, buffconfig = BattleECS.Utility.BuffUtility.IsSkillHasPowerChangeOnceBuff(skillStruct.skillid)
        if flag then
          for _, v in ipairs(string.split(buffconfig.buffvalues, ";")) do
            local record = string.split(v, "=")
            if record[1] == "orderpwr_value" then
              battleWorld:AddRedPower(tonumber(record[2]))
            elseif record[1] == "chaospwr_value" then
              battleWorld:AddBluePower(tonumber(record[2]))
            end
          end
        else
          BattleECS.Utility.Utility.SetSkillComponnetPassiveSkillList(entity, skillStruct, entity, true)
        end
      end
    end
    if revived then
      return
    end
    BattleECS.Utility.PhysicsUtility.SetEntityPhyscisComponentAwake(entity, false)
    BattleECS.Utility.Utility.RoleDeadClearComponentData(entity)
    BattleECS.Utility.BuffUtility.InsertEntityDifferentBuff({
      entity = entity,
      enermyentity = damageFromEntity,
      buffid = 20000,
      buffparamter = "time=999999999",
      skillid = 0,
      battleworld = battleWorld
    })
    BattleECS.Utility.BuffUtility.ClearDeadEntityBuff(entity)
    for _, v in ipairs(battleWorld._leftPlayerSummonList) do
      if v:GetComponent(BattleECS.Components.TypeComponent)._summonName ~= "buff" and v._entityId == entity._entityId then
        v:GetComponent(BattleECS.Components.TypeComponent)._isNeedDestroy = true
        v:GetComponent(BattleECS.Components.PhysicsComponent)._isNeedReleaseBox = true
      end
    end
    for _, v in ipairs(battleWorld._rightPlayerSummonList) do
      if v:GetComponent(BattleECS.Components.TypeComponent)._summonName ~= "buff" and v._entityId == entity._entityId then
        v:GetComponent(BattleECS.Components.TypeComponent)._isNeedDestroy = true
        v:GetComponent(BattleECS.Components.PhysicsComponent)._isNeedReleaseBox = true
      end
    end
    for _, v in ipairs(battleWorld._playerSkillEffectEntityList) do
      if v._entityId == entity._entityId then
        v:GetComponent(BattleECS.Components.TypeComponent)._isNeedDestroy = true
        v:GetComponent(BattleECS.Components.PhysicsComponent)._isNeedReleaseBox = true
      end
    end
    if entity:GetComponent(BattleECS.Components.TypeComponent)._summonName == "yuzi" then
      local fatherEntity
      for i, e in ipairs(battleWorld._entitys) do
        if e._entityId == entity:GetComponent(BattleECS.Components.TypeComponent)._summonFatherEntityid then
          fatherEntity = e
          break
        end
      end
      if fatherEntity then
        fatherEntity:GetComponent(BattleECS.Components.SummonDataComponent)._yuziSummonData[entity:GetComponent(BattleECS.Components.TypeComponent)._roleID] = nil
      end
    elseif entity:GetComponent(BattleECS.Components.TypeComponent)._summonName == "buff" then
      local fatherEntity
      for i, e in ipairs(battleWorld._entitys) do
        if e._entityId == entity:GetComponent(BattleECS.Components.TypeComponent)._summonFatherEntityid then
          fatherEntity = e
          break
        end
      end
      if fatherEntity then
        local fatherSummonData = fatherEntity:GetComponent(BattleECS.Components.SummonDataComponent)._summonBuffData
        local removeList = {}
        for i = #fatherSummonData, 1, -1 do
          local data = fatherSummonData[i]
          if data.summonEntityId == entity._entityId then
            local buffComponent = fatherEntity:GetComponent(BattleECS.Components.BuffComponent)
            if buffComponent then
              for i = #buffComponent._buffList, 1, -1 do
                local v = buffComponent._buffList[i]
                if v.buffId == data.buffId then
                  v.buffObj:Destroy()
                  table.remove(buffComponent._buffList, i)
                  break
                end
              end
            end
            table.insert(removeList, i)
          end
        end
        for _, i in ipairs(removeList) do
          table.remove(fatherSummonData, i)
        end
      end
    end
    local protocol = BattleClientProtocolManager.CreateProtocol("action.sroledead")
    protocol.entityId = entity._entityId
    protocol.damageFrom = damageFrom
    battleWorld._lastDamageRoleId = damageFromEntity:GetComponent(BattleECS.Components.TypeComponent)._roleID
    protocol.damageNum = fixedpoint.tonumber(damageNum)
    ProtocolUtility.SendPlayBattleVoice(entity:GetComponent(BattleECS.Components.TypeComponent)._roleID, BattleECS.Utility.DataUtility.VoiceType.Attacked, nil, battleWorld)
    LogInfoFormat("ProtocolUtility", "deadentityid:%s", entity._entityId)
    battleWorld:InsertViewProtocolData(protocol)
    local component = entity:GetComponent(BattleECS.Components.SummonDataComponent)
    if component and component._alternateFighter then
      local initialTagType = {Not = 0, Is = 1}
      if component._alternateFighter.camp == BattleECS.Components.TypeComponent.CampType.Left then
        LogInfoFormat("ProtocolUtility", "left alternate fighter role id : %s", component._alternateFighter.id)
        battleWorld:CreateLeftPlayer(component._alternateFighter, {
          isInitial = initialTagType.Is
        })
        ProtocolUtility.SendPlayBattleVoice(component._alternateFighter.id, BattleECS.Utility.DataUtility.VoiceType.BattleStart, nil, battleWorld)
      end
      if component._alternateFighter.camp == BattleECS.Components.TypeComponent.CampType.Right then
        LogInfoFormat("ProtocolUtility", "right alternate fighter role id : %s", component._alternateFighter.id)
        battleWorld:CreateRightPlayer(component._alternateFighter, {
          isInitial = initialTagType.Is
        })
      end
    end
    return true
  end
end

function ProtocolUtility.SendCreateBuffEffectProtocol(entity, point, packagename, effectname, rad, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.screatebuffeffect")
  protocol.entityid = entity._entityId
  protocol.point = point
  protocol.packagename = packagename
  protocol.effectname = effectname
  if rad then
    if fixedpoint.judgetype(rad) then
      rad = fixedpoint.tonumber(rad)
    end
    protocol.rad = math.floor(rad * 1000)
  else
    protocol.rad = 0
  end
  if entity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
    protocol.isImaged = 1
  else
    protocol.isImaged = 0
  end
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendDestroyBuffEffectProtocol(entityid, point, effectname, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sdestroybuffeffect")
  protocol.entityid = entityid
  protocol.point = point
  protocol.effectname = effectname
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendBattlerPlayAnimationByNameProtocol(entity, name, ignorePriority, battleWorld)
  if entity:GetComponent(BattleECS.Components.FlySkillDataComponent) then
    return
  end
  if name == "" then
    return
  end
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sbattlerplayanimationbyname")
  protocol.entityid = entity._entityId
  protocol.name = name
  protocol.ignorePriority = ignorePriority or 0
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendDamageMissProtocol(entityid, damagetype, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sdamagemiss")
  protocol.entityid = entityid
  protocol.damegetype = damagetype
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendFixPointSkillAttackedInfo(damageFromEntityID, hittedEntity, skillid, damageNum, isPost, rad, isAnimation, battleWorld, damageType, isPlayAttackedEffect)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.screatefixpointskillattackedinfo")
  protocol.entityId = hittedEntity._entityId
  protocol.skillId = skillid
  protocol.damageFrom = damageFromEntityID
  if fixedpoint.judgetype(damageNum) then
    damageNum = fixedpoint.tonumber(damageNum)
  end
  protocol.damageNum = math.floor(damageNum)
  protocol.type = 2
  protocol.damageType = damageType
  protocol.currentHp = fixedpoint.tonumber(hittedEntity:GetComponent(BattleECS.Components.HpComponent)._currentHp)
  if not isPost then
    protocol.isPost = 1
  else
    protocol.isPost = 0
  end
  if hittedEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
    protocol.isImaged = 1
  else
    protocol.isImaged = 0
  end
  if fixedpoint.judgetype(rad) then
    rad = fixedpoint.tonumber(rad)
  end
  protocol.rad = math.floor(rad * 1000)
  if isAnimation then
    protocol.isPlayHpBarAnimation = 1
  else
    protocol.isPlayHpBarAnimation = 0
  end
  protocol.isPlayAttackedEffect = isPlayAttackedEffect
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendSkillFail(entityid, skillid, type, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sskillfail")
  protocol.entityid = entityid
  protocol.skillid = skillid
  protocol.type = type
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendSkillStart(skillid, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sskillstart")
  protocol.skillid = skillid
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendSkillEnd(skillid, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sskillend")
  protocol.skillid = skillid
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SCreateSceneEffect(effectid, posx, posy, rad, camp, battleWorld, posZ)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.screatesceneeffect")
  protocol.effectid = effectid
  protocol.posX = fixedpoint.tonumber(posx)
  protocol.posY = fixedpoint.tonumber(posy)
  protocol.posZ = 0
  if posZ then
    if fixedpoint.judgetype(posZ) then
      posZ = fixedpoint.tonumber(posZ)
    end
    protocol.posZ = posZ
  end
  if fixedpoint.judgetype(rad) then
    rad = fixedpoint.tonumber(rad)
  end
  protocol.rad = rad
  protocol.camp = camp
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendBattlePowerShow(redMax, redCu, blueMax, blueCu, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sbattleworldpowershow")
  protocol.redMaxPower = fixedpoint.tonumber(redMax)
  protocol.redCurrentPower = fixedpoint.tonumber(redCu)
  protocol.blueMaxPower = fixedpoint.tonumber(blueMax)
  protocol.blueCurrentPower = fixedpoint.tonumber(blueCu)
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendBattleEnd(type, isjoin, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sbattleend")
  protocol.type = type
  protocol.isjoin = isjoin
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendBattleResult(battleresult, isjoin, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sbattleresult")
  protocol.type = battleresult
  protocol.isjoin = isjoin
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendFlySkill(entityid, x, y, z, effectid, playerentityid, rad, isimaged, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.screateflyskill")
  protocol.entityId = entityid
  protocol.posX = fixedpoint.tonumber(x)
  protocol.posY = fixedpoint.tonumber(y)
  protocol.posZ = fixedpoint.tonumber(z)
  protocol.effectid = effectid
  protocol.playerEntityId = playerentityid
  if fixedpoint.judgetype(rad) then
    rad = fixedpoint.tonumber(rad)
  end
  protocol.rad = rad
  protocol.isImaged = isimaged
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendUseSkill(skillid, entityid, isImaged, camp, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.suseskill")
  protocol.skillid = skillid
  protocol.entityid = entityid
  protocol.isImaged = isImaged
  protocol.camp = camp
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendChangeEntityHpCellVisible(entityid, visible, spritevisible, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.schangeentityhpcellvisible")
  protocol.entityid = entityid
  protocol.visible = visible
  protocol.spritevisible = spritevisible
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendUpdateRoleBuffs(entityid, buffid, time, battleWorld, stackTime)
  if BattleECS.Utility.DataUtility.cIBuffCfgTable[buffid] then
    return
  end
  local protocol = BattleClientProtocolManager.CreateProtocol("action.supdaterolebuffs")
  protocol.entityid = entityid
  protocol.buffid = buffid
  protocol.counttime = time
  protocol.stacklayer = stackTime or -1
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendSkillBegin(entityid, skillid, battleWorld)
  local record = BattleECS.Utility.DataUtility.cskillTable[skillid]
  local type = record.spellType
  local lasttime = record.spellTime
  local skillAttr = record.attr
  local SkillShowCountDownType = {
    NotLoad = 0,
    LoadInterrupt = 1,
    ContinualInterrupt = 2,
    InfiniteInterrupt = 3,
    LoadNotInterrupt = 4,
    ContinualNotInterrupt = 5,
    InfiniteNotInterrupt = 6
  }
  if type == SkillShowCountDownType.NotLoad then
    return
  end
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sskillbegin")
  protocol.entityid = entityid
  protocol.skillid = skillid
  protocol.type = type
  protocol.lasttime = lasttime
  protocol.skillattr = skillAttr
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendSkillInterrupted(entityid, skillid, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sskillinterrupted")
  protocol.entityid = entityid
  protocol.skillid = skillid
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendInvincibleStateChange(entityid, state, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sinvinciblestatechange")
  protocol.entityid = entityid
  protocol.state = state
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendShieldValueChange(entityid, buffId, shieldType, value, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sshieldvaluechange")
  protocol.entityid = entityid
  protocol.buffid = buffId
  protocol.shieldtype = shieldType
  if fixedpoint.judgetype(value) then
    value = fixedpoint.tonumber(value)
  end
  protocol.value = value
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendBossIsInWeakState(battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sbossisinweakstate")
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendAccumulatePowerStateChange(state, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.saccumulatepowerstatechange")
  protocol.state = state
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendCollaborativeSkillNumChange(num, entityid, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.scollaborativeskillnumchange")
  protocol.num = fixedpoint.tonumber(num)
  protocol.entityid = entityid
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendSetClipRectForShiKongZhiMen(entityId, w, h, camp, effectName, battleWorld, clipState)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.ssetcliprectforshikongzhimen")
  protocol.entityid = entityId
  protocol.w = w
  protocol.h = h
  protocol.camp = camp
  protocol.objectname = effectName
  protocol.clipstate = tostring(clipState)
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendActiveSkillStateChange(entityId, skillId, isInCD, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sactiveskillstatechange")
  protocol.entityid = entityId
  protocol.skillid = skillId
  protocol.isInCD = isInCD
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendActorTimeSkillState(state, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sactortimeskillstate")
  protocol.state = state
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendPlayBattleVoice(roleId, voiceType, index, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.splaybattlevoice")
  protocol.roleId = roleId
  protocol.voiceType = voiceType
  protocol.index = index or -1
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendPlayAudio(audioId, audioValue, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.splayaudio")
  protocol.audioid = audioId
  protocol.audiovalue = audioValue
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendChangeAnimatorState(animatorType, param, value, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.schangeanimatorstate")
  protocol.animatorType = animatorType
  protocol.param = param
  protocol.value = value
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.ChangeEntityNameTextId(entityId, nameTextId, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.schangeentityname")
  protocol.entityId = entityId
  protocol.nameTextId = nameTextId
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendPlayBattleCameraAnimationName(cameraMoveType, moveDelayTime, resetDelayTime, skillId, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.splaybattlecameraanimationname")
  protocol.cameraMoveType = cameraMoveType
  protocol.moveDelayTime = moveDelayTime
  protocol.resetDelayTime = resetDelayTime
  protocol.skillId = skillId
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendShowOrderPowerSpecialUIEffect(effectType, powerIndex, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sshoworderpowerspecialuieffect")
  protocol.effectType = effectType
  protocol.powerGridIndex = powerIndex
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendSActionWithActiveSkill(entityId, enermyEntityId, skillId, battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sactionwithactiveskill")
  protocol.entityId = entityId
  protocol.skillId = skillId
  protocol.enermyEntityId = enermyEntityId
  battleWorld:InsertViewProtocolData(protocol)
end

function ProtocolUtility.SendSBreakOutPowerNumber(battleWorld)
  local protocol = BattleClientProtocolManager.CreateProtocol("action.sbreakoutpowernumber")
  protocol.breakoutPower = battleWorld._accumulatePower
  protocol.breakoutPowerMax = battleWorld._accumulatePowerMax
  battleWorld:InsertViewProtocolData(protocol)
end

return ProtocolUtility
