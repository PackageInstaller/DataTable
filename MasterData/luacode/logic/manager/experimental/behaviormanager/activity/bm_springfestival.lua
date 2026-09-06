local CBossNianPart = BeanManager.GetTableByName("activity.cbossnianpart")
local CBossNianRewardShow = BeanManager.GetTableByName("activity.cbossnianpointreward")
local CSfblessingChat = BeanManager.GetTableByName("activity.csfblessingchat")
local CGetSpringRedPacket = require("protocols.def.protocol.activity.cgetspringredpacket")
local BM_SpringFestival = class("BM_SpringFestival")

function BM_SpringFestival:Ctor()
  self._data = NekoData.Data.activities.springfestival
end

function BM_SpringFestival:IsRedPacketEnable()
  return self._data.redPacketIsOpen
end

function BM_SpringFestival:GetRedPacketState()
  return self._data.redPacketState
end

function BM_SpringFestival:GetBossInfo()
  return self._data.bossData
end

function BM_SpringFestival:GetBossScoreAndRank()
  return {
    score = self._data.bossData.score,
    rank = self._data.bossData.rank
  }
end

function BM_SpringFestival:GetBossInfoByID(id)
  return self._data.bossData.bossList[id]
end

function BM_SpringFestival:GetSpringSpirit()
  return self._data.spirit.spirit
end

function BM_SpringFestival:GetNextSpiritLeftTime()
  return self._data.spirit.lefttime
end

function BM_SpringFestival:GetSpiritLimit()
  return self._data.recorder.actPowerLimit
end

function BM_SpringFestival:GetBossRewardData(bossId)
  local killReward = {}
  local stageReward = {}
  local recorder = CBossNianPart:GetRecorder(bossId)
  for i, item in ipairs(recorder.showkillBossRewardId) do
    table.insert(killReward, {
      id = item,
      num = recorder.showkillBossRewardNum[i],
      stage = -1
    })
  end
  local allIds = CBossNianRewardShow:GetAllIds()
  for i, id in pairs(allIds) do
    local bossid = id // 1000
    local stage = id - bossid * 1000
    recorder = CBossNianRewardShow:GetRecorder(id)
    if bossid == bossId then
      for i, item in ipairs(recorder.battleRewardId) do
        table.insert(stageReward, {
          id = item,
          num = recorder.battleRewardNum[i],
          stage = stage
        })
      end
    end
  end
  return killReward, stageReward
end

function BM_SpringFestival:GetCfgRecorder()
  return self._data.recorder
end

function BM_SpringFestival:GetDay()
  return self._data.redPacketStateDay
end

function BM_SpringFestival:GetSpringBattleResult()
  return self._data.battleresult
end

function BM_SpringFestival:GetIsOpen()
  return self._data.state == 1
end

function BM_SpringFestival:GetNPCTalkTimeLineIDs()
  if not self._npcTalkTimeLineIDs then
    self._npcTalkTimeLineIDs = {}
    for _, id in ipairs(CSfblessingChat:GetAllIds()) do
      local record = CSfblessingChat:GetRecorder(id)
      if record.timelineID ~= 0 then
        table.insert(self._npcTalkTimeLineIDs, record.timelineID)
      end
    end
  end
  return self._npcTalkTimeLineIDs
end

function BM_SpringFestival:ShowRedDot()
  local loginRedPoint = self._data.redPacketStateDay and self._data.redPacketStateDay ~= 0 and CS.UnityEngine.PlayerPrefs.GetInt("SpringFestivalDay") ~= self._data.redPacketStateDay
  return loginRedPoint or self:ShowRedPacketRedPoint() or self:ShowBossRedPoint()
end

function BM_SpringFestival:ShowRedPacketRedPoint()
  if self._data.redPacketIsOpen then
    return self._data.redPacketState[CGetSpringRedPacket.FREE] == 0 or self._data.redPacketState[CGetSpringRedPacket.ACTIVE] == 0 and NekoData.BehaviorManager.BM_Task:GetActiveInfo().current >= 100
  end
end

function BM_SpringFestival:ShowBossRedPoint()
  return self._data.bossRewardRedPoint == 1
end

function BM_SpringFestival:ShowRedDotByFunctionIndex(index)
  if index == 1 then
    return self:ShowRedPacketRedPoint()
  elseif index == 2 then
    return self:ShowBossRedPoint()
  end
end

function BM_SpringFestival:GetRankID()
  return self._data.rankId
end

function BM_SpringFestival:IsSpringShopEnable()
  return self._data.springShopIsOpen
end

return BM_SpringFestival
