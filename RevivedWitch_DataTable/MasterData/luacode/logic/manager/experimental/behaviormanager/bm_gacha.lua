-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_gacha.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CVarCfg = (BeanManager.GetTableByName)("var.cvarconfig")
local tenDrawGuideTotalTimes = tonumber((CVarCfg:GetRecorder(45)).Value)
local CDrawSystemShare = (BeanManager.GetTableByName)("sharesystem.cdrawsystemshare")
local BM_Gacha = class("BM_Gacha")
BM_Gacha.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._gacha = (NekoData.Data).gacha
end

BM_Gacha.GetGachaPools = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local list = {}
  for i,v in ipairs((self._gacha).pools) do
    local pool = {}
    pool.id = v.id
    pool.value = v.value
    ;
    (table.insert)(list, pool)
  end
  return list
end

BM_Gacha.ClearConvertItems = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._gacha).convertItems = {}
end

BM_Gacha.GetConvertItems = function(self)
  -- function num : 0_3
  return (self._gacha).convertItems
end

BM_Gacha.GetDrawTimes = function(self)
  -- function num : 0_4
  return (self._gacha).drawTimes
end

BM_Gacha.GetCurrentDayDrawTimes = function(self)
  -- function num : 0_5
  return (self._gacha).curDayTimes
end

BM_Gacha.GetDrawTotalTimes = function(self)
  -- function num : 0_6 , upvalues : tenDrawGuideTotalTimes
  return tenDrawGuideTotalTimes
end

BM_Gacha.GetBaoDiNum = function(self)
  -- function num : 0_7
  return (self._gacha).baodiNum
end

BM_Gacha.GetShareState = function(self)
  -- function num : 0_8
  return (self._gacha).shareState
end

BM_Gacha.RequestShareAward = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ((LuaNetManager.CreateProtocol)("protocol.card.csharedrawcard")):Send()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gacha).shareState = 0
end

BM_Gacha.GetShareQRCodeID = function(self)
  -- function num : 0_10 , upvalues : _ENV, CDrawSystemShare
  local channel = (SdkManager.GetChannel)()
  if channel == "none" then
    return (CDrawSystemShare:GetRecorder(110001)).pictureID
  else
    if channel == "leit" then
      local channelid = tonumber((SdkManager.GetChannelID)())
      if channelid then
        return (CDrawSystemShare:GetRecorder(channelid)).pictureID
      else
        if (SdkManager.GetPlatform)() == "iOS" then
          return (CDrawSystemShare:GetRecorder(210009)).pictureID
        else
          return (CDrawSystemShare:GetRecorder(110001)).pictureID
        end
      end
    else
      do
        if channel == "yost" then
          local channelName = (SdkManager.GetChannelName)()
          if channelName == "en" then
            return (CDrawSystemShare:GetRecorder(201)).pictureID
          else
            if channelName == "kr" then
              return (CDrawSystemShare:GetRecorder(202)).pictureID
            else
              if channelName == "jp" then
                return (CDrawSystemShare:GetRecorder(203)).pictureID
              end
            end
          end
        else
          do
            if channel == "qian" then
              return (CDrawSystemShare:GetRecorder(110001)).pictureID
            else
              if channel == "mqan" then
                return (CDrawSystemShare:GetRecorder(110001)).pictureID
              end
            end
            return -1
          end
        end
      end
    end
  end
end

BM_Gacha.GetShareTextID = function(self)
  -- function num : 0_11 , upvalues : _ENV, CDrawSystemShare
  local channel = (SdkManager.GetChannel)()
  if channel == "none" then
    return (CDrawSystemShare:GetRecorder(110001)).textID
  else
    if channel == "leit" then
      local channelid = tonumber((SdkManager.GetChannelID)())
      if channelid then
        return (CDrawSystemShare:GetRecorder(channelid)).textID
      else
        if (SdkManager.GetPlatform)() == "iOS" then
          return (CDrawSystemShare:GetRecorder(210009)).textID
        else
          return (CDrawSystemShare:GetRecorder(110001)).textID
        end
      end
    else
      do
        if channel == "yost" then
          local channelName = (SdkManager.GetChannelName)()
          if channelName == "en" then
            return (CDrawSystemShare:GetRecorder(201)).textID
          else
            if channelName == "kr" then
              return (CDrawSystemShare:GetRecorder(202)).textID
            else
              if channelName == "jp" then
                return (CDrawSystemShare:GetRecorder(203)).textID
              end
            end
          end
        else
          do
            if channel == "qian" then
              return (CDrawSystemShare:GetRecorder(110001)).textID
            else
              if channel == "mqan" then
                return (CDrawSystemShare:GetRecorder(110001)).textID
              end
            end
            return -1
          end
        end
      end
    end
  end
end

BM_Gacha.IsCanShare = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if channel == "none" then
    return true
  else
    if (SdkManager.GetPlatform)() == "iOS" then
      return true
    end
    local channelID = tonumber((SdkManager.GetChannelID)())
    local recorder = ((BeanManager.GetTableByName)("sharesystem.csharereward")):GetRecorder(1)
    local tab = (string.split)(recorder.onChannelId, ";")
    if recorder.onChannelId == "" then
      return true
    end
    for k,v in pairs(tab) do
      if channelID == tonumber(v) then
        return true
      end
    end
  end
  do
    return false
  end
end

return BM_Gacha

