local YardSceneHelper = CS.PixelNeko.P1.Scene.YardSceneHelper
local BoxColiderStaticFunctions = CS.PixelNeko.Lua.BoxColiderStaticFunctions
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local UIEventTriggerHelper = CS.PixelNeko.UI.EventTriggerHelper
local EffectStaticFunctions = CS.PixelNeko.Lua.UI.EffectStaticFunctions
local Light = strictclass("Light")

function Light:Ctor(itemId, itemKey)
  self._itemId = itemId
  self._key = itemKey
  self._parentPointObject = nil
end

function Light:Destroy()
  self._task = nil
  CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._gameObject)
  self._gameObject = nil
end

function Light:CreatePlayer(pointObject)
  self._parentPointObject = pointObject
  local effectId
  local asset = {}
  asset.assetBundleName = "sceneobjects/home.prefabs.assetbundle"
  if self._itemId == DataCommon.WhiteLight then
    asset.prefabName = "home_glow_01"
    effectId = 1027
  elseif self._itemId == DataCommon.DarkLight then
    asset.prefabName = "home_glow_02"
    effectId = 1028
  elseif self._itemId == DataCommon.ColorLight then
    asset.prefabName = "home_glow_03"
    effectId = 1029
  end
  if not asset.prefabName then
    LogErrorFormat("Light", "item with id %s is not lights", self._itemId)
  end
  self._gameObject = YardSceneHelper.CreatePlayer(asset.assetBundleName, asset.prefabName, pointObject)
  if effectId then
    local assetBundleName, assetName = EffectUtil.GetAssetBundleNameAndAssetName(effectId)
    YardSceneHelper.CreateEffect(assetBundleName, assetName, self._gameObject)
  end
end

function Light:SetClickParam(intData)
  local sceneObjectClick = SceneObjectClick.GetSceneObjectClick(self._gameObject)
  if sceneObjectClick == nil then
    return
  end
  sceneObjectClick.IntData = intData
end

return Light
