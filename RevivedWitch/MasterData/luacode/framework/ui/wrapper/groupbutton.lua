-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/groupbutton.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GroupButtonStaticFunctions = (((CS.PixelNeko).Lua).UI).GroupButtonStaticFunctions
local Window = require("framework.ui.wrapper.window")
local GroupButton = class("GroupButton", Window)
GroupButton.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : GroupButton
  ((GroupButton.super).Ctor)(self, gameObject)
end

GroupButton.SetSelected = function(self, value)
  -- function num : 0_1 , upvalues : GroupButtonStaticFunctions
  (GroupButtonStaticFunctions.SetSelected)(self._uiObject, value)
end

GroupButton.IsSelected = function(self)
  -- function num : 0_2 , upvalues : GroupButtonStaticFunctions
  return (GroupButtonStaticFunctions.IsSelected)(self._uiObject)
end

GroupButton.SetTextImgSelected = function(self, assetBundleName, imageName)
  -- function num : 0_3 , upvalues : GroupButtonStaticFunctions
  (GroupButtonStaticFunctions.SetTextImgSelected)(self._uiObject, assetBundleName, imageName)
end

GroupButton.SetTextImgNormal = function(self, assetBundleName, imageName)
  -- function num : 0_4 , upvalues : GroupButtonStaticFunctions
  (GroupButtonStaticFunctions.SetTextImgNormal)(self._uiObject, assetBundleName, imageName)
end

return GroupButton

