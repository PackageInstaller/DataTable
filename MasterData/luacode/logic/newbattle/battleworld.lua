local World = require("ecs.world")
require("box2d")
BattleECS.Utility.DataUtility.InitConfigTable()
BattleECS.Utility.DataUtility.InitSplitCSkillBuffValue()
BattleECS.Utility.DataUtility.InitCSkillFormulaCfgBattleFormula()
BattleECS.Utility.DataUtility.InitCSkillBattleFormula()
BattleECS.Utility.DataUtility.InitCSkillRateCfgFormula()
BattleECS.Utility.DataUtility.InitCSkillCostCfgFormula()
BattleECS.Utility.DataUtility.InitCSkillbehavior()
BattleECS.Utility.DataUtility.InitCGlobalBuffBattleFormula()
BattleECS.Utility.DataUtility.InitPowerNumType()
local BattleEndType = BattleClientProtocolManager.GetBeanDef("data.battleendtype")
local BattleWorld = strictclass("BattleWorld", World)
BattleWorld.PowerAccumulateStateType = {
  Filling = 1,
  Full = 2,
  BreakOut = 3,
  Drain = 4
}

function BattleWorld:Ctor(fun, battleId, sceneid, battleBuffs, battlePosList)
  BattleWorld.super.Ctor(self)
  self._battleID = battleId
  self._sceneID = sceneid
  self._insertData = fun
  self._battleBuffsList = {}
  for _, v in ipairs(battleBuffs) do
    LogInfoFormat("BattleWorld", "battleBuffs buffid %s num %s", v.id, v.num)
    table.insert(self._battleBuffsList, {
      buffId = v.id,
      count = v.num,
      roleLimit = v.roleLimit
    })
    if not BattleECS.Utility.DataUtility.cGlobalBuffConfigTable[v.id] then
      LogErrorFormat("BattleWorld", "buffid %s is not in cgloballbuffconfig", v.id)
    end
  end
  self._battlePosList = battlePosList
  LogInfoFormat("BattleWorld", "battleid:%s sceneid:%s", self._battleID, self._sceneID)
  self._redPower = fixedpoint_zero
  self._bluePower = fixedpoint_zero
  self._redPowerMax = fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[8].attr) * fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[1].attr)
  self._bluePowerMax = fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[9].attr) * fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[2].attr)
  self._powerBreakOutIncreateSpeed = false
  self._powerAccumulateState = self.PowerAccumulateStateType.Filling
  self._accumulatePower = 0
  self._accumulatePowerMax = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[93].attr)
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
  self._stopBattleWorldTimeCountTotalLeft = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[61].attr)
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

function BattleWorld:Destroy()
  BattleWorld.super.Destroy(self)
  box2d.deleteWorld(self._physicsWorld)
end

function BattleWorld:DestroyPhysicsBody(id)
  box2d.deleteBody(self._physicsWorld, id)
end

function BattleWorld:RemoveOtherPhysicsEntityList(entityid)
  local removeList = {}
  for k = #self._otherPhysicsEntityList, 1, -1 do
    local entity = self._otherPhysicsEntityList[k]
    if entityid == entity._entityId then
      table.insert(removeList, k)
    end
  end
  for _, i in ipairs(removeList) do
    table.remove(self._otherPhysicsEntityList, i)
  end
end

function BattleWorld:Init()
  self:CreatePhysicsWorld()
  self:AddSystem(BattleECS.Systems.BehaviorSystem)
  self:AddSystem(BattleECS.Systems.PhysicsSystem)
  self:AddSystem(BattleECS.Systems.AnimationSystem)
  self:AddSystem(BattleECS.Systems.SkillSystem)
  self:AddSystem(BattleECS.Systems.HpSystem)
  self:AddSystem(BattleECS.Systems.ReleaseSystem)
  self:AddSystem(BattleECS.Systems.SkillEffectSystem)
  self:AddSystem(BattleECS.Systems.ViewMoveSystem)
  self:AddSystem(BattleECS.Systems.SpritePhysicsSystem)
  self:AddSystem(BattleECS.Systems.BuffSystem)
  self:AddSystem(BattleECS.Systems.AnimationEventSystem)
  self:AddSystem(BattleECS.Systems.RoleDeadCountSystem)
  self:AddSystem(BattleECS.Systems.DeadDisappearCountSystem)
  self:AddSystem(BattleECS.Systems.FlySkillDataSystem)
  self:AddSystem(BattleECS.Systems.CreateRoleSystem)
  self:InitCreateUtilityEntity()
end

function BattleWorld:InitCreateUtilityEntity()
  self._createUtilityEntity = self:NewEntity()
  self._createUtilityEntity:AddComponent(BattleECS.Components.CreateRoleComponent)
end

function BattleWorld:SetIsMonsterAllDeadDisapper(flag)
  self._isMonsterAllDeadDisapper = flag
end

function BattleWorld:SetIsAllMonsterStateCanBeBattleEnd(flag)
  self._isAllMonsterStateCanBeBattleEnd = flag
end

function BattleWorld:SetGuardBuffEntityid(camp, id, isRemove)
  if not isRemove then
    if camp == BattleECS.Components.TypeComponent.CampType.Left then
      table.insert(self._guardBuffLeftEntityidPool, id)
      self._guardBuffLeftEntityid = id
    elseif camp == BattleECS.Components.TypeComponent.CampType.Right then
      table.insert(self._guardBuffRightEntityidPool, id)
      self._guardBuffRightEntityid = id
    end
  elseif camp == BattleECS.Components.TypeComponent.CampType.Left then
    local index = table.indexof(self._guardBuffLeftEntityidPool, id)
    if not index then
      LogErrorFormat("BattleWorld", "GuardBuffLeftEntityidGroup Not Exist %s", id)
    else
      table.remove(self._guardBuffLeftEntityidPool, index)
      if #self._guardBuffLeftEntityidPool > 0 then
        self._guardBuffLeftEntityid = self._guardBuffLeftEntityidPool[#self._guardBuffLeftEntityidPool]
      else
        self._guardBuffLeftEntityid = 0
      end
    end
  elseif camp == BattleECS.Components.TypeComponent.CampType.Right then
    local index = table.indexof(self._guardBuffRightEntityidPool, id)
    if not index then
      LogErrorFormat("BattleWorld", "GuardBuffRightEntityidGroup Not Exist %s", id)
    else
      table.remove(self._guardBuffRightEntityidPool, index)
      if #self._guardBuffRightEntityidPool > 0 then
        self._guardBuffRightEntityid = self._guardBuffRightEntityidPool[#self._guardBuffRightEntityidPool]
      else
        self._guardBuffRightEntityid = 0
      end
    end
  end
end

function BattleWorld:SetAssistData(data)
  self._partnerBattlerData = data
end

function BattleWorld:SetRandomSeed(seed)
  self._randomSeed = seed
  LogInfoFormat("BattleWorld", "randomseed:%s", self._randomSeed)
  self._randomPcg = pcg.create(self._randomSeed)
end

function BattleWorld:AddBattleCount()
  self._isStopBattleWorldTimeCount = self._isStopBattleWorldTimeCount + 1
end

function BattleWorld:SetIsJoin(state)
  self._isJoin = state
end

function BattleWorld:SetIsLeftGMInvincible(flag)
  self._isLeftGMInvincible = flag
end

function BattleWorld:SetIsRightGMInvincible(flag)
  self._isRightGMInvincible = flag
end

function BattleWorld:GetIsLeftGMInvincible()
  return self._isLeftGMInvincible
end

function BattleWorld:GetIsRightGMInvincible()
  return self._isRightGMInvincible
end

function BattleWorld:FullEnergyPower()
  self._accumulatePower = self._accumulatePowerMax
end

function BattleWorld:SetRightCampSkillInterruptedTime(num)
  self._rightCampSkillInterruptedTime = num
end

function BattleWorld:GetRightCampSkillInterruptedTime()
  return self._rightCampSkillInterruptedTime
end

function BattleWorld:AddRedPower(num)
  self._redPower = self._redPower + num * fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[1].attr)
  self._redPower = fixedpoint.min(self._redPower, self._redPowerMax)
  self._redPower = fixedpoint.max(self._redPower, 0)
end

function BattleWorld:AddBluePower(num)
  self._bluePower = self._bluePower + num * fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[2].attr)
  self._bluePower = fixedpoint.min(self._bluePower, self._bluePowerMax)
  self._bluePower = fixedpoint.max(self._bluePower, 0)
end

function BattleWorld:GetBattleCount()
  return self._isStopBattleWorldTimeCount
end

function BattleWorld:SetCampWinState(winCamp)
  self._campWinState = winCamp
end

function BattleWorld:GetCampWinState()
  return self._campWinState
end

function BattleWorld:SetWorldState(str)
  self._worldState = str
end

function BattleWorld:GetWorldState()
  return self._worldState
end

function BattleWorld:SetLeftLineupInfo(list)
  self._leftLineupInfo = list
end

function BattleWorld:GetElementNumFromLeftLine(elementType)
  if not self._leftLineupInfo.element then
    LogError("BattleWorld", "leftLineupInfo.element is nil")
    return 0
  end
  local result = self._leftLineupInfo.element[4] or 0
  if elementType ~= 4 then
    local addnum = self._leftLineupInfo.element[elementType] or 0
    result = result + addnum
  end
  return result
end

function BattleWorld:GetVocationNumFromLeftLine(vocationType)
  if not self._leftLineupInfo.vocation then
    LogError("BattleWorld", "leftLineupInfo.vocation is nil")
    return 0
  end
  local result = self._leftLineupInfo.vocation[7] or 0
  if vocationType ~= 7 then
    local addnum = self._leftLineupInfo.vocation[vocationType] or 0
    result = result + addnum
  end
  return result
end

function BattleWorld:CreatePhysicsWorld()
  self._physicsWorld = box2d.newWorld(0, -1000)
  local landBodyId = box2d.newBody(self._physicsWorld, 0, 0, 0)
  box2d.bodySetUserData(self._physicsWorld, landBodyId, {
    entityid = 0,
    camp = 0,
    skillid = 0,
    rad = 0,
    useskillentityid = 0
  })
  local landFixtureId = 0
  if self._battleID == 1122 then
    landFixtureId = box2d.newEdgeShapeFixture(self._physicsWorld, landBodyId, -10000, 266, 10000, 266, 200, 0, 1000, false, 65535, 65535)
  elseif self._battleID == 1127 then
    landFixtureId = box2d.newEdgeShapeFixture(self._physicsWorld, landBodyId, -10000, -50, 10000, -50, 200, 0, 1000, false, 65535, 65535)
  else
    landFixtureId = box2d.newEdgeShapeFixture(self._physicsWorld, landBodyId, -10000, -7930, 10000, -7930, 200, 0, 1000, false, 65535, 65535)
  end
  box2d.fixtureSetUserData(self._physicsWorld, landBodyId, landFixtureId, {fixtype = "land"})
  landFixtureId = box2d.newEdgeShapeFixture(self._physicsWorld, landBodyId, -10000, -10000, -10000, 10000, 200, 0, 1000, false, 65535, 65535)
  box2d.fixtureSetUserData(self._physicsWorld, landBodyId, landFixtureId, {fixtype = "land"})
  landFixtureId = box2d.newEdgeShapeFixture(self._physicsWorld, landBodyId, 10000, -10000, 10000, 10000, 200, 0, 1000, false, 65535, 65535)
  box2d.fixtureSetUserData(self._physicsWorld, landBodyId, landFixtureId, {fixtype = "land"})
  landFixtureId = box2d.newEdgeShapeFixture(self._physicsWorld, landBodyId, -10000, 9000, 10000, 9000, 200, 0, 1000, false, 65535, 65535)
  box2d.fixtureSetUserData(self._physicsWorld, landBodyId, landFixtureId, {fixtype = "land"})
end

function BattleWorld:GetBatterIndex()
  return table.nums(self._leftPlayerList) + table.nums(self._leftPlayerSummonList) + table.nums(self._rightPlayerList) + table.nums(self._rightPlayerSummonList)
end

function BattleWorld:GetRightPlayerList()
  return self._rightPlayerList
end

function BattleWorld:GetLeftPlayerList()
  return self._leftPlayerList
end

function BattleWorld:IfNoCreatingPlayer()
  local component = self._createUtilityEntity:GetComponent(BattleECS.Components.CreateRoleComponent)
  if #component._playerInfoList ~= 0 then
    LogInfoFormat("BattleWorld", "component._playerInfoList number %s", #component._playerInfoList)
  end
  return #component._playerInfoList == 0
end

function BattleWorld:CreateLeftPlayer(playerInfo, additionalInfo)
  local component = self._createUtilityEntity:GetComponent(BattleECS.Components.CreateRoleComponent)
  if additionalInfo then
    table.insert(component._playerInfoList, {
      playerInfo = playerInfo,
      camp = BattleECS.Components.TypeComponent.CampType.Left,
      isInitial = additionalInfo.isInitial,
      alternateFighterBean = additionalInfo.alternateFighterBean
    })
  else
    table.insert(component._playerInfoList, {
      playerInfo = playerInfo,
      camp = BattleECS.Components.TypeComponent.CampType.Left
    })
  end
end

function BattleWorld:RevivePlayer(entityid)
  local entity
  for i, e in ipairs(self._entitys) do
    if e._entityId == entityid then
      entity = e
      break
    end
  end
  if entity then
    BattleECS.Utility.PhysicsUtility.SetEntityPhyscisComponentAwake(entity, true)
    local component = entity:GetComponent(BattleECS.Components.PositionComponent)
    component._position.x = entity:GetComponent(BattleECS.Components.PositionComponent)._targetPos.x
    component._position.y = entity:GetComponent(BattleECS.Components.PositionComponent)._targetPos.y
    BattleECS.Utility.PhysicsUtility.SetEntityPosition(self._physicsWorld, entity, component._position.x, component._position.y)
    BattleECS.Utility.BuffUtility.RevivePlayerBuffState(entity)
    component = entity:GetComponent(BattleECS.Components.AnimationEventComponent)
    component._roleIsInPositionChangeAnimationData = {}
    local ifIgnorePriority = {No = 0, Yes = 1}
    BattleECS.Utility.ProtocolUtility.SendBattlerPlayAnimationByNameProtocol(entity, "Revive", ifIgnorePriority.No, self)
    local attribute = {}
    component = entity:GetComponent(BattleECS.Components.HpComponent)
    attribute.hp = fixedpoint.tonumber(component._currentHp)
    attribute.hpmax = fixedpoint.tonumber(component._maxHp)
    BattleECS.Utility.ProtocolUtility.SendRoleCreate(entity._entityId, 1, attribute, {}, nil, self)
    BattleECS.Utility.ProtocolUtility.SendPlayBattleVoice(entity:GetComponent(BattleECS.Components.TypeComponent)._roleID, BattleECS.Utility.DataUtility.VoiceType.Revive, nil, self)
  end
end

function BattleWorld:SetLeftPlayerPositionAndImaged(entityid, x, y, isImaged)
  local entity
  for i, e in ipairs(self._entitys) do
    if e._entityId == entityid then
      entity = e
      break
    end
  end
  if entity then
    local component = entity:GetComponent(BattleECS.Components.PositionComponent)
    component._position.x = x
    component._position.y = y
    BattleECS.Utility.PhysicsUtility.SetEntityPosition(self._physicsWorld, entity, x, y)
    entity:GetComponent(BattleECS.Components.TypeComponent)._isImaged = isImaged
    BattleECS.Utility.PhysicsUtility.SetEntityPhyscisComponentAwake(entity, not isImaged)
  end
end

function BattleWorld:ChangeLeftPlayer(playerInfo)
  local leftPlayer
  for _, e in ipairs(self._leftPlayerList) do
    if e._entityId == playerInfo.entityid then
      leftPlayer = e
      break
    end
  end
  if not leftPlayer then
    for _, e in ipairs(self._leftPlayerSummonList) do
      if e._entityId == playerInfo.entityid then
        leftPlayer = e
        break
      end
    end
  end
  local rightPlayer
  for _, e in ipairs(self._rightPlayerList) do
    if e._entityId == playerInfo.entityid then
      rightPlayer = e
      break
    end
  end
  if not rightPlayer then
    for _, e in ipairs(self._rightPlayerSummonList) do
      if e._entityId == playerInfo.entityid then
        rightPlayer = e
        break
      end
    end
  end
  if leftPlayer then
    local entity = leftPlayer
    self:DestroyPhysicsBody(entity:GetComponent(BattleECS.Components.PhysicsComponent)._box2DBodyID)
    local shapeConfig
    if playerInfo.shapeid == 0 then
      shapeConfig = {
        assetBundleName = playerInfo.assetBundleName,
        prefabName = playerInfo.prefabName
      }
    else
      shapeConfig = BattleECS.Utility.DataUtility.cNPCShapeTable[playerInfo.shapeid]
    end
    local component = entity:GetComponent(BattleECS.Components.TypeComponent)
    component._changeShapeID = playerInfo.shapeid
    component = entity:GetComponent(BattleECS.Components.PositionComponent)
    local BodyId = box2d.newBody(self._physicsWorld, 2, component._position.x, component._position.y)
    box2d.bodySetUserData(self._physicsWorld, BodyId, {
      entityid = entity._entityId,
      camp = 1,
      skillid = 0,
      rad = 0,
      useskillentityid = entity._entityId
    })
    local colliderData = require("data.battledata.npcshapedata." .. string.lower(shapeConfig.prefabName))
    local hitFixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackedColliserSize.x, colliderData.attackedColliserSize.y, colliderData.attackedColliserOffect.x, colliderData.attackedColliserOffect.y, 0, 200, 0, 0, true, 3, 3)
    box2d.fixtureSetUserData(self._physicsWorld, BodyId, hitFixtureId, {fixid = hitFixtureId, fixtype = "hitted"})
    local landFixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, 50, 50, 0, 0, 0, 5000, 0, 1000, false, tonumber(string.format("%#x", tostring(2 ^ self:GetBatterIndex()))), tonumber(string.format("%#x", tostring(2 ^ self:GetBatterIndex()))))
    box2d.fixtureSetUserData(self._physicsWorld, BodyId, landFixtureId, {fixid = landFixtureId, fixtype = "land"})
    component = entity:GetComponent(BattleECS.Components.PhysicsComponent)
    component._box2DBodyID = BodyId
    component = entity:GetComponent(BattleECS.Components.BuffComponent)
    if component then
      for _, v in ipairs(component._buffList) do
        v.buffObj:ChangeShapeToPlayBeginBuffEffect()
      end
    end
    return entity
  elseif rightPlayer then
    local entity = rightPlayer
    self:DestroyPhysicsBody(entity:GetComponent(BattleECS.Components.PhysicsComponent)._box2DBodyID)
    local shapeConfig
    if playerInfo.shapeid == 0 then
      shapeConfig = {
        assetBundleName = playerInfo.assetBundleName,
        prefabName = playerInfo.prefabName
      }
    else
      shapeConfig = BattleECS.Utility.DataUtility.cNPCShapeTable[playerInfo.shapeid]
    end
    local component = entity:GetComponent(BattleECS.Components.TypeComponent)
    component._changeShapeID = playerInfo.shapeid
    component = entity:GetComponent(BattleECS.Components.PositionComponent)
    local BodyId = box2d.newBody(self._physicsWorld, 2, component._position.x, component._position.y)
    box2d.bodySetUserData(self._physicsWorld, BodyId, {
      entityid = entity._entityId,
      camp = 2,
      skillid = 0,
      rad = 0,
      useskillentityid = entity._entityId
    })
    local colliderData = require("data.battledata.npcshapedata." .. string.lower(shapeConfig.prefabName))
    local hitFixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackedColliserSize.x, colliderData.attackedColliserSize.y, -colliderData.attackedColliserOffect.x, colliderData.attackedColliserOffect.y, 0, 200, 0, 0, true, 3, 3)
    box2d.fixtureSetUserData(self._physicsWorld, BodyId, hitFixtureId, {fixid = hitFixtureId, fixtype = "hitted"})
    local landFixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, 50, 50, 0, 0, 0, 5000, 0, 1000, false, tonumber(string.format("%#x", tostring(2 ^ self:GetBatterIndex()))), tonumber(string.format("%#x", tostring(2 ^ self:GetBatterIndex()))))
    box2d.fixtureSetUserData(self._physicsWorld, BodyId, landFixtureId, {fixid = landFixtureId, fixtype = "land"})
    component = entity:GetComponent(BattleECS.Components.PhysicsComponent)
    component._box2DBodyID = BodyId
    component = entity:GetComponent(BattleECS.Components.BuffComponent)
    if component then
      for _, v in ipairs(component._buffList) do
        v.buffObj:ChangeShapeToPlayBeginBuffEffect()
      end
    end
    return entity
  end
end

function BattleWorld:CreateLeftPlayerSummon(...)
  local rec = {
    ...
  }
  local info = rec[1]
  local name = info.name
  if name == "yuzi" then
    local monsterid = info.monsterid
    local buffdata = info.buffdata
    local pos = 0
    if monsterid == 90001 then
      pos = 72
    elseif monsterid == 90002 then
      pos = 73
    elseif monsterid == 90003 then
      pos = 74
    end
    local data = {}
    local record = string.split(BattleECS.Utility.DataUtility.cBattleConstCfgTable[pos].attr, ",")
    data.x = fixedpoint(record[1])
    data.y = fixedpoint(record[2])
    data.z = fixedpoint(record[3])
    local config = BattleECS.Utility.DataUtility.cMonsterCfgTable[monsterid]
    if config then
      local entity = self:NewEntity()
      local shapeConfig = BattleECS.Utility.DataUtility.cNPCShapeTable[config.shapeID]
      local component = entity:AddComponent(BattleECS.Components.TypeComponent)
      component._camp = BattleECS.Components.TypeComponent.CampType.Left
      component._roleID = monsterid
      component._summonName = name
      local roleRecorder = BattleECS.Utility.DataUtility.roleConfigTable[monsterid]
      roleRecorder = roleRecorder or BattleECS.Utility.DataUtility.cMonsterCfgTable[monsterid]
      local shapeRecorder = BattleECS.Utility.DataUtility.cNPCShapeTable[roleRecorder.shapeID]
      component._oriShapeAssetBundleName = shapeRecorder.assetBundleName
      component._oriShapePrefabName = shapeRecorder.prefabName
      entity:AddComponent(BattleECS.Components.HpComponent)
      entity:AddComponent(BattleECS.Components.DefenseComponent)
      entity:AddComponent(BattleECS.Components.AttackComponent)
      entity:AddComponent(BattleECS.Components.AnimationEventComponent)
      local BodyId = box2d.newBody(self._physicsWorld, 2, data.x, data.y)
      box2d.bodySetUserData(self._physicsWorld, BodyId, {
        entityid = entity._entityId,
        camp = 1,
        skillid = 1,
        rad = 0,
        useskillentityid = entity._entityId
      })
      local colliderData = require("data.battledata.npcshapedata." .. string.lower(shapeConfig.prefabName))
      local hitFixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackedColliserSize.x, colliderData.attackedColliserSize.y, colliderData.attackedColliserOffect.x, colliderData.attackedColliserOffect.y, 0, 200, 0, 0, true, 3, 3)
      box2d.fixtureSetUserData(self._physicsWorld, BodyId, hitFixtureId, {fixid = hitFixtureId, fixtype = "hitted"})
      component = entity:AddComponent(BattleECS.Components.PhysicsComponent)
      component._box2DBodyID = BodyId
      entity:AddComponent(BattleECS.Components.BehaviorComponent)
      local behavior
      if config.behaviacAI ~= "" then
        behavior = BehaviorManager.NewBehavior("newbattle/" .. config.behaviacAI)
      else
        behavior = BehaviorManager.NewBehavior("newbattle/newbattle")
      end
      component = entity:AddComponent(BattleECS.Components.SkillComponent)
      behavior._behaviorSkillList = {}
      for _, v in ipairs(config.skillid) do
        if v ~= 0 then
          local cd = BattleECS.Utility.DataUtility.cSkillCostTable[v].CDfraps
          local hasSaveSkillInSkillComponentSkillList = false
          for _, skillTable in ipairs(component._skillList) do
            if skillTable.skillId == v then
              skillTable.cdTime = fixedpoint(cd)
              skillTable.currentTime = 0
              hasSaveSkillInSkillComponentSkillList = true
              break
            end
          end
          if not hasSaveSkillInSkillComponentSkillList then
            table.insert(component._skillList, {
              skillId = v,
              cdTime = fixedpoint(cd),
              currentTime = 0
            })
          end
          table.insert(behavior._behaviorSkillList, v)
        end
      end
      behavior._data = {
        RandomFunction = self._randomPcg
      }
      behavior._entityId = entity._entityId
      behavior._battleworld = self
      behavior:SetTree()
      entity:GetComponent(BattleECS.Components.BehaviorComponent)._behavior = behavior
      component = entity:AddComponent(BattleECS.Components.PositionComponent)
      component._position.x = data.x
      component._position.y = data.y
      component._position.z = data.z
      entity:AddComponent(BattleECS.Components.BuffComponent)
      local buffenermyentity
      for i, e in ipairs(self._entitys) do
        if e._entityId == info.useskillentityid then
          buffenermyentity = e
          break
        end
      end
      BattleECS.Utility.BuffUtility.InsertEntityDifferentBuff({
        entity = entity,
        enermyentity = buffenermyentity,
        buffid = buffdata.buffid,
        buffparamter = buffdata.buffvalues,
        skillid = info.skillid,
        battleworld = self
      })
      local protocol = BattleClientProtocolManager.CreateProtocol("action.srolesummoncreate")
      protocol.entityid = entity._entityId
      protocol.attribute.camp = BattleECS.Components.TypeComponent.CampType.Left
      protocol.attribute.id = monsterid
      component = entity:GetComponent(BattleECS.Components.HpComponent)
      protocol.attribute.hp = fixedpoint.tonumber(component._maxHp)
      protocol.attribute.hpmax = fixedpoint.tonumber(component._maxHp)
      protocol.attribute.x = fixedpoint.tonumber(data.x)
      protocol.attribute.y = fixedpoint.tonumber(data.y)
      protocol.attribute.z = fixedpoint.tonumber(data.z)
      protocol.attribute.assetbundlename = shapeRecorder.assetBundleName
      protocol.attribute.prefabname = shapeRecorder.prefabName
      self:InsertViewProtocolData(protocol)
      return entity
    end
  end
end

function BattleWorld:CreatePlayerSummon(...)
  local rec = {
    ...
  }
  local info = rec[1]
  local name = info.name
  if name == "buff" then
    local config = BattleECS.Utility.DataUtility.cMonsterCfgTable[info.monsterid]
    if config then
      local x, y, z = info.bornPoint.x, info.bornPoint.y, info.bornPoint.z
      local shapeConfig = BattleECS.Utility.DataUtility.cNPCShapeTable[config.shapeID]
      local entity = self:NewEntity()
      local component = entity:AddComponent(BattleECS.Components.HpComponent)
      local SummonTypeEnum = {SameWithFather = 1, ReadFromConfig = 2}
      if info.summonType == SummonTypeEnum.SameWithFather then
        local fatherComponent = info.summonFatherEntity:GetComponent(BattleECS.Components.HpComponent)
        component._maxHp = fatherComponent._maxHp
        component._basicMaxHp = component._maxHp
        component._currentHp = fatherComponent._maxHp
        component = entity:AddComponent(BattleECS.Components.DefenseComponent)
        fatherComponent = info.summonFatherEntity:GetComponent(BattleECS.Components.DefenseComponent)
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
        component = entity:AddComponent(BattleECS.Components.AttackComponent)
        fatherComponent = info.summonFatherEntity:GetComponent(BattleECS.Components.AttackComponent)
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
      elseif info.summonType == SummonTypeEnum.ReadFromConfig then
        local fatherComponent = info.summonFatherEntity:GetComponent(BattleECS.Components.TypeComponent)
        local totalHp = fixedpoint_zero
        local hpConstant = string.split(config.hpConstant, ";")
        for i, hp in ipairs(hpConstant) do
          local value = BattleECS.Utility.Utility.CalculateConfigAttrFunc(hp, {
            lv = fatherComponent._level
          })
          totalHp = totalHp + value
        end
        component._maxHp = totalHp
        component._basicMaxHp = component._maxHp
        component._currentHp = totalHp
        component = entity:AddComponent(BattleECS.Components.AttackComponent)
        local value = BattleECS.Utility.Utility.CalculateConfigAttrFunc(config.attackConstant, {
          lv = fatherComponent._level
        })
        component._attack = fixedpoint(value)
        component._basicAttack = component._attack
        component = entity:AddComponent(BattleECS.Components.DefenseComponent)
        value = BattleECS.Utility.Utility.CalculateConfigAttrFunc(config.defConstant, {
          lv = fatherComponent._level
        })
        component._attackDefense = fixedpoint(value)
        component._basicAttackDefense = component._attackDefense
        value = BattleECS.Utility.Utility.CalculateConfigAttrFunc(config.magicDefConstant, {
          lv = fatherComponent._level
        })
        component._magicDefense = fixedpoint(value)
        component._basicMagicDefense = component._magicDefense
        value = BattleECS.Utility.Utility.CalculateConfigAttrFunc(config.damagereduce, {
          lv = fatherComponent._level
        })
        component._damageReduce = fixedpoint(value)
      end
      local fatherCamp = info.summonFatherEntity:GetComponent(BattleECS.Components.TypeComponent)._camp
      local roleRecorder = BattleECS.Utility.DataUtility.roleConfigTable[info.monsterid]
      roleRecorder = roleRecorder or BattleECS.Utility.DataUtility.cMonsterCfgTable[info.monsterid]
      local shapeRecorder = BattleECS.Utility.DataUtility.cNPCShapeTable[roleRecorder.shapeID]
      component = entity:AddComponent(BattleECS.Components.TypeComponent)
      component._camp = fatherCamp
      component._roleID = info.monsterid
      component._summonName = name
      component._oriShapeAssetBundleName = shapeRecorder.assetBundleName
      component._oriShapePrefabName = shapeRecorder.prefabName
      component._rolePointNum = info.pointNum
      local protocol = BattleClientProtocolManager.CreateProtocol("action.srolesummoncreate")
      protocol.entityid = entity._entityId
      protocol.fatherEntityId = info.summonFatherEntity._entityId
      protocol.attribute.camp = fatherCamp
      protocol.attribute.id = info.monsterid
      component = entity:GetComponent(BattleECS.Components.HpComponent)
      protocol.attribute.hp = fixedpoint.tonumber(component._currentHp)
      protocol.attribute.hpmax = fixedpoint.tonumber(component._maxHp)
      protocol.attribute.x = fixedpoint.tonumber(x)
      protocol.attribute.y = fixedpoint.tonumber(y)
      protocol.attribute.z = fixedpoint.tonumber(z)
      protocol.attribute.assetbundlename = shapeRecorder.assetBundleName
      protocol.attribute.prefabname = shapeRecorder.prefabName
      protocol.attribute.nameTextId = config.nameTextID
      self:InsertViewProtocolData(protocol)
      entity:AddComponent(BattleECS.Components.AnimationEventComponent)
      component = entity:AddComponent(BattleECS.Components.DeadDisappearCountComponent)
      local animationEndData = require("data.battledata.npcshapeanimationdata." .. string.lower(shapeConfig.prefabName))
      if animationEndData.DeadDisappear then
        component._deadTotalCount = animationEndData.DeadDisappear.endEventFrames
      else
        component._deadTotalCount = 0
      end
      local BodyId = box2d.newBody(self._physicsWorld, 2, x, y)
      box2d.bodySetUserData(self._physicsWorld, BodyId, {
        entityid = entity._entityId,
        camp = fatherCamp,
        skillid = 0,
        rad = 0,
        useskillentityid = entity._entityId
      })
      local colliderData = require("data.battledata.npcshapedata." .. string.lower(shapeConfig.prefabName))
      local hitFixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackedColliserSize.x, colliderData.attackedColliserSize.y, colliderData.attackedColliserOffect.x, colliderData.attackedColliserOffect.y, 0, 200, 0, 0, true, 3, 3)
      box2d.fixtureSetUserData(self._physicsWorld, BodyId, hitFixtureId, {fixid = hitFixtureId, fixtype = "hitted"})
      component = entity:AddComponent(BattleECS.Components.PhysicsComponent)
      component._box2DBodyID = BodyId
      if config.speed then
        component._toTargetMaxSpeed.x = fixedpoint(config.speed) * 10
      else
        component._toTargetMaxSpeed.x = fixedpoint(config.speedConstant) * 10
      end
      entity:AddComponent(BattleECS.Components.BehaviorComponent)
      local behavior
      if config.behaviacAI ~= "" then
        behavior = BehaviorManager.NewBehavior("newbattle/" .. config.behaviacAI)
      else
        behavior = BehaviorManager.NewBehavior("newbattle/newbattle")
      end
      component = entity:AddComponent(BattleECS.Components.SkillComponent)
      behavior._behaviorSkillList = {}
      for _, v in ipairs(config.skillid) do
        if v ~= 0 then
          local cd = BattleECS.Utility.DataUtility.cSkillCostTable[v].CDfraps
          local hasSaveSkillInSkillComponentSkillList = false
          for _, skillTable in ipairs(component._skillList) do
            if skillTable.skillId == v then
              skillTable.cdTime = fixedpoint(cd)
              skillTable.currentTime = 0
              hasSaveSkillInSkillComponentSkillList = true
              break
            end
          end
          if not hasSaveSkillInSkillComponentSkillList then
            table.insert(component._skillList, {
              skillId = v,
              cdTime = fixedpoint(cd),
              currentTime = 0
            })
          end
          table.insert(behavior._behaviorSkillList, v)
        end
      end
      component._isHasPassiveSkillParamter = info.summonFatherEntity:GetComponent(BattleECS.Components.SkillComponent)._isHasPassiveSkillParamter
      behavior._data = {
        RandomFunction = self._randomPcg
      }
      behavior._entityId = entity._entityId
      behavior._battleworld = self
      behavior:SetTree()
      entity:GetComponent(BattleECS.Components.BehaviorComponent)._behavior = behavior
      component = entity:AddComponent(BattleECS.Components.PositionComponent)
      component._position.x = x
      component._position.y = y
      component._position.z = z
      component._targetPos.x = x
      component._targetPos.y = y
      entity:AddComponent(BattleECS.Components.BuffComponent)
      entity:AddComponent(BattleECS.Components.SummonDataComponent)
      if config.defaultBuff and config.defaultBuff ~= "" then
        for _, v in ipairs(string.split(config.defaultBuff, ";")) do
          BattleECS.Utility.BuffUtility.InsertEntityDifferentBuff({
            entity = entity,
            enermyentity = entity,
            buffid = tonumber(v),
            buffparamter = "time=99999",
            skillid = 0,
            battleworld = self
          })
        end
      end
      for _, birthSkill in ipairs(info.birthSkillList) do
        BattleECS.Utility.BuffUtility.SetBuffListToOwnCampEntityBySkillID(entity, entity, tonumber(birthSkill), self)
        local hittedEntityList = BattleECS.Utility.Utility.GetSkillEffectEntity(tonumber(birthSkill), entity._entityId, self)
        if table.nums(hittedEntityList) ~= 0 then
          self:CreateSkillEntity(tonumber(birthSkill), entity._entityId, 1, hittedEntityList)
        end
      end
      entity:GetComponent(BattleECS.Components.TypeComponent)._summonFatherEntityid = info.summonFatherEntity._entityId
      local DeleteType = {DontDeleteFatherBuff = 0, DeleteFatherBuff = 1}
      if info.buffDeletedAfterDeathOrNot == DeleteType.DeleteFatherBuff then
        table.insert(info.summonFatherEntity:GetComponent(BattleECS.Components.SummonDataComponent)._summonBuffData, {
          buffId = info.buffId,
          summonEntityId = entity._entityId
        })
      end
      if fatherCamp == BattleECS.Components.TypeComponent.CampType.Left then
        local hasEntity = false
        for i, e in ipairs(self._leftPlayerSummonList) do
          if e._entityId == entity._entityId then
            self._leftPlayerSummonList[i] = entity
            hasEntity = true
          end
        end
        if not hasEntity then
          table.insert(self._leftPlayerSummonList, entity)
        end
      elseif fatherCamp == BattleECS.Components.TypeComponent.CampType.Right then
        local hasEntity = false
        for i, e in ipairs(self._rightPlayerSummonList) do
          if e._entityId == entity._entityId then
            self._rightPlayerSummonList[i] = entity
            hasEntity = true
          end
        end
        if not hasEntity then
          table.insert(self._rightPlayerSummonList, entity)
        end
      else
        LogErrorFormat("BattleWorld", "entity id %s summon id %s father's camp %s is not left/right, so destroy", entity._entityId, info.monsterid, fatherCamp)
      end
      return entity
    end
  end
end

function BattleWorld:CreateRightPlayer(playerInfo, additionalInfo)
  local component = self._createUtilityEntity:GetComponent(BattleECS.Components.CreateRoleComponent)
  if additionalInfo then
    table.insert(component._playerInfoList, {
      playerInfo = playerInfo,
      camp = BattleECS.Components.TypeComponent.CampType.Right,
      isInitial = additionalInfo.isInitial,
      alternateFighterBean = additionalInfo.alternateFighterBean
    })
  else
    table.insert(component._playerInfoList, {
      playerInfo = playerInfo,
      camp = BattleECS.Components.TypeComponent.CampType.Right
    })
  end
end

function BattleWorld:CreatePartnerJoin(playerInfo, positionTable)
  local entity = self:NewEntity()
  local component = entity:AddComponent(BattleECS.Components.TypeComponent)
  component._camp = playerInfo.camp
  component._roleID = playerInfo.id
  component._rolePointNum = playerInfo.key
  component._summonName = "partner"
  component._oriShapeAssetBundleName = playerInfo.assetbundlename
  component._oriShapePrefabName = playerInfo.prefabname
  component._runelv = playerInfo.runelv
  component = entity:AddComponent(BattleECS.Components.HpComponent)
  component._maxHp = fixedpoint(playerInfo.hpmax)
  component._basicMaxHp = component._maxHp
  component._currentHp = fixedpoint(playerInfo.hp)
  component = entity:AddComponent(BattleECS.Components.AttackComponent)
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
  component = entity:AddComponent(BattleECS.Components.DefenseComponent)
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
  component = entity:AddComponent(BattleECS.Components.SkillComponent)
  local count = 0
  for _, v in ipairs(playerInfo.skilllist) do
    if v ~= 0 then
      local cd = BattleECS.Utility.DataUtility.cSkillCostTable[v].CDfraps
      local hasSaveSkillInSkillComponentSkillList = false
      for _, skillTable in ipairs(component._skillList) do
        if skillTable.skillId == v then
          skillTable.cdTime = fixedpoint(cd)
          skillTable.currentTime = 0
          hasSaveSkillInSkillComponentSkillList = true
          break
        end
      end
      if not hasSaveSkillInSkillComponentSkillList then
        table.insert(component._skillList, {
          skillId = v,
          cdTime = fixedpoint(cd),
          currentTime = cd
        })
      end
      count = BattleECS.Utility.Utility.GetMonsterOrRoleMagicOrAttackEndFraps(entity, v)
    end
  end
  local BodyId = box2d.newBody(self._physicsWorld, 2, positionTable.x, positionTable.y)
  component = entity:AddComponent(BattleECS.Components.PhysicsComponent)
  component._box2DBodyID = BodyId
  component = entity:AddComponent(BattleECS.Components.PositionComponent)
  component._position.x = positionTable.x
  component._position.y = positionTable.y
  component._position.z = positionTable.z
  if count ~= 0 then
    component = entity:AddComponent(BattleECS.Components.RoleDeadCountComponent)
    component._maxCount = count
  end
  entity:AddComponent(BattleECS.Components.BuffComponent)
  entity:AddComponent(BattleECS.Components.AnimationEventComponent)
  for _, v in ipairs(playerInfo.skilllist) do
    BattleECS.Utility.Utility.SetSkillID(entity, v)
  end
  local protocol = BattleClientProtocolManager.CreateProtocol("action.spartnercreate")
  protocol.entityid = entity._entityId
  protocol.attribute.atk = playerInfo.atk
  protocol.attribute.matk = playerInfo.matk
  protocol.attribute.camp = playerInfo.camp
  protocol.attribute.speed = 0
  protocol.attribute.skilllist = playerInfo.skilllist
  protocol.attribute.key = playerInfo.key
  protocol.attribute.id = playerInfo.id
  protocol.attribute.x = fixedpoint.tonumber(positionTable.x)
  protocol.attribute.y = fixedpoint.tonumber(positionTable.y)
  protocol.attribute.z = fixedpoint.tonumber(positionTable.z)
  protocol.attribute.assetbundlename = playerInfo.assetbundlename
  protocol.attribute.prefabname = playerInfo.prefabname
  self:InsertViewProtocolData(protocol)
  local hasEntity = false
  for i, e in ipairs(self._leftPlayerPartnerList) do
    if e._entityId == entity._entityId then
      self._leftPlayerPartnerList[i] = entity
      hasEntity = true
    end
  end
  if not hasEntity then
    table.insert(self._leftPlayerPartnerList, entity)
  end
  local pos = entity:GetComponent(BattleECS.Components.PositionComponent)
  local delt = BattleECS.Utility.Utility.GetSkillEffectSocketPoint(playerInfo.prefabname, "HitPoint_Bottom")
  local x, y = pos._position.x - delt.x, pos._position.y + delt.y
  BattleECS.Utility.ProtocolUtility.SCreateSceneEffect(3, x, y, 0, 1, self)
  return entity
end

function BattleWorld:CreateSkillEntity(skillid, useSkillEntityID, createIndex, hittedEntityList)
  local hasEffect = false
  local useSkillEntity
  for i, e in ipairs(self._entitys) do
    if e._entityId == useSkillEntityID then
      useSkillEntity = e
      break
    end
  end
  if useSkillEntity then
    local useSkillEntitySkillComponent = useSkillEntity:GetComponent(BattleECS.Components.SkillComponent)
    local isAttackSkill = BattleECS.Utility.Utility.IsAttackSkill(skillid)
    local isUseSkill = BattleECS.Utility.Utility.IsUseSkill(skillid)
    local skillBehaviorRecord = BattleECS.Utility.DataUtility.cSkillBehaviorTable[skillid]
    if skillBehaviorRecord then
      local max = 1
      local endAnimationFrames = 0
      local entity = self:NewEntity()
      if isAttackSkill then
        table.insert(useSkillEntitySkillComponent._attackEntitySkillList, entity)
      elseif isUseSkill then
        for _, attackSkillEntity in ipairs(useSkillEntitySkillComponent._attackEntitySkillList) do
          local tempCom = attackSkillEntity:GetComponent(BattleECS.Components.TypeComponent)
          if tempCom then
            tempCom._isNeedDestroy = true
            tempCom._isNeedSendProtocolDestroy = false
          end
          tempCom = attackSkillEntity:GetComponent(BattleECS.Components.SkillEffectComponent)
          if tempCom then
            tempCom._animationAtkList = {}
            local removeList = {}
            for i = #tempCom._flyEntityList, 1, -1 do
              local v = tempCom._flyEntityList[i]
              local flyentity
              for _, e in ipairs(self._entitys) do
                if e._entityId == v.entityId then
                  flyentity = e
                  break
                end
              end
              if flyentity then
                if flyentity:GetComponent(BattleECS.Components.PhysicsComponent) then
                  flyentity:GetComponent(BattleECS.Components.PhysicsComponent)._isNeedReleaseBox = true
                end
                flyentity:GetComponent(BattleECS.Components.TypeComponent)._isNeedDestroy = true
              end
              table.insert(removeList, i)
            end
            for _, i in ipairs(removeList) do
              table.remove(tempCom._flyEntityList, i)
            end
          end
        end
        useSkillEntitySkillComponent._attackEntitySkillList = {}
      end
      local component = entity:AddComponent(BattleECS.Components.SkillEffectComponent)
      local animationRecord = BattleECS.Utility.DataUtility.cSkillAnimationTable[skillid]
      if animationRecord then
        local animationType = {
          None = 0,
          OneAttackAction = 1,
          ThreeAnimationAction = 2
        }
        if animationRecord.actionType == animationType.ThreeAnimationAction then
          local ifIgnorePriority = {No = 0, Yes = 1}
          BattleECS.Utility.ProtocolUtility.SendBattlerPlayAnimationByNameProtocol(useSkillEntity, animationRecord.skillStart, ifIgnorePriority.No, self)
          local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(useSkillEntity)
          local frapData = require("data.battledata.npcshapeanimationdata." .. string.lower(shapeRecorder.prefabName))
          local frapDataSkillStart = frapData[animationRecord.skillStart]
          if frapDataSkillStart then
            local startEndFrams = frapDataSkillStart.endEventFrames
            component._startAnimationDelayTime = startEndFrams
            table.insert(component._animationAtkList, {
              endAnimation = animationRecord.skillEnd,
              loopTime = startEndFrams + tonumber(animationRecord.loopTime)
            })
            if max < startEndFrams + tonumber(animationRecord.loopTime) then
              max = startEndFrams + tonumber(animationRecord.loopTime)
            end
          else
            LogErrorFormat("BattleWorld", "npcshapeanimationdata.%s dont have skillStart in cSkillAnimationTable skillid %s", string.lower(shapeRecorder.prefabName), skillid)
          end
          local frapDataSkillEnd = frapData[animationRecord.skillEnd]
          if frapDataSkillEnd then
            endAnimationFrames = frapDataSkillEnd.endEventFrames
          end
        elseif animationRecord.actionType == animationType.OneAttackAction then
          local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(useSkillEntity)
          local frapData = require("data.battledata.npcshapeanimationdata." .. string.lower(shapeRecorder.prefabName))
          local frapDataActionAtk = frapData[animationRecord.actionAtk]
          if frapDataActionAtk then
            endAnimationFrames = frapDataActionAtk.endEventFrames
          else
            LogErrorFormat("BattleWorld", "npcshapeanimationdata.%s dont have actionAtk in cSkillAnimationTable skillid %s", string.lower(shapeRecorder.prefabName), skillid)
          end
        end
      else
        local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(useSkillEntity)
        local frapData = require("data.battledata.npcshapeanimationdata." .. string.lower(shapeRecorder.prefabName))
        local frapDataActionAtk = frapData[skillBehaviorRecord.actionAtk]
        if frapDataActionAtk then
          endAnimationFrames = frapDataActionAtk.endEventFrames
        end
      end
      if BattleECS.Utility.Utility.IsSkillHas10006Buff(skillid) then
        entity:AddComponent(BattleECS.Components.TypeComponent)
        local effect = BattleECS.Utility.DataUtility.cSkillBehaviorTable[skillid].typeMineEffectAtk
        for _, v in ipairs(effect) do
          if type(v) ~= "number" then
            LogErrorFormat("BattleWorld", "- DataUtility.cSkillBehaviorTable.typeMineEffectAtk[%s]  is  %s", skillid, type(v))
          end
          local skillEffectId = v
          local curPrefabName = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._oriShapePrefabName
          skillEffectId = BattleECS.Utility.Utility.GetSkinSkillChangeEffectId(curPrefabName, skillEffectId)
          if skillEffectId then
            hasEffect = true
            local cskilleffectRecord = BattleECS.Utility.DataUtility.cSkillEffectTable[skillEffectId]
            if not cskilleffectRecord then
              LogErrorFormat("BattleWorld", "cskilleffect dont have effectid:%s", v)
            end
            if max < cskilleffectRecord.fraps + component._startAnimationDelayTime then
              max = cskilleffectRecord.fraps + component._startAnimationDelayTime
            end
            if max < cskilleffectRecord.HitFraps + component._startAnimationDelayTime then
              max = cskilleffectRecord.HitFraps + component._startAnimationDelayTime
            end
            max = math.max(max, cskilleffectRecord.effecttime)
            table.insert(component._typeMineEffectAtkList, {effectid = skillEffectId, hittedEntityID = 0})
          end
        end
        component._useSkillEntityID = useSkillEntityID
        component._flyNeedDestroyMaxFrap = max + endAnimationFrames
        component._skillID = skillid
        return hasEffect
      end
      if BattleECS.Utility.Utility.IsYingXiSkill(skillid) then
        entity:AddComponent(BattleECS.Components.TypeComponent)
        component._useSkillEntityID = useSkillEntityID
        component._flyNeedDestroyMaxFrap = 0
        component._skillID = skillid
        component._attackEntityList = hittedEntityList
        return
      end
      local hittedEntityID = hittedEntityList[createIndex]._entityId
      entity:AddComponent(BattleECS.Components.TypeComponent)._camp = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._camp
      local effect = BattleECS.Utility.DataUtility.cSkillBehaviorTable[skillid].typeMineEffectAtk
      for index, v in ipairs(effect) do
        local skillEffectId = v
        if BattleECS.Utility.Utility.IsLingShouChongJi(skillid) then
          local vTable = effect[index]
          local typePowerNum = 0
          if BattleECS.Utility.DataUtility.cSkillCostTable[skillid].ChaosCost ~= 0 then
            typePowerNum = useSkillEntitySkillComponent._skillCostPowerList[skillid].blue
          elseif BattleECS.Utility.DataUtility.cSkillCostTable[skillid].OrderCost ~= 0 then
            typePowerNum = useSkillEntitySkillComponent._skillCostPowerList[skillid].red
          end
          if index > typePowerNum then
            break
          end
          local randomNum = self._randomPcg(1, #vTable)
          skillEffectId = vTable[randomNum]
        end
        if type(skillEffectId) ~= "number" then
          LogErrorFormat("BattleWorld", "- DataUtility.cSkillBehaviorTable.typeMineEffectAtk[%s]  is  %s", skillid, type(skillEffectId))
        end
        local curPrefabName = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._oriShapePrefabName
        skillEffectId = BattleECS.Utility.Utility.GetSkinSkillChangeEffectId(curPrefabName, skillEffectId)
        if skillEffectId then
          hasEffect = true
          local cskilleffectRecord = BattleECS.Utility.DataUtility.cSkillEffectTable[skillEffectId]
          if not cskilleffectRecord then
            LogErrorFormat("BattleWorld", "cskilleffect dont have effectid:%s", v)
          end
          table.insert(component._typeMineEffectAtkList, {effectid = skillEffectId, hittedEntityID = hittedEntityID})
          if max < cskilleffectRecord.HitFraps + component._startAnimationDelayTime then
            max = cskilleffectRecord.HitFraps + component._startAnimationDelayTime
          end
          max = math.max(max, cskilleffectRecord.effecttime)
        end
      end
      effect = BattleECS.Utility.DataUtility.cSkillBehaviorTable[skillid].flightPropEffectAtk
      for _, v in ipairs(effect) do
        local skillEffectId = v
        if type(skillEffectId) ~= "number" then
          LogErrorFormat("BattleWorld", "- DataUtility.cSkillBehaviorTable.flightPropEffectAtk[%s]  is  %s", skillid, type(skillEffectId))
        end
        local curPrefabName = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._oriShapePrefabName
        skillEffectId = BattleECS.Utility.Utility.GetSkinSkillChangeEffectId(curPrefabName, skillEffectId)
        if skillEffectId then
          hasEffect = true
          local cskilleffectRecord = BattleECS.Utility.DataUtility.cSkillEffectTable[skillEffectId]
          if not cskilleffectRecord then
            LogErrorFormat("BattleWorld", "cskilleffect dont have effectid:%s", v)
          end
          if max < cskilleffectRecord.fraps + component._startAnimationDelayTime then
            max = cskilleffectRecord.fraps + component._startAnimationDelayTime
          end
          if BattleECS.Utility.DataUtility.cskillTable[skillid].attackOrderToEmery == 5 then
            local selfHittedEntityList = BattleECS.Utility.Utility.GetSkillEffectEntity(skillid, useSkillEntityID, self)
            hittedEntityID = selfHittedEntityList[createIndex]._entityId
            table.insert(component._flightPropEffectAtk, {effectid = skillEffectId, hittedEntityID = hittedEntityID})
          else
            table.insert(component._flightPropEffectAtk, {effectid = skillEffectId, hittedEntityID = hittedEntityID})
          end
        end
      end
      effect = BattleECS.Utility.DataUtility.cSkillBehaviorTable[skillid].invalidEffectAtk
      for _, v in ipairs(effect) do
        local skillEffectId = v
        if type(skillEffectId) ~= "number" then
          LogErrorFormat("BattleWorld", "- %- DataUtility.cSkillBehaviorTable.invalidEffectAtk[%s]  is  %s", skillid, type(skillEffectId))
        end
        local curPrefabName = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._oriShapePrefabName
        skillEffectId = BattleECS.Utility.Utility.GetSkinSkillChangeEffectId(curPrefabName, skillEffectId)
        if skillEffectId then
          local cskilleffectRecord = BattleECS.Utility.DataUtility.cSkillEffectTable[skillEffectId]
          if not cskilleffectRecord then
            LogErrorFormat("BattleWorld", "cskilleffect dont have effectid:%s", v)
          end
          if max < cskilleffectRecord.fraps + component._startAnimationDelayTime then
            max = cskilleffectRecord.fraps + component._startAnimationDelayTime
          end
          if max < cskilleffectRecord.HitFraps + component._startAnimationDelayTime then
            max = cskilleffectRecord.HitFraps + component._startAnimationDelayTime
          end
          table.insert(component._invalidEffectAtkList, {effectid = skillEffectId, hittedEntityID = hittedEntityID})
        end
      end
      effect = BattleECS.Utility.DataUtility.cSkillBehaviorTable[skillid].noColliderEffectAtk
      for _, v in ipairs(effect) do
        local skillEffectId = v
        if type(skillEffectId) ~= "number" then
          LogErrorFormat("BattleWorld", "- DataUtility.cSkillBehaviorTable.noColliderEffectAtk[%s]  is  %s", skillid, type(skillEffectId))
        end
        local curPrefabName = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._oriShapePrefabName
        skillEffectId = BattleECS.Utility.Utility.GetSkinSkillChangeEffectId(curPrefabName, skillEffectId)
        if skillEffectId then
          hasEffect = true
          local cskilleffectRecord = BattleECS.Utility.DataUtility.cSkillEffectTable[skillEffectId]
          if not cskilleffectRecord then
            LogErrorFormat("BattleWorld", "cskilleffect dont have effectid:%s", v)
          end
          table.insert(component._noColliderEffectList, {effectid = skillEffectId, hittedEntityID = hittedEntityID})
          if max < cskilleffectRecord.HitFraps + component._startAnimationDelayTime then
            max = cskilleffectRecord.HitFraps + component._startAnimationDelayTime
          end
        end
      end
      effect = BattleECS.Utility.DataUtility.cSkillBehaviorTable[skillid].WarningEffect
      for _, v in ipairs(effect) do
        local skillEffectId = v
        if type(skillEffectId) ~= "number" then
          LogErrorFormat("BattleWorld", "- DataUtility.cSkillBehaviorTable.WarningEffect[%s]  is  %s", skillid, type(skillEffectId))
        end
        local curPrefabName = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._oriShapePrefabName
        skillEffectId = BattleECS.Utility.Utility.GetSkinSkillChangeEffectId(curPrefabName, skillEffectId)
        if skillEffectId then
          local cskilleffectRecord = BattleECS.Utility.DataUtility.cSkillEffectTable[skillEffectId]
          if not cskilleffectRecord then
            LogErrorFormat("BattleWorld", "cskilleffect dont have effectid:%s", v)
          end
          table.insert(component._warningEffectList, {effectid = skillEffectId, hittedEntityID = hittedEntityID})
        end
      end
      component._useSkillEntityID = useSkillEntityID
      component._flyNeedDestroyMaxFrap = max + endAnimationFrames
      component._skillID = skillid
    end
  end
  return hasEffect
end

function BattleWorld:ChangeFlySkillEffectRadAndSpeed(entityid)
  local entity
  for i, e in ipairs(self._entitys) do
    if e._entityId == entityid then
      entity = e
      break
    end
  end
  if entity then
    local component = entity:GetComponent(BattleECS.Components.FlySkillDataComponent)
    if component._flyDestination.x ~= fixedpoint(-1) and component._flyDestination.y ~= fixedpoint(-1) then
      local posComponent = entity:GetComponent(BattleECS.Components.PositionComponent)
      local speed = BattleECS.Utility.DataUtility.cSkillEffectTable[20104001].speed
      local camp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
      local delta = {
        x = component._flyDestination.x - posComponent._position.x,
        y = component._flyDestination.y - posComponent._position.y
      }
      local distance = fixedpoint.sqrt(fixedpoint.square(delta.x / 1000) + fixedpoint.square(delta.y / 1000)) * 1000
      if distance == fixedpoint_zero then
        distance = 1
      end
      local cos = delta.y / distance
      local sin = delta.x / distance
      local xSp = speed * sin
      local ySp = speed * cos
      local BodyId = entity:GetComponent(BattleECS.Components.PhysicsComponent)._box2DBodyID
      posComponent._velocity.x = xSp
      posComponent._velocity.y = ySp
      component._onceFlyTime = fixedpoint_zero
      component._randomNum = 0
    else
      local tX, tY, num = BattleECS.Utility.Utility.GetRandomPosition(component._randomNum, self._randomPcg)
      local posComponent = entity:GetComponent(BattleECS.Components.PositionComponent)
      local x, y = posComponent._position.x, posComponent._position.y
      local camp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
      local speed = BattleECS.Utility.DataUtility.cSkillEffectTable[20104001].speed
      if camp == BattleECS.Components.TypeComponent.CampType.Left then
      else
        speed = -speed
      end
      local rad, sin = 0, 0
      rad, sin = BattleECS.Utility.Utility.ReturnEffectRadByTargetXY(x, y, tX, tY)
      local xSp = fixedpoint.abs(speed * fixedpoint.sqrt(1 - fixedpoint.square(sin)))
      local ySp = fixedpoint.abs(speed * sin)
      if tX < x then
        xSp = -xSp
      end
      if tY < y then
        ySp = -ySp
      end
      local BodyId = entity:GetComponent(BattleECS.Components.PhysicsComponent)._box2DBodyID
      posComponent._velocity.x = xSp
      posComponent._velocity.y = ySp
      component._onceFlyTime = fixedpoint.abs((x - tX) / xSp) * 33 // 1
      component._randomNum = num
    end
  end
end

function BattleWorld:CreateHorizontalUniformSpeedFlyingProp(effectConfig, skillid, useSkillEntityID, tarEntityID, isInsertOtherPhysicsList, effectid)
  local useSkillEntity
  for i, e in ipairs(self._entitys) do
    if e._entityId == useSkillEntityID then
      useSkillEntity = e
      break
    end
  end
  local targetEntity
  for i, e in ipairs(self._entitys) do
    if e._entityId == tarEntityID then
      targetEntity = e
      break
    end
  end
  if skillid == 201040 then
    if useSkillEntity then
      local entity = self:NewEntity()
      local camp = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._camp
      entity:AddComponent(BattleECS.Components.TypeComponent)._camp = camp
      local position = useSkillEntity:GetComponent(BattleECS.Components.PositionComponent)._position
      local x = fixedpoint_zero
      local y = fixedpoint_zero
      local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(useSkillEntity)
      local qDPath = BattleECS.Utility.Utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, effectConfig.socket)
      if useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Right then
        x = position.x - qDPath.x
        y = position.y + qDPath.y
      elseif useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
        x = position.x - qDPath.x
        y = position.y + qDPath.y
      else
        x = position.x + qDPath.x
        y = position.y + qDPath.y
      end
      local BodyId = box2d.newBody(self._physicsWorld, 2, x, y)
      local speed = 0
      if camp == BattleECS.Components.TypeComponent.CampType.Left then
        if useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
          speed = -effectConfig.speed
        else
          speed = effectConfig.speed
        end
      else
        speed = -effectConfig.speed
      end
      local rad, sin = fixedpoint_zero, fixedpoint_zero
      local n = self._randomPcg(1, 3)
      local tX, tY = BattleECS.Utility.Utility.GetRandomPosition(n, self._randomPcg)
      rad, sin = BattleECS.Utility.Utility.ReturnEffectRadByTargetXY(x, y, tX, tY)
      local xSp = fixedpoint.abs(speed * fixedpoint.sqrt(1 - fixedpoint.square(sin)))
      local ySp = fixedpoint.abs(speed * sin)
      if x > tX then
        xSp = -xSp
      end
      if y > tY then
        ySp = -ySp
      end
      local component = entity:AddComponent(BattleECS.Components.FlySkillDataComponent)
      component._skillMaxContactNumber = BattleECS.Utility.Utility.GetSkillAttackNumber(skillid)
      component._skillEffectType = BattleECS.Components.FlySkillDataComponent.SkillEffectType.FlyProp
      component._shouldBeButByShiKongZhiMen = effectConfig.isCut == 1
      if component._shouldBeButByShiKongZhiMen then
        LogInfoFormat("BattleWorld", "CreateHorizontalUniformSpeedFlyingProp effecid %s isCut %s _shouldBeButByShiKongZhiMen %s", effectConfig.id, effectConfig.isCut, component._shouldBeButByShiKongZhiMen)
      end
      component._onceFlyTime = fixedpoint.abs((x - tX) / xSp) * 33 // 1
      component._randomNum = n
      box2d.bodySetUserData(self._physicsWorld, BodyId, {
        entityid = entity._entityId,
        camp = camp,
        skillid = skillid,
        rad = rad,
        useskillentityid = useSkillEntityID
      })
      local colliderData = require("data.battledata.npcshapedata." .. string.lower(effectConfig.effectName))
      if not colliderData.attackColliserSize then
      end
      if not colliderData.attackColliserOffect then
      end
      local fixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackColliserSize.x, colliderData.attackColliserSize.y, colliderData.attackColliserOffect.x, colliderData.attackColliserOffect.y, rad * fixedpoint(1000), 200, 0, 1000, true, 65535, 65535)
      box2d.fixtureSetUserData(self._physicsWorld, BodyId, fixtureId, {fixid = fixtureId, fixtype = "normal"})
      entity:AddComponent(BattleECS.Components.PhysicsComponent)._box2DBodyID = BodyId
      component = entity:AddComponent(BattleECS.Components.PositionComponent)
      component._position.x, component._position.y = x, y
      component._velocity.x, component._velocity.y = xSp, ySp
      BattleECS.Utility.ProtocolUtility.SendFlySkill(entity._entityId, x, y, fixedpoint_zero, effectid, useSkillEntity._entityId, fixedpoint.floor(rad * 1000), 0, self)
      if self._actor_shiKongZhiMen_w[camp] then
        BattleECS.Utility.ProtocolUtility.SendSetClipRectForShiKongZhiMen(entity._entityId, self._actor_shiKongZhiMen_w[camp], self._actor_shiKongZhiMen_h[camp], camp, effectConfig.effectName, self, true)
      else
        self._actor_shiKongZhiMen_effectList[entity._entityId] = {
          entityId = entity._entityId,
          camp = camp,
          effectName = effectConfig.effectName
        }
      end
      self._actor_shiKongZhiMenRelease_effectList[entity._entityId] = {
        entityId = entity._entityId,
        camp = camp,
        effectName = effectConfig.effectName
      }
      self._actor_shiKongTingZhi_effectList[entity._entityId] = {
        entityId = entity._entityId,
        camp = camp,
        effectName = effectConfig.effectName
      }
      local hasEntity = false
      for i, e in ipairs(self._shape20030FlyBallSet) do
        if e._entityId == entity._entityId then
          self._shape20030FlyBallSet[i] = entity
          hasEntity = true
        end
      end
      if not hasEntity then
        table.insert(self._shape20030FlyBallSet, entity)
      end
    end
    return
  end
  if useSkillEntity and targetEntity then
    local entity = self:NewEntity()
    local camp = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._camp
    entity:AddComponent(BattleECS.Components.TypeComponent)._camp = camp
    local component = entity:AddComponent(BattleECS.Components.FlySkillDataComponent)
    component._skillMaxContactNumber = BattleECS.Utility.Utility.GetSkillAttackNumber(skillid)
    component._skillEffectType = BattleECS.Components.FlySkillDataComponent.SkillEffectType.FlyProp
    local position = useSkillEntity:GetComponent(BattleECS.Components.PositionComponent)._position
    local x = 0
    local y = 0
    local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(useSkillEntity)
    local qDPath = BattleECS.Utility.Utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, effectConfig.socket)
    if useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Right then
      x = position.x - qDPath.x
      y = position.y + qDPath.y
    elseif useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
      x = position.x - qDPath.x
      y = position.y + qDPath.y
    else
      x = position.x + qDPath.x
      y = position.y + qDPath.y
    end
    local BodyId = box2d.newBody(self._physicsWorld, 2, x, y)
    local speed = 0
    if camp == BattleECS.Components.TypeComponent.CampType.Left then
      if useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
        speed = -effectConfig.speed
      else
        speed = effectConfig.speed
      end
    else
      speed = -effectConfig.speed
    end
    local rad, sin, deg = fixedpoint_zero, fixedpoint_zero, fixedpoint_zero
    if effectConfig.targetsocket ~= "" then
      rad, sin, deg = BattleECS.Utility.Utility.ReturnEffectRad(useSkillEntity, targetEntity, effectConfig.socket, effectConfig.targetsocket)
    else
      rad, sin, deg = BattleECS.Utility.Utility.ReturnEffectRad(useSkillEntity, targetEntity, effectConfig.socket)
    end
    if effectConfig.deviationAngleOrNot == 0 then
      rad = fixedpoint_zero
    end
    LogInfoFormat("BattleWorld", "skillid %s effectid %s rad %s deg %s", skillid, effectConfig.id, rad, deg)
    local xSp = speed * fixedpoint.sqrt(1 - fixedpoint.square(sin))
    local ySp = speed * sin
    box2d.bodySetUserData(self._physicsWorld, BodyId, {
      entityid = entity._entityId,
      camp = camp,
      skillid = skillid,
      rad = rad,
      useskillentityid = useSkillEntityID
    })
    local colliderData = require("data.battledata.npcshapedata." .. string.lower(effectConfig.effectName))
    local fixtureId = 0
    if not colliderData.attackColliserSize then
    end
    if not colliderData.attackColliserOffect then
    end
    if colliderData.attackColliserSize and colliderData.attackColliserOffect then
      if camp == BattleECS.Components.TypeComponent.CampType.Left then
        fixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackColliserSize.x, colliderData.attackColliserSize.y, colliderData.attackColliserOffect.x, colliderData.attackColliserOffect.y, rad * fixedpoint(1000), 200, 0, 1000, true, 65535, 65535)
      else
        fixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackColliserSize.x, colliderData.attackColliserSize.y, -colliderData.attackColliserOffect.x, colliderData.attackColliserOffect.y, -rad * fixedpoint(1000), 200, 0, 1000, true, 65535, 65535)
      end
      box2d.fixtureSetUserData(self._physicsWorld, BodyId, fixtureId, {fixid = fixtureId, fixtype = "normal"})
    else
      local negTag = -1
      if camp == BattleECS.Components.TypeComponent.CampType.Left then
        negTag = 1
      end
      fixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, 1000, 1000, 1000 * negTag, 1000, rad * fixedpoint(1000) * negTag, 200, 0, 1000, true, 65535, 65535)
      box2d.fixtureSetUserData(self._physicsWorld, BodyId, fixtureId, {fixid = fixtureId, fixtype = "lucency"})
    end
    entity:AddComponent(BattleECS.Components.PhysicsComponent)._box2DBodyID = BodyId
    component = entity:AddComponent(BattleECS.Components.PositionComponent)
    component._position.x, component._position.y = x, y
    component._velocity.x, component._velocity.y = xSp, ySp
    if isInsertOtherPhysicsList then
      table.insert(self._otherPhysicsEntityList, entity)
    end
    local isImaged = 0
    if useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
      isImaged = 1
    end
    BattleECS.Utility.ProtocolUtility.SendFlySkill(entity._entityId, x, y, position.z, effectid, useSkillEntityID, fixedpoint.floor(deg * 1000), isImaged, self)
    if self._actor_shiKongZhiMen_w[camp] then
      BattleECS.Utility.ProtocolUtility.SendSetClipRectForShiKongZhiMen(entity._entityId, self._actor_shiKongZhiMen_w[camp], self._actor_shiKongZhiMen_h[camp], camp, effectConfig.effectName, self, true)
    else
      self._actor_shiKongZhiMen_effectList[entity._entityId] = {
        entityId = entity._entityId,
        camp = camp,
        effectName = effectConfig.effectName
      }
    end
    self._actor_shiKongZhiMenRelease_effectList[entity._entityId] = {
      entityId = entity._entityId,
      camp = camp,
      effectName = effectConfig.effectName
    }
    self._actor_shiKongTingZhi_effectList[entity._entityId] = {
      entityId = entity._entityId,
      camp = camp,
      effectName = effectConfig.effectName
    }
  end
end

function BattleWorld:CreateConfirmPositionProp(effectConfig, skillid, useSkillEntity, x, y, z, skillEntity, effectid, isAddHit)
  local entity = self:NewEntity()
  local camp
  if BattleECS.Utility.Utility.GetSkillEffectCamp(skillid) == BattleECS.Utility.Utility.SkillEffectCampType.OwnSide and not BattleECS.Utility.Utility.IsShiKongZhiMen(skillid) then
    camp = BattleECS.Components.TypeComponent.CampType.Both
  else
    camp = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._camp
  end
  local component = entity:AddComponent(BattleECS.Components.TypeComponent)
  component._camp = camp
  component._bindingSkillID = skillid
  component = entity:AddComponent(BattleECS.Components.PositionComponent)
  component._position.x = x
  component._position.y = y
  component = entity:AddComponent(BattleECS.Components.FlySkillDataComponent)
  component._skillMaxContactNumber = BattleECS.Utility.Utility.GetSkillAttackNumber(skillid)
  component._colliderLifeTime = effectConfig.lifeTime
  component._shouldBeButByShiKongZhiMen = effectConfig.isCut == 1
  if component._shouldBeButByShiKongZhiMen then
    LogInfoFormat("BattleWorld", "CreateConfirmPositionProp effecid %s isCut %s _shouldBeButByShiKongZhiMen %s", effectConfig.id, effectConfig.isCut, component._shouldBeButByShiKongZhiMen)
  end
  if skillEntity and isAddHit then
    entity:AddComponent(BattleECS.Components.PhysicsComponent)
    entity:AddComponent(BattleECS.Components.AnimationEventComponent)
    local hasFlyEntity = false
    for _, v in ipairs(skillEntity:GetComponent(BattleECS.Components.SkillEffectComponent)._flyEntityList) do
      if v.entityId == entity._entityId then
        v.hitFraps = effectConfig.HitFraps
        hasFlyEntity = true
      end
    end
    if not hasFlyEntity then
      table.insert(skillEntity:GetComponent(BattleECS.Components.SkillEffectComponent)._flyEntityList, {
        entityId = entity._entityId,
        hitFraps = effectConfig.HitFraps
      })
    end
  end
  local isImaged = 0
  if useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
    isImaged = 1
  end
  BattleECS.Utility.ProtocolUtility.SendFlySkill(entity._entityId, x, y, z, effectid, useSkillEntity._entityId, 0, isImaged, self)
  if not isAddHit then
    entity:GetComponent(BattleECS.Components.TypeComponent)._isNeedDestroy = true
  end
end

function BattleWorld:AddBoxBodyToEntity(effectConfig, skillid, useSkillEntity, x, y, flyEntityId)
  local camp = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._camp
  if BattleECS.Utility.Utility.GetSkillEffectCamp(skillid) == BattleECS.Utility.Utility.SkillEffectCampType.OwnSide and not BattleECS.Utility.Utility.IsShiKongZhiMen(skillid) then
    camp = BattleECS.Components.TypeComponent.CampType.Both
  end
  local entity
  for i, e in ipairs(self._entitys) do
    if e._entityId == flyEntityId then
      entity = e
      break
    end
  end
  if entity then
    local colliderData = require("data.battledata.npcshapedata." .. string.lower(effectConfig.effectName))
    if not colliderData.attackColliserSize then
    end
    if not colliderData.attackColliserOffect then
    end
    local BodyId = 0
    if BattleECS.Utility.Utility.IsShiKongZhiMen(skillid) then
      BodyId = box2d.newBody(self._physicsWorld, 2, x, y)
      box2d.bodySetUserData(self._physicsWorld, BodyId, {
        entityid = entity._entityId,
        camp = camp,
        skillid = skillid,
        rad = 0,
        useskillentityid = useSkillEntity._entityId
      })
      local fixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackColliserSize.x, colliderData.attackColliserSize.y, -colliderData.attackColliserOffect.x, colliderData.attackColliserOffect.y, 0, 200, 0, 1000, true, 65535, 65535)
      box2d.fixtureSetUserData(self._physicsWorld, BodyId, fixtureId, {fixid = fixtureId, fixtype = "hitted"})
      if camp == BattleECS.Components.TypeComponent.CampType.Right then
        self._actor_shiKongZhiMen_entityId[BattleECS.Components.TypeComponent.CampType.Left] = entity._entityId
        self._actor_shiKongZhiMen_w[BattleECS.Components.TypeComponent.CampType.Left] = colliderData.attackColliserSize.x
        self._actor_shiKongZhiMen_h[BattleECS.Components.TypeComponent.CampType.Left] = colliderData.attackColliserSize.y
        for _, v in pairs(self._actor_shiKongZhiMen_effectList) do
          if v.camp == BattleECS.Components.TypeComponent.CampType.Left then
            BattleECS.Utility.ProtocolUtility.SendSetClipRectForShiKongZhiMen(v.entityId, self._actor_shiKongZhiMen_w[v.camp], self._actor_shiKongZhiMen_h[v.camp], v.camp, v.effectName, self, true)
          end
        end
        self._actor_shiKongZhiMen_effectList = {}
      elseif camp == BattleECS.Components.TypeComponent.CampType.Left then
        self._actor_shiKongZhiMen_entityId[BattleECS.Components.TypeComponent.CampType.Right] = entity._entityId
        self._actor_shiKongZhiMen_w[BattleECS.Components.TypeComponent.CampType.Right] = colliderData.attackColliserSize.x
        self._actor_shiKongZhiMen_h[BattleECS.Components.TypeComponent.CampType.Right] = colliderData.attackColliserSize.y
        for _, v in pairs(self._actor_shiKongZhiMen_effectList) do
          if v.camp == BattleECS.Components.TypeComponent.CampType.Right then
            BattleECS.Utility.ProtocolUtility.SendSetClipRectForShiKongZhiMen(v.entityId, self._actor_shiKongZhiMen_w[v.camp], self._actor_shiKongZhiMen_h[v.camp], v.camp, v.effectName, self, true)
          end
        end
        self._actor_shiKongZhiMen_effectList = {}
      end
    else
      BodyId = box2d.newBody(self._physicsWorld, 2, x, y)
      box2d.bodySetUserData(self._physicsWorld, BodyId, {
        entityid = entity._entityId,
        camp = camp,
        skillid = skillid,
        rad = 0,
        useskillentityid = useSkillEntity._entityId
      })
      local fixtureId = 0
      if camp == BattleECS.Components.TypeComponent.CampType.Left or camp == BattleECS.Components.TypeComponent.CampType.Both then
        if useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged or effectConfig.id == 601110103 then
          fixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackColliserSize.x, colliderData.attackColliserSize.y, -colliderData.attackColliserOffect.x, colliderData.attackColliserOffect.y, 0, 200, 0, 1000, true, 65535, 65535)
        else
          fixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackColliserSize.x, colliderData.attackColliserSize.y, colliderData.attackColliserOffect.x, colliderData.attackColliserOffect.y, 0, 200, 0, 1000, true, 65535, 65535)
        end
      else
        fixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackColliserSize.x, colliderData.attackColliserSize.y, -colliderData.attackColliserOffect.x, colliderData.attackColliserOffect.y, 0, 200, 0, 1000, true, 65535, 65535)
      end
      box2d.fixtureSetUserData(self._physicsWorld, BodyId, fixtureId, {fixid = fixtureId, fixtype = "normal"})
    end
    local component = entity:GetComponent(BattleECS.Components.PhysicsComponent)
    if component then
      component._box2DBodyID = BodyId
      if effectConfig.isFollow == 1 then
        component._isChangePositionToUseSkillEntity = true
        component._useSkillEntityEntityID = useSkillEntity._entityId
        local record = useSkillEntity:GetComponent(BattleECS.Components.PositionComponent)._position
        component = entity:GetComponent(BattleECS.Components.PositionComponent)
        component._toUseSkillEntityPositonDeltaPosition.x = x - record.x
        component._toUseSkillEntityPositonDeltaPosition.y = y - record.y
      end
    else
      LogErrorFormat("BattleWorld", "AddBoxBodyToEntity no PhysicsComponent in this entity id %s", flyEntityId)
    end
    entity:GetComponent(BattleECS.Components.FlySkillDataComponent)._skillEffectType = BattleECS.Components.FlySkillDataComponent.SkillEffectType.ConfirmProp
    if effectConfig.animationName and effectConfig.animationName ~= "" then
      entity:GetComponent(BattleECS.Components.FlySkillDataComponent)._skillEffectType = BattleECS.Components.FlySkillDataComponent.SkillEffectType.ConfirmFlyProp
      local animationData = require("data.battledata.animation." .. string.lower(effectConfig.animationName))
      local inComponent = entity:GetComponent(BattleECS.Components.AnimationEventComponent)
      if inComponent then
        BattleECS.Utility.AnimationUtility.IntegrateChangePositionData(entity, string.lower(effectConfig.animationName))
      else
        LogErrorFormat("BattleWorld", "AddBoxBodyToEntity with effectConfig.animationName no AnimationEventComponent in this entity id %s", flyEntityId)
      end
      table.insert(self._playerSkillEffectEntityList, entity)
    end
  end
end

function BattleWorld:CreateParaBaloSkill(useSkillEntityID, tarEntityID, effectConfig, skillid)
  local useSkillEntity
  for i, e in ipairs(self._entitys) do
    if e._entityId == useSkillEntityID then
      useSkillEntity = e
      break
    end
  end
  local tarEntity
  for i, e in ipairs(self._entitys) do
    if e._entityId == tarEntityID then
      tarEntity = e
      break
    end
  end
  if useSkillEntity and tarEntity then
    local entity = self:NewEntity()
    local camp = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._camp
    entity:AddComponent(BattleECS.Components.TypeComponent)._camp = camp
    local component = entity:AddComponent(BattleECS.Components.FlySkillDataComponent)
    component._skillEffectType = BattleECS.Components.FlySkillDataComponent.SkillEffectType.ParaFlyProp
    local position = useSkillEntity:GetComponent(BattleECS.Components.PositionComponent)._position
    local x = 0
    local y = 0
    local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(useSkillEntity)
    local qDPath = BattleECS.Utility.Utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, effectConfig.socket)
    if camp == BattleECS.Components.TypeComponent.CampType.Right then
      x = position.x - qDPath.x
      y = position.y + qDPath.y
    elseif useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
      x = position.x - qDPath.x
      y = position.y + qDPath.y
    else
      x = position.x + qDPath.x
      y = position.y + qDPath.y
    end
    local BodyId = box2d.newBody(self._physicsWorld, 2, x, y)
    local speed = fixedpoint_zero
    if camp == BattleECS.Components.TypeComponent.CampType.Left then
      if useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
        speed = fixedpoint(-effectConfig.speed)
      else
        speed = fixedpoint(effectConfig.speed)
      end
    else
      speed = fixedpoint(-effectConfig.speed)
    end
    box2d.bodySetUserData(self._physicsWorld, BodyId, {
      entityid = entity._entityId,
      camp = camp,
      skillid = skillid,
      rad = 0,
      useskillentityid = useSkillEntityID
    })
    local colliderData = require("data.battledata.npcshapedata." .. string.lower(effectConfig.effectName))
    local fixtureId = 0
    if not colliderData.attackColliserSize then
    end
    if not colliderData.attackColliserOffect then
    end
    if camp == BattleECS.Components.TypeComponent.CampType.Left then
      fixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackColliserSize.x, colliderData.attackColliserSize.y, colliderData.attackColliserOffect.x, colliderData.attackColliserOffect.y, 0, 200, 0, 1000, true, 65535, 65535)
    else
      fixtureId = box2d.newBoxShapeFixture(self._physicsWorld, BodyId, colliderData.attackColliserSize.x, colliderData.attackColliserSize.y, -colliderData.attackColliserOffect.x, colliderData.attackColliserOffect.y, 0, 200, 0, 1000, true, 65535, 65535)
    end
    box2d.fixtureSetUserData(self._physicsWorld, BodyId, fixtureId, {fixid = fixtureId, fixtype = "normal"})
    component = entity:AddComponent(BattleECS.Components.PhysicsComponent)
    component._box2DBodyID = BodyId
    component._toTargetCurrentSpeed.x = speed
    local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(tarEntity)
    local targetpoint = BattleECS.Utility.Utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, effectConfig.targetsocket)
    local tarCamp = tarEntity:GetComponent(BattleECS.Components.TypeComponent)._camp
    local tarPos = tarEntity:GetComponent(BattleECS.Components.PositionComponent)._position
    local tarX = 0
    local tarY = 0
    if tarCamp == BattleECS.Components.TypeComponent.CampType.Right then
      tarX = tarPos.x - targetpoint.x
      tarY = tarPos.y + targetpoint.y
    else
      tarX = tarPos.x + targetpoint.x
      tarY = tarPos.y + targetpoint.y
    end
    local deltY = y - tarY
    local vY = fixedpoint_zero
    local deltX = x - tarX
    local a = fixedpoint(-effectConfig.gAcceleration)
    if 0 < deltY then
      vY = fixedpoint.abs(a) * deltX / 2 / fixedpoint.abs(speed) - deltY * fixedpoint.abs(speed) / deltX
    elseif deltY == 0 then
      vY = deltX * fixedpoint.abs(a) / 2 / fixedpoint.abs(speed)
    else
      vY = fixedpoint.abs(a) * deltX / 2 / fixedpoint.abs(speed) + deltY * fixedpoint.abs(speed) / deltX
    end
    component._toTargetCurrentSpeed.y = vY
    component._toTargetAcceleration.y = a
    entity:AddComponent(BattleECS.Components.PositionComponent)._position.x, entity:AddComponent(BattleECS.Components.PositionComponent)._position.y = x, y
    table.insert(self._otherPhysicsEntityList, entity)
    local isImaged = 0
    if useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
      isImaged = 1
    end
    BattleECS.Utility.ProtocolUtility.SendFlySkill(entity._entityId, x, y, position.z, effectConfig.id, useSkillEntityID, 0, isImaged, self)
    if self._actor_shiKongZhiMen_w[camp] then
      BattleECS.Utility.ProtocolUtility.SendSetClipRectForShiKongZhiMen(entity._entityId, self._actor_shiKongZhiMen_w[camp], self._actor_shiKongZhiMen_h[camp], camp, effectConfig.effectName, self, true)
    else
      self._actor_shiKongZhiMen_effectList[entity._entityId] = {
        entityId = entity._entityId,
        camp = camp,
        effectName = effectConfig.effectName
      }
    end
    self._actor_shiKongZhiMenRelease_effectList[entity._entityId] = {
      entityId = entity._entityId,
      camp = camp,
      effectName = effectConfig.effectName
    }
    self._actor_shiKongTingZhi_effectList[entity._entityId] = {
      entityId = entity._entityId,
      camp = camp,
      effectName = effectConfig.effectName
    }
  end
end

function BattleWorld:UpdataZero()
  self:GetSystem(BattleECS.Systems.CreateRoleSystem):Update()
  BattleECS.Utility.ProtocolUtility.SendBattlePowerShow(self._redPowerMax, self._redPower, self._bluePowerMax, self._bluePower, self)
end

function BattleWorld:Update(deltaTime, unscaledDeltaTime)
  if self._powerAccumulateState == self.PowerAccumulateStateType.BreakOut then
    self._breakOutPowerCountFrame = self._breakOutPowerCountFrame + 1
    if self._breakOutPowerCountFrame >= tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[96].attr) then
      self._breakOutPowerCountFrame = 0
      self._powerBreakOutIncreateSpeed = false
      self._powerAccumulateState = self.PowerAccumulateStateType.Drain
      BattleECS.Utility.ProtocolUtility.SendAccumulatePowerStateChange(self._powerAccumulateState, self)
    end
  end
  if self._powerAccumulateState == self.PowerAccumulateStateType.Drain then
    self._drainPowerCountFrame = self._drainPowerCountFrame + 1
    if self._drainPowerCountFrame >= tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[97].attr) then
      self._drainPowerCountFrame = 0
      self._powerAccumulateState = self.PowerAccumulateStateType.Filling
      BattleECS.Utility.ProtocolUtility.SendAccumulatePowerStateChange(self._powerAccumulateState, self)
    end
  end
  local increasenum = 1
  for _, v in ipairs(self._leftPlayerPowerIncreaseSpeedList) do
    increasenum = fixedpoint.max(increasenum, v.speed)
  end
  local increaseSpeed = fixedpoint_zero
  for i, v in ipairs(self._battleWorldPowerIncreaseSpeed) do
    increaseSpeed = increaseSpeed + v.addition * v.stack
  end
  increasenum = increasenum + increaseSpeed
  if self._powerBreakOutIncreateSpeed then
    increasenum = increasenum + fixedpoint(BattleECS.Utility.DataUtility.cBattleConstCfgTable[114].attr)
  end
  self._redPower = self._redPower + increasenum
  self._redPower = fixedpoint.min(self._redPower, self._redPowerMax)
  BattleECS.Utility.ProtocolUtility.SendBattlePowerShow(self._redPowerMax, self._redPower, self._bluePowerMax, self._bluePower, self)
  self._accumulatePower = math.min(self._accumulatePower, self._accumulatePowerMax)
  if self._accumulatePower >= self._accumulatePowerMax and self._powerAccumulateState == self.PowerAccumulateStateType.Filling then
    self._powerAccumulateState = self.PowerAccumulateStateType.Full
    BattleECS.Utility.ProtocolUtility.SendAccumulatePowerStateChange(self._powerAccumulateState, self)
  end
  self:GetSystem(BattleECS.Systems.CreateRoleSystem):Update()
  self:GetSystem(BattleECS.Systems.FlySkillDataSystem):Update()
  self:GetSystem(BattleECS.Systems.PhysicsSystem):Update()
  self:GetSystem(BattleECS.Systems.BuffSystem):Update()
  self:GetSystem(BattleECS.Systems.SpritePhysicsSystem):Update()
  self:GetSystem(BattleECS.Systems.SkillSystem):Update()
  self:GetSystem(BattleECS.Systems.AnimationSystem):Update()
  self:GetSystem(BattleECS.Systems.AnimationEventSystem):Update()
  self:GetSystem(BattleECS.Systems.SkillEffectSystem):Update()
  self:GetSystem(BattleECS.Systems.DeadDisappearCountSystem):Update()
  self:GetSystem(BattleECS.Systems.BehaviorSystem):Update()
  self:GetSystem(BattleECS.Systems.HpSystem):Update()
  self:GetSystem(BattleECS.Systems.ReleaseSystem):Update()
  self:GetSystem(BattleECS.Systems.RoleDeadCountSystem):Update()
  self:GetSystem(BattleECS.Systems.ViewMoveSystem):Update()
  self._battleWorldStartFrames = self._battleWorldStartFrames + 1
end

function BattleWorld:InsertViewProtocolData(protocol)
  self._insertData(protocol)
end

function BattleWorld:OnCSkillAct(protocol)
  local entity
  for i, e in ipairs(self._entitys) do
    if e._entityId == protocol.entityId then
      entity = e
      break
    end
  end
  if entity then
    if BattleECS.Utility.Utility.IsYingXiSkill(protocol.skillid) and entity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
      return
    end
    BattleECS.Utility.Utility.IsRoleCanUseSkill(entity, protocol.skillid, self)
  else
    LogErrorFormat("BattleWorld", "entityid:%s", protocol.entityId)
  end
end

function BattleWorld:OnCBattleKill(data)
  local isjoin = 0
  if 0 < self._partnerJoinCount then
    isjoin = 1
  end
  BattleECS.Utility.ProtocolUtility.SendBattleResult(data.type, isjoin, self)
  BattleECS.Utility.ProtocolUtility.SendBattleEnd(data.type, isjoin, self)
  LogInfoFormat("BattleWorld", "客户端战斗结束发送kill, type %s", data.type)
end

function BattleWorld:OnCPartner()
  local partner = self._partnerBattlerData
  local camp = 1
  local Enum_Camp = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
  local bean = BattleClientProtocolManager.CreateBean("data.attribute")
  bean.id = partner.id
  BattleECS.Utility.ProtocolUtility.SendPlayBattleVoice(bean.id, BattleECS.Utility.DataUtility.VoiceType.BattleStart, nil, self)
  local posId = 1
  local posCfg = self._battlePosList[tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[posId + 49].attr)]
  local x, y, z = posCfg.x, posCfg.y, posCfg.z
  bean.key = posId
  bean.camp = camp
  local positionTable = {
    x = fixedpoint_zero,
    y = fixedpoint_zero,
    z = fixedpoint_zero
  }
  if Enum_Camp.LeftFighter == camp then
    local offect = string.split(BattleECS.Utility.DataUtility.cBattleConstCfgTable[30].attr, ";")
    positionTable.x = x + fixedpoint(offect[1])
    positionTable.y = y + fixedpoint(offect[2])
    positionTable.z = z + fixedpoint(offect[3])
  elseif Enum_Camp.RightFighter == camp then
  end
  local AttrTypeEnum = BattleClientProtocolManager.GetBeanDef("data.attrtype")
  bean.hp = partner.attrs[AttrTypeEnum.HP]
  bean.hpmax = partner.attrs[AttrTypeEnum.MAX_HP]
  bean.atk = partner.attrs[AttrTypeEnum.ATTACK]
  bean.def = partner.attrs[AttrTypeEnum.DEFEND]
  bean.mdef = partner.attrs[AttrTypeEnum.MAGIC_DEFEND]
  bean.speed = partner.attrs[AttrTypeEnum.SPEED]
  bean.damage = partner.attrs[AttrTypeEnum.DAMAGE] or 0
  bean.physicalbonus = partner.attrs[AttrTypeEnum.PHYSICALBONUS] or 0
  bean.physicalreduce = partner.attrs[AttrTypeEnum.PHYSICALREDUCE] or 0
  bean.magicbonus = partner.attrs[AttrTypeEnum.MAGICBONUS] or 0
  bean.magicreduce = partner.attrs[AttrTypeEnum.MAGICREDUCE] or 0
  bean.physicalcritrate = partner.attrs[AttrTypeEnum.CRITRATE] or 0
  bean.physicalcritdegree = partner.attrs[AttrTypeEnum.CRITDEGREE] or 0
  bean.attackspeed = partner.attrs[AttrTypeEnum.ATTACKSPEED] or 0
  bean.magiclifesteal = partner.attrs[AttrTypeEnum.MAGICLIFESTEAL] or 0
  bean.physicallifesteal = partner.attrs[AttrTypeEnum.PHYSICALLIFESTEAL] or 0
  bean.physicalevasion = partner.attrs[AttrTypeEnum.EVASION] or 0
  bean.physicalblock = partner.attrs[AttrTypeEnum.PHYSICALBLOCK] or 0
  bean.magicblock = partner.attrs[AttrTypeEnum.MAGICBLOCK] or 0
  bean.physicaldefbreak = partner.attrs[AttrTypeEnum.PHYSICALDEFBREAK] or 0
  bean.magicdefbreak = partner.attrs[AttrTypeEnum.MAGICDEFBREAK] or 0
  bean.critrateresistance = partner.attrs[AttrTypeEnum.CRITRATERESISTANCE] or 0
  bean.critdegreeresistance = partner.attrs[AttrTypeEnum.CRITDEGREERESISTANCE] or 0
  bean.extraphysicaldamage = partner.attrs[AttrTypeEnum.EXTRAPHYSICALDAMAGE] or 0
  bean.extramagicdamage = partner.attrs[AttrTypeEnum.EXTRAMAGICDAMAGE] or 0
  bean.curativebonus = partner.attrs[AttrTypeEnum.CURATIVEBONUS] or 0
  bean.accuracy = partner.attrs[AttrTypeEnum.ACCURACY] or 0
  bean.critratelevel = partner.attrs[AttrTypeEnum.CRIT_LEVEL] or 0
  bean.critdegreelevel = partner.attrs[AttrTypeEnum.CRIT_DEGREE_LEVEL] or 0
  bean.healingpower = partner.attrs[AttrTypeEnum.HEALING_POWER] or 0
  bean.comborate1 = partner.attrs[AttrTypeEnum.COMBORATE1] or 0
  bean.comborate2 = partner.attrs[AttrTypeEnum.COMBORATE2] or 0
  bean.damagereduce = partner.attrs[AttrTypeEnum.DAMAGE_REDUCE] or 0
  bean.runelv = partner.attrs[AttrTypeEnum.RUNE_LV] or 0
  bean.baseskill = partner.baseSkill or 0
  bean.passiveskill = partner.passiveSkills or {}
  local shapeRecorder
  local cskinRecoder = BattleECS.Utility.DataUtility.cSkinTable[partner.skinId]
  LogInfoFormat("BattleWorld", "partner skinId %s", partner.skinId)
  if cskinRecoder then
    shapeRecorder = BattleECS.Utility.DataUtility.cNPCShapeTable[cskinRecoder.shapeID]
  else
    local roleRecoder = BattleECS.Utility.DataUtility.roleConfigTable[partner.id]
    roleRecoder = roleRecoder or BattleECS.Utility.DataUtility.cMonsterCfgTable[partner.id]
    shapeRecorder = BattleECS.Utility.DataUtility.cNPCShapeTable[roleRecoder.shapeID]
  end
  bean.assetbundlename = shapeRecorder.assetBundleName
  bean.prefabname = shapeRecorder.prefabName
  for _, v in ipairs(partner.skills) do
    if v ~= 0 then
      table.insert(bean.skilllist, v)
    end
  end
  self:CreatePartnerJoin(bean, positionTable)
  self._partnerJoinCount = self._partnerJoinCount + 1
  local protocol = BattleClientProtocolManager.CreateProtocol("action.spartner")
  protocol.count = self._partnerJoinCount
  self:InsertViewProtocolData(protocol)
end

function BattleWorld:OnCBreakOutPower(protocol)
  LuaNotificationCenter.PostNotification(Common.n_FillInBattlePower, self, {
    curRedPower = self._redPower,
    curBluePower = self._bluePower
  })
  self:AddRedPower(tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[8].attr))
  self:AddBluePower(tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[9].attr))
  self._accumulatePower = 0
  self._powerBreakOutIncreateSpeed = true
  self._powerAccumulateState = self.PowerAccumulateStateType.BreakOut
  for _, entity in ipairs(self._leftPlayerList) do
    local skillList = BattleECS.Utility.BuffUtility.IsHasTriggerBuffWhenBreakOutPower(entity, self._randomPcg)
    for _, skillStruct in ipairs(skillList) do
      BattleECS.Utility.Utility.SetSkillComponnetPassiveSkillList(entity, skillStruct, entity)
    end
  end
  for _, entity in ipairs(self._leftPlayerSummonList) do
    local skillList = BattleECS.Utility.BuffUtility.IsHasTriggerBuffWhenBreakOutPower(entity, self._randomPcg)
    for _, skillStruct in ipairs(skillList) do
      BattleECS.Utility.Utility.SetSkillComponnetPassiveSkillList(entity, skillStruct, entity)
    end
  end
  BattleECS.Utility.ProtocolUtility.SendAccumulatePowerStateChange(self._powerAccumulateState, self)
end

return BattleWorld
