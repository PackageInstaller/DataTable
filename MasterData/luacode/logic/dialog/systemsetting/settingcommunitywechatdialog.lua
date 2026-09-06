local SettingCommunityWechatDialog = class("SettingCommunityWechatDialog", Dialog)
SettingCommunityWechatDialog.AssetBundleName = "ui/layouts.setting"
SettingCommunityWechatDialog.AssetName = "SettingCommunityWechat"

function SettingCommunityWechatDialog:Ctor(...)
  SettingCommunityWechatDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function SettingCommunityWechatDialog:OnCreate()
  self:GetChild("Panel"):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function SettingCommunityWechatDialog:OnDestroy(...)
end

function SettingCommunityWechatDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("systemsetting.settingcommunitywechatdialog")
end

return SettingCommunityWechatDialog
