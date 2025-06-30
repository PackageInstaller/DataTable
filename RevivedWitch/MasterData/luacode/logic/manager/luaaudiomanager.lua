-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/luaaudiomanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AudioManager = ((CS.PixelNeko).Audio).AudioManager
local CSoundSourceTable = (BeanManager.GetTableByName)("sound.csoundsource")
local CWalkAnimationTable = (BeanManager.GetTableByName)("sound.cwalkanimation")
local CGroundTypeTable = (BeanManager.GetTableByName)("sound.cgroundtype")
local LuaAudioManager = {}
local _VoiceResourceTable, _langCode, _langPostfix = nil, nil, nil
local SetVoiceTable = function()
  -- function num : 0_0 , upvalues : _langCode, _ENV, _langPostfix, _VoiceResourceTable
  _langCode = (((CS.UnityEngine).PlayerPrefs).GetString)("VoiceLangCode", "")
  local resValidState = (LuaUpdateManager.GetResValidState)()
  -- DECOMPILER ERROR at PC35: Unhandled construct in 'MakeBoolean' P1

  if (_langCode == "" or resValidState["audio-" .. _langCode] == nil or not resValidState["audio-" .. _langCode]) and (LuaUpdateManager.UseEditorRes)() and _langCode == "" then
    _langCode = "ja_JP"
    ;
    (((CS.UnityEngine).PlayerPrefs).SetString)("VoiceLangCode", _langCode)
  end
  _langCode = "none"
  if resValidState["audio-ja_JP"] ~= nil and resValidState["audio-ja_JP"] then
    _langCode = "ja_JP"
  else
    if resValidState["audio-zh_Hans"] ~= nil and resValidState["audio-zh_Hans"] then
      _langCode = "zh_Hans"
    end
  end
  ;
  (((CS.UnityEngine).PlayerPrefs).SetString)("VoiceLangCode", _langCode)
  _langPostfix = "_" .. (string.lower)(_langCode)
  local tableName = "sound.cvoicesource" .. _langPostfix
  _VoiceResourceTable = (BeanManager.GetTableByName)(tableName)
end

LuaAudioManager.Init = function()
  -- function num : 0_1 , upvalues : SetVoiceTable, _ENV, LuaAudioManager
  SetVoiceTable()
  ;
  (LuaNotificationCenter.AddObserver)(LuaAudioManager, SetVoiceTable, Common.n_AudioLanguageChanged, nil)
end

LuaAudioManager.GetCurrentVoiceResName = function()
  -- function num : 0_2 , upvalues : _langCode
  return "audio-" .. _langCode
end

LuaAudioManager.PlayBGM = function(id, isreplay)
  -- function num : 0_3 , upvalues : CSoundSourceTable, _ENV, AudioManager
  if id ~= 0 then
    local record = CSoundSourceTable:GetRecorder(id)
    if record then
      if record.cueSheet == "" or record.cueName == "" then
        LogErrorFormat("LuaAudioManager", "PlayBGM csoundsource id %s cueSheet [%s] cueName [%s]", id, record.cueSheet, record.cueName)
      end
      if isreplay then
        (AudioManager.PlayBGM)(record.cueSheet, record.cueName, record.volume / 100, isreplay)
      else
        ;
        (AudioManager.PlayBGM)(record.cueSheet, record.cueName, record.volume / 100)
      end
    else
      LogErrorFormat("LuaAudioManager", "audio id %s doesnt exist", id)
    end
  end
end

local pause_bgm = function(id, sw)
  -- function num : 0_4 , upvalues : CSoundSourceTable, AudioManager
  local record = CSoundSourceTable:GetRecorder(id)
  if record then
    (AudioManager.PauseBGM)(record.cueSheet, record.cueName, sw)
  end
end

LuaAudioManager.PauseBGM = function(id)
  -- function num : 0_5 , upvalues : _ENV, pause_bgm
  LogInfoFormat("LuaAudioManager", "PauseBGM id-%s success", id)
  pause_bgm(id, true, "")
end

LuaAudioManager.ResumeBGM = function(id)
  -- function num : 0_6 , upvalues : _ENV, pause_bgm
  LogInfoFormat("LuaAudioManager", "ResumeBGM id-%s success", id)
  pause_bgm(id, false, "")
end

LuaAudioManager.StopBGM = function(id)
  -- function num : 0_7 , upvalues : CSoundSourceTable, AudioManager, _ENV
  local record = CSoundSourceTable:GetRecorder(id)
  if record then
    (AudioManager.StopBGM)(record.cueSheet, record.cueName)
    LogInfoFormat("LuaAudioManager", "StopBGM id-%s success", id)
  end
end

LuaAudioManager.PlayVoice = function(id, isReplay)
  -- function num : 0_8 , upvalues : _VoiceResourceTable, _ENV, AudioManager
  do
    if id ~= 0 then
      local record = _VoiceResourceTable:GetRecorder(id)
      if record then
        if record.cueSheet == "" or record.cueName == "" then
          LogErrorFormat("LuaAudioManager", "PlayVoice _VoiceResourceTable id %s cueSheet [%s] cueName [%s]", id, record.cueSheet, record.cueName)
          return false
        end
        if isReplay then
          (AudioManager.PlayBGM)(record.cueSheet, record.cueName, record.volume / 100, isReplay)
        else
          ;
          (AudioManager.PlayBGM)(record.cueSheet, record.cueName, record.volume / 100)
        end
      else
        LogErrorFormat("LuaAudioManager", "voice id %s doesnt exist", id)
        return false
      end
      return true
    end
    return false
  end
end

LuaAudioManager.StopVoice = function(id)
  -- function num : 0_9 , upvalues : _VoiceResourceTable, AudioManager, _ENV
  local record = _VoiceResourceTable:GetRecorder(id)
  if record then
    (AudioManager.StopBGM)(record.cueSheet, record.cueName)
    LogInfoFormat("LuaAudioManager", "Stop voice id-%s success", id)
  end
end

LuaAudioManager.ResumeVoice = function(id)
  -- function num : 0_10 , upvalues : _ENV, pause_bgm
  LogInfoFormat("LuaAudioManager", "Resume voice id-%s success", id)
  pause_bgm(id, false)
end

LuaAudioManager.GetCueSheetAndCueNameWithVoiceID = function(voiceID)
  -- function num : 0_11 , upvalues : _VoiceResourceTable
  local record = _VoiceResourceTable:GetRecorder(voiceID)
  if record then
    return record.cueSheet, record.cueName
  end
end

LuaAudioManager.SetLuaAudioTable = function()
  -- function num : 0_12 , upvalues : CSoundSourceTable, _ENV, _VoiceResourceTable, AudioManager
  local allIds = CSoundSourceTable:GetAllIds()
  local audioTable = {}
  local volumes = {}
  for _,id in ipairs(allIds) do
    if not audioTable[id] then
      audioTable[id] = {}
      do
        local record = CSoundSourceTable:GetRecorder(id)
        -- DECOMPILER ERROR at PC21: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (audioTable[id])[record.cueSheet] = record.cueName
        volumes[id] = record.volume / 100
        -- DECOMPILER ERROR at PC25: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC25: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  allIds = _VoiceResourceTable:GetAllIds()
  for _,id in ipairs(allIds) do
    if not audioTable[id] then
      audioTable[id] = {}
      do
        local record = _VoiceResourceTable:GetRecorder(id)
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (audioTable[id])[record.cueSheet] = record.cueName
        volumes[id] = record.volume / 100
        -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  ;
  (AudioManager.SetLuaAudioTable)(audioTable, volumes)
end

LuaAudioManager.SetCategoryVolume = function(category, value)
  -- function num : 0_13 , upvalues : AudioManager
  (AudioManager.SetCategoryVolume)(category, value)
end

LuaAudioManager.SetGroundMaterialList = function()
  -- function num : 0_14 , upvalues : _ENV, CGroundTypeTable, AudioManager
  local temp = {}
  for _,id in ipairs(CGroundTypeTable:GetAllIds()) do
    local record = CGroundTypeTable:GetRecorder(id)
    temp[record.groundType] = record.selector
  end
  ;
  (AudioManager.SetGroundMaterialList)(temp)
end

LuaAudioManager.SetWalkAnimationClipNameList = function()
  -- function num : 0_15 , upvalues : _ENV, CWalkAnimationTable, AudioManager
  local temp = {}
  for _,id in ipairs(CWalkAnimationTable:GetAllIds()) do
    local record = CWalkAnimationTable:GetRecorder(id)
    ;
    (table.insert)(temp, record.animName)
  end
  ;
  (AudioManager.SetWalkAnimationClipNameList)(temp)
end

LuaAudioManager.GetAudioMaxLastTime = function(audioId)
  -- function num : 0_16 , upvalues : AudioManager
  return (AudioManager.GetAudioMaxLastTime)(audioId)
end

LuaAudioManager.GetCueSheetAndCueNameWithAudioId = function(audioId)
  -- function num : 0_17 , upvalues : CSoundSourceTable
  local record = CSoundSourceTable:GetRecorder(audioId)
  return record.cueSheet, record.cueName
end

LuaAudioManager.IsAudioPlaying = function(audioId)
  -- function num : 0_18 , upvalues : AudioManager
  return (AudioManager.IsAudioPlaying)(audioId)
end

LuaAudioManager.PauseCategory = function(category, pause)
  -- function num : 0_19 , upvalues : AudioManager
  (AudioManager.PauseCategory)(category, pause)
end

LuaAudioManager.IfAudioIsVoice = function(id)
  -- function num : 0_20 , upvalues : _VoiceResourceTable
  local record = _VoiceResourceTable:GetRecorder(id)
  if record then
    return true
  end
end

local CuePlayEndCallBackFunc = function(cueSheet, cueName)
  -- function num : 0_21 , upvalues : _ENV, LuaAudioManager
  (LuaNotificationCenter.PostNotification)(Common.n_CuePlayEnd, LuaAudioManager, {cueSheet = cueSheet, cueName = cueName})
end

local CuePlayStopCallBackFunc = function(cueSheet, cueName)
  -- function num : 0_22 , upvalues : _ENV, LuaAudioManager
  (LuaNotificationCenter.PostNotification)(Common.n_CuePlayStop, LuaAudioManager, {cueSheet = cueSheet, cueName = cueName})
end

;
(AudioManager.SetCuePlayEndCallBackFunc)(CuePlayEndCallBackFunc)
;
(AudioManager.SetCuePlayStopCallBackFunc)(CuePlayStopCallBackFunc)
return LuaAudioManager

