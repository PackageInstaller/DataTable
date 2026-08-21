-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settingsoundtabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local SoundLevelTable = (BeanManager.GetTableByName)("setting.csoundlevel")
local SettingSoundTabCell = class("SettingSoundTabCell", Dialog)
SettingSoundTabCell.AssetBundleName = "ui/layouts.setting"
SettingSoundTabCell.AssetName = "SettingSound"
local audioLanguageNum = 2
SettingSoundTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingSoundTabCell
  ((SettingSoundTabCell.super).Ctor)(self, ...)
  self._languageData = {}
  self._audioData = {}
  self.bShowAudioFrame = false
  self._bDownLoadVersion = false
  self._audioResInfo = {}
end

SettingSoundTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._musicToggleList = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

      (self._musicToggleList)[i] = self:GetChild("Frame/SettingSystemMusic/ToggleGroup/Toggle" .. i)
      ;
      ((self._musicToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnMusicValueChanged(i)
  end
)
    end
  end
  self._soundToggleList = {}
  for i = 1, 4 do
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

    (self._soundToggleList)[i] = self:GetChild("Frame/SettingSystemSound/ToggleGroup/Toggle" .. i)
    ;
    ((self._soundToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_1 , upvalues : self, i
    self:OnSoundValueChanged(i)
  end
)
  end
  self._voiceToggleList = {}
  for i = 1, 4 do
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

    (self._voiceToggleList)[i] = self:GetChild("Frame/SettingSystemVoice/ToggleGroup/Toggle" .. i)
    ;
    ((self._voiceToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_2 , upvalues : self, i
    self:OnVoiceValueChanged(i)
  end
)
  end
  self._audioBack = self:GetChild("Frame/SettingLanguage/Voice/Back")
  self._audioOpenIcon = self:GetChild("Frame/SettingLanguage/Voice/Btn")
  self._audioHideIcon = self:GetChild("Frame/SettingLanguage/Voice/BtnDown")
  self._curAudioName = self:GetChild("Frame/SettingLanguage/Voice/Btn/Txt")
  self._curAudioName2 = self:GetChild("Frame/SettingLanguage/Voice/BtnDown/Txt")
  self._audioFrameBack = self:GetChild("Frame/SettingLanguage/VoiceList")
  self._audioFramePanel = self:GetChild("Frame/SettingLanguage/VoiceList/Frame")
  self._audioFrame = (TableFrame.Create)(self._audioFramePanel, self, true, false, true)
  self._x = (self._audioFramePanel):GetSize()
  self._pos_x = (self._audioFramePanel):GetPosition()
  self._rootX = (self._audioFrameBack):GetSize()
  self._pos_rootX = (self._audioFrameBack):GetPosition()
  ;
  (self._audioBack):Subscribe_PointerClickEvent(self.OpenOrHideAudioFrame, self)
  ;
  (self._audioOpenIcon):Subscribe_PointerClickEvent(self.OpenAudioFrame, self)
  ;
  (self._audioHideIcon):Subscribe_PointerClickEvent(self.HideAudioFrame, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNewOverlayFSMounted, Common.n_NewOverlayFSMounted, nil)
  self:InitAudioInfo()
end

SettingSoundTabCell.InitAudioInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV, SysConfigEnum
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
        local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
        for i,v in ipairs(self._musicToggleList) do
          if i == sysConfig[SysConfigEnum.musicNum] then
            v:SetIsOnType(true)
          else
            v:SetIsOnType(false)
          end
        end
        for i,v in ipairs(self._soundToggleList) do
          if i == sysConfig[SysConfigEnum.soundEffectNum] then
            v:SetIsOnType(true)
          else
            v:SetIsOnType(false)
          end
        end
        for i,v in ipairs(self._voiceToggleList) do
          if i == sysConfig[SysConfigEnum.dubbingNum] then
            v:SetIsOnType(true)
          else
            v:SetIsOnType(false)
          end
        end
        ;
        (self._audioFrame):ReloadAllCell()
        if #self._audioData < 3 then
          local totallength = (self._audioFrame):GetTotalLength()
          local delta = totallength - self._oy
          ;
          (self._audioFramePanel):SetSize(self._x, self._ox, self._y, self._oy + delta)
          ;
          (self._audioFramePanel):SetPosition(self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y - delta / 2)
          ;
          (self._audioFrameBack):SetSize(self._rootX, self._rootOX, self._rooty, self._rootOY + delta)
          ;
          (self._audioFrameBack):SetPosition(self._pos_rootX, self._pos_rootOX, self._pos_rooty, self._pos_rootOY - delta)
          ;
          (self._audioFrame):ReloadAllCell()
        end
      end
    end
  end
end

SettingSoundTabCell.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._audioFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

SettingSoundTabCell.NumberOfCell = function(self, helper)
  -- function num : 0_4
  if helper == self._audioFrame then
    return #self._audioData
  else
    return #self._languageData
  end
end

SettingSoundTabCell.CellAtIndex = function(self, helper, index)
  -- function num : 0_5
  if helper == self._audioFrame then
    return "systemsetting.selectaudiocell"
  else
    return "systemsetting.selectlanguagecell"
  end
end

SettingSoundTabCell.DataAtIndex = function(self, helper, index)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if helper == self._audioFrame then
    ((self._audioData)[index]).index = index
    return (self._audioData)[index]
  else
    return (self._languageData)[index]
  end
end

SettingSoundTabCell.OpenAudioFrame = function(self)
  -- function num : 0_7
  self.bShowAudioFrame = true
  self:SetAudioUIShowState()
end

SettingSoundTabCell.HideAudioFrame = function(self)
  -- function num : 0_8
  self.bShowAudioFrame = false
  self:SetAudioUIShowState()
end

SettingSoundTabCell.OpenOrHideAudioFrame = function(self)
  -- function num : 0_9
  self.bShowAudioFrame = not self.bShowAudioFrame
  self:SetAudioUIShowState()
end

SettingSoundTabCell.SetAudioUIShowState = function(self)
  -- function num : 0_10
  (self._audioFrameBack):SetActive(self.bShowAudioFrame)
  ;
  (self._audioOpenIcon):SetActive(not self.bShowAudioFrame)
  ;
  (self._audioHideIcon):SetActive(self.bShowAudioFrame)
end

SettingSoundTabCell.OnSelectAudio = function(self, audioInfo)
  -- function num : 0_11 , upvalues : _ENV
  LogInfoFormat("SettingSoundTabCell ", " OnSelectAudio audio Name:%s resName:%s ", audioInfo.audioName, audioInfo.audioResName)
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

SettingSoundTabCell.ConfirmDownLoadAudio = function(self, resName)
  -- function num : 0_12 , upvalues : _ENV
  if (((((CS.PixelNeko).FileSystem).Update).UpdateManagerGame).CreateUpdateFSMGame)(resName) then
    self:InitAudioInfo()
    ;
    ((DialogManager.CreateSingletonDialog)("resupdatedialog")):SetResName(resName)
  else
    LogErrorFormat("SettingSoundTabCell", "CreateUpdateFSMGame fail, resName = %s", resName)
  end
end

SettingSoundTabCell.ChangeAudio = function(self)
  -- function num : 0_13 , upvalues : _ENV
  LogInfoFormat("SettingSoundTabCell", ": ChangeVoiceType %s ", self._selectAudioLangCode)
  ;
  (((CS.UnityEngine).PlayerPrefs).SetString)("VoiceLangCode", self._selectAudioLangCode)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_AudioLanguageChanged, nil)
  self:InitAudioInfo()
end

SettingSoundTabCell.OnGlobalPointerDown = function(self, args)
  -- function num : 0_14 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._audioFrameBack)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:HideAudioFrame()
  end
end

SettingSoundTabCell.OnNewOverlayFSMounted = function(self, args)
  -- function num : 0_15
  self:InitAudioInfo()
  if self._selectAudioLangCode and args.userInfo == "audio-" .. self._selectAudioLangCode then
    self:ChangeAudio()
  end
end

SettingSoundTabCell.OnMusicValueChanged = function(self, index)
  -- function num : 0_16 , upvalues : _ENV, SysConfigEnum, SoundLevelTable
  if ((self._musicToggleList)[index]):GetIsOnType() then
    local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.musicNum] then
      map.typeKey = SysConfigEnum.musicNum
      map.typeValue = index
      local record = SoundLevelTable:GetRecorder(1)
      local num = tonumber((record.soundLevel)[index])
      if not num or (table.nums)(record.soundLevel) < num then
        num = (table.nums)(record.soundLevel)
      end
      ;
      (LuaAudioManager.SetCategoryVolume)(tonumber(record.categoryID), tonumber(num))
    end
    do
      if map.typeKey and map.typeValue then
        ((NekoData.DataManager).DM_Game):SetSystemConfig({[map.typeKey] = map.typeValue})
        local cchangesysconfig = (LuaNetManager.CreateProtocol)("protocol.user.cchangesysconfig")
        -- DECOMPILER ERROR at PC76: Confused about usage of register: R5 in 'UnsetPending'

        if cchangesysconfig then
          (cchangesysconfig.configs)[map.typeKey] = map.typeValue
          cchangesysconfig:Send()
        end
      end
    end
  end
end

SettingSoundTabCell.OnSoundValueChanged = function(self, index)
  -- function num : 0_17 , upvalues : _ENV, SysConfigEnum, SoundLevelTable
  if ((self._soundToggleList)[index]):GetIsOnType() then
    local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.soundEffectNum] then
      map.typeKey = SysConfigEnum.soundEffectNum
      map.typeValue = index
      local record = SoundLevelTable:GetRecorder(2)
      local num = tonumber((record.soundLevel)[index])
      if not num or num < tonumber((record.soundLevel)[1]) or (table.nums)(record.soundLevel) < num then
        num = (table.nums)(record.soundLevel)
      end
      ;
      (LuaAudioManager.SetCategoryVolume)(tonumber(record.categoryID), tonumber(num))
    end
    do
      if map.typeKey and map.typeValue then
        ((NekoData.DataManager).DM_Game):SetSystemConfig({[map.typeKey] = map.typeValue})
        local cchangesysconfig = (LuaNetManager.CreateProtocol)("protocol.user.cchangesysconfig")
        -- DECOMPILER ERROR at PC82: Confused about usage of register: R5 in 'UnsetPending'

        if cchangesysconfig then
          (cchangesysconfig.configs)[map.typeKey] = map.typeValue
          cchangesysconfig:Send()
        end
      end
    end
  end
end

SettingSoundTabCell.OnVoiceValueChanged = function(self, index)
  -- function num : 0_18 , upvalues : _ENV, SysConfigEnum, SoundLevelTable
  if ((self._voiceToggleList)[index]):GetIsOnType() then
    local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.dubbingNum] then
      map.typeKey = SysConfigEnum.dubbingNum
      map.typeValue = index
      local record = SoundLevelTable:GetRecorder(3)
      local num = tonumber((record.soundLevel)[index])
      if not num or num < tonumber((record.soundLevel)[1]) or (table.nums)(record.soundLevel) < num then
        num = (table.nums)(record.soundLevel)
      end
      ;
      (LuaAudioManager.SetCategoryVolume)(tonumber(record.categoryID), tonumber(num))
    end
    do
      if map.typeKey and map.typeValue then
        ((NekoData.DataManager).DM_Game):SetSystemConfig({[map.typeKey] = map.typeValue})
        local cchangesysconfig = (LuaNetManager.CreateProtocol)("protocol.user.cchangesysconfig")
        -- DECOMPILER ERROR at PC82: Confused about usage of register: R5 in 'UnsetPending'

        if cchangesysconfig then
          (cchangesysconfig.configs)[map.typeKey] = map.typeValue
          cchangesysconfig:Send()
        end
      end
    end
  end
end

return SettingSoundTabCell

