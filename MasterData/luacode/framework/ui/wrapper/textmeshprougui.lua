-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/textmeshprougui.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TextMeshProUGUIStaticFunctions = (((CS.PixelNeko).Lua).UI).TextMeshProUGUIStaticFunctions
local Window = require("framework.ui.wrapper.window")
local TextMeshProUGUI = class("TextMeshProUGUI", Window)
TextMeshProUGUI.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : TextMeshProUGUI
  ((TextMeshProUGUI.super).Ctor)(self, gameObject)
end

TextMeshProUGUI.SetText = function(self, text)
  -- function num : 0_1 , upvalues : TextMeshProUGUIStaticFunctions, _ENV
  (TextMeshProUGUIStaticFunctions.SetText)(self._uiObject, tostring(text))
end

TextMeshProUGUI.GetText = function(self)
  -- function num : 0_2 , upvalues : TextMeshProUGUIStaticFunctions
  return (TextMeshProUGUIStaticFunctions.GetText)(self._uiObject)
end

TextMeshProUGUI.GetPreferredValues = function(self)
  -- function num : 0_3 , upvalues : TextMeshProUGUIStaticFunctions
  return (TextMeshProUGUIStaticFunctions.GetPreferredValues)(self._uiObject)
end

return TextMeshProUGUI

