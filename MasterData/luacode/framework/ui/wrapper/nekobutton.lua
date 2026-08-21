-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/nekobutton.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NekoButtonStaticFunctions = (((CS.PixelNeko).Lua).UI).NekoButtonStaticFunctions
local Window = require("framework.ui.wrapper.window")
local NekoButton = class("NekoButton", Window)
NekoButton.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : NekoButton
  ((NekoButton.super).Ctor)(self, gameObject)
end

NekoButton.SetInteractable = function(self, value)
  -- function num : 0_1 , upvalues : NekoButtonStaticFunctions
  (NekoButtonStaticFunctions.SetInteractable)(self._uiObject, value)
end

NekoButton.GetInteractable = function(self)
  -- function num : 0_2 , upvalues : NekoButtonStaticFunctions
  return (NekoButtonStaticFunctions.GetInteractable)(self._uiObject)
end

NekoButton.SetSprite = function(self, assetBundleName, imageName)
  -- function num : 0_3 , upvalues : _ENV
  ((((CS.PixelNeko).UI).UIManager).SetImage)(self._uiObject, assetBundleName, imageName)
end

return NekoButton

