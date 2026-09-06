local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local SceneRef = require("logic.scene.scenerefs.sceneref")
local TrainCampSceneref = class("TrainCampSceneref", SceneRef)

function TrainCampSceneref:Init()
  TrainCampSceneref.super.Init(self)
  self._mainCamera = GlobalCameras.GetCamera("TrainCampMain")
  self._normalCharacterPoint = TransformStaticFunctions.GetChild(self._rootGameObject, "RoomGroup/TrainingRoom/Characters")
  self._attackerPoint = TransformStaticFunctions.GetChild(self._rootGameObject, "RoomGroup/TrainingRoom/Characters/AttackerPoint")
end

function TrainCampSceneref:GetNormalCharacterPoint()
  return self._normalCharacterPoint
end

function TrainCampSceneref:GetAttackerPoint()
  return self._attackerPoint
end

return TrainCampSceneref
