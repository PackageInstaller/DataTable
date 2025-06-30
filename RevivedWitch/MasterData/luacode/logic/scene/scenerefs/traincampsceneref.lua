-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/traincampsceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local SceneRef = require("logic.scene.scenerefs.sceneref")
local TrainCampSceneref = class("TrainCampSceneref", SceneRef)
TrainCampSceneref.Init = function(self)
  -- function num : 0_0 , upvalues : TrainCampSceneref, GlobalCameras, TransformStaticFunctions
  ((TrainCampSceneref.super).Init)(self)
  self._mainCamera = (GlobalCameras.GetCamera)("TrainCampMain")
  self._normalCharacterPoint = (TransformStaticFunctions.GetChild)(self._rootGameObject, "RoomGroup/TrainingRoom/Characters")
  self._attackerPoint = (TransformStaticFunctions.GetChild)(self._rootGameObject, "RoomGroup/TrainingRoom/Characters/AttackerPoint")
end

TrainCampSceneref.GetNormalCharacterPoint = function(self)
  -- function num : 0_1
  return self._normalCharacterPoint
end

TrainCampSceneref.GetAttackerPoint = function(self)
  -- function num : 0_2
  return self._attackerPoint
end

return TrainCampSceneref

