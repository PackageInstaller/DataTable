-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/firstscenesceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FirstScenePlayerMove = (((CS.PixelNeko).P1).FirstScene).FirstScenePlayerMove
local SceneRef = require("logic.scene.scenerefs.sceneref")
local FirstSceneSceneRef = class("FirstSceneSceneRef", SceneRef)
FirstSceneSceneRef.Init = function(self)
  -- function num : 0_0 , upvalues : FirstSceneSceneRef, FirstScenePlayerMove
  ((FirstSceneSceneRef.super).Init)(self)
  local transform = (self._rootGameObject).transform
  local actor = transform:Find("ActorFirstScene")
  self._firstScenePlayerMove = (FirstScenePlayerMove.GetFirstScenePlayerMove)(actor.gameObject)
end

FirstSceneSceneRef.GetFirstScenePlayerMove = function(self)
  -- function num : 0_1
  return self._firstScenePlayerMove
end

return FirstSceneSceneRef

