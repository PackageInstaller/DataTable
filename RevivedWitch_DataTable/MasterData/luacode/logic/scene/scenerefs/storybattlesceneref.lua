-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/storybattlesceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local StoryBattleSceneRef = class("StoryBattleSceneRef", NewBattleSceneRef)
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
StoryBattleSceneRef.Init = function(self)
  -- function num : 0_0 , upvalues : StoryBattleSceneRef, TransformStaticFunctions
  ((StoryBattleSceneRef.super).Init)(self)
  local rootTransform = (self._rootGameObject).transform
  self._triggerTimeLine = (TransformStaticFunctions.GetChild)(self._rootGameObject, "W1_Battle_boss01_01")
end

return StoryBattleSceneRef

