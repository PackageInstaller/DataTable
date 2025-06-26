-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_voice.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Voice = class("BM_Voice")
local CSoundCatalog = (BeanManager.GetTableByName)("sound.csoundcatalog")
local CSoundCatalog_Skin = (BeanManager.GetTableByNameWithLanguage)("sound.csoundcatalog_skin")
local CSoundHandbook = (BeanManager.GetTableByName)("sound.csoundhandbook")
local CSoundHandbook_Skin = (BeanManager.GetTableByNameWithLanguage)("sound.csoundhandbook_skin")
local CSoundCDTable = (BeanManager.GetTableByName)("sound.csoundcd")
BM_Voice.VoiceType = {LevelUp = "LevelUp", LimitUp = "LimitUp", RareUp = "RareUp", Impression = "Impression", NormalGift = "NormalGift", FavoriteGift = "FavoriteGift", BodyTouch = "BodyTouch", Standby = "Standby", Formation = "Formation", Adventure = "Adventure", OpenBox = "OpenBox", ManaTree = "ManaTree", LifeHealing = "LifeHealing", BattleStart = "BattleStart", SkillID = "SkillID", SkillCV = "SkillCV", Attacked = "Attacked", Revive = "Revive", Victory = "Victory", Defeat = "Defeat", BattleKill = "BattleKill", YardTouch = "YardTouch", Dispatch = "Dispatch", Withdraw = "Withdraw", Summory = "Summory", Conversation = "Conversation", Emotion = "Emotion", Introduction = "Introduction", Login = "Login", PosterGirlWelcome = "PosterGirlWelcome", PosterGirlWelcomeNewYear = "PosterGirlWelcomeNewYear"}
BM_Voice.HandbookVoiceType = {relationVoice = "relationVoice", otherVoice = "otherVoice", Touchreactvoice = "Touchreactvoice"}
local battleAudioPlayCDCountTime = {}
BM_Voice.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._dm = (NekoData.DataManager).DM_Voice
end

local PlayFashionVoice = function(self, voiceTable, roleID, tableKey, index, isBattle)
  -- function num : 0_1 , upvalues : _ENV, CSoundCDTable, battleAudioPlayCDCountTime
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(roleID)
  if role == nil then
    return nil
  end
  local fashionID = role:GetDefaultFashion()
  if fashionID == nil or fashionID <= 0 then
    return nil
  end
  local record = voiceTable:GetRecorder(fashionID)
  if record == nil then
    return nil
  end
  local voiceValue = record[tableKey]
  do
    if type(voiceValue) == "table" then
      local voiceIDCount = #voiceValue
      if voiceIDCount == 0 then
        LogError("BM_Voice", "fashion id " .. roleID .. " " .. tableKey .. " index error")
        return nil
      end
      if index == nil or index < 0 then
        index = (math.random)(#voiceValue)
      end
      if #voiceValue < index then
        LogError("BM_Voice", "fashion id " .. roleID .. " " .. tableKey .. " has no voice id")
        return nil
      end
      voiceValue = voiceValue[index]
    end
    if isBattle ~= true then
      (LuaAudioManager.PlayVoice)(voiceValue)
      LogInfo("BM_Voice", " " .. tableKey .. " ")
      return voiceValue
    end
    local cSoundCDRecord = CSoundCDTable:GetRecorder(voiceValue)
    local cantPlayInAudioCD = false
    if voiceValue ~= 0 and cSoundCDRecord then
      if cSoundCDRecord.cd and cSoundCDRecord.cd ~= 0 then
        if battleAudioPlayCDCountTime[voiceValue] then
          local delta = (ServerGameTimer.GetServerTimeForecast)() - battleAudioPlayCDCountTime[voiceValue]
          if delta < cSoundCDRecord.cd * 1000 then
            cantPlayInAudioCD = true
          else
            battleAudioPlayCDCountTime[voiceValue] = (ServerGameTimer.GetServerTimeForecast)()
          end
        else
          do
            battleAudioPlayCDCountTime[voiceValue] = (ServerGameTimer.GetServerTimeForecast)()
            if not cantPlayInAudioCD then
              (LuaAudioManager.PlayVoice)(voiceValue)
              LogInfo("BM_Voice", " " .. tableKey .. " " .. voiceValue)
              return voiceValue
            end
          end
        end
      end
    end
  end
end

local PlayImpl = function(self, voiceTable, fashionVoiceTable, roleID, tableKey, index)
  -- function num : 0_2 , upvalues : _ENV, CSoundCatalog, PlayFashionVoice
  do
    if roleID == nil or roleID < 0 then
      local recordID = (math.random)(#CSoundCatalog:GetAllIds())
      roleID = recordID
    end
    local fashionVoiceID = PlayFashionVoice(self, fashionVoiceTable, roleID, tableKey, index)
    if fashionVoiceID ~= nil then
      return fashionVoiceID
    end
    local record = voiceTable:GetRecorder(roleID)
    if record == nil then
      return nil
    end
    local voiceValue = record[tableKey]
    do
      if type(voiceValue) == "table" then
        local voiceIDCount = #voiceValue
        if voiceIDCount == 0 then
          LogError("BM_Voice", "role id " .. roleID .. " " .. tableKey .. " index error")
          return nil
        end
        if index == nil or index < 0 then
          index = (math.random)(#voiceValue)
        end
        if #voiceValue < index then
          LogError("BM_Voice", "role id " .. roleID .. " " .. tableKey .. " has no voice id")
          return nil
        end
        voiceValue = voiceValue[index]
      end
      LogInfo("BM_Voice", " " .. tableKey .. " ")
      if (LuaAudioManager.PlayVoice)(voiceValue) then
        return voiceValue
      end
    end
  end
end

BM_Voice.PlayVoice = function(self, voiceID)
  -- function num : 0_3 , upvalues : _ENV
  (LuaAudioManager.PlayVoice)(voiceID)
end

BM_Voice.StopVoice = function(self, voiceID)
  -- function num : 0_4 , upvalues : _ENV
  (LuaAudioManager.StopVoice)(voiceID)
end

BM_Voice.Play = function(self, roleID, tableKey, index)
  -- function num : 0_5 , upvalues : PlayImpl, CSoundCatalog, CSoundCatalog_Skin
  return PlayImpl(self, CSoundCatalog, CSoundCatalog_Skin, roleID, tableKey, index)
end

BM_Voice.PlayHandBook = function(self, roleID, tableKey, index)
  -- function num : 0_6 , upvalues : PlayImpl, CSoundHandbook, CSoundHandbook_Skin
  return PlayImpl(self, CSoundHandbook, CSoundHandbook_Skin, roleID, tableKey, index)
end

BM_Voice.Play2 = function(self, roleID, fashionID, tableKey, index)
  -- function num : 0_7 , upvalues : CSoundCatalog_Skin, CSoundCatalog, _ENV
  if not roleID then
    roleID = -1
  end
  if not fashionID then
    fashionID = -1
  end
  local recordFashion = CSoundCatalog_Skin:GetRecorder(fashionID)
  local recordRole = CSoundCatalog:GetRecorder(roleID)
  local record = recordFashion or recordRole
  if record == nil then
    return nil
  end
  if tableKey == nil then
    LogError("BM_Voice", "The Play2() func arg tableKey is nil.")
    return nil
  end
  local voiceValue = record[tableKey]
  do
    if type(voiceValue) == "table" then
      local voiceIDCount = #voiceValue
      if voiceIDCount == 0 then
        LogError("BM_Voice", "The character id " .. record.id .. " " .. tableKey .. " index error.")
        return nil
      end
      if index == nil or index < 0 then
        index = (math.random)(#voiceValue)
      end
      if #voiceValue < index then
        LogError("BM_Voice", "The character id " .. record.id .. " " .. tableKey .. " has no voice id.")
        return nil
      end
      voiceValue = voiceValue[index]
    end
    LogInfo("BM_Voice", "Play voice " .. tableKey .. " index " .. (index or ""))
    if (LuaAudioManager.PlayVoice)(voiceValue) then
      return voiceValue
    else
      return 0
    end
  end
end

BM_Voice.PlayBattleVoice = function(self, characterID, tableKey, index)
  -- function num : 0_8 , upvalues : _ENV, CSoundCatalog, PlayFashionVoice, CSoundCatalog_Skin, CSoundCDTable, battleAudioPlayCDCountTime
  do
    if characterID == nil or characterID < 0 then
      local recordID = (math.random)(#CSoundCatalog:GetAllIds())
      characterID = recordID
    end
    local fashionVoiceID = PlayFashionVoice(self, CSoundCatalog_Skin, characterID, tableKey, index)
    if fashionVoiceID ~= nil then
      return fashionVoiceID
    end
    local record = CSoundCatalog:GetRecorder(characterID)
    if record == nil then
      return nil
    end
    local voiceValue = record[tableKey]
    do
      if type(voiceValue) == "table" then
        local voiceIDCount = #voiceValue
        if voiceIDCount == 0 then
          LogError("BM_Voice", "character id " .. characterID .. " " .. tableKey .. " index error")
          return nil
        end
        if index == nil or index < 0 then
          index = (math.random)(#voiceValue)
        end
        if #voiceValue < index then
          LogError("BM_Voice", "character id " .. characterID .. " " .. tableKey .. " has no voice id")
          return nil
        end
        voiceValue = voiceValue[index]
      end
      local cSoundCDRecord = CSoundCDTable:GetRecorder(voiceValue)
      local cantPlayInAudioCD = false
      if voiceValue ~= 0 and cSoundCDRecord then
        if cSoundCDRecord.cd and cSoundCDRecord.cd ~= 0 then
          if battleAudioPlayCDCountTime[voiceValue] then
            local delta = (ServerGameTimer.GetServerTimeForecast)() - battleAudioPlayCDCountTime[voiceValue]
            if delta < cSoundCDRecord.cd * 1000 then
              cantPlayInAudioCD = true
            else
              battleAudioPlayCDCountTime[voiceValue] = (ServerGameTimer.GetServerTimeForecast)()
            end
          else
            do
              battleAudioPlayCDCountTime[voiceValue] = (ServerGameTimer.GetServerTimeForecast)()
              if not cantPlayInAudioCD then
                (LuaAudioManager.PlayVoice)(voiceValue)
                LogInfo("BM_Voice", " " .. tableKey .. " " .. voiceValue)
                return voiceValue
              end
            end
          end
        end
      end
    end
  end
end

return BM_Voice

