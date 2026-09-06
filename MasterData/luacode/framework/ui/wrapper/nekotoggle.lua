local ToggleStaticFunctions = CS.PixelNeko.Lua.UI.ToggleStaticFunctions
local UIEventTriggerHelper = CS.PixelNeko.UI.EventTriggerHelper
local Window = require("framework.ui.wrapper.window")
local Toggle = class("NekoToggle", Window)

function Toggle:Ctor(gameObject)
  Toggle.super.Ctor(self, gameObject)
end

function Toggle:SetIsOnType(type)
  ToggleStaticFunctions.SetIsOnType(self._uiObject, type)
end

function Toggle:GetIsOnType()
  return ToggleStaticFunctions.GetIsOnType(self._uiObject)
end

function Toggle:SetInteractable(value)
  return ToggleStaticFunctions.SetInteractable(self._uiObject, value)
end

function Toggle:IsInteractable()
  return ToggleStaticFunctions.IsInteractable(self._uiObject)
end

function Toggle:Subscribe_ValueChangedEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddValueChangedListener(self._uiObject, callback, ins)
end

function Toggle:Unsubscribe_ValueChangedEvent(handler)
  UIEventTriggerHelper.RemoveValueChangedListener(self._uiObject, handler)
end

return Toggle
