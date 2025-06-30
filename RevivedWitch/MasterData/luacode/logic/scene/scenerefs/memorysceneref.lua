-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/memorysceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local SkySceneRef = require("logic.scene.scenerefs.skysceneref")
local MemorySceneRef = class("MemorySceneRef", SkySceneRef)
MemorySceneRef.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MemorySceneRef
  ((MemorySceneRef.super).Ctor)(self, ...)
end

MemorySceneRef.Init = function(self)
  -- function num : 0_1 , upvalues : MemorySceneRef, TransformStaticFunctions
  ((MemorySceneRef.super).Init)(self)
  self._effectNodeTransform = ((TransformStaticFunctions.GetChild)(((self.actor).object).transform, "Effect")).transform
end

return MemorySceneRef

