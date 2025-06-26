-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/resource/resourceguidecoverpaneldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ResourceGuideCoverPanelDialog = class("ResourceGuideCoverPanelDialog", Dialog)
ResourceGuideCoverPanelDialog.AssetBundleName = "ui/layouts"
ResourceGuideCoverPanelDialog.AssetName = "WindowMask"
ResourceGuideCoverPanelDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResourceGuideCoverPanelDialog
  ((ResourceGuideCoverPanelDialog.super).Ctor)(self, ...)
  self._groupName = "Guide"
end

ResourceGuideCoverPanelDialog.OnCreate = function(self)
  -- function num : 0_1
end

ResourceGuideCoverPanelDialog.OnDestroy = function(self)
  -- function num : 0_2
end

return ResourceGuideCoverPanelDialog

