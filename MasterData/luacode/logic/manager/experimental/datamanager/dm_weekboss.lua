local CWeeklyBossCultivateSkillMap = BeanManager.GetTableByName("dungeonselect.cweeklybosscultivateskillmap")
local DM_WeekBoss = class("DM_WeekBoss")

function DM_WeekBoss:Ctor()
  self._data = NekoData.Data.weekboss
  self._data.weekBossData = nil
  self._data.reddot = {}
  self._data.leftTalentNumber = 0
  self._data.unlockedTalentNode = {}
  self._data.allTalentNodes = {}
  self._data.sortedNodeIdList = {}
  self._data.lastWeekRankData = nil
  self._data.lastWeekRankId = nil
  self._data.lastWeekBossId = nil
  self._data.leftTime = -1
  self._data.resetTime = -1
  self._data.nightmareTime = -1
  self._data.addtion = false
  self._culSkillMap = {}
  local allIds = CWeeklyBossCultivateSkillMap:GetAllIds()
  local record
  for _, id in ipairs(allIds) do
    record = CWeeklyBossCultivateSkillMap:GetRecorder(id)
    self._culSkillMap[record.mapID] = self._culSkillMap[record.mapID] or {}
    table.insert(self._culSkillMap[record.mapID], record)
  end
end

function DM_WeekBoss:Clear()
  self._data.weekBossData = nil
  self._data.reddot = {}
  self._data.leftTalentNumber = 0
  self._data.unlockedTalentNode = {}
  self._data.allTalentNodes = {}
  self._data.sortedNodeIdList = {}
  self._data.lastWeekRankData = nil
  self._data.lastWeekRankId = nil
  self._data.lastWeekBossId = nil
  self._data.leftTime = -1
  self._data.resetTime = -1
  self._data.nightmareTime = -1
  self._data.addtion = false
end

function DM_WeekBoss:OnSOpenWeekBossPanel(protocol)
  self._data.weekBossData = protocol
  self._data.reddot[NekoData.BehaviorManager.BM_WeekBoss.RedDotType.Reward] = table.nums(protocol.bosses.awardGot) < protocol.bosses.awardTotalNum
end

function DM_WeekBoss:OnSWeekBossRedPoint(protocol)
  if protocol.redType == NekoData.BehaviorManager.BM_WeekBoss.RedDotType.Challenge then
    NekoData.BehaviorManager.BM_WeekBoss:SetLocalIntWithName(NekoData.BehaviorManager.BM_WeekBoss.LocalParamData.ChallengeHasBeenClicked.nameTxt, NekoData.BehaviorManager.BM_WeekBoss.LocalParamData.ChallengeHasBeenClicked.showType.Show)
  else
    self._data.reddot[protocol.redType] = true
  end
end

local function SetCultivateRedDot(self)
  local status = false
  for nodeId, _ in pairs(self._data.allTalentNodes) do
    if NekoData.BehaviorManager.BM_WeekBoss:GetNodeStatus(nodeId) == NekoData.BehaviorManager.BM_WeekBoss.NodeStatusType.CanBeUnlock then
      status = true
      break
    end
  end
  self._data.reddot[NekoData.BehaviorManager.BM_WeekBoss.RedDotType.Cultivate] = status
end

function DM_WeekBoss:OnSWeekBossTalent(protocol)
  self._data.leftTalentNumber = protocol.leftNum
  self._data.unlockedTalentNode = {}
  for _, id in ipairs(protocol.unlockedTalentNode) do
    self._data.unlockedTalentNode[id] = true
  end
  self._data.allTalentNodes = {}
  self._data.sortedNodeIdList = {}
  if not self._data.weekBossData then
    LogError("DM_WeekBoss", "weekbossdata is nil")
    return false
  end
  local bossId = self._data.weekBossData.bosses.id
  local culSkillMapList = self._culSkillMap[bossId]
  if culSkillMapList then
    for _, record in ipairs(culSkillMapList) do
      self._data.allTalentNodes[record.id] = record
      table.insert(self._data.sortedNodeIdList, record.id)
    end
    table.sort(self._data.sortedNodeIdList, function(a, b)
      return a < b
    end)
  else
    LogErrorFormat("DM_WeekBoss", "bossid %s dont have mapID in cweeklybosscultivateskillmap", bossId)
  end
  SetCultivateRedDot(self)
  return culSkillMapList
end

function DM_WeekBoss:OnSImproveTalent(protocol)
  NekoData.BehaviorManager.BM_WeekBoss:CosumeTalentLeftNumber(self._data.allTalentNodes[protocol.unlockNode].unlockConsumptionTimes)
  self._data.unlockedTalentNode[protocol.unlockNode] = true
  SetCultivateRedDot(self)
end

function DM_WeekBoss:OnSLastWeekChallengeRanking(protocol)
  self._data.lastWeekRankData = protocol.topThreeRank
  self._data.lastWeekRankId = protocol.rankId
  self._data.lastWeekBossId = protocol.bossId
end

function DM_WeekBoss:OnSReceiveWeekAward(protocol)
  if not self._data.weekBossData then
    LogError("DM_WeekBoss", "weekbossdata is nil")
    return
  end
  if self._data.weekBossData.bosses.id == protocol.id then
    table.insert(self._data.weekBossData.bosses.awardGot, protocol.stageId)
  end
  self._data.reddot[NekoData.BehaviorManager.BM_WeekBoss.RedDotType.Reward] = table.nums(self._data.weekBossData.bosses.awardGot) < self._data.weekBossData.bosses.awardTotalNum
end

function DM_WeekBoss:OnSWeekBossTime(protocol)
  if protocol.leftTime > 0 and self._data.leftTime == -1 or protocol.leftTime == -1 and 0 < self._data.leftTime then
    LuaNotificationCenter.PostNotification(Common.n_WeekBossRefresh, self, nil)
  end
  LogInfoFormat("DM_WeekBoss", "lefttime %s resettime %s nightmaretime %s", protocol.leftTime, protocol.resetTime, protocol.nightmareTime)
  self._data.leftTime = protocol.leftTime
  self._data.resetTime = protocol.resetTime
  self._data.nightmareTime = protocol.nightmareTime
  if not NekoData.BehaviorManager.BM_WeekBoss:IsOpen() then
    self._data.reddot[NekoData.BehaviorManager.BM_WeekBoss.RedDotType.Cultivate] = false
    self._data.reddot[NekoData.BehaviorManager.BM_WeekBoss.RedDotType.Challenge] = false
    LuaNotificationCenter.PostNotification(Common.n_SWeekBossRedPoint, nil, nil)
  end
end

function DM_WeekBoss:SetTeamAddtion()
  self._data.teamaddtion = true
end

return DM_WeekBoss
