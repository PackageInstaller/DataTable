-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/twovalueprogressbar.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TwoValueProgressBarStaticFunctions = (((CS.PixelNeko).Lua).UI).TwoValueProgressBarStaticFunctions
local Window = require("framework.ui.wrapper.window")
local TwoValueProgressBar = class("TwoValueProgressBar", Window)
TwoValueProgressBar.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : TwoValueProgressBar
  ((TwoValueProgressBar.super).Ctor)(self, gameObject)
end

TwoValueProgressBar.SetFirstValue = function(self, value)
  -- function num : 0_1 , upvalues : TwoValueProgressBarStaticFunctions
  (TwoValueProgressBarStaticFunctions.SetFirstValue)(self._uiObject, value)
end

TwoValueProgressBar.GetFirstValue = function(self)
  -- function num : 0_2 , upvalues : TwoValueProgressBarStaticFunctions
  return (TwoValueProgressBarStaticFunctions.GetFirstValue)(self._uiObject)
end

TwoValueProgressBar.SetSecondValue = function(self, value)
  -- function num : 0_3 , upvalues : TwoValueProgressBarStaticFunctions
  (TwoValueProgressBarStaticFunctions.SetSecondValue)(self._uiObject, value)
end

TwoValueProgressBar.GetSecondValue = function(self)
  -- function num : 0_4 , upvalues : TwoValueProgressBarStaticFunctions
  return (TwoValueProgressBarStaticFunctions.GetSecondValue)(self._uiObject)
end

return TwoValueProgressBar

