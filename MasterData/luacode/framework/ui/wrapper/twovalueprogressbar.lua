local TwoValueProgressBarStaticFunctions = CS.PixelNeko.Lua.UI.TwoValueProgressBarStaticFunctions
local Window = require("framework.ui.wrapper.window")
local TwoValueProgressBar = class("TwoValueProgressBar", Window)

function TwoValueProgressBar:Ctor(gameObject)
  TwoValueProgressBar.super.Ctor(self, gameObject)
end

function TwoValueProgressBar:SetFirstValue(value)
  TwoValueProgressBarStaticFunctions.SetFirstValue(self._uiObject, value)
end

function TwoValueProgressBar:GetFirstValue()
  return TwoValueProgressBarStaticFunctions.GetFirstValue(self._uiObject)
end

function TwoValueProgressBar:SetSecondValue(value)
  TwoValueProgressBarStaticFunctions.SetSecondValue(self._uiObject, value)
end

function TwoValueProgressBar:GetSecondValue()
  return TwoValueProgressBarStaticFunctions.GetSecondValue(self._uiObject)
end

return TwoValueProgressBar
