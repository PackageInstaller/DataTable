-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonmenusettingdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonMenuSettingDialog = class("DungeonMenuSettingDialog", Dialog)
DungeonMenuSettingDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonMenuSettingDialog.AssetName = "DungeonMenuSetting"
DungeonMenuSettingDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonMenuSettingDialog
  ((DungeonMenuSettingDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._createFlag = {moveStyle = false, UIShow = false}
  self._originalMode = {}
end

DungeonMenuSettingDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._move_style_toggle_0 = self:GetChild("MoveStyle/ToggleGroup/_Toggle_0")
  ;
  (self._move_style_toggle_0):SetUserData(0)
  ;
  (self._move_style_toggle_0):Subscribe_ValueChangedEvent(self.OnMoveStyleValueChanged, self)
  self._move_style_toggle_1 = self:GetChild("MoveStyle/ToggleGroup/_Toggle_1")
  ;
  (self._move_style_toggle_1):SetUserData(1)
  ;
  (self._move_style_toggle_1):Subscribe_ValueChangedEvent(self.OnMoveStyleValueChanged, self)
  self._uishow_toggle_0 = self:GetChild("UIShow/ToggleGroup/_Toggle_0")
  ;
  (self._uishow_toggle_0):SetUserData(0)
  ;
  (self._uishow_toggle_0):Subscribe_ValueChangedEvent(self.OnUIShowValueChanged, self)
  self._uishow_toggle_1 = self:GetChild("UIShow/ToggleGroup/_Toggle_1")
  ;
  (self._uishow_toggle_1):SetUserData(1)
  ;
  (self._uishow_toggle_1):Subscribe_ValueChangedEvent(self.OnUIShowValueChanged, self)
  self._createFlag = {moveStyle = true, UIShow = true}
  if ((NekoData.BehaviorManager).BM_SystemSetting):GetMobileMode() == "rockerMobileMode" then
    (self._move_style_toggle_0):SetIsOnType(true)
    ;
    (self._move_style_toggle_1):SetIsOnType(false)
  else
    ;
    (self._move_style_toggle_0):SetIsOnType(false)
    ;
    (self._move_style_toggle_1):SetIsOnType(true)
  end
  if ((NekoData.BehaviorManager).BM_SystemSetting):GetUIShowMode() == "uiMovingHideMode" then
    (self._uishow_toggle_0):SetIsOnType(true)
    ;
    (self._uishow_toggle_1):SetIsOnType(false)
  else
    ;
    (self._uishow_toggle_0):SetIsOnType(false)
    ;
    (self._uishow_toggle_1):SetIsOnType(true)
  end
  self._saveBtn = self:GetChild("SaveBtn")
  self._closeBtn = self:GetChild("CloseBtn")
  ;
  (self._saveBtn):Subscribe_PointerClickEvent(self.OnSaveBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
end

DungeonMenuSettingDialog.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonMenuSettingDialog.OnMoveStyleValueChanged = function(self, args, luawindow)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if (self._createFlag).moveStyle then
    (self._originalMode).moveStyle = ((NekoData.BehaviorManager).BM_SystemSetting):GetMobileMode()
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._createFlag).moveStyle = false
  else
    if ((NekoData.BehaviorManager).BM_SystemSetting):GetMobileMode() == "clickMobileMode" and luawindow:GetUserData() == 0 then
      ((NekoData.DataManager).DM_SystemSetting):SetRockerMobileMode()
    else
      if ((NekoData.BehaviorManager).BM_SystemSetting):GetMobileMode() == "rockerMobileMode" and luawindow:GetUserData() == 1 then
        ((NekoData.DataManager).DM_SystemSetting):SetClickMobileMode()
      end
    end
  end
end

DungeonMenuSettingDialog.OnUIShowValueChanged = function(self, args, luawindow)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if (self._createFlag).UIShow then
    (self._originalMode).UIShow = ((NekoData.BehaviorManager).BM_SystemSetting):GetUIShowMode()
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._createFlag).UIShow = false
  else
    if ((NekoData.BehaviorManager).BM_SystemSetting):GetUIShowMode() == "uiAlwaysShowMode" and luawindow:GetUserData() == 0 then
      ((NekoData.DataManager).DM_SystemSetting):SetUIMovingHideMode()
    else
      if ((NekoData.BehaviorManager).BM_SystemSetting):GetUIShowMode() == "uiMovingHideMode" and luawindow:GetUserData() == 1 then
        ((NekoData.DataManager).DM_SystemSetting):SetUIAlwaysShowMode()
      end
    end
  end
end

DungeonMenuSettingDialog.OnSaveBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_SystemSetting):GetMobileMode() == "clickMobileMode" and (self._originalMode).moveStyle == "rockerMobileMode" then
    (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
  end
  if ((NekoData.BehaviorManager).BM_SystemSetting):GetMobileMode() == "rockerMobileMode" and (self._originalMode).moveStyle == "clickMobileMode" then
    (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
  end
  self:Destroy()
end

DungeonMenuSettingDialog.OnCloseBtnClicked = function(self)
  -- function num : 0_6
  if (self._originalMode).moveStyle == "rockerMobileMode" then
    (self._move_style_toggle_0):SetIsOnType(true)
    ;
    (self._move_style_toggle_1):SetIsOnType(false)
  else
    ;
    (self._move_style_toggle_0):SetIsOnType(false)
    ;
    (self._move_style_toggle_1):SetIsOnType(true)
  end
  if (self._originalMode).UIShow == "uiMovingHideMode" then
    (self._uishow_toggle_0):SetIsOnType(true)
    ;
    (self._uishow_toggle_1):SetIsOnType(false)
  else
    ;
    (self._uishow_toggle_0):SetIsOnType(false)
    ;
    (self._uishow_toggle_1):SetIsOnType(true)
  end
  self:Destroy()
end

return DungeonMenuSettingDialog

