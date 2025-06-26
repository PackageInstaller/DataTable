-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guide/blockclickdefaultdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BlockClickDialog = class("BlockClickDialog", Dialog)
BlockClickDialog.AssetBundleName = "ui/layouts.guide"
BlockClickDialog.AssetName = "GuideBack"
BlockClickDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BlockClickDialog
  ((BlockClickDialog.super).Ctor)(self, ...)
  self._groupName = "Battle"
end

BlockClickDialog.OnCreate = function(self)
  -- function num : 0_1
  self._guideTxt = self:GetChild("GuideBack/GuideTxt")
end

BlockClickDialog.OnDestroy = function(self)
  -- function num : 0_2
end

return BlockClickDialog

