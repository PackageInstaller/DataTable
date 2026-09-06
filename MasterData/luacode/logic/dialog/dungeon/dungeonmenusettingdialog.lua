local DungeonMenuSettingDialog = class("DungeonMenuSettingDialog", Dialog)
DungeonMenuSettingDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonMenuSettingDialog.AssetName = "DungeonMenuSetting"

function DungeonMenuSettingDialog:Ctor(...)
  DungeonMenuSettingDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._createFlag = {moveStyle = false, UIShow = false}
  self._originalMode = {}
end

function DungeonMenuSettingDialog:OnCreate()
  self._move_style_toggle_0 = self:GetChild("MoveStyle/ToggleGroup/_Toggle_0")
  self._move_style_toggle_0:SetUserData(0)
  self._move_style_toggle_0:Subscribe_ValueChangedEvent(self.OnMoveStyleValueChanged, self)
  self._move_style_toggle_1 = self:GetChild("MoveStyle/ToggleGroup/_Toggle_1")
  self._move_style_toggle_1:SetUserData(1)
  self._move_style_toggle_1:Subscribe_ValueChangedEvent(self.OnMoveStyleValueChanged, self)
  self._uishow_toggle_0 = self:GetChild("UIShow/ToggleGroup/_Toggle_0")
  self._uishow_toggle_0:SetUserData(0)
  self._uishow_toggle_0:Subscribe_ValueChangedEvent(self.OnUIShowValueChanged, self)
  self._uishow_toggle_1 = self:GetChild("UIShow/ToggleGroup/_Toggle_1")
  self._uishow_toggle_1:SetUserData(1)
  self._uishow_toggle_1:Subscribe_ValueChangedEvent(self.OnUIShowValueChanged, self)
  self._createFlag = {moveStyle = true, UIShow = true}
  if NekoData.BehaviorManager.BM_SystemSetting:GetMobileMode() == "rockerMobileMode" then
    self._move_style_toggle_0:SetIsOnType(true)
    self._move_style_toggle_1:SetIsOnType(false)
  else
    self._move_style_toggle_0:SetIsOnType(false)
    self._move_style_toggle_1:SetIsOnType(true)
  end
  if NekoData.BehaviorManager.BM_SystemSetting:GetUIShowMode() == "uiMovingHideMode" then
    self._uishow_toggle_0:SetIsOnType(true)
    self._uishow_toggle_1:SetIsOnType(false)
  else
    self._uishow_toggle_0:SetIsOnType(false)
    self._uishow_toggle_1:SetIsOnType(true)
  end
  self._saveBtn = self:GetChild("SaveBtn")
  self._closeBtn = self:GetChild("CloseBtn")
  self._saveBtn:Subscribe_PointerClickEvent(self.OnSaveBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
end

function DungeonMenuSettingDialog:OnDestroy()
end

function DungeonMenuSettingDialog:OnMoveStyleValueChanged(args, luawindow)
  if self._createFlag.moveStyle then
    self._originalMode.moveStyle = NekoData.BehaviorManager.BM_SystemSetting:GetMobileMode()
    self._createFlag.moveStyle = false
  elseif NekoData.BehaviorManager.BM_SystemSetting:GetMobileMode() == "clickMobileMode" and luawindow:GetUserData() == 0 then
    NekoData.DataManager.DM_SystemSetting:SetRockerMobileMode()
  elseif NekoData.BehaviorManager.BM_SystemSetting:GetMobileMode() == "rockerMobileMode" and luawindow:GetUserData() == 1 then
    NekoData.DataManager.DM_SystemSetting:SetClickMobileMode()
  end
end

function DungeonMenuSettingDialog:OnUIShowValueChanged(args, luawindow)
  if self._createFlag.UIShow then
    self._originalMode.UIShow = NekoData.BehaviorManager.BM_SystemSetting:GetUIShowMode()
    self._createFlag.UIShow = false
  elseif NekoData.BehaviorManager.BM_SystemSetting:GetUIShowMode() == "uiAlwaysShowMode" and luawindow:GetUserData() == 0 then
    NekoData.DataManager.DM_SystemSetting:SetUIMovingHideMode()
  elseif NekoData.BehaviorManager.BM_SystemSetting:GetUIShowMode() == "uiMovingHideMode" and luawindow:GetUserData() == 1 then
    NekoData.DataManager.DM_SystemSetting:SetUIAlwaysShowMode()
  end
end

function DungeonMenuSettingDialog:OnSaveBtnClicked()
  if NekoData.BehaviorManager.BM_SystemSetting:GetMobileMode() == "clickMobileMode" and self._originalMode.moveStyle == "rockerMobileMode" then
    DialogManager.DestroySingletonDialog("dungeon.rockerdialog")
  end
  if NekoData.BehaviorManager.BM_SystemSetting:GetMobileMode() == "rockerMobileMode" and self._originalMode.moveStyle == "clickMobileMode" then
    DialogManager.CreateSingletonDialog("dungeon.rockerdialog")
  end
  self:Destroy()
end

function DungeonMenuSettingDialog:OnCloseBtnClicked()
  if self._originalMode.moveStyle == "rockerMobileMode" then
    self._move_style_toggle_0:SetIsOnType(true)
    self._move_style_toggle_1:SetIsOnType(false)
  else
    self._move_style_toggle_0:SetIsOnType(false)
    self._move_style_toggle_1:SetIsOnType(true)
  end
  if self._originalMode.UIShow == "uiMovingHideMode" then
    self._uishow_toggle_0:SetIsOnType(true)
    self._uishow_toggle_1:SetIsOnType(false)
  else
    self._uishow_toggle_0:SetIsOnType(false)
    self._uishow_toggle_1:SetIsOnType(true)
  end
  self:Destroy()
end

return DungeonMenuSettingDialog
