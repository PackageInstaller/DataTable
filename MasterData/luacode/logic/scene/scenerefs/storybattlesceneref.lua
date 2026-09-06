local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local StoryBattleSceneRef = class("StoryBattleSceneRef", NewBattleSceneRef)
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions

function StoryBattleSceneRef:Init()
  StoryBattleSceneRef.super.Init(self)
  local rootTransform = self._rootGameObject.transform
  self._triggerTimeLine = TransformStaticFunctions.GetChild(self._rootGameObject, "W1_Battle_boss01_01")
end

return StoryBattleSceneRef
