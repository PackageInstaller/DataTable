-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/system/skilleffectsystem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = require("ecs.system")
local SkillEffectSystem = strictclass("SkillEffectSystem", System)
SkillEffectSystem.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkillEffectSystem, _ENV
  ((SkillEffectSystem.super).Ctor)(self, ...)
  self._utility = (BattleECS.Utility).Utility
  self._protocolUtility = (BattleECS.Utility).ProtocolUtility
  self._buffUtility = (BattleECS.Utility).BuffUtility
  self._physicsUtility = (BattleECS.Utility).PhysicsUtility
  self._dataUtility = (BattleECS.Utility).DataUtility
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).SkillEffectComponent)
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).TypeComponent)
end

SkillEffectSystem.Destroy = function(self)
  -- function num : 0_1 , upvalues : SkillEffectSystem
  ((SkillEffectSystem.super).Destroy)(self)
end

SkillEffectSystem.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local SkillEffectComponent = (BattleECS.Components).SkillEffectComponent
  local TypeComponent = (BattleECS.Components).TypeComponent
  local PositionComponent = (BattleECS.Components).PositionComponent
  local SkillComponent = (BattleECS.Components).SkillComponent
  local AttackComponent = (BattleECS.Components).AttackComponent
  local HpComponent = (BattleECS.Components).HpComponent
  local BuffComponent = (BattleECS.Components).BuffComponent
  local sceneEffectFlyItemTypeEqual2List = {}
  local buffEffectFlyItemTypeEqual2List = {}
  for _,entity in ipairs(self._entitys) do
    local component = entity:GetComponent(SkillEffectComponent)
    if component then
      local useskillentity = nil
      for _,e in ipairs((self._world)._entitys) do
        if e._entityId == component._useSkillEntityID then
          useskillentity = e
          break
        end
      end
      do
        if not useskillentity then
          self:SetDestroyTagSkillEntity(entity, component)
          return 
        end
        local camp = (useskillentity:GetComponent(TypeComponent))._camp
        if ((self._utility).IsRoleDead)(useskillentity) then
          self:DestroyEffectByNameWithJudgeDeleteOrNor(component, component._invalidEffectAtkList, camp)
          self:DestroyEffectByNameWithJudgeDeleteOrNor(component, component._typeMineEffectAtkList, camp)
          self:DestroyEffectByNameWithJudgeDeleteOrNor(component, component._flightPropEffectAtk, camp)
          self:DestroyEffectByNameWithJudgeDeleteOrNor(component, component._noColliderEffectList, camp)
          self:DestroyEffectByNameWithJudgeDeleteOrNor(component, component._warningEffectList, camp)
          self:SetDestroyTagSkillEntity(entity, component)
          return 
        end
        if not ((self._buffUtility).IsSkillHasInterreptBuff)(component._skillID) and ((self._buffUtility).IsRoleHasInterruptedSKillBuff)(useskillentity, component._skillID) then
          for _,v in ipairs(component._invalidEffectAtkList) do
            local effectConfig = ((self._dataUtility).cSkillEffectTable)[v.effectid]
            if effectConfig.deviationAngleOrNot == 1 then
              ((self._protocolUtility).SendDestroyBuffEffectProtocol)(component._useSkillEntityID, effectConfig.socket, effectConfig.effectName, self._world)
            end
          end
          self:DestroyEffectByName(component._invalidEffectAtkList, camp)
          self:DestroyEffectByName(component._typeMineEffectAtkList, camp)
          self:DestroyEffectByName(component._flightPropEffectAtk, camp)
          self:DestroyEffectByName(component._noColliderEffectList, camp)
          self:DestroyEffectByName(component._warningEffectList, camp)
          self:SetDestroyTagSkillEntity(entity, component)
          ;
          ((self._protocolUtility).SendSkillInterrupted)(component._useSkillEntityID, component._skillID, self._world)
          -- DECOMPILER ERROR at PC168: Confused about usage of register: R18 in 'UnsetPending'

          if (useskillentity:GetComponent(TypeComponent))._camp == (TypeComponent.CampType).Right then
            (self._world)._rightCampSkillInterruptedTime = (self._world)._rightCampSkillInterruptedTime + 1
          end
          local cskillcameramoverecord = ((self._dataUtility).cSkillCameraMoveTable)[component._skillID]
          do
            do
              if cskillcameramoverecord and cskillcameramoverecord.CameraMoveType ~= 0 then
                local MoveType = {Interrept = -2}
                ;
                ((self._protocolUtility).SendPlayBattleCameraAnimationName)(MoveType.Interrept, -1, -1, component._skillID, self._world)
              end
              component = useskillentity:GetComponent(BuffComponent)
              if component then
                component._delayBuffList = {}
              end
              do return  end
              component._attackTime = component._attackTime + 1
              -- DECOMPILER ERROR at PC215: Unhandled construct in 'MakeBoolean' P1

              if ((self._utility).IsYingXiSkill)(component._skillID) and component._attackTime == ((self._utility).GetMonsterOrRoleMagicOrAttackEndFraps)(useskillentity, component._skillID) then
                local isimaged = 0
                if (useskillentity:GetComponent(TypeComponent))._isImaged then
                  isimaged = 1
                end
                ;
                ((self._protocolUtility).SendUseSkill)(component._skillID, component._useSkillEntityID, isimaged, camp, self._world)
                local hittedEntityList = component._attackEntityList
                local record = nil
                for _,v in ipairs(hittedEntityList) do
                  record = v:GetComponent(PositionComponent)
                end
                local offset = tonumber((((self._dataUtility).cBattleConstCfgTable)[12]).attr)
                if camp == (TypeComponent.CampType).Right then
                  offset = -offset
                end
                local y = ((useskillentity:GetComponent(PositionComponent))._position).y
                ;
                (self._world):SetLeftPlayerPositionAndImaged(component._useSkillEntityID, (record._position).x - offset, y, true)
                local attackID = ((self._utility).GetEntityAttackSkillID)(useskillentity)
                if attackID then
                  for _,skillTable in ipairs((useskillentity:GetComponent(SkillComponent))._skillList) do
                    if skillTable.skillId == attackID then
                      skillTable.currentTime = (((self._dataUtility).cSkillCostTable)[attackID]).CDfraps
                      break
                    end
                  end
                end
                do
                  do
                    for _,v in ipairs(component._animationAtkList) do
                      if component._attackTime == v.loopTime then
                        local ifIgnorePriority = {No = 0, Yes = 1}
                        ;
                        ((self._protocolUtility).SendBattlerPlayAnimationByNameProtocol)(useskillentity, v.endAnimation, ifIgnorePriority.No, self._world)
                      end
                    end
                    ;
                    (entity:GetComponent(TypeComponent))._isNeedDestroy = true
                    ;
                    (entity:GetComponent(TypeComponent))._isNeedSendProtocolDestroy = false
                    do return  end
                    if component._skillID == 201034 and component._attackTime == ((self._utility).GetFrogRider201034DestroyFraps)() then
                      ((self._physicsUtility).SetEntityPhyscisComponentAwake)(useskillentity, true)
                      ;
                      ((self._physicsUtility).SetEntityAwake)((self._world)._physicsWorld, useskillentity, true)
                      ;
                      (entity:GetComponent(TypeComponent))._isNeedDestroy = true
                      ;
                      (entity:GetComponent(TypeComponent))._isNeedSendProtocolDestroy = false
                    end
                    for _,v in ipairs(component._animationAtkList) do
                      if component._attackTime == v.loopTime then
                        local ifIgnorePriority = {No = 0, Yes = 1}
                        ;
                        ((self._protocolUtility).SendBattlerPlayAnimationByNameProtocol)(useskillentity, v.endAnimation, ifIgnorePriority.No, self._world)
                      end
                    end
                    self:TraversalEffectList(component._invalidEffectAtkList, component, useskillentity, entity, camp, sceneEffectFlyItemTypeEqual2List, buffEffectFlyItemTypeEqual2List)
                    for _,v in ipairs(component._invalidEffectAtkList) do
                      local effectConfig = ((self._dataUtility).cSkillEffectTable)[v.effectid]
                      if component._attackTime == effectConfig.fraps + component._startAnimationDelayTime and ((self._utility).IsSkillHas10006Buff)(component._skillID) then
                        self:CreateBuffEffect(buffEffectFlyItemTypeEqual2List, useskillentity, effectConfig)
                      end
                      if component._attackTime == effectConfig.HitFraps + component._startAnimationDelayTime then
                        if component._skillID == 201014 or component._skillID == 201016 then
                          (entity:GetComponent(TypeComponent))._isNeedDestroy = true
                          ;
                          (entity:GetComponent(TypeComponent))._isNeedSendProtocolDestroy = false
                          for _,player in ipairs((self._world)._leftPlayerList) do
                            if not ((self._utility).IsRoleDead)(player) and (self._world):GetCampWinState() == "" then
                              ((self._buffUtility).SetBuffListToEnemyCampEntityBySkillID)(player, useskillentity, component._skillID, self._world, 0)
                            end
                          end
                        else
                          do
                            if ((self._utility).IsSkillHas10006Buff)(component._skillID) then
                              local ourlist = ((self._buffUtility).GetSKillBuffList)(component._skillID)
                              for _,v in ipairs(ourlist) do
                                ((self._buffUtility).InsertEntityDifferentBuff)({entity = useskillentity, enermyentity = useskillentity, buffid = tonumber(v.buffid), buffparamter = v.buffvalues, skillid = component._skillID, battleworld = self._world})
                              end
                              ;
                              (entity:GetComponent(TypeComponent))._isNeedDestroy = true
                              ;
                              (entity:GetComponent(TypeComponent))._isNeedSendProtocolDestroy = false
                            else
                              do
                                if ((self._utility).IsDamageReBoundSkill)(component._skillID) then
                                  local damagefrom = (useskillentity:GetComponent(HpComponent))._lastDamageFrom
                                  local damagefromEntity = nil
                                  for _,e in ipairs((self._world)._entitys) do
                                    if e._entityId == damagefrom then
                                      damagefromEntity = e
                                      break
                                    end
                                  end
                                  do
                                    if damagefromEntity then
                                      local damageFromCamp = (damagefromEntity:GetComponent(TypeComponent))._camp
                                      local useskillEntityCamp = (useskillentity:GetComponent(TypeComponent))._camp
                                      if damageFromCamp ~= useskillEntityCamp then
                                        ((self._buffUtility).SetBuffListToEnemyCampEntityBySkillID)(damagefromEntity, useskillentity, component._skillID, self._world, 0)
                                      end
                                    end
                                    do
                                      -- DECOMPILER ERROR at PC534: LeaveBlock: unexpected jumping out DO_STMT

                                      -- DECOMPILER ERROR at PC534: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                      -- DECOMPILER ERROR at PC534: LeaveBlock: unexpected jumping out IF_STMT

                                      -- DECOMPILER ERROR at PC534: LeaveBlock: unexpected jumping out DO_STMT

                                      -- DECOMPILER ERROR at PC534: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                      -- DECOMPILER ERROR at PC534: LeaveBlock: unexpected jumping out IF_STMT

                                      -- DECOMPILER ERROR at PC534: LeaveBlock: unexpected jumping out DO_STMT

                                      -- DECOMPILER ERROR at PC534: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                      -- DECOMPILER ERROR at PC534: LeaveBlock: unexpected jumping out IF_STMT

                                      -- DECOMPILER ERROR at PC534: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                      -- DECOMPILER ERROR at PC534: LeaveBlock: unexpected jumping out IF_STMT

                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                    self:TraversalEffectList(component._noColliderEffectList, component, useskillentity, entity, camp, sceneEffectFlyItemTypeEqual2List, buffEffectFlyItemTypeEqual2List)
                    for _,v in ipairs(component._noColliderEffectList) do
                      local effectConfig = ((self._dataUtility).cSkillEffectTable)[v.effectid]
                      if component._attackTime == effectConfig.HitFraps + component._startAnimationDelayTime then
                        local ourBuffEntityList = ((self._utility).GetSkillOurCampEntityList)(component._skillID, component._useSkillEntityID, self._world)
                        if ourBuffEntityList then
                          for _,v in ipairs(ourBuffEntityList) do
                            if (self._world):GetCampWinState() == "" then
                              ((self._buffUtility).SetBuffListToOwnCampEntityBySkillID)(v, useskillentity, component._skillID, self._world)
                            end
                          end
                        end
                        do
                          local hittedEntityList = ((self._utility).GetSkillEffectEntity)(component._skillID, component._useSkillEntityID, self._world)
                          if hittedEntityList then
                            for _,v in ipairs(hittedEntityList) do
                              ((self._buffUtility).SetBuffListToEnemyCampEntityBySkillID)(v, useskillentity, component._skillID, self._world, 0)
                            end
                          end
                          do
                            -- DECOMPILER ERROR at PC607: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC607: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC607: LeaveBlock: unexpected jumping out IF_STMT

                          end
                        end
                      end
                    end
                    self:TraversalEffectList(component._warningEffectList, component, useskillentity, entity, camp, sceneEffectFlyItemTypeEqual2List, buffEffectFlyItemTypeEqual2List)
                    for _,v in ipairs(component._flightPropEffectAtk) do
                      local effectConfig = ((self._dataUtility).cSkillEffectTable)[v.effectid]
                      if effectConfig.isCut == 1 then
                        if ((self._world)._actor_shiKongZhiMen_w)[camp] then
                          ((self._protocolUtility).SendSetClipRectForShiKongZhiMen)(effectConfig.id, ((self._world)._actor_shiKongZhiMen_w)[camp], ((self._world)._actor_shiKongZhiMen_h)[camp], camp, effectConfig.effectName, self._world, true)
                        else
                          -- DECOMPILER ERROR at PC658: Confused about usage of register: R24 in 'UnsetPending'

                          ;
                          ((self._world)._actor_shiKongZhiMen_effectList)[effectConfig.id] = {entityId = effectConfig.id, camp = camp, effectName = effectConfig.effectName}
                        end
                        -- DECOMPILER ERROR at PC668: Confused about usage of register: R24 in 'UnsetPending'

                        ;
                        ((self._world)._actor_shiKongZhiMenRelease_effectList)[effectConfig.id] = {entityId = effectConfig.id, camp = camp, effectName = effectConfig.effectName}
                      end
                      -- DECOMPILER ERROR at PC679: Confused about usage of register: R24 in 'UnsetPending'

                      ;
                      ((self._world)._actor_shiKongTingZhi_effectList)[effectConfig.id] = {entityId = -effectConfig.id, camp = camp, effectName = effectConfig.effectName}
                      if component._attackTime == effectConfig.fraps + component._startAnimationDelayTime then
                        if effectConfig.gAcceleration ~= 0 then
                          (self._world):CreateParaBaloSkill(component._useSkillEntityID, v.hittedEntityID, effectConfig, component._skillID)
                        else
                          ;
                          (self._world):CreateHorizontalUniformSpeedFlyingProp(effectConfig, component._skillID, component._useSkillEntityID, v.hittedEntityID, true, v.effectid)
                        end
                      else
                        if effectConfig.effecttime ~= 0 and component._attackTime == effectConfig.fraps + component._startAnimationDelayTime + effectConfig.effecttime then
                          ((self._protocolUtility).SendDestroyBuffEffectProtocol)(component._useSkillEntityID, effectConfig.socket, effectConfig.effectName, self._world)
                          ;
                          ((self._protocolUtility).SendDestroyEffectByName)(camp, effectConfig.effectName, self._world)
                        end
                      end
                    end
                    for _,v in ipairs(component._typeMineEffectAtkList) do
                      local effectConfig = ((self._dataUtility).cSkillEffectTable)[v.effectid]
                      if effectConfig.isCut == 1 then
                        if ((self._world)._actor_shiKongZhiMen_w)[camp] then
                          ((self._protocolUtility).SendSetClipRectForShiKongZhiMen)(effectConfig.id, ((self._world)._actor_shiKongZhiMen_w)[camp], ((self._world)._actor_shiKongZhiMen_h)[camp], camp, effectConfig.effectName, self._world, true)
                        else
                          -- DECOMPILER ERROR at PC773: Confused about usage of register: R24 in 'UnsetPending'

                          ;
                          ((self._world)._actor_shiKongZhiMen_effectList)[effectConfig.id] = {entityId = effectConfig.id, camp = camp, effectName = effectConfig.effectName}
                        end
                        -- DECOMPILER ERROR at PC783: Confused about usage of register: R24 in 'UnsetPending'

                        ;
                        ((self._world)._actor_shiKongZhiMenRelease_effectList)[effectConfig.id] = {entityId = effectConfig.id, camp = camp, effectName = effectConfig.effectName}
                      end
                      -- DECOMPILER ERROR at PC794: Confused about usage of register: R24 in 'UnsetPending'

                      ;
                      ((self._world)._actor_shiKongTingZhi_effectList)[effectConfig.id] = {entityId = -effectConfig.id, camp = camp, effectName = effectConfig.effectName}
                      if ((self._utility).IsSkillHas10006Buff)(component._skillID) then
                        local entitylist = ((self._utility).GetSkillOurCampEntityList)(component._skillID, component._useSkillEntityID, self._world)
                        if component._attackTime == effectConfig.fraps + component._startAnimationDelayTime then
                          for _,player in ipairs(entitylist) do
                            if effectConfig.effectOwner == 0 then
                              local pos = useskillentity:GetComponent(PositionComponent)
                              local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(useskillentity)
                              local delt = ((self._utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, effectConfig.socket)
                              local y = (pos._targetPos).y + delt.y
                              local x = (pos._targetPos).x + delt.x
                              local z = (pos._position).z + delt.z
                              ;
                              (self._world):CreateConfirmPositionProp(effectConfig, component._skillID, useskillentity, x, y, z, entity, v.effectid, false)
                            else
                              do
                                if effectConfig.effectOwner == 1 then
                                  local pos = player:GetComponent(PositionComponent)
                                  local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(player)
                                  local delt = ((self._utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, effectConfig.socket)
                                  local y = (pos._targetPos).y + delt.y
                                  local x = (pos._targetPos).x + delt.x
                                  local z = (pos._position).z + delt.z
                                  ;
                                  (self._world):CreateConfirmPositionProp(effectConfig, component._skillID, useskillentity, x, y, z, entity, v.effectid, false)
                                end
                                do
                                  -- DECOMPILER ERROR at PC900: LeaveBlock: unexpected jumping out DO_STMT

                                  -- DECOMPILER ERROR at PC900: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                  -- DECOMPILER ERROR at PC900: LeaveBlock: unexpected jumping out IF_STMT

                                end
                              end
                            end
                          end
                        else
                          if effectConfig.effecttime ~= 0 and component._attackTime == effectConfig.fraps + component._startAnimationDelayTime + effectConfig.effecttime then
                            ((self._protocolUtility).SendDestroyBuffEffectProtocol)(component._useSkillEntityID, effectConfig.socket, effectConfig.effectName, self._world)
                            ;
                            ((self._protocolUtility).SendDestroyEffectByName)(camp, effectConfig.effectName, self._world)
                          end
                        end
                        if component._attackTime == effectConfig.HitFraps + component._startAnimationDelayTime and (self._world):GetCampWinState() == "" then
                          local haveHit = false
                          for _,player in ipairs(entitylist) do
                            local ourlist = ((self._buffUtility).GetSKillBuffList)(component._skillID)
                            for _,v in ipairs(ourlist) do
                              if tonumber(v.buffid) == 10006 then
                                haveHit = true
                              end
                              ;
                              ((self._buffUtility).InsertEntityDifferentBuff)({entity = player, enermyentity = useskillentity, buffid = tonumber(v.buffid), buffparamter = v.buffvalues, skillid = component._skillID, battleworld = self._world})
                            end
                            ;
                            (self._world):RevivePlayer(player._entityId)
                          end
                          if haveHit then
                            component._typeMineEffectAtkEffectTime = component._typeMineEffectAtkEffectTime + 1
                          end
                        end
                      else
                        do
                          if component._skillID == 201015 and component._attackTime == ((self._utility).GetMonsterOrRoleMagicOrAttackEndFraps)(useskillentity, component._skillID) and ((self._buffUtility).IsHasCurrentBuff)(useskillentity, 20014) then
                            ((self._buffUtility).SetEntityBuffEffectState)(useskillentity, 20014, true)
                            local ifIgnorePriority = {No = 0, Yes = 1}
                            ;
                            ((self._protocolUtility).SendBattlerPlayAnimationByNameProtocol)(useskillentity, "Stop", ifIgnorePriority.No, self._world)
                            ;
                            ((self._protocolUtility).SendSkillStart)(201013, self._world)
                          end
                          do
                            if component._attackTime == effectConfig.fraps + component._startAnimationDelayTime then
                              local hittedEntity = nil
                              for _,e in ipairs((self._world)._entitys) do
                                if e._entityId == v.hittedEntityID then
                                  hittedEntity = e
                                  break
                                end
                              end
                              do
                                if hittedEntity then
                                  if ((self._utility).IsLiuGuangZhan)(component._skillID) and ((self._utility).IsRoleDead)(hittedEntity) then
                                    hittedEntity = (((self._utility).GetSkillEffectEntity)(component._skillID, component._useSkillEntityID, self._world))[1]
                                  end
                                  if effectConfig.effectOwner == 0 then
                                    local pos = useskillentity:GetComponent(PositionComponent)
                                    local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(useskillentity)
                                    local delt = ((self._utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, effectConfig.socket)
                                    local x, y, z = 0, 0, 0
                                    if camp == (TypeComponent.CampType).Left then
                                      if ((self._utility).IsShiBuKeDang)(component._skillID) then
                                        x = (pos._position).x + delt.x
                                      else
                                        -- DECOMPILER ERROR at PC1114: Overwrote pending register: R29 in 'AssignReg'

                                        x = (pos._position).x + delt.x
                                      end
                                      z = (pos._position).z + delt.z
                                    else
                                      -- DECOMPILER ERROR at PC1128: Overwrote pending register: R29 in 'AssignReg'

                                      x = (pos._position).x - delt.x
                                      z = (pos._position).z + delt.z
                                    end
                                    if component._skillID == 201046 then
                                      x = x + component._randomDeltXOffect
                                      local XOffect = (string.split)((((self._dataUtility).cBattleConstCfgTable)[58]).attr, ";")
                                      component._randomDeltXOffect = component._randomDeltXOffect + (fixedpoint(XOffect[1]) - ((self._world)._randomPcg)(1, 1000) * (fixedpoint(XOffect[2]) - fixedpoint(XOffect[1])) / 1000)
                                    end
                                    do
                                      do
                                        ;
                                        (self._world):CreateConfirmPositionProp(effectConfig, component._skillID, useskillentity, x, y, z, entity, v.effectid, true)
                                        if effectConfig.effectOwner == 1 then
                                          if ((self._utility).IsSkillTypeEffectNeedDiffTarget)(component._skillID) then
                                            hittedEntity = (((self._utility).GetSkillEffectEntity)(component._skillID, component._useSkillEntityID, self._world))[1]
                                          end
                                          if hittedEntity then
                                            local pos = hittedEntity:GetComponent(PositionComponent)
                                            local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(hittedEntity)
                                            -- DECOMPILER ERROR at PC1211: Overwrote pending register: R29 in 'AssignReg'

                                            local delt = ((self._utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, y)
                                            local x, y, z = 0, 0, 0
                                            local hittedCamp = (hittedEntity:GetComponent(TypeComponent))._camp
                                            if hittedCamp == (TypeComponent.CampType).Left then
                                              x = (pos._position).x + delt.x
                                              z = (pos._position).z + delt.z
                                            else
                                              -- DECOMPILER ERROR at PC1245: Overwrote pending register: R29 in 'AssignReg'

                                              x = (pos._position).x - delt.x
                                              z = (pos._position).z + delt.z
                                            end
                                            ;
                                            (self._world):CreateConfirmPositionProp(effectConfig, component._skillID, useskillentity, x, y, z, entity, v.effectid, true)
                                          else
                                            do
                                              for _,v in ipairs(component._animationAtkList) do
                                                local ifIgnorePriority = {No = 0, Yes = 1}
                                                ;
                                                ((self._protocolUtility).SendBattlerPlayAnimationByNameProtocol)(useskillentity, v.endAnimation, ifIgnorePriority.No, self._world)
                                              end
                                              self:SetDestroyTagSkillEntity(entity, component)
                                              if effectConfig.effectOwner == 2 then
                                                local x, y, z = 0, 0, 0
                                                if camp == (TypeComponent.CampType).Left then
                                                  local record = ((self._world)._battlePosList)[tonumber(effectConfig.lefteffectPosId)]
                                                  if record then
                                                    x = record.x
                                                  else
                                                    LogErrorFormat("SkillEffectSystem", "id %s lefteffectPosId %s", effectConfig.id, effectConfig.lefteffectPosId)
                                                  end
                                                else
                                                  do
                                                    do
                                                      do
                                                        local record = ((self._world)._battlePosList)[tonumber(effectConfig.righteffectPosId)]
                                                        -- DECOMPILER ERROR at PC1326: Overwrote pending register: R27 in 'AssignReg'

                                                        -- DECOMPILER ERROR at PC1327: Overwrote pending register: R26 in 'AssignReg'

                                                        if record then
                                                          x = record.x
                                                        else
                                                          LogErrorFormat("SkillEffectSystem", "id %s righteffectPosId %s", effectConfig.id, effectConfig.righteffectPosId)
                                                        end
                                                        ;
                                                        (self._world):CreateConfirmPositionProp(effectConfig, component._skillID, useskillentity, x, y, z, entity, v.effectid, true)
                                                        -- DECOMPILER ERROR at PC1354: Overwrote pending register: R26 in 'AssignReg'

                                                        -- DECOMPILER ERROR at PC1364: Overwrote pending register: R27 in 'AssignReg'

                                                        if effectConfig.effecttime ~= 0 and component._attackTime == effectConfig.fraps + y + effectConfig.effecttime then
                                                          ((self._protocolUtility).SendDestroyBuffEffectProtocol)(component._useSkillEntityID, effectConfig.socket, z, self._world)
                                                          ;
                                                          ((self._protocolUtility).SendDestroyEffectByName)(camp, effectConfig.effectName, self._world)
                                                        end
                                                        do
                                                          if component._attackTime == effectConfig.HitFraps + component._startAnimationDelayTime then
                                                            local haveHit = false
                                                            for i,v in ipairs(component._flyEntityList) do
                                                              if v.hitFraps == effectConfig.HitFraps then
                                                                local flyentity = nil
                                                                for _,e in ipairs((self._world)._entitys) do
                                                                  if e._entityId == v.entityId then
                                                                    flyentity = e
                                                                    break
                                                                  end
                                                                end
                                                                do
                                                                  if flyentity then
                                                                    haveHit = true
                                                                    -- DECOMPILER ERROR at PC1407: Confused about usage of register: R31 in 'UnsetPending'

                                                                    ;
                                                                    ((component._flyEntityList)[i]).hitFraps = -1
                                                                    local pos = flyentity:GetComponent(PositionComponent)
                                                                    local x, y = (pos._position).x, (pos._position).y
                                                                    ;
                                                                    (self._world):AddBoxBodyToEntity(effectConfig, component._skillID, useskillentity, x, y, v.entityId)
                                                                  end
                                                                  do
                                                                    -- DECOMPILER ERROR at PC1424: LeaveBlock: unexpected jumping out DO_STMT

                                                                    -- DECOMPILER ERROR at PC1424: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                    -- DECOMPILER ERROR at PC1424: LeaveBlock: unexpected jumping out IF_STMT

                                                                  end
                                                                end
                                                              end
                                                            end
                                                            if haveHit then
                                                              component._typeMineEffectAtkEffectTime = component._typeMineEffectAtkEffectTime + 1
                                                            end
                                                          end
                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out DO_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out DO_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out DO_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out DO_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out DO_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out DO_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out DO_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out DO_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out DO_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                          -- DECOMPILER ERROR at PC1431: LeaveBlock: unexpected jumping out IF_STMT

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
                    if component._attackTime == component._flyNeedDestroyMaxFrap then
                      if component._skillID ~= 201034 then
                        (entity:GetComponent(TypeComponent))._isNeedDestroy = true
                        ;
                        (entity:GetComponent(TypeComponent))._isNeedSendProtocolDestroy = false
                      else
                        local isJoin, data = ((self._utility).IsJoinBattleAndEnoughCondition)((self._world)._battleID)
                        if data.chatId ~= 0 then
                          local BattlePauseType = (BattleClientProtocolManager.GetBeanDef)("data.battlepausetype")
                          local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sbattlepause")
                          protocol.pauseType = BattlePauseType.NpcChat
                          protocol.param = tostring(data.chatId)
                          ;
                          (self._world):InsertViewProtocolData(protocol)
                        end
                      end
                    end
                    do
                      -- DECOMPILER ERROR at PC1475: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC1475: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC1475: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC1475: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC1475: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC1475: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC1475: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC1475: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC1475: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC1475: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC1475: LeaveBlock: unexpected jumping out IF_STMT

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

SkillEffectSystem.TraversalEffectList = function(self, effectList, skillEffectComponent, useskillentity, curEntity, camp, sceneEffectFlyItemTypeEqual2List, buffEffectFlyItemTypeEqual2List)
  -- function num : 0_3 , upvalues : _ENV
  local TypeComponent = (BattleECS.Components).TypeComponent
  local PositionComponent = (BattleECS.Components).PositionComponent
  for _,v in ipairs(effectList) do
    local effectConfig = ((self._dataUtility).cSkillEffectTable)[v.effectid]
    if effectConfig.isCut == 1 then
      if ((self._world)._actor_shiKongZhiMen_w)[camp] then
        ((self._protocolUtility).SendSetClipRectForShiKongZhiMen)(effectConfig.id, ((self._world)._actor_shiKongZhiMen_w)[camp], ((self._world)._actor_shiKongZhiMen_h)[camp], camp, effectConfig.effectName, self._world, true)
      else
        -- DECOMPILER ERROR at PC46: Confused about usage of register: R16 in 'UnsetPending'

        ;
        ((self._world)._actor_shiKongZhiMen_effectList)[effectConfig.id] = {entityId = effectConfig.id, camp = camp, effectName = effectConfig.effectName}
      end
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R16 in 'UnsetPending'

      ;
      ((self._world)._actor_shiKongZhiMenRelease_effectList)[effectConfig.id] = {entityId = effectConfig.id, camp = camp, effectName = effectConfig.effectName}
    end
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R16 in 'UnsetPending'

    ;
    ((self._world)._actor_shiKongTingZhi_effectList)[effectConfig.id] = {entityId = -effectConfig.id, camp = camp, effectName = effectConfig.effectName}
    if skillEffectComponent._attackTime == effectConfig.fraps + skillEffectComponent._startAnimationDelayTime then
      if effectConfig.deviationAngleOrNot == 1 then
        local hittedentity = nil
        for _,e in ipairs((self._world)._entitys) do
          if e._entityId == v.hittedEntityID then
            hittedentity = e
            break
          end
        end
        do
          do
            if hittedentity then
              local rad, sin, deg = ((self._utility).ReturnEffectRad)(useskillentity, hittedentity, effectConfig.socket)
              self:CreateBuffEffect(buffEffectFlyItemTypeEqual2List, useskillentity, effectConfig, deg)
            end
            if effectConfig.deleteOrNot == 1 then
              if effectConfig.effectOwner == 1 then
                local hittedentity = nil
                for _,e in ipairs((self._world)._entitys) do
                  if e._entityId == v.hittedEntityID then
                    hittedentity = e
                    break
                  end
                end
                do
                  if hittedentity then
                    if skillEffectComponent._warningEffectList == effectList then
                      self:CreateBuffEffect(buffEffectFlyItemTypeEqual2List, hittedentity, effectConfig)
                    else
                      local pos = hittedentity:GetComponent(PositionComponent)
                      local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(hittedentity)
                      local delt = ((self._utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, effectConfig.socket)
                      local x, y, z = 0, 0, 0
                      local hittedCamp = (hittedentity:GetComponent(TypeComponent))._camp
                      if hittedCamp == (TypeComponent.CampType).Left then
                        x = (pos._position).x + delt.x
                        z = (pos._position).z + delt.z
                      else
                        -- DECOMPILER ERROR at PC183: Overwrote pending register: R21 in 'AssignReg'

                        x = (pos._position).x - delt.x
                        z = (pos._position).z + delt.z
                      end
                      ;
                      (self._world):CreateConfirmPositionProp(effectConfig, skillEffectComponent._skillID, useskillentity, x, y, z, curEntity, v.effectid, false)
                    end
                  end
                  do
                    if effectConfig.effectOwner == 2 then
                      local x, y, z = 0, 0, 0
                      -- DECOMPILER ERROR at PC215: Overwrote pending register: R21 in 'AssignReg'

                      if camp == (TypeComponent.CampType).Left then
                        local record = ((self._world)._battlePosList)[tonumber(y)]
                        x = record.x
                      else
                        do
                          do
                            do
                              local record = ((self._world)._battlePosList)[tonumber(effectConfig.righteffectPosId)]
                              -- DECOMPILER ERROR at PC232: Overwrote pending register: R18 in 'AssignReg'

                              -- DECOMPILER ERROR at PC233: Overwrote pending register: R17 in 'AssignReg'

                              x = record.x
                              self:CreateSceneEffect(sceneEffectFlyItemTypeEqual2List, x, y, z, camp, effectConfig)
                              -- DECOMPILER ERROR at PC247: Overwrote pending register: R17 in 'AssignReg'

                              -- DECOMPILER ERROR at PC248: Overwrote pending register: R18 in 'AssignReg'

                              if effectConfig.isFollow == 0 then
                                local pos = useskillentity:GetComponent(z)
                                local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(useskillentity)
                                local delt = ((self._utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, effectConfig.socket)
                                local x, y, z = 0, 0, 0
                                if camp == (TypeComponent.CampType).Left then
                                  x = (pos._position).x + delt.x
                                  z = (pos._position).z + delt.z
                                else
                                  -- DECOMPILER ERROR at PC289: Overwrote pending register: R20 in 'AssignReg'

                                  x = (pos._position).x - delt.x
                                  z = (pos._position).z + delt.z
                                end
                                ;
                                (self._world):CreateConfirmPositionProp(effectConfig, skillEffectComponent._skillID, useskillentity, x, y, z, curEntity, v.effectid, false)
                              else
                                do
                                  -- DECOMPILER ERROR at PC311: Overwrote pending register: R20 in 'AssignReg'

                                  self:CreateBuffEffect(buffEffectFlyItemTypeEqual2List, useskillentity, y)
                                  if effectConfig.effectOwner == 1 then
                                    local hittedentity = nil
                                    for _,e in ipairs((self._world)._entitys) do
                                      if e._entityId == v.hittedEntityID then
                                        hittedentity = e
                                        break
                                      end
                                    end
                                    do
                                      if hittedentity then
                                        local pos = hittedentity:GetComponent(PositionComponent)
                                        local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(hittedentity)
                                        local delt = ((self._utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, effectConfig.socket)
                                        local x, y, z = 0, 0, 0
                                        local hittedCamp = (hittedentity:GetComponent(TypeComponent))._camp
                                        if hittedCamp == (TypeComponent.CampType).Left then
                                          x = (pos._position).x + delt.x
                                          z = (pos._position).z + delt.z
                                        else
                                          -- DECOMPILER ERROR at PC379: Overwrote pending register: R21 in 'AssignReg'

                                          x = (pos._position).x - delt.x
                                          z = (pos._position).z + delt.z
                                        end
                                        ;
                                        (self._world):CreateConfirmPositionProp(effectConfig, skillEffectComponent._skillID, useskillentity, x, y, z, curEntity, v.effectid, false)
                                      end
                                      do
                                        if effectConfig.effectOwner == 2 then
                                          local x, y, z = 0, 0, 0
                                          -- DECOMPILER ERROR at PC411: Overwrote pending register: R21 in 'AssignReg'

                                          if camp == (TypeComponent.CampType).Left then
                                            local record = ((self._world)._battlePosList)[tonumber(y)]
                                            x = record.x
                                          else
                                            do
                                              do
                                                do
                                                  do
                                                    local record = ((self._world)._battlePosList)[tonumber(effectConfig.righteffectPosId)]
                                                    -- DECOMPILER ERROR at PC428: Overwrote pending register: R18 in 'AssignReg'

                                                    -- DECOMPILER ERROR at PC429: Overwrote pending register: R17 in 'AssignReg'

                                                    x = record.x
                                                    self:CreateSceneEffect(sceneEffectFlyItemTypeEqual2List, x, y, z, camp, effectConfig)
                                                    -- DECOMPILER ERROR at PC440: Overwrote pending register: R17 in 'AssignReg'

                                                    -- DECOMPILER ERROR at PC441: Overwrote pending register: R18 in 'AssignReg'

                                                    self:CreateBuffEffect(z, useskillentity, effectConfig)
                                                    if effectConfig.effecttime ~= 0 and skillEffectComponent._attackTime == effectConfig.fraps + skillEffectComponent._startAnimationDelayTime + effectConfig.effecttime then
                                                      ((self._protocolUtility).SendDestroyBuffEffectProtocol)(skillEffectComponent._useSkillEntityID, effectConfig.socket, effectConfig.effectName, self._world)
                                                      ;
                                                      ((self._protocolUtility).SendDestroyEffectByName)(camp, effectConfig.effectName, self._world)
                                                    end
                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out DO_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                    -- DECOMPILER ERROR at PC470: LeaveBlock: unexpected jumping out IF_STMT

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

SkillEffectSystem.SetDestroyTagSkillEntity = function(self, skillEntity, skillEffectComponent)
  -- function num : 0_4 , upvalues : _ENV
  local TypeComponent = (BattleECS.Components).TypeComponent
  local PhysicsComponent = (BattleECS.Components).PhysicsComponent
  ;
  (skillEntity:GetComponent(TypeComponent))._isNeedDestroy = true
  ;
  (skillEntity:GetComponent(TypeComponent))._isNeedSendProtocolDestroy = false
  local removeList = {}
  for i = #skillEffectComponent._flyEntityList, 1, -1 do
    local v = (skillEffectComponent._flyEntityList)[i]
    local flyentity = nil
    for _,e in ipairs((self._world)._entitys) do
      if e._entityId == v.entityId then
        flyentity = e
        break
      end
    end
    do
      do
        if flyentity then
          if flyentity:GetComponent(PhysicsComponent) then
            (flyentity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
          end
          ;
          (flyentity:GetComponent(TypeComponent))._isNeedDestroy = true
        end
        ;
        (table.insert)(removeList, i)
        -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  for _,i in ipairs(removeList) do
    (table.remove)(skillEffectComponent._flyEntityList, i)
  end
end

SkillEffectSystem.DestroyEffectByName = function(self, effectList, camp)
  -- function num : 0_5 , upvalues : _ENV
  for _,v in ipairs(effectList) do
    local effectConfig = ((self._dataUtility).cSkillEffectTable)[v.effectid]
    if effectConfig.breakOrNot == 1 then
      ((self._protocolUtility).SendDestroyEffectByName)(camp, effectConfig.effectName, self._world)
    end
  end
end

SkillEffectSystem.DestroyEffectByNameWithJudgeDeleteOrNor = function(self, skillEffectComponent, effectList, camp)
  -- function num : 0_6 , upvalues : _ENV
  for _,v in ipairs(effectList) do
    local effectConfig = ((self._dataUtility).cSkillEffectTable)[v.effectid]
    if effectConfig.deleteOrNot == 1 then
      ((self._protocolUtility).SendDestroyBuffEffectProtocol)(skillEffectComponent._useSkillEntityID, effectConfig.socket, effectConfig.effectName, self._world)
      ;
      ((self._protocolUtility).SendDestroyEffectByName)(camp, effectConfig.effectName, self._world)
    end
  end
end

SkillEffectSystem.CreateSceneEffect = function(self, sceneEffectFlyItemTypeEqual2List, x, y, z, camp, effectConfig)
  -- function num : 0_7
  if effectConfig.flyItemType == 2 and not sceneEffectFlyItemTypeEqual2List[effectConfig.id] then
    if ((self._utility).IsShiKongZhiMenEffect)(effectConfig.id) then
      ((self._protocolUtility).SCreateSceneEffect)(effectConfig.id, x, y, 0, camp, self._world, z)
    else
      ;
      ((self._protocolUtility).SCreateSceneEffect)(effectConfig.id, x, y, z, camp, self._world, z)
    end
    sceneEffectFlyItemTypeEqual2List[effectConfig.id] = true
  end
  if effectConfig.flyItemType == 3 then
    ((self._protocolUtility).SendDestroyEffectByName)(camp, effectConfig.effectName, self._world)
  end
  if ((self._utility).IsShiKongZhiMenEffect)(effectConfig.id) then
    ((self._protocolUtility).SCreateSceneEffect)(effectConfig.id, x, y, 0, camp, self._world, z)
  else
    ;
    ((self._protocolUtility).SCreateSceneEffect)(effectConfig.id, x, y, z, camp, self._world, z)
  end
end

SkillEffectSystem.CreateBuffEffect = function(self, buffEffectFlyItemTypeEqual2List, useskillentity, effectConfig, rad)
  -- function num : 0_8
  if effectConfig.flyItemType == 2 and not buffEffectFlyItemTypeEqual2List[effectConfig.id] then
    ((self._protocolUtility).SendCreateBuffEffectProtocol)(useskillentity, effectConfig.socket, effectConfig.packageName, effectConfig.effectName, rad, self._world)
    buffEffectFlyItemTypeEqual2List[effectConfig.id] = true
  end
  ;
  ((self._protocolUtility).SendCreateBuffEffectProtocol)(useskillentity, effectConfig.socket, effectConfig.packageName, effectConfig.effectName, rad, self._world)
end

return SkillEffectSystem

