local SettingCommunityCell4 = class("SettingCommunityCell4", Dialog)
SettingCommunityCell4.AssetBundleName = "ui/layouts.setting"
SettingCommunityCell4.AssetName = "SettingCommunityCell4"

function SettingCommunityCell4:Ctor(...)
  SettingCommunityCell4.super.Ctor(self, ...)
end

function SettingCommunityCell4:OnCreate()
  self._btn = self:GetChild("Btn")
  self._btn:Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

function SettingCommunityCell4:OnDestroy(...)
end

function SettingCommunityCell4:RefreshCell()
end

function SettingCommunityCell4:OnBtnClick()
  self._delegate:OnCell4BtnClick()
end

return SettingCommunityCell4
