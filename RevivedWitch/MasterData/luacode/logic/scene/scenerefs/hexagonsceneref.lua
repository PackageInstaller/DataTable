-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/hexagonsceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local TimelineManager = (((CS.PixelNeko).P1).TimeLine).TimelineManager
local SceneRef = require("logic.scene.scenerefs.sceneref")
local HexagonSceneRef = class("HexagonSceneRef", SceneRef)
HexagonSceneRef.Init = function(self)
  -- function num : 0_0 , upvalues : HexagonSceneRef, TransformStaticFunctions, GlobalCameras
  ((HexagonSceneRef.super).Init)(self)
  self._cameraPoint = (TransformStaticFunctions.GetChild)(self._rootGameObject, "CameraFollowPoint")
  self._blockParent = ((TransformStaticFunctions.GetChild)(self._rootGameObject, "BlockParent")).transform
  self._nightLight = (TransformStaticFunctions.GetChild)(self._rootGameObject, "DungeonCameraGroup/MainCamera/NightLight")
  self._dayLight = (TransformStaticFunctions.GetChild)(self._rootGameObject, "DayLight")
  self._timeLineGameObject = (TransformStaticFunctions.GetChild)(self._rootGameObject, "CloudCamera")
  self._sence_TX_yun_Day = (TransformStaticFunctions.GetChild)(self._rootGameObject, "DungeonCameraGroup/MainCamera/Effect/Sence_TX_yun_Day")
  self._sence_TX_yun_Night = (TransformStaticFunctions.GetChild)(self._rootGameObject, "DungeonCameraGroup/MainCamera/Effect/Sence_TX_yun_Night")
  self._waterPlaneDay = (TransformStaticFunctions.GetChild)(self._rootGameObject, "WaterPlaneDay")
  self._waterPlaneNight = (TransformStaticFunctions.GetChild)(self._rootGameObject, "WaterPlaneNight")
  self._cameraPosition = ((self._cameraPoint).transform).position
  self._mainCamera = (GlobalCameras.GetCamera)("Main")
end

return HexagonSceneRef

