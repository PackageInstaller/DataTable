-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settingsystemcharcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local SystemSettingCharCell = class("SystemSettingCharCell", Dialog)
SystemSettingCharCell.AssetBundleName = "ui/layouts.setting"
SystemSettingCharCell.AssetName = "SettingSystemChar"
SystemSettingCharCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SystemSettingCharCell
  ((SystemSettingCharCell.super).Ctor)(self, ...)
  self._characterDisplayData = {}
end

SystemSettingCharCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._characterDisplayBack = self:GetChild("Back")
  self._characterDisplayOpenIcon = self:GetChild("Btn")
  self._characterDisplayHideIcon = self:GetChild("BtnDown")
  self._characterDisplayOpenName = self:GetChild("Btn/Txt")
  self._characterDisplayHideName = self:GetChild("BtnDown/Txt")
  self._characterDisplayFrameBack = self:GetChild("CharList")
  self._characterDisplayFramePanel = self:GetChild("CharList/Frame")
  self._characterDisplayFrame = (TableFrame.Create)(self._characterDisplayFramePanel, self, true, false, true)
  ;
  (self._characterDisplayBack):Subscribe_PointerClickEvent(self.OpenOrHideCharDisplayFrame, self)
  ;
  (self._characterDisplayOpenIcon):Subscribe_PointerClickEvent(self.OpenCharDisplayFrame, self)
  ;
  (self._characterDisplayHideIcon):Subscribe_PointerClickEvent(self.HideCharDisplayFrame, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNewOverlayFSMounted, Common.n_NewOverlayFSMounted, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

SystemSettingCharCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._characterDisplayFrame):Destroy()
end

SystemSettingCharCell.RefreshCell = function(self)
  -- function num : 0_3
  self:InitCharacterInfo()
end

SystemSettingCharCell.ChangeCharacterDisplay = function(self, displayData)
  -- function num : 0_4 , upvalues : _ENV
  if displayData.type == 1 then
    (Live2DManager.SaveLocalSelected)(1)
  else
    ;
    (Live2DManager.SaveLocalSelected)(2)
  end
  self:InitCharacterInfo()
end

SystemSettingCharCell.OnSelectCharacterDisplay = function(self, displayData)
  -- function num : 0_5 , upvalues : _ENV
  LogInfoFormat("SystemSettingCharCell ", " OnSelectCharacterDisplay character display Name:%s resName:%s ", displayData.name, displayData.resName)
  self:HideCharDisplayFrame()
  if displayData.state == 2 then
    return 
  end
  if (LuaUpdateManager.UseEditorRes)() then
    self:ChangeCharacterDisplay(displayData)
  else
    if displayData.state == 0 then
      local c, t = (((((CS.PixelNeko).FileSystem).Update).UpdateManagerGame).GetDownloadPatchesProgress)(displayData.resName)
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(114, {(string.format)("%.2f", (t - c) / 1024 / 1024)}, function()
    -- function num : 0_5_0 , upvalues : self, displayData
    self:ConfirmDownLoadCharacterDispay(displayData.resName)
  end
, {}, nil, {})
    else
      do
        if displayData.state == 1 then
          self:ChangeCharacterDisplay(displayData)
        else
          if displayData.state == 3 then
            ((DialogManager.CreateSingletonDialog)("resupdatedialog")):SetResName(displayData.resName)
          end
        end
      end
    end
  end
end

SystemSettingCharCell.InitCharacterInfo = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self._characterDisplayData = {}
  local live2DName = (TextManager.GetText)(701070)
  local imageName = (TextManager.GetText)(701069)
  local isLive2DSelected = (Live2DManager.IsLive2DSelected)()
  local live2DData = {}
  live2DData.name = live2DName
  live2DData.resName = (Live2DManager.GetResName)()
  live2DData.type = 1
  if (LuaUpdateManager.HasInGameUpdateFSM)(live2DData.resName) then
    live2DData.state = 3
  else
    if isLive2DSelected then
      live2DData.state = 2
    else
      if (Live2DManager.IsDownloaded)() then
        live2DData.state = 1
      else
        live2DData.state = 0
      end
    end
  end
  local imageData = {}
  imageData.name = imageName
  imageData.resName = ""
  imageData.type = 2
  if isLive2DSelected then
    imageData.state = 1
  else
    imageData.state = 2
  end
  ;
  (table.insert)(self._characterDisplayData, live2DData)
  ;
  (table.insert)(self._characterDisplayData, imageData)
  if isLive2DSelected then
    (self._characterDisplayOpenName):SetText(live2DName)
    ;
    (self._characterDisplayHideName):SetText(live2DName)
  else
    ;
    (self._characterDisplayOpenName):SetText(imageName)
    ;
    (self._characterDisplayHideName):SetText(imageName)
  end
  ;
  (self._characterDisplayFrame):ReloadAllCell()
end

SystemSettingCharCell.OpenCharDisplayFrame = function(self)
  -- function num : 0_7
  self._showCharacterDisplayFrame = true
  self:SetCharacterDisplayUIShowState()
end

SystemSettingCharCell.HideCharDisplayFrame = function(self)
  -- function num : 0_8
  self._showCharacterDisplayFrame = false
  self:SetCharacterDisplayUIShowState()
end

SystemSettingCharCell.OpenOrHideCharDisplayFrame = function(self)
  -- function num : 0_9
  self._showCharacterDisplayFrame = not self._showCharacterDisplayFrame
  self:SetAudioUIShowStSetCharacterDisplayUIShowStateate()
end

SystemSettingCharCell.SetCharacterDisplayUIShowState = function(self)
  -- function num : 0_10
  (self._characterDisplayFrameBack):SetActive(self._showCharacterDisplayFrame)
  ;
  (self._characterDisplayOpenIcon):SetActive(not self._showCharacterDisplayFrame)
  ;
  (self._characterDisplayHideIcon):SetActive(self._showCharacterDisplayFrame)
end

SystemSettingCharCell.NumberOfCell = function(self, helper)
  -- function num : 0_11
  return #self._characterDisplayData
end

SystemSettingCharCell.CellAtIndex = function(self, helper, index)
  -- function num : 0_12
  return "systemsetting.selectcharacterdisplaycell"
end

SystemSettingCharCell.DataAtIndex = function(self, helper, index)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self._characterDisplayData)[index]).index = index
  return (self._characterDisplayData)[index]
end

SystemSettingCharCell.OnNewOverlayFSMounted = function(self, args)
  -- function num : 0_14 , upvalues : _ENV
  if args.userInfo == (Live2DManager.GetResName)() then
    self:InitCharacterInfo()
    return 
  end
end

SystemSettingCharCell.OnGlobalPointerDown = function(self, args)
  -- function num : 0_15 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._characterDisplayFramePanel)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:HideCharDisplayFrame()
  end
end

return SystemSettingCharCell

