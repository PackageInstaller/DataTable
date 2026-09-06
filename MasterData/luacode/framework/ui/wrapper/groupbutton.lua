local GroupButtonStaticFunctions = CS.PixelNeko.Lua.UI.GroupButtonStaticFunctions
local Window = require("framework.ui.wrapper.window")
local GroupButton = class("GroupButton", Window)

function GroupButton:Ctor(gameObject)
  GroupButton.super.Ctor(self, gameObject)
end

function GroupButton:SetSelected(value)
  GroupButtonStaticFunctions.SetSelected(self._uiObject, value)
end

function GroupButton:IsSelected()
  return GroupButtonStaticFunctions.IsSelected(self._uiObject)
end

function GroupButton:SetTextImgSelected(assetBundleName, imageName)
  GroupButtonStaticFunctions.SetTextImgSelected(self._uiObject, assetBundleName, imageName)
end

function GroupButton:SetTextImgNormal(assetBundleName, imageName)
  GroupButtonStaticFunctions.SetTextImgNormal(self._uiObject, assetBundleName, imageName)
end

return GroupButton
