local System = require("ecs.system")
local SkillEffectSystem = strictclass("SkillEffectSystem", System)

function SkillEffectSystem:Ctor(...)
  SkillEffectSystem.super.Ctor(self, ...)
  self._utility = BattleECS.Utility.Utility
  self._protocolUtility = BattleECS.Utility.ProtocolUtility
  self._buffUtility = BattleECS.Utility.BuffUtility
  self._physicsUtility = BattleECS.Utility.PhysicsUtility
  self._dataUtility = BattleECS.Utility.DataUtility
  table.insert(self._requiredComponents, BattleECS.Components.SkillEffectComponent)
  table.insert(self._requiredComponents, BattleECS.Components.TypeComponent)
end

function SkillEffectSystem:Destroy()
  SkillEffectSystem.super.Destroy(self)
end

function SkillEffectSystem:Update()
  local SkillEffectComponent = BattleECS.Components.SkillEffectComponent
  local TypeComponent = BattleECS.Components.TypeComponent
  local PositionComponent = BattleECS.Components.PositionComponent
  local SkillComponent = BattleECS.Components.SkillComponent
  local AttackComponent = BattleECS.Components.AttackComponent
  local HpComponent = BattleECS.Components.HpComponent
  local BuffComponent = BattleECS.Components.BuffComponent
  local sceneEffectFlyItemTypeEqual2List = {}
  local buffEffectFlyItemTypeEqual2List = {}
  for _, entity in ipairs(self._entitys) do
    local component = entity:GetComponent(SkillEffectComponent)
    if component then
      local useskillentity
      for _, e in ipairs(self._world._entitys) do
        if e._entityId == component._useSkillEntityID then
          useskillentity = e
          break
        end
      end
      if not useskillentity then
        self:SetDestroyTagSkillEntity(entity, component)
        return
      end
      local camp = useskillentity:GetComponent(TypeComponent)._camp
      if self._utility.IsRoleDead(useskillentity) then
        self:DestroyEffectByNameWithJudgeDeleteOrNor(component, component._invalidEffectAtkList, camp)
        self:DestroyEffectByNameWithJudgeDeleteOrNor(component, component._typeMineEffectAtkList, camp)
        self:DestroyEffectByNameWithJudgeDeleteOrNor(component, component._flightPropEffectAtk, camp)
        self:DestroyEffectByNameWithJudgeDeleteOrNor(component, component._noColliderEffectList, camp)
        self:DestroyEffectByNameWithJudgeDeleteOrNor(component, component._warningEffectList, camp)
        self:SetDestroyTagSkillEntity(entity, component)
        return
      end
      if not self._buffUtility.IsSkillHasInterreptBuff(component._skillID) and self._buffUtility.IsRoleHasInterruptedSKillBuff(useskillentity, component._skillID) then
        for _, v in ipairs(component._invalidEffectAtkList) do
          local effectConfig = self._dataUtility.cSkillEffectTable[v.effectid]
          if effectConfig.deviationAngleOrNot == 1 then
            self._protocolUtility.SendDestroyBuffEffectProtocol(component._useSkillEntityID, effectConfig.socket, effectConfig.effectName, self._world)
          end
        end
        self:DestroyEffectByName(component._invalidEffectAtkList, camp)
        self:DestroyEffectByName(component._typeMineEffectAtkList, camp)
        self:DestroyEffectByName(component._flightPropEffectAtk, camp)
        self:DestroyEffectByName(component._noColliderEffectList, camp)
        self:DestroyEffectByName(component._warningEffectList, camp)
        self:SetDestroyTagSkillEntity(entity, component)
        self._protocolUtility.SendSkillInterrupted(component._useSkillEntityID, component._skillID, self._world)
        if useskillentity:GetComponent(TypeComponent)._camp == TypeComponent.CampType.Right then
          self._world._rightCampSkillInterruptedTime = self._world._rightCampSkillInterruptedTime + 1
        end
        local cskillcameramoverecord = self._dataUtility.cSkillCameraMoveTable[component._skillID]
        if cskillcameramoverecord and cskillcameramoverecord.CameraMoveType ~= 0 then
          local MoveType = {Interrept = -2}
          self._protocolUtility.SendPlayBattleCameraAnimationName(MoveType.Interrept, -1, -1, component._skillID, self._world)
        end
        component = useskillentity:GetComponent(BuffComponent)
        if component then
          component._delayBuffList = {}
        end
        return
      end
      component._attackTime = component._attackTime + 1
      if self._utility.IsYingXiSkill(component._skillID) then
        if component._attackTime == self._utility.GetMonsterOrRoleMagicOrAttackEndFraps(useskillentity, component._skillID) then
          local isimaged = 0
          if useskillentity:GetComponent(TypeComponent)._isImaged then
            isimaged = 1
          end
          self._protocolUtility.SendUseSkill(component._skillID, component._useSkillEntityID, isimaged, camp, self._world)
          local hittedEntityList = component._attackEntityList
          local record
          for _, v in ipairs(hittedEntityList) do
            record = v:GetComponent(PositionComponent)
          end
          local offset = tonumber(self._dataUtility.cBattleConstCfgTable[12].attr)
          if camp == TypeComponent.CampType.Right then
            offset = -offset
          end
          local y = useskillentity:GetComponent(PositionComponent)._position.y
          self._world:SetLeftPlayerPositionAndImaged(component._useSkillEntityID, record._position.x - offset, y, true)
          local attackID = self._utility.GetEntityAttackSkillID(useskillentity)
          if attackID then
            for _, skillTable in ipairs(useskillentity:GetComponent(SkillComponent)._skillList) do
              if skillTable.skillId == attackID then
                skillTable.currentTime = self._dataUtility.cSkillCostTable[attackID].CDfraps
                break
              end
            end
          end
          for _, v in ipairs(component._animationAtkList) do
            if component._attackTime == v.loopTime then
              local ifIgnorePriority = {No = 0, Yes = 1}
              self._protocolUtility.SendBattlerPlayAnimationByNameProtocol(useskillentity, v.endAnimation, ifIgnorePriority.No, self._world)
            end
          end
          entity:GetComponent(TypeComponent)._isNeedDestroy = true
          entity:GetComponent(TypeComponent)._isNeedSendProtocolDestroy = false
        end
        return
      end
      if component._skillID == 201034 and component._attackTime == self._utility.GetFrogRider201034DestroyFraps() then
        self._physicsUtility.SetEntityPhyscisComponentAwake(useskillentity, true)
        self._physicsUtility.SetEntityAwake(self._world._physicsWorld, useskillentity, true)
        entity:GetComponent(TypeComponent)._isNeedDestroy = true
        entity:GetComponent(TypeComponent)._isNeedSendProtocolDestroy = false
      end
      for _, v in ipairs(component._animationAtkList) do
        if component._attackTime == v.loopTime then
          local ifIgnorePriority = {No = 0, Yes = 1}
          self._protocolUtility.SendBattlerPlayAnimationByNameProtocol(useskillentity, v.endAnimation, ifIgnorePriority.No, self._world)
        end
      end
      self:TraversalEffectList(component._invalidEffectAtkList, component, useskillentity, entity, camp, sceneEffectFlyItemTypeEqual2List, buffEffectFlyItemTypeEqual2List)
      for _, v in ipairs(component._invalidEffectAtkList) do
        local effectConfig = self._dataUtility.cSkillEffectTable[v.effectid]
        if component._attackTime == effectConfig.fraps + component._startAnimationDelayTime and self._utility.IsSkillHas10006Buff(component._skillID) then
          self:CreateBuffEffect(buffEffectFlyItemTypeEqual2List, useskillentity, effectConfig)
        end
        if component._attackTime == effectConfig.HitFraps + component._startAnimationDelayTime then
          if component._skillID == 201014 or component._skillID == 201016 then
            entity:GetComponent(TypeComponent)._isNeedDestroy = true
            entity:GetComponent(TypeComponent)._isNeedSendProtocolDestroy = false
            for _, player in ipairs(self._world._leftPlayerList) do
              if not self._utility.IsRoleDead(player) and self._world:GetCampWinState() == "" then
                self._buffUtility.SetBuffListToEnemyCampEntityBySkillID(player, useskillentity, component._skillID, self._world, 0)
              end
            end
          elseif self._utility.IsSkillHas10006Buff(component._skillID) then
            local ourlist = self._buffUtility.GetSKillBuffList(component._skillID)
            for _, v in ipairs(ourlist) do
              self._buffUtility.InsertEntityDifferentBuff({
                entity = useskillentity,
                enermyentity = useskillentity,
                buffid = tonumber(v.buffid),
                buffparamter = v.buffvalues,
                skillid = component._skillID,
                battleworld = self._world
              })
            end
            entity:GetComponent(TypeComponent)._isNeedDestroy = true
            entity:GetComponent(TypeComponent)._isNeedSendProtocolDestroy = false
          elseif self._utility.IsDamageReBoundSkill(component._skillID) then
            local damagefrom = useskillentity:GetComponent(HpComponent)._lastDamageFrom
            local damagefromEntity
            for _, e in ipairs(self._world._entitys) do
              if e._entityId == damagefrom then
                damagefromEntity = e
                break
              end
            end
            if damagefromEntity then
              local damageFromCamp = damagefromEntity:GetComponent(TypeComponent)._camp
              local useskillEntityCamp = useskillentity:GetComponent(TypeComponent)._camp
              if damageFromCamp ~= useskillEntityCamp then
                self._buffUtility.SetBuffListToEnemyCampEntityBySkillID(damagefromEntity, useskillentity, component._skillID, self._world, 0)
              end
            end
          end
        end
      end
      self:TraversalEffectList(component._noColliderEffectList, component, useskillentity, entity, camp, sceneEffectFlyItemTypeEqual2List, buffEffectFlyItemTypeEqual2List)
      for _, v in ipairs(component._noColliderEffectList) do
        local effectConfig = self._dataUtility.cSkillEffectTable[v.effectid]
        if component._attackTime == effectConfig.HitFraps + component._startAnimationDelayTime then
          local ourBuffEntityList = self._utility.GetSkillOurCampEntityList(component._skillID, component._useSkillEntityID, self._world)
          if ourBuffEntityList then
            for _, v in ipairs(ourBuffEntityList) do
              if self._world:GetCampWinState() == "" then
                self._buffUtility.SetBuffListToOwnCampEntityBySkillID(v, useskillentity, component._skillID, self._world)
              end
            end
          end
          local hittedEntityList = self._utility.GetSkillEffectEntity(component._skillID, component._useSkillEntityID, self._world)
          if hittedEntityList then
            for _, v in ipairs(hittedEntityList) do
              self._buffUtility.SetBuffListToEnemyCampEntityBySkillID(v, useskillentity, component._skillID, self._world, 0)
            end
          end
        end
      end
      self:TraversalEffectList(component._warningEffectList, component, useskillentity, entity, camp, sceneEffectFlyItemTypeEqual2List, buffEffectFlyItemTypeEqual2List)
      for _, v in ipairs(component._flightPropEffectAtk) do
        local effectConfig = self._dataUtility.cSkillEffectTable[v.effectid]
        if effectConfig.isCut == 1 then
          if self._world._actor_shiKongZhiMen_w[camp] then
            self._protocolUtility.SendSetClipRectForShiKongZhiMen(effectConfig.id, self._world._actor_shiKongZhiMen_w[camp], self._world._actor_shiKongZhiMen_h[camp], camp, effectConfig.effectName, self._world, true)
          else
            self._world._actor_shiKongZhiMen_effectList[effectConfig.id] = {
              entityId = effectConfig.id,
              camp = camp,
              effectName = effectConfig.effectName
            }
          end
          self._world._actor_shiKongZhiMenRelease_effectList[effectConfig.id] = {
            entityId = effectConfig.id,
            camp = camp,
            effectName = effectConfig.effectName
          }
        end
        self._world._actor_shiKongTingZhi_effectList[effectConfig.id] = {
          entityId = -effectConfig.id,
          camp = camp,
          effectName = effectConfig.effectName
        }
        if component._attackTime == effectConfig.fraps + component._startAnimationDelayTime then
          if effectConfig.gAcceleration ~= 0 then
            self._world:CreateParaBaloSkill(component._useSkillEntityID, v.hittedEntityID, effectConfig, component._skillID)
          else
            self._world:CreateHorizontalUniformSpeedFlyingProp(effectConfig, component._skillID, component._useSkillEntityID, v.hittedEntityID, true, v.effectid)
          end
        elseif effectConfig.effecttime ~= 0 and component._attackTime == effectConfig.fraps + component._startAnimationDelayTime + effectConfig.effecttime then
          self._protocolUtility.SendDestroyBuffEffectProtocol(component._useSkillEntityID, effectConfig.socket, effectConfig.effectName, self._world)
          self._protocolUtility.SendDestroyEffectByName(camp, effectConfig.effectName, self._world)
        end
      end
      for _, v in ipairs(component._typeMineEffectAtkList) do
        local effectConfig = self._dataUtility.cSkillEffectTable[v.effectid]
        if effectConfig.isCut == 1 then
          if self._world._actor_shiKongZhiMen_w[camp] then
            self._protocolUtility.SendSetClipRectForShiKongZhiMen(effectConfig.id, self._world._actor_shiKongZhiMen_w[camp], self._world._actor_shiKongZhiMen_h[camp], camp, effectConfig.effectName, self._world, true)
          else
            self._world._actor_shiKongZhiMen_effectList[effectConfig.id] = {
              entityId = effectConfig.id,
              camp = camp,
              effectName = effectConfig.effectName
            }
          end
          self._world._actor_shiKongZhiMenRelease_effectList[effectConfig.id] = {
            entityId = effectConfig.id,
            camp = camp,
            effectName = effectConfig.effectName
          }
        end
        self._world._actor_shiKongTingZhi_effectList[effectConfig.id] = {
          entityId = -effectConfig.id,
          camp = camp,
          effectName = effectConfig.effectName
        }
        if self._utility.IsSkillHas10006Buff(component._skillID) then
          local entitylist = self._utility.GetSkillOurCampEntityList(component._skillID, component._useSkillEntityID, self._world)
          if component._attackTime == effectConfig.fraps + component._startAnimationDelayTime then
            for _, player in ipairs(entitylist) do
              if effectConfig.effectOwner == 0 then
                local pos = useskillentity:GetComponent(PositionComponent)
                local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(useskillentity)
                local delt = self._utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, effectConfig.socket)
                local y = pos._targetPos.y + delt.y
                local x = pos._targetPos.x + delt.x
                local z = pos._position.z + delt.z
                self._world:CreateConfirmPositionProp(effectConfig, component._skillID, useskillentity, x, y, z, entity, v.effectid, false)
              elseif effectConfig.effectOwner == 1 then
                local pos = player:GetComponent(PositionComponent)
                local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(player)
                local delt = self._utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, effectConfig.socket)
                local y = pos._targetPos.y + delt.y
                local x = pos._targetPos.x + delt.x
                local z = pos._position.z + delt.z
                self._world:CreateConfirmPositionProp(effectConfig, component._skillID, useskillentity, x, y, z, entity, v.effectid, false)
              end
            end
          elseif effectConfig.effecttime ~= 0 and component._attackTime == effectConfig.fraps + component._startAnimationDelayTime + effectConfig.effecttime then
            self._protocolUtility.SendDestroyBuffEffectProtocol(component._useSkillEntityID, effectConfig.socket, effectConfig.effectName, self._world)
            self._protocolUtility.SendDestroyEffectByName(camp, effectConfig.effectName, self._world)
          end
          if component._attackTime == effectConfig.HitFraps + component._startAnimationDelayTime and self._world:GetCampWinState() == "" then
            local haveHit = false
            for _, player in ipairs(entitylist) do
              local ourlist = self._buffUtility.GetSKillBuffList(component._skillID)
              for _, v in ipairs(ourlist) do
                if tonumber(v.buffid) == 10006 then
                  haveHit = true
                end
                self._buffUtility.InsertEntityDifferentBuff({
                  entity = player,
                  enermyentity = useskillentity,
                  buffid = tonumber(v.buffid),
                  buffparamter = v.buffvalues,
                  skillid = component._skillID,
                  battleworld = self._world
                })
              end
              self._world:RevivePlayer(player._entityId)
            end
            if haveHit then
              component._typeMineEffectAtkEffectTime = component._typeMineEffectAtkEffectTime + 1
            end
          end
        else
          if component._skillID == 201015 and component._attackTime == self._utility.GetMonsterOrRoleMagicOrAttackEndFraps(useskillentity, component._skillID) and self._buffUtility.IsHasCurrentBuff(useskillentity, 20014) then
            self._buffUtility.SetEntityBuffEffectState(useskillentity, 20014, true)
            local ifIgnorePriority = {No = 0, Yes = 1}
            self._protocolUtility.SendBattlerPlayAnimationByNameProtocol(useskillentity, "Stop", ifIgnorePriority.No, self._world)
            self._protocolUtility.SendSkillStart(201013, self._world)
          end
          if component._attackTime == effectConfig.fraps + component._startAnimationDelayTime then
            local hittedEntity
            for _, e in ipairs(self._world._entitys) do
              if e._entityId == v.hittedEntityID then
                hittedEntity = e
                break
              end
            end
            if hittedEntity then
              if self._utility.IsLiuGuangZhan(component._skillID) and self._utility.IsRoleDead(hittedEntity) then
                hittedEntity = self._utility.GetSkillEffectEntity(component._skillID, component._useSkillEntityID, self._world)[1]
              end
              if effectConfig.effectOwner == 0 then
                local pos = useskillentity:GetComponent(PositionComponent)
                local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(useskillentity)
                local delt = self._utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, effectConfig.socket)
                local x, y, z = 0, 0, 0
                if camp == TypeComponent.CampType.Left then
                  if self._utility.IsShiBuKeDang(component._skillID) then
                    x, y = pos._position.x + delt.x, pos._position.y + delt.y
                  else
                    x, y = pos._position.x + delt.x, pos._position.y + delt.y
                  end
                  z = pos._position.z + delt.z
                else
                  x, y = pos._position.x - delt.x, pos._position.y + delt.y
                  z = pos._position.z + delt.z
                end
                if component._skillID == 201046 then
                  x = x + component._randomDeltXOffect
                  local XOffect = string.split(self._dataUtility.cBattleConstCfgTable[58].attr, ";")
                  component._randomDeltXOffect = component._randomDeltXOffect + (fixedpoint(XOffect[1]) - self._world._randomPcg(1, 1000) * (fixedpoint(XOffect[2]) - fixedpoint(XOffect[1])) / 1000)
                end
                self._world:CreateConfirmPositionProp(effectConfig, component._skillID, useskillentity, x, y, z, entity, v.effectid, true)
              elseif effectConfig.effectOwner == 1 then
                if self._utility.IsSkillTypeEffectNeedDiffTarget(component._skillID) then
                  hittedEntity = self._utility.GetSkillEffectEntity(component._skillID, component._useSkillEntityID, self._world)[1]
                end
                if hittedEntity then
                  local pos = hittedEntity:GetComponent(PositionComponent)
                  local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(hittedEntity)
                  local delt = self._utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, effectConfig.socket)
                  local x, y, z = 0, 0, 0
                  local hittedCamp = hittedEntity:GetComponent(TypeComponent)._camp
                  if hittedCamp == TypeComponent.CampType.Left then
                    x, y = pos._position.x + delt.x, pos._position.y + delt.y
                    z = pos._position.z + delt.z
                  else
                    x, y = pos._position.x - delt.x, pos._position.y + delt.y
                    z = pos._position.z + delt.z
                  end
                  self._world:CreateConfirmPositionProp(effectConfig, component._skillID, useskillentity, x, y, z, entity, v.effectid, true)
                else
                  for _, v in ipairs(component._animationAtkList) do
                    local ifIgnorePriority = {No = 0, Yes = 1}
                    self._protocolUtility.SendBattlerPlayAnimationByNameProtocol(useskillentity, v.endAnimation, ifIgnorePriority.No, self._world)
                  end
                  self:SetDestroyTagSkillEntity(entity, component)
                end
              elseif effectConfig.effectOwner == 2 then
                local x, y, z = 0, 0, 0
                if camp == TypeComponent.CampType.Left then
                  local record = self._world._battlePosList[tonumber(effectConfig.lefteffectPosId)]
                  if record then
                    x, y, z = record.x, record.y, record.z
                  else
                    LogErrorFormat("SkillEffectSystem", "id %s lefteffectPosId %s", effectConfig.id, effectConfig.lefteffectPosId)
                  end
                else
                  local record = self._world._battlePosList[tonumber(effectConfig.righteffectPosId)]
                  if record then
                    x, y, z = record.x, record.y, record.z
                  else
                    LogErrorFormat("SkillEffectSystem", "id %s righteffectPosId %s", effectConfig.id, effectConfig.righteffectPosId)
                  end
                end
                self._world:CreateConfirmPositionProp(effectConfig, component._skillID, useskillentity, x, y, z, entity, v.effectid, true)
              end
            end
          elseif effectConfig.effecttime ~= 0 and component._attackTime == effectConfig.fraps + component._startAnimationDelayTime + effectConfig.effecttime then
            self._protocolUtility.SendDestroyBuffEffectProtocol(component._useSkillEntityID, effectConfig.socket, effectConfig.effectName, self._world)
            self._protocolUtility.SendDestroyEffectByName(camp, effectConfig.effectName, self._world)
          end
          if component._attackTime == effectConfig.HitFraps + component._startAnimationDelayTime then
            local haveHit = false
            for i, v in ipairs(component._flyEntityList) do
              if v.hitFraps == effectConfig.HitFraps then
                local flyentity
                for _, e in ipairs(self._world._entitys) do
                  if e._entityId == v.entityId then
                    flyentity = e
                    break
                  end
                end
                if flyentity then
                  haveHit = true
                  component._flyEntityList[i].hitFraps = -1
                  local pos = flyentity:GetComponent(PositionComponent)
                  local x, y = pos._position.x, pos._position.y
                  self._world:AddBoxBodyToEntity(effectConfig, component._skillID, useskillentity, x, y, v.entityId)
                end
              end
            end
            if haveHit then
              component._typeMineEffectAtkEffectTime = component._typeMineEffectAtkEffectTime + 1
            end
          end
        end
      end
      if component._attackTime == component._flyNeedDestroyMaxFrap then
        if component._skillID ~= 201034 then
          entity:GetComponent(TypeComponent)._isNeedDestroy = true
          entity:GetComponent(TypeComponent)._isNeedSendProtocolDestroy = false
        else
          local isJoin, data = self._utility.IsJoinBattleAndEnoughCondition(self._world._battleID)
          if data.chatId ~= 0 then
            local BattlePauseType = BattleClientProtocolManager.GetBeanDef("data.battlepausetype")
            local protocol = BattleClientProtocolManager.CreateProtocol("action.sbattlepause")
            protocol.pauseType = BattlePauseType.NpcChat
            protocol.param = tostring(data.chatId)
            self._world:InsertViewProtocolData(protocol)
          end
        end
      end
    end
  end
end

function SkillEffectSystem:TraversalEffectList(effectList, skillEffectComponent, useskillentity, curEntity, camp, sceneEffectFlyItemTypeEqual2List, buffEffectFlyItemTypeEqual2List)
  local TypeComponent = BattleECS.Components.TypeComponent
  local PositionComponent = BattleECS.Components.PositionComponent
  for _, v in ipairs(effectList) do
    local effectConfig = self._dataUtility.cSkillEffectTable[v.effectid]
    if effectConfig.isCut == 1 then
      if self._world._actor_shiKongZhiMen_w[camp] then
        self._protocolUtility.SendSetClipRectForShiKongZhiMen(effectConfig.id, self._world._actor_shiKongZhiMen_w[camp], self._world._actor_shiKongZhiMen_h[camp], camp, effectConfig.effectName, self._world, true)
      else
        self._world._actor_shiKongZhiMen_effectList[effectConfig.id] = {
          entityId = effectConfig.id,
          camp = camp,
          effectName = effectConfig.effectName
        }
      end
      self._world._actor_shiKongZhiMenRelease_effectList[effectConfig.id] = {
        entityId = effectConfig.id,
        camp = camp,
        effectName = effectConfig.effectName
      }
    end
    self._world._actor_shiKongTingZhi_effectList[effectConfig.id] = {
      entityId = -effectConfig.id,
      camp = camp,
      effectName = effectConfig.effectName
    }
    if skillEffectComponent._attackTime == effectConfig.fraps + skillEffectComponent._startAnimationDelayTime then
      if effectConfig.deviationAngleOrNot == 1 then
        local hittedentity
        for _, e in ipairs(self._world._entitys) do
          if e._entityId == v.hittedEntityID then
            hittedentity = e
            break
          end
        end
        if hittedentity then
          local rad, sin, deg = self._utility.ReturnEffectRad(useskillentity, hittedentity, effectConfig.socket)
          self:CreateBuffEffect(buffEffectFlyItemTypeEqual2List, useskillentity, effectConfig, deg)
        end
      elseif effectConfig.deleteOrNot == 1 then
        if effectConfig.effectOwner == 1 then
          local hittedentity
          for _, e in ipairs(self._world._entitys) do
            if e._entityId == v.hittedEntityID then
              hittedentity = e
              break
            end
          end
          if hittedentity then
            if skillEffectComponent._warningEffectList == effectList then
              self:CreateBuffEffect(buffEffectFlyItemTypeEqual2List, hittedentity, effectConfig)
            else
              local pos = hittedentity:GetComponent(PositionComponent)
              local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(hittedentity)
              local delt = self._utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, effectConfig.socket)
              local x, y, z = 0, 0, 0
              local hittedCamp = hittedentity:GetComponent(TypeComponent)._camp
              if hittedCamp == TypeComponent.CampType.Left then
                x, y = pos._position.x + delt.x, pos._position.y + delt.y
                z = pos._position.z + delt.z
              else
                x, y = pos._position.x - delt.x, pos._position.y + delt.y
                z = pos._position.z + delt.z
              end
              self._world:CreateConfirmPositionProp(effectConfig, skillEffectComponent._skillID, useskillentity, x, y, z, curEntity, v.effectid, false)
            end
          end
        elseif effectConfig.effectOwner == 2 then
          local x, y, z = 0, 0, 0
          if camp == TypeComponent.CampType.Left then
            local record = self._world._battlePosList[tonumber(effectConfig.lefteffectPosId)]
            x, y, z = record.x, record.y, record.z
          else
            local record = self._world._battlePosList[tonumber(effectConfig.righteffectPosId)]
            x, y, z = record.x, record.y, record.z
          end
          self:CreateSceneEffect(sceneEffectFlyItemTypeEqual2List, x, y, z, camp, effectConfig)
        elseif effectConfig.isFollow == 0 then
          local pos = useskillentity:GetComponent(PositionComponent)
          local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(useskillentity)
          local delt = self._utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, effectConfig.socket)
          local x, y, z = 0, 0, 0
          if camp == TypeComponent.CampType.Left then
            x, y = pos._position.x + delt.x, pos._position.y + delt.y
            z = pos._position.z + delt.z
          else
            x, y = pos._position.x - delt.x, pos._position.y + delt.y
            z = pos._position.z + delt.z
          end
          self._world:CreateConfirmPositionProp(effectConfig, skillEffectComponent._skillID, useskillentity, x, y, z, curEntity, v.effectid, false)
        else
          self:CreateBuffEffect(buffEffectFlyItemTypeEqual2List, useskillentity, effectConfig)
        end
      elseif effectConfig.effectOwner == 1 then
        local hittedentity
        for _, e in ipairs(self._world._entitys) do
          if e._entityId == v.hittedEntityID then
            hittedentity = e
            break
          end
        end
        if hittedentity then
          local pos = hittedentity:GetComponent(PositionComponent)
          local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(hittedentity)
          local delt = self._utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, effectConfig.socket)
          local x, y, z = 0, 0, 0
          local hittedCamp = hittedentity:GetComponent(TypeComponent)._camp
          if hittedCamp == TypeComponent.CampType.Left then
            x, y = pos._position.x + delt.x, pos._position.y + delt.y
            z = pos._position.z + delt.z
          else
            x, y = pos._position.x - delt.x, pos._position.y + delt.y
            z = pos._position.z + delt.z
          end
          self._world:CreateConfirmPositionProp(effectConfig, skillEffectComponent._skillID, useskillentity, x, y, z, curEntity, v.effectid, false)
        end
      elseif effectConfig.effectOwner == 2 then
        local x, y, z = 0, 0, 0
        if camp == TypeComponent.CampType.Left then
          local record = self._world._battlePosList[tonumber(effectConfig.lefteffectPosId)]
          x, y, z = record.x, record.y, record.z
        else
          local record = self._world._battlePosList[tonumber(effectConfig.righteffectPosId)]
          x, y, z = record.x, record.y, record.z
        end
        self:CreateSceneEffect(sceneEffectFlyItemTypeEqual2List, x, y, z, camp, effectConfig)
      else
        self:CreateBuffEffect(buffEffectFlyItemTypeEqual2List, useskillentity, effectConfig)
      end
    elseif effectConfig.effecttime ~= 0 and skillEffectComponent._attackTime == effectConfig.fraps + skillEffectComponent._startAnimationDelayTime + effectConfig.effecttime then
      self._protocolUtility.SendDestroyBuffEffectProtocol(skillEffectComponent._useSkillEntityID, effectConfig.socket, effectConfig.effectName, self._world)
      self._protocolUtility.SendDestroyEffectByName(camp, effectConfig.effectName, self._world)
    end
  end
end

function SkillEffectSystem:SetDestroyTagSkillEntity(skillEntity, skillEffectComponent)
  local TypeComponent = BattleECS.Components.TypeComponent
  local PhysicsComponent = BattleECS.Components.PhysicsComponent
  skillEntity:GetComponent(TypeComponent)._isNeedDestroy = true
  skillEntity:GetComponent(TypeComponent)._isNeedSendProtocolDestroy = false
  local removeList = {}
  for i = #skillEffectComponent._flyEntityList, 1, -1 do
    local v = skillEffectComponent._flyEntityList[i]
    local flyentity
    for _, e in ipairs(self._world._entitys) do
      if e._entityId == v.entityId then
        flyentity = e
        break
      end
    end
    if flyentity then
      if flyentity:GetComponent(PhysicsComponent) then
        flyentity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
      end
      flyentity:GetComponent(TypeComponent)._isNeedDestroy = true
    end
    table.insert(removeList, i)
  end
  for _, i in ipairs(removeList) do
    table.remove(skillEffectComponent._flyEntityList, i)
  end
end

function SkillEffectSystem:DestroyEffectByName(effectList, camp)
  for _, v in ipairs(effectList) do
    local effectConfig = self._dataUtility.cSkillEffectTable[v.effectid]
    if effectConfig.breakOrNot == 1 then
      self._protocolUtility.SendDestroyEffectByName(camp, effectConfig.effectName, self._world)
    end
  end
end

function SkillEffectSystem:DestroyEffectByNameWithJudgeDeleteOrNor(skillEffectComponent, effectList, camp)
  for _, v in ipairs(effectList) do
    local effectConfig = self._dataUtility.cSkillEffectTable[v.effectid]
    if effectConfig.deleteOrNot == 1 then
      self._protocolUtility.SendDestroyBuffEffectProtocol(skillEffectComponent._useSkillEntityID, effectConfig.socket, effectConfig.effectName, self._world)
      self._protocolUtility.SendDestroyEffectByName(camp, effectConfig.effectName, self._world)
    end
  end
end

function SkillEffectSystem:CreateSceneEffect(sceneEffectFlyItemTypeEqual2List, x, y, z, camp, effectConfig)
  if effectConfig.flyItemType == 2 then
    if not sceneEffectFlyItemTypeEqual2List[effectConfig.id] then
      if self._utility.IsShiKongZhiMenEffect(effectConfig.id) then
        self._protocolUtility.SCreateSceneEffect(effectConfig.id, x, y, 0, camp, self._world, z)
      else
        self._protocolUtility.SCreateSceneEffect(effectConfig.id, x, y, z, camp, self._world, z)
      end
      sceneEffectFlyItemTypeEqual2List[effectConfig.id] = true
    end
  else
    if effectConfig.flyItemType == 3 then
      self._protocolUtility.SendDestroyEffectByName(camp, effectConfig.effectName, self._world)
    end
    if self._utility.IsShiKongZhiMenEffect(effectConfig.id) then
      self._protocolUtility.SCreateSceneEffect(effectConfig.id, x, y, 0, camp, self._world, z)
    else
      self._protocolUtility.SCreateSceneEffect(effectConfig.id, x, y, z, camp, self._world, z)
    end
  end
end

function SkillEffectSystem:CreateBuffEffect(buffEffectFlyItemTypeEqual2List, useskillentity, effectConfig, rad)
  if effectConfig.flyItemType == 2 then
    if not buffEffectFlyItemTypeEqual2List[effectConfig.id] then
      self._protocolUtility.SendCreateBuffEffectProtocol(useskillentity, effectConfig.socket, effectConfig.packageName, effectConfig.effectName, rad, self._world)
      buffEffectFlyItemTypeEqual2List[effectConfig.id] = true
    end
  else
    self._protocolUtility.SendCreateBuffEffectProtocol(useskillentity, effectConfig.socket, effectConfig.packageName, effectConfig.effectName, rad, self._world)
  end
end

return SkillEffectSystem
