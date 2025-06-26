-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/systemsettingdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local SoundLevelTable = (BeanManager.GetTableByName)("setting.csoundlevel")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local SystemSettingDialog = class("SystemSettingDialog", Dialog)
SystemSettingDialog.AssetBundleName = "ui/layouts.setting"
SystemSettingDialog.AssetName = "SettingMain"
SystemSettingDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SystemSettingDialog
  ((SystemSettingDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._tab = nil
end

SystemSettingDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TabFrame
  self._groupBtnList = {}
  for i = 2, 6 do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    (self._groupBtnList)[i] = self:GetChild("Back/Group/GroupBtn" .. i)
  end
  do
    if (SdkManager.GetChannel)() ~= "leit" or #((NekoData.BehaviorManager).BM_Game):GetSupportCommunityCfg() == 0 then
      ((self._groupBtnList)[6]):SetActive((((CS.PixelNeko).LuaManager).IsUnityEditor)())
      self._groupBtnSelectLine = {}
      for i = 2, 5 do
        -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

        (self._groupBtnSelectLine)[i] = self:GetChild("Back/Group/Select" .. i)
      end
      self._framePanel = self:GetChild("Back/Frame")
      self._backBtn = self:GetChild("BackBtn")
      self._frame = (TabFrame.Create)(self._framePanel, self)
      ;
      (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
      ;
      ((self._groupBtnList)[2]):Subscribe_PointerClickEvent(self.OnBtn2Clicked, self)
      ;
      ((self._groupBtnList)[3]):Subscribe_PointerClickEvent(self.OnBtn3Clicked, self)
      ;
      ((self._groupBtnList)[4]):Subscribe_PointerClickEvent(self.OnBtn4Clicked, self)
      ;
      ((self._groupBtnList)[5]):Subscribe_PointerClickEvent(self.OnBtn5Clicked, self)
      ;
      ((self._groupBtnList)[6]):Subscribe_PointerClickEvent(self.OnBtn6Clicked, self)
      self:Init()
      local show = (SdkManager.GetChannel)() == "leit"
      ;
      ((self._groupBtnList)[4]):SetActive(show)
      if (SdkManager.GetChannel)() ~= "none" then
        ((self._groupBtnList)[4]):SetActive(show)
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end
end

SystemSettingDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
end

SystemSettingDialog.Init = function(self)
  -- function num : 0_3
  self:OnBtn4Clicked()
end

SystemSettingDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

SystemSettingDialog.OnRefreshIdentityTabCell = function(self)
  -- function num : 0_5
  ((self._frame):GetCellAtIndex(3)):RefreshTabCell()
end

SystemSettingDialog.DidToPage = function(self, window, orderIndex)
  -- function num : 0_6 , upvalues : _ENV
  for k,v in pairs(self._groupBtnList) do
    if k == orderIndex then
      ((self._groupBtnList)[k]):SetSelected(true)
    else
      ;
      ((self._groupBtnList)[k]):SetSelected(false)
    end
  end
  for k,v in pairs(self._groupBtnSelectLine) do
    if k == orderIndex then
      ((self._groupBtnSelectLine)[k]):SetActive(true)
    else
      ;
      ((self._groupBtnSelectLine)[k]):SetActive(false)
    end
  end
end

SystemSettingDialog.OnBtn2Clicked = function(self)
  -- function num : 0_7
  if self._tab ~= 2 then
    self._tab = 2
    ;
    (self._frame):ToPage(self._tab)
  end
end

SystemSettingDialog.OnBtn3Clicked = function(self)
  -- function num : 0_8
  if self._tab ~= 3 then
    self._tab = 3
    ;
    (self._frame):ToPage(self._tab)
  end
end

SystemSettingDialog.OnBtn4Clicked = function(self)
  -- function num : 0_9
  if self._tab ~= 4 then
    self._tab = 4
    ;
    (self._frame):ToPage(self._tab)
  end
end

SystemSettingDialog.OnBtn5Clicked = function(self)
  -- function num : 0_10
  if self._tab ~= 5 then
    self._tab = 5
    ;
    (self._frame):ToPage(self._tab)
  end
end

SystemSettingDialog.OnBtn6Clicked = function(self)
  -- function num : 0_11
  if self._tab ~= 6 then
    self._tab = 6
    ;
    (self._frame):ToPage(self._tab)
  end
end

SystemSettingDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_12
  if index == 2 then
    return "systemsetting.systemsettingtabcell"
  else
    if index == 3 then
      return "systemsetting.settingotherstabcell"
    else
      if index == 4 then
        return "systemsetting.settingaccounttabcell"
      else
        if index == 5 then
          return "systemsetting.settingsoundtabcell"
        else
          if index == 6 then
            return "systemsetting.settingcommunitydialog"
          end
        end
      end
    end
  end
end

return SystemSettingDialog

