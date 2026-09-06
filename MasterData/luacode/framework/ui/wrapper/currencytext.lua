local CurrencyTextStaticFunctions = CS.PixelNeko.Lua.UI.CurrencyTextStaticFunctions
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Text = require("framework.ui.wrapper.text")
local CurrencyText = class("CurrencyText", Text)

function CurrencyText:Ctor(gameObject)
  CurrencyText.super.Ctor(self, gameObject)
end

function CurrencyText:SetNumber(num, fullShow)
  CurrencyTextStaticFunctions.SetText(self._uiObject, NumberManager.GetShowNumber(num, fullShow))
end

return CurrencyText
