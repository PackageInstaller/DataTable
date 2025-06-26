-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settingcommunitywechatdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SettingCommunityWechatDialog = class("SettingCommunityWechatDialog", Dialog)
SettingCommunityWechatDialog.AssetBundleName = "ui/layouts.setting"
SettingCommunityWechatDialog.AssetName = "SettingCommunityWechat"
SettingCommunityWechatDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingCommunityWechatDialog
  ((SettingCommunityWechatDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

SettingCommunityWechatDialog.OnCreate = function(self)
  -- function num : 0_1
  (self:GetChild("Panel")):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

SettingCommunityWechatDialog.OnDestroy = function(self, ...)
  -- function num : 0_2
end

SettingCommunityWechatDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("systemsetting.settingcommunitywechatdialog")
end

return SettingCommunityWechatDialog

