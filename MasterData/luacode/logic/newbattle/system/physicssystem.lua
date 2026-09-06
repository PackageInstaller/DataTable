local System = require("ecs.system")
local PhysicsSystem = strictclass("PhysicsSystem", System)

function PhysicsSystem:Ctor(...)
  PhysicsSystem.super.Ctor(self, ...)
  self._contactList = {}
  self._utility = BattleECS.Utility.Utility
  self._protocolUtility = BattleECS.Utility.ProtocolUtility
  self._buffUtility = BattleECS.Utility.BuffUtility
  self._physicsUtility = BattleECS.Utility.PhysicsUtility
  table.insert(self._requiredComponents, BattleECS.Components.PositionComponent)
  table.insert(self._requiredComponents, BattleECS.Components.PhysicsComponent)
  local worldId = self._world._physicsWorld
  box2d.worldSetBeginContact(worldId, function(worldId, leftBodyId, leftBodyUserData, leftFixtureId, leftFixtureUserData, rightBodyId, rightBodyUserData, rightFixtureId, rightFixtureUserData)
    xpcall(function()
      self:worldSetBeginContact(worldId, leftBodyId, leftBodyUserData, leftFixtureId, leftFixtureUserData, rightBodyId, rightBodyUserData, rightFixtureId, rightFixtureUserData)
    end, function(err)
      LogError("PhysicsSystem", string.format("lua error : %s", err))
    end)
  end)
  box2d.worldSetEndContact(worldId, function(worldId, leftBodyId, leftBodyUserData, leftFixtureId, leftFixtureUserData, rightBodyId, rightBodyUserData, rightFixtureId, rightFixtureUserData)
    xpcall(function()
      self:worldSetEndContact(worldId, leftBodyId, leftBodyUserData, leftFixtureId, leftFixtureUserData, rightBodyId, rightBodyUserData, rightFixtureId, rightFixtureUserData)
    end, function(err)
      LogError("PhysicsSystem", string.format("lua error : %s", err))
    end)
  end)
end

function PhysicsSystem:worldSetBeginContact(worldId, leftBodyId, leftBodyUserData, leftFixtureId, leftFixtureUserData, rightBodyId, rightBodyUserData, rightFixtureId, rightFixtureUserData)
  if self._world._actor_shiKongZhiMen_entityId[BattleECS.Components.TypeComponent.CampType.Right] then
    if self._utility.IsShiXiangGuiSiWangGuangXian(leftBodyUserData.skillid) then
      local entity
      for _, e in ipairs(self._world._entitys) do
        if e._entityId == leftBodyUserData.entityid then
          entity = e
          break
        end
      end
      if entity then
        entity:GetComponent(BattleECS.Components.PhysicsComponent)._isNeedReleaseBox = true
        entity:GetComponent(BattleECS.Components.TypeComponent)._isNeedDestroy = true
      end
      return
    elseif self._utility.IsShiXiangGuiSiWangGuangXian(rightBodyUserData.skillid) then
      local entity
      for _, e in ipairs(self._world._entitys) do
        if e._entityId == rightBodyUserData.entityid then
          entity = e
          break
        end
      end
      if entity then
        entity:GetComponent(BattleECS.Components.PhysicsComponent)._isNeedReleaseBox = true
        entity:GetComponent(BattleECS.Components.TypeComponent)._isNeedDestroy = true
      end
      return
    end
  end
  if leftFixtureUserData.fixtype ~= "land" and rightFixtureUserData.fixtype ~= "land" then
    local leftEntity, rightEntity
    for _, e in ipairs(self._entitys) do
      if e._entityId == leftBodyUserData.entityid then
        leftEntity = e
        break
      end
    end
    for _, e in ipairs(self._entitys) do
      if e._entityId == rightBodyUserData.entityid then
        rightEntity = e
        break
      end
    end
    local leftBodyUserDataCamp
    if leftEntity then
      leftBodyUserDataCamp = leftEntity:GetComponent(BattleECS.Components.TypeComponent)._camp
    end
    local rightBodyUserDataCamp
    if rightEntity then
      rightBodyUserDataCamp = rightEntity:GetComponent(BattleECS.Components.TypeComponent)._camp
    end
    if leftBodyUserDataCamp ~= rightBodyUserDataCamp then
      if leftBodyUserData.skillid == 201430 or rightBodyUserData.skillid == 201430 then
        local a = 1
      end
      if self._utility.IsShiKongZhiMen(leftBodyUserData.skillid) then
        local entityFlyDataCom = rightEntity:GetComponent(BattleECS.Components.FlySkillDataComponent)
        if entityFlyDataCom then
          local effectType = entityFlyDataCom._skillEffectType
          local shouldBeButByShiKongZhiMen = entityFlyDataCom._shouldBeButByShiKongZhiMen
          if effectType == BattleECS.Components.FlySkillDataComponent.SkillEffectType.FlyProp or effectType == BattleECS.Components.FlySkillDataComponent.SkillEffectType.ConfirmFlyProp or effectType == BattleECS.Components.FlySkillDataComponent.SkillEffectType.ParaFlyProp or shouldBeButByShiKongZhiMen then
            rightEntity:GetComponent(BattleECS.Components.PhysicsComponent)._isNeedReleaseBox = true
            rightEntity:GetComponent(BattleECS.Components.TypeComponent)._isNeedDestroy = true
            rightEntity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake = false
            for i, inV in ipairs(self._world._playerSkillEffectEntityList) do
              if inV._entityId == rightBodyUserData.entityid then
                table.remove(self._world._playerSkillEffectEntityList, i)
                break
              end
            end
            return
          end
        end
      end
      if self._utility.IsShiKongZhiMen(rightBodyUserData.skillid) then
        local entityFlyDataCom = leftEntity:GetComponent(BattleECS.Components.FlySkillDataComponent)
        if entityFlyDataCom then
          local effectType = entityFlyDataCom._skillEffectType
          local shouldBeButByShiKongZhiMen = entityFlyDataCom._shouldBeButByShiKongZhiMen
          if effectType == BattleECS.Components.FlySkillDataComponent.SkillEffectType.FlyProp or effectType == BattleECS.Components.FlySkillDataComponent.SkillEffectType.ConfirmFlyProp or effectType == BattleECS.Components.FlySkillDataComponent.SkillEffectType.ParaFlyProp or shouldBeButByShiKongZhiMen then
            leftEntity:GetComponent(BattleECS.Components.PhysicsComponent)._isNeedReleaseBox = true
            leftEntity:GetComponent(BattleECS.Components.TypeComponent)._isNeedDestroy = true
            leftEntity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake = false
            for i, inV in ipairs(self._world._playerSkillEffectEntityList) do
              if inV._entityId == leftBodyUserData.entityid then
                table.remove(self._world._playerSkillEffectEntityList, i)
                break
              end
            end
            return
          end
        end
      end
    end
    for _, v in ipairs(self._world._leftPlayerList) do
      if leftBodyUserData.entityid == v._entityId then
        if v:GetComponent(BattleECS.Components.TypeComponent)._camp ~= rightBodyUserData.camp and leftFixtureUserData.fixtype == "hitted" and rightFixtureUserData.fixtype == "normal" and v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake and rightEntity and rightEntity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake then
          table.insert(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, {
            rad = rightBodyUserData.rad,
            entityid = rightBodyUserData.entityid,
            skillid = rightBodyUserData.skillid,
            isEffect = true,
            useSkillEntityID = rightBodyUserData.useskillentityid
          })
        end
      elseif rightBodyUserData.entityid == v._entityId and leftBodyUserData.camp ~= v:GetComponent(BattleECS.Components.TypeComponent)._camp and rightFixtureUserData.fixtype == "hitted" and leftFixtureUserData.fixtype == "normal" and v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake and leftEntity and leftEntity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake then
        table.insert(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, {
          rad = leftBodyUserData.rad,
          entityid = leftBodyUserData.entityid,
          skillid = leftBodyUserData.skillid,
          isEffect = true,
          useSkillEntityID = leftBodyUserData.useskillentityid
        })
      end
    end
    for _, v in ipairs(self._world._rightPlayerList) do
      if leftBodyUserData.entityid == v._entityId then
        if v:GetComponent(BattleECS.Components.TypeComponent)._camp ~= rightBodyUserData.camp and leftFixtureUserData.fixtype == "hitted" and rightFixtureUserData.fixtype == "normal" and v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake and rightEntity and rightEntity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake then
          table.insert(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, {
            rad = rightBodyUserData.rad,
            entityid = rightBodyUserData.entityid,
            skillid = rightBodyUserData.skillid,
            isEffect = true,
            useSkillEntityID = rightBodyUserData.useskillentityid
          })
        end
      elseif rightBodyUserData.entityid == v._entityId and leftBodyUserData.camp ~= v:GetComponent(BattleECS.Components.TypeComponent)._camp and rightFixtureUserData.fixtype == "hitted" and leftFixtureUserData.fixtype == "normal" and v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake and leftEntity and leftEntity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake then
        table.insert(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, {
          rad = leftBodyUserData.rad,
          entityid = leftBodyUserData.entityid,
          skillid = leftBodyUserData.skillid,
          isEffect = true,
          useSkillEntityID = leftBodyUserData.useskillentityid
        })
      end
    end
    for _, v in ipairs(self._world._leftPlayerSummonList) do
      if leftBodyUserData.entityid == v._entityId then
        if v:GetComponent(BattleECS.Components.TypeComponent)._camp ~= rightBodyUserData.camp and leftFixtureUserData.fixtype == "hitted" and rightFixtureUserData.fixtype == "normal" and v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake and rightEntity and rightEntity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake then
          table.insert(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, {
            rad = rightBodyUserData.rad,
            entityid = rightBodyUserData.entityid,
            skillid = rightBodyUserData.skillid,
            isEffect = true,
            useSkillEntityID = rightBodyUserData.useskillentityid
          })
        end
      elseif rightBodyUserData.entityid == v._entityId and leftBodyUserData.camp ~= v:GetComponent(BattleECS.Components.TypeComponent)._camp and rightFixtureUserData.fixtype == "hitted" and leftFixtureUserData.fixtype == "normal" and v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake and leftEntity and leftEntity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake then
        table.insert(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, {
          rad = leftBodyUserData.rad,
          entityid = leftBodyUserData.entityid,
          skillid = leftBodyUserData.skillid,
          isEffect = true,
          useSkillEntityID = leftBodyUserData.useskillentityid
        })
      end
    end
    for _, v in ipairs(self._world._rightPlayerSummonList) do
      if leftBodyUserData.entityid == v._entityId then
        if v:GetComponent(BattleECS.Components.TypeComponent)._camp ~= rightBodyUserData.camp and leftFixtureUserData.fixtype == "hitted" and rightFixtureUserData.fixtype == "normal" and v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake and rightEntity and rightEntity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake then
          table.insert(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, {
            rad = rightBodyUserData.rad,
            entityid = rightBodyUserData.entityid,
            skillid = rightBodyUserData.skillid,
            isEffect = true,
            useSkillEntityID = rightBodyUserData.useskillentityid
          })
        end
      elseif rightBodyUserData.entityid == v._entityId and leftBodyUserData.camp ~= v:GetComponent(BattleECS.Components.TypeComponent)._camp and rightFixtureUserData.fixtype == "hitted" and leftFixtureUserData.fixtype == "normal" and v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake and leftEntity and leftEntity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake then
        table.insert(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, {
          rad = leftBodyUserData.rad,
          entityid = leftBodyUserData.entityid,
          skillid = leftBodyUserData.skillid,
          isEffect = true,
          useSkillEntityID = leftBodyUserData.useskillentityid
        })
      end
    end
    for _, v in ipairs(self._world._playerSkillEffectEntityList) do
      if leftBodyUserData.entityid == v._entityId then
        if v:GetComponent(BattleECS.Components.TypeComponent)._camp ~= rightBodyUserData.camp and leftFixtureUserData.fixtype == "hitted" and rightFixtureUserData.fixtype == "normal" and v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake and rightEntity and rightEntity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake then
          table.insert(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, {
            rad = rightBodyUserData.rad,
            entityid = rightBodyUserData.entityid,
            skillid = rightBodyUserData.skillid,
            isEffect = true,
            useSkillEntityID = rightBodyUserData.useskillentityid
          })
        end
      elseif rightBodyUserData.entityid == v._entityId and leftBodyUserData.camp ~= v:GetComponent(BattleECS.Components.TypeComponent)._camp and rightFixtureUserData.fixtype == "hitted" and leftFixtureUserData.fixtype == "normal" and v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake and leftEntity and leftEntity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake then
        table.insert(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, {
          rad = leftBodyUserData.rad,
          entityid = leftBodyUserData.entityid,
          skillid = leftBodyUserData.skillid,
          isEffect = true,
          useSkillEntityID = leftBodyUserData.useskillentityid
        })
      end
    end
  else
    if leftFixtureUserData.fixtype == "land" and leftBodyUserData.entityid == 0 then
      for _, v in ipairs(self._world._otherPhysicsEntityList) do
        if rightBodyUserData.entityid == v._entityId then
          table.insert(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, {
            rad = 0,
            entityid = 0,
            skillid = 0
          })
        end
      end
    elseif rightFixtureUserData.fixtype == "land" and rightBodyUserData.entityid == 0 then
      for _, v in ipairs(self._world._otherPhysicsEntityList) do
        if leftBodyUserData.entityid == v._entityId then
          table.insert(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, {
            rad = 0,
            entityid = 0,
            skillid = 0
          })
        end
      end
    end
    if leftFixtureUserData.fixtype == "lucency" and rightFixtureUserData.fixtype == "land" then
      local entity
      for _, e in ipairs(self._world._entitys) do
        if e._entityId == leftBodyUserData.entityid then
          entity = e
          break
        end
      end
      if entity then
        entity:GetComponent(BattleECS.Components.PhysicsComponent)._isNeedReleaseBox = true
        entity:GetComponent(BattleECS.Components.TypeComponent)._isNeedDestroy = true
      end
    elseif leftFixtureUserData.fixtype == "land" and rightFixtureUserData.fixtype == "lucency" then
      local entity
      for _, e in ipairs(self._world._entitys) do
        if e._entityId == rightBodyUserData.entityid then
          entity = e
          break
        end
      end
      if entity then
        entity:GetComponent(BattleECS.Components.PhysicsComponent)._isNeedReleaseBox = true
        entity:GetComponent(BattleECS.Components.TypeComponent)._isNeedDestroy = true
      end
    end
  end
end

function PhysicsSystem:worldSetEndContact(worldId, leftBodyId, leftBodyUserData, leftFixtureId, leftFixtureUserData, rightBodyId, rightBodyUserData, rightFixtureId, rightFixtureUserData)
  if leftFixtureUserData.fixtype ~= "land" and rightFixtureUserData.fixtype ~= "land" then
    for _, v in ipairs(self._world._leftPlayerList) do
      if leftBodyUserData.entityid == v._entityId then
        if leftFixtureUserData.fixtype == "hitted" then
          local removeList = {}
          for k = #v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, 1, -1 do
            local data = v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList[k]
            if data.entityid == rightBodyUserData.entityid then
              if rightFixtureUserData.fixtype == "normal" then
                BattleECS.Utility.BuffUtility.RemoveEntityBuffBySkillID(v, rightBodyUserData.skillid)
              end
              table.insert(removeList, k)
            end
          end
          for _, k in ipairs(removeList) do
            table.remove(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, k)
          end
        end
      elseif rightBodyUserData.entityid == v._entityId and rightFixtureUserData.fixtype == "hitted" then
        local removeList = {}
        for k = #v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, 1, -1 do
          local data = v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList[k]
          if data.entityid == leftBodyUserData.entityid then
            if leftFixtureUserData.fixtype == "normal" then
              BattleECS.Utility.BuffUtility.RemoveEntityBuffBySkillID(v, leftBodyUserData.skillid)
            end
            table.insert(removeList, k)
          end
        end
        for _, k in ipairs(removeList) do
          table.remove(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, k)
        end
      end
    end
    for _, v in ipairs(self._world._rightPlayerList) do
      if leftBodyUserData.entityid == v._entityId then
        if leftFixtureUserData.fixtype == "hitted" then
          local removeList = {}
          for k = #v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, 1, -1 do
            local data = v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList[k]
            if data.entityid == rightBodyUserData.entityid then
              if rightFixtureUserData.fixtype == "normal" then
                BattleECS.Utility.BuffUtility.RemoveEntityBuffBySkillID(v, rightBodyUserData.skillid)
              end
              table.insert(removeList, k)
            end
          end
          for _, k in ipairs(removeList) do
            table.remove(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, k)
          end
        end
      elseif rightBodyUserData.entityid == v._entityId and rightFixtureUserData.fixtype == "hitted" then
        local removeList = {}
        for k = #v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, 1, -1 do
          local data = v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList[k]
          if data.entityid == leftBodyUserData.entityid then
            if leftFixtureUserData.fixtype == "normal" then
              BattleECS.Utility.BuffUtility.RemoveEntityBuffBySkillID(v, leftBodyUserData.skillid)
            end
            table.insert(removeList, k)
          end
        end
        for _, k in ipairs(removeList) do
          table.remove(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, k)
        end
      end
    end
    for _, v in ipairs(self._world._leftPlayerSummonList) do
      if leftBodyUserData.entityid == v._entityId then
        if leftFixtureUserData.fixtype == "hitted" then
          local removeList = {}
          for k = #v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, 1, -1 do
            local data = v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList[k]
            if data.entityid == rightBodyUserData.entityid then
              table.insert(removeList, k)
            end
          end
          for _, k in ipairs(removeList) do
            table.remove(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, k)
          end
        end
      elseif rightBodyUserData.entityid == v._entityId and rightFixtureUserData.fixtype == "hitted" then
        local removeList = {}
        for k = #v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, 1, -1 do
          local data = v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList[k]
          if data.entityid == leftBodyUserData.entityid then
            table.insert(removeList, k)
          end
        end
        for _, k in ipairs(removeList) do
          table.remove(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, k)
        end
      end
    end
    for _, v in ipairs(self._world._rightPlayerSummonList) do
      if leftBodyUserData.entityid == v._entityId then
        if leftFixtureUserData.fixtype == "hitted" then
          local removeList = {}
          for k = #v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, 1, -1 do
            local data = v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList[k]
            if data.entityid == rightBodyUserData.entityid then
              table.insert(removeList, k)
            end
          end
          for _, k in ipairs(removeList) do
            table.remove(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, k)
          end
        end
      elseif rightBodyUserData.entityid == v._entityId and rightFixtureUserData.fixtype == "hitted" then
        local removeList = {}
        for k = #v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, 1, -1 do
          local data = v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList[k]
          if data.entityid == leftBodyUserData.entityid then
            table.insert(removeList, k)
          end
        end
        for _, k in ipairs(removeList) do
          table.remove(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, k)
        end
      end
    end
    for _, v in ipairs(self._world._playerSkillEffectEntityList) do
      if leftBodyUserData.entityid == v._entityId then
        if leftFixtureUserData.fixtype == "normal" then
          local removeList = {}
          for k = #v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, 1, -1 do
            local data = v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList[k]
            if data.entityid == rightBodyUserData.entityid then
              table.insert(removeList, k)
            end
          end
          for _, k in ipairs(removeList) do
            table.remove(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, k)
          end
        end
      elseif rightBodyUserData.entityid == v._entityId and rightFixtureUserData.fixtype == "normal" then
        local removeList = {}
        for k = #v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, 1, -1 do
          local data = v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList[k]
          if data.entityid == leftBodyUserData.entityid then
            table.insert(removeList, k)
          end
        end
        for _, k in ipairs(removeList) do
          table.remove(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, k)
        end
      end
    end
  elseif leftFixtureUserData.fixtype == "land" and leftBodyUserData.entityid == 0 then
    for _, v in ipairs(self._world._otherPhysicsEntityList) do
      if rightBodyUserData.entityid == v._entityId then
        local removeList = {}
        for k = #v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, 1, -1 do
          local data = v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList[k]
          if data.entityid == 0 then
            table.insert(removeList, k)
          end
        end
        for _, k in ipairs(removeList) do
          table.remove(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, k)
        end
      end
    end
  elseif rightFixtureUserData.fixtype == "land" and rightBodyUserData.entityid == 0 then
    for _, v in ipairs(self._world._otherPhysicsEntityList) do
      if leftBodyUserData.entityid == v._entityId then
        local removeList = {}
        for k = #v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, 1, -1 do
          local data = v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList[k]
          if data.entityid == 0 then
            table.insert(removeList, k)
          end
        end
        for _, k in ipairs(removeList) do
          table.remove(v:GetComponent(BattleECS.Components.PhysicsComponent)._hittedContactList, k)
        end
      end
    end
  end
end

function PhysicsSystem:Destroy()
  PhysicsSystem.super.Destroy(self)
end

function PhysicsSystem:Update()
  local PositionComponent = BattleECS.Components.PositionComponent
  local PhysicsComponent = BattleECS.Components.PhysicsComponent
  local TypeComponent = BattleECS.Components.TypeComponent
  local AnimationEventComponent = BattleECS.Components.AnimationEventComponent
  local FlySkillDataComponent = BattleECS.Components.FlySkillDataComponent
  local HpComponent = BattleECS.Components.HpComponent
  box2d.worldStep(self._world._physicsWorld, 30, 8, 3)
  for _, entity in ipairs(self._entitys) do
    local position = entity:GetComponent(PositionComponent)
    local physics = entity:GetComponent(PhysicsComponent)
    local camp = entity:GetComponent(TypeComponent)._camp
    if position and physics then
      local b1x, b1y = position._position.x, position._position.y
      if not self._utility.IsToTargetXPoint(entity) then
        if self._world:GetCampWinState() == "" then
          local component = entity:GetComponent(AnimationEventComponent)
          if component and not component._roleIsInPositionChangeAnimationState and not self._buffUtility.IsRoleHasCanNotActiveMoveBuff(entity) then
            if camp == TypeComponent.CampType.Right then
              local speedX = physics._toTargetCurrentSpeed.x + 10
              speedX = fixedpoint.min(speedX, physics._toTargetMaxSpeed.x)
              local x = b1x - speedX
              local y = b1y
              x = fixedpoint.max(x, position._targetPos.x)
              b1x = x
              b1y = y
              position._position.x, position._position.y = x, y
              self._physicsUtility.SetEnityPhysicsComponentCurrentSpeed(entity, speedX)
              if not physics._isStartMove and not self._utility.IsRoleDead(entity) then
                local ifIgnorePriority = {No = 0, Yes = 1}
                self._protocolUtility.SendBattlerPlayAnimationByNameProtocol(entity, "Move", ifIgnorePriority.Yes, self._world)
                physics._isStartMove = true
                physics._isStopMove = false
              end
            elseif camp == TypeComponent.CampType.Left then
              if physics._isStartMove then
                physics._moveCurrentFraps = physics._moveCurrentFraps + 1
              end
              if physics._isStartMove and physics._moveCurrentFraps >= physics._moveMaxFraps or not physics._isStartMove then
                local speedX = physics._toTargetCurrentSpeed.x + 10
                speedX = fixedpoint.min(speedX, physics._toTargetMaxSpeed.x)
                local x = b1x + speedX
                if entity:GetComponent(TypeComponent)._isImaged then
                  x = b1x - speedX
                end
                local y = b1y
                x = fixedpoint.min(x, position._targetPos.x)
                b1x = x
                b1y = y
                position._position.x, position._position.y = x, y
                self._physicsUtility.SetEnityPhysicsComponentCurrentSpeed(entity, speedX)
                if not physics._isStartMove and not self._utility.IsRoleDead(entity) then
                  local ifIgnorePriority = {No = 0, Yes = 1}
                  self._protocolUtility.SendBattlerPlayAnimationByNameProtocol(entity, "Move", ifIgnorePriority.Yes, self._world)
                  physics._isStartMove = true
                  physics._isStopMove = false
                end
              end
            end
          end
        end
      else
        local component = entity:GetComponent(FlySkillDataComponent)
        if component and component._skillEffectType == FlySkillDataComponent.SkillEffectType.ParaFlyProp then
        else
          self._physicsUtility.SetEnityPhysicsComponentCurrentSpeed(entity, fixedpoint_zero)
          if not physics._isStopMove and not self._utility.IsRoleDead(entity) then
            local ifIgnorePriority = {No = 0, Yes = 1}
            self._protocolUtility.SendBattlerPlayAnimationByNameProtocol(entity, "MoveEnd", ifIgnorePriority.No, self._world)
            physics._isStartMove = false
            physics._isStopMove = true
            physics._moveCurrentFraps = 0
          end
        end
      end
      local hpComponent = entity:GetComponent(HpComponent)
      if not (not hpComponent or self._utility.IsRoleDead(entity)) or not hpComponent then
        if physics._isChangePositionToUseSkillEntity then
          local useSkillEntity
          for _, e in ipairs(self._world._entitys) do
            if e._entityId == physics._useSkillEntityEntityID then
              useSkillEntity = e
              break
            end
          end
          if useSkillEntity then
            local pos = useSkillEntity:GetComponent(PositionComponent)._position
            local deltapos = entity:GetComponent(PositionComponent)._toUseSkillEntityPositonDeltaPosition
            x = pos.x + deltapos.x
            y = pos.y + deltapos.y
            b1x = x
            b1y = y
            position._position.x, position._position.y = x, y
          end
        end
        component = entity:GetComponent(FlySkillDataComponent)
        if component and component._skillEffectType == FlySkillDataComponent.SkillEffectType.ParaFlyProp then
          if camp == TypeComponent.CampType.Right then
            local speedX = physics._toTargetCurrentSpeed.x
            local x = b1x + speedX
            local speedY = physics._toTargetCurrentSpeed.y + physics._toTargetAcceleration.y
            local y = b1y + speedY
            b1x = x
            b1y = y
            position._position.x, position._position.y = x, y
            self._physicsUtility.SetEnityPhysicsComponentCurrentSpeed(entity, speedX, speedY)
          elseif camp == TypeComponent.CampType.Left then
          end
        end
        position._position.x = b1x
        position._position.y = b1y
      end
      position._position.x = position._position.x + position._velocity.x / 30
      position._position.y = position._position.y + position._velocity.y / 30
      self._physicsUtility.SetEntityPosition(self._world._physicsWorld, entity, position._position.x, position._position.y)
      if self._world._battleID == 1122 and self._world:GetCampWinState() ~= "" then
        self._utility.ShiXiangGuiBattleEndMoveFun(entity)
      end
    end
  end
end

return PhysicsSystem
