local RankType = LuaNetManager.GetBeanDef("protocol.ranking.ranktype")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local SChristmasSupportRedPointDef = LuaNetManager.GetProtocolDef("protocol.activity.schristmassupportredpoint")
local CChristmasCall = BeanManager.GetTableByName("activity.cchristmascall")
local CChristmasCallCfg = BeanManager.GetTableByName("activity.cchristmascallcfg")
local CChristmasCallRank = BeanManager.GetTableByName("activity.cchristmascallrank")
local BM_ChristmasCall = class("BM_ChristmasCall")

function BM_ChristmasCall:Ctor()
  self._christmascall = NekoData.Data.activities.chrismascall
end

function BM_ChristmasCall:GetIsOpen()
  return self._christmascall.isOpen
end

function BM_ChristmasCall:GetTotalRemainTime()
  return self._christmascall.totalRemainTime - (ServerGameTimer.GetServerTimeForecast() - self._christmascall.startTime)
end

function BM_ChristmasCall:GetCallRemainTime()
  return self._christmascall.callRemainTime
end

function BM_ChristmasCall:GetShopCanOpen()
  return self._christmascall.shopCanOpen
end

function BM_ChristmasCall:GetNowScore()
  return self._christmascall.nowScore
end

function BM_ChristmasCall:GetNowGlobalScore()
  return self._christmascall.globalScore
end

function BM_ChristmasCall:GetCanCall()
  return self._christmascall.canCall
end

function BM_ChristmasCall:GetNowGainCallNum()
  return self._christmascall.nowGainCallNum
end

function BM_ChristmasCall:GetCallLeftTimeState()
  local nowRemainTime = self:GetCallRemainTime()
  if nowRemainTime < 3600000 then
    return 2, self:GetRemainTimeStr(nowRemainTime)
  elseif nowRemainTime < 86400000 then
    return 1, self:GetRemainTimeStr(nowRemainTime)
  elseif nowRemainTime < 172800000 then
    return 0, self:GetRemainTimeStr(nowRemainTime)
  end
  return -1
end

function BM_ChristmasCall:GetRemainTimeStr(endTime)
  local str = ""
  if endTime and 0 < endTime then
    local time = endTime // 1000
    local day = time // 86400
    local hour = time // 3600
    local min = time // 60
    local sec = time % 60
    if 0 < day then
      str = TextManager.GetText(CStringRes:GetRecorder(1684).msgTextID)
      str = string.gsub(str, "%$parameter1%$", day)
    elseif 0 < hour then
      str = TextManager.GetText(CStringRes:GetRecorder(1685).msgTextID)
      str = string.gsub(str, "%$parameter1%$", hour)
    elseif 0 < min then
      str = TextManager.GetText(CStringRes:GetRecorder(1686).msgTextID)
      str = string.gsub(str, "%$parameter1%$", min)
    elseif 0 < sec then
      str = TextManager.GetText(CStringRes:GetRecorder(1686).msgTextID)
      str = string.gsub(str, "%$parameter1%$", 0)
    end
  end
  return str
end

function BM_ChristmasCall:GetRewardState()
  return self._christmascall.rewardIds
end

function BM_ChristmasCall:GetRewardCfgByRank(rank)
  if rank == -1 then
    return
  end
  local allIDs = CChristmasCallRank:GetAllIds()
  for _, id in ipairs(allIDs) do
    local record = CChristmasCallRank:GetRecorder(id)
    if rank <= record.rankRewardType then
      return CChristmasCallRank:GetRecorder(id)
    end
  end
end

function BM_ChristmasCall:GetRandomCallVoiceID()
  if not self._callRandomVoicIDs then
    self._callRandomVoicIDs = {}
    for _, value in pairs(CChristmasCall:GetRecorder(1).charTalk) do
      table.insert(self._callRandomVoicIDs, value)
    end
  end
  local len = #self._callRandomVoicIDs
  local randomIndex = math.random(1, len)
  return self._callRandomVoicIDs[randomIndex]
end

function BM_ChristmasCall:GetNPCTalkTimeLineIDs()
  if not self._npcTalkTimeLineIDs then
    self._npcTalkTimeLineIDs = {}
    for _, id in ipairs(CChristmasCallCfg:GetAllIds()) do
      local record = CChristmasCallCfg:GetRecorder(id)
      if record.npcTalk ~= 0 then
        table.insert(self._npcTalkTimeLineIDs, record.npcTalk)
      end
    end
  end
  return self._npcTalkTimeLineIDs
end

function BM_ChristmasCall:GetSettleState()
  return self._christmascall.settleState
end

function BM_ChristmasCall:AddRedDot(type)
  self._christmascall.redDotList[type] = true
end

function BM_ChristmasCall:KillRedDot(type)
  self._christmascall.redDotList[type] = nil
end

function BM_ChristmasCall:GetRedDot(type)
  return self._christmascall.redDotList[type]
end

function BM_ChristmasCall:HaveRedDot()
  return next(self._christmascall.redDotList) ~= nil
end

function BM_ChristmasCall:ShowRedDot()
  if not self:GetIsOpen() then
    return false
  end
  return self:HaveRedDot() or NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.ChristmasCallActivityUnlock) ~= nil
end

function BM_ChristmasCall:GetCChristmasCallCfg()
  return CChristmasCall
end

function BM_ChristmasCall:GetCChristmasCallCfgCfg()
  return CChristmasCallCfg
end

function BM_ChristmasCall:GetCChristmasCallRankCfg()
  return CChristmasCallRank
end

function BM_ChristmasCall:SendCChristmasSupport(num)
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cchristmassupport")
  if protocol then
    protocol.num = num
    protocol:Send()
  end
end

function BM_ChristmasCall:SendCReceiveSupportReward(rewardType, id)
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceivesupportreward")
  if protocol then
    protocol.rewardType = rewardType
    protocol.id = id
    protocol:Send()
  end
end

function BM_ChristmasCall:SendCOpenTotalSupportScore()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.copentotalsupportscore")
  if protocol then
    protocol:Send()
  end
end

function BM_ChristmasCall:SendCGetShopInfo()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = DataCommon.ChristmasCallShopID
    protocol:Send()
  end
end

function BM_ChristmasCall:SendCSimpleRank(rankType, rankId)
  local protocol = LuaNetManager.CreateProtocol("protocol.ranking.csimplerank")
  if protocol then
    protocol.rankType = NekoData.BehaviorManager.BM_SimpleRank:GetRankTypeDef().CHRISTMAS_SUPPORT
    protocol.rankId = 0
    protocol:Send()
  end
end

function BM_ChristmasCall:SendCLookOtherInfo(userId)
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.clookotherinfo")
  if protocol then
    protocol.userId = userId
    protocol:Send()
  end
end

function BM_ChristmasCall:SendCheckGainNumber()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.ccheckgainnumber")
  if protocol then
    protocol:Send()
  end
end

function BM_ChristmasCall:GetSChristmasSupportRedPointDef()
  return SChristmasSupportRedPointDef
end

return BM_ChristmasCall
