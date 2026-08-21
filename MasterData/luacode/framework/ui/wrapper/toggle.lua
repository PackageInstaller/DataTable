-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/toggle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ToggleStaticFunctions = (((CS.PixelNeko).Lua).UI).ToggleStaticFunctions
local UIEventTriggerHelper = ((CS.PixelNeko).UI).EventTriggerHelper
local Window = require("framework.ui.wrapper.window")
local Toggle = class("Toggle", Window)
Toggle.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : Toggle
  ((Toggle.super).Ctor)(self, gameObject)
end

Toggle.SetIsOnType = function(self, type)
  -- function num : 0_1 , upvalues : ToggleStaticFunctions
  (ToggleStaticFunctions.SetIsOnType)(self._uiObject, type)
end

Toggle.GetIsOnType = function(self)
  -- function num : 0_2 , upvalues : ToggleStaticFunctions
  return (ToggleStaticFunctions.GetIsOnType)(self._uiObject)
end

Toggle.SetInteractable = function(self, value)
  -- function num : 0_3 , upvalues : ToggleStaticFunctions
  return (ToggleStaticFunctions.SetInteractable)(self._uiObject, value)
end

Toggle.IsInteractable = function(self)
  -- function num : 0_4 , upvalues : ToggleStaticFunctions
  return (ToggleStaticFunctions.IsInteractable)(self._uiObject)
end

Toggle.Subscribe_ValueChangedEvent = function(self, callback, ins)
  -- function num : 0_5 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddValueChangedListener)(self._uiObject, callback, ins)
end

Toggle.Unsubscribe_ValueChangedEvent = function(self, handler)
  -- function num : 0_6 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveValueChangedListener)(self._uiObject, handler)
end

return Toggle

