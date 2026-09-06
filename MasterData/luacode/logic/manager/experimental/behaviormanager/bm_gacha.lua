local CVarCfg = BeanManager.GetTableByName("var.cvarconfig")
local tenDrawGuideTotalTimes = tonumber(CVarCfg:GetRecorder(45).Value)
local CDrawSystemShare = BeanManager.GetTableByName("sharesystem.cdrawsystemshare")
local BM_Gacha = class("BM_Gacha")

function BM_Gacha:Ctor()
  self._gacha = NekoData.Data.gacha
end

function BM_Gacha:GetGachaPools()
  local list = {}
  for i, v in ipairs(self._gacha.pools) do
    local pool = {}
    pool.id = v.id
    pool.value = v.value
    table.insert(list, pool)
  end
  return list
end

function BM_Gacha:ClearConvertItems()
  self._gacha.convertItems = {}
end

function BM_Gacha:GetConvertItems()
  return self._gacha.convertItems
end

function BM_Gacha:GetDrawTimes()
  return self._gacha.drawTimes
end

function BM_Gacha:GetCurrentDayDrawTimes()
  return self._gacha.curDayTimes
end

function BM_Gacha:GetDrawTotalTimes()
  return tenDrawGuideTotalTimes
end

function BM_Gacha:GetBaoDiNum()
  return self._gacha.baodiNum
end

function BM_Gacha:GetShareState()
  return self._gacha.shareState
end

function BM_Gacha:RequestShareAward()
  LuaNetManager.CreateProtocol("protocol.card.csharedrawcard"):Send()
  self._gacha.shareState = 0
end

function BM_Gacha:GetShareQRCodeID()
  local channel = SdkManager.GetChannel()
  if channel == "none" then
    return CDrawSystemShare:GetRecorder(110001).pictureID
  elseif channel == "leit" then
    local channelid = tonumber(SdkManager.GetChannelID())
    if channelid then
      return CDrawSystemShare:GetRecorder(channelid).pictureID
    elseif SdkManager.GetPlatform() == "iOS" then
      return CDrawSystemShare:GetRecorder(210009).pictureID
    else
      return CDrawSystemShare:GetRecorder(110001).pictureID
    end
  elseif channel == "yost" then
    local channelName = SdkManager.GetChannelName()
    if channelName == "en" then
      return CDrawSystemShare:GetRecorder(201).pictureID
    elseif channelName == "kr" then
      return CDrawSystemShare:GetRecorder(202).pictureID
    elseif channelName == "jp" then
      return CDrawSystemShare:GetRecorder(203).pictureID
    end
  elseif channel == "qian" then
    return CDrawSystemShare:GetRecorder(110001).pictureID
  elseif channel == "mqan" then
    return CDrawSystemShare:GetRecorder(110001).pictureID
  elseif channel == "quka" or channel == "qukb" then
    return CDrawSystemShare:GetRecorder(110001).pictureID
  end
  return -1
end

function BM_Gacha:GetShareTextID()
  local channel = SdkManager.GetChannel()
  if channel == "none" then
    return CDrawSystemShare:GetRecorder(110001).textID
  elseif channel == "leit" then
    local channelid = tonumber(SdkManager.GetChannelID())
    if channelid then
      return CDrawSystemShare:GetRecorder(channelid).textID
    elseif SdkManager.GetPlatform() == "iOS" then
      return CDrawSystemShare:GetRecorder(210009).textID
    else
      return CDrawSystemShare:GetRecorder(110001).textID
    end
  elseif channel == "yost" then
    local channelName = SdkManager.GetChannelName()
    if channelName == "en" then
      return CDrawSystemShare:GetRecorder(201).textID
    elseif channelName == "kr" then
      return CDrawSystemShare:GetRecorder(202).textID
    elseif channelName == "jp" then
      return CDrawSystemShare:GetRecorder(203).textID
    end
  elseif channel == "qian" then
    return CDrawSystemShare:GetRecorder(110001).textID
  elseif channel == "mqan" then
    return CDrawSystemShare:GetRecorder(110001).textID
  elseif channel == "quka" or channel == "qukb" then
    return CDrawSystemShare:GetRecorder(110001).textID
  end
  return -1
end

function BM_Gacha:IsCanShare()
  if channel == "none" then
    return true
  else
    if SdkManager.GetPlatform() == "iOS" then
      return true
    end
    local channelID = tonumber(SdkManager.GetChannelID())
    local recorder = BeanManager.GetTableByName("sharesystem.csharereward"):GetRecorder(1)
    local tab = string.split(recorder.onChannelId, ";")
    if recorder.onChannelId == "" then
      return true
    end
    for k, v in pairs(tab) do
      if channelID == tonumber(v) then
        return true
      end
    end
  end
  return false
end

return BM_Gacha
