local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local SceneRef = require("logic.scene.scenerefs.sceneref")
local CourtyardSceneref = class("CourtyardSceneref", SceneRef)

function CourtyardSceneref:Init()
  CourtyardSceneref.super.Init(self)
  self._cinemachinesGameObject = TransformStaticFunctions.GetChild(self._rootGameObject, "Cinemachines")
  self._cinemachineStart = TransformStaticFunctions.GetChild(self._rootGameObject, "Cinemachines/Start")
  self._cinemachiesAnimator = self._cinemachinesGameObject:GetComponent("Animator")
  self._cameraFollowPoint = TransformStaticFunctions.GetChild(self._rootGameObject, "CameraFollowPoint")
  self._cameraBorder = TransformStaticFunctions.GetChild(self._rootGameObject, "CameraBorder")
  self._mainCamera = GlobalCameras.GetCamera("Main")
  self._mainCameraAnimator = self._mainCamera.gameObject:GetComponent("Animator")
  self._cinemachines = {}
  self._cinemachines[1] = TransformStaticFunctions.GetChild(self._rootGameObject, "Cinemachines/Tree")
  self._cinemachines[2] = TransformStaticFunctions.GetChild(self._rootGameObject, "Cinemachines/Explore")
  self._buildingScenes = {}
  self._buildingScenes[DataCommon.MagicTree] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_tree")
  self._buildingScenes[DataCommon.Explore] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_adventure")
  self._buildingScenes[DataCommon.Firefly] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_light")
  self._buildingScenes[DataCommon.Alchemy] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_alchemy")
  self._buildingScenes[DataCommon.Cabin] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_dorm")
  self._buildingScenes[DataCommon.TrainCamp] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_training")
  self._buildingScenes[DataCommon.YardMusic] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_phonograph")
  self._uiPoints = {}
  self._uiPoints[DataCommon.MagicTree] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_tree/UIPoint")
  self._uiPoints[DataCommon.Explore] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_adventure/UIPoint")
  self._uiPoints[DataCommon.Firefly] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_light/UIPoint")
  self._uiPoints[DataCommon.Alchemy] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_alchemy/UIPoint")
  self._uiPoints[DataCommon.Cabin] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_dorm/UIPoint")
  self._uiPoints[DataCommon.TrainCamp] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_training/UIPoint")
  self._uiPoints[DataCommon.YardMusic] = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_phonograph/UIPoint")
  self._characterPoints = {}
  self._characterPoints[DataCommon.MagicTree] = TransformStaticFunctions.GetChild(self._rootGameObject, "Characters/point_tree")
  self._characterPoints[DataCommon.Explore] = TransformStaticFunctions.GetChild(self._rootGameObject, "Characters/home_explore")
  self._characterPoints[DataCommon.Firefly] = TransformStaticFunctions.GetChild(self._rootGameObject, "Characters/home_light")
  self._characterPoints[DataCommon.Alchemy] = TransformStaticFunctions.GetChild(self._rootGameObject, "Characters/home_alchemy")
  self._magicTreeCollectLightEffect = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_tree/GlowCollectEffect")
  self._glowsPoint = TransformStaticFunctions.GetChild(self._rootGameObject, "Glows")
  self._glowsPoints = {}
  for i = 1, 5 do
    self._glowsPoints[i] = TransformStaticFunctions.GetChild(self._rootGameObject, "Glows/Point" .. i)
  end
  self._lightWorkEffect = TransformStaticFunctions.GetChild(self._rootGameObject, "InteractableObjs/home_light/TingYuan_TX_deng")
end

function CourtyardSceneref:GetMainCamera()
  return self._mainCamera
end

function CourtyardSceneref:GetCinemachineStart()
  return self._cinemachineStart
end

function CourtyardSceneref:GetCinemachines()
  return self._cinemachines
end

function CourtyardSceneref:GetCinemachiesAnimator()
  return self._cinemachiesAnimator
end

function CourtyardSceneref:GetMainCameraAnimator()
  return self._mainCameraAnimator
end

function CourtyardSceneref:GetCharacterPoints()
  return self._characterPoints
end

function CourtyardSceneref:GetUIPointByBuildingId(buildingId)
  return self._uiPoints[buildingId]
end

function CourtyardSceneref:GetUIPoints()
  return self._uiPoints
end

function CourtyardSceneref:GetBuildingScenes()
  return self._buildingScenes
end

return CourtyardSceneref
