-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_anniversaryshare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SAnniversaryShareInfoDef = (LuaNetManager.GetProtocolDef)("protocol.activity.sanniversaryshareinfo")
local CCumulativeSharingExtraAward = (BeanManager.GetTableByName)("welfare.ccumulativesharingextraaward")
local CAllShareCfg = (BeanManager.GetTableByName)("activity.callsharecfg")
local CShareReward = (BeanManager.GetTableByName)("sharesystem.csharereward")
if (SdkManager.GetChannel)() == "leit" and ((SdkManager.GetAgent)()):IsChannelPackage() then
  CCumulativeSharingExtraAward = (BeanManager.GetTableByName)("welfare.ccumulativesharingextraawardqd")
end
local BM_AnniversaryShare = class("BM_AnniversaryShare")
BM_AnniversaryShare.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).anniversaryshare
end

BM_AnniversaryShare.GetLeftTime = function(self)
  -- function num : 0_1 , upvalues : _ENV
  return (self._data).leftTime - ((ServerGameTimer.GetServerTimeForecast)() - (self._data).initialTime)
end

BM_AnniversaryShare.GetShareLeftTime = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return (self._data).shareLeftTime - ((ServerGameTimer.GetServerTimeForecast)() - (self._data).initialTime)
end

BM_AnniversaryShare.GetIsOpen = function(self)
  -- function num : 0_3
  do return self:GetLeftTime() > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_AnniversaryShare.GetShareIsOpen = function(self)
  -- function num : 0_4
  do return self:GetShareLeftTime() > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_AnniversaryShare.GetPictureID = function(self)
  -- function num : 0_5 , upvalues : CAllShareCfg
  local record = CAllShareCfg:GetRecorder((self._data).pictureID)
  if record then
    return record.imgid
  else
    return 0
  end
end

BM_AnniversaryShare.GetTotalShare = function(self)
  -- function num : 0_6
  return (self._data).totalShare
end

BM_AnniversaryShare.GetTotShareAward = function(self)
  -- function num : 0_7
  return (self._data).totShareAward
end

BM_AnniversaryShare.GetDailyShareAward = function(self)
  -- function num : 0_8
  return (self._data).dailyShareAward
end

BM_AnniversaryShare.GetHaveRedDot = function(self)
  -- function num : 0_9 , upvalues : SAnniversaryShareInfoDef, _ENV
  if not self:GetIsOpen() then
    return false
  end
  -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P3

  do return (self:GetShareIsOpen() and self:GetDailyShareAward() == SAnniversaryShareInfoDef.UNLOCKED) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_AnniversaryShare.GetNeedProgress = function(self, theID)
  -- function num : 0_10 , upvalues : CCumulativeSharingExtraAward, _ENV
  local recorderPre = CCumulativeSharingExtraAward:GetRecorder(theID - 1)
  local recorder = CCumulativeSharingExtraAward:GetRecorder(theID)
  if recorderPre then
    local var1 = (self._data).totalShare - recorderPre.needNum
    local var2 = (self._data).totalShare - recorder.needNum
    if var1 <= 0 then
      return 0
    else
      if var2 <= 0 then
        return ((self._data).totalShare - recorderPre.needNum) / (recorder.needNum - recorderPre.needNum)
      else
        return 1
      end
    end
  else
    do
      if recorder then
        return (self._data).totalShare / recorder.needNum
      else
        LogError("BM_AnniversaryShare:GetNeedProgress", "The " .. tostring(theID) .. " not exist!")
        return 0
      end
    end
  end
end

BM_AnniversaryShare.GetImgToTextID = function(self)
  -- function num : 0_11 , upvalues : CAllShareCfg
  local record = CAllShareCfg:GetRecorder((self._data).pictureID)
  if record then
    return record.wordid
  else
    return 0
  end
end

BM_AnniversaryShare.SendCQueryAnniversaryShareInfo = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if not self:GetIsOpen() then
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cqueryanniversaryshareinfo")
  if protocol then
    protocol:Send()
  end
end

BM_AnniversaryShare.SendCAnniversaryShare = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if not self:GetIsOpen() then
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.canniversaryshare")
  if protocol then
    protocol:Send()
  end
end

BM_AnniversaryShare.SendCFetchShareAward = function(self, awardId)
  -- function num : 0_14 , upvalues : _ENV
  if not self:GetIsOpen() then
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cfetchshareaward")
  if protocol then
    protocol.awardId = awardId
    protocol:Send()
  end
end

BM_AnniversaryShare.GetCShareReward = function(self)
  -- function num : 0_15 , upvalues : CShareReward
  local recorder = CShareReward:GetRecorder(6)
  return (recorder.itemID)[1], (recorder.itemNum)[1]
end

BM_AnniversaryShare.GetCAllShareCfg = function(self)
  -- function num : 0_16 , upvalues : CAllShareCfg
  return CAllShareCfg
end

BM_AnniversaryShare.GetCCumulativeSharingExtraAward = function(self)
  -- function num : 0_17 , upvalues : CCumulativeSharingExtraAward
  return CCumulativeSharingExtraAward
end

BM_AnniversaryShare.GetSAnniversaryShareInfoDef = function(self)
  -- function num : 0_18 , upvalues : SAnniversaryShareInfoDef
  return SAnniversaryShareInfoDef
end

return BM_AnniversaryShare

