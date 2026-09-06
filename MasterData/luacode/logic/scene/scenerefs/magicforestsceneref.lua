local MagicforestScenePlayerMove = CS.PixelNeko.P1.MagicForestScene.MagicforestScenePlayerMove
local SceneRef = require("logic.scene.scenerefs.sceneref")
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local MagicForestSceneref = class("MagicForestSceneref", SceneRef)

function MagicForestSceneref:Init()
  MagicForestSceneref.super.Init(self)
  local actor = TransformStaticFunctions.GetChild(self._rootGameObject, "ActorW1")
  self._magicForestScenePlayerMove = MagicforestScenePlayerMove.GetMagicforestScenePlayerMove(actor.gameObject)
end

function MagicForestSceneref:GetMagicforestScenePlayerMove()
  return self._magicForestScenePlayerMove
end

return MagicForestSceneref
