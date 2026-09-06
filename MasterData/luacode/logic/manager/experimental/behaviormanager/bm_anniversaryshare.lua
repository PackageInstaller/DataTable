local SAnniversaryShareInfoDef = LuaNetManager.GetProtocolDef("protocol.activity.sanniversaryshareinfo")
local CCumulativeSharingExtraAward = BeanManager.GetTableByName("welfare.ccumulativesharingextraaward")
local CAllShareCfg = BeanManager.GetTableByName("activity.callsharecfg")
local CShareReward = BeanManager.GetTableByName("sharesystem.csharereward")
if SdkManager.GetChannel() == "leit" and SdkManager.GetAgent():IsChannelPackage() then
  CCumulativeSharingExtraAward = BeanManager.GetTableByName("welfare.ccumulativesharingextraawardqd")
end
local BM_AnniversaryShare = class("BM_AnniversaryShare")

function BM_AnniversaryShare:Ctor()
  self._data = NekoData.Data.anniversaryshare
end

function BM_AnniversaryShare:GetLeftTime()
  return self._data.leftTime - (ServerGameTimer.GetServerTimeForecast() - self._data.initialTime)
end

function BM_AnniversaryShare:GetShareLeftTime()
  return self._data.shareLeftTime - (ServerGameTimer.GetServerTimeForecast() - self._data.initialTime)
end

function BM_AnniversaryShare:GetIsOpen()
  return self:GetLeftTime() > 0
end

function BM_AnniversaryShare:GetShareIsOpen()
  return self:GetShareLeftTime() > 0
end

function BM_AnniversaryShare:GetPictureID()
  local record = CAllShareCfg:GetRecorder(self._data.pictureID)
  if record then
    return record.imgid
  else
    return 0
  end
end

function BM_AnniversaryShare:GetTotalShare()
  return self._data.totalShare
end

function BM_AnniversaryShare:GetTotShareAward()
  return self._data.totShareAward
end

function BM_AnniversaryShare:GetDailyShareAward()
  return self._data.dailyShareAward
end

function BM_AnniversaryShare:GetHaveRedDot()
  if not self:GetIsOpen() then
    return false
  end
  return self:GetShareIsOpen() and self:GetDailyShareAward() == SAnniversaryShareInfoDef.UNLOCKED or next(self._data.totShareAwardCanGet)
end

function BM_AnniversaryShare:GetNeedProgress(theID)
  local recorderPre = CCumulativeSharingExtraAward:GetRecorder(theID - 1)
  local recorder = CCumulativeSharingExtraAward:GetRecorder(theID)
  if recorderPre then
    local var1 = self._data.totalShare - recorderPre.needNum
    local var2 = self._data.totalShare - recorder.needNum
    if var1 <= 0 then
      return 0
    elseif var2 <= 0 then
      return (self._data.totalShare - recorderPre.needNum) / (recorder.needNum - recorderPre.needNum)
    else
      return 1
    end
  elseif recorder then
    return self._data.totalShare / recorder.needNum
  else
    LogError("BM_AnniversaryShare:GetNeedProgress", "The " .. tostring(theID) .. " not exist!")
    return 0
  end
end

function BM_AnniversaryShare:GetImgToTextID()
  local record = CAllShareCfg:GetRecorder(self._data.pictureID)
  if record then
    return record.wordid
  else
    return 0
  end
end

function BM_AnniversaryShare:SendCQueryAnniversaryShareInfo()
  if not self:GetIsOpen() then
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cqueryanniversaryshareinfo")
  if protocol then
    protocol:Send()
  end
end

function BM_AnniversaryShare:SendCAnniversaryShare()
  if not self:GetIsOpen() then
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.canniversaryshare")
  if protocol then
    protocol:Send()
  end
end

function BM_AnniversaryShare:SendCFetchShareAward(awardId)
  if not self:GetIsOpen() then
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cfetchshareaward")
  if protocol then
    protocol.awardId = awardId
    protocol:Send()
  end
end

function BM_AnniversaryShare:GetCShareReward()
  local recorder = CShareReward:GetRecorder(6)
  return recorder.itemID[1], recorder.itemNum[1]
end

function BM_AnniversaryShare:GetCAllShareCfg()
  return CAllShareCfg
end

function BM_AnniversaryShare:GetCCumulativeSharingExtraAward()
  return CCumulativeSharingExtraAward
end

function BM_AnniversaryShare:GetSAnniversaryShareInfoDef()
  return SAnniversaryShareInfoDef
end

return BM_AnniversaryShare
