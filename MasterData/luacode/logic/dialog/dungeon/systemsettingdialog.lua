-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/systemsettingdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SystemSettingDialog = class("SystemSettingDialog", Dialog)
SystemSettingDialog.AssetBundleName = "ui/layouts"
SystemSettingDialog.AssetName = "SystemSettingMain"
SystemSettingDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SystemSettingDialog
  ((SystemSettingDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._createFlag = false
end

SystemSettingDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._backBtn = self:GetChild("__BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._toggle_0 = self:GetChild("MoveMethod/ToggleGroup/_Toggle_0")
  ;
  (self._toggle_0):SetUserData(0)
  ;
  (self._toggle_0):Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  self._toggle_1 = self:GetChild("MoveMethod/ToggleGroup/_Toggle_1")
  ;
  (self._toggle_1):SetUserData(1)
  ;
  (self._toggle_1):Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  self._createFlag = true
  if ((NekoData.BehaviorManager).BM_SystemSetting):GetMobileMode() == "rockerMobileMode" then
    (self._toggle_0):SetIsOnType(true)
    ;
    (self._toggle_1):SetIsOnType(false)
  else
    ;
    (self._toggle_0):SetIsOnType(false)
    ;
    (self._toggle_1):SetIsOnType(true)
  end
end

SystemSettingDialog.OnDestroy = function(self)
  -- function num : 0_2
end

SystemSettingDialog.OnBackBtnClicked = function(self, args)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("dungeon.systemsettingdialog")
  ;
  (DialogManager.CreateSingletonDialog)("dungeon.settingmenu")
end

SystemSettingDialog.OnValueChanged = function(self, args, luawindow)
  -- function num : 0_4 , upvalues : _ENV
  if self._createFlag then
    self._createFlag = false
  else
    if ((NekoData.BehaviorManager).BM_SystemSetting):GetMobileMode() == "clickMobileMode" and luawindow:GetUserData() == 0 then
      (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
      ;
      ((NekoData.DataManager).DM_SystemSetting):SetRockerMobileMode()
    else
      if ((NekoData.BehaviorManager).BM_SystemSetting):GetMobileMode() == "rockerMobileMode" and luawindow:GetUserData() == 1 then
        (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
        ;
        ((NekoData.DataManager).DM_SystemSetting):SetClickMobileMode()
      end
    end
  end
end

return SystemSettingDialog

