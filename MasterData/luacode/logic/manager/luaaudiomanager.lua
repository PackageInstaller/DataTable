local AudioManager = CS.PixelNeko.Audio.AudioManager
local CSoundSourceTable = BeanManager.GetTableByName("sound.csoundsource")
local CWalkAnimationTable = BeanManager.GetTableByName("sound.cwalkanimation")
local CGroundTypeTable = BeanManager.GetTableByName("sound.cgroundtype")
local LuaAudioManager = {}
local _VoiceResourceTable, _langCode, _langPostfix

local function SetVoiceTable()
  _langCode = CS.UnityEngine.PlayerPrefs.GetString("VoiceLangCode", "")
  local resValidState = LuaUpdateManager.GetResValidState()
  if _langCode == "" or resValidState["audio-" .. _langCode] == nil or not resValidState["audio-" .. _langCode] then
    if LuaUpdateManager.UseEditorRes() then
      if _langCode == "" then
        _langCode = "ja_JP"
        CS.UnityEngine.PlayerPrefs.SetString("VoiceLangCode", _langCode)
      end
    else
      _langCode = "none"
      if resValidState["audio-ja_JP"] ~= nil and resValidState["audio-ja_JP"] then
        _langCode = "ja_JP"
      elseif resValidState["audio-zh_Hans"] ~= nil and resValidState["audio-zh_Hans"] then
        _langCode = "zh_Hans"
      end
      CS.UnityEngine.PlayerPrefs.SetString("VoiceLangCode", _langCode)
    end
  end
  _langPostfix = "_" .. string.lower(_langCode)
  local tableName = "sound.cvoicesource" .. _langPostfix
  _VoiceResourceTable = BeanManager.GetTableByName(tableName)
end

function LuaAudioManager.Init()
  SetVoiceTable()
  LuaNotificationCenter.AddObserver(LuaAudioManager, SetVoiceTable, Common.n_AudioLanguageChanged, nil)
end

function LuaAudioManager.GetCurrentVoiceResName()
  return "audio-" .. _langCode
end

function LuaAudioManager.IsDownloaded()
  if LuaUpdateManager.UseEditorRes() then
    return true
  end
  local resState = LuaUpdateManager.GetResValidState()
  if resState["audio-ja_JP"] ~= nil and resState["audio-ja_JP"] == true then
    return true
  elseif resState["audio-zh_Hans"] ~= nil and resState["audio-zh_Hans"] == true then
    return true
  else
    return false
  end
end

function LuaAudioManager.PlayBGM(id, isreplay)
  if id ~= 0 then
    local record = CSoundSourceTable:GetRecorder(id)
    if record then
      if record.cueSheet == "" or record.cueName == "" then
        LogErrorFormat("LuaAudioManager", "PlayBGM csoundsource id %s cueSheet [%s] cueName [%s]", id, record.cueSheet, record.cueName)
      end
      if isreplay then
        AudioManager.PlayBGM(record.cueSheet, record.cueName, record.volume / 100, isreplay)
      else
        AudioManager.PlayBGM(record.cueSheet, record.cueName, record.volume / 100)
      end
    else
      LogErrorFormat("LuaAudioManager", "audio id %s doesnt exist", id)
    end
  end
end

local function pause_bgm(id, sw)
  local record = CSoundSourceTable:GetRecorder(id)
  if record then
    AudioManager.PauseBGM(record.cueSheet, record.cueName, sw)
  end
end

function LuaAudioManager.PauseBGM(id)
  LogInfoFormat("LuaAudioManager", "PauseBGM id-%s success", id)
  pause_bgm(id, true, "")
end

function LuaAudioManager.ResumeBGM(id)
  LogInfoFormat("LuaAudioManager", "ResumeBGM id-%s success", id)
  pause_bgm(id, false, "")
end

function LuaAudioManager.StopBGM(id)
  local record = CSoundSourceTable:GetRecorder(id)
  if record then
    AudioManager.StopBGM(record.cueSheet, record.cueName)
    LogInfoFormat("LuaAudioManager", "StopBGM id-%s success", id)
  end
end

function LuaAudioManager.PlayVoice(id, isReplay)
  if id ~= 0 then
    local record = _VoiceResourceTable:GetRecorder(id)
    if record then
      if record.cueSheet == "" or record.cueName == "" then
        LogErrorFormat("LuaAudioManager", "PlayVoice _VoiceResourceTable id %s cueSheet [%s] cueName [%s]", id, record.cueSheet, record.cueName)
        return false
      end
      if isReplay then
        AudioManager.PlayBGM(record.cueSheet, record.cueName, record.volume / 100, isReplay)
      else
        AudioManager.PlayBGM(record.cueSheet, record.cueName, record.volume / 100)
      end
    else
      LogErrorFormat("LuaAudioManager", "voice id %s doesnt exist", id)
      return false
    end
    return true
  end
  return false
end

function LuaAudioManager.StopVoice(id)
  local record = _VoiceResourceTable:GetRecorder(id)
  if record then
    AudioManager.StopBGM(record.cueSheet, record.cueName)
    LogInfoFormat("LuaAudioManager", "Stop voice id-%s success", id)
  end
end

function LuaAudioManager.ResumeVoice(id)
  LogInfoFormat("LuaAudioManager", "Resume voice id-%s success", id)
  pause_bgm(id, false)
end

function LuaAudioManager.GetCueSheetAndCueNameWithVoiceID(voiceID)
  local record = _VoiceResourceTable:GetRecorder(voiceID)
  if record then
    return record.cueSheet, record.cueName
  end
end

function LuaAudioManager.SetLuaAudioTable()
  local allIds = CSoundSourceTable:GetAllIds()
  local audioTable = {}
  local volumes = {}
  for _, id in ipairs(allIds) do
    audioTable[id] = audioTable[id] or {}
    local record = CSoundSourceTable:GetRecorder(id)
    audioTable[id][record.cueSheet] = record.cueName
    volumes[id] = record.volume / 100
  end
  allIds = _VoiceResourceTable:GetAllIds()
  for _, id in ipairs(allIds) do
    audioTable[id] = audioTable[id] or {}
    local record = _VoiceResourceTable:GetRecorder(id)
    audioTable[id][record.cueSheet] = record.cueName
    volumes[id] = record.volume / 100
  end
  AudioManager.SetLuaAudioTable(audioTable, volumes)
end

function LuaAudioManager.SetCategoryVolume(category, value)
  AudioManager.SetCategoryVolume(category, value)
end

function LuaAudioManager.SetGroundMaterialList()
  local temp = {}
  for _, id in ipairs(CGroundTypeTable:GetAllIds()) do
    local record = CGroundTypeTable:GetRecorder(id)
    temp[record.groundType] = record.selector
  end
  AudioManager.SetGroundMaterialList(temp)
end

function LuaAudioManager.SetWalkAnimationClipNameList()
  local temp = {}
  for _, id in ipairs(CWalkAnimationTable:GetAllIds()) do
    local record = CWalkAnimationTable:GetRecorder(id)
    table.insert(temp, record.animName)
  end
  AudioManager.SetWalkAnimationClipNameList(temp)
end

function LuaAudioManager.GetAudioMaxLastTime(audioId)
  return AudioManager.GetAudioMaxLastTime(audioId)
end

function LuaAudioManager.GetCueSheetAndCueNameWithAudioId(audioId)
  local record = CSoundSourceTable:GetRecorder(audioId)
  return record.cueSheet, record.cueName
end

function LuaAudioManager.IsAudioPlaying(audioId)
  return AudioManager.IsAudioPlaying(audioId)
end

function LuaAudioManager.PauseCategory(category, pause)
  AudioManager.PauseCategory(category, pause)
end

function LuaAudioManager.IfAudioIsVoice(id)
  local record = _VoiceResourceTable:GetRecorder(id)
  if record then
    return true
  end
end

local function CuePlayEndCallBackFunc(cueSheet, cueName)
  LuaNotificationCenter.PostNotification(Common.n_CuePlayEnd, LuaAudioManager, {cueSheet = cueSheet, cueName = cueName})
end

local function CuePlayStopCallBackFunc(cueSheet, cueName)
  LuaNotificationCenter.PostNotification(Common.n_CuePlayStop, LuaAudioManager, {cueSheet = cueSheet, cueName = cueName})
end

AudioManager.SetCuePlayEndCallBackFunc(CuePlayEndCallBackFunc)
AudioManager.SetCuePlayStopCallBackFunc(CuePlayStopCallBackFunc)
return LuaAudioManager
