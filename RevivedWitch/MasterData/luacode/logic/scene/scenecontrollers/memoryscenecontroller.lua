-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/memoryscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MemorySceneBehaviour = (((CS.PixelNeko).P1).MemoryScene).MemorySceneBehaviour
local ParticleSystemStaticFunctions = ((CS.PixelNeko).Lua).ParticleSystemStaticFunctions
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local CWaterSceneEffect = (BeanManager.GetTableByName)("scene.cwatersceneeffect")
local SkySceneController = require("logic.scene.scenecontrollers.skyscenecontroller")
local MemorySceneController = class("MemorySceneController", SkySceneController)
MemorySceneController.Ctor = function(self, sceneRef)
  -- function num : 0_0 , upvalues : MemorySceneController
  ((MemorySceneController.super).Ctor)(self, sceneRef)
end

MemorySceneController.Init = function(self)
  -- function num : 0_1 , upvalues : MemorySceneController, CWaterSceneEffect, _ENV, MemorySceneBehaviour
  ((MemorySceneController.super).Init)(self)
  local record = CWaterSceneEffect:GetRecorder(1)
  self._blockInfoTable = {}
  self._squaredEffectDistance = record.effectDistance
  self._effectLiveTime = record.effectLifeTime / 1000
  self._lastColliderID = nil
  self._effectAssetBundleName = (EffectUtil.GetAssetBundleNameAndAssetName)(record.effectId)
  ;
  (MemorySceneBehaviour.SetOnCollisionCallback)(((self._sceneRef).actor).object, self, self.OnCollision)
end

MemorySceneController.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : MemorySceneController, MemorySceneBehaviour
  ((MemorySceneController.super).OnDestroy)(self)
  ;
  (MemorySceneBehaviour.SetOnCollisionCallback)(((self._sceneRef).actor).object, nil, nil)
end

local IsInDistance = function(self, pos1, pos2)
  -- function num : 0_3
  local distance = pos2 - pos1
  do return distance.x * distance.x + distance.y * distance.y + distance.z * distance.z < self._squaredEffectDistance end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

MemorySceneController.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_4 , upvalues : MemorySceneController, _ENV
  ((MemorySceneController.super).Update)(self, deltaTime, unscaleDeltaTime)
  local toDeleteList = {}
  for k,v in pairs(self._blockInfoTable) do
    local leftTIme = v.leftTime - deltaTime
    if leftTIme <= 0 then
      (table.insert)(toDeleteList, k)
    else
      v.leftTime = leftTIme
    end
  end
  for k,v in ipairs(toDeleteList) do
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R9 in 'UnsetPending'

    (self._blockInfoTable)[v] = nil
  end
end

MemorySceneController.OnCollision = function(self, pos, euler, colliderID)
  -- function num : 0_5 , upvalues : _ENV, IsInDistance, PrefabLoader, TransformStaticFunctions
  local isPlayEffect = true
  if self._lastColliderID == colliderID then
    for k,v in pairs(self._blockInfoTable) do
      if IsInDistance(self, pos, v.pos) then
        isPlayEffect = false
        break
      end
    end
  end
  do
    if isPlayEffect == false then
      return 
    end
    local effectPrefab, loadHandler = (PrefabLoader.LoadAndInstantiatePrefab)(self._effectAssetBundleName, self._effectAssetName)
    ;
    (TransformStaticFunctions.SetPosition)(effectPrefab, pos.x, pos.y, pos.z)
    ;
    (TransformStaticFunctions.SetWorldEuler)(effectPrefab, euler.x, euler.y, euler.z)
    ;
    (TransformStaticFunctions.SetParent)(effectPrefab.transform, (self._sceneRef)._effectNodeTransform, true)
    local blockInfo = {}
    blockInfo.pos = pos
    blockInfo.effect = effectPrefab
    blockInfo.leftTime = self._effectLiveTime
    blockInfo.colliderID = colliderID
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self._blockInfoTable)[loadHandler] = blockInfo
    self:ResetRocker()
  end
end

return MemorySceneController

