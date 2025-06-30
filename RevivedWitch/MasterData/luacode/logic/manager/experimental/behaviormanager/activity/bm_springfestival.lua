-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_springfestival.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBossNianPart = (BeanManager.GetTableByName)("activity.cbossnianpart")
local CBossNianRewardShow = (BeanManager.GetTableByName)("activity.cbossnianpointreward")
local CSfblessingChat = (BeanManager.GetTableByName)("activity.csfblessingchat")
local CGetSpringRedPacket = require("protocols.def.protocol.activity.cgetspringredpacket")
local BM_SpringFestival = class("BM_SpringFestival")
BM_SpringFestival.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).springfestival
end

BM_SpringFestival.IsRedPacketEnable = function(self)
  -- function num : 0_1
  return (self._data).redPacketIsOpen
end

BM_SpringFestival.GetRedPacketState = function(self)
  -- function num : 0_2
  return (self._data).redPacketState
end

BM_SpringFestival.GetBossInfo = function(self)
  -- function num : 0_3
  return (self._data).bossData
end

BM_SpringFestival.GetBossScoreAndRank = function(self)
  -- function num : 0_4
  return {score = ((self._data).bossData).score, rank = ((self._data).bossData).rank}
end

BM_SpringFestival.GetBossInfoByID = function(self, id)
  -- function num : 0_5
  return (((self._data).bossData).bossList)[id]
end

BM_SpringFestival.GetSpringSpirit = function(self)
  -- function num : 0_6
  return ((self._data).spirit).spirit
end

BM_SpringFestival.GetNextSpiritLeftTime = function(self)
  -- function num : 0_7
  return ((self._data).spirit).lefttime
end

BM_SpringFestival.GetSpiritLimit = function(self)
  -- function num : 0_8
  return ((self._data).recorder).actPowerLimit
end

BM_SpringFestival.GetBossRewardData = function(self, bossId)
  -- function num : 0_9 , upvalues : CBossNianPart, _ENV, CBossNianRewardShow
  local killReward = {}
  local stageReward = {}
  local recorder = CBossNianPart:GetRecorder(bossId)
  for i,item in ipairs(recorder.showkillBossRewardId) do
    (table.insert)(killReward, {id = item, num = (recorder.showkillBossRewardNum)[i], stage = -1})
  end
  local allIds = CBossNianRewardShow:GetAllIds()
  for i,id in pairs(allIds) do
    local bossid = id // 1000
    local stage = id - bossid * 1000
    recorder = CBossNianRewardShow:GetRecorder(id)
    if bossid == bossId then
      for i,item in ipairs(recorder.battleRewardId) do
        (table.insert)(stageReward, {id = item, num = (recorder.battleRewardNum)[i], stage = stage})
      end
    end
  end
  return killReward, stageReward
end

BM_SpringFestival.GetCfgRecorder = function(self)
  -- function num : 0_10
  return (self._data).recorder
end

BM_SpringFestival.GetDay = function(self)
  -- function num : 0_11
  return (self._data).redPacketStateDay
end

BM_SpringFestival.GetSpringBattleResult = function(self)
  -- function num : 0_12
  return (self._data).battleresult
end

BM_SpringFestival.GetIsOpen = function(self)
  -- function num : 0_13
  do return (self._data).state == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_SpringFestival.GetNPCTalkTimeLineIDs = function(self)
  -- function num : 0_14 , upvalues : _ENV, CSfblessingChat
  if not self._npcTalkTimeLineIDs then
    self._npcTalkTimeLineIDs = {}
    for _,id in ipairs(CSfblessingChat:GetAllIds()) do
      local record = CSfblessingChat:GetRecorder(id)
      if record.timelineID ~= 0 then
        (table.insert)(self._npcTalkTimeLineIDs, record.timelineID)
      end
    end
  end
  do
    return self._npcTalkTimeLineIDs
  end
end

BM_SpringFestival.ShowRedDot = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local loginRedPoint = not (self._data).redPacketStateDay or ((self._data).redPacketStateDay ~= 0 and (((CS.UnityEngine).PlayerPrefs).GetInt)("SpringFestivalDay") ~= (self._data).redPacketStateDay)
  if not loginRedPoint and not self:ShowRedPacketRedPoint() then
    do return self:ShowBossRedPoint() end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

BM_SpringFestival.ShowRedPacketRedPoint = function(self)
  -- function num : 0_16 , upvalues : CGetSpringRedPacket, _ENV
  if ((self._data).redPacketState)[CGetSpringRedPacket.FREE] ~= 0 and (((self._data).redPacketState)[CGetSpringRedPacket.ACTIVE] ~= 0 or (((NekoData.BehaviorManager).BM_Task):GetActiveInfo()).current < 100) then
    do return not (self._data).redPacketIsOpen end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_SpringFestival.ShowBossRedPoint = function(self)
  -- function num : 0_17
  do return (self._data).bossRewardRedPoint == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_SpringFestival.ShowRedDotByFunctionIndex = function(self, index)
  -- function num : 0_18
  if index == 1 then
    return self:ShowRedPacketRedPoint()
  else
    if index == 2 then
      return self:ShowBossRedPoint()
    end
  end
end

BM_SpringFestival.GetRankID = function(self)
  -- function num : 0_19
  return (self._data).rankId
end

BM_SpringFestival.IsSpringShopEnable = function(self)
  -- function num : 0_20
  return (self._data).springShopIsOpen
end

return BM_SpringFestival

