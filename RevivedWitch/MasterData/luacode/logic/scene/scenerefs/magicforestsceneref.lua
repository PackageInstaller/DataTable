-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/magicforestsceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MagicforestScenePlayerMove = (((CS.PixelNeko).P1).MagicForestScene).MagicforestScenePlayerMove
local SceneRef = require("logic.scene.scenerefs.sceneref")
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local MagicForestSceneref = class("MagicForestSceneref", SceneRef)
MagicForestSceneref.Init = function(self)
  -- function num : 0_0 , upvalues : MagicForestSceneref, TransformStaticFunctions, MagicforestScenePlayerMove
  ((MagicForestSceneref.super).Init)(self)
  local actor = (TransformStaticFunctions.GetChild)(self._rootGameObject, "ActorW1")
  self._magicForestScenePlayerMove = (MagicforestScenePlayerMove.GetMagicforestScenePlayerMove)(actor.gameObject)
end

MagicForestSceneref.GetMagicforestScenePlayerMove = function(self)
  -- function num : 0_1
  return self._magicForestScenePlayerMove
end

return MagicForestSceneref

