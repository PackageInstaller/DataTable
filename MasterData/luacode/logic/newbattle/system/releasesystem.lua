local System = require("ecs.system")
local ReleaseSystem = strictclass("ReleaseSystem", System)

function ReleaseSystem:Ctor(...)
  ReleaseSystem.super.Ctor(self, ...)
  self._utility = BattleECS.Utility.Utility
  self._protocolUtility = BattleECS.Utility.ProtocolUtility
end

function ReleaseSystem:Destroy()
  ReleaseSystem.super.Destroy(self)
end

function ReleaseSystem:Update()
  local PositionComponent = BattleECS.Components.PositionComponent
  local PhysicsComponent = BattleECS.Components.PhysicsComponent
  local TypeComponent = BattleECS.Components.TypeComponent
  local SkillEffectComponent = BattleECS.Components.SkillEffectComponent
  local AnimationEventComponent = BattleECS.Components.AnimationEventComponent
  local worldEntitysRemoveList = {}
  for _, entity in ipairs(self._world._entitys) do
    local pComponent = entity:GetComponent(PhysicsComponent)
    if pComponent and pComponent._isNeedReleaseBox then
      self._world:DestroyPhysicsBody(pComponent._box2DBodyID)
    end
    local tComponent = entity:GetComponent(TypeComponent)
    if tComponent and tComponent._isNeedDestroy then
      for camp, entityId in pairs(self._world._actor_shiKongZhiMen_entityId) do
        if entity._entityId == entityId then
          for _, v in pairs(self._world._actor_shiKongZhiMenRelease_effectList) do
            if camp == v.camp then
              self._protocolUtility.SendSetClipRectForShiKongZhiMen(v.entityId, self._world._actor_shiKongZhiMen_w[v.camp], self._world._actor_shiKongZhiMen_h[v.camp], v.camp, v.effectName, self._world, false)
            end
          end
          self._world._actor_shiKongZhiMen_effectList = {}
          self._world._actor_shiKongZhiMenRelease_effectList = {}
          self._world._actor_shiKongZhiMen_entityId[camp] = nil
          self._world._actor_shiKongZhiMen_w[camp] = nil
          self._world._actor_shiKongZhiMen_h[camp] = nil
          break
        end
      end
      if tComponent._isNeedSendProtocolDestroy then
        local protocol = BattleClientProtocolManager.CreateProtocol("action.sdestroyobject")
        protocol.entityid = entity._entityId
        protocol.skillid = tComponent._bindingSkillID
        if tComponent._isImaged then
          protocol.isimageentity = 1
          local pos = entity:GetComponent(PositionComponent)
          local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(entity)
          local delt = self._utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, "HitPoint")
          local x, y = pos._position.x - delt.x, pos._position.y + delt.y
          self._protocolUtility.SCreateSceneEffect(3004104, x, y, 0, 1, self._world)
        else
          protocol.isimageentity = 0
        end
        if tComponent._summonName == "partner" then
          protocol.ispartner = 1
        else
          protocol.ispartner = 0
        end
        self._world:InsertViewProtocolData(protocol)
      end
      table.insert(worldEntitysRemoveList, entity._entityId)
      self._world:RemoveOtherPhysicsEntityList(entity._entityId)
      local removeList = {}
      for i = #self._world._leftPlayerSummonList, 1, -1 do
        local e = self._world._leftPlayerSummonList[i]
        if e._entityId == entity._entityId then
          table.insert(removeList, i)
        end
      end
      for _, i in ipairs(removeList) do
        table.remove(self._world._leftPlayerSummonList, i)
      end
      removeList = {}
      for i = #self._world._rightPlayerSummonList, 1, -1 do
        local e = self._world._rightPlayerSummonList[i]
        if e._entityId == entity._entityId then
          table.insert(removeList, i)
        end
      end
      for _, i in ipairs(removeList) do
        table.remove(self._world._rightPlayerSummonList, i)
      end
      removeList = {}
      for i = #self._world._playerSkillEffectEntityList, 1, -1 do
        local e = self._world._playerSkillEffectEntityList[i]
        if e._entityId == entity._entityId then
          table.insert(removeList, i)
        end
      end
      for _, i in ipairs(removeList) do
        table.remove(self._world._playerSkillEffectEntityList, i)
      end
      removeList = {}
      for i = #self._world._shape20030FlyBallSet, 1, -1 do
        local e = self._world._shape20030FlyBallSet[i]
        if e._entityId == entity._entityId then
          table.insert(removeList, i)
        end
      end
      for _, i in ipairs(removeList) do
        table.remove(self._world._shape20030FlyBallSet, i)
      end
      self._world._actor_shiKongZhiMen_effectList[entity._entityId] = nil
      self._world._actor_shiKongZhiMenRelease_effectList[entity._entityId] = nil
      self._world._actor_shiKongTingZhi_effectList[entity._entityId] = nil
    end
  end
  for _, entityId in ipairs(worldEntitysRemoveList) do
    self._world:DeleteEntity(entityId)
  end
end

return ReleaseSystem
