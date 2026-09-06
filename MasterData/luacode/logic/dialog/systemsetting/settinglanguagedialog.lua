local UIManager = CS.PixelNeko.UI.UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local SettingLanguageDialog = class("SettingLanguageDialog", Dialog)
SettingLanguageDialog.AssetBundleName = "ui/layouts.setting"
SettingLanguageDialog.AssetName = "SettingLanguage"
local audioLanguageNum = 2

function SettingLanguageDialog:Ctor(...)
  SettingLanguageDialog.super.Ctor(self, ...)
  self._languageData = {}
  self._audioData = {}
  self.bShowAudioFrame = false
  self._characterDisplayData = {}
  self._showCharacterDisplayFrame = false
  self._bDownLoadVersion = false
  self._audioResInfo = {}
end

function SettingLanguageDialog:OnCreate()
  self._audioBack = self:GetChild("Voice/Back")
  self._audioOpenIcon = self:GetChild("Voice/Btn")
  self._audioHideIcon = self:GetChild("Voice/BtnDown")
  self._curAudioName = self:GetChild("Voice/Btn/Txt")
  self._curAudioName2 = self:GetChild("Voice/BtnDown/Txt")
  self._audioFrameBack = self:GetChild("VoiceList")
  self._audioFramePanel = self:GetChild("VoiceList/Frame")
  self._audioFrame = TableFrame.Create(self._audioFramePanel, self, true, true, true)
  self._characterDisplayBack = self:GetChild("Char/Back")
  self._characterDisplayOpenIcon = self:GetChild("Char/Btn")
  self._characterDisplayHideIcon = self:GetChild("Char/BtnDown")
  self._characterDisplayOpenName = self:GetChild("Char/Btn/Txt")
  self._characterDisplayHideName = self:GetChild("Char/BtnDown/Txt")
  self._characterDisplayFrameBack = self:GetChild("CharList")
  self._characterDisplayFramePanel = self:GetChild("CharList/Frame")
  self._characterDisplayFrame = TableFrame.Create(self._characterDisplayFramePanel, self, true, true, true)
  self._audioBack:Subscribe_PointerClickEvent(self.OpenOrHideAudioFrame, self)
  self._audioOpenIcon:Subscribe_PointerClickEvent(self.OpenAudioFrame, self)
  self._audioHideIcon:Subscribe_PointerClickEvent(self.HideAudioFrame, self)
  self._characterDisplayBack:Subscribe_PointerClickEvent(self.OpenOrHideCharDisplayFrame, self)
  self._characterDisplayOpenIcon:Subscribe_PointerClickEvent(self.OpenCharDisplayFrame, self)
  self._characterDisplayHideIcon:Subscribe_PointerClickEvent(self.HideCharDisplayFrame, self)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNewOverlayFSMounted, Common.n_NewOverlayFSMounted, nil)
  self:InitAudioInfo()
  self:InitCharacterInfo()
end

function SettingLanguageDialog:InitAudioInfo()
  local curAudioResName = LuaAudioManager.GetCurrentVoiceResName()
  self._audioData = {}
  if LuaUpdateManager.UseEditorRes() then
    local data = {}
    data.audioResName = "audio-zh_Hans"
    data.langCode = "zh_Hans"
    data.audioName = TextManager.GetText(700765)
    if curAudioResName == data.audioResName then
      data.state = 2
      self._curAudioName:SetText(data.audioName)
      self._curAudioName2:SetText(data.audioName)
    else
      data.state = 1
    end
    table.insert(self._audioData, data)
    local data = {}
    data.audioResName = "audio-ja_JP"
    data.langCode = "ja_JP"
    data.audioName = TextManager.GetText(700766)
    if curAudioResName == data.audioResName then
      data.state = 2
      self._curAudioName:SetText(data.audioName)
      self._curAudioName2:SetText(data.audioName)
    else
      data.state = 1
    end
    table.insert(self._audioData, data)
  else
    for k, v in pairs(LuaUpdateManager.GetUpdateStateChecks()) do
      local data = {}
      data.audioResName = k
      data.state = 0
      if v then
        data.state = 1
        if LuaUpdateManager.HasInGameUpdateFSM(k) then
          data.state = 3
        end
      end
      if k == "audio-zh_Hans" then
        data.audioName = TextManager.GetText(700765)
        data.langCode = "zh_Hans"
      elseif k == "audio-ja_JP" then
        data.audioName = TextManager.GetText(700766)
        data.langCode = "ja_JP"
      end
      if data.audioName then
        table.insert(self._audioData, data)
        if curAudioResName == k then
          data.state = 2
          self._curAudioName:SetText(data.audioName)
          self._curAudioName2:SetText(data.audioName)
        end
      end
    end
  end
  self._audioFrame:ReloadAllCell()
end

function SettingLanguageDialog:OnDestroy()
  self._audioFrame:Destroy()
  self._characterDisplayFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function SettingLanguageDialog:NumberOfCell(helper)
  if helper == self._audioFrame then
    return #self._audioData
  elseif helper == self._characterDisplayFrame then
    return #self._characterDisplayData
  else
    return #self._languageData
  end
end

function SettingLanguageDialog:CellAtIndex(helper, index)
  if helper == self._audioFrame then
    return "systemsetting.selectaudiocell"
  elseif helper == self._characterDisplayFrame then
    return "systemsetting.selectcharacterdisplaycell"
  else
    return "systemsetting.selectlanguagecell"
  end
end

function SettingLanguageDialog:DataAtIndex(helper, index)
  if helper == self._audioFrame then
    return self._audioData[index]
  elseif helper == self._characterDisplayFrame then
    return self._characterDisplayData[index]
  else
    return self._languageData[index]
  end
end

function SettingLanguageDialog:OpenAudioFrame()
  self.bShowAudioFrame = true
  self:SetAudioUIShowState()
end

function SettingLanguageDialog:HideAudioFrame()
  self.bShowAudioFrame = false
  self:SetAudioUIShowState()
end

function SettingLanguageDialog:OpenOrHideAudioFrame()
  self.bShowAudioFrame = not self.bShowAudioFrame
  self:SetAudioUIShowState()
end

function SettingLanguageDialog:SetAudioUIShowState()
  self._audioFrameBack:SetActive(self.bShowAudioFrame)
  self._audioOpenIcon:SetActive(not self.bShowAudioFrame)
  self._audioHideIcon:SetActive(self.bShowAudioFrame)
end

function SettingLanguageDialog:OnSelectAudio(audioInfo)
  LogInfoFormat("SettingLanguageDialog ", " OnSelectAudio audio Name:%s resName:%s ", audioInfo.audioName, audioInfo.audioResName)
  self:HideAudioFrame()
  if audioInfo.state == 2 then
    return
  end
  self._selectAudioLangCode = audioInfo.langCode
  if LuaUpdateManager.UseEditorRes() then
    self:ChangeAudio()
  elseif audioInfo.state == 0 then
    local c, t = CS.PixelNeko.FileSystem.Update.UpdateManagerGame.GetDownloadPatchesProgress(audioInfo.audioResName)
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(72, {
      string.format("%.2f", (t - c) / 1024 / 1024)
    }, function()
      self:ConfirmDownLoadAudio(audioInfo.audioResName)
    end, {}, nil, {})
  elseif audioInfo.state == 1 then
    self:ChangeAudio()
  elseif audioInfo.state == 3 then
    DialogManager.CreateSingletonDialog("resupdatedialog"):SetResName(audioInfo.audioResName)
  end
end

function SettingLanguageDialog:ConfirmDownLoadAudio(resName)
  if CS.PixelNeko.FileSystem.Update.UpdateManagerGame.CreateUpdateFSMGame(resName) then
    self:InitAudioInfo()
    DialogManager.CreateSingletonDialog("resupdatedialog"):SetResName(resName)
  else
    LogErrorFormat("SettingLanguageDialog", "CreateUpdateFSMGame fail, resName = %s", resName)
  end
end

function SettingLanguageDialog:ChangeAudio()
  LogInfoFormat("SettingLanguageDialog", ": ChangeVoiceType %s ", self._selectAudioLangCode)
  CS.UnityEngine.PlayerPrefs.SetString("VoiceLangCode", self._selectAudioLangCode)
  LuaNotificationCenter.PostNotification(Common.n_AudioLanguageChanged, nil)
  self:InitAudioInfo()
end

function SettingLanguageDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._audioFrameBack._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:HideAudioFrame()
  end
end

function SettingLanguageDialog:InitCharacterInfo()
  self._characterDisplayData = {}
  local live2DName = TextManager.GetText(701070)
  local imageName = TextManager.GetText(701069)
  local isLive2DSelected = Live2DManager.IsLive2DSelected()
  local live2DData = {}
  live2DData.name = live2DName
  live2DData.resName = Live2DManager.GetResName()
  live2DData.type = 1
  if LuaUpdateManager.HasInGameUpdateFSM(live2DData.resName) then
    live2DData.state = 3
  elseif isLive2DSelected then
    live2DData.state = 2
  elseif Live2DManager.IsDownloaded() then
    live2DData.state = 1
  else
    live2DData.state = 0
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
    table.insert(self._characterDisplayData, live2DData)
    table.insert(self._characterDisplayData, imageData)
    self._characterDisplayOpenName:SetText(live2DName)
    self._characterDisplayHideName:SetText(live2DName)
  else
    table.insert(self._characterDisplayData, imageData)
    table.insert(self._characterDisplayData, live2DData)
    self._characterDisplayOpenName:SetText(imageName)
    self._characterDisplayHideName:SetText(imageName)
  end
  self._characterDisplayFrame:ReloadAllCell()
end

function SettingLanguageDialog:OnSelectCharacterDisplay(displayData)
  LogInfoFormat("SettingLanguageDialog ", " OnSelectCharacterDisplay character display Name:%s resName:%s ", displayData.name, displayData.resName)
  self:HideCharDisplayFrame()
  if displayData.state == 2 then
    return
  end
  if LuaUpdateManager.UseEditorRes() then
    self:ChangeCharacterDisplay(displayData)
  elseif displayData.state == 0 then
    local c, t = CS.PixelNeko.FileSystem.Update.UpdateManagerGame.GetDownloadPatchesProgress(displayData.resName)
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(114, {
      string.format("%.2f", (t - c) / 1024 / 1024)
    }, function()
      self:ConfirmDownLoadCharacterDispay(displayData.resName)
    end, {}, nil, {})
  elseif displayData.state == 1 then
    self:ChangeCharacterDisplay(displayData)
  elseif displayData.state == 3 then
    DialogManager.CreateSingletonDialog("resupdatedialog"):SetResName(displayData.resName)
  end
end

function SettingLanguageDialog:ChangeCharacterDisplay(displayData)
  if displayData.type == 1 then
    Live2DManager.SaveLocalSelected(1)
  else
    Live2DManager.SaveLocalSelected(2)
  end
  self:InitCharacterInfo()
end

function SettingLanguageDialog:ConfirmDownLoadCharacterDispay(resName)
  if CS.PixelNeko.FileSystem.Update.UpdateManagerGame.CreateUpdateFSMGame(resName) then
    DialogManager.CreateSingletonDialog("resupdatedialog"):SetResName(resName)
  else
    LogErrorFormat("SettingLanguageDialog", "CreateUpdateFSMGame fail, resName = %s", resName)
  end
end

function SettingLanguageDialog:OpenCharDisplayFrame()
  self._showCharacterDisplayFrame = true
  self:SetCharacterDisplayUIShowState()
end

function SettingLanguageDialog:HideCharDisplayFrame()
  self._showCharacterDisplayFrame = false
  self:SetCharacterDisplayUIShowState()
end

function SettingLanguageDialog:OpenOrHideCharDisplayFrame()
  self._showCharacterDisplayFrame = not self._showCharacterDisplayFrame
  self:SetAudioUIShowStSetCharacterDisplayUIShowStateate()
end

function SettingLanguageDialog:SetCharacterDisplayUIShowState()
  self._characterDisplayFrameBack:SetActive(self._showCharacterDisplayFrame)
  self._characterDisplayOpenIcon:SetActive(not self._showCharacterDisplayFrame)
  self._characterDisplayHideIcon:SetActive(self._showCharacterDisplayFrame)
end

function SettingLanguageDialog:OnNewOverlayFSMounted(args)
  if args.userInfo == Live2DManager.GetResName() then
    self:InitCharacterInfo()
    return
  end
  self:InitAudioInfo()
  if self._selectAudioLangCode and args.userInfo == "audio-" .. self._selectAudioLangCode then
    self:ChangeAudio()
  end
end

return SettingLanguageDialog
