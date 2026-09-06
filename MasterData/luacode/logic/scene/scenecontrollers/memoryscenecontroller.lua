local MemorySceneBehaviour = CS.PixelNeko.P1.MemoryScene.MemorySceneBehaviour
local ParticleSystemStaticFunctions = CS.PixelNeko.Lua.ParticleSystemStaticFunctions
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local CWaterSceneEffect = BeanManager.GetTableByName("scene.cwatersceneeffect")
local SkySceneController = require("logic.scene.scenecontrollers.skyscenecontroller")
local MemorySceneController = class("MemorySceneController", SkySceneController)

function MemorySceneController:Ctor(sceneRef)
  MemorySceneController.super.Ctor(self, sceneRef)
end

function MemorySceneController:Init()
  MemorySceneController.super.Init(self)
  local record = CWaterSceneEffect:GetRecorder(1)
  self._blockInfoTable = {}
  self._squaredEffectDistance = record.effectDistance
  self._effectLiveTime = record.effectLifeTime / 1000
  self._lastColliderID = nil
  self._effectAssetBundleName, self._effectAssetName = EffectUtil.GetAssetBundleNameAndAssetName(record.effectId)
  MemorySceneBehaviour.SetOnCollisionCallback(self._sceneRef.actor.object, self, self.OnCollision)
end

function MemorySceneController:OnDestroy()
  MemorySceneController.super.OnDestroy(self)
  MemorySceneBehaviour.SetOnCollisionCallback(self._sceneRef.actor.object, nil, nil)
end

local function IsInDistance(self, pos1, pos2)
  local distance = pos2 - pos1
  return distance.x * distance.x + distance.y * distance.y + distance.z * distance.z < self._squaredEffectDistance
end

function MemorySceneController:Update(deltaTime, unscaleDeltaTime)
  MemorySceneController.super.Update(self, deltaTime, unscaleDeltaTime)
  local toDeleteList = {}
  for k, v in pairs(self._blockInfoTable) do
    local leftTIme = v.leftTime - deltaTime
    if leftTIme <= 0 then
      table.insert(toDeleteList, k)
    else
      v.leftTime = leftTIme
    end
  end
  for k, v in ipairs(toDeleteList) do
    self._blockInfoTable[v] = nil
  end
end

function MemorySceneController:OnCollision(pos, euler, colliderID)
  local isPlayEffect = true
  if self._lastColliderID == colliderID then
    for k, v in pairs(self._blockInfoTable) do
      if IsInDistance(self, pos, v.pos) then
        isPlayEffect = false
        break
      end
    end
  end
  if isPlayEffect == false then
    return
  end
  local effectPrefab, loadHandler = PrefabLoader.LoadAndInstantiatePrefab(self._effectAssetBundleName, self._effectAssetName)
  TransformStaticFunctions.SetPosition(effectPrefab, pos.x, pos.y, pos.z)
  TransformStaticFunctions.SetWorldEuler(effectPrefab, euler.x, euler.y, euler.z)
  TransformStaticFunctions.SetParent(effectPrefab.transform, self._sceneRef._effectNodeTransform, true)
  local blockInfo = {}
  blockInfo.pos = pos
  blockInfo.effect = effectPrefab
  blockInfo.leftTime = self._effectLiveTime
  blockInfo.colliderID = colliderID
  self._blockInfoTable[loadHandler] = blockInfo
  self:ResetRocker()
end

return MemorySceneController
