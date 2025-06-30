-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_weekboss.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SWeekBossRedPoint = (LuaNetManager.GetProtocolDef)("protocol.battle.sweekbossredpoint")
local BM_WeekBoss = class("BM_WeekBoss")
BM_WeekBoss.RedDotType = {Challenge = SWeekBossRedPoint.UNLOCK_NIGHTMARE, Rank = 4, Reward = SWeekBossRedPoint.RECEIVE_REWARD, Cultivate = SWeekBossRedPoint.UNLOCK_TALENT, Achievement = 5, Total = 6}
BM_WeekBoss.NodeStatusType = {CanBeUnlock = 0, TimesNotEnough = 1, BeforeNodeLock = 2, ConflictedHasBeenUnlock = 4, HasBeenUnlocked = 8, Forbid = 16}
local PARAM_PREFIX = "BOSSRUSHWEEK"
local ParamShowType = {Show = 0, No = 1}
BM_WeekBoss.LocalParamData = {
NightmareChallengeConfirm = {nameTxt = "NightmareChallengeConfirm", default = ParamShowType.Show, 
showType = {Show = 0, No = 1}
}
, 
ChallengeHasBeenClicked = {nameTxt = "ChallengeHasBeenClicked", default = ParamShowType.Show, 
showType = {Show = 0, No = 1}
}
}
BM_WeekBoss.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).weekboss
end

BM_WeekBoss.GetWeekBossRushData = function(self)
  -- function num : 0_1
  return (self._data).weekBossData
end

BM_WeekBoss.GetWeekBossRushRankId = function(self)
  -- function num : 0_2
  return ((self._data).weekBossData).rankId
end

BM_WeekBoss.IsUnlock = function(self)
  -- function num : 0_3
  do return (self._data).leftTime ~= -1 or (self._data).resetTime ~= -1 or (self._data).nightmareTime ~= -1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_WeekBoss.IsOpen = function(self)
  -- function num : 0_4
  do return (self._data).leftTime ~= -1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_WeekBoss.GetLeftTime = function(self)
  -- function num : 0_5
  return (self._data).leftTime
end

BM_WeekBoss.GetResetTime = function(self)
  -- function num : 0_6
  return (self._data).resetTime
end

BM_WeekBoss.GetNightmareTime = function(self)
  -- function num : 0_7
  return (self._data).nightmareTime
end

BM_WeekBoss.IsNightmareOpen = function(self)
  -- function num : 0_8
  do return (self._data).nightmareTime == -1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_WeekBoss.GetRedDotWithType = function(self, type)
  -- function num : 0_9
  return ((self._data).reddot)[type]
end

BM_WeekBoss.GetTalentLeftNumber = function(self)
  -- function num : 0_10
  return (self._data).leftTalentNumber
end

BM_WeekBoss.CosumeTalentLeftNumber = function(self, cosume)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if cosume <= (self._data).leftTalentNumber then
    (self._data).leftTalentNumber = (self._data).leftTalentNumber - cosume
    return true
  else
    return false
  end
end

BM_WeekBoss.GetUnlockTalentNode = function(self)
  -- function num : 0_12
  return (self._data).unlockedTalentNode
end

BM_WeekBoss.GetAllTalentNodes = function(self)
  -- function num : 0_13
  return (self._data).allTalentNodes
end

BM_WeekBoss.GetNodeStatus = function(self, nodeId)
  -- function num : 0_14 , upvalues : _ENV
  if not ((self._data).allTalentNodes)[nodeId] then
    return (self.NodeStatusType).Forbid
  end
  local result = (self.NodeStatusType).CanBeUnlock
  if ((self._data).unlockedTalentNode)[nodeId] then
    result = result | (self.NodeStatusType).HasBeenUnlocked
  end
  if ((self._data).unlockedTalentNode)[(((self._data).allTalentNodes)[nodeId]).conflictedNode] then
    result = result | (self.NodeStatusType).ConflictedHasBeenUnlock
  end
  if (self._data).leftTalentNumber < (((self._data).allTalentNodes)[nodeId]).unlockConsumptionTimes then
    result = result | (self.NodeStatusType).TimesNotEnough
  end
  local frontNode = (((self._data).allTalentNodes)[nodeId]).frontNode
  local frontList = {}
  local beforeNodeUnlock = false
  if frontNode ~= "-1" then
    frontList = (string.split)(frontNode, ";")
  else
    beforeNodeUnlock = true
  end
  local frontNodeList = {}
  for _,nodeId in ipairs(frontList) do
    if ((self._data).unlockedTalentNode)[tonumber(nodeId)] then
      beforeNodeUnlock = true
      break
    end
  end
  do
    if not beforeNodeUnlock then
      result = result | (self.NodeStatusType).BeforeNodeLock
    end
    return result
  end
end

BM_WeekBoss.GetLocalIntWithType = function(self, dataTable)
  -- function num : 0_15 , upvalues : _ENV, PARAM_PREFIX
  return (((CS.UnityEngine).PlayerPrefs).GetInt)((table.concat)({(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid, PARAM_PREFIX, dataTable.nameTxt}, "."), dataTable.default)
end

BM_WeekBoss.SetLocalIntWithName = function(self, nameTxt, value)
  -- function num : 0_16 , upvalues : _ENV, PARAM_PREFIX
  (((CS.UnityEngine).PlayerPrefs).SetInt)((table.concat)({(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid, PARAM_PREFIX, nameTxt}, "."), value)
end

BM_WeekBoss.IfShowRedDotInMainlinePanel = function(self)
  -- function num : 0_17 , upvalues : _ENV
  do return not self:IsOpen() or not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BossRush) or (not ((self._data).reddot)[(self.RedDotType).Achievement] and not ((self._data).reddot)[(self.RedDotType).Reward] and (self:GetLocalIntWithType((self.LocalParamData).ChallengeHasBeenClicked) ~= (((self.LocalParamData).ChallengeHasBeenClicked).showType).Show and self:GetRedDotWithType((self.RedDotType).Challenge))) end
  if not ((self._data).reddot)[(self.RedDotType).Achievement] then
    do return ((self._data).reddot)[(self.RedDotType).Reward] end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

BM_WeekBoss.GetLastWeekRankData = function(self)
  -- function num : 0_18
  if not (self._data).lastWeekRankData then
    return {}
  end
end

BM_WeekBoss.GetLastWeekRankId = function(self)
  -- function num : 0_19
  return (self._data).lastWeekRankId
end

BM_WeekBoss.GetLastWeekBossId = function(self)
  -- function num : 0_20
  return (self._data).lastWeekBossId
end

BM_WeekBoss.SetRedDotWithType = function(self, type, value)
  -- function num : 0_21
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self._data).reddot)[type] = value
end

BM_WeekBoss.GetSortedNodeIdList = function(self)
  -- function num : 0_22
  return (self._data).sortedNodeIdList
end

BM_WeekBoss.GetTeamAddtion = function(self)
  -- function num : 0_23
  if self:IsOpen() then
    return (self._data).teamaddtion
  end
end

return BM_WeekBoss

