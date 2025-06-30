-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/image.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Window = require("framework.ui.wrapper.window")
local Image = class("Image", Window)
Image.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : Image
  ((Image.super).Ctor)(self, gameObject)
end

Image.SetImageFromSet = function(self, assetBundleName, imagesetName, imageName)
  -- function num : 0_1 , upvalues : _ENV
  assetBundleName = "ui/imagesets." .. assetBundleName .. ".assetbundle"
  local assetName = imageName
  ;
  ((((CS.PixelNeko).UI).UIManager).SetImageTexture)(self._uiObject, assetBundleName, imagesetName, assetName)
end

Image.SetImage = function(self, assetBundleName, imageName)
  -- function num : 0_2 , upvalues : _ENV
  assetBundleName = "ui/imagesets." .. assetBundleName .. ".assetbundle"
  ;
  ((((CS.PixelNeko).UI).UIManager).SetImage)(self._uiObject, assetBundleName, imageName)
end

Image.SetSprite = function(self, assetBundleName, imageName)
  -- function num : 0_3 , upvalues : _ENV
  ((((CS.PixelNeko).UI).UIManager).SetImage)(self._uiObject, assetBundleName, imageName)
end

Image.SetColor = function(self, color)
  -- function num : 0_4 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).ImageStaticFunctions).SetColor)(self._uiObject, color)
end

Image.GetColor = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).ImageStaticFunctions).GetColor)(self._uiObject)
end

Image.SetFillAmount = function(self, value)
  -- function num : 0_6 , upvalues : _ENV
  (((((CS.PixelNeko).Lua).UI).ImageStaticFunctions).SetFillAmount)(self._uiObject, value)
end

Image.GetFillAmount = function(self)
  -- function num : 0_7 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).ImageStaticFunctions).GetFillAmount)(self._uiObject)
end

Image.SetEnable = function(self, isActive)
  -- function num : 0_8 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).ImageStaticFunctions).SetEnable)(self._uiObject, isActive)
end

Image.GetRaycastTarget = function(self)
  -- function num : 0_9 , upvalues : _ENV
  return (((((CS.PixelNeko).Lua).UI).ImageStaticFunctions).GetRaycastTarget)(self._uiObject)
end

Image.SetRaycastTarget = function(self, value)
  -- function num : 0_10 , upvalues : _ENV
  (((((CS.PixelNeko).Lua).UI).ImageStaticFunctions).SetRaycastTarget)(self._uiObject, value)
end

Image.SetAlpha = function(self, value)
  -- function num : 0_11 , upvalues : _ENV
  (((((CS.PixelNeko).Lua).UI).ImageStaticFunctions).SetAlpha)(self._uiObject, value)
end

return Image

