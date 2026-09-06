local SettingCommunityCell1 = class("SettingCommunityCell1", Dialog)
SettingCommunityCell1.AssetBundleName = "ui/layouts.setting"
SettingCommunityCell1.AssetName = "SettingCommunityCell1"

function SettingCommunityCell1:Ctor(...)
  SettingCommunityCell1.super.Ctor(self, ...)
end

function SettingCommunityCell1:OnCreate()
  self._btn = self:GetChild("Btn")
  self._btn:Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

function SettingCommunityCell1:OnDestroy(...)
end

function SettingCommunityCell1:RefreshCell()
end

function SettingCommunityCell1:OnBtnClick()
  self._delegate:OnCell1BtnClick()
end

return SettingCommunityCell1
