local BannerDialog = class("BannerDialog", Dialog)
BannerDialog.AssetBundleName = "ui/layouts.banner"
BannerDialog.AssetName = "Banner"

function BannerDialog:Ctor(...)
  BannerDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function BannerDialog:OnCreate()
  self._backBtn = self:GetChild("CloseBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnCloseBtnClick, self)
end

function BannerDialog:OnDestroy()
end

function BannerDialog:OnCloseBtnClick()
  DialogManager.DestroySingletonDialog("banner.bannerdialog")
end

return BannerDialog
