-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/inputfield.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEventTriggerHelper = ((CS.PixelNeko).UI).EventTriggerHelper
local Window = require("framework.ui.wrapper.window")
local InputField = class("InputField", Window)
InputField.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : InputField
  ((InputField.super).Ctor)(self, gameObject)
end

InputField.GetText = function(self)
  -- function num : 0_1 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).InputFieldStaticFunctions).GetText)(self._uiObject)
end

InputField.SetText = function(self, str)
  -- function num : 0_2 , upvalues : _ENV
  if not str then
    str = ""
  end
  return (((((CS.PixelNeko).Lua).UI).InputFieldStaticFunctions).SetText)(self._uiObject, str)
end

InputField.GetFontSize = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).InputFieldStaticFunctions).GetFontSize)(self._uiObject)
end

InputField.GetPreferredSize = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).InputFieldStaticFunctions).GetPreferredSize)(self._uiObject)
end

InputField.IsFocused = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).InputFieldStaticFunctions).IsFocused)(self._uiObject)
end

InputField.ActivateInputField = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).InputFieldStaticFunctions).ActivateInputField)(self._uiObject)
end

InputField.MoveTextEnd = function(self, flag)
  -- function num : 0_7 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).InputFieldStaticFunctions).MoveTextEnd)(self._uiObject, flag)
end

InputField.SetLineType = function(self, lineType)
  -- function num : 0_8 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).InputFieldStaticFunctions).SetLineType)(self._uiObject, lineType)
end

InputField.SetGenerateOutOfBounds = function(self, flag)
  -- function num : 0_9 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).InputFieldStaticFunctions).SetGenerateOutOfBounds)(self._uiObject, flag)
end

InputField.SetInteractable = function(self, flag)
  -- function num : 0_10 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).InputFieldStaticFunctions).SetInteractable)(self._uiObject, flag)
end

InputField.Subscribe_ValueChangedEvent = function(self, callback, ins)
  -- function num : 0_11 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddInputFieldValueChangedListener)(self._uiObject, callback, ins)
end

InputField.Unsubscribe_ValueChangedEvent = function(self, handler)
  -- function num : 0_12 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveInputFieldValueChangedListener)(self._uiObject, handler)
end

InputField.Subscribe_EditEndEvent = function(self, callback, ins)
  -- function num : 0_13 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddInputFieldEditEndListener)(self._uiObject, callback, ins)
end

InputField.Unsubscribe_EditEndEvent = function(self, handler)
  -- function num : 0_14 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveInputFieldEditEndListener)(self._uiObject, handler)
end

return InputField

