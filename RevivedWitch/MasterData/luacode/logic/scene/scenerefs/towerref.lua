-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/towerref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneRef = require("logic.scene.scenerefs.sceneref")
local TowerRef = class("TowerRef", SceneRef)
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
TowerRef.Init = function(self)
  -- function num : 0_0 , upvalues : TowerRef, TransformStaticFunctions, _ENV, GlobalCameras
  ((TowerRef.super).Init)(self)
  local maproot = (TransformStaticFunctions.GetChild)(self:GetRootGameObject(), "Map")
  local pos = (((((CS.PixelNeko).P1).Scene).TrapHelper).GetObjectsWithID)(maproot)
  self.pos = {}
  for object,id in pairs(pos) do
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'

    (self.pos)[id] = object
  end
  self.actor = {object = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "ActorTower")}
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.actor).animator = ((self.actor).object):GetComponent("Animator")
  self.cameraFollowPoint2 = (TransformStaticFunctions.GetChild)(self._rootGameObject, "CameraFollowPoint2")
  self.cameraFollowPoint3 = (TransformStaticFunctions.GetChild)(self._rootGameObject, "CameraFollowPoint3")
  self.mainCamera = (GlobalCameras.GetCamera)("DormMain")
  self._stateDrivenCameraGameObject = (TransformStaticFunctions.GetChild)(self._rootGameObject, "CM StateDrivenCamera1")
  self._stateDrivenCameraAnimator = (self._stateDrivenCameraGameObject):GetComponent("Animator")
  self._dirX = (((CS.UnityEngine).Animator).StringToHash)("dirx")
  self._dirY = (((CS.UnityEngine).Animator).StringToHash)("diry")
  self.backgroundAnchor = (TransformStaticFunctions.GetChild)(self._rootGameObject, "DormSceneCameraGroup/Main Camera/BackGround")
end

return TowerRef

