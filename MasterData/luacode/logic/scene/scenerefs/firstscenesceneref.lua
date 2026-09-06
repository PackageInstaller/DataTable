local FirstScenePlayerMove = CS.PixelNeko.P1.FirstScene.FirstScenePlayerMove
local SceneRef = require("logic.scene.scenerefs.sceneref")
local FirstSceneSceneRef = class("FirstSceneSceneRef", SceneRef)

function FirstSceneSceneRef:Init()
  FirstSceneSceneRef.super.Init(self)
  local transform = self._rootGameObject.transform
  local actor = transform:Find("ActorFirstScene")
  self._firstScenePlayerMove = FirstScenePlayerMove.GetFirstScenePlayerMove(actor.gameObject)
end

function FirstSceneSceneRef:GetFirstScenePlayerMove()
  return self._firstScenePlayerMove
end

return FirstSceneSceneRef
