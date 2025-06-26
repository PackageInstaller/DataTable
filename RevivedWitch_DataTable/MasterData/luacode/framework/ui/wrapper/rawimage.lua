-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/rawimage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RawImageStaticFunctions = (((CS.PixelNeko).Lua).UI).RawImageStaticFunctions
local Window = require("framework.ui.wrapper.window")
local RawImage = class("RawImage", Window)
RawImage.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : RawImage, RawImageStaticFunctions
  ((RawImage.super).Ctor)(self, gameObject)
  self._rawImage = (RawImageStaticFunctions.Get)(gameObject)
end

RawImage.GetRawImage = function(self)
  -- function num : 0_1
  return self._rawImage
end

RawImage.SetImage = function(self, rt)
  -- function num : 0_2 , upvalues : RawImageStaticFunctions
  (RawImageStaticFunctions.SetImage)(self._rawImage, rt)
end

RawImage.SetUVRect = function(self, x, y, w, h)
  -- function num : 0_3 , upvalues : RawImageStaticFunctions
  (RawImageStaticFunctions.SetUVRect)(self._rawImage, x, y, w, h)
end

RawImage.SetColor = function(self, color)
  -- function num : 0_4 , upvalues : RawImageStaticFunctions
  return (RawImageStaticFunctions.SetColor)(self._rawImage, color)
end

RawImage.GetColor = function(self)
  -- function num : 0_5 , upvalues : RawImageStaticFunctions
  return (RawImageStaticFunctions.GetColor)(self._rawImage)
end

RawImage.SetEnable = function(self, isActive)
  -- function num : 0_6 , upvalues : RawImageStaticFunctions
  return (RawImageStaticFunctions.SetEnable)(self._rawImage, isActive)
end

RawImage.GetRaycastTarget = function(self)
  -- function num : 0_7 , upvalues : RawImageStaticFunctions
  return (RawImageStaticFunctions.GetRaycastTarget)(self._rawImage)
end

RawImage.SetRaycastTarget = function(self, value)
  -- function num : 0_8 , upvalues : RawImageStaticFunctions
  (RawImageStaticFunctions.SetRaycastTarget)(self._rawImage, value)
end

RawImage.SetAlpha = function(self, value)
  -- function num : 0_9 , upvalues : RawImageStaticFunctions
  (RawImageStaticFunctions.SetAlpha)(self._rawImage, value)
end

return RawImage

