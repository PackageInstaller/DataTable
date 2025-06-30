-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/baseguidesceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local CinemachineVirtualCameraStaticFunctions = (((CS.PixelNeko).Lua).Cinemachine).CinemachineVirtualCameraStaticFunctions
local CinemachineStateDrivenCameraStaticFunctions = (((CS.PixelNeko).Lua).Cinemachine).CinemachineStateDrivenCameraStaticFunctions
local CameraStaticFunctions = ((CS.PixelNeko).Lua).CameraStaticFunctions
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local BaseGuideSceneRef = class("BaseGuideSceneRef", NewBattleSceneRef)
BaseGuideSceneRef.Init = function(self, ...)
  -- function num : 0_0 , upvalues : BaseGuideSceneRef, TransformStaticFunctions, CameraStaticFunctions
  ((BaseGuideSceneRef.super).Init)(self, ...)
  self._acter1 = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Story/ActorFirstBattle")
  self._timeline1 = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Story/TimeLine/TimeLine1")
  self._timeline2 = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Story/TimeLine/TimeLine2")
  self._timeline3 = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Story/TimeLine/TimeLine3")
  self._timeline16 = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Story/TimeLine/TimeLine16")
  self._mainCamera = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BaseTest/BattleSceneCameraGroup/Main Camera")
  self._mainCameraComponent = (CameraStaticFunctions.Get)(self._mainCamera)
  self._mirror = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Story/base_item_01")
  self._gate = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BaseTest/InteractableObjs/base_gate")
  self._spring = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BaseTest/InteractableObjs/base_soulfountain")
  self._battleCamera = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Story/TimeLineCamera/Camera5")
end

BaseGuideSceneRef.BSR_GetBattleCamera = function(self)
  -- function num : 0_1
  return self._battleCamera
end

return BaseGuideSceneRef

