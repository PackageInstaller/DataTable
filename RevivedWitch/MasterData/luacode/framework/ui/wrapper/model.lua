-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/model.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIModelStaticFunctions = (((CS.PixelNeko).Lua).UI).UIModelStaticFunctions
local Window = require("framework.ui.wrapper.window")
local Model = class("Model", Window)
Model.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : Model
  ((Model.super).Ctor)(self, gameObject)
end

Model.AddModelSync = function(self, assetBundleName, assetName)
  -- function num : 0_1 , upvalues : UIModelStaticFunctions
  return (UIModelStaticFunctions.AddModelSync)(self._uiObject, assetBundleName, assetName)
end

Model.ReleaseModel = function(self, handler)
  -- function num : 0_2 , upvalues : UIModelStaticFunctions
  (UIModelStaticFunctions.Release)(self._uiObject, handler)
end

return Model

