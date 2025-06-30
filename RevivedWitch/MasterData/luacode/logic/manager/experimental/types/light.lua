-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/light.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local YardSceneHelper = (((CS.PixelNeko).P1).Scene).YardSceneHelper
local BoxColiderStaticFunctions = ((CS.PixelNeko).Lua).BoxColiderStaticFunctions
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local UIEventTriggerHelper = ((CS.PixelNeko).UI).EventTriggerHelper
local EffectStaticFunctions = (((CS.PixelNeko).Lua).UI).EffectStaticFunctions
local Light = strictclass("Light")
Light.Ctor = function(self, itemId, itemKey)
  -- function num : 0_0
  self._itemId = itemId
  self._key = itemKey
  self._parentPointObject = nil
end

Light.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._task = nil
  ;
  ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._gameObject)
  self._gameObject = nil
end

Light.CreatePlayer = function(self, pointObject)
  -- function num : 0_2 , upvalues : _ENV, YardSceneHelper
  self._parentPointObject = pointObject
  local effectId = nil
  local asset = {}
  asset.assetBundleName = "sceneobjects/home.prefabs.assetbundle"
  if self._itemId == DataCommon.WhiteLight then
    asset.prefabName = "home_glow_01"
    effectId = 1027
  else
    if self._itemId == DataCommon.DarkLight then
      asset.prefabName = "home_glow_02"
      effectId = 1028
    else
      if self._itemId == DataCommon.ColorLight then
        asset.prefabName = "home_glow_03"
        effectId = 1029
      end
    end
  end
  if not asset.prefabName then
    LogErrorFormat("Light", "item with id %s is not lights", self._itemId)
  end
  self._gameObject = (YardSceneHelper.CreatePlayer)(asset.assetBundleName, asset.prefabName, pointObject)
  if effectId then
    local assetBundleName, assetName = (EffectUtil.GetAssetBundleNameAndAssetName)(effectId)
    ;
    (YardSceneHelper.CreateEffect)(assetBundleName, assetName, self._gameObject)
  end
end

Light.SetClickParam = function(self, intData)
  -- function num : 0_3 , upvalues : SceneObjectClick
  local sceneObjectClick = (SceneObjectClick.GetSceneObjectClick)(self._gameObject)
  if sceneObjectClick == nil then
    return 
  end
  sceneObjectClick.IntData = intData
end

return Light

