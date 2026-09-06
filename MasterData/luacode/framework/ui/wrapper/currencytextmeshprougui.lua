local CurrencyTextMeshProUGUIStaticFunctions = CS.PixelNeko.Lua.UI.CurrencyTextMeshProUGUIStaticFunctions
local TextMeshProUGUI = require("framework.ui.wrapper.textmeshprougui")
local CurrencyTextMeshProUGUI = class("CurrencyTextMeshProUGUI", TextMeshProUGUI)

function CurrencyTextMeshProUGUI:Ctor(gameObject)
  CurrencyTextMeshProUGUI.super.Ctor(self, gameObject)
end

function CurrencyTextMeshProUGUI:SetNumber(num, fullShow)
  CurrencyTextMeshProUGUIStaticFunctions.SetText(self._uiObject, NumberManager.GetShowNumber(num, fullShow))
end

return CurrencyTextMeshProUGUI
