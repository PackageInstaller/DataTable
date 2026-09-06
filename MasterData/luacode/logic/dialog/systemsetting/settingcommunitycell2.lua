local SettingCommunityCell2 = class("SettingCommunityCell2", Dialog)
SettingCommunityCell2.AssetBundleName = "ui/layouts.setting"
SettingCommunityCell2.AssetName = "SettingCommunityCell2"

function SettingCommunityCell2:Ctor(...)
  SettingCommunityCell2.super.Ctor(self, ...)
end

function SettingCommunityCell2:OnCreate()
  self._btn = self:GetChild("Btn")
  self._btn:Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

function SettingCommunityCell2:OnDestroy(...)
end

function SettingCommunityCell2:RefreshCell()
end

function SettingCommunityCell2:OnBtnClick()
  self._delegate:OnCell2BtnClick()
end

return SettingCommunityCell2
