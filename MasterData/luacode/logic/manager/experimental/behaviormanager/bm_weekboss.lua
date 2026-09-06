local SWeekBossRedPoint = LuaNetManager.GetProtocolDef("protocol.battle.sweekbossredpoint")
local BM_WeekBoss = class("BM_WeekBoss")
BM_WeekBoss.RedDotType = {
  Challenge = SWeekBossRedPoint.UNLOCK_NIGHTMARE,
  Rank = 4,
  Reward = SWeekBossRedPoint.RECEIVE_REWARD,
  Cultivate = SWeekBossRedPoint.UNLOCK_TALENT,
  Achievement = 5,
  Total = 6
}
BM_WeekBoss.NodeStatusType = {
  CanBeUnlock = 0,
  TimesNotEnough = 1,
  BeforeNodeLock = 2,
  ConflictedHasBeenUnlock = 4,
  HasBeenUnlocked = 8,
  Forbid = 16
}
local PARAM_PREFIX = "BOSSRUSHWEEK"
local ParamShowType = {Show = 0, No = 1}
BM_WeekBoss.LocalParamData = {
  NightmareChallengeConfirm = {
    nameTxt = "NightmareChallengeConfirm",
    default = ParamShowType.Show,
    showType = {Show = 0, No = 1}
  },
  ChallengeHasBeenClicked = {
    nameTxt = "ChallengeHasBeenClicked",
    default = ParamShowType.Show,
    showType = {Show = 0, No = 1}
  }
}

function BM_WeekBoss:Ctor()
  self._data = NekoData.Data.weekboss
end

function BM_WeekBoss:GetWeekBossRushData()
  return self._data.weekBossData
end

function BM_WeekBoss:GetWeekBossRushRankId()
  return self._data.weekBossData.rankId
end

function BM_WeekBoss:IsUnlock()
  return self._data.leftTime ~= -1 or self._data.resetTime ~= -1 or self._data.nightmareTime ~= -1
end

function BM_WeekBoss:IsOpen()
  return self._data.leftTime ~= -1
end

function BM_WeekBoss:GetLeftTime()
  return self._data.leftTime
end

function BM_WeekBoss:GetResetTime()
  return self._data.resetTime
end

function BM_WeekBoss:GetNightmareTime()
  return self._data.nightmareTime
end

function BM_WeekBoss:IsNightmareOpen()
  return self._data.nightmareTime == -1
end

function BM_WeekBoss:GetRedDotWithType(type)
  return self._data.reddot[type]
end

function BM_WeekBoss:GetTalentLeftNumber()
  return self._data.leftTalentNumber
end

function BM_WeekBoss:CosumeTalentLeftNumber(cosume)
  if cosume <= self._data.leftTalentNumber then
    self._data.leftTalentNumber = self._data.leftTalentNumber - cosume
    return true
  else
    return false
  end
end

function BM_WeekBoss:GetUnlockTalentNode()
  return self._data.unlockedTalentNode
end

function BM_WeekBoss:GetAllTalentNodes()
  return self._data.allTalentNodes
end

function BM_WeekBoss:GetNodeStatus(nodeId)
  if not self._data.allTalentNodes[nodeId] then
    return self.NodeStatusType.Forbid
  end
  local result = self.NodeStatusType.CanBeUnlock
  if self._data.unlockedTalentNode[nodeId] then
    result = result | self.NodeStatusType.HasBeenUnlocked
  end
  if self._data.unlockedTalentNode[self._data.allTalentNodes[nodeId].conflictedNode] then
    result = result | self.NodeStatusType.ConflictedHasBeenUnlock
  end
  if self._data.leftTalentNumber < self._data.allTalentNodes[nodeId].unlockConsumptionTimes then
    result = result | self.NodeStatusType.TimesNotEnough
  end
  local frontNode = self._data.allTalentNodes[nodeId].frontNode
  local frontList = {}
  local beforeNodeUnlock = false
  if frontNode ~= "-1" then
    frontList = string.split(frontNode, ";")
  else
    beforeNodeUnlock = true
  end
  local frontNodeList = {}
  for _, nodeId in ipairs(frontList) do
    if self._data.unlockedTalentNode[tonumber(nodeId)] then
      beforeNodeUnlock = true
      break
    end
  end
  if not beforeNodeUnlock then
    result = result | self.NodeStatusType.BeforeNodeLock
  end
  return result
end

function BM_WeekBoss:GetLocalIntWithType(dataTable)
  return CS.UnityEngine.PlayerPrefs.GetInt(table.concat({
    NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid,
    PARAM_PREFIX,
    dataTable.nameTxt
  }, "."), dataTable.default)
end

function BM_WeekBoss:SetLocalIntWithName(nameTxt, value)
  CS.UnityEngine.PlayerPrefs.SetInt(table.concat({
    NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid,
    PARAM_PREFIX,
    nameTxt
  }, "."), value)
end

function BM_WeekBoss:IfShowRedDotInMainlinePanel()
  if self:IsOpen() and NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BossRush) then
    return self._data.reddot[self.RedDotType.Achievement] or self._data.reddot[self.RedDotType.Reward] or self:GetLocalIntWithType(self.LocalParamData.ChallengeHasBeenClicked) == self.LocalParamData.ChallengeHasBeenClicked.showType.Show or self:GetRedDotWithType(self.RedDotType.Challenge)
  else
    return self._data.reddot[self.RedDotType.Achievement] or self._data.reddot[self.RedDotType.Reward]
  end
end

function BM_WeekBoss:GetLastWeekRankData()
  return self._data.lastWeekRankData or {}
end

function BM_WeekBoss:GetLastWeekRankId()
  return self._data.lastWeekRankId
end

function BM_WeekBoss:GetLastWeekBossId()
  return self._data.lastWeekBossId
end

function BM_WeekBoss:SetRedDotWithType(type, value)
  self._data.reddot[type] = value
end

function BM_WeekBoss:GetSortedNodeIdList()
  return self._data.sortedNodeIdList
end

function BM_WeekBoss:GetTeamAddtion()
  return self:IsOpen() and self._data.teamaddtion
end

return BM_WeekBoss
