local UIEventTriggerHelper = CS.PixelNeko.UI.EventTriggerHelper
local UIScrollBarStaticFunctions = CS.PixelNeko.Lua.UI.ScrollBarStaticFunctions
local Window = require("framework.ui.wrapper.window")
local ScrollBar = class("Scrollbar", Window)

function ScrollBar:Ctor(gameObject)
  ScrollBar.super.Ctor(self, gameObject)
end

function ScrollBar:SetScrollDirection(dir)
  return UIScrollBarStaticFunctions.SetDirection(self._uiObject, dir)
end

function ScrollBar:SetScrollValue(value)
  return UIScrollBarStaticFunctions.SetValue(self._uiObject, value)
end

function ScrollBar:GetScrollValue()
  return UIScrollBarStaticFunctions.GetValue(self._uiObject)
end

function ScrollBar:SetScrollSize(size)
  return UIScrollBarStaticFunctions.SetSize(self._uiObject, size)
end

function ScrollBar:Subscribe_ValueChangedEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddScrollBarValueChangedListener(self._uiObject, callback, ins)
end

function ScrollBar:Unsubscribe_ValueChangedEvent(handler)
  UIEventTriggerHelper.RemoveScrollBarValueChangedListener(self._uiObject, handler)
end

return ScrollBar
