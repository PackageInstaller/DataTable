-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/buff/buff.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Buff = strictclass("Buff")
local SpriteShowType = {None = -1, Show = 1, Hide = 0, OnlyHideHitPoint = 2, OnlyShowHitPoint = 3}
Buff.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : _ENV, SpriteShowType
  local args = {...}
  local data = args[1]
  if data.damagetransformparamter then
    self._damageTransformParamter = data.damagetransformparamter
  end
  if data.fixedpointAttrValue then
    self._specialBuffParameterFixedpointAttrValue = data.fixedpointAttrValue
  end
  local cbuffRecord = (((BattleECS.Utility).DataUtility).cBuffCfgTable)[data.buffid]
  if data.isplayattackedeffect then
    self._isPlayAttackedEffect = data.isplayattackedeffect
  else
    if cbuffRecord then
      self._isPlayAttackedEffect = cbuffRecord.isEffectAtt
    else
      self._isPlayAttackedEffect = 1
    end
  end
  if data.isconnect then
    self._isConnect = true
  end
  self._buffID = data.buffid
  if not data.originalBuffId then
    self._originalBuffId = self._buffID
    self._buffParamter = data.buffparamter
    self._buffAdditionalAttribute = {}
    self._everyStackTimesBuffAdditionalAttribute = {}
    self._entity = data.entity
    self._randomFun = (data.battleworld)._randomPcg
    self._enermyEntity = data.enermyentity
    self._skillid = data.skillid
    self._battleWorld = data.battleworld
    if data.rad then
      self._effectRad = data.rad
    else
      self._effectRad = 0
    end
    self._totalTime = 1
    self._isDamageTriggerContinueBuff = false
    self._currentTime = 0
    self._stackCurrentTime = {}
    self._isEffect = true
    self._effectCount = 0
    self._effectCountTotal = nil
    self._effectBuffidList = {}
    self._triggerRate = 100
    self._bossBonusValue = fixedpoint_zero
    self._monsterBonusValue = fixedpoint_zero
    self._elementype = fixedpoint_zero
    self._elementdmg = fixedpoint_zero
    self._elementnum = fixedpoint_zero
    self._stackTimes = 99999
    self._maxStackTimes = 99999
    self._stackTimesCur = 1
    self._coolDownTime = 0
    self._triggerCDTime = 0
    self._triggerCDCountTime = nil
    self._yingXiBuffAttackTime = 0
    self._linkSkillEffectTime = 0
    self._linkSkillEffectTotalTime = 99999
    self._isCrit20096ShadowsWordRate = 0
    local cbufflinkskillRecord = (((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable)[self._buffID]
    if cbufflinkskillRecord then
      self._linkSkillRecord = cbufflinkskillRecord
      local conditions = (string.split)(cbufflinkskillRecord.conditionid, ";")
      self._linkSkillCondition = {}
      local index = 1
      for _,c in ipairs(conditions) do
        if tonumber(c) > 100 then
          local record = (((BattleECS.Utility).DataUtility).cLinkSkillConditionCfgTable)[tonumber(c)]
          -- DECOMPILER ERROR at PC258: Confused about usage of register: R13 in 'UnsetPending'

          ;
          (self._linkSkillCondition)[index] = {conditionId = tonumber(c), 
cfg = {relation = tonumber(record.relation), timebefore = tonumber(record.timebefore), timeafter = tonumber(record.timeafter), castskillid = tonumber(record.castskillid), powerchange = tonumber(record.powerchange), hppctfloor = tonumber(record.hppctfloor), hppcttop = tonumber(record.hppcttop), buffid = tonumber(record.buffid), buffstacks = tonumber(record.buffstacks), attrid = tonumber(record.attrid), attrfloor = tonumber(record.attrfloor), attrtop = tonumber(record.attrtop), damageskillid = tonumber(record.damageskillid), station = tonumber(record.station)}
, timebeforeFlag = not record, timeafterFlag = record.timebefore ~= "" and record.timeafter == "", castskillidFlag = record.castskillid == "", powerchangeFlag = record.powerchange == "", hppctfloorFlag = record.hppctfloor == "", hppcttopFlag = record.hppcttop == "", buffIdFlag = record.buffid == "", attrIdFlag = record.attrid == "", damageskillidFlag = record.damageskillid == "", stationFlag = record.station == ""}
          index = index + 1
        end
        LogErrorFormat("Buff", "CLinkSkillConditionCfg doesnt have id %d condition, CBuffLinkSkillCfg id %s ", tonumber(c), self._buffID)
      end
    end
    local cbuffSummonRecord = (((BattleECS.Utility).DataUtility).cBuffSummonTable)[self._buffID]
    if cbuffSummonRecord then
      local fatherPointNum = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._rolePointNum
      local bornPoint = cbuffSummonRecord.bornPoint
      if (string.find)(bornPoint, "-") then
        local aTempData = (string.split)(bornPoint, "-")
        bornPoint = tonumber(fatherPointNum) - tonumber(aTempData[2])
      elseif (string.find)(bornPoint, "+") then
        local aTempData = (string.split)(bornPoint, "+")
        bornPoint = tonumber(fatherPointNum) + tonumber(aTempData[2])
      elseif bornPoint == "0" then
        bornPoint = tonumber(fatherPointNum)
      else
        bornPoint = tonumber(bornPoint)
      end
      local posCfg = (self._battleWorld)._battlePosList
      if not posCfg[bornPoint] then
        bornPoint = tonumber(fatherPointNum)
        LogErrorFormat("Buff", "wrong pos in cbuffsummon.bornPoint buffId %s, uses father pos", self._buffID)
      end
      local posRecord = posCfg[bornPoint]
      local skillList = (string.split)(cbuffSummonRecord.birthSkill, ";")
      self._summonEntity = (self._battleWorld):CreatePlayerSummon({name = "buff", monsterid = cbuffSummonRecord.summonId, birthSkillList = skillList, summonFatherEntity = self._entity, buffId = self._buffID, buffDeletedAfterDeathOrNot = tonumber(cbuffSummonRecord.buffDeletedAfterDeathOrNot), 
bornPoint = {x = posRecord.x, y = posRecord.y, z = posRecord.z}
, pointNum = bornPoint, summonType = cbuffSummonRecord.summonType})
    end
    if (((BattleECS.Utility).DataUtility).cIBuffCfgTable)[self._buffID] then
      return 
    end
    self._totalTime = 99999
    if not cbuffRecord then
      LogErrorFormat("buff", "buffid %s not in cbuffconfig, skillid %s", self._buffID, self._skillid)
    end
    if cbuffRecord.stacktimes > 0 then
      self._stackTimes = cbuffRecord.stacktimes
      self._maxStackTimes = cbuffRecord.stacktimes
    end
    self._damagePercentStage = 100
    self._overrideSelfType = cbuffRecord.overrideSelfType
    if cbuffRecord.animation ~= "" then
      local ifIgnorePriority = {No = 0, Yes = 1}
      ;
      (((BattleECS.Utility).ProtocolUtility).SendBattlerPlayAnimationByNameProtocol)(self._entity, cbuffRecord.animation, ifIgnorePriority.No, self._battleWorld)
    elseif (((BattleECS.Utility).BuffUtility).GetBuffLimiteType)(self._buffID) == 7 and self._buffID ~= 20000 then
      local ifIgnorePriority = {No = 0, Yes = 1}
      ;
      (((BattleECS.Utility).ProtocolUtility).SendBattlerPlayAnimationByNameProtocol)(self._entity, "BattleIdle", ifIgnorePriority.No, self._battleWorld)
    end
    if self._buffID == 20084 then
      (self._battleWorld):SetGuardBuffEntityid(((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp, (self._entity)._entityId, false)
    end
    if self._buffID == 20097 or self._buffID == 20272 then
      (((BattleECS.Utility).PhysicsUtility).SetEntityPhyscisComponentAwake)(self._entity, false)
      ;
      (((BattleECS.Utility).ProtocolUtility).SendChangeEntityHpCellVisible)((self._entity)._entityId, 0, SpriteShowType.Hide, self._battleWorld)
    end
    if self._buffID == 20099 then
      (((BattleECS.Utility).PhysicsUtility).SetEntityPhyscisComponentAwake)(self._entity, false)
      ;
      (((BattleECS.Utility).ProtocolUtility).SendChangeEntityHpCellVisible)((self._entity)._entityId, 0, SpriteShowType.None, self._battleWorld)
    end
    if self._buffID == 20168 then
      (((BattleECS.Utility).ProtocolUtility).SendChangeEntityHpCellVisible)((self._entity)._entityId, 0, SpriteShowType.None, self._battleWorld)
    end
    self._hideOptions = cbuffRecord.hideOptions
    if self._hideOptions and self._hideOptions ~= 0 then
      (((BattleECS.Utility).PhysicsUtility).SetEntityPhyscisComponentAwake)(self._entity, false)
      local VisibleType = {HpBar = 2, Sprite = 1}
      local hpBarVisible = -1
      local spriteVisible = SpriteShowType.None
      if self._hideOptions & VisibleType.HpBar ~= 0 then
        hpBarVisible = 0
      end
      if self._hideOptions & VisibleType.Sprite ~= 0 then
        spriteVisible = SpriteShowType.Hide
      end
      ;
      (((BattleECS.Utility).ProtocolUtility).SendChangeEntityHpCellVisible)((self._entity)._entityId, hpBarVisible, spriteVisible, self._battleWorld)
    end
    if cbuffRecord.NpcShape ~= "" then
      if self._buffID == 20211 then
        local BattlePauseType = (BattleClientProtocolManager.GetBeanDef)("data.battlepausetype")
        local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sbattlepause")
        protocol.pauseType = BattlePauseType.TimeLine
        protocol.param = ""
        ;
        (self._battleWorld):InsertViewProtocolData(protocol)
      end
      local protocol = (BattleClientProtocolManager.CreateProtocol)("action.srolechangeshapeandattribute")
      protocol.entityid = (self._entity)._entityId
      local changeNpcShapeRecord = (((BattleECS.Utility).DataUtility).cRoleSkinChangeshapeCfgTable)[self._buffID]
      if changeNpcShapeRecord then
        local changeFlag = false
        local oriShapePrefabName = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._oriShapePrefabName
        local oriShapeAssetBundleName = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._oriShapeAssetBundleName
        for index,before in ipairs(changeNpcShapeRecord.shapeid) do
          local beforeRecord = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[tonumber(before)]
          if beforeRecord and beforeRecord.prefabName == oriShapePrefabName and beforeRecord.assetBundleName == oriShapeAssetBundleName then
            protocol.shapeid = tonumber((changeNpcShapeRecord.changeshapeid)[index])
            changeFlag = true
            break
          end
        end
        if not changeFlag then
          LogInfoFormat("Buff", "buffid %s in croleskinchangeshapecfg, but _oriShapePrefabName %s _oriShapeAssetBundleName %s dont have corresponding changeitem", self._buffID, oriShapePrefabName, oriShapeAssetBundleName)
          protocol.shapeid = tonumber(cbuffRecord.NpcShape)
        end
      else
        protocol.shapeid = tonumber(cbuffRecord.NpcShape)
      end
      ;
      (self._battleWorld):InsertViewProtocolData(protocol)
      ;
      (self._battleWorld):ChangeLeftPlayer(protocol)
    end
    if self._buffID == 20346 then
      (((BattleECS.Utility).BuffUtility).ResetPowerCostValue)(self._entity)
    end
    if self._buffID == 20404 then
      local component = (self._entity):GetComponent((BattleECS.Components).PositionComponent)
      local pos = {x = (component._position).x, y = (component._position).y}
      local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(self._entity)
      local delt = (((BattleECS.Utility).Utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, "HitPoint")
      for _,flyEntity in ipairs((self._battleWorld)._shape20030FlyBallSet) do
        component = flyEntity:GetComponent((BattleECS.Components).FlySkillDataComponent)
        -- DECOMPILER ERROR at PC726: Confused about usage of register: R15 in 'UnsetPending'

        ;
        (component._flyDestination).x = pos.x - delt.x
        -- DECOMPILER ERROR at PC731: Confused about usage of register: R15 in 'UnsetPending'

        ;
        (component._flyDestination).y = pos.y + delt.y
        component._currentFlyFraps = component._onceFlyTime
      end
    end
    do
      if cbuffRecord.invincible == 1 then
        local StateType = {Begin = 0, End = 1}
        ;
        (((BattleECS.Utility).ProtocolUtility).SendInvincibleStateChange)((self._entity)._entityId, StateType.Begin, self._battleWorld)
      end
      if self._buffID == 20776 then
        local StateType = {Begin = 0, Over = 1}
        ;
        (((BattleECS.Utility).ProtocolUtility).SendActorTimeSkillState)(StateType.Begin, self._battleWorld)
        local entityCamp = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp
        for _,v in pairs((self._battleWorld)._actor_shiKongTingZhi_effectList) do
          if v.camp == entityCamp then
            (((BattleECS.Utility).ProtocolUtility).SendDestroyEffectByName)(v.camp, v.effectName, self._battleWorld)
            local effectEntity = nil
            for i,e in ipairs((self._battleWorld)._entitys) do
              if e._entityId == v.entityId then
                effectEntity = e
                break
              end
            end
            if effectEntity then
              (effectEntity:GetComponent((BattleECS.Components).TypeComponent))._isNeedDestroy = true
              local physCom = effectEntity:GetComponent((BattleECS.Components).PhysicsComponent)
              if physCom then
                physCom._isNeedReleaseBox = true
              end
            end
          end
        end
        -- DECOMPILER ERROR at PC821: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self._battleWorld)._actor_shiKongTingZhi_effectList = {}
      end
      do
        if self._buffID == 20816 then
          local animatorType = {EMengAnimator = 1}
          ;
          (((BattleECS.Utility).ProtocolUtility).SendChangeAnimatorState)(animatorType.EMengAnimator, "isNightmare", 1, self._battleWorld)
        end
        if self._buffID == 20835 then
          (((BattleECS.Utility).ProtocolUtility).SendChangeEntityHpCellVisible)((self._entity)._entityId, -1, SpriteShowType.OnlyHideHitPoint, self._battleWorld)
        end
        do
          if self._buffID == 20910 then
            local PowerOtherEffectType = {Drvaspa = 1104}
            ;
            (((BattleECS.Utility).ProtocolUtility).SendShowOrderPowerSpecialUIEffect)(PowerOtherEffectType.Drvaspa, (((BattleECS.Utility).DataUtility).GetPowerGridFunc)((self._battleWorld)._redPowerMax, (((BattleECS.Utility).DataUtility).PowerType).Blue), self._battleWorld)
            -- DECOMPILER ERROR at PC885: Confused about usage of register: R7 in 'UnsetPending'

            ;
            (self._battleWorld)._redPowerMax = (self._battleWorld)._redPowerMax - fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[2]).attr)
          end
          -- DECOMPILER ERROR: 49 unprocessed JMP targets
        end
      end
    end
  end
end

Buff.PlayTriggerAnimation = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if (((BattleECS.Utility).DataUtility).cBuffAnimationCfgTable)[self._buffID] then
    local recorder = ((((BattleECS.Utility).DataUtility).cBuffAnimationCfgTable)[self._buffID]).animation
    if recorder ~= "" and (((BattleECS.Utility).AnimationUtility).IsNeedResetEntityAnimationEventComponentIsInChangePosition)(self._entity) then
      (((BattleECS.Utility).AnimationUtility).IntegrateChangePositionData)(self._entity, recorder)
      if recorder == "blowup" or recorder == "blowup3" then
        local ifIgnorePriority = {No = 0, Yes = 1}
        ;
        (((BattleECS.Utility).ProtocolUtility).SendBattlerPlayAnimationByNameProtocol)(self._entity, "Hit", ifIgnorePriority.No, self._battleWorld)
      else
        do
          if recorder == "magicshock" then
            (((BattleECS.Utility).ProtocolUtility).SendFixPointSkillAttackedInfo)((self._enermyEntity)._entityId, self._entity, self._skillid, 0, true, 0, false, self._battleWorld, 0, 0)
          end
        end
      end
    end
  end
end

Buff.InitContinueBuffInfo = function(self, dontSetBuffTotalTime)
  -- function num : 0_2 , upvalues : _ENV
  if (((BattleECS.Utility).DataUtility).cIBuffCfgTable)[self._buffID] then
    if ((((BattleECS.Utility).DataUtility).cIBuffCfgTable)[self._buffID]).classname ~= "Interruption" and ((((BattleECS.Utility).DataUtility).cIBuffCfgTable)[self._buffID]).classname ~= "Purify" and ((((BattleECS.Utility).DataUtility).cIBuffCfgTable)[self._buffID]).classname ~= "Dispel" and ((((BattleECS.Utility).DataUtility).cIBuffCfgTable)[self._buffID]).classname ~= "ComboCost" and ((((BattleECS.Utility).DataUtility).cIBuffCfgTable)[self._buffID]).classname ~= "PowerUp" then
      self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, self._buffParamter)})
    else
      if ((((BattleECS.Utility).DataUtility).cIBuffCfgTable)[self._buffID]).classname == "PowerUp" and (self._entity)._entityId == (self._enermyEntity)._entityId then
        self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, self._buffParamter)})
      end
    end
    ;
    (((BattleECS.Utility).ProtocolUtility).SendUpdateRoleBuffs)((self._entity)._entityId, self._buffID, 1, self._battleWorld)
    return 
  end
  if (((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID] then
    local curPrefabName = ((self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent))._oriShapePrefabName
    self._beginEffectList = (string.split)(((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).effectid, ";")
    for i,v in ipairs(self._beginEffectList) do
      v = tonumber(v)
      -- DECOMPILER ERROR at PC147: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self._beginEffectList)[i] = (((BattleECS.Utility).BuffUtility).GetSkinBuffChangeEffectId)(curPrefabName, v)
    end
    self._endEffectList = (string.split)(((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).effectEndid, ";")
    for i,v in ipairs(self._endEffectList) do
      v = tonumber(v)
      -- DECOMPILER ERROR at PC178: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self._endEffectList)[i] = (((BattleECS.Utility).BuffUtility).GetSkinBuffChangeEffectId)(curPrefabName, v)
    end
    if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "roundbuff" then
      local record = (string.split)(self._buffParamter, ";")
      if not dontSetBuffTotalTime then
        for index,param in ipairs(record) do
          local r = (string.split)(param, "=")
          if r[1] == "time" then
            self:SetBuffTotalTime(tonumber(r[2]))
            break
          end
        end
      end
      do
        do
          for index,param in ipairs(record) do
            local r = (string.split)(param, "=")
            if r[1] == "timecell" then
              self._effectTime = tonumber(r[2])
              self._timecellEffectTimes = 0
            else
              if r[1] == "effectnums" then
                self._effectNum = tonumber(r[2])
              else
                if r[1] == "effectorder" then
                  self._effectOrder = tonumber(r[2])
                else
                  if (string.find)(r[1], "_value") then
                    self._numParamter = param
                  end
                end
              end
            end
          end
          self._onceTimeBuffID = tonumber(((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).buffattr)
          if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "continualbuff" then
            local record = (string.split)(self._buffParamter, ";")
            local isHasTime = false
            for index,param in ipairs(record) do
              local r = (string.split)(param, "=")
              if r[1] == "time" then
                isHasTime = true
                if not dontSetBuffTotalTime then
                  self:SetBuffTotalTime(tonumber(r[2]))
                end
                break
              end
            end
            do
              do
                for index,param in ipairs(record) do
                  local r = (string.split)(param, "=")
                  if (string.find)(r[1], "_value") then
                    self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, param)})
                  else
                    if r[1] == "ischange" then
                      (table.insert)(((self._entity):GetComponent((BattleECS.Components).BuffComponent))._isHasChangeBuff, tonumber(r[2]))
                      self._selfIsHasChangeBuffIndex = #((self._entity):GetComponent((BattleECS.Components).BuffComponent))._isHasChangeBuff
                    else
                      if r[1] == "percentage" then
                        self._damagePercentStage = tonumber(r[2])
                      else
                        if r[1] == "rate" then
                          self._triggerRate = tonumber(r[2])
                          if not self._triggerRate then
                            self._triggerRate = self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, param)})
                          end
                          if not self._triggerRate then
                            LogErrorFormat("buff", "buffid %s skillid %s param [rate] wrong", self._buffID, self._skillid)
                          end
                        else
                          if r[1] == "triggercd" then
                            self._triggerCDTime = tonumber(r[2])
                          else
                            if r[1] == "shadowswordrate" then
                              self._isCrit20096ShadowsWordRate = fixedpoint(r[2])
                            else
                              if r[1] == "bossbonus" then
                                self._bossBonusValue = tonumber(r[2])
                                if not self._bossBonusValue then
                                  self._bossBonusValue = self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, param)})
                                end
                                if not self._bossBonusValue then
                                  LogErrorFormat("buff", "buffid %s skillid %s param [bossbonus] wrong", self._buffID, self._skillid)
                                end
                              else
                                if r[1] == "monsterbonus" then
                                  self._monsterBonusValue = tonumber(r[2])
                                  if not self._monsterBonusValue then
                                    self._monsterBonusValue = self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, param)})
                                  end
                                  if not self._monsterBonusValue then
                                    LogErrorFormat("buff", "buffid %s skillid %s param [monsterbonus] wrong", self._buffID, self._skillid)
                                  end
                                else
                                  if r[1] == "elementype" then
                                    self._elementype = tonumber(r[2])
                                    if not self._elementype then
                                      self._elementype = self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, param)})
                                    end
                                    if not self._elementype then
                                      LogErrorFormat("buff", "buffid %s skillid %s param [elementype] wrong", self._buffID, self._skillid)
                                    end
                                  else
                                    if r[1] == "elementdmg" then
                                      self._elementdmg = tonumber(r[2])
                                      if not self._elementdmg then
                                        self._elementdmg = self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, param)})
                                      end
                                      if not self._elementdmg then
                                        LogErrorFormat("buff", "buffid %s skillid %s param [elementdmg] wrong", self._buffID, self._skillid)
                                      end
                                    else
                                      if r[1] == "elementnum" then
                                        self._elementnum = tonumber(r[2])
                                        if not self._elementnum then
                                          self._elementnum = self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, param)})
                                        end
                                        if not self._elementnum then
                                          LogErrorFormat("buff", "buffid %s skillid %s param [elementnum] wrong", self._buffID, self._skillid)
                                        end
                                      else
                                        if r[1] == "forcecrit" then
                                          local forceCrit = tonumber(r[2])
                                          if forceCrit == 1 then
                                            ((self._entity):GetComponent((BattleECS.Components).HpComponent))._forceCritFlag = true
                                          else
                                            ;
                                            ((self._entity):GetComponent((BattleECS.Components).HpComponent))._forceCritFlag = false
                                          end
                                        else
                                          do
                                            if r[1] == "crazystate" then
                                              local crazyState = tonumber(r[2])
                                              if crazyState == 1 then
                                                (((BattleECS.Utility).ProtocolUtility).SendBossEnterViolent)(self._battleWorld)
                                              end
                                            else
                                              do
                                                do
                                                  self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, param)})
                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out DO_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out DO_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                  -- DECOMPILER ERROR at PC639: LeaveBlock: unexpected jumping out IF_STMT

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
                self._isDamageTriggerContinueBuff = not isHasTime
                if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "endbuff" then
                  local record = (string.split)(self._buffParamter, ";")
                  if not dontSetBuffTotalTime then
                    for index,param in ipairs(record) do
                      local r = (string.split)(param, "=")
                      if r[1] == "time" then
                        self:SetBuffTotalTime(tonumber(r[2]))
                        break
                      end
                    end
                  end
                  do
                    do
                      for index,param in ipairs(record) do
                        local r = (string.split)(param, "=")
                        if (string.find)(r[1], "_value") then
                          self._endBuffParamter = param
                        end
                      end
                      self._onceTimeBuffID = tonumber(((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).buffattr)
                      if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "finishbuff" then
                        local record = (string.split)(self._buffParamter, ";")
                        if not dontSetBuffTotalTime then
                          for index,param in ipairs(record) do
                            local r = (string.split)(param, "=")
                            if r[1] == "time" then
                              self:SetBuffTotalTime(tonumber(r[2]))
                              break
                            end
                          end
                        end
                        do
                          do
                            self._onceTimeBuffID = tonumber(((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).buffattr)
                            if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "readbuff" then
                              local record = (string.split)(self._buffParamter, ";")
                              self._readbuffParamterWithValue = {}
                              if not dontSetBuffTotalTime then
                                for index,param in ipairs(record) do
                                  local r = (string.split)(param, "=")
                                  if r[1] == "time" then
                                    self:SetBuffTotalTime(tonumber(r[2]))
                                    break
                                  end
                                end
                              end
                              do
                                for index,param in ipairs(record) do
                                  local r = (string.split)(param, "=")
                                  if (string.find)(r[1], "_value") then
                                    local returnValue, formula, attrResult = (((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, param)
                                    ;
                                    (table.insert)(self._readbuffParamterWithValue, {returnValue, formula, attrResult})
                                    self:NumbericalCalculation({returnValue, formula, attrResult})
                                  end
                                end
                                do
                                  if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "breakbuff" then
                                    local record = (string.split)(self._buffParamter, ";")
                                    if not dontSetBuffTotalTime then
                                      for index,param in ipairs(record) do
                                        local r = (string.split)(param, "=")
                                        if r[1] == "time" then
                                          self:SetBuffTotalTime(tonumber(r[2]))
                                          break
                                        end
                                      end
                                    end
                                    do
                                      for index,param in ipairs(record) do
                                        local r = (string.split)(param, "=")
                                        if (string.find)(r[1], "_value") then
                                          self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, param)})
                                        end
                                      end
                                      do
                                        if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "areabuff" then
                                          local record = (string.split)(self._buffParamter, ";")
                                          if not dontSetBuffTotalTime then
                                            for index,param in ipairs(record) do
                                              local r = (string.split)(param, "=")
                                              if r[1] == "time" then
                                                self:SetBuffTotalTime(tonumber(r[2]))
                                                break
                                              end
                                            end
                                          end
                                          do
                                            do
                                              for index,param in ipairs(record) do
                                                local r = (string.split)(param, "=")
                                                if r[1] == "timecell" then
                                                  self._effectTime = tonumber(r[2])
                                                  self._timecellEffectTimes = 0
                                                else
                                                  if (string.find)(r[1], "_value") then
                                                    self._numParamter = param
                                                  end
                                                end
                                              end
                                              if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).buffattr ~= "" then
                                                self._onceTimeBuffID = tonumber(((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).buffattr)
                                              else
                                                self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, self._numParamter)})
                                              end
                                              if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "barrierbuff" then
                                                local record = (string.split)(self._buffParamter, ";")
                                                if not dontSetBuffTotalTime then
                                                  for index,param in ipairs(record) do
                                                    local r = (string.split)(R10_PC1026, "=")
                                                    R10_PC1026 = r[1]
                                                    if R10_PC1026 == "time" then
                                                      R10_PC1026(self, tonumber(r[2]))
                                                      break
                                                    end
                                                  end
                                                end
                                                do
                                                  for index,param in ipairs(record) do
                                                    -- DECOMPILER ERROR at PC1044: Overwrote pending register: R10 in 'AssignReg'

                                                    local r = (string.split)(R10_PC1026, "=")
                                                    -- DECOMPILER ERROR at PC1047: Overwrote pending register: R10 in 'AssignReg'

                                                    -- DECOMPILER ERROR at PC1050: Overwrote pending register: R10 in 'AssignReg'

                                                    if R10_PC1026 == "effecttimes" then
                                                      R10_PC1026 = R10_PC1026(r[2])
                                                      self._effectCountTotal = R10_PC1026
                                                    end
                                                  end
                                                  for _,v in ipairs((string.split)(((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).buffattr, ";")) do
                                                    (table.insert)(R10_PC1026, tonumber(R12_PC1075))
                                                  end
                                                  do
                                                    if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "shieldbuff" then
                                                      local record = (string.split)(self._buffParamter, ";")
                                                      if not dontSetBuffTotalTime then
                                                        for index,param in ipairs(record) do
                                                          -- DECOMPILER ERROR at PC1102: Overwrote pending register: R10 in 'AssignReg'

                                                          local r = (string.split)(R10_PC1026, "=")
                                                          -- DECOMPILER ERROR at PC1105: Overwrote pending register: R10 in 'AssignReg'

                                                          -- DECOMPILER ERROR at PC1108: Overwrote pending register: R10 in 'AssignReg'

                                                          if R10_PC1026 == "time" then
                                                            R10_PC1026(self, tonumber(r[2]))
                                                            break
                                                          end
                                                        end
                                                      end
                                                      do
                                                        for index,param in ipairs(record) do
                                                          -- DECOMPILER ERROR at PC1122: Overwrote pending register: R10 in 'AssignReg'

                                                          local r = (string.split)(R10_PC1026, "=")
                                                          -- DECOMPILER ERROR at PC1125: Overwrote pending register: R10 in 'AssignReg'

                                                          -- DECOMPILER ERROR at PC1126: Overwrote pending register: R10 in 'AssignReg'

                                                          R10_PC1026 = R10_PC1026(r[1], "_value")
                                                          if R10_PC1026 then
                                                            R10_PC1026(self, {(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, R16_PC1141)})
                                                          end
                                                        end
                                                        do
                                                          if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "linkbuff" then
                                                            local record = (string.split)(self._buffParamter, ";")
                                                            if not dontSetBuffTotalTime then
                                                              for index,param in ipairs(record) do
                                                                -- DECOMPILER ERROR at PC1169: Overwrote pending register: R10 in 'AssignReg'

                                                                local r = (string.split)(R10_PC1026, "=")
                                                                -- DECOMPILER ERROR at PC1172: Overwrote pending register: R10 in 'AssignReg'

                                                                -- DECOMPILER ERROR at PC1175: Overwrote pending register: R10 in 'AssignReg'

                                                                if R10_PC1026 == "time" then
                                                                  R10_PC1026(self, tonumber(r[2]))
                                                                  break
                                                                end
                                                              end
                                                            end
                                                            do
                                                              for index,param in ipairs(record) do
                                                                -- DECOMPILER ERROR at PC1189: Overwrote pending register: R10 in 'AssignReg'

                                                                local r = (string.split)(R10_PC1026, "=")
                                                                -- DECOMPILER ERROR at PC1192: Overwrote pending register: R10 in 'AssignReg'

                                                                -- DECOMPILER ERROR at PC1195: Overwrote pending register: R10 in 'AssignReg'

                                                                if R10_PC1026 == "rate" then
                                                                  R10_PC1026 = R10_PC1026(r[2])
                                                                  self._triggerRate = R10_PC1026
                                                                  R10_PC1026 = self._triggerRate
                                                                  if not R10_PC1026 then
                                                                    R10_PC1026 = R10_PC1026(self, {(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, R16_PC1141)})
                                                                    self._triggerRate = R10_PC1026
                                                                  end
                                                                  R10_PC1026 = self._triggerRate
                                                                  if not R10_PC1026 then
                                                                    R10_PC1026 = LogErrorFormat
                                                                    R10_PC1026("buff", "buffid %s skillid %s param [rate] wrong", self._buffID, self._skillid)
                                                                  end
                                                                else
                                                                  R10_PC1026 = string
                                                                  R10_PC1026 = R10_PC1026.find
                                                                  R10_PC1026 = R10_PC1026(r[1], "usetime")
                                                                  if R10_PC1026 then
                                                                    R10_PC1026 = tonumber
                                                                    R10_PC1026 = R10_PC1026(r[2])
                                                                    self._effectCountTotal = R10_PC1026
                                                                  else
                                                                    R10_PC1026 = string
                                                                    R10_PC1026 = R10_PC1026.find
                                                                    R10_PC1026 = R10_PC1026(r[1], "value")
                                                                    -- DECOMPILER ERROR at PC1252: Overwrote pending register: R16 in 'AssignReg'

                                                                    if R10_PC1026 then
                                                                      R10_PC1026(self, {(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, R16_PC1141)})
                                                                    else
                                                                      -- DECOMPILER ERROR at PC1257: Overwrote pending register: R10 in 'AssignReg'

                                                                      -- DECOMPILER ERROR at PC1260: Overwrote pending register: R10 in 'AssignReg'

                                                                      -- DECOMPILER ERROR at PC1268: Overwrote pending register: R16 in 'AssignReg'

                                                                      if R10_PC1026 == "totaldmg" then
                                                                        R10_PC1026 = R10_PC1026(self, {(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, R16_PC1141)})
                                                                        self._totalDamageTriggerCondition = R10_PC1026
                                                                        self._triggerConditionDamageCumulativeNumber = 0
                                                                      else
                                                                        R10_PC1026 = r[1]
                                                                        if R10_PC1026 == "skillnum" then
                                                                          R10_PC1026 = tonumber
                                                                          R10_PC1026 = R10_PC1026(r[2])
                                                                          self._skillTriggerType = R10_PC1026
                                                                        else
                                                                          R10_PC1026 = r[1]
                                                                          if R10_PC1026 == "skillid" then
                                                                            R10_PC1026 = tonumber
                                                                            R10_PC1026 = R10_PC1026(r[2])
                                                                            self._linkBuffLimitSkillid = R10_PC1026
                                                                          else
                                                                            R10_PC1026 = r[1]
                                                                            if R10_PC1026 == "triggercd" then
                                                                              R10_PC1026 = tonumber
                                                                              R10_PC1026 = R10_PC1026(r[2])
                                                                              self._triggerCDTime = R10_PC1026
                                                                            else
                                                                              R10_PC1026 = r[1]
                                                                              if R10_PC1026 == "roundcd" then
                                                                                R10_PC1026 = tonumber
                                                                                R10_PC1026 = R10_PC1026(r[2])
                                                                                self._coolDownTime = R10_PC1026
                                                                              else
                                                                                R10_PC1026 = r[1]
                                                                                if R10_PC1026 == "genertimes" then
                                                                                  R10_PC1026 = tonumber
                                                                                  R10_PC1026 = R10_PC1026(r[2])
                                                                                  self._linkSkillEffectTotalTime = R10_PC1026
                                                                                else
                                                                                  R10_PC1026 = r[1]
                                                                                  if R10_PC1026 == "crazystate" then
                                                                                    R10_PC1026 = tonumber
                                                                                    R10_PC1026 = R10_PC1026(r[2])
                                                                                    local crazyState = nil
                                                                                    if crazyState == 1 then
                                                                                      (((BattleECS.Utility).ProtocolUtility).SendBossEnterViolent)(self._battleWorld)
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
                                                              do
                                                                if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "skillbonusbuff" then
                                                                  local record = (string.split)(self._buffParamter, ";")
                                                                  local isHasTime = false
                                                                  for index,param in ipairs(record) do
                                                                    local r = (string.split)(param, "=")
                                                                    if r[1] == "time" then
                                                                      isHasTime = true
                                                                      if not dontSetBuffTotalTime then
                                                                        self:SetBuffTotalTime(tonumber(r[2]))
                                                                      end
                                                                      break
                                                                    end
                                                                  end
                                                                  do
                                                                    for index,param in ipairs(record) do
                                                                      local r = (string.split)(param, "=")
                                                                      -- DECOMPILER ERROR at PC1394: Overwrote pending register: R16 in 'AssignReg'

                                                                      if (string.find)(r[1], "_value") then
                                                                        self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, R16_PC1141, param)})
                                                                      end
                                                                    end
                                                                    do
                                                                      if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "skillsectionendbuff" then
                                                                        local record = (string.split)(self._buffParamter, ";")
                                                                        local isHasTime = false
                                                                        local r = nil
                                                                        for index,param in ipairs(record) do
                                                                          r = (string.split)(param, "=")
                                                                          if r[1] == "time" then
                                                                            isHasTime = true
                                                                            if not dontSetBuffTotalTime then
                                                                              self:SetBuffTotalTime(tonumber(r[2]))
                                                                            end
                                                                            break
                                                                          end
                                                                        end
                                                                        do
                                                                          local hasFound = false
                                                                          local buffComponent = ((self._entity):GetComponent((BattleECS.Components).BuffComponent))
                                                                          local tempPa = nil
                                                                          for _,pa in ipairs(buffComponent._skillsectionendbuffSnapShoot) do
                                                                            if pa.buffId == self._buffID then
                                                                              pa.buffObj = self
                                                                              tempPa = pa
                                                                              hasFound = true
                                                                              break
                                                                            end
                                                                          end
                                                                          do
                                                                            if not hasFound then
                                                                              (table.insert)(buffComponent._skillsectionendbuffSnapShoot, {buffObj = self, buffId = self._buffID, 
paParams = {}
})
                                                                              tempPa = (buffComponent._skillsectionendbuffSnapShoot)[#buffComponent._skillsectionendbuffSnapShoot]
                                                                            end
                                                                            if tempPa then
                                                                              for index,param in ipairs(record) do
                                                                                -- DECOMPILER ERROR at PC1489: Overwrote pending register: R16 in 'AssignReg'

                                                                                r = (string.split)(param, R16_PC1141)
                                                                                -- DECOMPILER ERROR at PC1495: Overwrote pending register: R16 in 'AssignReg'

                                                                                if (string.find)(r[1], R16_PC1141) then
                                                                                  (table.insert)(tempPa.paParams, R16_PC1141)
                                                                                  R16_PC1141 = {(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, param)}
                                                                                end
                                                                              end
                                                                            else
                                                                              do
                                                                                LogErrorFormat("Buff", "buffid %s skillsectionendbuff snapshoot add failed", self._buffID)
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
  end
end

Buff.PlayBeginEffect = function(self, isNotPlay)
  -- function num : 0_3 , upvalues : _ENV
  if isNotPlay then
    return 
  end
  if self._beginEffectList then
    for _,v in ipairs(self._beginEffectList) do
      do
        if (((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v] and ((((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]).isInEffectSocket == "0" then
          local config = (((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]
          ;
          (((BattleECS.Utility).ProtocolUtility).SendDestroyBuffEffectProtocol)((self._entity)._entityId, config.socket, config.effectName, self._battleWorld)
        end
        if (((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v] then
          if ((((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]).isInEffectSocket == "0" then
            local config = (((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]
            ;
            (((BattleECS.Utility).ProtocolUtility).SendCreateBuffEffectProtocol)(self._entity, config.socket, config.packageName, config.effectName, nil, self._battleWorld)
          else
            do
              if ((((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]).isInEffectSocket == "1" then
                local pos = (self._entity):GetComponent((BattleECS.Components).PositionComponent)
                local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(self._entity)
                local delt = (((BattleECS.Utility).Utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, ((((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]).socket)
                local x, y, z = 0, 0, nil
                local camp = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp
                if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                  x = (pos._position).x + delt.x
                  z = (pos._position).z + delt.z
                else
                  -- DECOMPILER ERROR at PC142: Overwrote pending register: R11 in 'AssignReg'

                  x = (pos._position).x - delt.x
                  z = (pos._position).z + delt.z
                end
                ;
                (((BattleECS.Utility).ProtocolUtility).SCreateSceneEffect)(v, x, y, 0, camp, self._battleWorld, z)
              end
              do
                -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out DO_STMT

              end
            end
          end
        end
      end
    end
  end
end

Buff.PlayEndEffect = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._endEffectList then
    for _,v in ipairs(self._endEffectList) do
      if (((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v] then
        if ((((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]).isInEffectSocket == "0" then
          local config = (((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]
          ;
          (((BattleECS.Utility).ProtocolUtility).SendCreateBuffEffectProtocol)(self._entity, config.socket, config.packageName, config.effectName, nil, self._battleWorld)
        else
          do
            if ((((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]).isInEffectSocket == "1" then
              local pos = (self._entity):GetComponent((BattleECS.Components).PositionComponent)
              local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(self._entity)
              local delt = (((BattleECS.Utility).Utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, ((((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]).socket)
              local x, y, z = 0, 0, nil
              local camp = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp
              if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                x = (pos._position).x + delt.x
                z = (pos._position).z + delt.z
              else
                -- DECOMPILER ERROR at PC109: Overwrote pending register: R10 in 'AssignReg'

                x = (pos._position).x - delt.x
                z = (pos._position).z + delt.z
              end
              ;
              (((BattleECS.Utility).ProtocolUtility).SCreateSceneEffect)(v, x, y, 0, camp, self._battleWorld, z)
            end
            do
              -- DECOMPILER ERROR at PC127: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC127: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC127: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC127: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC127: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

Buff.ChangeShapeToPlayBeginBuffEffect = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._beginEffectList then
    for _,v in ipairs(self._beginEffectList) do
      if (((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v] and ((((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]).isInEffectSocket == "0" then
        local config = (((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]
        ;
        (((BattleECS.Utility).ProtocolUtility).SendCreateBuffEffectProtocol)(self._entity, config.socket, config.packageName, config.effectName, nil, self._battleWorld)
      end
    end
  end
end

Buff.Destroy = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local OverRideType = {Cover = 0, RespectivelyShow = 1, Overlay = 2, OverlayWithoutRefreshTime = 3}
  if self._overrideSelfType == OverRideType.RespectivelyShow then
    for i = 1, self:GetStackTimesCur() do
      if not (self._stackCurrentTime)[i] then
        LogErrorFormat("Buff", "Not Exist StackCurrentTime GetStackTimesCur() = %s,i = %s", self:GetStackTimes(), i)
      else
        ;
        (((BattleECS.Utility).ProtocolUtility).SendUpdateRoleBuffs)((self._entity)._entityId, self._buffID, 0, self._battleWorld, ((self._stackCurrentTime)[i]).index)
      end
    end
    self._stackCurrentTime = {}
  else
    ;
    (((BattleECS.Utility).ProtocolUtility).SendUpdateRoleBuffs)((self._entity)._entityId, self._buffID, 0, self._battleWorld)
  end
  self:BuffEffectEnd()
end

Buff.BuffEffectEnd = function(self)
  -- function num : 0_7 , upvalues : _ENV, SpriteShowType
  if self._buffID ~= 20041 and self._buffID ~= 20045 and self._buffID ~= 20151 and self._buffID ~= 20152 and self._buffID ~= 20153 and self._buffID ~= 20154 then
    self:PlayEndEffect()
  end
  if self._beginEffectList then
    for _,v in ipairs(self._beginEffectList) do
      if (((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v] and ((((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]).isInEffectSocket == "0" then
        local config = (((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]
        ;
        (((BattleECS.Utility).ProtocolUtility).SendDestroyBuffEffectProtocol)((self._entity)._entityId, config.socket, config.effectName, self._battleWorld)
      end
    end
    self._beginEffectList = {}
  end
  if self:GetBuffClassName() == "endbuff" then
    if self._endBuffParamter and self._endBuffParamter ~= "" then
      self:NumbericalCalculation({(((BattleECS.Utility).BuffUtility).ProcessFormulaString)(self._buffID, self._skillid, self._endBuffParamter)})
    end
    if self._buffID == 20346 then
      (self._battleWorld):AddRedPower(((self._entity):GetComponent((BattleECS.Components).BuffComponent))._orderPowerCost)
      ;
      (self._battleWorld):AddBluePower(((self._entity):GetComponent((BattleECS.Components).BuffComponent))._chaosPowerCost)
    end
  end
  if self:GetBuffClassName() == "finishbuff" then
    (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({entity = self._entity, enermyentity = self._entity, buffid = self._onceTimeBuffID, battleworld = self._battleWorld})
  end
  self:DeleteAttribute()
  if self._buffID == 20117 then
    local hasOccur = false
    for _,v in ipairs((self._battleWorld)._leftPlayerPowerIncreaseSpeedList) do
      if v.entityId == (self._entity)._entityId then
        v.speed = 1
        hasOccur = true
        break
      end
    end
    do
      do
        if not hasOccur then
          (table.insert)((self._battleWorld)._leftPlayerPowerIncreaseSpeedList, {entityId = (self._entity)._entityId, speed = 1})
        end
        if self._buffID == 20097 or self._buffID == 20272 then
          (((BattleECS.Utility).PhysicsUtility).SetEntityPhyscisComponentAwake)(self._entity, true)
          ;
          (((BattleECS.Utility).ProtocolUtility).SendChangeEntityHpCellVisible)((self._entity)._entityId, 1, SpriteShowType.Show, self._battleWorld)
        end
        if self._buffID == 20099 then
          (((BattleECS.Utility).PhysicsUtility).SetEntityPhyscisComponentAwake)(self._entity, true)
          ;
          (((BattleECS.Utility).ProtocolUtility).SendChangeEntityHpCellVisible)((self._entity)._entityId, 1, SpriteShowType.None, self._battleWorld)
        end
        if self._buffID == 20168 then
          (((BattleECS.Utility).ProtocolUtility).SendChangeEntityHpCellVisible)((self._entity)._entityId, 1, SpriteShowType.None, self._battleWorld)
        end
        if self._buffID == 20835 then
          (((BattleECS.Utility).ProtocolUtility).SendChangeEntityHpCellVisible)((self._entity)._entityId, -1, SpriteShowType.OnlyShowHitPoint, self._battleWorld)
        end
        if self._hideOptions and self._hideOptions ~= 0 then
          local VisibleType = {HpBar = 2, Sprite = 1}
          local hpBarVisible = -1
          local spriteVisible = -1
          if self._hideOptions & VisibleType.HpBar ~= 0 then
            hpBarVisible = 1
          end
          if self._hideOptions & VisibleType.Sprite ~= 0 then
            spriteVisible = 1
          end
          ;
          (((BattleECS.Utility).ProtocolUtility).SendChangeEntityHpCellVisible)((self._entity)._entityId, hpBarVisible, spriteVisible, self._battleWorld)
          ;
          (((BattleECS.Utility).PhysicsUtility).SetEntityPhyscisComponentAwake)(self._entity, true)
        end
        do
          if self._buffID == 20045 or self._buffID == 20151 or self._buffID == 20152 or self._buffID == 20153 or self._buffID == 20154 then
            local isimaged = 0
            if ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._isImaged then
              isimaged = 1
            end
            ;
            (((BattleECS.Utility).ProtocolUtility).SendUseSkill)(6014101, (self._entity)._entityId, isimaged, ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp, self._battleWorld)
            local component = ((self._entity):GetComponent((BattleECS.Components).PositionComponent))._targetPos
            local x, y = component.x, component.y
            ;
            (self._battleWorld):SetLeftPlayerPositionAndImaged((self._entity)._entityId, x, y, false)
            local attackID = (((BattleECS.Utility).Utility).GetEntityAttackSkillID)(self._entity)
            if attackID then
              for _,skillTable in ipairs(((self._entity):GetComponent((BattleECS.Components).SkillComponent))._skillList) do
                if skillTable.skillId == attackID then
                  skillTable.currentTime = 0
                  break
                end
              end
            end
            do
              do
                if ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._summonName == "partner" then
                  ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._isNeedDestroy = true
                  if (self._entity):GetComponent((BattleECS.Components).PhysicsComponent) then
                    ((self._entity):GetComponent((BattleECS.Components).PhysicsComponent))._isNeedReleaseBox = true
                  end
                end
                if self._buffID == 20084 then
                  (self._battleWorld):SetGuardBuffEntityid(((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp, (self._entity)._entityId, true)
                end
                do
                  if self._buffID == 20168 then
                    local hpChange = -((self._entity):GetComponent((BattleECS.Components).HpComponent))._currentHp
                    ;
                    (((BattleECS.Utility).Utility).ChangeEntityCurrentHp)(self._entity, hpChange)
                    ;
                    (((BattleECS.Utility).ProtocolUtility).IsSendRoleDeadAndDeleteBox2DPhysics)(self._entity, (self._enermyEntity)._entityId, hpChange, self._battleWorld)
                  end
                  if (((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID] then
                    do
                      if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).endingAnimation ~= "" then
                        local ifIgnorePriority = {No = 0, Yes = 1}
                        ;
                        (((BattleECS.Utility).ProtocolUtility).SendBattlerPlayAnimationByNameProtocol)(self._entity, ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).endingAnimation, ifIgnorePriority.Yes, self._battleWorld)
                      end
                      if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).NpcShape ~= "" then
                        local changeToOriginal = true
                        local component = (self._entity):GetComponent((BattleECS.Components).BuffComponent)
                        if component then
                          for _,v in ipairs(component._buffList) do
                            if (v.buffObj):GetIfHaveNpcShapeChangeCfg() and v.buffId ~= self._buffID then
                              changeToOriginal = false
                              break
                            end
                          end
                        end
                        do
                          if changeToOriginal then
                            local protocol = (BattleClientProtocolManager.CreateProtocol)("action.srolechangeshapeandattribute")
                            protocol.entityid = (self._entity)._entityId
                            local roleId = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._roleID
                            local roleRecord = (((BattleECS.Utility).DataUtility).roleConfigTable)[roleId]
                            if not roleRecord then
                              roleRecord = (((BattleECS.Utility).DataUtility).cMonsterCfgTable)[roleId]
                              protocol.shapeid = roleRecord.shapeID
                            else
                              protocol.shapeid = 0
                              protocol.assetBundleName = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._oriShapeAssetBundleName
                              protocol.prefabName = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._oriShapePrefabName
                            end
                            if not roleRecord then
                              LogErrorFormat("Buff", "id %s(entityid %s) not in roleconfig or cmonsterconfig", roleId, (self._entity)._entityId)
                            end
                            ;
                            (self._battleWorld):InsertViewProtocolData(protocol)
                            ;
                            (self._battleWorld):ChangeLeftPlayer(protocol)
                          end
                          do
                            do
                              if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).invincible == 1 then
                                local StateType = {Begin = 0, End = 1}
                                ;
                                (((BattleECS.Utility).ProtocolUtility).SendInvincibleStateChange)((self._entity)._entityId, StateType.End, self._battleWorld)
                              end
                              if self:GetBuffClassName() == "shieldbuff" then
                                local ShowShieldType = {NormalShield = 0}
                                local shieldType = ShowShieldType.NormalShield
                                ;
                                (((BattleECS.Utility).ProtocolUtility).SendShieldValueChange)((self._entity)._entityId, self._buffID, shieldType, 0, self._battleWorld)
                                local _, skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenShieldBuffEnd)(self._entity, self._buffID, self._randomFun)
                                for _,skillStruct in ipairs(skillList) do
                                  (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(self._enermyEntity, skillStruct, self._entity)
                                end
                              end
                              do
                                if self._summonEntity and not (((BattleECS.Utility).Utility).IsRoleDead)(self._summonEntity) then
                                  (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({entity = self._summonEntity, enermyentity = self._entity, buffid = 20000, buffparamter = "time=999999999", skillid = 0, battleworld = self._battleWorld})
                                  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sroledead")
                                  protocol.entityId = (self._summonEntity)._entityId
                                  protocol.damageFrom = (self._entity)._entityId
                                  protocol.damageNum = 0
                                  LogInfoFormat("Buff", "dead summon entityid: %s", (self._summonEntity)._entityId)
                                  ;
                                  (self._battleWorld):InsertViewProtocolData(protocol)
                                end
                                do
                                  do
                                    if self._buffID == 20776 then
                                      local StateType = {Begin = 0, Over = 1}
                                      ;
                                      (((BattleECS.Utility).ProtocolUtility).SendActorTimeSkillState)(StateType.Over, self._battleWorld)
                                    end
                                    -- DECOMPILER ERROR at PC697: Confused about usage of register: R1 in 'UnsetPending'

                                    if self._buffID == 20910 then
                                      (self._battleWorld)._redPowerMax = (self._battleWorld)._redPowerMax + tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[2]).attr)
                                      ;
                                      (((BattleECS.Utility).ProtocolUtility).SendShowOrderPowerSpecialUIEffect)(-1, (((BattleECS.Utility).DataUtility).GetPowerGridFunc)((self._battleWorld)._redPowerMax, (((BattleECS.Utility).DataUtility).PowerType).Blue), self._battleWorld)
                                    end
                                    if self._selfIsHasChangeBuffIndex then
                                      (table.remove)(((self._entity):GetComponent((BattleECS.Components).BuffComponent))._isHasChangeBuff, self._selfIsHasChangeBuffIndex)
                                    end
                                    local removeList = {}
                                    local buffComponent = (self._entity):GetComponent((BattleECS.Components).BuffComponent)
                                    for i,pa in ipairs(buffComponent._skillsectionendbuffSnapShoot) do
                                      if pa.buffId == self._buffID then
                                        (table.insert)(removeList, 1, R11_PC751)
                                      end
                                    end
                                    for _,i in ipairs(removeList) do
                                      (table.remove)(buffComponent._skillsectionendbuffSnapShoot, R10_PC762)
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

Buff.SetBuffTotalTime = function(self, time)
  -- function num : 0_8 , upvalues : _ENV
  self._totalTime = time
  local OverRideType = {Cover = 0, RespectivelyShow = 1, Overlay = 2, OverlayWithoutRefreshTime = 3}
  if self._overrideSelfType == OverRideType.RespectivelyShow then
    for i = 1, self:GetStackTimesCur() do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

      if not (self._stackCurrentTime)[i] then
        (self._stackCurrentTime)[i] = {currentTime = self._totalTime, index = i}
        do
          do
            if (self._stackCurrentTime)[i - 1] then
              local indexValue = (((self._stackCurrentTime)[i - 1]).index + 1) % self._maxStackTimes
              if indexValue == 0 then
                indexValue = self._maxStackTimes
              end
              -- DECOMPILER ERROR at PC42: Confused about usage of register: R8 in 'UnsetPending'

              ;
              ((self._stackCurrentTime)[i]).index = indexValue
            end
            ;
            (((BattleECS.Utility).ProtocolUtility).SendUpdateRoleBuffs)((self._entity)._entityId, self._buffID, ((self._stackCurrentTime)[i]).currentTime, self._battleWorld, ((self._stackCurrentTime)[i]).index)
            -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  else
    ;
    (((BattleECS.Utility).ProtocolUtility).SendUpdateRoleBuffs)((self._entity)._entityId, self._buffID, self._totalTime, self._battleWorld)
  end
end

Buff.SetStackTimes = function(self, time)
  -- function num : 0_9
  self._stackTimes = time
end

Buff.SetStackTimesCur = function(self, time)
  -- function num : 0_10
  self._stackTimesCur = time
end

Buff.SetBuffParam = function(self, param)
  -- function num : 0_11
  self._buffParamter = param
end

Buff.SetEnermyEntity = function(self, entity)
  -- function num : 0_12
  self._enermyEntity = entity
end

Buff.SetSkillid = function(self, skillid)
  -- function num : 0_13
  self._skillid = skillid
end

Buff.SetOriginalBuffId = function(self, originalBuffId)
  -- function num : 0_14
  if not originalBuffId then
    self._originalBuffId = self._buffID
  end
end

Buff.SetIsConnect = function(self, isconnect)
  -- function num : 0_15
  self._isConnect = isconnect
end

Buff.SetBuffEffectCount = function(self, num)
  -- function num : 0_16 , upvalues : _ENV
  self._effectCount = num
  if self._effectCountTotal and self._effectCountTotal == self._effectCount then
    (((BattleECS.Utility).BuffUtility).RemoveEntityBuff)(self._entity, self._buffID)
  end
end

Buff.SetBuffContinuedTime = function(self, time, isNotReloadPlayEffect, addStackCurrentTime, updateBuffWithoutRefreshTime)
  -- function num : 0_17 , upvalues : _ENV
  local cBuffConfigRecorder = (((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]
  self._currentTime = time
  if self._triggerCDCountTime then
    self._triggerCDCountTime = self._triggerCDCountTime + 1
  end
  if not self:IsCDOver() then
    return 
  end
  local OverRideType = {Cover = 0, RespectivelyShow = 1, Overlay = 2, OverlayWithoutRefreshTime = 3}
  if addStackCurrentTime and self._overrideSelfType == OverRideType.RespectivelyShow then
    local removeilist = {}
    for i = 1, self:GetStackTimesCur() do
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R12 in 'UnsetPending'

      if (self._stackCurrentTime)[i] then
        ((self._stackCurrentTime)[i]).currentTime = ((self._stackCurrentTime)[i]).currentTime - 1
        if ((self._stackCurrentTime)[i]).currentTime == 0 then
          self:DeleteTheStackTimesAttribute(((self._stackCurrentTime)[i]).index)
          ;
          (((BattleECS.Utility).ProtocolUtility).SendUpdateRoleBuffs)((self._entity)._entityId, self._buffID, ((self._stackCurrentTime)[i]).currentTime, self._battleWorld, ((self._stackCurrentTime)[i]).index)
          ;
          (table.insert)(removeilist, 1, i)
        end
      end
    end
    for _,i in ipairs(removeilist) do
      (table.remove)(self._stackCurrentTime, i)
      self:SetStackTimesCur(self:GetStackTimesCur() - 1)
    end
  else
    do
      if self._overrideSelfType == OverRideType.OverlayWithoutRefreshTime and updateBuffWithoutRefreshTime then
        self:InitContinueBuffInfo(true)
        ;
        (((BattleECS.Utility).ProtocolUtility).SendUpdateRoleBuffs)((self._entity)._entityId, self._buffID, self._totalTime - self._currentTime, self._battleWorld)
      end
      if self._maxStackTimes < self:GetStackTimesCur() then
        self:SetStackTimesCur(self._maxStackTimes)
        ;
        (((BattleECS.Utility).ProtocolUtility).SendUpdateRoleBuffs)((self._entity)._entityId, self._buffID, self._totalTime, self._battleWorld)
        return 
      end
      if self:GetStackTimesCur() < 0 then
        self:SetStackTimesCur(0)
        return 
      end
      if self:GetStackTimes() > 0 and self:GetStackTimes() <= 1 and self._currentTime == 0 then
        (((BattleECS.Utility).ProtocolUtility).SendUpdateRoleBuffs)((self._entity)._entityId, self._buffID, self._totalTime, self._battleWorld)
        return 
      end
      if self._currentTime == 0 then
        self:InitContinueBuffInfo()
        self:PlayBeginEffect(isNotReloadPlayEffect)
        self:PlayTriggerAnimation()
      end
      if self._onceTimeBuffID and self._effectTime then
        local _, t = (math.modf)(self._currentTime / self._effectTime)
        if tonumber(t) == 0 then
          self._timecellEffectTimes = self._timecellEffectTimes + 1
          if self._effectNum and self._effectOrder then
            local entitylist = (((BattleECS.Utility).BuffUtility).GetSpecialRoundBuffTargetEntityList)(self._entity, self._battleWorld, self._effectOrder, self._effectNum)
            for _,v in ipairs(entitylist) do
              (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({entity = v, enermyentity = self._entity, buffid = self._onceTimeBuffID, buffparamter = self._numParamter, skillid = self._skillid, battleworld = self._battleWorld, originalBuffId = self._originalBuffId})
            end
          else
            do
              do
                local isPlayAttackedEffect = 1
                if cBuffConfigRecorder and cBuffConfigRecorder.isEffectAtt == 0 then
                  isPlayAttackedEffect = 0
                end
                ;
                (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({entity = self._entity, enermyentity = self._enermyEntity, buffid = self._onceTimeBuffID, buffparamter = self._numParamter, skillid = self._skillid, battleworld = self._battleWorld, isplayattackedeffect = isPlayAttackedEffect, originalBuffId = self._originalBuffId})
                if self:GetBuffClassName() == "readbuff" and time >= 0 then
                  for _,param in ipairs(self._readbuffParamterWithValue) do
                    self:NumbericalCalculation(param)
                  end
                end
                do
                  if self._buffID == 20045 or self._buffID == 20151 or self._buffID == 20152 or self._buffID == 20153 or self._buffID == 20154 then
                    local delt = 0
                    if self._buffID == 20045 or self._buffID == 20151 or self._buffID == 20152 or self._buffID == 20153 or self._buffID == 20154 then
                      delt = (((BattleECS.Utility).Utility).GetMonsterOrRoleMagicOrAttackEndFraps)(self._entity, self._skillid)
                    end
                    if self._currentTime == self._totalTime - delt then
                      for _,v in ipairs(self._endEffectList) do
                        local config = (((BattleECS.Utility).DataUtility).cBuffEffectCfgTable)[v]
                        ;
                        (((BattleECS.Utility).ProtocolUtility).SendCreateBuffEffectProtocol)(self._entity, config.socket, config.packageName, config.effectName, nil, self._battleWorld)
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

Buff.IsCDOver = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self._coolDownTime == 0 or self._currentTime % self._coolDownTime == 0 then
    if self._coolDownTime ~= 0 then
      local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenCDComeToZero)(self._entity, self._randomFun, self._buffID)
      for _,v in ipairs(skillList) do
        (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(self._entity, v, self._entity)
      end
    end
    do
      do return true end
      return false
    end
  end
end

Buff.IsTriggerCDOver = function(self)
  -- function num : 0_19
  if self._triggerCDTime == 0 or not self._triggerCDCountTime or self._triggerCDTime <= self._triggerCDCountTime then
    if self._triggerCDCountTime and self._triggerCDTime <= self._triggerCDCountTime then
      self._triggerCDCountTime = nil
    end
    return true
  end
  return false
end

Buff.ResetTriggerCDCountTime = function(self)
  -- function num : 0_20
  if not self._triggerCDCountTime then
    self._triggerCDCountTime = 0
  end
end

Buff.DeleteAttribute = function(self, attributename)
  -- function num : 0_21 , upvalues : _ENV
  for _,v in ipairs(self._buffAdditionalAttribute) do
    if (attributename and attributename == v.key) or not attributename then
      if v.key == "defend_value" then
        ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackDefense = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackDefense - v.value
      else
        if v.key == "maxhp_value" then
          ((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp = ((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp - v.value
        else
          if v.key == "attack_value" then
            ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attack = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attack - v.value
          else
            if v.key == "physicalbonus_value" then
              ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackDamageAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackDamageAddition - v.value
            else
              if v.key == "magicbonus_value" then
                ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicDamageAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicDamageAddition - v.value
              else
                if v.key == "magicdef_value" then
                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicDefense = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicDefense - v.value
                else
                  if v.key == "physicalreduce_value" then
                    ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackDefenseAddition = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackDefenseAddition - v.value
                  else
                    if v.key == "magicreduce_value" then
                      ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicDefenseAddition = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicDefenseAddition - v.value
                    else
                      if v.key == "magiclifesteal_value" then
                        ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicSuckBlood = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicSuckBlood - v.value
                      else
                        if v.key == "physicallifesteal_value" then
                          ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackSuckBlood = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackSuckBlood - v.value
                        else
                          if v.key == "attackspeed_value" then
                            ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackSpeed = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackSpeed - v.value
                          else
                            if v.key == "physicalblock_value" then
                              ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackInjuryReduceNumber = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackInjuryReduceNumber - v.value
                            else
                              if v.key == "magicblock_value" then
                                ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicInjuryReduceNumber = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicInjuryReduceNumber - v.value
                              else
                                if v.key == "evasion_value" then
                                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackMiss = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackMiss - v.value
                                else
                                  if v.key == "physicaldefbreak_value" then
                                    ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackDefBreak = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackDefBreak - v.value
                                  else
                                    if v.key == "magicdefbreak_value" then
                                      ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicDefBreak = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicDefBreak - v.value
                                    else
                                      if v.key == "critrate_value" then
                                        ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritRate = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritRate - v.value
                                      else
                                        if v.key == "critdegree_value" then
                                          ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegree = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegree - v.value
                                        else
                                          if v.key == "critrateresistance_value" then
                                            ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackCritDefense = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackCritDefense - v.value
                                          else
                                            if v.key == "critdegreeresistance_value" then
                                              ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackCritDegreeDefense = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackCritDegreeDefense - v.value
                                            else
                                              if v.key == "extraphysicaldmg_value" then
                                                ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackAddition - v.value
                                              else
                                                if v.key == "extramagicdmg_value" then
                                                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicAddition - v.value
                                                else
                                                  if v.key == "curativeadd_value" then
                                                    ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._treatmentAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._treatmentAddition - v.value
                                                  else
                                                    if v.key == "accuracy_value" then
                                                      ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._hitRate = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._hitRate - v.value
                                                    else
                                                      if v.key == "dmgskilladd_value" then
                                                        ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._skillDamageBonus = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._skillDamageBonus - v.value
                                                      else
                                                        if v.key == "healskilladd_value" then
                                                          ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._skillTreeteBonus = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._skillTreeteBonus - v.value
                                                        else
                                                          if v.key == "shield_value" .. self._buffID then
                                                            local removeList = {}
                                                            for i = #((self._entity):GetComponent((BattleECS.Components).HpComponent))._damageSheildNumberList, 1, -1 do
                                                              local inV = (((self._entity):GetComponent((BattleECS.Components).HpComponent))._damageSheildNumberList)[i]
                                                              if inV.buffid == self._buffID then
                                                                (table.insert)(removeList, i)
                                                              end
                                                            end
                                                            for _,i in ipairs(removeList) do
                                                              (table.remove)(((self._entity):GetComponent((BattleECS.Components).HpComponent))._damageSheildNumberList, i)
                                                            end
                                                          else
                                                            do
                                                              if v.key == "combonum_value" then
                                                                local component = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
                                                                component._comboNumber = component._comboNumber - v.value
                                                                component._comboNumber = (fixedpoint.max)(fixedpoint_zero, component._comboNumber)
                                                              else
                                                                do
                                                                  if v.key == "bosscombonum_value" then
                                                                    local component = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
                                                                    component._bossComboNumber = component._bossComboNumber - v.value
                                                                    component._bossComboNumber = (fixedpoint.max)(0, component._bossComboNumber)
                                                                  else
                                                                    do
                                                                      if v.key == "cooldownreduce_value" then
                                                                        local component = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
                                                                        component._skillCoolDownReduce = component._skillCoolDownReduce - v.value
                                                                        for _,inValue in ipairs(component._skillList) do
                                                                          if ((((BattleECS.Utility).DataUtility).cskillTable)[inValue.skillId]).effecttype == 2 then
                                                                            inValue.cdTime = inValue.cdTime / ((100 - v.value) / 100)
                                                                          end
                                                                        end
                                                                      else
                                                                        do
                                                                          if v.key == "passiveskill_value" then
                                                                            local component = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
                                                                            component._isHasPassiveSkillParamter = component._isHasPassiveSkillParamter - v.value
                                                                            component._isHasPassiveSkillParamter = (fixedpoint.max)(0, component._isHasPassiveSkillParamter)
                                                                          else
                                                                            do
                                                                              if v.key == "ordercostreduce_value" then
                                                                                local component = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
                                                                                -- DECOMPILER ERROR at PC694: Confused about usage of register: R8 in 'UnsetPending'

                                                                                ;
                                                                                (component._skillCostPowerReduceList).order = (component._skillCostPowerReduceList).order - v.value
                                                                                -- DECOMPILER ERROR at PC702: Confused about usage of register: R8 in 'UnsetPending'

                                                                                ;
                                                                                (component._skillCostPowerReduceList).order = (fixedpoint.max)(0, (component._skillCostPowerReduceList).order)
                                                                                ;
                                                                                (((BattleECS.Utility).ProtocolUtility).SendRoleSkillPowerReduce)((self._entity)._entityId, (component._skillCostPowerReduceList).order, (component._skillCostPowerReduceList).chaos, self._battleWorld)
                                                                              else
                                                                                do
                                                                                  if v.key == "chaoscostreduce_value" then
                                                                                    local component = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
                                                                                    -- DECOMPILER ERROR at PC730: Confused about usage of register: R8 in 'UnsetPending'

                                                                                    ;
                                                                                    (component._skillCostPowerReduceList).chaos = (component._skillCostPowerReduceList).chaos - v.value
                                                                                    -- DECOMPILER ERROR at PC738: Confused about usage of register: R8 in 'UnsetPending'

                                                                                    ;
                                                                                    (component._skillCostPowerReduceList).chaos = (fixedpoint.max)(0, (component._skillCostPowerReduceList).chaos)
                                                                                    ;
                                                                                    (((BattleECS.Utility).ProtocolUtility).SendRoleSkillPowerReduce)((self._entity)._entityId, (component._skillCostPowerReduceList).order, (component._skillCostPowerReduceList).chaos, self._battleWorld)
                                                                                  else
                                                                                    do
                                                                                      if v.key == "critratelev_value" then
                                                                                        ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritLevel = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritLevel - v.value
                                                                                        ;
                                                                                        ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritLevel = getcritlevelsection(((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritLevel)
                                                                                      else
                                                                                        if v.key == "critdegreelev_value" then
                                                                                          ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegreeLevel = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegreeLevel - v.value
                                                                                          ;
                                                                                          ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegreeLevel = getcritdegreesection(((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegreeLevel)
                                                                                        else
                                                                                          -- DECOMPILER ERROR at PC840: Confused about usage of register: R7 in 'UnsetPending'

                                                                                          if (string.match)(v.key, "buff%d+num_value") then
                                                                                            (((self._entity):GetComponent((BattleECS.Components).BuffComponent))._buffnum)[v.key] = fixedpoint_zero
                                                                                          else
                                                                                            -- DECOMPILER ERROR at PC860: Unhandled construct in 'MakeBoolean' P1

                                                                                            if v.key == "orderpwrgrow_value" and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                                                                                              local isremove = true
                                                                                              for _,v in ipairs((self._battleWorld)._leftPlayerList) do
                                                                                                if v._entityId ~= (self._entity)._entityId and (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(v, self._buffID) then
                                                                                                  isremove = false
                                                                                                  break
                                                                                                end
                                                                                              end
                                                                                              do
                                                                                                if isremove then
                                                                                                  for i,v in ipairs((self._battleWorld)._battleWorldPowerIncreaseSpeed) do
                                                                                                    if v.buffid == self._buffID then
                                                                                                      (table.remove)((self._battleWorld)._battleWorldPowerIncreaseSpeed, i)
                                                                                                      break
                                                                                                    end
                                                                                                  end
                                                                                                end
                                                                                                do
                                                                                                  if v.key == "magicevasion_value" then
                                                                                                    ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicEvasion = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicEvasion - v.value
                                                                                                  else
                                                                                                    if v.key == "physicalevasion_value" then
                                                                                                      ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._physicalEvasion = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._physicalEvasion - v.value
                                                                                                    else
                                                                                                      if v.key == "phydmglimit" then
                                                                                                        ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._phyDmgLimit = -fixedpoint.maxinteger
                                                                                                      else
                                                                                                        if v.key == "magicdmglimit" then
                                                                                                          ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._magicDmgLimit = -fixedpoint.maxinteger
                                                                                                        else
                                                                                                          if v.key == "dmglimitrate" then
                                                                                                            ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._dmgLimitRate = fixedpoint_zero
                                                                                                          else
                                                                                                            if v.key == "dmglimitrate_value" then
                                                                                                              ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._dmgLimitRate = ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._dmgLimitRate - v.value
                                                                                                            else
                                                                                                              if v.key == "attacktime_value" then
                                                                                                                ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._attackTime = ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._attackTime - v.value
                                                                                                              else
                                                                                                                if v.key == "phydmgmax" then
                                                                                                                  ((self._enermyEntity):GetComponent((BattleECS.Components).BuffComponent))._bringOutPhyDmgLimit = -fixedpoint.maxinteger
                                                                                                                else
                                                                                                                  if v.key == "magicdmgmax" then
                                                                                                                    ((self._enermyEntity):GetComponent((BattleECS.Components).BuffComponent))._bringOutMagicDmgLimit = -fixedpoint.maxinteger
                                                                                                                  else
                                                                                                                    -- DECOMPILER ERROR at PC1070: Unhandled construct in 'MakeBoolean' P1

                                                                                                                    if v.key == "enemyorderpwrgrow_value" and ((self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                                                                                                                      local isremove = true
                                                                                                                      for _,v in ipairs((self._battleWorld)._rightPlayerList) do
                                                                                                                        if v._entityId ~= (self._enermyEntity)._entityId and (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(v, self._buffID) then
                                                                                                                          isremove = false
                                                                                                                          break
                                                                                                                        end
                                                                                                                      end
                                                                                                                      do
                                                                                                                        if isremove then
                                                                                                                          for i,v in ipairs((self._battleWorld)._battleWorldPowerIncreaseSpeed) do
                                                                                                                            if v.buffid == self._buffID then
                                                                                                                              (table.remove)((self._battleWorld)._battleWorldPowerIncreaseSpeed, i)
                                                                                                                              break
                                                                                                                            end
                                                                                                                          end
                                                                                                                        end
                                                                                                                        do
                                                                                                                          do
                                                                                                                            if v.key == "damagereduce_value" then
                                                                                                                              ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._damageReduce = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._damageReduce - v.value
                                                                                                                            else
                                                                                                                              if v.key == "runelv_value" then
                                                                                                                                ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._runelv = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._runelv - v.value
                                                                                                                              end
                                                                                                                            end
                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1153: LeaveBlock: unexpected jumping out IF_STMT

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
        end
      end
    end
  end
end

Buff.DeleteTheStackTimesAttribute = function(self, stackTimeCur)
  -- function num : 0_22 , upvalues : _ENV
  if (self._everyStackTimesBuffAdditionalAttribute)[stackTimeCur] then
    for _,v in ipairs(self._buffAdditionalAttribute) do
      for _,inV in ipairs((self._everyStackTimesBuffAdditionalAttribute)[stackTimeCur]) do
        if inV.key == v.key then
          v.value = v.value - inV.value
        end
      end
    end
    for k,v in ipairs((self._everyStackTimesBuffAdditionalAttribute)[stackTimeCur]) do
      if v.key == "defend_value" then
        ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackDefense = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackDefense - v.value
      else
        if v.key == "maxhp_value" then
          ((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp = ((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp - v.value
        else
          if v.key == "attack_value" then
            ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attack = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attack - v.value
          else
            if v.key == "physicalbonus_value" then
              ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackDamageAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackDamageAddition - v.value
            else
              if v.key == "magicbonus_value" then
                ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicDamageAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicDamageAddition - v.value
              else
                if v.key == "magicdef_value" then
                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicDefense = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicDefense - v.value
                else
                  if v.key == "physicalreduce_value" then
                    ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackDefenseAddition = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackDefenseAddition - v.value
                  else
                    if v.key == "magicreduce_value" then
                      ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicDefenseAddition = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicDefenseAddition - v.value
                    else
                      if v.key == "magiclifesteal_value" then
                        ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicSuckBlood = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicSuckBlood - v.value
                      else
                        if v.key == "physicallifesteal_value" then
                          ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackSuckBlood = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackSuckBlood - v.value
                        else
                          if v.key == "attackspeed_value" then
                            ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackSpeed = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackSpeed - v.value
                          else
                            if v.key == "physicalblock_value" then
                              ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackInjuryReduceNumber = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackInjuryReduceNumber - v.value
                            else
                              if v.key == "magicblock_value" then
                                ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicInjuryReduceNumber = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicInjuryReduceNumber - v.value
                              else
                                if v.key == "evasion_value" then
                                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackMiss = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackMiss - v.value
                                else
                                  if v.key == "physicaldefbreak_value" then
                                    ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackDefBreak = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackDefBreak - v.value
                                  else
                                    if v.key == "magicdefbreak_value" then
                                      ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicDefBreak = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicDefBreak - v.value
                                    else
                                      if v.key == "critrate_value" then
                                        ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritRate = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritRate - v.value
                                      else
                                        if v.key == "critdegree_value" then
                                          ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegree = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegree - v.value
                                        else
                                          if v.key == "critrateresistance_value" then
                                            ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackCritDefense = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackCritDefense - v.value
                                          else
                                            if v.key == "critdegreeresistance_value" then
                                              ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackCritDegreeDefense = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackCritDegreeDefense - v.value
                                            else
                                              if v.key == "extraphysicaldmg_value" then
                                                ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackAddition - v.value
                                              else
                                                if v.key == "extramagicdmg_value" then
                                                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicAddition - v.value
                                                else
                                                  if v.key == "curativeadd_value" then
                                                    ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._treatmentAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._treatmentAddition - v.value
                                                  else
                                                    if v.key == "accuracy_value" then
                                                      ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._hitRate = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._hitRate - v.value
                                                    else
                                                      if v.key == "dmgskilladd_value" then
                                                        ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._skillDamageBonus = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._skillDamageBonus - v.value
                                                      else
                                                        if v.key == "healskilladd_value" then
                                                          ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._skillTreeteBonus = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._skillTreeteBonus - v.value
                                                        else
                                                          if v.key == "shield_value" .. self._buffID then
                                                            local removeList = {}
                                                            for i = #((self._entity):GetComponent((BattleECS.Components).HpComponent))._damageSheildNumberList, 1, -1 do
                                                              local inV = (((self._entity):GetComponent((BattleECS.Components).HpComponent))._damageSheildNumberList)[i]
                                                              if inV.buffid == self._buffID then
                                                                (table.insert)(removeList, i)
                                                              end
                                                            end
                                                            for _,i in ipairs(removeList) do
                                                              (table.remove)(((self._entity):GetComponent((BattleECS.Components).HpComponent))._damageSheildNumberList, i)
                                                            end
                                                          else
                                                            do
                                                              if v.key == "combonum_value" then
                                                                local component = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
                                                                component._comboNumber = component._comboNumber - v.value
                                                                component._comboNumber = (fixedpoint.max)(fixedpoint_zero, component._comboNumber)
                                                              else
                                                                do
                                                                  if v.key == "bosscombonum_value" then
                                                                    local component = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
                                                                    component._bossComboNumber = component._bossComboNumber - v.value
                                                                    component._bossComboNumber = (fixedpoint.max)(0, component._bossComboNumber)
                                                                  else
                                                                    do
                                                                      if v.key == "cooldownreduce_value" then
                                                                        local component = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
                                                                        component._skillCoolDownReduce = component._skillCoolDownReduce - v.value
                                                                        for _,inValue in ipairs(component._skillList) do
                                                                          if ((((BattleECS.Utility).DataUtility).cskillTable)[inValue.skillId]).effecttype == 2 then
                                                                            inValue.cdTime = inValue.cdTime / ((100 - v.value) / 100)
                                                                          end
                                                                        end
                                                                      else
                                                                        do
                                                                          if v.key == "passiveskill_value" then
                                                                            local component = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
                                                                            component._isHasPassiveSkillParamter = component._isHasPassiveSkillParamter - v.value
                                                                            component._isHasPassiveSkillParamter = (fixedpoint.max)(0, component._isHasPassiveSkillParamter)
                                                                          else
                                                                            do
                                                                              if v.key == "ordercostreduce_value" then
                                                                                local component = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
                                                                                -- DECOMPILER ERROR at PC713: Confused about usage of register: R8 in 'UnsetPending'

                                                                                ;
                                                                                (component._skillCostPowerReduceList).order = (component._skillCostPowerReduceList).order - v.value
                                                                                -- DECOMPILER ERROR at PC721: Confused about usage of register: R8 in 'UnsetPending'

                                                                                ;
                                                                                (component._skillCostPowerReduceList).order = (fixedpoint.max)(0, (component._skillCostPowerReduceList).order)
                                                                                ;
                                                                                (((BattleECS.Utility).ProtocolUtility).SendRoleSkillPowerReduce)((self._entity)._entityId, (component._skillCostPowerReduceList).order, (component._skillCostPowerReduceList).chaos, self._battleWorld)
                                                                              else
                                                                                do
                                                                                  if v.key == "chaoscostreduce_value" then
                                                                                    local component = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
                                                                                    -- DECOMPILER ERROR at PC749: Confused about usage of register: R8 in 'UnsetPending'

                                                                                    ;
                                                                                    (component._skillCostPowerReduceList).chaos = (component._skillCostPowerReduceList).chaos - v.value
                                                                                    -- DECOMPILER ERROR at PC757: Confused about usage of register: R8 in 'UnsetPending'

                                                                                    ;
                                                                                    (component._skillCostPowerReduceList).chaos = (fixedpoint.max)(0, (component._skillCostPowerReduceList).chaos)
                                                                                    ;
                                                                                    (((BattleECS.Utility).ProtocolUtility).SendRoleSkillPowerReduce)((self._entity)._entityId, (component._skillCostPowerReduceList).order, (component._skillCostPowerReduceList).chaos, self._battleWorld)
                                                                                  else
                                                                                    do
                                                                                      if v.key == "critratelev_value" then
                                                                                        ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritLevel = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritLevel - v.value
                                                                                        ;
                                                                                        ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritLevel = getcritlevelsection(((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritLevel)
                                                                                      else
                                                                                        if v.key == "critdegreelev_value" then
                                                                                          ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegreeLevel = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegreeLevel - v.value
                                                                                          ;
                                                                                          ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegreeLevel = getcritdegreesection(((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegreeLevel)
                                                                                        else
                                                                                          -- DECOMPILER ERROR at PC859: Confused about usage of register: R7 in 'UnsetPending'

                                                                                          if (string.match)(v.key, "buff%d+num_value") then
                                                                                            (((self._entity):GetComponent((BattleECS.Components).BuffComponent))._buffnum)[v.key] = fixedpoint_zero
                                                                                          else
                                                                                            -- DECOMPILER ERROR at PC879: Unhandled construct in 'MakeBoolean' P1

                                                                                            if v.key == "orderpwrgrow_value" and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                                                                                              local isremove = true
                                                                                              for _,v in ipairs((self._battleWorld)._leftPlayerList) do
                                                                                                if v._entityId ~= (self._entity)._entityId and (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(v, self._buffID) then
                                                                                                  isremove = false
                                                                                                  break
                                                                                                end
                                                                                              end
                                                                                              do
                                                                                                if isremove then
                                                                                                  for i,v in ipairs((self._battleWorld)._battleWorldPowerIncreaseSpeed) do
                                                                                                    if v.buffid == self._buffID then
                                                                                                      (table.remove)((self._battleWorld)._battleWorldPowerIncreaseSpeed, i)
                                                                                                      break
                                                                                                    end
                                                                                                  end
                                                                                                end
                                                                                                do
                                                                                                  if v.key == "magicevasion_value" then
                                                                                                    ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicEvasion = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicEvasion - v.value
                                                                                                  else
                                                                                                    if v.key == "physicalevasion_value" then
                                                                                                      ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._physicalEvasion = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._physicalEvasion - v.value
                                                                                                    else
                                                                                                      if v.key == "phydmglimit" then
                                                                                                        ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._phyDmgLimit = -fixedpoint.maxinteger
                                                                                                      else
                                                                                                        if v.key == "magicdmglimit" then
                                                                                                          ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._magicDmgLimit = -fixedpoint.maxinteger
                                                                                                        else
                                                                                                          if v.key == "dmglimitrate" then
                                                                                                            ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._dmgLimitRate = fixedpoint_zero
                                                                                                          else
                                                                                                            if v.key == "dmglimitrate_value" then
                                                                                                              ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._dmgLimitRate = ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._dmgLimitRate - v.value
                                                                                                            else
                                                                                                              if v.key == "attacktime_value" then
                                                                                                                ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._attackTime = ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._attackTime - v.value
                                                                                                              else
                                                                                                                if v.key == "phydmgmax" then
                                                                                                                  ((self._enermyEntity):GetComponent((BattleECS.Components).BuffComponent))._bringOutPhyDmgLimit = -fixedpoint.maxinteger
                                                                                                                else
                                                                                                                  if v.key == "magicdmgmax" then
                                                                                                                    ((self._enermyEntity):GetComponent((BattleECS.Components).BuffComponent))._bringOutMagicDmgLimit = -fixedpoint.maxinteger
                                                                                                                  else
                                                                                                                    -- DECOMPILER ERROR at PC1089: Unhandled construct in 'MakeBoolean' P1

                                                                                                                    if v.key == "enemyorderpwrgrow_value" and ((self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                                                                                                                      local isremove = true
                                                                                                                      for _,v in ipairs((self._battleWorld)._rightPlayerList) do
                                                                                                                        if v._entityId ~= (self._enermyEntity)._entityId and (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(v, self._buffID) then
                                                                                                                          isremove = false
                                                                                                                          break
                                                                                                                        end
                                                                                                                      end
                                                                                                                      do
                                                                                                                        if isremove then
                                                                                                                          for i,v in ipairs((self._battleWorld)._battleWorldPowerIncreaseSpeed) do
                                                                                                                            if v.buffid == self._buffID then
                                                                                                                              (table.remove)((self._battleWorld)._battleWorldPowerIncreaseSpeed, i)
                                                                                                                              break
                                                                                                                            end
                                                                                                                          end
                                                                                                                        end
                                                                                                                        do
                                                                                                                          do
                                                                                                                            if v.key == "damagereduce_value" then
                                                                                                                              ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._damageReduce = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._damageReduce - v.value
                                                                                                                            else
                                                                                                                              if v.key == "runelv_value" then
                                                                                                                                ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._runelv = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._runelv - v.value
                                                                                                                              end
                                                                                                                            end
                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                            -- DECOMPILER ERROR at PC1172: LeaveBlock: unexpected jumping out IF_STMT

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
        end
      end
    end
    -- DECOMPILER ERROR at PC1175: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._everyStackTimesBuffAdditionalAttribute)[stackTimeCur] = nil
  end
end

Buff.ClearBuffAdditionalAttribute = function(self)
  -- function num : 0_23
  self:DeleteAttribute()
  self._buffAdditionalAttribute = {}
end

Buff.SetBuffIsEffect = function(self, state)
  -- function num : 0_24 , upvalues : _ENV
  self._isEffect = state
  if not self._isEffect then
    self:BuffEffectEnd()
  else
    self:PlayBeginEffect()
    if self._buffID == 20117 then
      local hasOccur = false
      for _,v in ipairs((self._battleWorld)._leftPlayerPowerIncreaseSpeedList) do
        if v.entityId == (self._entity)._entityId then
          v.speed = fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[67]).attr) / 1000
          hasOccur = true
          break
        end
      end
      do
        if not hasOccur then
          (table.insert)((self._battleWorld)._leftPlayerPowerIncreaseSpeedList, {entityId = (self._entity)._entityId, speed = fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[67]).attr) / 1000})
        end
      end
    end
  end
end

Buff.GetBuffTotalTime = function(self)
  -- function num : 0_25
  return self._totalTime
end

Buff.GetBuffContinuedTime = function(self)
  -- function num : 0_26
  return self._currentTime
end

Buff.GetBuffIsEffect = function(self)
  -- function num : 0_27
  return self._isEffect
end

Buff.GetLinkBuffLimitSkillid = function(self)
  -- function num : 0_28
  return self._linkBuffLimitSkillid
end

Buff.GetBuffRemainTime = function(self)
  -- function num : 0_29
  return self._totalTime - self._currentTime
end

Buff.GetBuffEffectCount = function(self)
  -- function num : 0_30
  return self._effectCount
end

Buff.GetBuffEffectCountTotal = function(self)
  -- function num : 0_31
  return self._effectCountTotal
end

Buff.GetDamegePercentStage = function(self)
  -- function num : 0_32
  return self._damagePercentStage
end

Buff.GetEffectBuffList = function(self)
  -- function num : 0_33
  return self._effectBuffidList
end

Buff.GetBUffTriggerRate = function(self)
  -- function num : 0_34
  return self._triggerRate
end

Buff.GetBUffBossBonusValue = function(self)
  -- function num : 0_35
  return self._bossBonusValue
end

Buff.GetBUffMonsterBonusValue = function(self)
  -- function num : 0_36
  return self._monsterBonusValue
end

Buff.GetBuffElementypeValue = function(self)
  -- function num : 0_37
  return {elementype = self._elementype, elementdmg = self._elementdmg, elementnum = self._elementnum}
end

Buff.GetBuffSkillID = function(self)
  -- function num : 0_38
  return self._skillid
end

Buff.GetStackTimes = function(self)
  -- function num : 0_39
  return self._stackTimes
end

Buff.GetStackTimesCur = function(self)
  -- function num : 0_40
  return self._stackTimesCur
end

Buff.GetBuffSkillTriggerType = function(self)
  -- function num : 0_41
  return self._skillTriggerType
end

Buff.GetBuffID = function(self)
  -- function num : 0_42
  return self._buffID
end

Buff.GetLinkSkillEffectTime = function(self)
  -- function num : 0_43
  return self._linkSkillEffectTime
end

Buff.SetLinkSkillEffectTime = function(self, times)
  -- function num : 0_44
  self._linkSkillEffectTime = times
end

Buff.GetLinkSkillEffectTotalTime = function(self)
  -- function num : 0_45
  return self._linkSkillEffectTotalTime
end

Buff.GetIfHaveNpcShapeChangeCfg = function(self)
  -- function num : 0_46 , upvalues : _ENV
  local record = (((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]
  if record.NpcShape == "" then
    do return not record end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

Buff.GetBuffInfluenceEntityIsCanBeChosenBySkillState = function(self)
  -- function num : 0_47 , upvalues : _ENV
  if (((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID] then
    return ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).selectedOrNot
  end
  return 0
end

Buff.GetDisposableBuffid = function(self)
  -- function num : 0_48 , upvalues : _ENV
  if (((BattleECS.Utility).DataUtility).cIBuffCfgTable)[self._buffID] then
    return self._buffID
  else
    if self._onceTimeBuffID and (((BattleECS.Utility).DataUtility).cIBuffCfgTable)[self._onceTimeBuffID] then
      return self._onceTimeBuffID
    end
  end
  return nil
end

Buff.GetBuffIsDamagedTriggerContinue = function(self)
  -- function num : 0_49
  return self._isDamageTriggerContinueBuff
end

Buff.GetBuffClassName = function(self)
  -- function num : 0_50 , upvalues : _ENV
  if (((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID] then
    return ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname
  end
  if (((BattleECS.Utility).DataUtility).cIBuffCfgTable)[self._buffID] then
    return ((((BattleECS.Utility).DataUtility).cIBuffCfgTable)[self._buffID]).classname
  end
  return nil
end

Buff.SetTriggerConditionDamageCumulativeNumber = function(self, num)
  -- function num : 0_51
  self._triggerConditionDamageCumulativeNumber = num
end

Buff.GetTriggerConditionDamageCumulativeNumber = function(self)
  -- function num : 0_52
  return self._triggerConditionDamageCumulativeNumber
end

Buff.GetTotalDamageTriggerCondition = function(self)
  -- function num : 0_53
  return self._totalDamageTriggerCondition
end

Buff.GetEnermyEntityid = function(self)
  -- function num : 0_54
  return (self._enermyEntity)._entityId
end

Buff.IsHasLinkSkill = function(self)
  -- function num : 0_55
  return self._linkSkillRecord
end

Buff.IfLinkSkillConditionFit = function(self)
  -- function num : 0_56 , upvalues : _ENV
  local flag = false
  for _,condition in ipairs(self._linkSkillCondition) do
    if condition.timebeforeFlag and condition.timeafterFlag and condition.castskillidFlag and condition.powerchangeFlag and condition.hppctfloorFlag and condition.hppcttopFlag and condition.buffIdFlag and condition.attrIdFlag and condition.damageskillidFlag then
      flag = condition.stationFlag
    end
  end
  do
    if not flag then
      for _,condition in ipairs(self._linkSkillCondition) do
        condition.timebeforeFlag = (condition.cfg).timebefore == nil
        condition.timeafterFlag = (condition.cfg).timeafter == nil
        condition.castskillidFlag = (condition.cfg).castskillid == nil
        condition.powerchangeFlag = (condition.cfg).powerchange == nil
        condition.hppctfloorFlag = (condition.cfg).hppctfloor == nil
        condition.hppcttopFlag = (condition.cfg).hppcttop == nil
        condition.buffIdFlag = (condition.cfg).buffid == nil
        condition.attrIdFlag = (condition.cfg).attrid == nil
        condition.damageskillidFlag = (condition.cfg).damageskillid == nil
        condition.stationFlag = (condition.cfg).station == nil
      end
      do return flag end
      -- DECOMPILER ERROR: 11 unprocessed JMP targets
    end
  end
end

Buff.GetLinkSkillCondition = function(self)
  -- function num : 0_57
  return self._linkSkillCondition
end

Buff.GetLinkSkillId = function(self)
  -- function num : 0_58 , upvalues : _ENV
  return {skillid = tonumber((self._linkSkillRecord).skillid), skillgroupid = tonumber((self._linkSkillRecord).skillgroupid)}
end

Buff.GetYingXiBuffAttackTime = function(self)
  -- function num : 0_59
  return self._yingXiBuffAttackTime
end

Buff.SetYingXiBuffAttackTime = function(self, time)
  -- function num : 0_60
  self._yingXiBuffAttackTime = time
end

Buff.GetIsCrit20096ShadowsWordRate = function(self)
  -- function num : 0_61
  return self._isCrit20096ShadowsWordRate
end

Buff.GetBuffTimeCellEffectTimes = function(self)
  -- function num : 0_62
  return self._timecellEffectTimes
end

local physicssuckbloodfun = function(damageb, physicallifesteala)
  -- function num : 0_63
  return -damageb * physicallifesteala
end

local magicsuckbloodfun = function(damageb, magiclifesteala)
  -- function num : 0_64
  return -damageb * magiclifesteala
end

local getcritdegreesection = function(critdegree)
  -- function num : 0_65 , upvalues : _ENV
  local record = (string.split)(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[70]).attr, ";")
  return (fixedpoint.min)((fixedpoint.max)(critdegree, fixedpoint(record[1]) / 1000), fixedpoint(record[2]) / 1000)
end

local getcritlevelsection = function(critlevel)
  -- function num : 0_66 , upvalues : _ENV
  local record = (string.split)(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[84]).attr, ";")
  return (fixedpoint.min)((fixedpoint.max)(critlevel, fixedpoint(record[1]) / 1000), fixedpoint(record[2]) / 1000)
end

Buff.NumbericalCalculation = function(self, paramter)
  -- function num : 0_67 , upvalues : _ENV, getcritdegreesection, magicsuckbloodfun, physicssuckbloodfun, getcritlevelsection
  local isCrit = false
  local critPara = 0
  local ShowShieldType = {NormalShield = 0}
  local attackComponnetA = (self._enermyEntity):GetComponent((BattleECS.Components).AttackComponent)
  local hpComponnetA = (self._enermyEntity):GetComponent((BattleECS.Components).HpComponent)
  local defenComponentA = (self._enermyEntity):GetComponent((BattleECS.Components).DefenseComponent)
  local skillComponentA = (self._enermyEntity):GetComponent((BattleECS.Components).SkillComponent)
  local buffComponentA = (self._enermyEntity):GetComponent((BattleECS.Components).BuffComponent)
  local attackComponnetB = (self._entity):GetComponent((BattleECS.Components).AttackComponent)
  local hpComponnetB = (self._entity):GetComponent((BattleECS.Components).HpComponent)
  local defenComponentB = (self._entity):GetComponent((BattleECS.Components).DefenseComponent)
  local typeComponentB = (self._entity):GetComponent((BattleECS.Components).TypeComponent)
  local skillComponentB = (self._entity):GetComponent((BattleECS.Components).SkillComponent)
  local buffComponentB = (self._entity):GetComponent((BattleECS.Components).BuffComponent)
  local typeComponentA = (self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent)
  if not typeComponentA then
    return 
  end
  if (buffComponentB._isHasChangeBuff)[1] then
    -- DECOMPILER ERROR at PC90: Unhandled construct in 'MakeBoolean' P1

    if self._buffID == 10000 and (buffComponentB._isHasChangeBuff)[1] == 2 then
      self._buffID = 10001
    end
    -- DECOMPILER ERROR at PC99: Unhandled construct in 'MakeBoolean' P1

    if self._buffID == 10016 and (buffComponentB._isHasChangeBuff)[1] == 2 then
      self._buffID = 10017
    end
    -- DECOMPILER ERROR at PC108: Unhandled construct in 'MakeBoolean' P1

    if self._buffID == 10001 and (buffComponentB._isHasChangeBuff)[1] == 1 then
      self._buffID = 10000
    end
    if self._buffID == 10017 and (buffComponentB._isHasChangeBuff)[1] == 1 then
      self._buffID = 10016
    end
    -- DECOMPILER ERROR at PC128: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC128: Unhandled construct in 'MakeBoolean' P1

    if self._onceTimeBuffID and self._onceTimeBuffID == 10000 and (buffComponentB._isHasChangeBuff)[1] == 2 then
      self._onceTimeBuffID = 10001
    end
  end
  -- DECOMPILER ERROR at PC137: Unhandled construct in 'MakeBoolean' P1

  if self._onceTimeBuffID == 10016 and (buffComponentB._isHasChangeBuff)[1] == 2 then
    self._onceTimeBuffID = 10017
  end
  -- DECOMPILER ERROR at PC146: Unhandled construct in 'MakeBoolean' P1

  if self._onceTimeBuffID == 10001 and (buffComponentB._isHasChangeBuff)[1] == 1 then
    self._onceTimeBuffID = 10000
  end
  if self._onceTimeBuffID == 10017 and (buffComponentB._isHasChangeBuff)[1] == 1 then
    self._onceTimeBuffID = 10016
  end
  local rec = {}
  rec.attackComponnetA = attackComponnetA
  rec.hpComponnetA = hpComponnetA
  rec.defenComponentA = defenComponentA
  rec.skillComponentA = skillComponentA
  rec.typeComponentA = typeComponentA
  rec.buffComponentA = buffComponentA
  rec.attackComponnetB = attackComponnetB
  rec.hpComponnetB = hpComponnetB
  rec.defenComponentB = defenComponentB
  rec.skillComponentB = skillComponentB
  rec.typeComponentB = typeComponentB
  rec.buffComponentB = buffComponentB
  rec.returnValue = paramter[1]
  rec.formula = paramter[2]
  rec.attrResult = paramter[3]
  local thisTimeDisposableBuffid = self:GetDisposableBuffid()
  rec.buffid = thisTimeDisposableBuffid
  rec.originalBuffid = self._originalBuffId
  rec.skillid = self._skillid
  rec.entity = self._entity
  rec.enermyentity = self._enermyEntity
  rec.world = self._battleWorld
  local funcResult, returnvalue, baseDamageResult = (((BattleECS.Utility).BuffUtility).NewAnalysisFormula)(rec)
  local thisBuffIsCritBuff = true
  thisBuffIsCritBuff = not (((BattleECS.Utility).DataUtility).cIBuffCfgTable)[thisTimeDisposableBuffid] or ((((BattleECS.Utility).DataUtility).cIBuffCfgTable)[thisTimeDisposableBuffid]).isCrit == 1
  if thisTimeDisposableBuffid ~= 10000 then
    local physicalBuff, physicalDamge = false, self._damageTransformParamter or (self._battleWorld)._battleID == 1120 or (self._battleWorld)._battleID == 1122 or not thisBuffIsCritBuff or returnvalue ~= "hp_value"
    local magicBuff, magicDamge = false, thisTimeDisposableBuffid == 10001
    if physicalDamge or thisTimeDisposableBuffid == 10002 then
      physicalBuff = true
    end
    if magicDamge or thisTimeDisposableBuffid == 10003 then
      magicBuff = true
    end
    if physicalBuff or magicBuff then
      if ((((BattleECS.Utility).Utility).IsAiSheLei1Skill)(self._skillid) or (((BattleECS.Utility).Utility).IsAiSheLei2Skill)(self._skillid)) and hpComponnetB._forceCritFlag then
        hpComponnetB._forceCritFlag = false
        isCrit = true
      end
      local isCrit20096ShadowsWordRate = 0
      local isHas, buffobj = (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(self._entity, 20096)
      if isHas and buffobj:GetEnermyEntityid() == self:GetEnermyEntityid() then
        isCrit20096ShadowsWordRate = buffobj:GetIsCrit20096ShadowsWordRate()
      end
      if (physicalBuff and physicalDamge) or magicBuff and magicDamge then
        isHas = (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(self._enermyEntity, 20134)
        if isHas and hpComponnetA._currentHp <= fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[69]).attr) * hpComponnetA._maxHp // 1000 then
          isCrit = true
        end
      end
      if not isCrit and (self._randomFun)(1, 1000) / fixedpoint(1000) <= attackComponnetA._attackCritRate + isCrit20096ShadowsWordRate - defenComponentB._attackCritDefense then
        isCrit = true
      end
      if isCrit then
        if (physicalBuff and physicalDamge) or magicBuff and magicDamge then
          critPara = attackComponnetA._attackCritDegree - defenComponentB._attackCritDegreeDefense
        else
          critPara = attackComponnetA._attackCritDegree
        end
        critPara = getcritdegreesection(critPara)
      end
    end
    local isHas, buffobj = (((BattleECS.Utility).BuffUtility).IsHasYingXiContinueBuff)(self._enermyEntity)
    if isHas then
      if isCrit then
        buffobj:SetYingXiBuffAttackTime(buffobj:GetYingXiBuffAttackTime() + 1)
      end
      if (not isCrit or tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[90]).attr) <= buffobj:GetYingXiBuffAttackTime()) and ((self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent))._isImaged and (((BattleECS.Utility).Utility).IsAttackSkill)(self._skillid) then
        local time = (((BattleECS.Utility).Utility).GetMonsterOrRoleMagicOrAttackEndFraps)(self._enermyEntity, self._skillid)
        if buffobj:GetBuffTotalTime() > 999 then
          buffobj:SetBuffTotalTime(time + 1)
          buffobj:SetBuffContinuedTime(1)
        end
      end
    end
    if self:GetBuffClassName() == "readbuff" then
      for _,v in ipairs(self._buffAdditionalAttribute) do
        if v.key == returnvalue then
          self:DeleteAttribute(returnvalue)
          v.value = 0
        end
      end
    end
    local preBuffAdditionalAttribute = nil
    if returnvalue == "shield_value" then
      local dontHaveAttribute = false
      local index = nil
      for i,v in ipairs(self._buffAdditionalAttribute) do
        if v.key == returnvalue .. self._buffID then
          dontHaveAttribute = true
          index = i
          break
        end
      end
      if not dontHaveAttribute then
        (table.insert)(self._buffAdditionalAttribute, {key = returnvalue .. self._buffID, value = 0})
        index = #self._buffAdditionalAttribute
      end
      preBuffAdditionalAttribute = ((self._buffAdditionalAttribute)[index]).value
    else
      local dontHaveAttribute = false
      local index = nil
      for i,v in ipairs(self._buffAdditionalAttribute) do
        if v.key == returnvalue then
          dontHaveAttribute = true
          index = i
          break
        end
      end
      if not dontHaveAttribute then
        (table.insert)(self._buffAdditionalAttribute, {key = returnvalue, value = 0})
        index = #self._buffAdditionalAttribute
      end
      preBuffAdditionalAttribute = ((self._buffAdditionalAttribute)[index]).value
    end
    if (((BattleECS.Utility).Utility).IsTreateSkill)(self._skillid) then
      local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenRoleTreateRemoveDebuff)(self._enermyEntity, self._randomFun)
      for _,skillStruct in ipairs(skillList) do
        (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(self._entity, skillStruct, self._entity)
      end
    end
    if returnvalue ~= "hp_value" then
      (((BattleECS.Utility).BuffUtility).SetSkillsectionendbuffSkillEffect)(self._entity, self._originalBuffId)
      ;
      (((BattleECS.Utility).BuffUtility).SetSkillsectionendbuffSkillEffect)(self._enermyEntity, self._originalBuffId)
      ;
      (((BattleECS.Utility).BuffUtility).SetSkillsectionendbuffSkillEffect)(self._entity, self._buffID)
      ;
      (((BattleECS.Utility).BuffUtility).SetSkillsectionendbuffSkillEffect)(self._enermyEntity, self._buffID)
    end
    local deltaValueUsedAddBuffReturnValue = 0
    if returnvalue == "hp_value" then
      local hpChange = (fixedpoint.floor)(funcResult)
      if self._specialBuffParameterFixedpointAttrValue then
        hpChange = hpChange + self._specialBuffParameterFixedpointAttrValue
      end
      local hpChangeToUiView = 0
      if isCrit then
        hpChange = (fixedpoint.floor)((hpChange) * critPara)
      end
      if not (((BattleECS.Utility).Utility).IsRoleDead)(self._entity) or self._buffID == 10006 then
        if (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(self._entity, 20014) then
          if (((BattleECS.Utility).BuffUtility).GetEntityBuffEffectState)(self._entity, 20014) then
            hpChange = 0
          elseif not (((BattleECS.Utility).Utility).IsAttackSkill)(self._skillid) then
            hpChange = hpChange * 3
            ;
            (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({entity = self._entity, enermyentity = self._entity, buffid = 20020, buffparamter = "time=150", skillid = 0, battleworld = self._battleWorld})
          end
        elseif (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(self._entity, 20020) then
          hpChange = hpChange * 3
        end
        if (((BattleECS.Utility).BuffUtility).IsNormalOrSelectiveMonster)(((self._entity):GetComponent((BattleECS.Components).TypeComponent))._roleID) then
          hpChange = hpChange + hpChange * (((BattleECS.Utility).BuffUtility).GetBossBonusValueAll)(self._enermyEntity)
        end
        if (((BattleECS.Utility).BuffUtility).IsExceptNormalOrSelectiveMonster)(((self._entity):GetComponent((BattleECS.Components).TypeComponent))._roleID) then
          hpChange = hpChange + (hpChange) * (((BattleECS.Utility).BuffUtility).GetMonsterBonusValueAll)(self._enermyEntity)
        end
        local element = ((self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent))._roleElementType
        if element ~= 0 then
          hpChange = hpChange + (hpChange) * (((BattleECS.Utility).BuffUtility).GetEntityElementAdditionDmg)(self._battleWorld, self._entity, element)
        end
        if hpChange < 0 and (self._randomFun)(1, 1000) <= ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._dmgLimitRate then
          if thisTimeDisposableBuffid == 10000 or thisTimeDisposableBuffid == 10016 then
            hpChange = (fixedpoint.max)(hpChange, ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._phyDmgLimit)
          elseif thisTimeDisposableBuffid == 10001 or thisTimeDisposableBuffid == 10017 then
            hpChange = (fixedpoint.max)(hpChange, ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._magicDmgLimit)
          else
            hpChange = (fixedpoint.max)(hpChange, ((self._entity):GetComponent((BattleECS.Components).BuffComponent))._phyDmgLimit)
          end
        end
        if hpChange < 0 then
          if thisTimeDisposableBuffid == 10000 or thisTimeDisposableBuffid == 10016 then
            hpChange = (fixedpoint.max)(hpChange, ((self._enermyEntity):GetComponent((BattleECS.Components).BuffComponent))._bringOutPhyDmgLimit)
          elseif thisTimeDisposableBuffid == 10001 or thisTimeDisposableBuffid == 10017 then
            hpChange = (fixedpoint.max)(hpChange, ((self._enermyEntity):GetComponent((BattleECS.Components).BuffComponent))._bringOutMagicDmgLimit)
          else
            hpChange = (fixedpoint.max)(hpChange, ((self._enermyEntity):GetComponent((BattleECS.Components).BuffComponent))._bringOutPhyDmgLimit)
          end
        end
        local isHasBuff, buffRec = (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(self._entity, 20176)
        if isHasBuff and hpChange < 0 and not self._isConnect then
          local list = {}
          if ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left then
            for _,v in ipairs((self._battleWorld)._leftPlayerList) do
              if v._entityId ~= (self._entity)._entityId and (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(v, 20176) then
                (table.insert)(list, v)
              end
            end
          elseif ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
            for _,v in ipairs((self._battleWorld)._rightPlayerList) do
              if v._entityId ~= (self._entity)._entityId and (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(v, 20176) then
                (table.insert)(list, v)
              end
            end
          end
          hpChange = hpChange // ((table.nums)(list) + 1)
          local recordNum = 0
          if isCrit then
            recordNum = 1
          end
          for _,v in ipairs(list) do
            (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({entity = v, enermyentity = self._enermyEntity, buffid = thisTimeDisposableBuffid, buffparamter = "hp_value=0", skillid = self._skillid, battleworld = self._battleWorld, damagetransformparamter = recordNum, isconnect = true, originalBuffId = 0, fixedpointAttrValue = hpChange})
          end
        end
        if hpChange < 0 then
          if hpComponnetB._currentHp + hpChange <= 0 then
            local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenRoleDamagedToDead)(self._entity, self._randomFun)
            for _,skillStruct in ipairs(skillList) do
              local ourlist = (((BattleECS.Utility).BuffUtility).GetSKillBuffList)(skillStruct.skillid)
              for _,v in ipairs(ourlist) do
                local record = (string.split)(v.buffvalues, "=")
                if record[1] == "hp_value" then
                  if (string.find)(record[2], "%d+") then
                    hpChange = fixedpoint(record[2]) - hpComponnetB._currentHp
                  elseif record[2] == "maxhpb" then
                    hpChange = hpComponnetB._maxHp
                    self._buffID = tonumber(v.buffid)
                    if (((BattleECS.Utility).Utility).IsSkillOnceEquipSkill)(skillStruct.skillid) then
                      local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sroleuseequipskill")
                      protocol.entityid = (self._entity)._entityId
                      protocol.skillid = (((BattleECS.Utility).Utility).IsSkillOnceEquipSkill)(skillStruct.skillid)
                      ;
                      (self._battleWorld):InsertViewProtocolData(protocol)
                    end
                  end
                end
              end
              ;
              (skillStruct.buff):SetBuffEffectCount((skillStruct.buff):GetBuffEffectCount() + 1)
            end
            local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenRoleKillEnermy)(self._enermyEntity)
            for _,skillStruct in ipairs(skillList) do
              if (skillStruct.buff):GetLinkBuffLimitSkillid() and self._skillid == (skillStruct.buff):GetLinkBuffLimitSkillid() then
                local random = (self._randomFun)(1, 100)
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
                  (((BattleECS.Utility).Utility).SetSkillIsCostPowerState)(self._enermyEntity, false)
                  ;
                  (((BattleECS.Utility).Utility).SetSkillID)(self._enermyEntity, skillStruct.skillid)
                end
              end
            end
          end
          ;
          ((self._entity):GetComponent((BattleECS.Components).HpComponent))._buffDamgeSkillId = self._skillid
          ;
          (((BattleECS.Utility).Utility).SetEntityHpComponentLastDamege)(self._entity, hpChange, (self._enermyEntity)._entityId)
          ;
          (((BattleECS.Utility).Utility).AddEntityHpComponentSkillHitNumber)(self._enermyEntity, -hpChange, self._skillid)
          ;
          (((BattleECS.Utility).Utility).SetEntityHpComponentTotalDamege)(self._entity, -hpChange)
          ;
          (((BattleECS.Utility).Utility).RecordEntityHpComponentElementDamage)(self._entity, -hpChange, self._enermyEntity)
          do
            if attackComponnetA._magicSuckBlood > 0 and ((((BattleECS.Utility).DataUtility).cIBuffCfgTable)[thisTimeDisposableBuffid]).classname == "MagicDamage" and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp ~= ((self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent))._camp then
              local magicheal = magicsuckbloodfun(hpComponnetB._lastDamage, attackComponnetA._magicSuckBlood)
              ;
              (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({isplayattackedeffect = 0, entity = self._enermyEntity, enermyentity = self._enermyEntity, buffid = 10009, buffparamter = "hp_value=0", skillid = self._skillid, battleworld = self._battleWorld, fixedpointAttrValue = magicheal})
              ;
              (((BattleECS.Utility).BuffUtility).RemoveEntityBuffBySkillID)(self._enermyEntity, self._skillid)
            end
            do
              if attackComponnetA._attackSuckBlood > 0 and ((((BattleECS.Utility).DataUtility).cIBuffCfgTable)[thisTimeDisposableBuffid]).classname == "PhysicalDamage" and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp ~= ((self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent))._camp then
                local physicheal = physicssuckbloodfun(hpComponnetB._lastDamage, attackComponnetA._attackSuckBlood)
                ;
                (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({isplayattackedeffect = 0, entity = self._enermyEntity, enermyentity = self._enermyEntity, buffid = 10008, buffparamter = "hp_value=0", skillid = self._skillid, battleworld = self._battleWorld, fixedpointAttrValue = physicheal})
                ;
                (((BattleECS.Utility).BuffUtility).RemoveEntityBuffBySkillID)(self._enermyEntity, self._skillid)
              end
              local isHas, buffobj = (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(self._entity, 20273)
              if isHas and (self._entity)._entityId == buffobj:GetEnermyEntityid() then
                local percentage = buffobj:GetDamegePercentStage()
                if ((self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                  for _,v in ipairs((self._battleWorld)._leftPlayerList) do
                    local vIsHas, vBuffObj = (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(v, 20273)
                    if vIsHas and vBuffObj:GetEnermyEntityid() == (self._entity)._entityId and v._entityId ~= (self._entity)._entityId then
                      (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({isplayattackedeffect = 0, entity = v, enermyentity = self._entity, buffid = 10007, buffparamter = "hp_value=0", skillid = self._skillid, battleworld = self._battleWorld, fixedpointAttrValue = hpChange * percentage // 100})
                    end
                  end
                else
                  for _,v in ipairs((self._battleWorld)._rightPlayerList) do
                    local vIsHas, vBuffObj = (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(v, 20273)
                    if vIsHas and vBuffObj:GetEnermyEntityid() == (self._entity)._entityId and v._entityId ~= (self._entity)._entityId then
                      (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({isplayattackedeffect = 0, entity = v, enermyentity = self._entity, buffid = 10007, buffparamter = "hp_value=0", skillid = self._skillid, battleworld = self._battleWorld, fixedpointAttrValue = hpChange * percentage // 100})
                    end
                  end
                end
              end
              local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenRoleDamagedMoreEqualNumber)(self._entity)
              for _,skillStruct in ipairs(skillList) do
                local random = (self._randomFun)(1, 100)
                local effectTime = (skillStruct.buff):GetLinkSkillEffectTime()
                local totalEffectTime = (skillStruct.buff):GetLinkSkillEffectTotalTime()
                local triggerLinkSkillFlag = random <= (skillStruct.buff):GetBUffTriggerRate()
                if totalEffectTime and totalEffectTime <= effectTime then
                  triggerLinkSkillFlag = false
                end
                if triggerLinkSkillFlag then
                  local num = (skillStruct.buff):GetTriggerConditionDamageCumulativeNumber()
                  ;
                  (skillStruct.buff):SetTriggerConditionDamageCumulativeNumber(num - hpChange)
                  if (skillStruct.buff):GetTotalDamageTriggerCondition() <= num - hpChange then
                    (skillStruct.buff):SetLinkSkillEffectTime(effectTime + 1)
                    ;
                    (skillStruct.buff):ResetTriggerCDCountTime()
                    ;
                    (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(self._entity, skillStruct, self._entity)
                    ;
                    (skillStruct.buff):SetTriggerConditionDamageCumulativeNumber(0)
                  end
                end
              end
              if isCrit then
                local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenRoleCrit)(self._enermyEntity, self._randomFun)
                for _,skillStruct in ipairs(skillList) do
                  (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(self._enermyEntity, R40_PC1481, self._entity)
                end
              end
              if (((BattleECS.Utility).Utility).IsAttackSkill)(self._skillid) then
                local skillList = {}
                if hpChange < 0 then
                  skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenRoleAttackHit)(self._enermyEntity, self._randomFun)
                elseif hpChange > 0 then
                  skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenRoleAttackHeal)(self._enermyEntity, self._randomFun)
                end
                for _,skillStruct in ipairs(skillList) do
                  (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(self._enermyEntity, R40_PC1481, self._entity)
                end
              end
              if (((BattleECS.Utility).Utility).IsUseSkill)(self._skillid) then
                local buffComponent = (self._enermyEntity):GetComponent((BattleECS.Components).BuffComponent)
                ;
                (table.insert)(buffComponent._removeBuffClassNameList, "skillbonusbuff")
                ;
                (((BattleECS.Utility).BuffUtility).SetSkillsectionendbuffSkillEffect)(self._entity, self._originalBuffId)
                ;
                (((BattleECS.Utility).BuffUtility).SetSkillsectionendbuffSkillEffect)(self._enermyEntity, self._originalBuffId)
                ;
                (((BattleECS.Utility).BuffUtility).SetSkillsectionendbuffSkillEffect)(self._entity, self._buffID)
                ;
                (((BattleECS.Utility).BuffUtility).SetSkillsectionendbuffSkillEffect)(self._enermyEntity, self._buffID)
                local skillList = {}
                if hpChange <= 0 then
                  skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenRoleUseSkillHit)(self._enermyEntity)
                elseif hpChange > 0 then
                  skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenRoleUseSkillHeal)(self._enermyEntity)
                end
                for _,skillStruct in ipairs(skillList) do
                  -- DECOMPILER ERROR at PC1600: Overwrote pending register: R40 in 'AssignReg'

                  -- DECOMPILER ERROR at PC1605: Overwrote pending register: R40 in 'AssignReg'

                  -- DECOMPILER ERROR at PC1607: Overwrote pending register: R40 in 'AssignReg'

                  -- DECOMPILER ERROR at PC1611: Overwrote pending register: R40 in 'AssignReg'

                  -- DECOMPILER ERROR at PC1616: Overwrote pending register: R40 in 'AssignReg'

                  if ((skillStruct.buff):GetLinkBuffLimitSkillid() and (skillStruct.buff):GetLinkBuffLimitSkillid() == R40_PC1481) or not (skillStruct.buff):GetLinkBuffLimitSkillid() then
                    local random = (self._randomFun)(R40_PC1481, 100)
                    -- DECOMPILER ERROR at PC1619: Overwrote pending register: R40 in 'AssignReg'

                    -- DECOMPILER ERROR at PC1620: Overwrote pending register: R40 in 'AssignReg'

                    R40_PC1481 = R40_PC1481(R40_PC1481)
                    local effectTime = nil
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
                      (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(self._enermyEntity, skillStruct, self._entity)
                    end
                  end
                end
              else
                (((BattleECS.Utility).BuffUtility).SetSkillsectionendbuffSkillEffect)(self._entity, self._originalBuffId)
                ;
                (((BattleECS.Utility).BuffUtility).SetSkillsectionendbuffSkillEffect)(self._enermyEntity, self._originalBuffId)
                ;
                (((BattleECS.Utility).BuffUtility).SetSkillsectionendbuffSkillEffect)(self._entity, self._buffID)
                ;
                (((BattleECS.Utility).BuffUtility).SetSkillsectionendbuffSkillEffect)(self._enermyEntity, self._buffID)
              end
              if hpChange > 0 and thisTimeDisposableBuffid == 10010 and hpComponnetB._maxHp < hpComponnetB._currentHp + hpChange then
                local overFlowHpNumber = hpComponnetB._currentHp + hpChange - hpComponnetB._maxHp
                local buffinfo = (((BattleECS.Utility).BuffUtility).GetSkillOverFlowTreatmentBuffInfo)(self._skillid)
                if buffinfo then
                  (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({entity = self._entity, enermyentity = self._enermyEntity, buffid = buffinfo.buffid, buffparamter = "maxhp_value=0;" .. buffinfo.buffparamater, skillid = self._skillid, battleworld = self._battleWorld, fixedpointAttrValue = overFlowHpNumber})
                end
              end
              hpChangeToUiView = hpChange
              -- DECOMPILER ERROR at PC1774: Unhandled construct in 'MakeBoolean' P1

              if (not (self._battleWorld)._isLeftGMInvincible and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left) or not (self._battleWorld)._isRightGMInvincible and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                (((BattleECS.Utility).Utility).ChangeEntityCurrentHp)(self._entity, hpChange)
              end
              for _,v in ipairs(hpComponnetB._damageSheildNumberList) do
                local shieldType = nil
                if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[v.buffid]).classname == "shieldbuff" then
                  shieldType = ShowShieldType.NormalShield
                end
                hpChangeToUiView = hpChangeToUiView + v.number
                if hpChangeToUiView > 0 then
                  v.number = hpChangeToUiView
                  ;
                  (((BattleECS.Utility).ProtocolUtility).SendShieldValueChange)((self._entity)._entityId, v.buffid, shieldType, v.number, self._battleWorld)
                  hpChangeToUiView = 0
                  hpChange = 0
                  break
                else
                  local breakFlag = v.number <= 0
                  hpChange = hpChange + v.number
                  v.number = 0
                  ;
                  (((BattleECS.Utility).ProtocolUtility).SendShieldValueChange)((self._entity)._entityId, v.buffid, shieldType, v.number, self._battleWorld)
                  if not breakFlag then
                    local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenShieldNumberChangeZeroAndSameToBuffID)(self._entity, v.buffid, self._randomFun)
                    for _,skillStruct in ipairs(skillList) do
                      (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(self._entity, skillStruct, self._entity)
                    end
                    skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenShieldBuffEnd)(self._entity, v.buffid, self._randomFun)
                    for _,skillStruct in ipairs(skillList) do
                      (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(v.shieldComeFromEntity, skillStruct, self._enermyEntity)
                    end
                  end
                end
              end
              if (not (self._battleWorld)._isLeftGMInvincible and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left) or not (self._battleWorld)._isRightGMInvincible and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                (((BattleECS.Utility).Utility).ChangeEntityCurrentHp)(self._entity, hpChange)
              end
              if (not (self._battleWorld)._isLeftGMInvincible and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left) or not (self._battleWorld)._isRightGMInvincible and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                (((BattleECS.Utility).Utility).ChangeEntityCurrentHp)(self._entity, hpChange)
              end
              if (self._entity)._entityId == (self._battleWorld)._bossEntityid then
                local record = (((BattleECS.Utility).DataUtility).cBossBreakCfgTable)[((self._entity):GetComponent((BattleECS.Components).TypeComponent))._roleID]
                if record then
                  local breakbuff = record.breakbuff
                  for k,v in ipairs((self._battleWorld)._bossHpStage) do
                    if hpChange > 0 and v.stage and breakbuff[(table.nums)((self._battleWorld)._bossHpStage) - k] and hpComponnetB._maxHp - hpComponnetB._currentHp < v.totalHpNum then
                      if v.buffidList then
                        local removeList = {}
                        for index = #v.buffidList, 1, -1 do
                          local buffid = (v.buffidList)[index]
                          ;
                          (((BattleECS.Utility).BuffUtility).RemoveEntityBuff)(self._entity, buffid)
                          ;
                          (table.insert)(removeList, index)
                        end
                        for _,index in ipairs(removeList) do
                          (table.remove)(v.buffidList, index)
                        end
                      end
                      v.buffidList = {}
                    end
                    if not v.stage and breakbuff[(table.nums)((self._battleWorld)._bossHpStage) - k] and v.totalHpNum <= hpComponnetB._maxHp - hpComponnetB._currentHp then
                      v.buffidList = {}
                      local buffattr = (string.split)((string.sub)((record.breakbuffattr)[(table.nums)((self._battleWorld)._bossHpStage) - k], 2, (string.len)((record.breakbuffattr)[(table.nums)((self._battleWorld)._bossHpStage) - k]) - 1), "}{")
                      for index,buffid in ipairs((string.split)(breakbuff[(table.nums)((self._battleWorld)._bossHpStage) - k], ";")) do
                        (table.insert)(v.buffidList, tonumber(buffid))
                        ;
                        (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({entity = self._entity, enermyentity = self._entity, buffid = tonumber(buffid), buffparamter = buffattr[index], skillid = 0, battleworld = self._battleWorld})
                      end
                      ;
                      (((BattleECS.Utility).ProtocolUtility).SendBossIsInWeakState)(self._battleWorld)
                    end
                  end
                end
                for k,v in ipairs((self._battleWorld)._bossHpStage) do
                  if hpComponnetB._maxHp - hpComponnetB._currentHp < v.totalHpNum then
                    v.stage = false
                  else
                    v.stage = true
                  end
                end
              end
              local DamageTypeEnum = {None = 0, Damage = 1, BreakBuff = 2, DamageCrit = 3, Heal = 4, HealCrit = 5, BreakBuffCrit = 6, Resist = 7}
              local damagetype = DamageTypeEnum.None
              if not (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(self._entity, 20041) and self._buffID ~= 20168 then
                local skillid = (((BattleECS.Utility).BuffUtility).GetBuffChangeSKillID)(self._enermyEntity, self._skillid, self._battleWorld)
                local tempRecord = (((BattleECS.Utility).DataUtility).cIBuffCfgTable)[thisTimeDisposableBuffid]
                if tempRecord and (string.find)(tempRecord.classname, "Damage") then
                  if isCrit then
                    damagetype = DamageTypeEnum.DamageCrit
                  elseif (((BattleECS.Utility).BuffUtility).IsEntityHasBreakBuff)(self._entity) then
                    if isCrit then
                      damagetype = DamageTypeEnum.BreakBuffCrit
                    else
                      damagetype = DamageTypeEnum.BreakBuff
                    end
                  else
                    damagetype = DamageTypeEnum.Damage
                  end
                  if baseDamageResult and (hpChange) // (fixedpoint.floor)(baseDamageResult) < fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[113]).attr) then
                    damagetype = DamageTypeEnum.Resist
                  end
                elseif tempRecord and (string.find)(tempRecord.classname, "Heal") then
                  if isCrit then
                    damagetype = DamageTypeEnum.HealCrit
                  else
                    damagetype = DamageTypeEnum.Heal
                  end
                elseif thisTimeDisposableBuffid == 10006 then
                  damagetype = DamageTypeEnum.Heal
                elseif thisTimeDisposableBuffid == 10014 then
                  damagetype = DamageTypeEnum.Damage
                end
                if self._damageTransformParamter then
                  if self._damageTransformParamter == 1 then
                    damagetype = DamageTypeEnum.DamageCrit
                  elseif self._damageTransformParamter == 0 then
                    damagetype = DamageTypeEnum.Damage
                  end
                end
                local isPost = false
                if skillid == 201064 then
                  isPost = true
                end
                if (self._entity):GetComponent((BattleECS.Components).FlySkillDataComponent) and ((self._entity):GetComponent((BattleECS.Components).FlySkillDataComponent))._skillEffectType == (((BattleECS.Components).FlySkillDataComponent).SkillEffectType).DefendFlyProp then
                  isPost = true
                end
                ;
                (((BattleECS.Utility).ProtocolUtility).SendFixPointSkillAttackedInfo)((self._enermyEntity)._entityId, self._entity, skillid, hpChangeToUiView, isPost, self._effectRad, false, self._battleWorld, damagetype, self._isPlayAttackedEffect)
              end
              if hpChange < 0 and (((BattleECS.Utility).Utility).IsActiveSkill)(self._enermyEntity, self._skillid) then
                (((BattleECS.Utility).ProtocolUtility).SendSActionWithActiveSkill)((self._entity)._entityId, (self._enermyEntity)._entityId, self._skillid, self._battleWorld)
              end
              local hitHpPercent = fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[92]).attr) / 100
              local entityCamp = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp
              local enermyCamp = ((self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent))._camp
              if entityCamp ~= enermyCamp and hpChange < 0 and hitHpPercent <= (fixedpoint.abs)(hpChange) / ((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp then
                (((BattleECS.Utility).ProtocolUtility).SendPlayBattleVoice)(((self._entity):GetComponent((BattleECS.Components).TypeComponent))._roleID, (((BattleECS.Utility).DataUtility).VoiceType).Attacked, nil, self._battleWorld)
              end
              local roleReallyDead = (((BattleECS.Utility).ProtocolUtility).IsSendRoleDeadAndDeleteBox2DPhysics)(self._entity, (self._enermyEntity)._entityId, hpChange, self._battleWorld)
              if damagetype ~= DamageTypeEnum.None and damagetype ~= DamageTypeEnum.Heal and damagetype ~= DamageTypeEnum.HealCrit and not roleReallyDead then
                local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenRoleDamaged)(self._entity, self._randomFun)
                for _,skillStruct in ipairs(skillList) do
                  local flag, buffconfig = (((BattleECS.Utility).BuffUtility).IsSkillHasPowerChangeOnceBuff)(skillStruct.skillid)
                  if flag then
                    for _,v in ipairs((string.split)(buffconfig.buffvalues, ";")) do
                      local record = (string.split)(v, "=")
                      if record[1] == "orderpwr_value" then
                        (self._battleWorld):AddRedPower(tonumber(record[2]))
                      elseif record[1] == "chaospwr_value" then
                        (self._battleWorld):AddBluePower(tonumber(record[2]))
                      end
                    end
                  else
                    (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(self._entity, skillStruct, self._enermyEntity)
                  end
                end
              end
              do
                if (((BattleECS.Utility).Utility).IsShiBuKeDang)(self._skillid) and not (((BattleECS.Utility).BuffUtility).IsHasCanNotBeBlowedBuff)(self._entity) and (((BattleECS.Utility).AnimationUtility).IsNeedResetEntityAnimationEventComponentIsInChangePosition)(self._entity) then
                  local component = (self._enermyEntity):GetComponent((BattleECS.Components).AnimationEventComponent)
                  if component then
                    if component._roleIsInPositionChangeAnimationTimeStamp < component._chargeBackTime then
                      (((BattleECS.Utility).AnimationUtility).IntegrateChangePositionData)(self._entity, "enemyblowupl")
                    else
                      (((BattleECS.Utility).AnimationUtility).IntegrateChangePositionData)(self._entity, "enemyblowupr")
                    end
                  end
                end
                if returnvalue == "defend_value" then
                  local defend = funcResult
                  deltaValueUsedAddBuffReturnValue = defend
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackDefense = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackDefense + defend
                elseif returnvalue == "maxhp_value" then
                  local maxHpChange = (fixedpoint.floor)(funcResult)
                  if self._specialBuffParameterFixedpointAttrValue then
                    maxHpChange = maxHpChange + self._specialBuffParameterFixedpointAttrValue
                  end
                  deltaValueUsedAddBuffReturnValue = maxHpChange
                  local curMaxHp = ((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp
                  local curHp = ((self._entity):GetComponent((BattleECS.Components).HpComponent))._currentHp
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp = ((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp + (maxHpChange)
                  local ratio = curHp / curMaxHp
                  ratio = (fixedpoint.min)(ratio, 1)
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).HpComponent))._currentHp = (fixedpoint.floor)(((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp * ratio)
                  if (self._entity)._entityId == (self._battleWorld)._bossEntityid then
                    curMaxHp = ((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp
                    curHp = ((self._entity):GetComponent((BattleECS.Components).HpComponent))._currentHp
                    local everyHpLineNum = curMaxHp / #(self._battleWorld)._bossHpStage
                    local hpLineCount = 0
                    while everyHpLineNum < curHp do
                      curHp = curHp - everyHpLineNum
                      hpLineCount = hpLineCount + 1
                    end
                    local attribute = (BattleClientProtocolManager.CreateBean)("data.attribute")
                    local bosshpstagelist = {}
                    local hpdelta = 0
                    local curHasSet = false
                    for k,v in ipairs((self._battleWorld)._bossHpStage) do
                      if k <= hpLineCount then
                        v.num = everyHpLineNum
                      elseif not curHasSet then
                        v.num = curHp
                        curHasSet = true
                      else
                        v.num = 0
                      end
                      hpdelta = hpdelta + v.num
                      v.totalHpNum = hpdelta
                    end
                    for k,v in ipairs((self._battleWorld)._bossHpStage) do
                      bosshpstagelist[k] = ((_ENV.math).ceil)((fixedpoint.tonumber)(v.num))
                    end
                    local protocol = (BattleClientProtocolManager.CreateProtocol)("action.supdatebosshpstage")
                    protocol.entityId = (self._entity)._entityId
                    protocol.bosshpstage = bosshpstagelist
                    ;
                    (self._battleWorld):InsertViewProtocolData(protocol)
                  end
                elseif returnvalue == "maxhpscale_value" then
                  local maxHpValueRatio = funcResult
                  local curMaxHp = ((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp
                  local curHp = ((self._entity):GetComponent((BattleECS.Components).HpComponent))._currentHp
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp = (1 + maxHpValueRatio) * curMaxHp
                  local ratio = curHp / curMaxHp
                  if curHp == curMaxHp then
                    ratio = 1
                  end
                  ratio = (fixedpoint.min)(ratio, 1)
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).HpComponent))._currentHp = (fixedpoint.floor)(((self._entity):GetComponent((BattleECS.Components).HpComponent))._maxHp * ratio)
                  if (self._entity)._entityId == (self._battleWorld)._bossEntityid then
                    local attribute = (BattleClientProtocolManager.CreateBean)("data.attribute")
                    local bosshpstagelist = {}
                    local hpdelta = 0
                    for k,v in ipairs((self._battleWorld)._bossHpStage) do
                      v.num = (maxHpValueRatio + 1) * v.num
                      hpdelta = hpdelta + v.num
                      v.totalHpNum = hpdelta
                    end
                    for k,v in ipairs((self._battleWorld)._bossHpStage) do
                      bosshpstagelist[k] = ((_ENV.math).ceil)((fixedpoint.tonumber)(v.num))
                    end
                    local protocol = (BattleClientProtocolManager.CreateProtocol)("action.supdatebosshpstage")
                    protocol.entityId = (self._entity)._entityId
                    protocol.bosshpstage = bosshpstagelist
                    ;
                    (self._battleWorld):InsertViewProtocolData(protocol)
                  end
                elseif returnvalue == "attack_value" then
                  local attack = funcResult
                  deltaValueUsedAddBuffReturnValue = attack
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attack = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attack + attack
                elseif returnvalue == "magicdef_value" then
                  local magicdef = funcResult
                  deltaValueUsedAddBuffReturnValue = magicdef
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicDefense = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicDefense + magicdef
                elseif returnvalue == "physicalbonus_value" then
                  local phybonus = funcResult
                  deltaValueUsedAddBuffReturnValue = phybonus
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackDamageAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackDamageAddition + phybonus
                elseif returnvalue == "magicbonus_value" then
                  local magicbonus = funcResult
                  deltaValueUsedAddBuffReturnValue = magicbonus
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicDamageAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicDamageAddition + magicbonus
                elseif returnvalue == "physicalreduce_value" then
                  local phyreduce = funcResult
                  deltaValueUsedAddBuffReturnValue = phyreduce
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackDefenseAddition = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackDefenseAddition + phyreduce
                elseif returnvalue == "magicreduce_value" then
                  local magicreduce = funcResult
                  deltaValueUsedAddBuffReturnValue = magicreduce
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicDefenseAddition = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicDefenseAddition + magicreduce
                elseif returnvalue == "magiclifesteal_value" then
                  local magicsuckblood = funcResult
                  deltaValueUsedAddBuffReturnValue = magicsuckblood
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicSuckBlood = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicSuckBlood + magicsuckblood
                elseif returnvalue == "physicallifesteal_value" then
                  local physicssuckblood = funcResult
                  deltaValueUsedAddBuffReturnValue = physicssuckblood
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackSuckBlood = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackSuckBlood + physicssuckblood
                elseif returnvalue == "attackspeed_value" then
                  local attackspeed = funcResult
                  deltaValueUsedAddBuffReturnValue = attackspeed
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackSpeed = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackSpeed + attackspeed
                elseif returnvalue == "physicalblock_value" then
                  local physicalblock = funcResult
                  deltaValueUsedAddBuffReturnValue = physicalblock
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackInjuryReduceNumber = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackInjuryReduceNumber + physicalblock
                elseif returnvalue == "magicblock_value" then
                  local magicblock = funcResult
                  deltaValueUsedAddBuffReturnValue = magicblock
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicInjuryReduceNumber = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicInjuryReduceNumber + magicblock
                elseif returnvalue == "evasion_value" then
                  local evasion = funcResult
                  deltaValueUsedAddBuffReturnValue = evasion
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackMiss = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackMiss + evasion
                elseif returnvalue == "physicaldefbreak_value" then
                  local defbreak = funcResult
                  deltaValueUsedAddBuffReturnValue = defbreak
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackDefBreak = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackDefBreak + defbreak
                elseif returnvalue == "magicdefbreak_value" then
                  local magicdefbreak = funcResult
                  deltaValueUsedAddBuffReturnValue = magicdefbreak
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicDefBreak = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicDefBreak + magicdefbreak
                elseif returnvalue == "critrate_value" then
                  local physicalcritrate = funcResult
                  deltaValueUsedAddBuffReturnValue = physicalcritrate
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritRate = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritRate + physicalcritrate
                elseif returnvalue == "critdegree_value" then
                  local physicalcritdegree = funcResult
                  deltaValueUsedAddBuffReturnValue = physicalcritdegree
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegree = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackCritDegree + physicalcritdegree
                elseif returnvalue == "critrateresistance_value" then
                  local critdefend = funcResult
                  deltaValueUsedAddBuffReturnValue = critdefend
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackCritDefense = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackCritDefense + critdefend
                elseif returnvalue == "critdegreeresistance_value" then
                  local critdedegreefend = funcResult
                  deltaValueUsedAddBuffReturnValue = critdedegreefend
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackCritDegreeDefense = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._attackCritDegreeDefense + critdedegreefend
                elseif returnvalue == "extraphysicaldmg_value" then
                  local extraphysicaldamage = funcResult
                  deltaValueUsedAddBuffReturnValue = extraphysicaldamage
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._attackAddition + extraphysicaldamage
                elseif returnvalue == "extramagicdmg_value" then
                  local extramagicdamage = funcResult
                  deltaValueUsedAddBuffReturnValue = extramagicdamage
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._magicAddition + extramagicdamage
                elseif returnvalue == "curativeadd_value" then
                  local curativebonus = funcResult
                  deltaValueUsedAddBuffReturnValue = curativebonus
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._treatmentAddition = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._treatmentAddition + curativebonus
                elseif returnvalue == "accuracy_value" then
                  local accuracy = funcResult
                  deltaValueUsedAddBuffReturnValue = accuracy
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._hitRate = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._hitRate + accuracy
                elseif returnvalue == "totaldmg" then
                  return funcResult
                elseif returnvalue == "rate" then
                  return funcResult
                elseif returnvalue == "bossbonus" then
                  return funcResult
                elseif returnvalue == "monsterbonus" then
                  return funcResult
                elseif returnvalue == "elementdmg" then
                  return funcResult
                elseif returnvalue == "elementype" then
                  return funcResult
                elseif returnvalue == "elementnum" then
                  return funcResult
                elseif returnvalue == "phydmglimit" then
                  local phydmglimit = funcResult
                  deltaValueUsedAddBuffReturnValue = phydmglimit
                  buffComponentB._phyDmgLimit = -phydmglimit
                elseif returnvalue == "magicdmglimit" then
                  local magicdmglimit = funcResult
                  deltaValueUsedAddBuffReturnValue = magicdmglimit
                  buffComponentB._magicDmgLimit = -magicdmglimit
                elseif returnvalue == "dmglimitrate" then
                  local dmglimitrate = funcResult
                  deltaValueUsedAddBuffReturnValue = dmglimitrate
                  buffComponentB._dmgLimitRate = dmglimitrate
                elseif returnvalue == "dmgskilladd_value" then
                  local skillbonus = funcResult
                  deltaValueUsedAddBuffReturnValue = skillbonus
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._skillDamageBonus = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._skillDamageBonus + skillbonus
                elseif returnvalue == "healskilladd_value" then
                  local skillbonus = funcResult
                  deltaValueUsedAddBuffReturnValue = skillbonus
                  ;
                  ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._skillTreeteBonus = ((self._entity):GetComponent((BattleECS.Components).AttackComponent))._skillTreeteBonus + skillbonus
                else
                  -- DECOMPILER ERROR at PC3500: Unhandled construct in 'MakeBoolean' P1

                  if returnvalue == "orderpwr_value" and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                    local orderpwr = funcResult
                    ;
                    (self._battleWorld):AddRedPower(orderpwr)
                  end
                end
                do
                  -- DECOMPILER ERROR at PC3524: Unhandled construct in 'MakeBoolean' P1

                  if returnvalue == "chaospwr_value" and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                    local chaospwr = funcResult
                    ;
                    (self._battleWorld):AddBluePower(chaospwr)
                  end
                  if returnvalue == "shield_value" then
                    local sheild = funcResult
                    local damageTypeStr = ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).buffattr
                    if (string.find)(damageTypeStr, "10000") and (string.find)(damageTypeStr, "10001") and (string.find)(damageTypeStr, "10007") then
                      local index = nil
                      for i,v in ipairs(self._buffAdditionalAttribute) do
                        if v.key == returnvalue .. self._buffID then
                          index = i
                          break
                        end
                      end
                      -- DECOMPILER ERROR at PC3583: Confused about usage of register: R30 in 'UnsetPending'

                      ;
                      ((self._buffAdditionalAttribute)[index]).value = ((self._buffAdditionalAttribute)[index]).value + sheild
                      local isHas = false
                      for _,v in ipairs(((self._entity):GetComponent((BattleECS.Components).HpComponent))._damageSheildNumberList) do
                        if v.buffid == self._buffID then
                          local shieldType = nil
                          if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[v.buffid]).classname == "shieldbuff" then
                            shieldType = ShowShieldType.NormalShield
                          end
                          v.number = sheild
                          ;
                          (((BattleECS.Utility).ProtocolUtility).SendShieldValueChange)((self._entity)._entityId, v.buffid, shieldType, v.number, self._battleWorld)
                          isHas = true
                        end
                      end
                      if not isHas then
                        (table.insert)(((self._entity):GetComponent((BattleECS.Components).HpComponent))._damageSheildNumberList, {buffid = self._buffID, number = sheild, shieldComeFromEntity = self._enermyEntity})
                        local shieldType = nil
                        if ((((BattleECS.Utility).DataUtility).cBuffCfgTable)[self._buffID]).classname == "shieldbuff" then
                          shieldType = ShowShieldType.NormalShield
                        end
                        ;
                        (((BattleECS.Utility).ProtocolUtility).SendShieldValueChange)((self._entity)._entityId, self._buffID, shieldType, sheild, self._battleWorld)
                      end
                    end
                  elseif returnvalue == "combonum_value" then
                    local combonum = funcResult
                    deltaValueUsedAddBuffReturnValue = combonum
                    skillComponentB._comboNumber = skillComponentB._comboNumber + combonum
                  elseif returnvalue == "bosscombonum_value" then
                    local combonum = funcResult
                    deltaValueUsedAddBuffReturnValue = combonum
                    skillComponentB._bossComboNumber = skillComponentB._bossComboNumber + combonum
                  elseif returnvalue == "cooldownreduce_value" then
                    local cooldownreduce = funcResult
                    if skillComponentB._skillCoolDownReduce + cooldownreduce > 100 then
                      cooldownreduce = 100 - skillComponentB._skillCoolDownReduce
                    end
                    deltaValueUsedAddBuffReturnValue = cooldownreduce
                    skillComponentB._skillCoolDownReduce = skillComponentB._skillCoolDownReduce + (cooldownreduce)
                    for _,v in ipairs(skillComponentB._skillList) do
                      if ((((BattleECS.Utility).DataUtility).cskillTable)[v.skillId]).effecttype == 2 then
                        v.cdTime = v.cdTime * ((100 - skillComponentB._skillCoolDownReduce) / 100)
                      end
                    end
                  elseif returnvalue == "passiveskill_value" then
                    local passiveskill = funcResult
                    deltaValueUsedAddBuffReturnValue = passiveskill
                    skillComponentB._isHasPassiveSkillParamter = skillComponentB._isHasPassiveSkillParamter + passiveskill
                  elseif returnvalue == "ordercostreduce_value" then
                    local ordercostreduce = funcResult
                    deltaValueUsedAddBuffReturnValue = ordercostreduce
                    -- DECOMPILER ERROR at PC3759: Confused about usage of register: R28 in 'UnsetPending'

                    ;
                    (skillComponentB._skillCostPowerReduceList).order = (skillComponentB._skillCostPowerReduceList).order + ordercostreduce
                    ;
                    (((BattleECS.Utility).ProtocolUtility).SendRoleSkillPowerReduce)((self._entity)._entityId, (skillComponentB._skillCostPowerReduceList).order, (skillComponentB._skillCostPowerReduceList).chaos, self._battleWorld)
                  elseif returnvalue == "chaoscostreduce_value" then
                    local chaoscostreduce = funcResult
                    deltaValueUsedAddBuffReturnValue = chaoscostreduce
                    -- DECOMPILER ERROR at PC3791: Confused about usage of register: R28 in 'UnsetPending'

                    ;
                    (skillComponentB._skillCostPowerReduceList).chaos = (skillComponentB._skillCostPowerReduceList).chaos + chaoscostreduce
                    ;
                    (((BattleECS.Utility).ProtocolUtility).SendRoleSkillPowerReduce)((self._entity)._entityId, (skillComponentB._skillCostPowerReduceList).order, (skillComponentB._skillCostPowerReduceList).chaos, self._battleWorld)
                  elseif returnvalue == "critratelev_value" then
                    local critratelev = funcResult
                    deltaValueUsedAddBuffReturnValue = critratelev
                    attackComponnetB._attackCritLevel = attackComponnetB._attackCritLevel + critratelev
                    attackComponnetB._attackCritLevel = getcritlevelsection(attackComponnetB._attackCritLevel)
                  elseif returnvalue == "critdegreelev_value" then
                    local critdegreelev = funcResult
                    deltaValueUsedAddBuffReturnValue = critdegreelev
                    attackComponnetB._attackCritDegreeLevel = attackComponnetB._attackCritDegreeLevel + critdegreelev
                    attackComponnetB._attackCritDegreeLevel = getcritdegreesection(attackComponnetB._attackCritDegreeLevel)
                  elseif (string.match)(returnvalue, "buff%d+num_value") then
                    local buffnum = funcResult
                    deltaValueUsedAddBuffReturnValue = buffnum
                    -- DECOMPILER ERROR at PC3863: Confused about usage of register: R28 in 'UnsetPending'

                    if not (buffComponentB._buffnum)[returnvalue] then
                      do
                        (buffComponentB._buffnum)[returnvalue] = _ENV.fixedpoint_zero
                        -- DECOMPILER ERROR at PC3870: Confused about usage of register: R28 in 'UnsetPending'

                        ;
                        (buffComponentB._buffnum)[returnvalue] = (buffComponentB._buffnum)[returnvalue] + buffnum
                        -- DECOMPILER ERROR at PC3890: Unhandled construct in 'MakeBoolean' P1

                        if returnvalue == "orderpwrgrow_value" and ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                          local orderspeed = funcResult / 100
                          deltaValueUsedAddBuffReturnValue = orderspeed
                          local isHas = nil
                          for i,v in ipairs((self._battleWorld)._battleWorldPowerIncreaseSpeed) do
                            if v.buffid == self._buffID then
                              v.addition = orderspeed
                              v.stack = self:GetStackTimesCur()
                              isHas = true
                            end
                          end
                          if not isHas then
                            (table.insert)((self._battleWorld)._battleWorldPowerIncreaseSpeed, {buffid = self._buffID, addition = orderspeed, stack = self:GetStackTimesCur()})
                          end
                        end
                        if returnvalue == "magicevasion_value" then
                          local evasion = funcResult
                          deltaValueUsedAddBuffReturnValue = evasion
                          ;
                          ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicEvasion = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._magicEvasion + evasion
                        elseif returnvalue == "physicalevasion_value" then
                          local evasion = funcResult
                          deltaValueUsedAddBuffReturnValue = evasion
                          ;
                          ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._physicalEvasion = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._physicalEvasion + evasion
                        elseif returnvalue == "dmglimitrate_value" then
                          local dmglimitrate = funcResult
                          deltaValueUsedAddBuffReturnValue = dmglimitrate
                          buffComponentB._dmgLimitRate = buffComponentB._dmgLimitRate + dmglimitrate
                        elseif returnvalue == "attacktime_value" then
                          local times = funcResult
                          deltaValueUsedAddBuffReturnValue = times
                          buffComponentB._attackTime = buffComponentB._attackTime + times
                        elseif returnvalue == "phydmgmax" then
                          local bringoutphydmglimit = funcResult
                          deltaValueUsedAddBuffReturnValue = bringoutphydmglimit
                          buffComponentA._bringOutPhyDmgLimit = -bringoutphydmglimit
                        elseif returnvalue == "magicdmgmax" then
                          local bringoutmagicdmglimit = funcResult
                          deltaValueUsedAddBuffReturnValue = bringoutmagicdmglimit
                          buffComponentA._bringOutMagicDmgLimit = -bringoutmagicdmglimit
                        else
                          -- DECOMPILER ERROR at PC4031: Unhandled construct in 'MakeBoolean' P1

                          if returnvalue == "enemyorderpwr_value" and ((self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                            local orderpwr = funcResult
                            ;
                            (self._battleWorld):AddRedPower(orderpwr)
                          end
                        end
                        do
                          -- DECOMPILER ERROR at PC4055: Unhandled construct in 'MakeBoolean' P1

                          if returnvalue == "enemychaospwr_value" and ((self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                            local chaospwr = funcResult
                            ;
                            (self._battleWorld):AddBluePower(chaospwr)
                          end
                          -- DECOMPILER ERROR at PC4079: Unhandled construct in 'MakeBoolean' P1

                          if returnvalue == "enemyorderpwrgrow_value" and ((self._enermyEntity):GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                            local orderspeed = funcResult / 100
                            deltaValueUsedAddBuffReturnValue = orderspeed
                            local isHas = nil
                            for i,v in ipairs((self._battleWorld)._battleWorldPowerIncreaseSpeed) do
                              if v.buffid == self._buffID then
                                v.addition = orderspeed
                                v.stack = self:GetStackTimesCur()
                                isHas = true
                              end
                            end
                            if not isHas then
                              (table.insert)((self._battleWorld)._battleWorldPowerIncreaseSpeed, {buffid = self._buffID, addition = orderspeed, stack = self:GetStackTimesCur()})
                            end
                          end
                          if returnvalue == "damagereduce_value" then
                            local damagereduce = funcResult
                            deltaValueUsedAddBuffReturnValue = damagereduce
                            ;
                            ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._damageReduce = ((self._entity):GetComponent((BattleECS.Components).DefenseComponent))._damageReduce + damagereduce
                          elseif returnvalue == "runelv_value" then
                            local runelv = funcResult
                            deltaValueUsedAddBuffReturnValue = runelv
                            ;
                            ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._runelv = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._runelv + runelv
                          end
                          local index = nil
                          for i,v in ipairs(self._buffAdditionalAttribute) do
                            if v.key == returnvalue then
                              index = i
                              break
                            end
                          end
                          -- DECOMPILER ERROR at PC4185: Confused about usage of register: R28 in 'UnsetPending'

                          if index then
                            ((self._buffAdditionalAttribute)[index]).value = ((self._buffAdditionalAttribute)[index]).value + deltaValueUsedAddBuffReturnValue
                            if (self._stackCurrentTime)[self:GetStackTimesCur()] then
                              local whenAddStackTimesTheIndex = ((self._stackCurrentTime)[self:GetStackTimesCur()]).index
                              -- DECOMPILER ERROR at PC4210: Confused about usage of register: R29 in 'UnsetPending'

                              if not (self._everyStackTimesBuffAdditionalAttribute)[whenAddStackTimesTheIndex] then
                                (self._everyStackTimesBuffAdditionalAttribute)[whenAddStackTimesTheIndex] = {}
                                do
                                  local dontHaveEveryStackTimesBuffAdditionalAttribute = false
                                  for _,v in ipairs((self._everyStackTimesBuffAdditionalAttribute)[whenAddStackTimesTheIndex]) do
                                    if v.key == returnvalue then
                                      dontHaveEveryStackTimesBuffAdditionalAttribute = true
                                      v.value = ((self._buffAdditionalAttribute)[index]).value - preBuffAdditionalAttribute
                                      break
                                    end
                                  end
                                  if not dontHaveEveryStackTimesBuffAdditionalAttribute then
                                    (table.insert)((self._everyStackTimesBuffAdditionalAttribute)[whenAddStackTimesTheIndex], {key = returnvalue, value = ((self._buffAdditionalAttribute)[index]).value - preBuffAdditionalAttribute})
                                  end
                                  -- DECOMPILER ERROR: 232 unprocessed JMP targets
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

return Buff

