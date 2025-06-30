-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/battleworld.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local World = require("ecs.world")
require("box2d")
;
(((BattleECS.Utility).DataUtility).InitConfigTable)()
;
(((BattleECS.Utility).DataUtility).InitSplitCSkillBuffValue)()
;
(((BattleECS.Utility).DataUtility).InitCSkillFormulaCfgBattleFormula)()
;
(((BattleECS.Utility).DataUtility).InitCSkillBattleFormula)()
;
(((BattleECS.Utility).DataUtility).InitCSkillRateCfgFormula)()
;
(((BattleECS.Utility).DataUtility).InitCSkillCostCfgFormula)()
;
(((BattleECS.Utility).DataUtility).InitCSkillbehavior)()
;
(((BattleECS.Utility).DataUtility).InitCGlobalBuffBattleFormula)()
;
(((BattleECS.Utility).DataUtility).InitPowerNumType)()
local BattleEndType = (BattleClientProtocolManager.GetBeanDef)("data.battleendtype")
local BattleWorld = strictclass("BattleWorld", World)
BattleWorld.PowerAccumulateStateType = {Filling = 1, Full = 2, BreakOut = 3, Drain = 4}
BattleWorld.Ctor = function(self, fun, battleId, sceneid, battleBuffs, battlePosList)
  -- function num : 0_0 , upvalues : BattleWorld, _ENV
  ((BattleWorld.super).Ctor)(self)
  self._battleID = battleId
  self._sceneID = sceneid
  self._insertData = fun
  self._battleBuffsList = {}
  for _,v in ipairs(battleBuffs) do
    LogInfoFormat("BattleWorld", "battleBuffs buffid %s num %s", v.id, v.num)
    ;
    (table.insert)(self._battleBuffsList, {buffId = v.id, count = v.num})
    if not (((BattleECS.Utility).DataUtility).cGlobalBuffConfigTable)[v.id] then
      LogErrorFormat("BattleWorld", "buffid %s is not in cgloballbuffconfig", v.id)
    end
  end
  self._battlePosList = battlePosList
  LogInfoFormat("BattleWorld", "battleid:%s sceneid:%s", self._battleID, self._sceneID)
  self._redPower = fixedpoint_zero
  self._bluePower = fixedpoint_zero
  self._redPowerMax = fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[8]).attr) * fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[1]).attr)
  self._bluePowerMax = fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[9]).attr) * fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[2]).attr)
  self._powerBreakOutIncreateSpeed = false
  self._powerAccumulateState = (self.PowerAccumulateStateType).Filling
  self._accumulatePower = 0
  self._accumulatePowerMax = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[93]).attr)
  self._worldState = "init"
  self._leftPlayerList = {}
  self._leftPlayerPartnerList = {}
  self._leftPlayerSummonList = {}
  self._rightPlayerList = {}
  self._rightPlayerSummonList = {}
  self._playerSkillEffectEntityList = {}
  self._otherPhysicsEntityList = {}
  self._shape20030FlyBallSet = {}
  self._isStopBattleWorldTimeCount = 0
  self._stopBattleWorldTimeCountTotalLeft = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[61]).attr)
  self._stopBattleWorldTimeCountTotalRight = 0
  self._campWinState = ""
  self._battleWorldStartFrames = 0
  self._battleWorldPowerIncreaseSpeed = {}
  self._leftPlayerPowerIncreaseSpeedList = {}
  self._breakOutPowerCountFrame = 0
  self._drainPowerCountFrame = 0
  self._isJoin = false
  self._partnerJoinCount = 0
  self._partnerBattlerData = {}
  self._isMonsterAllDeadDisapper = false
  self._isAllMonsterStateCanBeBattleEnd = false
  self._guardBuffLeftEntityid = 0
  self._guardBuffRightEntityid = 0
  self._guardBuffLeftEntityidPool = {}
  self._guardBuffRightEntityidPool = {}
  self._bossHpStage = {}
  self._bossEntityid = 0
  self._randomSeed = 0
  self._randomPcg = nil
  self._lastDamageRoleId = 0
  self._rightCampSkillInterruptedTime = 0
  self._actor_shiKongZhiMen_effectList = {}
  self._actor_shiKongZhiMenRelease_effectList = {}
  self._actor_shiKongTingZhi_effectList = {}
  self._actor_shiKongZhiMen_entityId = {}
  self._actor_shiKongZhiMen_w = {}
  self._actor_shiKongZhiMen_h = {}
  self._isLeftGMInvincible = false
  self._isRightGMInvincible = false
  self._leftLineupInfo = {}
  self:Init()
end

BattleWorld.Destroy = function(self)
  -- function num : 0_1 , upvalues : BattleWorld, _ENV
  ((BattleWorld.super).Destroy)(self)
  ;
  (box2d.deleteWorld)(self._physicsWorld)
end

BattleWorld.DestroyPhysicsBody = function(self, id)
  -- function num : 0_2 , upvalues : _ENV
  (box2d.deleteBody)(self._physicsWorld, id)
end

BattleWorld.RemoveOtherPhysicsEntityList = function(self, entityid)
  -- function num : 0_3 , upvalues : _ENV
  local removeList = {}
  for k = #self._otherPhysicsEntityList, 1, -1 do
    local entity = (self._otherPhysicsEntityList)[k]
    if entityid == entity._entityId then
      (table.insert)(removeList, k)
    end
  end
  for _,i in ipairs(removeList) do
    (table.remove)(self._otherPhysicsEntityList, i)
  end
end

BattleWorld.Init = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:CreatePhysicsWorld()
  self:AddSystem((BattleECS.Systems).BehaviorSystem)
  self:AddSystem((BattleECS.Systems).PhysicsSystem)
  self:AddSystem((BattleECS.Systems).AnimationSystem)
  self:AddSystem((BattleECS.Systems).SkillSystem)
  self:AddSystem((BattleECS.Systems).HpSystem)
  self:AddSystem((BattleECS.Systems).ReleaseSystem)
  self:AddSystem((BattleECS.Systems).SkillEffectSystem)
  self:AddSystem((BattleECS.Systems).ViewMoveSystem)
  self:AddSystem((BattleECS.Systems).SpritePhysicsSystem)
  self:AddSystem((BattleECS.Systems).BuffSystem)
  self:AddSystem((BattleECS.Systems).AnimationEventSystem)
  self:AddSystem((BattleECS.Systems).RoleDeadCountSystem)
  self:AddSystem((BattleECS.Systems).DeadDisappearCountSystem)
  self:AddSystem((BattleECS.Systems).FlySkillDataSystem)
  self:AddSystem((BattleECS.Systems).CreateRoleSystem)
  self:InitCreateUtilityEntity()
end

BattleWorld.InitCreateUtilityEntity = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self._createUtilityEntity = self:NewEntity()
  ;
  (self._createUtilityEntity):AddComponent((BattleECS.Components).CreateRoleComponent)
end

BattleWorld.SetIsMonsterAllDeadDisapper = function(self, flag)
  -- function num : 0_6
  self._isMonsterAllDeadDisapper = flag
end

BattleWorld.SetIsAllMonsterStateCanBeBattleEnd = function(self, flag)
  -- function num : 0_7
  self._isAllMonsterStateCanBeBattleEnd = flag
end

BattleWorld.SetGuardBuffEntityid = function(self, camp, id, isRemove)
  -- function num : 0_8 , upvalues : _ENV
  if not isRemove then
    if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
      (table.insert)(self._guardBuffLeftEntityidPool, id)
      self._guardBuffLeftEntityid = id
    else
      if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
        (table.insert)(self._guardBuffRightEntityidPool, id)
        self._guardBuffRightEntityid = id
      end
    end
  else
    if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
      local index = (table.indexof)(self._guardBuffLeftEntityidPool, id)
      if not index then
        LogErrorFormat("BattleWorld", "GuardBuffLeftEntityidGroup Not Exist %s", id)
      else
        ;
        (table.remove)(self._guardBuffLeftEntityidPool, index)
        if #self._guardBuffLeftEntityidPool > 0 then
          self._guardBuffLeftEntityid = (self._guardBuffLeftEntityidPool)[#self._guardBuffLeftEntityidPool]
        else
          self._guardBuffLeftEntityid = 0
        end
      end
    else
      do
        if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
          local index = (table.indexof)(self._guardBuffRightEntityidPool, id)
          if not index then
            LogErrorFormat("BattleWorld", "GuardBuffRightEntityidGroup Not Exist %s", id)
          else
            ;
            (table.remove)(self._guardBuffRightEntityidPool, index)
            if #self._guardBuffRightEntityidPool > 0 then
              self._guardBuffRightEntityid = (self._guardBuffRightEntityidPool)[#self._guardBuffRightEntityidPool]
            else
              self._guardBuffRightEntityid = 0
            end
          end
        end
      end
    end
  end
end

BattleWorld.SetAssistData = function(self, data)
  -- function num : 0_9
  self._partnerBattlerData = data
end

BattleWorld.SetRandomSeed = function(self, seed)
  -- function num : 0_10 , upvalues : _ENV
  self._randomSeed = seed
  LogInfoFormat("BattleWorld", "randomseed:%s", self._randomSeed)
  self._randomPcg = (pcg.create)(self._randomSeed)
end

BattleWorld.AddBattleCount = function(self)
  -- function num : 0_11
  self._isStopBattleWorldTimeCount = self._isStopBattleWorldTimeCount + 1
end

BattleWorld.SetIsJoin = function(self, state)
  -- function num : 0_12
  self._isJoin = state
end

BattleWorld.SetIsLeftGMInvincible = function(self, flag)
  -- function num : 0_13
  self._isLeftGMInvincible = flag
end

BattleWorld.SetIsRightGMInvincible = function(self, flag)
  -- function num : 0_14
  self._isRightGMInvincible = flag
end

BattleWorld.GetIsLeftGMInvincible = function(self)
  -- function num : 0_15
  return self._isLeftGMInvincible
end

BattleWorld.GetIsRightGMInvincible = function(self)
  -- function num : 0_16
  return self._isRightGMInvincible
end

BattleWorld.FullEnergyPower = function(self)
  -- function num : 0_17
  self._accumulatePower = self._accumulatePowerMax
end

BattleWorld.SetRightCampSkillInterruptedTime = function(self, num)
  -- function num : 0_18
  self._rightCampSkillInterruptedTime = num
end

BattleWorld.GetRightCampSkillInterruptedTime = function(self)
  -- function num : 0_19
  return self._rightCampSkillInterruptedTime
end

BattleWorld.AddRedPower = function(self, num)
  -- function num : 0_20 , upvalues : _ENV
  self._redPower = self._redPower + num * fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[1]).attr)
  self._redPower = (fixedpoint.min)(self._redPower, self._redPowerMax)
  self._redPower = (fixedpoint.max)(self._redPower, 0)
end

BattleWorld.AddBluePower = function(self, num)
  -- function num : 0_21 , upvalues : _ENV
  self._bluePower = self._bluePower + num * fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[2]).attr)
  self._bluePower = (fixedpoint.min)(self._bluePower, self._bluePowerMax)
  self._bluePower = (fixedpoint.max)(self._bluePower, 0)
end

BattleWorld.GetBattleCount = function(self)
  -- function num : 0_22
  return self._isStopBattleWorldTimeCount
end

BattleWorld.SetCampWinState = function(self, winCamp)
  -- function num : 0_23
  self._campWinState = winCamp
end

BattleWorld.GetCampWinState = function(self)
  -- function num : 0_24
  return self._campWinState
end

BattleWorld.SetWorldState = function(self, str)
  -- function num : 0_25
  self._worldState = str
end

BattleWorld.GetWorldState = function(self)
  -- function num : 0_26
  return self._worldState
end

BattleWorld.SetLeftLineupInfo = function(self, list)
  -- function num : 0_27
  self._leftLineupInfo = list
end

BattleWorld.GetElementNumFromLeftLine = function(self, elementType)
  -- function num : 0_28 , upvalues : _ENV
  if not (self._leftLineupInfo).element then
    LogError("BattleWorld", "leftLineupInfo.element is nil")
    return 0
  end
  local result = ((self._leftLineupInfo).element)[4] or 0
  do
    if not ((self._leftLineupInfo).element)[elementType] then
      local addnum = elementType == 4 or 0
    end
    result = result + addnum
    return result
  end
end

BattleWorld.GetVocationNumFromLeftLine = function(self, vocationType)
  -- function num : 0_29 , upvalues : _ENV
  if not (self._leftLineupInfo).vocation then
    LogError("BattleWorld", "leftLineupInfo.vocation is nil")
    return 0
  end
  local result = ((self._leftLineupInfo).vocation)[7] or 0
  do
    if not ((self._leftLineupInfo).vocation)[vocationType] then
      local addnum = vocationType == 7 or 0
    end
    result = result + addnum
    return result
  end
end

BattleWorld.CreatePhysicsWorld = function(self)
  -- function num : 0_30 , upvalues : _ENV
  self._physicsWorld = (box2d.newWorld)(0, -1000)
  local landBodyId = (box2d.newBody)(self._physicsWorld, 0, 0, 0)
  ;
  (box2d.bodySetUserData)(self._physicsWorld, landBodyId, {entityid = 0, camp = 0, skillid = 0, rad = 0, useskillentityid = 0})
  local landFixtureId = 0
  if self._battleID == 1122 then
    landFixtureId = (box2d.newEdgeShapeFixture)(self._physicsWorld, landBodyId, -10000, 266, 10000, 266, 200, 0, 1000, false, 65535, 65535)
  else
    if self._battleID == 1127 then
      landFixtureId = (box2d.newEdgeShapeFixture)(self._physicsWorld, landBodyId, -10000, -50, 10000, -50, 200, 0, 1000, false, 65535, 65535)
    else
      landFixtureId = (box2d.newEdgeShapeFixture)(self._physicsWorld, landBodyId, -10000, -7930, 10000, -7930, 200, 0, 1000, false, 65535, 65535)
    end
  end
  ;
  (box2d.fixtureSetUserData)(self._physicsWorld, landBodyId, landFixtureId, {fixtype = "land"})
  landFixtureId = (box2d.newEdgeShapeFixture)(self._physicsWorld, landBodyId, -10000, -10000, -10000, 10000, 200, 0, 1000, false, 65535, 65535)
  ;
  (box2d.fixtureSetUserData)(self._physicsWorld, landBodyId, landFixtureId, {fixtype = "land"})
  landFixtureId = (box2d.newEdgeShapeFixture)(self._physicsWorld, landBodyId, 10000, -10000, 10000, 10000, 200, 0, 1000, false, 65535, 65535)
  ;
  (box2d.fixtureSetUserData)(self._physicsWorld, landBodyId, landFixtureId, {fixtype = "land"})
  landFixtureId = (box2d.newEdgeShapeFixture)(self._physicsWorld, landBodyId, -10000, 9000, 10000, 9000, 200, 0, 1000, false, 65535, 65535)
  ;
  (box2d.fixtureSetUserData)(self._physicsWorld, landBodyId, landFixtureId, {fixtype = "land"})
end

BattleWorld.GetBatterIndex = function(self)
  -- function num : 0_31 , upvalues : _ENV
  return (table.nums)(self._leftPlayerList) + (table.nums)(self._leftPlayerSummonList) + (table.nums)(self._rightPlayerList) + (table.nums)(self._rightPlayerSummonList)
end

BattleWorld.GetRightPlayerList = function(self)
  -- function num : 0_32
  return self._rightPlayerList
end

BattleWorld.GetLeftPlayerList = function(self)
  -- function num : 0_33
  return self._leftPlayerList
end

BattleWorld.IfNoCreatingPlayer = function(self)
  -- function num : 0_34 , upvalues : _ENV
  local component = (self._createUtilityEntity):GetComponent((BattleECS.Components).CreateRoleComponent)
  if #component._playerInfoList ~= 0 then
    LogInfoFormat("BattleWorld", "component._playerInfoList number %s", #component._playerInfoList)
  end
  do return #component._playerInfoList == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BattleWorld.CreateLeftPlayer = function(self, playerInfo, additionalInfo)
  -- function num : 0_35 , upvalues : _ENV
  local component = (self._createUtilityEntity):GetComponent((BattleECS.Components).CreateRoleComponent)
  if additionalInfo then
    (table.insert)(component._playerInfoList, {playerInfo = playerInfo, camp = (((BattleECS.Components).TypeComponent).CampType).Left, isInitial = additionalInfo.isInitial, alternateFighterBean = additionalInfo.alternateFighterBean})
  else
    ;
    (table.insert)(component._playerInfoList, {playerInfo = playerInfo, camp = (((BattleECS.Components).TypeComponent).CampType).Left})
  end
end

BattleWorld.RevivePlayer = function(self, entityid)
  -- function num : 0_36 , upvalues : _ENV
  local entity = nil
  for i,e in ipairs(self._entitys) do
    if e._entityId == entityid then
      entity = e
      break
    end
  end
  do
    if entity then
      (((BattleECS.Utility).PhysicsUtility).SetEntityPhyscisComponentAwake)(entity, true)
      local component = entity:GetComponent((BattleECS.Components).PositionComponent)
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (component._position).x = ((entity:GetComponent((BattleECS.Components).PositionComponent))._targetPos).x
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (component._position).y = ((entity:GetComponent((BattleECS.Components).PositionComponent))._targetPos).y
      ;
      (((BattleECS.Utility).PhysicsUtility).SetEntityPosition)(self._physicsWorld, entity, (component._position).x, (component._position).y)
      ;
      (((BattleECS.Utility).BuffUtility).RevivePlayerBuffState)(entity)
      component = entity:GetComponent((BattleECS.Components).AnimationEventComponent)
      component._roleIsInPositionChangeAnimationData = {}
      local ifIgnorePriority = {No = 0, Yes = 1}
      ;
      (((BattleECS.Utility).ProtocolUtility).SendBattlerPlayAnimationByNameProtocol)(entity, "Revive", ifIgnorePriority.No, self)
      local attribute = {}
      component = entity:GetComponent((BattleECS.Components).HpComponent)
      attribute.hp = (fixedpoint.tonumber)(component._currentHp)
      attribute.hpmax = (fixedpoint.tonumber)(component._maxHp)
      ;
      (((BattleECS.Utility).ProtocolUtility).SendRoleCreate)(entity._entityId, 1, attribute, {}, nil, self)
      ;
      (((BattleECS.Utility).ProtocolUtility).SendPlayBattleVoice)((entity:GetComponent((BattleECS.Components).TypeComponent))._roleID, (((BattleECS.Utility).DataUtility).VoiceType).Revive, nil, self)
    end
  end
end

BattleWorld.SetLeftPlayerPositionAndImaged = function(self, entityid, x, y, isImaged)
  -- function num : 0_37 , upvalues : _ENV
  local entity = nil
  for i,e in ipairs(self._entitys) do
    if e._entityId == entityid then
      entity = e
      break
    end
  end
  do
    if entity then
      local component = entity:GetComponent((BattleECS.Components).PositionComponent)
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (component._position).x = x
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (component._position).y = y
      ;
      (((BattleECS.Utility).PhysicsUtility).SetEntityPosition)(self._physicsWorld, entity, x, y)
      ;
      (entity:GetComponent((BattleECS.Components).TypeComponent))._isImaged = isImaged
      ;
      (((BattleECS.Utility).PhysicsUtility).SetEntityPhyscisComponentAwake)(entity, not isImaged)
    end
  end
end

BattleWorld.ChangeLeftPlayer = function(self, playerInfo)
  -- function num : 0_38 , upvalues : _ENV
  local leftPlayer = nil
  for _,e in ipairs(self._leftPlayerList) do
    if e._entityId == playerInfo.entityid then
      leftPlayer = e
      break
    end
  end
  do
    if not leftPlayer then
      for _,e in ipairs(self._leftPlayerSummonList) do
        if e._entityId == playerInfo.entityid then
          leftPlayer = e
          break
        end
      end
    end
    do
      local rightPlayer = nil
      for _,e in ipairs(self._rightPlayerList) do
        if e._entityId == playerInfo.entityid then
          rightPlayer = e
          break
        end
      end
      do
        if not rightPlayer then
          for _,e in ipairs(self._rightPlayerSummonList) do
            if e._entityId == playerInfo.entityid then
              rightPlayer = e
              break
            end
          end
        end
        do
          if leftPlayer then
            local entity = leftPlayer
            self:DestroyPhysicsBody((entity:GetComponent((BattleECS.Components).PhysicsComponent))._box2DBodyID)
            local shapeConfig = nil
            if playerInfo.shapeid == 0 then
              shapeConfig = {assetBundleName = playerInfo.assetBundleName, prefabName = playerInfo.prefabName}
            else
              shapeConfig = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[playerInfo.shapeid]
            end
            local component = entity:GetComponent((BattleECS.Components).TypeComponent)
            component._changeShapeID = playerInfo.shapeid
            component = entity:GetComponent((BattleECS.Components).PositionComponent)
            local BodyId = (box2d.newBody)(self._physicsWorld, 2, (component._position).x, (component._position).y)
            ;
            (box2d.bodySetUserData)(self._physicsWorld, BodyId, {entityid = entity._entityId, camp = 1, skillid = 0, rad = 0, useskillentityid = entity._entityId})
            local colliderData = require("data.battledata.npcshapedata." .. (string.lower)(shapeConfig.prefabName))
            local hitFixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackedColliserSize).x, (colliderData.attackedColliserSize).y, (colliderData.attackedColliserOffect).x, (colliderData.attackedColliserOffect).y, 0, 200, 0, 0, true, 3, 3)
            ;
            (box2d.fixtureSetUserData)(self._physicsWorld, BodyId, hitFixtureId, {fixid = hitFixtureId, fixtype = "hitted"})
            local landFixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, 50, 50, 0, 0, 0, 5000, 0, 1000, false, tonumber((string.format)("%#x", tostring(2 ^ self:GetBatterIndex()))), tonumber((string.format)("%#x", tostring(2 ^ self:GetBatterIndex()))))
            ;
            (box2d.fixtureSetUserData)(self._physicsWorld, BodyId, landFixtureId, {fixid = landFixtureId, fixtype = "land"})
            component = entity:GetComponent((BattleECS.Components).PhysicsComponent)
            component._box2DBodyID = BodyId
            component = entity:GetComponent((BattleECS.Components).BuffComponent)
            if component then
              for _,v in ipairs(component._buffList) do
                (v.buffObj):ChangeShapeToPlayBeginBuffEffect()
              end
            end
            do
              do
                do return entity end
                if rightPlayer then
                  local entity = rightPlayer
                  self:DestroyPhysicsBody((entity:GetComponent((BattleECS.Components).PhysicsComponent))._box2DBodyID)
                  local shapeConfig = nil
                  if playerInfo.shapeid == 0 then
                    shapeConfig = {assetBundleName = playerInfo.assetBundleName, prefabName = playerInfo.prefabName}
                  else
                    shapeConfig = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[playerInfo.shapeid]
                  end
                  local component = entity:GetComponent((BattleECS.Components).TypeComponent)
                  component._changeShapeID = playerInfo.shapeid
                  component = entity:GetComponent((BattleECS.Components).PositionComponent)
                  local BodyId = (box2d.newBody)(self._physicsWorld, 2, (component._position).x, (component._position).y)
                  ;
                  (box2d.bodySetUserData)(self._physicsWorld, BodyId, {entityid = entity._entityId, camp = 2, skillid = 0, rad = 0, useskillentityid = entity._entityId})
                  local colliderData = require("data.battledata.npcshapedata." .. (string.lower)(shapeConfig.prefabName))
                  local hitFixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackedColliserSize).x, (colliderData.attackedColliserSize).y, -(colliderData.attackedColliserOffect).x, (colliderData.attackedColliserOffect).y, 0, 200, 0, 0, true, 3, 3)
                  ;
                  (box2d.fixtureSetUserData)(self._physicsWorld, BodyId, hitFixtureId, {fixid = hitFixtureId, fixtype = "hitted"})
                  local landFixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, 50, 50, 0, 0, 0, 5000, 0, 1000, false, tonumber((string.format)("%#x", tostring(2 ^ self:GetBatterIndex()))), tonumber((string.format)("%#x", tostring(2 ^ self:GetBatterIndex()))))
                  ;
                  (box2d.fixtureSetUserData)(self._physicsWorld, BodyId, landFixtureId, {fixid = landFixtureId, fixtype = "land"})
                  component = entity:GetComponent((BattleECS.Components).PhysicsComponent)
                  component._box2DBodyID = BodyId
                  component = entity:GetComponent((BattleECS.Components).BuffComponent)
                  if component then
                    for _,v in ipairs(component._buffList) do
                      (v.buffObj):ChangeShapeToPlayBeginBuffEffect()
                    end
                  end
                  do
                    do return entity end
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

BattleWorld.CreateLeftPlayerSummon = function(self, ...)
  -- function num : 0_39 , upvalues : _ENV
  local rec = {...}
  local info = rec[1]
  local name = info.name
  if name == "yuzi" then
    local monsterid = info.monsterid
    local buffdata = info.buffdata
    local pos = 0
    if monsterid == 90001 then
      pos = 72
    else
      if monsterid == 90002 then
        pos = 73
      else
        if monsterid == 90003 then
          pos = 74
        end
      end
    end
    local data = {}
    local record = (string.split)(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[pos]).attr, ",")
    data.x = fixedpoint(record[1])
    data.y = fixedpoint(record[2])
    data.z = fixedpoint(record[3])
    local config = (((BattleECS.Utility).DataUtility).cMonsterCfgTable)[monsterid]
    if config then
      local entity = self:NewEntity()
      local shapeConfig = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[config.shapeID]
      local component = entity:AddComponent((BattleECS.Components).TypeComponent)
      component._camp = (((BattleECS.Components).TypeComponent).CampType).Left
      component._roleID = monsterid
      component._summonName = name
      local roleRecorder = (((BattleECS.Utility).DataUtility).roleConfigTable)[monsterid]
      if not roleRecorder then
        roleRecorder = (((BattleECS.Utility).DataUtility).cMonsterCfgTable)[monsterid]
      end
      local shapeRecorder = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[roleRecorder.shapeID]
      component._oriShapeAssetBundleName = shapeRecorder.assetBundleName
      component._oriShapePrefabName = shapeRecorder.prefabName
      entity:AddComponent((BattleECS.Components).HpComponent)
      entity:AddComponent((BattleECS.Components).DefenseComponent)
      entity:AddComponent((BattleECS.Components).AttackComponent)
      entity:AddComponent((BattleECS.Components).AnimationEventComponent)
      local BodyId = (box2d.newBody)(self._physicsWorld, 2, data.x, data.y)
      ;
      (box2d.bodySetUserData)(self._physicsWorld, BodyId, {entityid = entity._entityId, camp = 1, skillid = 1, rad = 0, useskillentityid = entity._entityId})
      local colliderData = require("data.battledata.npcshapedata." .. (string.lower)(shapeConfig.prefabName))
      local hitFixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackedColliserSize).x, (colliderData.attackedColliserSize).y, (colliderData.attackedColliserOffect).x, (colliderData.attackedColliserOffect).y, 0, 200, 0, 0, true, 3, 3)
      ;
      (box2d.fixtureSetUserData)(self._physicsWorld, BodyId, hitFixtureId, {fixid = hitFixtureId, fixtype = "hitted"})
      component = entity:AddComponent((BattleECS.Components).PhysicsComponent)
      component._box2DBodyID = BodyId
      entity:AddComponent((BattleECS.Components).BehaviorComponent)
      local behavior = nil
      if config.behaviacAI ~= "" then
        behavior = (BehaviorManager.NewBehavior)("newbattle/" .. config.behaviacAI)
      else
        behavior = (BehaviorManager.NewBehavior)("newbattle/newbattle")
      end
      component = entity:AddComponent((BattleECS.Components).SkillComponent)
      behavior._behaviorSkillList = {}
      for _,v in ipairs(config.skillid) do
        if v ~= 0 then
          local cd = ((((BattleECS.Utility).DataUtility).cSkillCostTable)[v]).CDfraps
          local hasSaveSkillInSkillComponentSkillList = false
          for _,skillTable in ipairs(component._skillList) do
            if skillTable.skillId == v then
              skillTable.cdTime = fixedpoint(cd)
              skillTable.currentTime = 0
              hasSaveSkillInSkillComponentSkillList = true
              break
            end
          end
          do
            do
              if not hasSaveSkillInSkillComponentSkillList then
                (table.insert)(component._skillList, {skillId = v, cdTime = fixedpoint(cd), currentTime = 0})
              end
              ;
              (table.insert)(behavior._behaviorSkillList, v)
              -- DECOMPILER ERROR at PC255: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC255: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC255: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      behavior._data = {RandomFunction = self._randomPcg}
      behavior._entityId = entity._entityId
      behavior._battleworld = self
      behavior:SetTree()
      ;
      (entity:GetComponent((BattleECS.Components).BehaviorComponent))._behavior = behavior
      component = entity:AddComponent((BattleECS.Components).PositionComponent)
      -- DECOMPILER ERROR at PC280: Confused about usage of register: R19 in 'UnsetPending'

      ;
      (component._position).x = data.x
      -- DECOMPILER ERROR at PC283: Confused about usage of register: R19 in 'UnsetPending'

      ;
      (component._position).y = data.y
      -- DECOMPILER ERROR at PC286: Confused about usage of register: R19 in 'UnsetPending'

      ;
      (component._position).z = data.z
      entity:AddComponent((BattleECS.Components).BuffComponent)
      local buffenermyentity = nil
      for i,e in ipairs(self._entitys) do
        if e._entityId == info.useskillentityid then
          buffenermyentity = e
          break
        end
      end
      do
        ;
        (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({entity = entity, enermyentity = buffenermyentity, buffid = buffdata.buffid, buffparamter = buffdata.buffvalues, skillid = info.skillid, battleworld = self})
        local protocol = (BattleClientProtocolManager.CreateProtocol)("action.srolesummoncreate")
        protocol.entityid = entity._entityId
        -- DECOMPILER ERROR at PC332: Confused about usage of register: R21 in 'UnsetPending'

        ;
        (protocol.attribute).camp = (((BattleECS.Components).TypeComponent).CampType).Left
        -- DECOMPILER ERROR at PC334: Confused about usage of register: R21 in 'UnsetPending'

        ;
        (protocol.attribute).id = monsterid
        component = entity:GetComponent((BattleECS.Components).HpComponent)
        -- DECOMPILER ERROR at PC346: Confused about usage of register: R21 in 'UnsetPending'

        ;
        (protocol.attribute).hp = (fixedpoint.tonumber)(component._maxHp)
        -- DECOMPILER ERROR at PC352: Confused about usage of register: R21 in 'UnsetPending'

        ;
        (protocol.attribute).hpmax = (fixedpoint.tonumber)(component._maxHp)
        -- DECOMPILER ERROR at PC358: Confused about usage of register: R21 in 'UnsetPending'

        ;
        (protocol.attribute).x = (fixedpoint.tonumber)(data.x)
        -- DECOMPILER ERROR at PC364: Confused about usage of register: R21 in 'UnsetPending'

        ;
        (protocol.attribute).y = (fixedpoint.tonumber)(data.y)
        -- DECOMPILER ERROR at PC370: Confused about usage of register: R21 in 'UnsetPending'

        ;
        (protocol.attribute).z = (fixedpoint.tonumber)(data.z)
        -- DECOMPILER ERROR at PC373: Confused about usage of register: R21 in 'UnsetPending'

        ;
        (protocol.attribute).assetbundlename = shapeRecorder.assetBundleName
        -- DECOMPILER ERROR at PC376: Confused about usage of register: R21 in 'UnsetPending'

        ;
        (protocol.attribute).prefabname = shapeRecorder.prefabName
        self:InsertViewProtocolData(protocol)
        do return entity end
      end
    end
  end
end

BattleWorld.CreatePlayerSummon = function(self, ...)
  -- function num : 0_40 , upvalues : _ENV
  local rec = {...}
  local info = rec[1]
  local name = info.name
  if name == "buff" then
    local config = (((BattleECS.Utility).DataUtility).cMonsterCfgTable)[info.monsterid]
    if config then
      local x, y, z = (info.bornPoint).x, (info.bornPoint).y, (info.bornPoint).z
      local shapeConfig = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[config.shapeID]
      local entity = self:NewEntity()
      local component = entity:AddComponent((BattleECS.Components).HpComponent)
      local SummonTypeEnum = {SameWithFather = 1, ReadFromConfig = 2}
      if info.summonType == SummonTypeEnum.SameWithFather then
        local fatherComponent = (info.summonFatherEntity):GetComponent((BattleECS.Components).HpComponent)
        component._maxHp = fatherComponent._maxHp
        component._basicMaxHp = component._maxHp
        component._currentHp = fatherComponent._maxHp
        component = entity:AddComponent((BattleECS.Components).DefenseComponent)
        fatherComponent = (info.summonFatherEntity):GetComponent((BattleECS.Components).DefenseComponent)
        component._attackDefense = fatherComponent._attackDefense
        component._basicAttackDefense = component._attackDefense
        component._magicDefense = fatherComponent._magicDefense
        component._basicMagicDefense = component._magicDefense
        component._attackDefenseAddition = fatherComponent._attackDefenseAddition
        component._magicDefenseAddition = fatherComponent._magicDefenseAddition
        component._attackInjuryReduceNumber = fatherComponent._attackInjuryReduceNumber
        component._magicInjuryReduceNumber = fatherComponent._magicInjuryReduceNumber
        component._attackMiss = fatherComponent._attackMiss
        component._attackCritDefense = fatherComponent._attackCritDefense
        component._attackCritDegreeDefense = fatherComponent._attackCritDegreeDefense
        component._damageReduce = fatherComponent._damageReduce
        component = entity:AddComponent((BattleECS.Components).AttackComponent)
        fatherComponent = (info.summonFatherEntity):GetComponent((BattleECS.Components).AttackComponent)
        component._attack = fatherComponent._attack
        component._basicAttack = component._attack
        component._attackDamageAddition = fatherComponent._attackDamageAddition
        component._magicDamageAddition = fatherComponent._magicDamageAddition
        component._attackSuckBlood = fatherComponent._attackSuckBlood
        component._magicSuckBlood = fatherComponent._magicSuckBlood
        component._attackSpeed = fatherComponent._attackSpeed
        component._attackDefBreak = fatherComponent._attackDefBreak
        component._magicDefBreak = fatherComponent._magicDefBreak
        component._attackCritRate = fatherComponent._attackCritRate
        component._basicAttackCritRate = component._attackCritRate
        component._attackCritDegree = fatherComponent._attackCritDegree
        component._basicAttackCritDegree = component._attackCritDegree
        component._attackAddition = fatherComponent._attackAddition
        component._magicAddition = fatherComponent._magicAddition
        component._treatmentAddition = fatherComponent._treatmentAddition
        component._hitRate = fatherComponent._hitRate
        component._attackCritLevel = fatherComponent._attackCritLevel
        component._attackCritDegreeLevel = fatherComponent._attackCritDegreeLevel
      else
        do
          if info.summonType == SummonTypeEnum.ReadFromConfig then
            local fatherComponent = (info.summonFatherEntity):GetComponent((BattleECS.Components).TypeComponent)
            local totalHp = fixedpoint_zero
            local hpConstant = (string.split)(config.hpConstant, ";")
            for i,hp in ipairs(hpConstant) do
              local value = (((BattleECS.Utility).Utility).CalculateConfigAttrFunc)(hp, {lv = fatherComponent._level})
              totalHp = totalHp + value
            end
            component._maxHp = totalHp
            component._basicMaxHp = component._maxHp
            component._currentHp = totalHp
            component = entity:AddComponent((BattleECS.Components).AttackComponent)
            local value = (((BattleECS.Utility).Utility).CalculateConfigAttrFunc)(config.attackConstant, {lv = fatherComponent._level})
            component._attack = fixedpoint(value)
            component._basicAttack = component._attack
            component = entity:AddComponent((BattleECS.Components).DefenseComponent)
            value = (((BattleECS.Utility).Utility).CalculateConfigAttrFunc)(config.defConstant, {lv = fatherComponent._level})
            component._attackDefense = fixedpoint(value)
            component._basicAttackDefense = component._attackDefense
            value = (((BattleECS.Utility).Utility).CalculateConfigAttrFunc)(config.magicDefConstant, {lv = fatherComponent._level})
            component._magicDefense = fixedpoint(value)
            component._basicMagicDefense = component._magicDefense
            value = (((BattleECS.Utility).Utility).CalculateConfigAttrFunc)(config.damagereduce, {lv = fatherComponent._level})
            component._damageReduce = fixedpoint(value)
          end
          do
            local fatherCamp = ((info.summonFatherEntity):GetComponent((BattleECS.Components).TypeComponent))._camp
            local roleRecorder = (((BattleECS.Utility).DataUtility).roleConfigTable)[info.monsterid]
            if not roleRecorder then
              roleRecorder = (((BattleECS.Utility).DataUtility).cMonsterCfgTable)[info.monsterid]
            end
            local shapeRecorder = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[roleRecorder.shapeID]
            component = entity:AddComponent((BattleECS.Components).TypeComponent)
            component._camp = fatherCamp
            component._roleID = info.monsterid
            component._summonName = name
            component._oriShapeAssetBundleName = shapeRecorder.assetBundleName
            component._oriShapePrefabName = shapeRecorder.prefabName
            component._rolePointNum = info.pointNum
            local protocol = (BattleClientProtocolManager.CreateProtocol)("action.srolesummoncreate")
            protocol.entityid = entity._entityId
            protocol.fatherEntityId = (info.summonFatherEntity)._entityId
            -- DECOMPILER ERROR at PC304: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (protocol.attribute).camp = fatherCamp
            -- DECOMPILER ERROR at PC307: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (protocol.attribute).id = info.monsterid
            component = entity:GetComponent((BattleECS.Components).HpComponent)
            -- DECOMPILER ERROR at PC319: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (protocol.attribute).hp = (fixedpoint.tonumber)(component._currentHp)
            -- DECOMPILER ERROR at PC325: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (protocol.attribute).hpmax = (fixedpoint.tonumber)(component._maxHp)
            -- DECOMPILER ERROR at PC331: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (protocol.attribute).x = (fixedpoint.tonumber)(x)
            -- DECOMPILER ERROR at PC337: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (protocol.attribute).y = (fixedpoint.tonumber)(y)
            -- DECOMPILER ERROR at PC343: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (protocol.attribute).z = (fixedpoint.tonumber)(z)
            -- DECOMPILER ERROR at PC346: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (protocol.attribute).assetbundlename = shapeRecorder.assetBundleName
            -- DECOMPILER ERROR at PC349: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (protocol.attribute).prefabname = shapeRecorder.prefabName
            -- DECOMPILER ERROR at PC352: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (protocol.attribute).nameTextId = config.nameTextID
            self:InsertViewProtocolData(protocol)
            entity:AddComponent((BattleECS.Components).AnimationEventComponent)
            component = entity:AddComponent((BattleECS.Components).DeadDisappearCountComponent)
            local animationEndData = require("data.battledata.npcshapeanimationdata." .. (string.lower)(shapeConfig.prefabName))
            if animationEndData.DeadDisappear then
              component._deadTotalCount = (animationEndData.DeadDisappear).endEventFrames
            else
              component._deadTotalCount = 0
            end
            local BodyId = (box2d.newBody)(self._physicsWorld, 2, x, y)
            ;
            (box2d.bodySetUserData)(self._physicsWorld, BodyId, {entityid = entity._entityId, camp = fatherCamp, skillid = 0, rad = 0, useskillentityid = entity._entityId})
            local colliderData = require("data.battledata.npcshapedata." .. (string.lower)(shapeConfig.prefabName))
            local hitFixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackedColliserSize).x, (colliderData.attackedColliserSize).y, (colliderData.attackedColliserOffect).x, (colliderData.attackedColliserOffect).y, 0, 200, 0, 0, true, 3, 3)
            ;
            (box2d.fixtureSetUserData)(self._physicsWorld, BodyId, hitFixtureId, {fixid = hitFixtureId, fixtype = "hitted"})
            component = entity:AddComponent((BattleECS.Components).PhysicsComponent)
            component._box2DBodyID = BodyId
            -- DECOMPILER ERROR at PC455: Confused about usage of register: R20 in 'UnsetPending'

            if config.speed then
              (component._toTargetMaxSpeed).x = fixedpoint(config.speed) * 10
            else
              -- DECOMPILER ERROR at PC462: Confused about usage of register: R20 in 'UnsetPending'

              ;
              (component._toTargetMaxSpeed).x = fixedpoint(config.speedConstant) * 10
            end
            entity:AddComponent((BattleECS.Components).BehaviorComponent)
            local behavior = nil
            if config.behaviacAI ~= "" then
              behavior = (BehaviorManager.NewBehavior)("newbattle/" .. config.behaviacAI)
            else
              behavior = (BehaviorManager.NewBehavior)("newbattle/newbattle")
            end
            component = entity:AddComponent((BattleECS.Components).SkillComponent)
            behavior._behaviorSkillList = {}
            for _,v in ipairs(config.skillid) do
              if v ~= 0 then
                local cd = ((((BattleECS.Utility).DataUtility).cSkillCostTable)[v]).CDfraps
                local hasSaveSkillInSkillComponentSkillList = false
                for _,skillTable in ipairs(component._skillList) do
                  if skillTable.skillId == v then
                    skillTable.cdTime = fixedpoint(cd)
                    skillTable.currentTime = 0
                    hasSaveSkillInSkillComponentSkillList = true
                    break
                  end
                end
                do
                  do
                    if not hasSaveSkillInSkillComponentSkillList then
                      (table.insert)(component._skillList, {skillId = v, cdTime = fixedpoint(cd), currentTime = 0})
                    end
                    ;
                    (table.insert)(behavior._behaviorSkillList, v)
                    -- DECOMPILER ERROR at PC540: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC540: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC540: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
            component._isHasPassiveSkillParamter = ((info.summonFatherEntity):GetComponent((BattleECS.Components).SkillComponent))._isHasPassiveSkillParamter
            behavior._data = {RandomFunction = self._randomPcg}
            behavior._entityId = entity._entityId
            behavior._battleworld = self
            behavior:SetTree()
            ;
            (entity:GetComponent((BattleECS.Components).BehaviorComponent))._behavior = behavior
            component = entity:AddComponent((BattleECS.Components).PositionComponent)
            -- DECOMPILER ERROR at PC572: Confused about usage of register: R21 in 'UnsetPending'

            ;
            (component._position).x = x
            -- DECOMPILER ERROR at PC574: Confused about usage of register: R21 in 'UnsetPending'

            ;
            (component._position).y = y
            -- DECOMPILER ERROR at PC576: Confused about usage of register: R21 in 'UnsetPending'

            ;
            (component._position).z = z
            -- DECOMPILER ERROR at PC578: Confused about usage of register: R21 in 'UnsetPending'

            ;
            (component._targetPos).x = x
            -- DECOMPILER ERROR at PC580: Confused about usage of register: R21 in 'UnsetPending'

            ;
            (component._targetPos).y = y
            entity:AddComponent((BattleECS.Components).BuffComponent)
            entity:AddComponent((BattleECS.Components).SummonDataComponent)
            if config.defaultBuff and config.defaultBuff ~= "" then
              for _,v in ipairs((string.split)(config.defaultBuff, ";")) do
                (((BattleECS.Utility).BuffUtility).InsertEntityDifferentBuff)({entity = entity, enermyentity = entity, buffid = tonumber(v), buffparamter = "time=99999", skillid = 0, battleworld = self})
              end
            end
            do
              for _,birthSkill in ipairs(info.birthSkillList) do
                (((BattleECS.Utility).BuffUtility).SetBuffListToOwnCampEntityBySkillID)(entity, entity, tonumber(birthSkill), self)
                local hittedEntityList = (((BattleECS.Utility).Utility).GetSkillEffectEntity)(tonumber(birthSkill), entity._entityId, self)
                if (table.nums)(hittedEntityList) ~= 0 then
                  self:CreateSkillEntity(tonumber(birthSkill), entity._entityId, 1, hittedEntityList)
                end
              end
              ;
              (entity:GetComponent((BattleECS.Components).TypeComponent))._summonFatherEntityid = (info.summonFatherEntity)._entityId
              local DeleteType = {DontDeleteFatherBuff = 0, DeleteFatherBuff = 1}
              if info.buffDeletedAfterDeathOrNot == DeleteType.DeleteFatherBuff then
                (table.insert)(((info.summonFatherEntity):GetComponent((BattleECS.Components).SummonDataComponent))._summonBuffData, {buffId = info.buffId, summonEntityId = entity._entityId})
              end
              if fatherCamp == (((BattleECS.Components).TypeComponent).CampType).Left then
                local hasEntity = false
                for i,e in ipairs(self._leftPlayerSummonList) do
                  -- DECOMPILER ERROR at PC710: Confused about usage of register: R28 in 'UnsetPending'

                  if e._entityId == entity._entityId then
                    (self._leftPlayerSummonList)[i] = entity
                    hasEntity = true
                  end
                end
                if not hasEntity then
                  (table.insert)(self._leftPlayerSummonList, entity)
                end
              else
                do
                  if fatherCamp == (((BattleECS.Components).TypeComponent).CampType).Right then
                    local hasEntity = false
                    for i,e in ipairs(self._rightPlayerSummonList) do
                      -- DECOMPILER ERROR at PC739: Confused about usage of register: R28 in 'UnsetPending'

                      if e._entityId == entity._entityId then
                        (self._rightPlayerSummonList)[i] = entity
                        hasEntity = true
                      end
                    end
                    if not hasEntity then
                      (table.insert)(self._rightPlayerSummonList, entity)
                    end
                  else
                    do
                      LogErrorFormat("BattleWorld", "entity id %s summon id %s father\'s camp %s is not left/right, so destroy", entity._entityId, info.monsterid, fatherCamp)
                      do return entity end
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

BattleWorld.CreateRightPlayer = function(self, playerInfo, additionalInfo)
  -- function num : 0_41 , upvalues : _ENV
  local component = (self._createUtilityEntity):GetComponent((BattleECS.Components).CreateRoleComponent)
  if additionalInfo then
    (table.insert)(component._playerInfoList, {playerInfo = playerInfo, camp = (((BattleECS.Components).TypeComponent).CampType).Right, isInitial = additionalInfo.isInitial, alternateFighterBean = additionalInfo.alternateFighterBean})
  else
    ;
    (table.insert)(component._playerInfoList, {playerInfo = playerInfo, camp = (((BattleECS.Components).TypeComponent).CampType).Right})
  end
end

BattleWorld.CreatePartnerJoin = function(self, playerInfo, positionTable)
  -- function num : 0_42 , upvalues : _ENV
  local entity = self:NewEntity()
  local component = entity:AddComponent((BattleECS.Components).TypeComponent)
  component._camp = playerInfo.camp
  component._roleID = playerInfo.id
  component._rolePointNum = playerInfo.key
  component._summonName = "partner"
  component._oriShapeAssetBundleName = playerInfo.assetbundlename
  component._oriShapePrefabName = playerInfo.prefabname
  component._runelv = playerInfo.runelv
  component = entity:AddComponent((BattleECS.Components).HpComponent)
  component._maxHp = fixedpoint(playerInfo.hpmax)
  component._basicMaxHp = component._maxHp
  component._currentHp = fixedpoint(playerInfo.hp)
  component = entity:AddComponent((BattleECS.Components).AttackComponent)
  component._attack = fixedpoint(playerInfo.atk)
  component._basicAttack = component._attack
  component._attackDamageAddition = fixedpoint(playerInfo.physicalbonus) / 1000
  component._magicDamageAddition = fixedpoint(playerInfo.magicbonus) / 1000
  component._attackSuckBlood = fixedpoint(playerInfo.physicallifesteal) / 100
  component._magicSuckBlood = fixedpoint(playerInfo.magiclifesteal) / 100
  component._attackSpeed = fixedpoint(playerInfo.attackspeed) / 1000
  component._attackDefBreak = fixedpoint(playerInfo.physicaldefbreak)
  component._magicDefBreak = fixedpoint(playerInfo.magicdefbreak)
  component._attackCritRate = fixedpoint(playerInfo.physicalcritrate) / 1000
  component._basicAttackCritRate = component._attackCritRate
  component._attackCritDegree = fixedpoint(playerInfo.physicalcritdegree) / 1000
  component._basicAttackCritDegree = component._attackCritDegree
  component._attackAddition = fixedpoint(playerInfo.extraphysicaldamage)
  component._magicAddition = fixedpoint(playerInfo.extramagicdamage)
  component._treatmentAddition = fixedpoint(playerInfo.curativebonus) / 1000
  component._hitRate = fixedpoint(playerInfo.accuracy) / 1000
  component._healingPower = fixedpoint(playerInfo.healingpower)
  component._attackCritLevel = fixedpoint(playerInfo.critratelevel)
  component._attackCritDegreeLevel = fixedpoint(playerInfo.critdegreelevel)
  component = entity:AddComponent((BattleECS.Components).DefenseComponent)
  component._attackDefense = fixedpoint(playerInfo.def)
  component._basicAttackDefense = component._attackDefense
  component._magicDefense = fixedpoint(playerInfo.mdef)
  component._basicMagicDefense = component._magicDefense
  component._attackDefenseAddition = fixedpoint(playerInfo.physicalreduce) / 1000
  component._magicDefenseAddition = fixedpoint(playerInfo.magicreduce) / 1000
  component._attackInjuryReduceNumber = fixedpoint(playerInfo.physicalblock)
  component._magicInjuryReduceNumber = fixedpoint(playerInfo.magicblock)
  component._attackMiss = fixedpoint(playerInfo.physicalevasion) / 1000
  component._attackCritDefense = fixedpoint(playerInfo.critrateresistance) / 1000
  component._attackCritDegreeDefense = fixedpoint(playerInfo.critdegreeresistance) / 1000
  component._damageReduce = fixedpoint(playerInfo.damagereduce) / 1000
  component = entity:AddComponent((BattleECS.Components).SkillComponent)
  local count = 0
  for _,v in ipairs(playerInfo.skilllist) do
    if v ~= 0 then
      local cd = ((((BattleECS.Utility).DataUtility).cSkillCostTable)[v]).CDfraps
      local hasSaveSkillInSkillComponentSkillList = false
      for _,skillTable in ipairs(component._skillList) do
        if skillTable.skillId == v then
          skillTable.cdTime = fixedpoint(cd)
          skillTable.currentTime = 0
          hasSaveSkillInSkillComponentSkillList = true
          break
        end
      end
      do
        do
          if not hasSaveSkillInSkillComponentSkillList then
            (table.insert)(component._skillList, {skillId = v, cdTime = fixedpoint(cd), currentTime = cd})
          end
          count = (((BattleECS.Utility).Utility).GetMonsterOrRoleMagicOrAttackEndFraps)(entity, v)
          -- DECOMPILER ERROR at PC238: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC238: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC238: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  local BodyId = (box2d.newBody)(self._physicsWorld, 2, positionTable.x, positionTable.y)
  component = entity:AddComponent((BattleECS.Components).PhysicsComponent)
  component._box2DBodyID = BodyId
  component = entity:AddComponent((BattleECS.Components).PositionComponent)
  -- DECOMPILER ERROR at PC262: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (component._position).x = positionTable.x
  -- DECOMPILER ERROR at PC265: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (component._position).y = positionTable.y
  -- DECOMPILER ERROR at PC268: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (component._position).z = positionTable.z
  if count ~= 0 then
    component = entity:AddComponent((BattleECS.Components).RoleDeadCountComponent)
    component._maxCount = count
  end
  entity:AddComponent((BattleECS.Components).BuffComponent)
  entity:AddComponent((BattleECS.Components).AnimationEventComponent)
  for _,v in ipairs(playerInfo.skilllist) do
    (((BattleECS.Utility).Utility).SetSkillID)(entity, v)
  end
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.spartnercreate")
  protocol.entityid = entity._entityId
  -- DECOMPILER ERROR at PC309: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (protocol.attribute).atk = playerInfo.atk
  -- DECOMPILER ERROR at PC312: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (protocol.attribute).matk = playerInfo.matk
  -- DECOMPILER ERROR at PC315: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (protocol.attribute).camp = playerInfo.camp
  -- DECOMPILER ERROR at PC317: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (protocol.attribute).speed = 0
  -- DECOMPILER ERROR at PC320: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (protocol.attribute).skilllist = playerInfo.skilllist
  -- DECOMPILER ERROR at PC323: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (protocol.attribute).key = playerInfo.key
  -- DECOMPILER ERROR at PC326: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (protocol.attribute).id = playerInfo.id
  -- DECOMPILER ERROR at PC332: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (protocol.attribute).x = (fixedpoint.tonumber)(positionTable.x)
  -- DECOMPILER ERROR at PC338: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (protocol.attribute).y = (fixedpoint.tonumber)(positionTable.y)
  -- DECOMPILER ERROR at PC344: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (protocol.attribute).z = (fixedpoint.tonumber)(positionTable.z)
  -- DECOMPILER ERROR at PC347: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (protocol.attribute).assetbundlename = playerInfo.assetbundlename
  -- DECOMPILER ERROR at PC350: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (protocol.attribute).prefabname = playerInfo.prefabname
  self:InsertViewProtocolData(protocol)
  local hasEntity = false
  for i,e in ipairs(self._leftPlayerPartnerList) do
    -- DECOMPILER ERROR at PC364: Confused about usage of register: R14 in 'UnsetPending'

    if e._entityId == entity._entityId then
      (self._leftPlayerPartnerList)[i] = entity
      hasEntity = true
    end
  end
  if not hasEntity then
    (table.insert)(self._leftPlayerPartnerList, entity)
  end
  local pos = entity:GetComponent((BattleECS.Components).PositionComponent)
  local delt = (((BattleECS.Utility).Utility).GetSkillEffectSocketPoint)(playerInfo.prefabname, "HitPoint_Bottom")
  local x, y = (pos._position).x - delt.x, (pos._position).y + delt.y
  ;
  (((BattleECS.Utility).ProtocolUtility).SCreateSceneEffect)(3, x, y, 0, 1, self)
  return entity
end

BattleWorld.CreateSkillEntity = function(self, skillid, useSkillEntityID, createIndex, hittedEntityList)
  -- function num : 0_43 , upvalues : _ENV
  local hasEffect = false
  local useSkillEntity = nil
  for i,e in ipairs(self._entitys) do
    if e._entityId == useSkillEntityID then
      useSkillEntity = e
      break
    end
  end
  do
    if useSkillEntity then
      local useSkillEntitySkillComponent = useSkillEntity:GetComponent((BattleECS.Components).SkillComponent)
      local isAttackSkill = (((BattleECS.Utility).Utility).IsAttackSkill)(skillid)
      local isUseSkill = (((BattleECS.Utility).Utility).IsUseSkill)(skillid)
      local skillBehaviorRecord = (((BattleECS.Utility).DataUtility).cSkillBehaviorTable)[skillid]
      if skillBehaviorRecord then
        local max = 1
        local endAnimationFrames = 0
        local entity = self:NewEntity()
        if isAttackSkill then
          (table.insert)(useSkillEntitySkillComponent._attackEntitySkillList, entity)
        else
          if isUseSkill then
            for _,attackSkillEntity in ipairs(useSkillEntitySkillComponent._attackEntitySkillList) do
              local tempCom = attackSkillEntity:GetComponent((BattleECS.Components).TypeComponent)
              if tempCom then
                tempCom._isNeedDestroy = true
                tempCom._isNeedSendProtocolDestroy = false
              end
              tempCom = attackSkillEntity:GetComponent((BattleECS.Components).SkillEffectComponent)
              if tempCom then
                tempCom._animationAtkList = {}
                local removeList = {}
                for i = #tempCom._flyEntityList, 1, -1 do
                  local v = (tempCom._flyEntityList)[i]
                  local flyentity = nil
                  for _,e in ipairs(self._entitys) do
                    if e._entityId == v.entityId then
                      flyentity = e
                      break
                    end
                  end
                  do
                    do
                      if flyentity then
                        if flyentity:GetComponent((BattleECS.Components).PhysicsComponent) then
                          (flyentity:GetComponent((BattleECS.Components).PhysicsComponent))._isNeedReleaseBox = true
                        end
                        ;
                        (flyentity:GetComponent((BattleECS.Components).TypeComponent))._isNeedDestroy = true
                      end
                      ;
                      (table.insert)(removeList, i)
                      -- DECOMPILER ERROR at PC123: LeaveBlock: unexpected jumping out DO_STMT

                    end
                  end
                end
                for _,i in ipairs(removeList) do
                  (table.remove)(tempCom._flyEntityList, i)
                end
              end
            end
            useSkillEntitySkillComponent._attackEntitySkillList = {}
          end
        end
        local component = entity:AddComponent((BattleECS.Components).SkillEffectComponent)
        local animationRecord = (((BattleECS.Utility).DataUtility).cSkillAnimationTable)[skillid]
        if animationRecord then
          local animationType = {None = 0, OneAttackAction = 1, ThreeAnimationAction = 2}
          if animationRecord.actionType == animationType.ThreeAnimationAction then
            local ifIgnorePriority = {No = 0, Yes = 1}
            ;
            (((BattleECS.Utility).ProtocolUtility).SendBattlerPlayAnimationByNameProtocol)(useSkillEntity, animationRecord.skillStart, ifIgnorePriority.No, self)
            local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(useSkillEntity)
            local frapData = require("data.battledata.npcshapeanimationdata." .. (string.lower)(shapeRecorder.prefabName))
            local frapDataSkillStart = frapData[animationRecord.skillStart]
            if frapDataSkillStart then
              local startEndFrams = frapDataSkillStart.endEventFrames
              component._startAnimationDelayTime = startEndFrams
              ;
              (table.insert)(component._animationAtkList, {endAnimation = animationRecord.skillEnd, loopTime = startEndFrams + tonumber(animationRecord.loopTime)})
              if max < startEndFrams + tonumber(animationRecord.loopTime) then
                max = startEndFrams + tonumber(animationRecord.loopTime)
              end
            else
              do
                LogErrorFormat("BattleWorld", "npcshapeanimationdata.%s dont have skillStart in cSkillAnimationTable skillid %s", (string.lower)(shapeRecorder.prefabName), skillid)
                do
                  local frapDataSkillEnd = frapData[animationRecord.skillEnd]
                  if frapDataSkillEnd then
                    endAnimationFrames = frapDataSkillEnd.endEventFrames
                  end
                  if animationRecord.actionType == animationType.OneAttackAction then
                    local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(useSkillEntity)
                    local frapData = require("data.battledata.npcshapeanimationdata." .. (string.lower)(shapeRecorder.prefabName))
                    local frapDataActionAtk = frapData[animationRecord.actionAtk]
                    if frapDataActionAtk then
                      endAnimationFrames = frapDataActionAtk.endEventFrames
                    else
                      LogErrorFormat("BattleWorld", "npcshapeanimationdata.%s dont have actionAtk in cSkillAnimationTable skillid %s", (string.lower)(shapeRecorder.prefabName), skillid)
                    end
                  end
                  do
                    local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(useSkillEntity)
                    local frapData = require("data.battledata.npcshapeanimationdata." .. (string.lower)(shapeRecorder.prefabName))
                    do
                      local frapDataActionAtk = frapData[skillBehaviorRecord.actionAtk]
                      if frapDataActionAtk then
                        endAnimationFrames = frapDataActionAtk.endEventFrames
                      end
                      if (((BattleECS.Utility).Utility).IsSkillHas10006Buff)(skillid) then
                        entity:AddComponent((BattleECS.Components).TypeComponent)
                        local effect = ((((BattleECS.Utility).DataUtility).cSkillBehaviorTable)[skillid]).typeMineEffectAtk
                        for _,v in ipairs(effect) do
                          if type(v) ~= "number" then
                            LogErrorFormat("BattleWorld", "- DataUtility.cSkillBehaviorTable.typeMineEffectAtk[%s]  is  %s", skillid, type(v))
                          end
                          local skillEffectId = v
                          local curPrefabName = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._oriShapePrefabName
                          skillEffectId = (((BattleECS.Utility).Utility).GetSkinSkillChangeEffectId)(curPrefabName, skillEffectId)
                          if skillEffectId then
                            hasEffect = true
                            local cskilleffectRecord = (((BattleECS.Utility).DataUtility).cSkillEffectTable)[skillEffectId]
                            if not cskilleffectRecord then
                              LogErrorFormat("BattleWorld", "cskilleffect dont have effectid:%s", v)
                            end
                            if max < cskilleffectRecord.fraps + component._startAnimationDelayTime then
                              max = cskilleffectRecord.fraps + component._startAnimationDelayTime
                            end
                            if max < cskilleffectRecord.HitFraps + component._startAnimationDelayTime then
                              max = cskilleffectRecord.HitFraps + component._startAnimationDelayTime
                            end
                            max = (math.max)(max, cskilleffectRecord.effecttime)
                            ;
                            (table.insert)(component._typeMineEffectAtkList, {effectid = skillEffectId, hittedEntityID = 0})
                          end
                        end
                        component._useSkillEntityID = useSkillEntityID
                        component._flyNeedDestroyMaxFrap = max + endAnimationFrames
                        component._skillID = skillid
                        return hasEffect
                      end
                      do
                        if (((BattleECS.Utility).Utility).IsYingXiSkill)(skillid) then
                          entity:AddComponent((BattleECS.Components).TypeComponent)
                          component._useSkillEntityID = useSkillEntityID
                          component._flyNeedDestroyMaxFrap = 0
                          component._skillID = skillid
                          component._attackEntityList = hittedEntityList
                          return 
                        end
                        local hittedEntityID = (hittedEntityList[createIndex])._entityId
                        ;
                        (entity:AddComponent((BattleECS.Components).TypeComponent))._camp = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._camp
                        do
                          local effect = ((((BattleECS.Utility).DataUtility).cSkillBehaviorTable)[skillid]).typeMineEffectAtk
                          for index,v in ipairs(effect) do
                            local skillEffectId = v
                            if (((BattleECS.Utility).Utility).IsLingShouChongJi)(skillid) then
                              local vTable = effect[index]
                              local typePowerNum = 0
                              if ((((BattleECS.Utility).DataUtility).cSkillCostTable)[skillid]).ChaosCost ~= 0 then
                                typePowerNum = ((useSkillEntitySkillComponent._skillCostPowerList)[skillid]).blue
                              else
                                if ((((BattleECS.Utility).DataUtility).cSkillCostTable)[skillid]).OrderCost ~= 0 then
                                  typePowerNum = ((useSkillEntitySkillComponent._skillCostPowerList)[skillid]).red
                                end
                              end
                              if typePowerNum >= index then
                                do
                                  local randomNum = (self._randomPcg)(1, #vTable)
                                  skillEffectId = vTable[randomNum]
                                  if type(skillEffectId) ~= "number" then
                                    LogErrorFormat("BattleWorld", "- DataUtility.cSkillBehaviorTable.typeMineEffectAtk[%s]  is  %s", skillid, type(skillEffectId))
                                  end
                                  local curPrefabName = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._oriShapePrefabName
                                  skillEffectId = (((BattleECS.Utility).Utility).GetSkinSkillChangeEffectId)(curPrefabName, skillEffectId)
                                  if skillEffectId then
                                    hasEffect = true
                                    local cskilleffectRecord = (((BattleECS.Utility).DataUtility).cSkillEffectTable)[skillEffectId]
                                    if not cskilleffectRecord then
                                      LogErrorFormat("BattleWorld", "cskilleffect dont have effectid:%s", v)
                                    end
                                    ;
                                    (table.insert)(component._typeMineEffectAtkList, {effectid = skillEffectId, hittedEntityID = hittedEntityID})
                                    if max < cskilleffectRecord.HitFraps + component._startAnimationDelayTime then
                                      max = cskilleffectRecord.HitFraps + component._startAnimationDelayTime
                                    end
                                    max = (math.max)(max, cskilleffectRecord.effecttime)
                                  end
                                  do
                                    -- DECOMPILER ERROR at PC530: LeaveBlock: unexpected jumping out DO_STMT

                                    -- DECOMPILER ERROR at PC530: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC530: LeaveBlock: unexpected jumping out IF_STMT

                                    -- DECOMPILER ERROR at PC530: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC530: LeaveBlock: unexpected jumping out IF_STMT

                                  end
                                end
                              end
                            end
                          end
                          effect = ((((BattleECS.Utility).DataUtility).cSkillBehaviorTable)[skillid]).flightPropEffectAtk
                          for _,v in ipairs(effect) do
                            local skillEffectId = v
                            if type(skillEffectId) ~= "number" then
                              LogErrorFormat("BattleWorld", "- DataUtility.cSkillBehaviorTable.flightPropEffectAtk[%s]  is  %s", skillid, type(skillEffectId))
                            end
                            local curPrefabName = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._oriShapePrefabName
                            skillEffectId = (((BattleECS.Utility).Utility).GetSkinSkillChangeEffectId)(curPrefabName, skillEffectId)
                            if skillEffectId then
                              hasEffect = true
                              local cskilleffectRecord = (((BattleECS.Utility).DataUtility).cSkillEffectTable)[skillEffectId]
                              if not cskilleffectRecord then
                                LogErrorFormat("BattleWorld", "cskilleffect dont have effectid:%s", v)
                              end
                              if max < cskilleffectRecord.fraps + component._startAnimationDelayTime then
                                max = cskilleffectRecord.fraps + component._startAnimationDelayTime
                              end
                              if ((((BattleECS.Utility).DataUtility).cskillTable)[skillid]).attackOrderToEmery == 5 then
                                local selfHittedEntityList = (((BattleECS.Utility).Utility).GetSkillEffectEntity)(skillid, useSkillEntityID, self)
                                hittedEntityID = (selfHittedEntityList[createIndex])._entityId
                                ;
                                (table.insert)(component._flightPropEffectAtk, {effectid = skillEffectId, hittedEntityID = hittedEntityID})
                              else
                                do
                                  do
                                    ;
                                    (table.insert)(component._flightPropEffectAtk, {effectid = skillEffectId, hittedEntityID = hittedEntityID})
                                    -- DECOMPILER ERROR at PC626: LeaveBlock: unexpected jumping out DO_STMT

                                    -- DECOMPILER ERROR at PC626: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                    -- DECOMPILER ERROR at PC626: LeaveBlock: unexpected jumping out IF_STMT

                                    -- DECOMPILER ERROR at PC626: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC626: LeaveBlock: unexpected jumping out IF_STMT

                                  end
                                end
                              end
                            end
                          end
                          effect = ((((BattleECS.Utility).DataUtility).cSkillBehaviorTable)[skillid]).invalidEffectAtk
                          for _,v in ipairs(effect) do
                            local skillEffectId = v
                            if type(skillEffectId) ~= "number" then
                              LogErrorFormat("BattleWorld", "- %- DataUtility.cSkillBehaviorTable.invalidEffectAtk[%s]  is  %s", skillid, type(skillEffectId))
                            end
                            local curPrefabName = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._oriShapePrefabName
                            skillEffectId = (((BattleECS.Utility).Utility).GetSkinSkillChangeEffectId)(curPrefabName, skillEffectId)
                            if skillEffectId then
                              local cskilleffectRecord = (((BattleECS.Utility).DataUtility).cSkillEffectTable)[skillEffectId]
                              if not cskilleffectRecord then
                                LogErrorFormat("BattleWorld", "cskilleffect dont have effectid:%s", v)
                              end
                              if max < cskilleffectRecord.fraps + component._startAnimationDelayTime then
                                max = cskilleffectRecord.fraps + component._startAnimationDelayTime
                              end
                              if max < cskilleffectRecord.HitFraps + component._startAnimationDelayTime then
                                max = cskilleffectRecord.HitFraps + component._startAnimationDelayTime
                              end
                              ;
                              (table.insert)(component._invalidEffectAtkList, {effectid = skillEffectId, hittedEntityID = hittedEntityID})
                            end
                          end
                          effect = ((((BattleECS.Utility).DataUtility).cSkillBehaviorTable)[skillid]).noColliderEffectAtk
                          for _,v in ipairs(effect) do
                            local skillEffectId = v
                            if type(skillEffectId) ~= "number" then
                              LogErrorFormat("BattleWorld", "- DataUtility.cSkillBehaviorTable.noColliderEffectAtk[%s]  is  %s", skillid, type(skillEffectId))
                            end
                            local curPrefabName = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._oriShapePrefabName
                            skillEffectId = (((BattleECS.Utility).Utility).GetSkinSkillChangeEffectId)(curPrefabName, skillEffectId)
                            if skillEffectId then
                              hasEffect = true
                              local cskilleffectRecord = (((BattleECS.Utility).DataUtility).cSkillEffectTable)[skillEffectId]
                              if not cskilleffectRecord then
                                LogErrorFormat("BattleWorld", "cskilleffect dont have effectid:%s", v)
                              end
                              ;
                              (table.insert)(component._noColliderEffectList, {effectid = skillEffectId, hittedEntityID = hittedEntityID})
                              if max < cskilleffectRecord.HitFraps + component._startAnimationDelayTime then
                                max = cskilleffectRecord.HitFraps + component._startAnimationDelayTime
                              end
                            end
                          end
                          effect = ((((BattleECS.Utility).DataUtility).cSkillBehaviorTable)[skillid]).WarningEffect
                          for _,v in ipairs(effect) do
                            local skillEffectId = v
                            if type(skillEffectId) ~= "number" then
                              LogErrorFormat("BattleWorld", "- DataUtility.cSkillBehaviorTable.WarningEffect[%s]  is  %s", skillid, type(skillEffectId))
                            end
                            local curPrefabName = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._oriShapePrefabName
                            skillEffectId = (((BattleECS.Utility).Utility).GetSkinSkillChangeEffectId)(curPrefabName, skillEffectId)
                            if skillEffectId then
                              local cskilleffectRecord = (((BattleECS.Utility).DataUtility).cSkillEffectTable)[skillEffectId]
                              if not cskilleffectRecord then
                                LogErrorFormat("BattleWorld", "cskilleffect dont have effectid:%s", v)
                              end
                              ;
                              (table.insert)(component._warningEffectList, {effectid = skillEffectId, hittedEntityID = hittedEntityID})
                            end
                          end
                          component._useSkillEntityID = useSkillEntityID
                          component._flyNeedDestroyMaxFrap = max + endAnimationFrames
                          component._skillID = skillid
                          return hasEffect
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

BattleWorld.ChangeFlySkillEffectRadAndSpeed = function(self, entityid)
  -- function num : 0_44 , upvalues : _ENV
  local entity = nil
  for i,e in ipairs(self._entitys) do
    if e._entityId == entityid then
      entity = e
      break
    end
  end
  do
    if entity then
      local component = entity:GetComponent((BattleECS.Components).FlySkillDataComponent)
      if (component._flyDestination).x ~= fixedpoint(-1) and (component._flyDestination).y ~= fixedpoint(-1) then
        local posComponent = entity:GetComponent((BattleECS.Components).PositionComponent)
        local speed = ((((BattleECS.Utility).DataUtility).cSkillEffectTable)[20104001]).speed
        local camp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
        local delta = {x = (component._flyDestination).x - (posComponent._position).x, y = (component._flyDestination).y - (posComponent._position).y}
        local distance = (fixedpoint.sqrt)((fixedpoint.square)(delta.x / 1000) + (fixedpoint.square)(delta.y / 1000)) * 1000
        if distance == fixedpoint_zero then
          distance = 1
        end
        local cos = delta.y / distance
        local sin = delta.x / distance
        local xSp = speed * sin
        local ySp = speed * cos
        local BodyId = (entity:GetComponent((BattleECS.Components).PhysicsComponent))._box2DBodyID
        -- DECOMPILER ERROR at PC95: Confused about usage of register: R14 in 'UnsetPending'

        ;
        (posComponent._velocity).x = xSp
        -- DECOMPILER ERROR at PC97: Confused about usage of register: R14 in 'UnsetPending'

        ;
        (posComponent._velocity).y = ySp
        component._onceFlyTime = fixedpoint_zero
        component._randomNum = 0
      else
        do
          local tX, tY, num = (((BattleECS.Utility).Utility).GetRandomPosition)(component._randomNum, self._randomPcg)
          local posComponent = entity:GetComponent((BattleECS.Components).PositionComponent)
          local x, y = (posComponent._position).x, (posComponent._position).y
          local camp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
          local speed = ((((BattleECS.Utility).DataUtility).cSkillEffectTable)[20104001]).speed
          if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
            speed = -speed
            local rad, sin = 0, 0
            rad = (((BattleECS.Utility).Utility).ReturnEffectRadByTargetXY)(x, y, tX, tY)
            local xSp = (fixedpoint.abs)(speed * (fixedpoint.sqrt)(1 - (fixedpoint.square)(sin)))
            local ySp = (fixedpoint.abs)(speed * sin)
            if tX < x then
              xSp = -xSp
            end
            if tY < y then
              ySp = -ySp
            end
            local BodyId = (entity:GetComponent((BattleECS.Components).PhysicsComponent))._box2DBodyID
            -- DECOMPILER ERROR at PC181: Confused about usage of register: R17 in 'UnsetPending'

            ;
            (posComponent._velocity).x = xSp
            -- DECOMPILER ERROR at PC183: Confused about usage of register: R17 in 'UnsetPending'

            ;
            (posComponent._velocity).y = ySp
            component._onceFlyTime = (fixedpoint.abs)((x - tX) / xSp) * 33 // 1
            component._randomNum = num
          end
        end
      end
    end
  end
end

BattleWorld.CreateHorizontalUniformSpeedFlyingProp = function(self, effectConfig, skillid, useSkillEntityID, tarEntityID, isInsertOtherPhysicsList, effectid)
  -- function num : 0_45 , upvalues : _ENV
  local useSkillEntity = nil
  for i,e in ipairs(self._entitys) do
    if e._entityId == useSkillEntityID then
      useSkillEntity = e
      break
    end
  end
  do
    local targetEntity = nil
    for i,e in ipairs(self._entitys) do
      if e._entityId == tarEntityID then
        targetEntity = e
        break
      end
    end
    do
      if skillid == 201040 then
        if useSkillEntity then
          local entity = self:NewEntity()
          local camp = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._camp
          ;
          (entity:AddComponent((BattleECS.Components).TypeComponent))._camp = camp
          local position = (useSkillEntity:GetComponent((BattleECS.Components).PositionComponent))._position
          local x = fixedpoint_zero
          local y = fixedpoint_zero
          local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(useSkillEntity)
          local qDPath = (((BattleECS.Utility).Utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, effectConfig.socket)
          if (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
            x = position.x - qDPath.x
            y = position.y + qDPath.y
          else
            if (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
              x = position.x - qDPath.x
              y = position.y + qDPath.y
            else
              x = position.x + qDPath.x
              y = position.y + qDPath.y
            end
          end
          local BodyId = (box2d.newBody)(self._physicsWorld, 2, x, y)
          local speed = 0
          if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
            if (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
              speed = -effectConfig.speed
            else
              speed = effectConfig.speed
            end
          else
            speed = -effectConfig.speed
          end
          local rad, sin = fixedpoint_zero, fixedpoint_zero
          local n = (self._randomPcg)(1, 3)
          local tX, tY = (((BattleECS.Utility).Utility).GetRandomPosition)(n, self._randomPcg)
          rad = (((BattleECS.Utility).Utility).ReturnEffectRadByTargetXY)(x, y, tX, tY)
          local xSp = (fixedpoint.abs)(speed * (fixedpoint.sqrt)(1 - (fixedpoint.square)(sin)))
          local ySp = (fixedpoint.abs)(speed * (sin))
          if tX < x then
            xSp = -xSp
          end
          if tY < y then
            ySp = -ySp
          end
          local component = entity:AddComponent((BattleECS.Components).FlySkillDataComponent)
          component._skillMaxContactNumber = (((BattleECS.Utility).Utility).GetSkillAttackNumber)(skillid)
          component._skillEffectType = (((BattleECS.Components).FlySkillDataComponent).SkillEffectType).FlyProp
          component._shouldBeButByShiKongZhiMen = effectConfig.isCut == 1
          if component._shouldBeButByShiKongZhiMen then
            LogInfoFormat("BattleWorld", "CreateHorizontalUniformSpeedFlyingProp effecid %s isCut %s _shouldBeButByShiKongZhiMen %s", effectConfig.id, effectConfig.isCut, component._shouldBeButByShiKongZhiMen)
          end
          component._onceFlyTime = (fixedpoint.abs)((x - tX) / xSp) * 33 // 1
          component._randomNum = n
          ;
          (box2d.bodySetUserData)(self._physicsWorld, BodyId, {entityid = entity._entityId, camp = camp, skillid = skillid, rad = rad, useskillentityid = useSkillEntityID})
          local colliderData = require("data.battledata.npcshapedata." .. (string.lower)(effectConfig.effectName))
          if colliderData.attackColliserSize or not colliderData.attackColliserOffect then
            local fixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackColliserSize).x, (colliderData.attackColliserSize).y, (colliderData.attackColliserOffect).x, (colliderData.attackColliserOffect).y, rad * fixedpoint(1000), 200, 0, 1000, true, 65535, 65535)
            ;
            (box2d.fixtureSetUserData)(self._physicsWorld, BodyId, fixtureId, {fixid = fixtureId, fixtype = "normal"})
            ;
            (entity:AddComponent((BattleECS.Components).PhysicsComponent))._box2DBodyID = BodyId
            component = entity:AddComponent((BattleECS.Components).PositionComponent)
            -- DECOMPILER ERROR at PC296: Confused about usage of register: R29 in 'UnsetPending'

            -- DECOMPILER ERROR at PC297: Confused about usage of register: R28 in 'UnsetPending'

            ;
            (component._position).x = x
            -- DECOMPILER ERROR at PC301: Confused about usage of register: R29 in 'UnsetPending'

            -- DECOMPILER ERROR at PC302: Confused about usage of register: R28 in 'UnsetPending'

            ;
            (component._velocity).x = xSp
            ;
            (((BattleECS.Utility).ProtocolUtility).SendFlySkill)(entity._entityId, x, y, fixedpoint_zero, effectid, useSkillEntity._entityId, (fixedpoint.floor)(rad * 1000), 0, self)
            if (self._actor_shiKongZhiMen_w)[camp] then
              (((BattleECS.Utility).ProtocolUtility).SendSetClipRectForShiKongZhiMen)(entity._entityId, (self._actor_shiKongZhiMen_w)[camp], (self._actor_shiKongZhiMen_h)[camp], camp, effectConfig.effectName, self, true)
            else
              -- DECOMPILER ERROR at PC347: Confused about usage of register: R28 in 'UnsetPending'

              (self._actor_shiKongZhiMen_effectList)[entity._entityId] = {entityId = entity._entityId, camp = camp, effectName = effectConfig.effectName}
            end
            -- DECOMPILER ERROR at PC356: Confused about usage of register: R28 in 'UnsetPending'

            ;
            (self._actor_shiKongZhiMenRelease_effectList)[entity._entityId] = {entityId = entity._entityId, camp = camp, effectName = effectConfig.effectName}
            -- DECOMPILER ERROR at PC365: Confused about usage of register: R28 in 'UnsetPending'

            ;
            (self._actor_shiKongTingZhi_effectList)[entity._entityId] = {entityId = entity._entityId, camp = camp, effectName = effectConfig.effectName}
            do
              local hasEntity = false
              for i,e in ipairs(self._shape20030FlyBallSet) do
                -- DECOMPILER ERROR at PC376: Confused about usage of register: R34 in 'UnsetPending'

                if e._entityId == entity._entityId then
                  (self._shape20030FlyBallSet)[i] = entity
                  hasEntity = true
                end
              end
              if not hasEntity then
                (table.insert)(self._shape20030FlyBallSet, entity)
              end
              do return  end
              if useSkillEntity and targetEntity then
                local entity = self:NewEntity()
                local camp = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._camp
                ;
                (entity:AddComponent((BattleECS.Components).TypeComponent))._camp = camp
                local component = entity:AddComponent((BattleECS.Components).FlySkillDataComponent)
                component._skillMaxContactNumber = (((BattleECS.Utility).Utility).GetSkillAttackNumber)(skillid)
                component._skillEffectType = (((BattleECS.Components).FlySkillDataComponent).SkillEffectType).FlyProp
                local position = (useSkillEntity:GetComponent((BattleECS.Components).PositionComponent))._position
                local x = 0
                local y = 0
                local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(useSkillEntity)
                local qDPath = (((BattleECS.Utility).Utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, effectConfig.socket)
                -- DECOMPILER ERROR at PC446: Overwrote pending register: R19 in 'AssignReg'

                if (useSkillEntity:GetComponent((sin.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                  x = position.x - qDPath.x
                  y = position.y + qDPath.y
                elseif (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
                  x = position.x - qDPath.x
                  y = position.y + qDPath.y
                else
                  x = position.x + qDPath.x
                  y = position.y + qDPath.y
                end
                local BodyId = (box2d.newBody)(self._physicsWorld, 2, x, y)
                local speed = 0
                if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                  if (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
                    speed = -effectConfig.speed
                  else
                    speed = effectConfig.speed
                  end
                else
                  speed = -effectConfig.speed
                end
                local rad, sin, deg = fixedpoint_zero, fixedpoint_zero, fixedpoint_zero
                if effectConfig.targetsocket ~= "" then
                  rad = (((BattleECS.Utility).Utility).ReturnEffectRad)(useSkillEntity, targetEntity, effectConfig.socket, effectConfig.targetsocket)
                else
                  -- DECOMPILER ERROR at PC543: Overwrote pending register: R21 in 'AssignReg'

                  -- DECOMPILER ERROR at PC544: Overwrote pending register: R20 in 'AssignReg'

                  rad = (((BattleECS.Utility).Utility).ReturnEffectRad)(useSkillEntity, targetEntity, effectConfig.socket)
                end
                if effectConfig.deviationAngleOrNot == 0 then
                  rad = fixedpoint_zero
                end
                LogInfoFormat("BattleWorld", "skillid %s effectid %s rad %s deg %s", skillid, effectConfig.id, rad, deg)
                local xSp = speed * (fixedpoint.sqrt)(1 - (fixedpoint.square)(sin))
                local ySp = speed * sin
                ;
                (box2d.bodySetUserData)(self._physicsWorld, BodyId, {entityid = entity._entityId, camp = camp, skillid = skillid, rad = rad, useskillentityid = useSkillEntityID})
                local colliderData = require("data.battledata.npcshapedata." .. (string.lower)(effectConfig.effectName))
                local fixtureId = 0
                if ((not colliderData.attackColliserSize and colliderData.attackColliserOffect) or colliderData.attackColliserSize) and colliderData.attackColliserOffect then
                  if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                    fixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackColliserSize).x, (colliderData.attackColliserSize).y, (colliderData.attackColliserOffect).x, (colliderData.attackColliserOffect).y, rad * fixedpoint(1000), 200, 0, 1000, true, 65535, 65535)
                  else
                    fixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackColliserSize).x, (colliderData.attackColliserSize).y, -(colliderData.attackColliserOffect).x, (colliderData.attackColliserOffect).y, -rad * fixedpoint(1000), 200, 0, 1000, true, 65535, 65535)
                  end
                  ;
                  (box2d.fixtureSetUserData)(self._physicsWorld, BodyId, fixtureId, {fixid = fixtureId, fixtype = "normal"})
                else
                  local negTag = -1
                  if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                    negTag = 1
                  end
                  fixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, 1000, 1000, 1000 * negTag, 1000, rad * fixedpoint(1000) * negTag, 200, 0, 1000, true, 65535, 65535)
                  ;
                  (box2d.fixtureSetUserData)(self._physicsWorld, BodyId, fixtureId, {fixid = fixtureId, fixtype = "lucency"})
                end
                ;
                (entity:AddComponent((BattleECS.Components).PhysicsComponent))._box2DBodyID = BodyId
                component = entity:AddComponent((BattleECS.Components).PositionComponent)
                -- DECOMPILER ERROR at PC723: Confused about usage of register: R27 in 'UnsetPending'

                -- DECOMPILER ERROR at PC724: Confused about usage of register: R26 in 'UnsetPending'

                ;
                (component._position).x = x
                -- DECOMPILER ERROR at PC728: Confused about usage of register: R27 in 'UnsetPending'

                -- DECOMPILER ERROR at PC729: Confused about usage of register: R26 in 'UnsetPending'

                ;
                (component._velocity).x = xSp
                if isInsertOtherPhysicsList then
                  (table.insert)(self._otherPhysicsEntityList, entity)
                end
                local isImaged = 0
                if (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
                  isImaged = 1
                end
                ;
                (((BattleECS.Utility).ProtocolUtility).SendFlySkill)(entity._entityId, x, y, position.z, effectid, useSkillEntityID, (fixedpoint.floor)(deg * 1000), isImaged, self)
                if (self._actor_shiKongZhiMen_w)[camp] then
                  (((BattleECS.Utility).ProtocolUtility).SendSetClipRectForShiKongZhiMen)(entity._entityId, (self._actor_shiKongZhiMen_w)[camp], (self._actor_shiKongZhiMen_h)[camp], camp, effectConfig.effectName, self, true)
                else
                  -- DECOMPILER ERROR at PC791: Confused about usage of register: R27 in 'UnsetPending'

                  (self._actor_shiKongZhiMen_effectList)[entity._entityId] = {entityId = entity._entityId, camp = camp, effectName = effectConfig.effectName}
                end
                -- DECOMPILER ERROR at PC800: Confused about usage of register: R27 in 'UnsetPending'

                ;
                (self._actor_shiKongZhiMenRelease_effectList)[entity._entityId] = {entityId = entity._entityId, camp = camp, effectName = effectConfig.effectName}
                -- DECOMPILER ERROR at PC809: Confused about usage of register: R27 in 'UnsetPending'

                ;
                (self._actor_shiKongTingZhi_effectList)[entity._entityId] = {entityId = entity._entityId, camp = camp, effectName = effectConfig.effectName}
              end
              -- DECOMPILER ERROR: 30 unprocessed JMP targets
            end
          end
        end
      end
    end
  end
end

BattleWorld.CreateConfirmPositionProp = function(self, effectConfig, skillid, useSkillEntity, x, y, z, skillEntity, effectid, isAddHit)
  -- function num : 0_46 , upvalues : _ENV
  local entity = (self:NewEntity())
  local camp = nil
  if (((BattleECS.Utility).Utility).GetSkillEffectCamp)(skillid) == (((BattleECS.Utility).Utility).SkillEffectCampType).OwnSide and not (((BattleECS.Utility).Utility).IsShiKongZhiMen)(skillid) then
    camp = (((BattleECS.Components).TypeComponent).CampType).Both
  else
    camp = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._camp
  end
  local component = entity:AddComponent((BattleECS.Components).TypeComponent)
  component._camp = camp
  component._bindingSkillID = skillid
  component = entity:AddComponent((BattleECS.Components).PositionComponent)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R13 in 'UnsetPending'

  ;
  (component._position).x = x
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R13 in 'UnsetPending'

  ;
  (component._position).y = y
  component = entity:AddComponent((BattleECS.Components).FlySkillDataComponent)
  component._skillMaxContactNumber = (((BattleECS.Utility).Utility).GetSkillAttackNumber)(skillid)
  component._colliderLifeTime = effectConfig.lifeTime
  component._shouldBeButByShiKongZhiMen = effectConfig.isCut == 1
  if component._shouldBeButByShiKongZhiMen then
    LogInfoFormat("BattleWorld", "CreateConfirmPositionProp effecid %s isCut %s _shouldBeButByShiKongZhiMen %s", effectConfig.id, effectConfig.isCut, component._shouldBeButByShiKongZhiMen)
  end
  if skillEntity and isAddHit then
    entity:AddComponent((BattleECS.Components).PhysicsComponent)
    entity:AddComponent((BattleECS.Components).AnimationEventComponent)
    local hasFlyEntity = false
    for _,v in ipairs((skillEntity:GetComponent((BattleECS.Components).SkillEffectComponent))._flyEntityList) do
      if v.entityId == entity._entityId then
        v.hitFraps = effectConfig.HitFraps
        hasFlyEntity = true
      end
    end
    if not hasFlyEntity then
      (table.insert)((skillEntity:GetComponent((BattleECS.Components).SkillEffectComponent))._flyEntityList, {entityId = entity._entityId, hitFraps = effectConfig.HitFraps})
    end
  end
  local isImaged = 0
  if (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
    isImaged = 1
  end
  ;
  (((BattleECS.Utility).ProtocolUtility).SendFlySkill)(entity._entityId, x, y, z, effectid, useSkillEntity._entityId, 0, isImaged, self)
  if not isAddHit then
    (entity:GetComponent((BattleECS.Components).TypeComponent))._isNeedDestroy = true
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

BattleWorld.AddBoxBodyToEntity = function(self, effectConfig, skillid, useSkillEntity, x, y, flyEntityId)
  -- function num : 0_47 , upvalues : _ENV
  local camp = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._camp
  if (((BattleECS.Utility).Utility).GetSkillEffectCamp)(skillid) == (((BattleECS.Utility).Utility).SkillEffectCampType).OwnSide and not (((BattleECS.Utility).Utility).IsShiKongZhiMen)(skillid) then
    camp = (((BattleECS.Components).TypeComponent).CampType).Both
  end
  local entity = nil
  for i,e in ipairs(self._entitys) do
    if e._entityId == flyEntityId then
      entity = e
      break
    end
  end
  do
    if entity then
      local colliderData = require("data.battledata.npcshapedata." .. (string.lower)(effectConfig.effectName))
      if colliderData.attackColliserSize or not colliderData.attackColliserOffect then
        local BodyId = 0
        if (((BattleECS.Utility).Utility).IsShiKongZhiMen)(skillid) then
          BodyId = (box2d.newBody)(self._physicsWorld, 2, x, y)
          ;
          (box2d.bodySetUserData)(self._physicsWorld, BodyId, {entityid = entity._entityId, camp = camp, skillid = skillid, rad = 0, useskillentityid = useSkillEntity._entityId})
          local fixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackColliserSize).x, (colliderData.attackColliserSize).y, -(colliderData.attackColliserOffect).x, (colliderData.attackColliserOffect).y, 0, 200, 0, 1000, true, 65535, 65535)
          ;
          (box2d.fixtureSetUserData)(self._physicsWorld, BodyId, fixtureId, {fixid = fixtureId, fixtype = "hitted"})
          -- DECOMPILER ERROR at PC134: Confused about usage of register: R12 in 'UnsetPending'

          if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
            (self._actor_shiKongZhiMen_entityId)[(((BattleECS.Components).TypeComponent).CampType).Left] = entity._entityId
            -- DECOMPILER ERROR at PC143: Confused about usage of register: R12 in 'UnsetPending'

            ;
            (self._actor_shiKongZhiMen_w)[(((BattleECS.Components).TypeComponent).CampType).Left] = (colliderData.attackColliserSize).x
            -- DECOMPILER ERROR at PC152: Confused about usage of register: R12 in 'UnsetPending'

            ;
            (self._actor_shiKongZhiMen_h)[(((BattleECS.Components).TypeComponent).CampType).Left] = (colliderData.attackColliserSize).y
            for _,v in pairs(self._actor_shiKongZhiMen_effectList) do
              if v.camp == (((BattleECS.Components).TypeComponent).CampType).Left then
                (((BattleECS.Utility).ProtocolUtility).SendSetClipRectForShiKongZhiMen)(v.entityId, (self._actor_shiKongZhiMen_w)[v.camp], (self._actor_shiKongZhiMen_h)[v.camp], v.camp, v.effectName, self, true)
              end
            end
            self._actor_shiKongZhiMen_effectList = {}
          else
            -- DECOMPILER ERROR at PC200: Confused about usage of register: R12 in 'UnsetPending'

            if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
              (self._actor_shiKongZhiMen_entityId)[(((BattleECS.Components).TypeComponent).CampType).Right] = entity._entityId
              -- DECOMPILER ERROR at PC209: Confused about usage of register: R12 in 'UnsetPending'

              ;
              (self._actor_shiKongZhiMen_w)[(((BattleECS.Components).TypeComponent).CampType).Right] = (colliderData.attackColliserSize).x
              -- DECOMPILER ERROR at PC218: Confused about usage of register: R12 in 'UnsetPending'

              ;
              (self._actor_shiKongZhiMen_h)[(((BattleECS.Components).TypeComponent).CampType).Right] = (colliderData.attackColliserSize).y
              for _,v in pairs(self._actor_shiKongZhiMen_effectList) do
                if v.camp == (((BattleECS.Components).TypeComponent).CampType).Right then
                  (((BattleECS.Utility).ProtocolUtility).SendSetClipRectForShiKongZhiMen)(v.entityId, (self._actor_shiKongZhiMen_w)[v.camp], (self._actor_shiKongZhiMen_h)[v.camp], v.camp, v.effectName, self, true)
                end
              end
              self._actor_shiKongZhiMen_effectList = {}
            end
          end
        else
          do
            BodyId = (box2d.newBody)(self._physicsWorld, 2, x, y)
            ;
            (box2d.bodySetUserData)(self._physicsWorld, BodyId, {entityid = entity._entityId, camp = camp, skillid = skillid, rad = 0, useskillentityid = useSkillEntity._entityId})
            do
              local fixtureId = 0
              if camp == (((BattleECS.Components).TypeComponent).CampType).Left or camp == (((BattleECS.Components).TypeComponent).CampType).Both then
                if (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged or effectConfig.id == 601110103 then
                  fixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackColliserSize).x, (colliderData.attackColliserSize).y, -(colliderData.attackColliserOffect).x, (colliderData.attackColliserOffect).y, 0, 200, 0, 1000, true, 65535, 65535)
                else
                  fixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackColliserSize).x, (colliderData.attackColliserSize).y, (colliderData.attackColliserOffect).x, (colliderData.attackColliserOffect).y, 0, 200, 0, 1000, true, 65535, 65535)
                end
              else
                fixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackColliserSize).x, (colliderData.attackColliserSize).y, -(colliderData.attackColliserOffect).x, (colliderData.attackColliserOffect).y, 0, 200, 0, 1000, true, 65535, 65535)
              end
              ;
              (box2d.fixtureSetUserData)(self._physicsWorld, BodyId, fixtureId, {fixid = fixtureId, fixtype = "normal"})
              local component = entity:GetComponent((BattleECS.Components).PhysicsComponent)
              if component then
                component._box2DBodyID = BodyId
                if effectConfig.isFollow == 1 then
                  component._isChangePositionToUseSkillEntity = true
                  component._useSkillEntityEntityID = useSkillEntity._entityId
                  local record = (useSkillEntity:GetComponent((BattleECS.Components).PositionComponent))._position
                  component = entity:GetComponent((BattleECS.Components).PositionComponent)
                  -- DECOMPILER ERROR at PC404: Confused about usage of register: R13 in 'UnsetPending'

                  ;
                  (component._toUseSkillEntityPositonDeltaPosition).x = x - record.x
                  -- DECOMPILER ERROR at PC408: Confused about usage of register: R13 in 'UnsetPending'

                  ;
                  (component._toUseSkillEntityPositonDeltaPosition).y = y - record.y
                end
              else
                do
                  LogErrorFormat("BattleWorld", "AddBoxBodyToEntity no PhysicsComponent in this entity id %s", flyEntityId)
                  ;
                  (entity:GetComponent((BattleECS.Components).FlySkillDataComponent))._skillEffectType = (((BattleECS.Components).FlySkillDataComponent).SkillEffectType).ConfirmProp
                  if effectConfig.animationName and effectConfig.animationName ~= "" then
                    (entity:GetComponent((BattleECS.Components).FlySkillDataComponent))._skillEffectType = (((BattleECS.Components).FlySkillDataComponent).SkillEffectType).ConfirmFlyProp
                    local animationData = require("data.battledata.animation." .. (string.lower)(effectConfig.animationName))
                    local inComponent = entity:GetComponent((BattleECS.Components).AnimationEventComponent)
                    if inComponent then
                      (((BattleECS.Utility).AnimationUtility).IntegrateChangePositionData)(entity, (string.lower)(effectConfig.animationName))
                    else
                      LogErrorFormat("BattleWorld", "AddBoxBodyToEntity with effectConfig.animationName no AnimationEventComponent in this entity id %s", flyEntityId)
                    end
                    ;
                    (table.insert)(self._playerSkillEffectEntityList, entity)
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

BattleWorld.CreateParaBaloSkill = function(self, useSkillEntityID, tarEntityID, effectConfig, skillid)
  -- function num : 0_48 , upvalues : _ENV
  local useSkillEntity = nil
  for i,e in ipairs(self._entitys) do
    if e._entityId == useSkillEntityID then
      useSkillEntity = e
      break
    end
  end
  do
    local tarEntity = nil
    for i,e in ipairs(self._entitys) do
      if e._entityId == tarEntityID then
        tarEntity = e
        break
      end
    end
    do
      if useSkillEntity and tarEntity then
        local entity = self:NewEntity()
        local camp = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._camp
        ;
        (entity:AddComponent((BattleECS.Components).TypeComponent))._camp = camp
        local component = entity:AddComponent((BattleECS.Components).FlySkillDataComponent)
        component._skillEffectType = (((BattleECS.Components).FlySkillDataComponent).SkillEffectType).ParaFlyProp
        local position = (useSkillEntity:GetComponent((BattleECS.Components).PositionComponent))._position
        local x = 0
        local y = 0
        local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(useSkillEntity)
        local qDPath = (((BattleECS.Utility).Utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, effectConfig.socket)
        if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
          x = position.x - qDPath.x
          y = position.y + qDPath.y
        else
          if (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
            x = position.x - qDPath.x
            y = position.y + qDPath.y
          else
            x = position.x + qDPath.x
            y = position.y + qDPath.y
          end
        end
        local BodyId = (box2d.newBody)(self._physicsWorld, 2, x, y)
        local speed = fixedpoint_zero
        if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
          if (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
            speed = fixedpoint(-effectConfig.speed)
          else
            speed = fixedpoint(effectConfig.speed)
          end
        else
          speed = fixedpoint(-effectConfig.speed)
        end
        ;
        (box2d.bodySetUserData)(self._physicsWorld, BodyId, {entityid = entity._entityId, camp = camp, skillid = skillid, rad = 0, useskillentityid = useSkillEntityID})
        local colliderData = require("data.battledata.npcshapedata." .. (string.lower)(effectConfig.effectName))
        local fixtureId = 0
        -- DECOMPILER ERROR at PC202: Unhandled construct in 'MakeBoolean' P1

        if (not colliderData.attackColliserSize and colliderData.attackColliserOffect) or camp == (((BattleECS.Components).TypeComponent).CampType).Left then
          fixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackColliserSize).x, (colliderData.attackColliserSize).y, (colliderData.attackColliserOffect).x, (colliderData.attackColliserOffect).y, 0, 200, 0, 1000, true, 65535, 65535)
        else
          fixtureId = (box2d.newBoxShapeFixture)(self._physicsWorld, BodyId, (colliderData.attackColliserSize).x, (colliderData.attackColliserSize).y, -(colliderData.attackColliserOffect).x, (colliderData.attackColliserOffect).y, 0, 200, 0, 1000, true, 65535, 65535)
        end
        ;
        (box2d.fixtureSetUserData)(self._physicsWorld, BodyId, fixtureId, {fixid = fixtureId, fixtype = "normal"})
        component = entity:AddComponent((BattleECS.Components).PhysicsComponent)
        component._box2DBodyID = BodyId
        -- DECOMPILER ERROR at PC243: Confused about usage of register: R19 in 'UnsetPending'

        ;
        (component._toTargetCurrentSpeed).x = speed
        local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(tarEntity)
        local targetpoint = (((BattleECS.Utility).Utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, effectConfig.targetsocket)
        local tarCamp = (tarEntity:GetComponent((BattleECS.Components).TypeComponent))._camp
        local tarPos = (tarEntity:GetComponent((BattleECS.Components).PositionComponent))._position
        local tarX = 0
        local tarY = 0
        if tarCamp == (((BattleECS.Components).TypeComponent).CampType).Right then
          tarX = tarPos.x - targetpoint.x
          tarY = tarPos.y + targetpoint.y
        else
          tarX = tarPos.x + targetpoint.x
          tarY = tarPos.y + targetpoint.y
        end
        local deltY = y - (tarY)
        local vY = fixedpoint_zero
        local deltX = x - (tarX)
        local a = fixedpoint(-effectConfig.gAcceleration)
        if deltY > 0 then
          vY = (fixedpoint.abs)(a) * deltX / 2 / (fixedpoint.abs)(speed) - deltY * (fixedpoint.abs)(speed) / deltX
        else
          if deltY == 0 then
            vY = deltX * (fixedpoint.abs)(a) / 2 / (fixedpoint.abs)(speed)
          else
            vY = (fixedpoint.abs)(a) * deltX / 2 / (fixedpoint.abs)(speed) + deltY * (fixedpoint.abs)(speed) / deltX
          end
        end
        -- DECOMPILER ERROR at PC352: Confused about usage of register: R29 in 'UnsetPending'

        ;
        (component._toTargetCurrentSpeed).y = vY
        -- DECOMPILER ERROR at PC354: Confused about usage of register: R29 in 'UnsetPending'

        ;
        (component._toTargetAcceleration).y = a
        -- DECOMPILER ERROR at PC368: Confused about usage of register: R30 in 'UnsetPending'

        -- DECOMPILER ERROR at PC369: Confused about usage of register: R29 in 'UnsetPending'

        ;
        ((entity:AddComponent((BattleECS.Components).PositionComponent))._position).x = x
        ;
        (table.insert)(self._otherPhysicsEntityList, entity)
        local isImaged = 0
        if (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
          isImaged = 1
        end
        ;
        (((BattleECS.Utility).ProtocolUtility).SendFlySkill)(entity._entityId, x, y, position.z, effectConfig.id, useSkillEntityID, 0, isImaged, self)
        if (self._actor_shiKongZhiMen_w)[camp] then
          (((BattleECS.Utility).ProtocolUtility).SendSetClipRectForShiKongZhiMen)(entity._entityId, (self._actor_shiKongZhiMen_w)[camp], (self._actor_shiKongZhiMen_h)[camp], camp, effectConfig.effectName, self, true)
        else
          -- DECOMPILER ERROR at PC426: Confused about usage of register: R30 in 'UnsetPending'

          ;
          (self._actor_shiKongZhiMen_effectList)[entity._entityId] = {entityId = entity._entityId, camp = camp, effectName = effectConfig.effectName}
        end
        -- DECOMPILER ERROR at PC435: Confused about usage of register: R30 in 'UnsetPending'

        ;
        (self._actor_shiKongZhiMenRelease_effectList)[entity._entityId] = {entityId = entity._entityId, camp = camp, effectName = effectConfig.effectName}
        -- DECOMPILER ERROR at PC444: Confused about usage of register: R30 in 'UnsetPending'

        ;
        (self._actor_shiKongTingZhi_effectList)[entity._entityId] = {entityId = entity._entityId, camp = camp, effectName = effectConfig.effectName}
      end
    end
  end
end

BattleWorld.UpdataZero = function(self)
  -- function num : 0_49 , upvalues : _ENV
  (self:GetSystem((BattleECS.Systems).CreateRoleSystem)):Update()
  ;
  (((BattleECS.Utility).ProtocolUtility).SendBattlePowerShow)(self._redPowerMax, self._redPower, self._bluePowerMax, self._bluePower, self)
end

BattleWorld.Update = function(self, deltaTime, unscaledDeltaTime)
  -- function num : 0_50 , upvalues : _ENV
  if self._powerAccumulateState == (self.PowerAccumulateStateType).BreakOut then
    self._breakOutPowerCountFrame = self._breakOutPowerCountFrame + 1
    if tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[96]).attr) <= self._breakOutPowerCountFrame then
      self._breakOutPowerCountFrame = 0
      self._powerBreakOutIncreateSpeed = false
      self._powerAccumulateState = (self.PowerAccumulateStateType).Drain
      ;
      (((BattleECS.Utility).ProtocolUtility).SendAccumulatePowerStateChange)(self._powerAccumulateState, self)
    end
  end
  if self._powerAccumulateState == (self.PowerAccumulateStateType).Drain then
    self._drainPowerCountFrame = self._drainPowerCountFrame + 1
    if tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[97]).attr) <= self._drainPowerCountFrame then
      self._drainPowerCountFrame = 0
      self._powerAccumulateState = (self.PowerAccumulateStateType).Filling
      ;
      (((BattleECS.Utility).ProtocolUtility).SendAccumulatePowerStateChange)(self._powerAccumulateState, self)
    end
  end
  local increasenum = 1
  for _,v in ipairs(self._leftPlayerPowerIncreaseSpeedList) do
    increasenum = (fixedpoint.max)(increasenum, v.speed)
  end
  local increaseSpeed = fixedpoint_zero
  for i,v in ipairs(self._battleWorldPowerIncreaseSpeed) do
    increaseSpeed = increaseSpeed + v.addition * v.stack
  end
  increasenum = increasenum + (increaseSpeed)
  if self._powerBreakOutIncreateSpeed then
    increasenum = increasenum + fixedpoint(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[114]).attr)
  end
  self._redPower = self._redPower + (increasenum)
  self._redPower = (fixedpoint.min)(self._redPower, self._redPowerMax)
  ;
  (((BattleECS.Utility).ProtocolUtility).SendBattlePowerShow)(self._redPowerMax, self._redPower, self._bluePowerMax, self._bluePower, self)
  self._accumulatePower = (math.min)(self._accumulatePower, self._accumulatePowerMax)
  if self._accumulatePowerMax <= self._accumulatePower and self._powerAccumulateState == (self.PowerAccumulateStateType).Filling then
    self._powerAccumulateState = (self.PowerAccumulateStateType).Full
    ;
    (((BattleECS.Utility).ProtocolUtility).SendAccumulatePowerStateChange)(self._powerAccumulateState, self)
  end
  ;
  (self:GetSystem((BattleECS.Systems).CreateRoleSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).FlySkillDataSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).PhysicsSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).BuffSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).SpritePhysicsSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).SkillSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).AnimationSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).AnimationEventSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).SkillEffectSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).DeadDisappearCountSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).BehaviorSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).HpSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).ReleaseSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).RoleDeadCountSystem)):Update()
  ;
  (self:GetSystem((BattleECS.Systems).ViewMoveSystem)):Update()
  self._battleWorldStartFrames = self._battleWorldStartFrames + 1
end

BattleWorld.InsertViewProtocolData = function(self, protocol)
  -- function num : 0_51
  (self._insertData)(protocol)
end

BattleWorld.OnCSkillAct = function(self, protocol)
  -- function num : 0_52 , upvalues : _ENV
  local entity = nil
  for i,e in ipairs(self._entitys) do
    if e._entityId == protocol.entityId then
      entity = e
      break
    end
  end
  do
    if entity then
      if (((BattleECS.Utility).Utility).IsYingXiSkill)(protocol.skillid) and (entity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
        return 
      end
      ;
      (((BattleECS.Utility).Utility).IsRoleCanUseSkill)(entity, protocol.skillid, self)
    else
      LogErrorFormat("BattleWorld", "entityid:%s", protocol.entityId)
    end
  end
end

BattleWorld.OnCBattleKill = function(self, data)
  -- function num : 0_53 , upvalues : _ENV
  local isjoin = 0
  if self._partnerJoinCount > 0 then
    isjoin = 1
  end
  ;
  (((BattleECS.Utility).ProtocolUtility).SendBattleResult)(data.type, isjoin, self)
  ;
  (((BattleECS.Utility).ProtocolUtility).SendBattleEnd)(data.type, isjoin, self)
  LogInfoFormat("BattleWorld", "客户端战斗结束发送kill, type %s", data.type)
end

BattleWorld.OnCPartner = function(self)
  -- function num : 0_54 , upvalues : _ENV
  local partner = self._partnerBattlerData
  local camp = 1
  local Enum_Camp = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
  local bean = (BattleClientProtocolManager.CreateBean)("data.attribute")
  bean.id = partner.id
  ;
  (((BattleECS.Utility).ProtocolUtility).SendPlayBattleVoice)(bean.id, (((BattleECS.Utility).DataUtility).VoiceType).BattleStart, nil, self)
  local posId = 1
  local posCfg = (self._battlePosList)[tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[posId + 49]).attr)]
  local x, y, z = posCfg.x, posCfg.y, posCfg.z
  bean.key = posId
  bean.camp = camp
  local positionTable = {x = fixedpoint_zero, y = fixedpoint_zero, z = fixedpoint_zero}
  do
    if Enum_Camp.LeftFighter == camp then
      local offect = (string.split)(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[30]).attr, ";")
      positionTable.x = x + fixedpoint(offect[1])
      positionTable.y = y + fixedpoint(offect[2])
      positionTable.z = z + fixedpoint(offect[3])
    else
    end
    if Enum_Camp.RightFighter == camp then
      local AttrTypeEnum = (BattleClientProtocolManager.GetBeanDef)("data.attrtype")
      bean.hp = (partner.attrs)[AttrTypeEnum.HP]
      bean.hpmax = (partner.attrs)[AttrTypeEnum.MAX_HP]
      bean.atk = (partner.attrs)[AttrTypeEnum.ATTACK]
      bean.def = (partner.attrs)[AttrTypeEnum.DEFEND]
      bean.mdef = (partner.attrs)[AttrTypeEnum.MAGIC_DEFEND]
      bean.speed = (partner.attrs)[AttrTypeEnum.SPEED]
      bean.damage = (partner.attrs)[AttrTypeEnum.DAMAGE] or 0
      bean.physicalbonus = (partner.attrs)[AttrTypeEnum.PHYSICALBONUS] or 0
      bean.physicalreduce = (partner.attrs)[AttrTypeEnum.PHYSICALREDUCE] or 0
      bean.magicbonus = (partner.attrs)[AttrTypeEnum.MAGICBONUS] or 0
      bean.magicreduce = (partner.attrs)[AttrTypeEnum.MAGICREDUCE] or 0
      bean.physicalcritrate = (partner.attrs)[AttrTypeEnum.CRITRATE] or 0
      bean.physicalcritdegree = (partner.attrs)[AttrTypeEnum.CRITDEGREE] or 0
      bean.attackspeed = (partner.attrs)[AttrTypeEnum.ATTACKSPEED] or 0
      bean.magiclifesteal = (partner.attrs)[AttrTypeEnum.MAGICLIFESTEAL] or 0
      bean.physicallifesteal = (partner.attrs)[AttrTypeEnum.PHYSICALLIFESTEAL] or 0
      bean.physicalevasion = (partner.attrs)[AttrTypeEnum.EVASION] or 0
      bean.physicalblock = (partner.attrs)[AttrTypeEnum.PHYSICALBLOCK] or 0
      bean.magicblock = (partner.attrs)[AttrTypeEnum.MAGICBLOCK] or 0
      bean.physicaldefbreak = (partner.attrs)[AttrTypeEnum.PHYSICALDEFBREAK] or 0
      bean.magicdefbreak = (partner.attrs)[AttrTypeEnum.MAGICDEFBREAK] or 0
      bean.critrateresistance = (partner.attrs)[AttrTypeEnum.CRITRATERESISTANCE] or 0
      bean.critdegreeresistance = (partner.attrs)[AttrTypeEnum.CRITDEGREERESISTANCE] or 0
      bean.extraphysicaldamage = (partner.attrs)[AttrTypeEnum.EXTRAPHYSICALDAMAGE] or 0
      bean.extramagicdamage = (partner.attrs)[AttrTypeEnum.EXTRAMAGICDAMAGE] or 0
      bean.curativebonus = (partner.attrs)[AttrTypeEnum.CURATIVEBONUS] or 0
      bean.accuracy = (partner.attrs)[AttrTypeEnum.ACCURACY] or 0
      bean.critratelevel = (partner.attrs)[AttrTypeEnum.CRIT_LEVEL] or 0
      bean.critdegreelevel = (partner.attrs)[AttrTypeEnum.CRIT_DEGREE_LEVEL] or 0
      bean.healingpower = (partner.attrs)[AttrTypeEnum.HEALING_POWER] or 0
      bean.comborate1 = (partner.attrs)[AttrTypeEnum.COMBORATE1] or 0
      bean.comborate2 = (partner.attrs)[AttrTypeEnum.COMBORATE2] or 0
      bean.damagereduce = (partner.attrs)[AttrTypeEnum.DAMAGE_REDUCE] or 0
      bean.runelv = (partner.attrs)[AttrTypeEnum.RUNE_LV] or 0
      bean.baseskill = partner.baseSkill or 0
      if not partner.passiveSkills then
        bean.passiveskill = {}
        local shapeRecorder = nil
        local cskinRecoder = (((BattleECS.Utility).DataUtility).cSkinTable)[partner.skinId]
        LogInfoFormat("BattleWorld", "partner skinId %s", partner.skinId)
        if cskinRecoder then
          shapeRecorder = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[cskinRecoder.shapeID]
        else
          local roleRecoder = (((BattleECS.Utility).DataUtility).roleConfigTable)[partner.id]
          if not roleRecoder then
            roleRecoder = (((BattleECS.Utility).DataUtility).cMonsterCfgTable)[partner.id]
          end
          shapeRecorder = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[roleRecoder.shapeID]
        end
        do
          bean.assetbundlename = shapeRecorder.assetBundleName
          bean.prefabname = shapeRecorder.prefabName
          for _,v in ipairs(partner.skills) do
            if v ~= 0 then
              (table.insert)(bean.skilllist, v)
            end
          end
          self:CreatePartnerJoin(bean, positionTable)
          self._partnerJoinCount = self._partnerJoinCount + 1
          local protocol = (BattleClientProtocolManager.CreateProtocol)("action.spartner")
          protocol.count = self._partnerJoinCount
          self:InsertViewProtocolData(protocol)
        end
      end
    end
  end
end

BattleWorld.OnCBreakOutPower = function(self, protocol)
  -- function num : 0_55 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_FillInBattlePower, self, {curRedPower = self._redPower, curBluePower = self._bluePower})
  self:AddRedPower(tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[8]).attr))
  self:AddBluePower(tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[9]).attr))
  self._accumulatePower = 0
  self._powerBreakOutIncreateSpeed = true
  self._powerAccumulateState = (self.PowerAccumulateStateType).BreakOut
  for _,entity in ipairs(self._leftPlayerList) do
    local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenBreakOutPower)(entity, self._randomPcg)
    for _,skillStruct in ipairs(skillList) do
      (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(entity, skillStruct, entity)
    end
  end
  for _,entity in ipairs(self._leftPlayerSummonList) do
    local skillList = (((BattleECS.Utility).BuffUtility).IsHasTriggerBuffWhenBreakOutPower)(entity, self._randomPcg)
    for _,skillStruct in ipairs(skillList) do
      (((BattleECS.Utility).Utility).SetSkillComponnetPassiveSkillList)(entity, skillStruct, entity)
    end
  end
  ;
  (((BattleECS.Utility).ProtocolUtility).SendAccumulatePowerStateChange)(self._powerAccumulateState, self)
end

return BattleWorld

