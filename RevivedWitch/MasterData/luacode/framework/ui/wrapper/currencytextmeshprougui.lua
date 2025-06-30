-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/currencytextmeshprougui.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CurrencyTextMeshProUGUIStaticFunctions = (((CS.PixelNeko).Lua).UI).CurrencyTextMeshProUGUIStaticFunctions
local TextMeshProUGUI = require("framework.ui.wrapper.textmeshprougui")
local CurrencyTextMeshProUGUI = class("CurrencyTextMeshProUGUI", TextMeshProUGUI)
CurrencyTextMeshProUGUI.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : CurrencyTextMeshProUGUI
  ((CurrencyTextMeshProUGUI.super).Ctor)(self, gameObject)
end

CurrencyTextMeshProUGUI.SetNumber = function(self, num, fullShow)
  -- function num : 0_1 , upvalues : CurrencyTextMeshProUGUIStaticFunctions, _ENV
  (CurrencyTextMeshProUGUIStaticFunctions.SetText)(self._uiObject, (NumberManager.GetShowNumber)(num, fullShow))
end

return CurrencyTextMeshProUGUI

