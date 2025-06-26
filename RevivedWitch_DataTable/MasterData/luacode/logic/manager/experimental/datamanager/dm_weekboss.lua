-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_weekboss.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CWeeklyBossCultivateSkillMap = (BeanManager.GetTableByName)("dungeonselect.cweeklybosscultivateskillmap")
local DM_WeekBoss = class("DM_WeekBoss")
DM_WeekBoss.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, CWeeklyBossCultivateSkillMap
  self._data = (NekoData.Data).weekboss
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).weekBossData = nil
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).reddot = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).leftTalentNumber = 0
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).unlockedTalentNode = {}
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).allTalentNodes = {}
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).sortedNodeIdList = {}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).lastWeekRankData = nil
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).lastWeekRankId = nil
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).lastWeekBossId = nil
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).leftTime = -1
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).resetTime = -1
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).nightmareTime = -1
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).addtion = false
  self._culSkillMap = {}
  ;
  (CWeeklyBossCultivateSkillMap:GetAllIds())
  local allIds = nil
  local record = nil
  for _,id in ipairs(allIds) do
    record = CWeeklyBossCultivateSkillMap:GetRecorder(id)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R8 in 'UnsetPending'

    if not (self._culSkillMap)[record.mapID] then
      do
        (self._culSkillMap)[record.mapID] = {}
        ;
        (table.insert)((self._culSkillMap)[record.mapID], record)
        -- DECOMPILER ERROR at PC65: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC65: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
end

DM_WeekBoss.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).weekBossData = nil
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).reddot = {}
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).leftTalentNumber = 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).unlockedTalentNode = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).allTalentNodes = {}
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).sortedNodeIdList = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).lastWeekRankData = nil
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).lastWeekRankId = nil
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).lastWeekBossId = nil
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).leftTime = -1
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).resetTime = -1
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).nightmareTime = -1
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).addtion = false
end

DM_WeekBoss.OnSOpenWeekBossPanel = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).weekBossData = protocol
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).reddot)[(((NekoData.BehaviorManager).BM_WeekBoss).RedDotType).Reward] = (table.nums)((protocol.bosses).awardGot) < (protocol.bosses).awardTotalNum
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_WeekBoss.OnSWeekBossRedPoint = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  if protocol.redType == (((NekoData.BehaviorManager).BM_WeekBoss).RedDotType).Challenge then
    ((NekoData.BehaviorManager).BM_WeekBoss):SetLocalIntWithName(((((NekoData.BehaviorManager).BM_WeekBoss).LocalParamData).ChallengeHasBeenClicked).nameTxt, (((((NekoData.BehaviorManager).BM_WeekBoss).LocalParamData).ChallengeHasBeenClicked).showType).Show)
  else
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._data).reddot)[protocol.redType] = true
  end
end

local SetCultivateRedDot = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local status = false
  for nodeId,_ in pairs((self._data).allTalentNodes) do
    if ((NekoData.BehaviorManager).BM_WeekBoss):GetNodeStatus(nodeId) == (((NekoData.BehaviorManager).BM_WeekBoss).NodeStatusType).CanBeUnlock then
      status = true
      break
    end
  end
  do
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._data).reddot)[(((NekoData.BehaviorManager).BM_WeekBoss).RedDotType).Cultivate] = status
  end
end

DM_WeekBoss.OnSWeekBossTalent = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV, SetCultivateRedDot
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).leftTalentNumber = protocol.leftNum
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).unlockedTalentNode = {}
  for _,id in ipairs(protocol.unlockedTalentNode) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).unlockedTalentNode)[id] = true
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).allTalentNodes = {}
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).sortedNodeIdList = {}
  if not (self._data).weekBossData then
    LogError("DM_WeekBoss", "weekbossdata is nil")
    return false
  end
  local bossId = (((self._data).weekBossData).bosses).id
  local culSkillMapList = (self._culSkillMap)[bossId]
  if culSkillMapList then
    for _,record in ipairs(culSkillMapList) do
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'

      ((self._data).allTalentNodes)[record.id] = record
      ;
      (table.insert)((self._data).sortedNodeIdList, record.id)
    end
    ;
    (table.sort)((self._data).sortedNodeIdList, function(a, b)
    -- function num : 0_5_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  else
    LogErrorFormat("DM_WeekBoss", "bossid %s dont have mapID in cweeklybosscultivateskillmap", bossId)
  end
  SetCultivateRedDot(self)
  return culSkillMapList
end

DM_WeekBoss.OnSImproveTalent = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV, SetCultivateRedDot
  ((NekoData.BehaviorManager).BM_WeekBoss):CosumeTalentLeftNumber((((self._data).allTalentNodes)[protocol.unlockNode]).unlockConsumptionTimes)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).unlockedTalentNode)[protocol.unlockNode] = true
  SetCultivateRedDot(self)
end

DM_WeekBoss.OnSLastWeekChallengeRanking = function(self, protocol)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).lastWeekRankData = protocol.topThreeRank
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).lastWeekRankId = protocol.rankId
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).lastWeekBossId = protocol.bossId
end

DM_WeekBoss.OnSReceiveWeekAward = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV
  if not (self._data).weekBossData then
    LogError("DM_WeekBoss", "weekbossdata is nil")
    return 
  end
  if (((self._data).weekBossData).bosses).id == protocol.id then
    (table.insert)((((self._data).weekBossData).bosses).awardGot, protocol.stageId)
  end
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).reddot)[(((NekoData.BehaviorManager).BM_WeekBoss).RedDotType).Reward] = (table.nums)((((self._data).weekBossData).bosses).awardGot) < (((self._data).weekBossData).bosses).awardTotalNum
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_WeekBoss.OnSWeekBossTime = function(self, protocol)
  -- function num : 0_9 , upvalues : _ENV
  if (protocol.leftTime > 0 and (self._data).leftTime == -1) or protocol.leftTime == -1 and (self._data).leftTime > 0 then
    (LuaNotificationCenter.PostNotification)(Common.n_WeekBossRefresh, self, nil)
  end
  LogInfoFormat("DM_WeekBoss", "lefttime %s resettime %s nightmaretime %s", protocol.leftTime, protocol.resetTime, protocol.nightmareTime)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).leftTime = protocol.leftTime
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).resetTime = protocol.resetTime
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).nightmareTime = protocol.nightmareTime
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R2 in 'UnsetPending'

  if not ((NekoData.BehaviorManager).BM_WeekBoss):IsOpen() then
    ((self._data).reddot)[(((NekoData.BehaviorManager).BM_WeekBoss).RedDotType).Cultivate] = false
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._data).reddot)[(((NekoData.BehaviorManager).BM_WeekBoss).RedDotType).Challenge] = false
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_SWeekBossRedPoint, nil, nil)
  end
end

DM_WeekBoss.SetTeamAddtion = function(self)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).teamaddtion = true
end

return DM_WeekBoss

