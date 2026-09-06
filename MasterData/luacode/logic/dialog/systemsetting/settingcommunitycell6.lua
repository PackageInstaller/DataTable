local SettingCommunityCell6 = class("SettingCommunityCell6", Dialog)
SettingCommunityCell6.AssetBundleName = "ui/layouts.setting"
SettingCommunityCell6.AssetName = "SettingCommunityCell6"

function SettingCommunityCell6:Ctor(...)
  SettingCommunityCell6.super.Ctor(self, ...)
end

function SettingCommunityCell6:OnCreate()
  self._btn = self:GetChild("Btn")
  self._btn:Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

function SettingCommunityCell6:OnDestroy(...)
end

function SettingCommunityCell6:RefreshCell()
end

function SettingCommunityCell6:OnBtnClick()
  self._delegate:OnCell6BtnClick()
end

return SettingCommunityCell6
