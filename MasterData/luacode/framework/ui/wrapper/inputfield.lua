local UIEventTriggerHelper = CS.PixelNeko.UI.EventTriggerHelper
local Window = require("framework.ui.wrapper.window")
local InputField = class("InputField", Window)

function InputField:Ctor(gameObject)
  InputField.super.Ctor(self, gameObject)
end

function InputField:GetText()
  return CS.PixelNeko.Lua.UI.InputFieldStaticFunctions.GetText(self._uiObject)
end

function InputField:SetText(str)
  str = str or ""
  return CS.PixelNeko.Lua.UI.InputFieldStaticFunctions.SetText(self._uiObject, str)
end

function InputField:GetFontSize()
  return CS.PixelNeko.Lua.UI.InputFieldStaticFunctions.GetFontSize(self._uiObject)
end

function InputField:GetPreferredSize()
  return CS.PixelNeko.Lua.UI.InputFieldStaticFunctions.GetPreferredSize(self._uiObject)
end

function InputField:IsFocused()
  return CS.PixelNeko.Lua.UI.InputFieldStaticFunctions.IsFocused(self._uiObject)
end

function InputField:ActivateInputField()
  return CS.PixelNeko.Lua.UI.InputFieldStaticFunctions.ActivateInputField(self._uiObject)
end

function InputField:MoveTextEnd(flag)
  return CS.PixelNeko.Lua.UI.InputFieldStaticFunctions.MoveTextEnd(self._uiObject, flag)
end

function InputField:SetLineType(lineType)
  return CS.PixelNeko.Lua.UI.InputFieldStaticFunctions.SetLineType(self._uiObject, lineType)
end

function InputField:SetGenerateOutOfBounds(flag)
  return CS.PixelNeko.Lua.UI.InputFieldStaticFunctions.SetGenerateOutOfBounds(self._uiObject, flag)
end

function InputField:SetInteractable(flag)
  return CS.PixelNeko.Lua.UI.InputFieldStaticFunctions.SetInteractable(self._uiObject, flag)
end

function InputField:Subscribe_ValueChangedEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddInputFieldValueChangedListener(self._uiObject, callback, ins)
end

function InputField:Unsubscribe_ValueChangedEvent(handler)
  UIEventTriggerHelper.RemoveInputFieldValueChangedListener(self._uiObject, handler)
end

function InputField:Subscribe_EditEndEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddInputFieldEditEndListener(self._uiObject, callback, ins)
end

function InputField:Unsubscribe_EditEndEvent(handler)
  UIEventTriggerHelper.RemoveInputFieldEditEndListener(self._uiObject, handler)
end

return InputField
