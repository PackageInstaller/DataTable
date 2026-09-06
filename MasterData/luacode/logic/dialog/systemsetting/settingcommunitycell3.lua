local SettingCommunityCell3 = class("SettingCommunityCell3", Dialog)
SettingCommunityCell3.AssetBundleName = "ui/layouts.setting"
SettingCommunityCell3.AssetName = "SettingCommunityCell3"

function SettingCommunityCell3:Ctor(...)
  SettingCommunityCell3.super.Ctor(self, ...)
end

function SettingCommunityCell3:OnCreate()
  self._btn = self:GetChild("Btn")
  self._btn:Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

function SettingCommunityCell3:OnDestroy(...)
end

function SettingCommunityCell3:RefreshCell()
end

function SettingCommunityCell3:OnBtnClick()
  self._delegate:OnCell3BtnClick()
end

return SettingCommunityCell3
