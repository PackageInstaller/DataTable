local SceneRef = require("logic.scene.scenerefs.sceneref")
local TowerRef = class("TowerRef", SceneRef)
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras

function TowerRef:Init()
  TowerRef.super.Init(self)
  local maproot = TransformStaticFunctions.GetChild(self:GetRootGameObject(), "Map")
  local pos = CS.PixelNeko.P1.Scene.TrapHelper.GetObjectsWithID(maproot)
  self.pos = {}
  for object, id in pairs(pos) do
    self.pos[id] = object
  end
  self.actor = {
    object = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, "ActorTower")
  }
  self.actor.animator = self.actor.object:GetComponent("Animator")
  self.cameraFollowPoint2 = TransformStaticFunctions.GetChild(self._rootGameObject, "CameraFollowPoint2")
  self.cameraFollowPoint3 = TransformStaticFunctions.GetChild(self._rootGameObject, "CameraFollowPoint3")
  self.mainCamera = GlobalCameras.GetCamera("DormMain")
  self._stateDrivenCameraGameObject = TransformStaticFunctions.GetChild(self._rootGameObject, "CM StateDrivenCamera1")
  self._stateDrivenCameraAnimator = self._stateDrivenCameraGameObject:GetComponent("Animator")
  self._dirX = CS.UnityEngine.Animator.StringToHash("dirx")
  self._dirY = CS.UnityEngine.Animator.StringToHash("diry")
  self.backgroundAnchor = TransformStaticFunctions.GetChild(self._rootGameObject, "DormSceneCameraGroup/Main Camera/BackGround")
end

return TowerRef
