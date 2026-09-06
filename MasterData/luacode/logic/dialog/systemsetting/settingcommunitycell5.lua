local SettingCommunityCell5 = class("SettingCommunityCell5", Dialog)
SettingCommunityCell5.AssetBundleName = "ui/layouts.setting"
SettingCommunityCell5.AssetName = "SettingCommunityCell5"

function SettingCommunityCell5:Ctor(...)
  SettingCommunityCell5.super.Ctor(self, ...)
end

function SettingCommunityCell5:OnCreate()
  self._btn = self:GetChild("Btn")
  self._btn:Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

function SettingCommunityCell5:OnDestroy(...)
end

function SettingCommunityCell5:RefreshCell()
end

function SettingCommunityCell5:OnBtnClick()
  self._delegate:OnCell5BtnClick()
end

return SettingCommunityCell5
