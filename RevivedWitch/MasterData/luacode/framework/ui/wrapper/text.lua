-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/text.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TextStaticFunctions = (((CS.PixelNeko).Lua).UI).TextStaticFunctions
local Window = require("framework.ui.wrapper.window")
local Text = class("Text", Window)
Text.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : Text
  ((Text.super).Ctor)(self, gameObject)
end

Text.SetText = function(self, text)
  -- function num : 0_1 , upvalues : TextStaticFunctions, _ENV
  (TextStaticFunctions.SetText)(self._uiObject, tostring(text))
end

Text.GetText = function(self)
  -- function num : 0_2 , upvalues : TextStaticFunctions
  return (TextStaticFunctions.GetText)(self._uiObject)
end

Text.GetPreferredSize = function(self)
  -- function num : 0_3 , upvalues : TextStaticFunctions
  return (TextStaticFunctions.GetPreferredSize)(self._uiObject)
end

Text.GetFontSize = function(self)
  -- function num : 0_4 , upvalues : TextStaticFunctions
  return (TextStaticFunctions.GetFontSize)(self._uiObject)
end

Text.SetColor = function(self, color)
  -- function num : 0_5 , upvalues : TextStaticFunctions
  (TextStaticFunctions.SetColor)(self._uiObject, color)
end

Text.GetColor = function(self)
  -- function num : 0_6 , upvalues : TextStaticFunctions
  return (TextStaticFunctions.GetColor)(self._uiObject)
end

return Text

