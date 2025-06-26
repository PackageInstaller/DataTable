-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/system/releasesystem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = require("ecs.system")
local ReleaseSystem = strictclass("ReleaseSystem", System)
ReleaseSystem.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReleaseSystem, _ENV
  ((ReleaseSystem.super).Ctor)(self, ...)
  self._utility = (BattleECS.Utility).Utility
  self._protocolUtility = (BattleECS.Utility).ProtocolUtility
end

ReleaseSystem.Destroy = function(self)
  -- function num : 0_1 , upvalues : ReleaseSystem
  ((ReleaseSystem.super).Destroy)(self)
end

ReleaseSystem.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local PositionComponent = (BattleECS.Components).PositionComponent
  local PhysicsComponent = (BattleECS.Components).PhysicsComponent
  local TypeComponent = (BattleECS.Components).TypeComponent
  local SkillEffectComponent = (BattleECS.Components).SkillEffectComponent
  local AnimationEventComponent = (BattleECS.Components).AnimationEventComponent
  local worldEntitysRemoveList = {}
  for _,entity in ipairs((self._world)._entitys) do
    local pComponent = entity:GetComponent(PhysicsComponent)
    if pComponent and pComponent._isNeedReleaseBox then
      (self._world):DestroyPhysicsBody(pComponent._box2DBodyID)
    end
    local tComponent = entity:GetComponent(TypeComponent)
    if tComponent and tComponent._isNeedDestroy then
      for camp,entityId in pairs((self._world)._actor_shiKongZhiMen_entityId) do
        if entity._entityId == entityId then
          for _,v in pairs((self._world)._actor_shiKongZhiMenRelease_effectList) do
            if camp == v.camp then
              ((self._protocolUtility).SendSetClipRectForShiKongZhiMen)(v.entityId, ((self._world)._actor_shiKongZhiMen_w)[v.camp], ((self._world)._actor_shiKongZhiMen_h)[v.camp], v.camp, v.effectName, self._world, false)
            end
          end
          -- DECOMPILER ERROR at PC77: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (self._world)._actor_shiKongZhiMen_effectList = {}
          -- DECOMPILER ERROR at PC80: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (self._world)._actor_shiKongZhiMenRelease_effectList = {}
          -- DECOMPILER ERROR at PC83: Confused about usage of register: R19 in 'UnsetPending'

          ;
          ((self._world)._actor_shiKongZhiMen_entityId)[camp] = nil
          -- DECOMPILER ERROR at PC86: Confused about usage of register: R19 in 'UnsetPending'

          ;
          ((self._world)._actor_shiKongZhiMen_w)[camp] = nil
          -- DECOMPILER ERROR at PC89: Confused about usage of register: R19 in 'UnsetPending'

          ;
          ((self._world)._actor_shiKongZhiMen_h)[camp] = nil
          break
        end
      end
      do
        if tComponent._isNeedSendProtocolDestroy then
          local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sdestroyobject")
          protocol.entityid = entity._entityId
          protocol.skillid = tComponent._bindingSkillID
          if tComponent._isImaged then
            protocol.isimageentity = 1
            local pos = entity:GetComponent(PositionComponent)
            local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(entity)
            local delt = ((self._utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, "HitPoint")
            local x, y = (pos._position).x - delt.x, (pos._position).y + delt.y
            ;
            ((self._protocolUtility).SCreateSceneEffect)(3004104, x, y, 0, 1, self._world)
          else
            do
              do
                protocol.isimageentity = 0
                if tComponent._summonName == "partner" then
                  protocol.ispartner = 1
                else
                  protocol.ispartner = 0
                end
                ;
                (self._world):InsertViewProtocolData(protocol)
                ;
                (table.insert)(worldEntitysRemoveList, entity._entityId)
                ;
                (self._world):RemoveOtherPhysicsEntityList(entity._entityId)
                do
                  local removeList = {}
                  for i = #(self._world)._leftPlayerSummonList, 1, -1 do
                    local e = ((self._world)._leftPlayerSummonList)[i]
                    if e._entityId == entity._entityId then
                      (table.insert)(removeList, i)
                    end
                  end
                  for _,i in ipairs(removeList) do
                    (table.remove)((self._world)._leftPlayerSummonList, i)
                  end
                  removeList = {}
                  for i = #(self._world)._rightPlayerSummonList, 1, -1 do
                    local e = ((self._world)._rightPlayerSummonList)[i]
                    if e._entityId == entity._entityId then
                      (table.insert)(removeList, i)
                    end
                  end
                  for _,i in ipairs(removeList) do
                    (table.remove)((self._world)._rightPlayerSummonList, i)
                  end
                  removeList = {}
                  for i = #(self._world)._playerSkillEffectEntityList, 1, -1 do
                    local e = ((self._world)._playerSkillEffectEntityList)[i]
                    if e._entityId == entity._entityId then
                      (table.insert)(removeList, i)
                    end
                  end
                  for _,i in ipairs(removeList) do
                    (table.remove)((self._world)._playerSkillEffectEntityList, i)
                  end
                  removeList = {}
                  for i = #(self._world)._shape20030FlyBallSet, 1, -1 do
                    local e = ((self._world)._shape20030FlyBallSet)[i]
                    if e._entityId == entity._entityId then
                      (table.insert)(removeList, i)
                    end
                  end
                  for _,i in ipairs(removeList) do
                    (table.remove)((self._world)._shape20030FlyBallSet, i)
                  end
                  -- DECOMPILER ERROR at PC294: Confused about usage of register: R15 in 'UnsetPending'

                  ;
                  ((self._world)._actor_shiKongZhiMen_effectList)[entity._entityId] = nil
                  -- DECOMPILER ERROR at PC298: Confused about usage of register: R15 in 'UnsetPending'

                  ;
                  ((self._world)._actor_shiKongZhiMenRelease_effectList)[entity._entityId] = nil
                  -- DECOMPILER ERROR at PC302: Confused about usage of register: R15 in 'UnsetPending'

                  ;
                  ((self._world)._actor_shiKongTingZhi_effectList)[entity._entityId] = nil
                  -- DECOMPILER ERROR at PC303: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC303: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC303: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC303: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC303: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC303: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC303: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC303: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC303: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
  for _,entityId in ipairs(worldEntitysRemoveList) do
    (self._world):DeleteEntity(entityId)
  end
end

return ReleaseSystem

