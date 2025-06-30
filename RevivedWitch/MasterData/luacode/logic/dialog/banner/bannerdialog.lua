-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/banner/bannerdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BannerDialog = class("BannerDialog", Dialog)
BannerDialog.AssetBundleName = "ui/layouts.banner"
BannerDialog.AssetName = "Banner"
BannerDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BannerDialog
  ((BannerDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

BannerDialog.OnCreate = function(self)
  -- function num : 0_1
  self._backBtn = self:GetChild("CloseBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnCloseBtnClick, self)
end

BannerDialog.OnDestroy = function(self)
  -- function num : 0_2
end

BannerDialog.OnCloseBtnClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("banner.bannerdialog")
end

return BannerDialog

