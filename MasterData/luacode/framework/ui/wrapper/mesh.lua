local UIMeshStaticFunctions = CS.PixelNeko.Lua.UI.UIMeshStaticFunctions
local Window = require("framework.ui.wrapper.window")
local Mesh = class("Mesh", Window)

function Mesh:Ctor(gameObject)
  Mesh.super.Ctor(self, gameObject)
end

function Mesh:AddMesh(assetBundleName, assetName)
  return UIMeshStaticFunctions.AddMesh(self._uiObject, assetBundleName, assetName)
end

function Mesh:ReleaseMesh(handler)
  UIMeshStaticFunctions.Release(self._uiObject, handler)
end

return Mesh
