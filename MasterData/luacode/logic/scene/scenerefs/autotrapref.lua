local SceneRef = require("logic.scene.scenerefs.sceneref")
local AutoTrapRef = class("AutoTrapRef", SceneRef)

function AutoTrapRef:Init()
  AutoTrapRef.super.Init(self)
  self.actor = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, "ActorAutoExplore")
  self.stage = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, "Stage")
  self.background = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, "BackGround")
  self.enemy = {
    root = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, "EnemyHandler"),
    point = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, "EnemyHandler/EnemyPoint")
  }
end

function AutoTrapRef:GetSceneControllerName()
  return "logic.scene.scenecontrollers.autotrapcontroller"
end

return AutoTrapRef
