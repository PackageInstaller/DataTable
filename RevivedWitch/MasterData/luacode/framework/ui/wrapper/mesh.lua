-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/mesh.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIMeshStaticFunctions = (((CS.PixelNeko).Lua).UI).UIMeshStaticFunctions
local Window = require("framework.ui.wrapper.window")
local Mesh = class("Mesh", Window)
Mesh.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : Mesh
  ((Mesh.super).Ctor)(self, gameObject)
end

Mesh.AddMesh = function(self, assetBundleName, assetName)
  -- function num : 0_1 , upvalues : UIMeshStaticFunctions
  return (UIMeshStaticFunctions.AddMesh)(self._uiObject, assetBundleName, assetName)
end

Mesh.ReleaseMesh = function(self, handler)
  -- function num : 0_2 , upvalues : UIMeshStaticFunctions
  (UIMeshStaticFunctions.Release)(self._uiObject, handler)
end

return Mesh

