-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_christmascall.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RankType = (LuaNetManager.GetBeanDef)("protocol.ranking.ranktype")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local SChristmasSupportRedPointDef = (LuaNetManager.GetProtocolDef)("protocol.activity.schristmassupportredpoint")
local CChristmasCall = (BeanManager.GetTableByName)("activity.cchristmascall")
local CChristmasCallCfg = (BeanManager.GetTableByName)("activity.cchristmascallcfg")
local CChristmasCallRank = (BeanManager.GetTableByName)("activity.cchristmascallrank")
local BM_ChristmasCall = class("BM_ChristmasCall")
BM_ChristmasCall.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._christmascall = ((NekoData.Data).activities).chrismascall
end

BM_ChristmasCall.GetIsOpen = function(self)
  -- function num : 0_1
  return (self._christmascall).isOpen
end

BM_ChristmasCall.GetTotalRemainTime = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return (self._christmascall).totalRemainTime - ((ServerGameTimer.GetServerTimeForecast)() - (self._christmascall).startTime)
end

BM_ChristmasCall.GetCallRemainTime = function(self)
  -- function num : 0_3
  return (self._christmascall).callRemainTime
end

BM_ChristmasCall.GetShopCanOpen = function(self)
  -- function num : 0_4
  return (self._christmascall).shopCanOpen
end

BM_ChristmasCall.GetNowScore = function(self)
  -- function num : 0_5
  return (self._christmascall).nowScore
end

BM_ChristmasCall.GetNowGlobalScore = function(self)
  -- function num : 0_6
  return (self._christmascall).globalScore
end

BM_ChristmasCall.GetCanCall = function(self)
  -- function num : 0_7
  return (self._christmascall).canCall
end

BM_ChristmasCall.GetNowGainCallNum = function(self)
  -- function num : 0_8
  return (self._christmascall).nowGainCallNum
end

BM_ChristmasCall.GetCallLeftTimeState = function(self)
  -- function num : 0_9
  local nowRemainTime = self:GetCallRemainTime()
  if nowRemainTime < 3600000 then
    return 2, self:GetRemainTimeStr(nowRemainTime)
  else
    if nowRemainTime < 86400000 then
      return 1, self:GetRemainTimeStr(nowRemainTime)
    else
      if nowRemainTime < 172800000 then
        return 0, self:GetRemainTimeStr(nowRemainTime)
      end
    end
  end
  return -1
end

BM_ChristmasCall.GetRemainTimeStr = function(self, endTime)
  -- function num : 0_10 , upvalues : _ENV, CStringRes
  local str = ""
  if endTime and endTime > 0 then
    local time = endTime // 1000
    local day = time // 86400
    local hour = time // 3600
    local min = time // 60
    local sec = time % 60
    if day > 0 then
      str = (TextManager.GetText)((CStringRes:GetRecorder(1684)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", day)
    else
      if hour > 0 then
        str = (TextManager.GetText)((CStringRes:GetRecorder(1685)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", hour)
      else
        if min > 0 then
          str = (TextManager.GetText)((CStringRes:GetRecorder(1686)).msgTextID)
          str = (string.gsub)(str, "%$parameter1%$", min)
        else
          if sec > 0 then
            str = (TextManager.GetText)((CStringRes:GetRecorder(1686)).msgTextID)
            str = (string.gsub)(str, "%$parameter1%$", 0)
          end
        end
      end
    end
  end
  do
    return str
  end
end

BM_ChristmasCall.GetRewardState = function(self)
  -- function num : 0_11
  return (self._christmascall).rewardIds
end

BM_ChristmasCall.GetRewardCfgByRank = function(self, rank)
  -- function num : 0_12 , upvalues : CChristmasCallRank, _ENV
  if rank == -1 then
    return 
  end
  local allIDs = CChristmasCallRank:GetAllIds()
  for _,id in ipairs(allIDs) do
    local record = CChristmasCallRank:GetRecorder(id)
    if rank <= record.rankRewardType then
      return CChristmasCallRank:GetRecorder(id)
    end
  end
end

BM_ChristmasCall.GetRandomCallVoiceID = function(self)
  -- function num : 0_13 , upvalues : _ENV, CChristmasCall
  if not self._callRandomVoicIDs then
    self._callRandomVoicIDs = {}
    for _,value in pairs((CChristmasCall:GetRecorder(1)).charTalk) do
      (table.insert)(self._callRandomVoicIDs, value)
    end
  end
  do
    local len = #self._callRandomVoicIDs
    local randomIndex = (math.random)(1, len)
    return (self._callRandomVoicIDs)[randomIndex]
  end
end

BM_ChristmasCall.GetNPCTalkTimeLineIDs = function(self)
  -- function num : 0_14 , upvalues : _ENV, CChristmasCallCfg
  if not self._npcTalkTimeLineIDs then
    self._npcTalkTimeLineIDs = {}
    for _,id in ipairs(CChristmasCallCfg:GetAllIds()) do
      local record = CChristmasCallCfg:GetRecorder(id)
      if record.npcTalk ~= 0 then
        (table.insert)(self._npcTalkTimeLineIDs, record.npcTalk)
      end
    end
  end
  do
    return self._npcTalkTimeLineIDs
  end
end

BM_ChristmasCall.GetSettleState = function(self)
  -- function num : 0_15
  return (self._christmascall).settleState
end

BM_ChristmasCall.AddRedDot = function(self, type)
  -- function num : 0_16
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._christmascall).redDotList)[type] = true
end

BM_ChristmasCall.KillRedDot = function(self, type)
  -- function num : 0_17
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._christmascall).redDotList)[type] = nil
end

BM_ChristmasCall.GetRedDot = function(self, type)
  -- function num : 0_18
  return ((self._christmascall).redDotList)[type]
end

BM_ChristmasCall.HaveRedDot = function(self)
  -- function num : 0_19 , upvalues : _ENV
  do return next((self._christmascall).redDotList) ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_ChristmasCall.ShowRedDot = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if not self:GetIsOpen() then
    return false
  end
  do return self:HaveRedDot() or ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).ChristmasCallActivityUnlock) ~= nil end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_ChristmasCall.GetCChristmasCallCfg = function(self)
  -- function num : 0_21 , upvalues : CChristmasCall
  return CChristmasCall
end

BM_ChristmasCall.GetCChristmasCallCfgCfg = function(self)
  -- function num : 0_22 , upvalues : CChristmasCallCfg
  return CChristmasCallCfg
end

BM_ChristmasCall.GetCChristmasCallRankCfg = function(self)
  -- function num : 0_23 , upvalues : CChristmasCallRank
  return CChristmasCallRank
end

BM_ChristmasCall.SendCChristmasSupport = function(self, num)
  -- function num : 0_24 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cchristmassupport")
  if protocol then
    protocol.num = num
    protocol:Send()
  end
end

BM_ChristmasCall.SendCReceiveSupportReward = function(self, rewardType, id)
  -- function num : 0_25 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceivesupportreward")
  if protocol then
    protocol.rewardType = rewardType
    protocol.id = id
    protocol:Send()
  end
end

BM_ChristmasCall.SendCOpenTotalSupportScore = function(self)
  -- function num : 0_26 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.copentotalsupportscore")
  if protocol then
    protocol:Send()
  end
end

BM_ChristmasCall.SendCGetShopInfo = function(self)
  -- function num : 0_27 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = DataCommon.ChristmasCallShopID
    protocol:Send()
  end
end

BM_ChristmasCall.SendCSimpleRank = function(self, rankType, rankId)
  -- function num : 0_28 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.ranking.csimplerank")
  if protocol then
    protocol.rankType = (((NekoData.BehaviorManager).BM_SimpleRank):GetRankTypeDef()).CHRISTMAS_SUPPORT
    protocol.rankId = 0
    protocol:Send()
  end
end

BM_ChristmasCall.SendCLookOtherInfo = function(self, userId)
  -- function num : 0_29 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.clookotherinfo")
  if protocol then
    protocol.userId = userId
    protocol:Send()
  end
end

BM_ChristmasCall.SendCheckGainNumber = function(self)
  -- function num : 0_30 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.ccheckgainnumber")
  if protocol then
    protocol:Send()
  end
end

BM_ChristmasCall.GetSChristmasSupportRedPointDef = function(self)
  -- function num : 0_31 , upvalues : SChristmasSupportRedPointDef
  return SChristmasSupportRedPointDef
end

return BM_ChristmasCall

