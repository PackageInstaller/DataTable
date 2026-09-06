local RawImageStaticFunctions = CS.PixelNeko.Lua.UI.RawImageStaticFunctions
local Window = require("framework.ui.wrapper.window")
local RawImage = class("RawImage", Window)

function RawImage:Ctor(gameObject)
  RawImage.super.Ctor(self, gameObject)
  self._rawImage = RawImageStaticFunctions.Get(gameObject)
end

function RawImage:GetRawImage()
  return self._rawImage
end

function RawImage:SetImage(rt)
  RawImageStaticFunctions.SetImage(self._rawImage, rt)
end

function RawImage:SetUVRect(x, y, w, h)
  RawImageStaticFunctions.SetUVRect(self._rawImage, x, y, w, h)
end

function RawImage:SetColor(color)
  return RawImageStaticFunctions.SetColor(self._rawImage, color)
end

function RawImage:GetColor()
  return RawImageStaticFunctions.GetColor(self._rawImage)
end

function RawImage:SetEnable(isActive)
  return RawImageStaticFunctions.SetEnable(self._rawImage, isActive)
end

function RawImage:GetRaycastTarget()
  return RawImageStaticFunctions.GetRaycastTarget(self._rawImage)
end

function RawImage:SetRaycastTarget(value)
  RawImageStaticFunctions.SetRaycastTarget(self._rawImage, value)
end

function RawImage:SetAlpha(value)
  RawImageStaticFunctions.SetAlpha(self._rawImage, value)
end

return RawImage
