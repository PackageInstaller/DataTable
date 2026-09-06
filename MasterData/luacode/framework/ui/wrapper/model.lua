local UIModelStaticFunctions = CS.PixelNeko.Lua.UI.UIModelStaticFunctions
local Window = require("framework.ui.wrapper.window")
local Model = class("Model", Window)

function Model:Ctor(gameObject)
  Model.super.Ctor(self, gameObject)
end

function Model:AddModelSync(assetBundleName, assetName)
  return UIModelStaticFunctions.AddModelSync(self._uiObject, assetBundleName, assetName)
end

function Model:ReleaseModel(handler)
  UIModelStaticFunctions.Release(self._uiObject, handler)
end

return Model
