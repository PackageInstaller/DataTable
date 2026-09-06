local FragmentTipsDialog = class("FragmentTipsDialog", Dialog)
FragmentTipsDialog.AssetBundleName = "ui/layouts.fragment"
FragmentTipsDialog.AssetName = "FragmentTip"

function FragmentTipsDialog:Ctor(...)
  FragmentTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function FragmentTipsDialog:OnCreate()
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function FragmentTipsDialog:OnDestroy()
end

function FragmentTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

return FragmentTipsDialog
