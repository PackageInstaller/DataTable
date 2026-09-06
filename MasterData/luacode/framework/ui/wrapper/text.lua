local TextStaticFunctions = CS.PixelNeko.Lua.UI.TextStaticFunctions
local Window = require("framework.ui.wrapper.window")
local Text = class("Text", Window)

function Text:Ctor(gameObject)
  Text.super.Ctor(self, gameObject)
end

function Text:SetText(text, color)
  if color and type(color) == "string" and color ~= "" then
    local r, g, b, a = hexToRGBA(color)
    self._uiObject:GetComponent("Text").color = CS.UnityEngine.Color(r, g, b, a)
  end
  TextStaticFunctions.SetText(self._uiObject, tostring(text))
end

function Text:GetText()
  return TextStaticFunctions.GetText(self._uiObject)
end

function Text:GetPreferredSize()
  return TextStaticFunctions.GetPreferredSize(self._uiObject)
end

function Text:GetFontSize()
  return TextStaticFunctions.GetFontSize(self._uiObject)
end

function Text:SetColor(color)
  TextStaticFunctions.SetColor(self._uiObject, color)
end

function Text:GetColor()
  return TextStaticFunctions.GetColor(self._uiObject)
end

function hexToRGBA(hexStr)
  hexStr = string.gsub(hexStr, "^#", "")
  hexStr = string.gsub(hexStr, "%s", "")
  local len = string.len(hexStr)
  local r, g, b, a = 0, 0, 0, 255
  if len == 3 or len == 4 then
    r = tonumber(string.sub(hexStr, 1, 1) .. string.sub(hexStr, 1, 1), 16)
    g = tonumber(string.sub(hexStr, 2, 2) .. string.sub(hexStr, 2, 2), 16)
    b = tonumber(string.sub(hexStr, 3, 3) .. string.sub(hexStr, 3, 3), 16)
    if len == 4 then
      a = tonumber(string.sub(hexStr, 4, 4) .. string.sub(hexStr, 4, 4), 16)
    end
  elseif len == 6 or len == 8 then
    r = tonumber(string.sub(hexStr, 1, 2), 16)
    g = tonumber(string.sub(hexStr, 3, 4), 16)
    b = tonumber(string.sub(hexStr, 5, 6), 16)
    if len == 8 then
      a = tonumber(string.sub(hexStr, 7, 8), 16)
    end
  else
    error("无效的HEX颜色格式: " .. hexStr .. " (长度应为3, 4, 6 或 8位)")
  end
  return r / 255, g / 255, b / 255, a / 255
end

return Text
