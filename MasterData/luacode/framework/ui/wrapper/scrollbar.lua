-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/scrollbar.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEventTriggerHelper = ((CS.PixelNeko).UI).EventTriggerHelper
local UIScrollBarStaticFunctions = (((CS.PixelNeko).Lua).UI).ScrollBarStaticFunctions
local Window = require("framework.ui.wrapper.window")
local ScrollBar = class("Scrollbar", Window)
ScrollBar.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : ScrollBar
  ((ScrollBar.super).Ctor)(self, gameObject)
end

ScrollBar.SetScrollDirection = function(self, dir)
  -- function num : 0_1 , upvalues : UIScrollBarStaticFunctions
  return (UIScrollBarStaticFunctions.SetDirection)(self._uiObject, dir)
end

ScrollBar.SetScrollValue = function(self, value)
  -- function num : 0_2 , upvalues : UIScrollBarStaticFunctions
  return (UIScrollBarStaticFunctions.SetValue)(self._uiObject, value)
end

ScrollBar.GetScrollValue = function(self)
  -- function num : 0_3 , upvalues : UIScrollBarStaticFunctions
  return (UIScrollBarStaticFunctions.GetValue)(self._uiObject)
end

ScrollBar.SetScrollSize = function(self, size)
  -- function num : 0_4 , upvalues : UIScrollBarStaticFunctions
  return (UIScrollBarStaticFunctions.SetSize)(self._uiObject, size)
end

ScrollBar.Subscribe_ValueChangedEvent = function(self, callback, ins)
  -- function num : 0_5 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddScrollBarValueChangedListener)(self._uiObject, callback, ins)
end

ScrollBar.Unsubscribe_ValueChangedEvent = function(self, handler)
  -- function num : 0_6 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveScrollBarValueChangedListener)(self._uiObject, handler)
end

return ScrollBar

