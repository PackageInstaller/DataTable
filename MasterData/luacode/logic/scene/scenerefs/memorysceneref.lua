local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local SkySceneRef = require("logic.scene.scenerefs.skysceneref")
local MemorySceneRef = class("MemorySceneRef", SkySceneRef)

function MemorySceneRef:Ctor(...)
  MemorySceneRef.super.Ctor(self, ...)
end

function MemorySceneRef:Init()
  MemorySceneRef.super.Init(self)
  self._effectNodeTransform = TransformStaticFunctions.GetChild(self.actor.object.transform, "Effect").transform
end

return MemorySceneRef
