-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settinglanguagedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local SettingLanguageDialog = class("SettingLanguageDialog", Dialog)
SettingLanguageDialog.AssetBundleName = "ui/layouts.setting"
SettingLanguageDialog.AssetName = "SettingLanguage"
local audioLanguageNum = 2
SettingLanguageDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingLanguageDialog
  ((SettingLanguageDialog.super).Ctor)(self, ...)
  self._languageData = {}
  self._audioData = {}
  self.bShowAudioFrame = false
  self._characterDisplayData = {}
  self._showCharacterDisplayFrame = false
  self._bDownLoadVersion = false
  self._audioResInfo = {}
end

SettingLanguageDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._audioBack = self:GetChild("Voice/Back")
  self._audioOpenIcon = self:GetChild("Voice/Btn")
  self._audioHideIcon = self:GetChild("Voice/BtnDown")
  self._curAudioName = self:GetChild("Voice/Btn/Txt")
  self._curAudioName2 = self:GetChild("Voice/BtnDown/Txt")
  self._audioFrameBack = self:GetChild("VoiceList")
  self._audioFramePanel = self:GetChild("VoiceList/Frame")
  self._audioFrame = (TableFrame.Create)(self._audioFramePanel, self, true, true, true)
  self._characterDisplayBack = self:GetChild("Char/Back")
  self._characterDisplayOpenIcon = self:GetChild("Char/Btn")
  self._characterDisplayHideIcon = self:GetChild("Char/BtnDown")
  self._characterDisplayOpenName = self:GetChild("Char/Btn/Txt")
  self._characterDisplayHideName = self:GetChild("Char/BtnDown/Txt")
  self._characterDisplayFrameBack = self:GetChild("CharList")
  self._characterDisplayFramePanel = self:GetChild("CharList/Frame")
  self._characterDisplayFrame = (TableFrame.Create)(self._characterDisplayFramePanel, self, true, true, true)
  ;
  (self._audioBack):Subscribe_PointerClickEvent(self.OpenOrHideAudioFrame, self)
  ;
  (self._audioOpenIcon):Subscribe_PointerClickEvent(self.OpenAudioFrame, self)
  ;
  (self._audioHideIcon):Subscribe_PointerClickEvent(self.HideAudioFrame, self)
  ;
  (self._characterDisplayBack):Subscribe_PointerClickEvent(self.OpenOrHideCharDisplayFrame, self)
  ;
  (self._characterDisplayOpenIcon):Subscribe_PointerClickEvent(self.OpenCharDisplayFrame, self)
  ;
  (self._characterDisplayHideIcon):Subscribe_PointerClickEvent(self.HideCharDisplayFrame, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNewOverlayFSMounted, Common.n_NewOverlayFSMounted, nil)
  self:InitAudioInfo()
  self:InitCharacterInfo()
end

SettingLanguageDialog.InitAudioInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local curAudioResName = (LuaAudioManager.GetCurrentVoiceResName)()
  self._audioData = {}
  if (LuaUpdateManager.UseEditorRes)() then
    local data = {}
    data.audioResName = "audio-zh_Hans"
    data.langCode = "zh_Hans"
    data.audioName = (TextManager.GetText)(700765)
    if curAudioResName == data.audioResName then
      data.state = 2
      ;
      (self._curAudioName):SetText(data.audioName)
      ;
      (self._curAudioName2):SetText(data.audioName)
    else
      data.state = 1
    end
    ;
    (table.insert)(self._audioData, data)
    local data = {}
    data.audioResName = "audio-ja_JP"
    data.langCode = "ja_JP"
    data.audioName = (TextManager.GetText)(700766)
    if curAudioResName == data.audioResName then
      data.state = 2
      ;
      (self._curAudioName):SetText(data.audioName)
      ;
      (self._curAudioName2):SetText(data.audioName)
    else
      data.state = 1
    end
    ;
    (table.insert)(self._audioData, data)
  else
    do
      for k,v in pairs((LuaUpdateManager.GetUpdateStateChecks)()) do
        local data = {}
        data.audioResName = k
        data.state = 0
        if v then
          data.state = 1
          if (LuaUpdateManager.HasInGameUpdateFSM)(k) then
            data.state = 3
          end
        end
        if k == "audio-zh_Hans" then
          data.audioName = (TextManager.GetText)(700765)
          data.langCode = "zh_Hans"
        else
          if k == "audio-ja_JP" then
            data.audioName = (TextManager.GetText)(700766)
            data.langCode = "ja_JP"
          end
        end
        if data.audioName then
          (table.insert)(self._audioData, data)
          if curAudioResName == k then
            data.state = 2
            ;
            (self._curAudioName):SetText(data.audioName)
            ;
            (self._curAudioName2):SetText(data.audioName)
          end
        end
      end
      do
        ;
        (self._audioFrame):ReloadAllCell()
      end
    end
  end
end

SettingLanguageDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._audioFrame):Destroy()
  ;
  (self._characterDisplayFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

SettingLanguageDialog.NumberOfCell = function(self, helper)
  -- function num : 0_4
  if helper == self._audioFrame then
    return #self._audioData
  else
    if helper == self._characterDisplayFrame then
      return #self._characterDisplayData
    else
      return #self._languageData
    end
  end
end

SettingLanguageDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_5
  if helper == self._audioFrame then
    return "systemsetting.selectaudiocell"
  else
    if helper == self._characterDisplayFrame then
      return "systemsetting.selectcharacterdisplaycell"
    else
      return "systemsetting.selectlanguagecell"
    end
  end
end

SettingLanguageDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_6
  if helper == self._audioFrame then
    return (self._audioData)[index]
  else
    if helper == self._characterDisplayFrame then
      return (self._characterDisplayData)[index]
    else
      return (self._languageData)[index]
    end
  end
end

SettingLanguageDialog.OpenAudioFrame = function(self)
  -- function num : 0_7
  self.bShowAudioFrame = true
  self:SetAudioUIShowState()
end

SettingLanguageDialog.HideAudioFrame = function(self)
  -- function num : 0_8
  self.bShowAudioFrame = false
  self:SetAudioUIShowState()
end

SettingLanguageDialog.OpenOrHideAudioFrame = function(self)
  -- function num : 0_9
  self.bShowAudioFrame = not self.bShowAudioFrame
  self:SetAudioUIShowState()
end

SettingLanguageDialog.SetAudioUIShowState = function(self)
  -- function num : 0_10
  (self._audioFrameBack):SetActive(self.bShowAudioFrame)
  ;
  (self._audioOpenIcon):SetActive(not self.bShowAudioFrame)
  ;
  (self._audioHideIcon):SetActive(self.bShowAudioFrame)
end

SettingLanguageDialog.OnSelectAudio = function(self, audioInfo)
  -- function num : 0_11 , upvalues : _ENV
  LogInfoFormat("SettingLanguageDialog ", " OnSelectAudio audio Name:%s resName:%s ", audioInfo.audioName, audioInfo.audioResName)
  self:HideAudioFrame()
  if audioInfo.state == 2 then
    return 
  end
  self._selectAudioLangCode = audioInfo.langCode
  if (LuaUpdateManager.UseEditorRes)() then
    self:ChangeAudio()
  else
    if audioInfo.state == 0 then
      local c, t = (((((CS.PixelNeko).FileSystem).Update).UpdateManagerGame).GetDownloadPatchesProgress)(audioInfo.audioResName)
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(72, {(string.format)("%.2f", (t - c) / 1024 / 1024)}, function()
    -- function num : 0_11_0 , upvalues : self, audioInfo
    self:ConfirmDownLoadAudio(audioInfo.audioResName)
  end
, {}, nil, {})
    else
      do
        if audioInfo.state == 1 then
          self:ChangeAudio()
        else
          if audioInfo.state == 3 then
            ((DialogManager.CreateSingletonDialog)("resupdatedialog")):SetResName(audioInfo.audioResName)
          end
        end
      end
    end
  end
end

SettingLanguageDialog.ConfirmDownLoadAudio = function(self, resName)
  -- function num : 0_12 , upvalues : _ENV
  if (((((CS.PixelNeko).FileSystem).Update).UpdateManagerGame).CreateUpdateFSMGame)(resName) then
    self:InitAudioInfo()
    ;
    ((DialogManager.CreateSingletonDialog)("resupdatedialog")):SetResName(resName)
  else
    LogErrorFormat("SettingLanguageDialog", "CreateUpdateFSMGame fail, resName = %s", resName)
  end
end

SettingLanguageDialog.ChangeAudio = function(self)
  -- function num : 0_13 , upvalues : _ENV
  LogInfoFormat("SettingLanguageDialog", ": ChangeVoiceType %s ", self._selectAudioLangCode)
  ;
  (((CS.UnityEngine).PlayerPrefs).SetString)("VoiceLangCode", self._selectAudioLangCode)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_AudioLanguageChanged, nil)
  self:InitAudioInfo()
end

SettingLanguageDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_14 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._audioFrameBack)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:HideAudioFrame()
  end
end

SettingLanguageDialog.InitCharacterInfo = function(self)
  -- function num : 0_15 , upvalues : _ENV
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
  if isLive2DSelected then
    (table.insert)(self._characterDisplayData, live2DData)
    ;
    (table.insert)(self._characterDisplayData, imageData)
    ;
    (self._characterDisplayOpenName):SetText(live2DName)
    ;
    (self._characterDisplayHideName):SetText(live2DName)
  else
    ;
    (table.insert)(self._characterDisplayData, imageData)
    ;
    (table.insert)(self._characterDisplayData, live2DData)
    ;
    (self._characterDisplayOpenName):SetText(imageName)
    ;
    (self._characterDisplayHideName):SetText(imageName)
  end
  ;
  (self._characterDisplayFrame):ReloadAllCell()
end

SettingLanguageDialog.OnSelectCharacterDisplay = function(self, displayData)
  -- function num : 0_16 , upvalues : _ENV
  LogInfoFormat("SettingLanguageDialog ", " OnSelectCharacterDisplay character display Name:%s resName:%s ", displayData.name, displayData.resName)
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
    -- function num : 0_16_0 , upvalues : self, displayData
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

SettingLanguageDialog.ChangeCharacterDisplay = function(self, displayData)
  -- function num : 0_17 , upvalues : _ENV
  if displayData.type == 1 then
    (Live2DManager.SaveLocalSelected)(1)
  else
    ;
    (Live2DManager.SaveLocalSelected)(2)
  end
  self:InitCharacterInfo()
end

SettingLanguageDialog.ConfirmDownLoadCharacterDispay = function(self, resName)
  -- function num : 0_18 , upvalues : _ENV
  if (((((CS.PixelNeko).FileSystem).Update).UpdateManagerGame).CreateUpdateFSMGame)(resName) then
    ((DialogManager.CreateSingletonDialog)("resupdatedialog")):SetResName(resName)
  else
    LogErrorFormat("SettingLanguageDialog", "CreateUpdateFSMGame fail, resName = %s", resName)
  end
end

SettingLanguageDialog.OpenCharDisplayFrame = function(self)
  -- function num : 0_19
  self._showCharacterDisplayFrame = true
  self:SetCharacterDisplayUIShowState()
end

SettingLanguageDialog.HideCharDisplayFrame = function(self)
  -- function num : 0_20
  self._showCharacterDisplayFrame = false
  self:SetCharacterDisplayUIShowState()
end

SettingLanguageDialog.OpenOrHideCharDisplayFrame = function(self)
  -- function num : 0_21
  self._showCharacterDisplayFrame = not self._showCharacterDisplayFrame
  self:SetAudioUIShowStSetCharacterDisplayUIShowStateate()
end

SettingLanguageDialog.SetCharacterDisplayUIShowState = function(self)
  -- function num : 0_22
  (self._characterDisplayFrameBack):SetActive(self._showCharacterDisplayFrame)
  ;
  (self._characterDisplayOpenIcon):SetActive(not self._showCharacterDisplayFrame)
  ;
  (self._characterDisplayHideIcon):SetActive(self._showCharacterDisplayFrame)
end

SettingLanguageDialog.OnNewOverlayFSMounted = function(self, args)
  -- function num : 0_23 , upvalues : _ENV
  if args.userInfo == (Live2DManager.GetResName)() then
    self:InitCharacterInfo()
    return 
  end
  self:InitAudioInfo()
  if self._selectAudioLangCode and args.userInfo == "audio-" .. self._selectAudioLangCode then
    self:ChangeAudio()
  end
end

return SettingLanguageDialog

