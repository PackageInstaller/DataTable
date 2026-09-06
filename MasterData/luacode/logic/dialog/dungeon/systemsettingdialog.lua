local SystemSettingDialog = class("SystemSettingDialog", Dialog)
SystemSettingDialog.AssetBundleName = "ui/layouts"
SystemSettingDialog.AssetName = "SystemSettingMain"

function SystemSettingDialog:Ctor(...)
  SystemSettingDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._createFlag = false
end

function SystemSettingDialog:OnCreate()
  self._backBtn = self:GetChild("__BackBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._toggle_0 = self:GetChild("MoveMethod/ToggleGroup/_Toggle_0")
  self._toggle_0:SetUserData(0)
  self._toggle_0:Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  self._toggle_1 = self:GetChild("MoveMethod/ToggleGroup/_Toggle_1")
  self._toggle_1:SetUserData(1)
  self._toggle_1:Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  self._createFlag = true
  if NekoData.BehaviorManager.BM_SystemSetting:GetMobileMode() == "rockerMobileMode" then
    self._toggle_0:SetIsOnType(true)
    self._toggle_1:SetIsOnType(false)
  else
    self._toggle_0:SetIsOnType(false)
    self._toggle_1:SetIsOnType(true)
  end
end

function SystemSettingDialog:OnDestroy()
end

function SystemSettingDialog:OnBackBtnClicked(args)
  DialogManager.DestroySingletonDialog("dungeon.systemsettingdialog")
  DialogManager.CreateSingletonDialog("dungeon.settingmenu")
end

function SystemSettingDialog:OnValueChanged(args, luawindow)
  if self._createFlag then
    self._createFlag = false
  elseif NekoData.BehaviorManager.BM_SystemSetting:GetMobileMode() == "clickMobileMode" and luawindow:GetUserData() == 0 then
    DialogManager.CreateSingletonDialog("dungeon.rockerdialog")
    NekoData.DataManager.DM_SystemSetting:SetRockerMobileMode()
  elseif NekoData.BehaviorManager.BM_SystemSetting:GetMobileMode() == "rockerMobileMode" and luawindow:GetUserData() == 1 then
    DialogManager.DestroySingletonDialog("dungeon.rockerdialog")
    NekoData.DataManager.DM_SystemSetting:SetClickMobileMode()
  end
end

return SystemSettingDialog
