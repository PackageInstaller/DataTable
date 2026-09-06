local Window = require("framework.ui.wrapper.window")
local Image = class("Image", Window)

function Image:Ctor(gameObject)
  Image.super.Ctor(self, gameObject)
end

function Image:SetImageFromSet(assetBundleName, imagesetName, imageName)
  assetBundleName = "ui/imagesets." .. assetBundleName .. ".assetbundle"
  local assetName = imageName
  CS.PixelNeko.UI.UIManager.SetImageTexture(self._uiObject, assetBundleName, imagesetName, assetName)
end

function Image:SetImage(assetBundleName, imageName)
  assetBundleName = "ui/imagesets." .. assetBundleName .. ".assetbundle"
  CS.PixelNeko.UI.UIManager.SetImage(self._uiObject, assetBundleName, imageName)
end

function Image:SetSprite(assetBundleName, imageName)
  CS.PixelNeko.UI.UIManager.SetImage(self._uiObject, assetBundleName, imageName)
end

function Image:SetColor(color)
  return CS.PixelNeko.Lua.UI.ImageStaticFunctions.SetColor(self._uiObject, color)
end

function Image:GetColor()
  return CS.PixelNeko.Lua.UI.ImageStaticFunctions.GetColor(self._uiObject)
end

function Image:SetFillAmount(value)
  CS.PixelNeko.Lua.UI.ImageStaticFunctions.SetFillAmount(self._uiObject, value)
end

function Image:GetFillAmount()
  return CS.PixelNeko.Lua.UI.ImageStaticFunctions.GetFillAmount(self._uiObject)
end

function Image:SetEnable(isActive)
  return CS.PixelNeko.Lua.UI.ImageStaticFunctions.SetEnable(self._uiObject, isActive)
end

function Image:GetRaycastTarget()
  return CS.PixelNeko.Lua.UI.ImageStaticFunctions.GetRaycastTarget(self._uiObject)
end

function Image:SetRaycastTarget(value)
  CS.PixelNeko.Lua.UI.ImageStaticFunctions.SetRaycastTarget(self._uiObject, value)
end

function Image:SetAlpha(value)
  CS.PixelNeko.Lua.UI.ImageStaticFunctions.SetAlpha(self._uiObject, value)
end

return Image
