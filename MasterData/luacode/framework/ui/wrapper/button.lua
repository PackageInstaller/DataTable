local ButtonStaticFunctions = CS.PixelNeko.Lua.UI.ButtonStaticFunctions
local Window = require("framework.ui.wrapper.window")
local Button = class("Button", Window)

function Button:Ctor(gameObject)
  Button.super.Ctor(self, gameObject)
end

function Button:SetInteractable(enabled)
  ButtonStaticFunctions.SetInteractable(self._uiObject, enabled)
end

function Button:IsInteractable()
  return ButtonStaticFunctions.IsInteractable(self._uiObject)
end

return Button
