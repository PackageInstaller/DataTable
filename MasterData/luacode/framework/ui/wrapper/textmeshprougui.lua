local TextMeshProUGUIStaticFunctions = CS.PixelNeko.Lua.UI.TextMeshProUGUIStaticFunctions
local Window = require("framework.ui.wrapper.window")
local TextMeshProUGUI = class("TextMeshProUGUI", Window)

function TextMeshProUGUI:Ctor(gameObject)
  TextMeshProUGUI.super.Ctor(self, gameObject)
end

function TextMeshProUGUI:SetText(text)
  TextMeshProUGUIStaticFunctions.SetText(self._uiObject, tostring(text))
end

function TextMeshProUGUI:GetText()
  return TextMeshProUGUIStaticFunctions.GetText(self._uiObject)
end

function TextMeshProUGUI:GetPreferredValues()
  return TextMeshProUGUIStaticFunctions.GetPreferredValues(self._uiObject)
end

return TextMeshProUGUI
