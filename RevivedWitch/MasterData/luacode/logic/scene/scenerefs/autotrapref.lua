-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/autotrapref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneRef = require("logic.scene.scenerefs.sceneref")
local AutoTrapRef = class("AutoTrapRef", SceneRef)
AutoTrapRef.Init = function(self)
  -- function num : 0_0 , upvalues : AutoTrapRef, _ENV
  ((AutoTrapRef.super).Init)(self)
  self.actor = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "ActorAutoExplore")
  self.stage = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "Stage")
  self.background = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "BackGround")
  self.enemy = {root = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "EnemyHandler"), point = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "EnemyHandler/EnemyPoint")}
end

AutoTrapRef.GetSceneControllerName = function(self)
  -- function num : 0_1
  return "logic.scene.scenecontrollers.autotrapcontroller"
end

return AutoTrapRef

