-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/courtyardsceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local SceneRef = require("logic.scene.scenerefs.sceneref")
local CourtyardSceneref = class("CourtyardSceneref", SceneRef)
CourtyardSceneref.Init = function(self)
  -- function num : 0_0 , upvalues : CourtyardSceneref, TransformStaticFunctions, GlobalCameras, _ENV
  ((CourtyardSceneref.super).Init)(self)
  self._cinemachinesGameObject = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Cinemachines")
  self._cinemachineStart = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Cinemachines/Start")
  self._cinemachiesAnimator = (self._cinemachinesGameObject):GetComponent("Animator")
  self._cameraFollowPoint = (TransformStaticFunctions.GetChild)(self._rootGameObject, "CameraFollowPoint")
  self._cameraBorder = (TransformStaticFunctions.GetChild)(self._rootGameObject, "CameraBorder")
  self._mainCamera = (GlobalCameras.GetCamera)("Main")
  self._mainCameraAnimator = ((self._mainCamera).gameObject):GetComponent("Animator")
  self._cinemachines = {}
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._cinemachines)[1] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Cinemachines/Tree")
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._cinemachines)[2] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Cinemachines/Explore")
  self._buildingScenes = {}
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._buildingScenes)[DataCommon.MagicTree] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_tree")
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._buildingScenes)[DataCommon.Explore] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_adventure")
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._buildingScenes)[DataCommon.Firefly] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_light")
  -- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._buildingScenes)[DataCommon.Alchemy] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_alchemy")
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._buildingScenes)[DataCommon.Cabin] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_dorm")
  -- DECOMPILER ERROR at PC102: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._buildingScenes)[DataCommon.TrainCamp] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_training")
  -- DECOMPILER ERROR at PC110: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._buildingScenes)[DataCommon.YardMusic] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_phonograph")
  self._uiPoints = {}
  -- DECOMPILER ERROR at PC120: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._uiPoints)[DataCommon.MagicTree] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_tree/UIPoint")
  -- DECOMPILER ERROR at PC128: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._uiPoints)[DataCommon.Explore] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_adventure/UIPoint")
  -- DECOMPILER ERROR at PC136: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._uiPoints)[DataCommon.Firefly] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_light/UIPoint")
  -- DECOMPILER ERROR at PC144: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._uiPoints)[DataCommon.Alchemy] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_alchemy/UIPoint")
  -- DECOMPILER ERROR at PC152: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._uiPoints)[DataCommon.Cabin] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_dorm/UIPoint")
  -- DECOMPILER ERROR at PC160: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._uiPoints)[DataCommon.TrainCamp] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_training/UIPoint")
  -- DECOMPILER ERROR at PC168: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._uiPoints)[DataCommon.YardMusic] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_phonograph/UIPoint")
  self._characterPoints = {}
  -- DECOMPILER ERROR at PC178: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._characterPoints)[DataCommon.MagicTree] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Characters/point_tree")
  -- DECOMPILER ERROR at PC186: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._characterPoints)[DataCommon.Explore] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Characters/home_explore")
  -- DECOMPILER ERROR at PC194: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._characterPoints)[DataCommon.Firefly] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Characters/home_light")
  -- DECOMPILER ERROR at PC202: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._characterPoints)[DataCommon.Alchemy] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Characters/home_alchemy")
  self._magicTreeCollectLightEffect = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_tree/GlowCollectEffect")
  self._glowsPoint = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Glows")
  self._glowsPoints = {}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC226: Confused about usage of register: R5 in 'UnsetPending'

    (self._glowsPoints)[i] = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Glows/Point" .. i)
  end
  self._lightWorkEffect = (TransformStaticFunctions.GetChild)(self._rootGameObject, "InteractableObjs/home_light/TingYuan_TX_deng")
end

CourtyardSceneref.GetMainCamera = function(self)
  -- function num : 0_1
  return self._mainCamera
end

CourtyardSceneref.GetCinemachineStart = function(self)
  -- function num : 0_2
  return self._cinemachineStart
end

CourtyardSceneref.GetCinemachines = function(self)
  -- function num : 0_3
  return self._cinemachines
end

CourtyardSceneref.GetCinemachiesAnimator = function(self)
  -- function num : 0_4
  return self._cinemachiesAnimator
end

CourtyardSceneref.GetMainCameraAnimator = function(self)
  -- function num : 0_5
  return self._mainCameraAnimator
end

CourtyardSceneref.GetCharacterPoints = function(self)
  -- function num : 0_6
  return self._characterPoints
end

CourtyardSceneref.GetUIPointByBuildingId = function(self, buildingId)
  -- function num : 0_7
  return (self._uiPoints)[buildingId]
end

CourtyardSceneref.GetUIPoints = function(self)
  -- function num : 0_8
  return self._uiPoints
end

CourtyardSceneref.GetBuildingScenes = function(self)
  -- function num : 0_9
  return self._buildingScenes
end

return CourtyardSceneref

