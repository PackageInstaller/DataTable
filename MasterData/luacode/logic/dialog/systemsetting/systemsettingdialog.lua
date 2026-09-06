local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local SoundLevelTable = BeanManager.GetTableByName("setting.csoundlevel")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local SystemSettingDialog = class("SystemSettingDialog", Dialog)
SystemSettingDialog.AssetBundleName = "ui/layouts.setting"
SystemSettingDialog.AssetName = "SettingMain"

function SystemSettingDialog:Ctor(...)
  SystemSettingDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._tab = nil
end

function SystemSettingDialog:OnCreate()
  self._groupBtnList = {}
  for i = 2, 6 do
    self._groupBtnList[i] = self:GetChild("Back/Group/GroupBtn" .. i)
  end
  self._groupBtnRedList = {}
  for i = 2, 6 do
    self._groupBtnRedList[i] = self:GetChild("Back/Group/GroupBtn" .. i .. "/RedDot")
    self._groupBtnRedList[i]:SetActive(false)
  end
  if not CS.PixelNeko.LuaManager.IsUnityEditor() then
    self._groupBtnList[6]:SetActive(SdkManager.GetChannel() == "leit" and #NekoData.BehaviorManager.BM_Game:GetSupportCommunityCfg() ~= 0)
  end
  self._groupBtnSelectLine = {}
  for i = 2, 5 do
    self._groupBtnSelectLine[i] = self:GetChild("Back/Group/Select" .. i)
  end
  self._framePanel = self:GetChild("Back/Frame")
  self._backBtn = self:GetChild("BackBtn")
  self._frame = TabFrame.Create(self._framePanel, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._groupBtnList[2]:Subscribe_PointerClickEvent(self.OnBtn2Clicked, self)
  self._groupBtnList[3]:Subscribe_PointerClickEvent(self.OnBtn3Clicked, self)
  self._groupBtnList[4]:Subscribe_PointerClickEvent(self.OnBtn4Clicked, self)
  self._groupBtnList[5]:Subscribe_PointerClickEvent(self.OnBtn5Clicked, self)
  self._groupBtnList[6]:Subscribe_PointerClickEvent(self.OnBtn6Clicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnNewOverlayFSMounted, Common.n_NewOverlayFSMounted, nil)
  self:Init()
  local show = SdkManager.GetChannel() == "leit"
  self._groupBtnList[4]:SetActive(show)
  if not show then
    self._groupBtnList[4]:SetActive(SdkManager.GetChannel() == "none")
  end
end

function SystemSettingDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
end

function SystemSettingDialog:Init()
  self:OnBtn4Clicked()
  self:UpdateGroupRed()
end

function SystemSettingDialog:OnBackBtnClicked()
  self:Destroy()
end

function SystemSettingDialog:OnRefreshIdentityTabCell()
  self._frame:GetCellAtIndex(3):RefreshTabCell()
end

function SystemSettingDialog:DidToPage(window, orderIndex)
  for k, v in pairs(self._groupBtnList) do
    if k == orderIndex then
      self._groupBtnList[k]:SetSelected(true)
    else
      self._groupBtnList[k]:SetSelected(false)
    end
  end
  for k, v in pairs(self._groupBtnSelectLine) do
    if k == orderIndex then
      self._groupBtnSelectLine[k]:SetActive(true)
    else
      self._groupBtnSelectLine[k]:SetActive(false)
    end
  end
end

function SystemSettingDialog:UpdateGroupRed()
  local islive2d_downloaded = Live2DManager.IsDownloaded()
  if islive2d_downloaded then
    self._groupBtnRedList[2]:SetActive(false)
  else
    self._groupBtnRedList[2]:SetActive(true)
  end
  local isaudio_downloaded = LuaAudioManager.IsDownloaded()
  if isaudio_downloaded then
    self._groupBtnRedList[5]:SetActive(false)
  else
    self._groupBtnRedList[5]:SetActive(true)
  end
end

function SystemSettingDialog:OnNewOverlayFSMounted(args)
  self:UpdateGroupRed()
end

function SystemSettingDialog:OnBtn2Clicked()
  if self._tab ~= 2 then
    self._tab = 2
    self._frame:ToPage(self._tab)
  end
end

function SystemSettingDialog:OnBtn3Clicked()
  if self._tab ~= 3 then
    self._tab = 3
    self._frame:ToPage(self._tab)
  end
end

function SystemSettingDialog:OnBtn4Clicked()
  if self._tab ~= 4 then
    self._tab = 4
    self._frame:ToPage(self._tab)
  end
end

function SystemSettingDialog:OnBtn5Clicked()
  if self._tab ~= 5 then
    self._tab = 5
    self._frame:ToPage(self._tab)
  end
end

function SystemSettingDialog:OnBtn6Clicked()
  if self._tab ~= 6 then
    self._tab = 6
    self._frame:ToPage(self._tab)
  end
end

function SystemSettingDialog:CellAtIndex(frame, index)
  if index == 2 then
    return "systemsetting.systemsettingtabcell"
  elseif index == 3 then
    return "systemsetting.settingotherstabcell"
  elseif index == 4 then
    return "systemsetting.settingaccounttabcell"
  elseif index == 5 then
    return "systemsetting.settingsoundtabcell"
  elseif index == 6 then
    return "systemsetting.settingcommunitydialog"
  end
end

return SystemSettingDialog
