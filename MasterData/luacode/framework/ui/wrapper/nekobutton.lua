local NekoButtonStaticFunctions = CS.PixelNeko.Lua.UI.NekoButtonStaticFunctions
local Window = require("framework.ui.wrapper.window")
local NekoButton = class("NekoButton", Window)

function NekoButton:Ctor(gameObject)
  NekoButton.super.Ctor(self, gameObject)
end

function NekoButton:SetInteractable(value)
  NekoButtonStaticFunctions.SetInteractable(self._uiObject, value)
end

function NekoButton:GetInteractable()
  return NekoButtonStaticFunctions.GetInteractable(self._uiObject)
end

function NekoButton:SetSprite(assetBundleName, imageName)
  CS.PixelNeko.UI.UIManager.SetImage(self._uiObject, assetBundleName, imageName)
end

return NekoButton
