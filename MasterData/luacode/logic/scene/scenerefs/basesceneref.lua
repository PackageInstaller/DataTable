local cBaseText = BeanManager.GetTableByName("scene.cbasetext")
local CHomeNpcCfgTable = BeanManager.GetTableByName("dialog.chomenpcconfig")
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local SceneRef = require("logic.scene.scenerefs.sceneref")
local BaseSceneRef = class("BaseSceneRef", SceneRef)
BaseSceneRef.CharType = {Guide001 = 1, Guide013 = 2}

function BaseSceneRef:GetSceneControllerName()
  return "logic.scene.base.basescenecontroller"
end

function BaseSceneRef:Init()
  local transform = self._rootGameObject.transform
  self._cinemachinesGameObject = transform:Find("Cinemachines").gameObject
  self._cinemachineStart = transform:Find("Cinemachines/Start").gameObject
  self._cinemachiesAnimator = self._cinemachinesGameObject:GetComponent("Animator")
  self._camera = GlobalCameras.GetCamera("Main")
  self._cameraTransform = self._camera.transform
  self._cameraAnimator = self._camera.gameObject:GetComponent("Animator")
  self._story = TransformStaticFunctions.GetChild(self._rootGameObject, "Story")
  self._advantureGuideEffectTransform = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/base_gate/Effect").transform
  self._tenKeepDrawGuideEffectTransform = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/base_soulfountain/Effect").transform
  self._base_quest = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/base_quest")
  self._base_gate = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/base_gate")
  self._char_001forbase = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/Char")
  self._char_Point = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/Char/CharPoint")
  self._char_001forbase_head_bubble = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/Char/EmojiPoint")
  self._char_013forbase = TransformStaticFunctions.GetChild(self._rootGameObject, CHomeNpcCfgTable:GetRecorder(BaseSceneRef.CharType.Guide013).path)
  self._sceneTextGameObjectTable = {}
  self._sceneUICamera = TransformStaticFunctions.GetChild(self._rootGameObject, "BaseSceneCameraGroup/Main Camera/SceneUICamera")
  self._cameraFollowPoint = TransformStaticFunctions.GetChild(self._rootGameObject, "CameraFollowPoint")
  for k, v in ipairs(cBaseText:GetAllIds()) do
    local record = cBaseText:GetRecorder(v)
    self._sceneTextGameObjectTable[v] = TransformStaticFunctions.GetChild(self._rootGameObject, record.sceneObject)
  end
  self._activity = {}
end

function BaseSceneRef:GetCameraTransform()
  return self._cameraTransform
end

function BaseSceneRef:GetCinemachineStart()
  return self._cinemachineStart
end

function BaseSceneRef:GetCamera()
  return self._camera
end

function BaseSceneRef:GetCinemachiesAnimator()
  return self._cinemachiesAnimator
end

function BaseSceneRef:GetCameraAnimator()
  return self._cameraAnimator
end

function BaseSceneRef:GetSceneUICamera()
  return self._sceneUICamera
end

return BaseSceneRef
