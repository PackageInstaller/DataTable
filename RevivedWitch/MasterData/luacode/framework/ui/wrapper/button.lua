-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/button.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ButtonStaticFunctions = (((CS.PixelNeko).Lua).UI).ButtonStaticFunctions
local Window = require("framework.ui.wrapper.window")
local Button = class("Button", Window)
Button.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : Button
  ((Button.super).Ctor)(self, gameObject)
end

Button.SetInteractable = function(self, enabled)
  -- function num : 0_1 , upvalues : ButtonStaticFunctions
  (ButtonStaticFunctions.SetInteractable)(self._uiObject, enabled)
end

Button.IsInteractable = function(self)
  -- function num : 0_2 , upvalues : ButtonStaticFunctions
  return (ButtonStaticFunctions.IsInteractable)(self._uiObject)
end

return Button

