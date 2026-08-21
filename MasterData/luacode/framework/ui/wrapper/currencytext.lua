-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/currencytext.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CurrencyTextStaticFunctions = (((CS.PixelNeko).Lua).UI).CurrencyTextStaticFunctions
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Text = require("framework.ui.wrapper.text")
local CurrencyText = class("CurrencyText", Text)
CurrencyText.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : CurrencyText
  ((CurrencyText.super).Ctor)(self, gameObject)
end

CurrencyText.SetNumber = function(self, num, fullShow)
  -- function num : 0_1 , upvalues : CurrencyTextStaticFunctions, _ENV
  (CurrencyTextStaticFunctions.SetText)(self._uiObject, (NumberManager.GetShowNumber)(num, fullShow))
end

return CurrencyText

