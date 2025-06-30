-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/basesceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cBaseText = (BeanManager.GetTableByName)("scene.cbasetext")
local CHomeNpcCfgTable = (BeanManager.GetTableByName)("dialog.chomenpcconfig")
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local SceneRef = require("logic.scene.scenerefs.sceneref")
local BaseSceneRef = class("BaseSceneRef", SceneRef)
BaseSceneRef.CharType = {Guide001 = 1, Guide013 = 2}
BaseSceneRef.GetSceneControllerName = function(self)
  -- function num : 0_0
  return "logic.scene.base.basescenecontroller"
end

BaseSceneRef.Init = function(self)
  -- function num : 0_1 , upvalues : GlobalCameras, TransformStaticFunctions, CHomeNpcCfgTable, BaseSceneRef, _ENV, cBaseText
  local transform = (self._rootGameObject).transform
  self._cinemachinesGameObject = (transform:Find("Cinemachines")).gameObject
  self._cinemachineStart = (transform:Find("Cinemachines/Start")).gameObject
  self._cinemachiesAnimator = (self._cinemachinesGameObject):GetComponent("Animator")
  self._camera = (GlobalCameras.GetCamera)("Main")
  self._cameraTransform = (self._camera).transform
  self._cameraAnimator = ((self._camera).gameObject):GetComponent("Animator")
  self._story = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Story")
  self._advantureGuideEffectTransform = ((TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/base_gate/Effect")).transform
  self._tenKeepDrawGuideEffectTransform = ((TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/base_soulfountain/Effect")).transform
  self._base_quest = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/base_quest")
  self._base_gate = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/base_gate")
  self._char_001forbase = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/Char")
  self._char_Point = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/Char/CharPoint")
  self._char_001forbase_head_bubble = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/Char/EmojiPoint")
  self._char_013forbase = (TransformStaticFunctions.GetChild)(self._rootGameObject, (CHomeNpcCfgTable:GetRecorder((BaseSceneRef.CharType).Guide013)).path)
  self._sceneTextGameObjectTable = {}
  self._sceneUICamera = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BaseSceneCameraGroup/Main Camera/SceneUICamera")
  self._cameraFollowPoint = (TransformStaticFunctions.GetChild)(self._rootGameObject, "CameraFollowPoint")
  for k,v in ipairs(cBaseText:GetAllIds()) do
    local record = cBaseText:GetRecorder(v)
    -- DECOMPILER ERROR at PC109: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self._sceneTextGameObjectTable)[v] = (TransformStaticFunctions.GetChild)(self._rootGameObject, record.sceneObject)
  end
  self._activity = {}
end

BaseSceneRef.GetCameraTransform = function(self)
  -- function num : 0_2
  return self._cameraTransform
end

BaseSceneRef.GetCinemachineStart = function(self)
  -- function num : 0_3
  return self._cinemachineStart
end

BaseSceneRef.GetCamera = function(self)
  -- function num : 0_4
  return self._camera
end

BaseSceneRef.GetCinemachiesAnimator = function(self)
  -- function num : 0_5
  return self._cinemachiesAnimator
end

BaseSceneRef.GetCameraAnimator = function(self)
  -- function num : 0_6
  return self._cameraAnimator
end

BaseSceneRef.GetSceneUICamera = function(self)
  -- function num : 0_7
  return self._sceneUICamera
end

return BaseSceneRef

