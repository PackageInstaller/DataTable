local System = require("System.System")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BattleActionStatsUtil = require("Battle.DbgEngine.Stats.BattleActionStatsUtil")
local BattleFavorStatsMgr = System.NewClass("BattleFavorStatsMgr")

function BattleFavorStatsMgr:ctor(battleEngine, statsMgr)
  self.battleEngine = battleEngine
  self.statsMgr = statsMgr
end

function BattleFavorStatsMgr:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseCard, self.OnAfterUseCard, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.ConsumeEnergy, self.OnConsumeEnergy, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.ConsumeUltiEnergy, self.OnConsumeUltiEnergy, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.ConsumeKeeperEnergy, self.OnConsumeKeeperEnergy, self)
end

function BattleFavorStatsMgr:UnregisterCallbacks()
  self.battleEngine:UnregisterAllEventsByTarget(self)
end

function BattleFavorStatsMgr:GetGlobalStats()
  return self.statsMgr.globalStats
end

function BattleFavorStatsMgr:IsCmdCardForFavorStats(card)
  if not card then
    return false
  end
  return card:CardTypeMatch(bc.FavorStatsCmdCardTypes) == true
end

function BattleFavorStatsMgr:AddTeamScalar(statKey, value, camp)
  if not (statKey and value) or 0 == value then
    return false
  end
  if self.battleEngine:IsPVE() ~= true then
    return false
  end
  if camp and camp ~= bc.BattleCamp.Camp1 then
    return false
  end
  local globalStats = self:GetGlobalStats()
  globalStats[statKey] = (globalStats[statKey] or 0) + value
  local logStr = string.format("同调统计：队伍 %s += %s", statKey, value)
  self.battleEngine:LogBattleWithTab(logStr)
  return true
end

function BattleFavorStatsMgr:AddAwakerMap(roleUid, roleTid, statKey, value)
  local globalStats = self:GetGlobalStats()
  if type(globalStats[statKey]) ~= "table" then
    globalStats[statKey] = {}
  end
  globalStats[statKey][roleTid] = (globalStats[statKey][roleTid] or 0) + value
  local role = self.battleEngine:GetObj(roleUid)
  local roleStr = role and role:GetBattleLogName() or tostring(roleTid)
  local logStr = string.format("同调统计：%s %s += %s", roleStr, statKey, value)
  self.battleEngine:LogBattleWithTab(logStr)
end

function BattleFavorStatsMgr:AddAwakerStatsFiltered(roleUid, statKey, value)
  if not (statKey and value) or 0 == value then
    return false, "drop"
  end
  if self.battleEngine:IsPVE() ~= true then
    return false, "drop"
  end
  if not roleUid or 0 == roleUid then
    return false, "fallback"
  end
  local role = self.battleEngine:GetObj(roleUid)
  if not role then
    return false, "fallback"
  end
  if role:GetCamp() ~= bc.BattleCamp.Camp1 then
    return false, "drop"
  end
  local roleTid = BattleActionStatsUtil.GetStatsRoleId(self.battleEngine, roleUid)
  if not roleTid or 0 == roleTid or 1 == roleTid then
    return false, "fallback"
  end
  self:AddAwakerMap(roleUid, roleTid, statKey, value)
  return true
end

function BattleFavorStatsMgr:Add4FavorStats(card, eventData, value, awakerKey, autoAwakerKey, teamKey, autoTeamKey)
  if not (eventData and value) or 0 == value then
    return
  end
  if self.battleEngine:IsPVE() ~= true then
    return
  end
  local castRoleUid = eventData.castRoleUid
  local camp = eventData.camp or card and card:GetCamp()
  local isAuto = true == eventData.isAutoOp
  if self:IsCmdCardForFavorStats(card) then
    local ok, why = self:AddAwakerStatsFiltered(castRoleUid, awakerKey, value)
    if ok then
      if isAuto then
        self:AddAwakerStatsFiltered(castRoleUid, autoAwakerKey, value)
      end
    elseif "fallback" == why and self:AddTeamScalar(teamKey, value, camp) and isAuto then
      self:AddTeamScalar(autoTeamKey, value, camp)
    end
    return
  end
  if self:AddTeamScalar(teamKey, value, camp) and isAuto then
    self:AddTeamScalar(autoTeamKey, value, camp)
  end
end

function BattleFavorStatsMgr:AddUltiEnergyStats(roleUid, cost, isAuto)
  if not cost or cost <= 0 then
    return
  end
  local ok = self:AddAwakerStatsFiltered(roleUid, bc.StatsKey.AwakerConsumeUltiEnergy, cost)
  if not ok then
    return
  end
  if isAuto then
    self:AddAwakerStatsFiltered(roleUid, bc.StatsKey.AutoAwakerConsumeUltiEnergy, cost)
  end
end

function BattleFavorStatsMgr:AddKeeperEnergyStats(cost, camp, isAuto)
  if not cost or cost <= 0 then
    return
  end
  if not self:AddTeamScalar(bc.StatsKey.ConsumeKeeperEnergy, cost, camp) then
    return
  end
  if isAuto then
    self:AddTeamScalar(bc.StatsKey.AutoConsumeKeeperEnergy, cost, camp)
  end
end

function BattleFavorStatsMgr:OnAfterUseCard(eventData)
  if not eventData then
    return
  end
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  self:Add4FavorStats(card, eventData, 1, bc.StatsKey.AwakerCmdCardUsedCount, bc.StatsKey.AutoAwakerCmdCardUsedCount, bc.StatsKey.NonCmdCardUsedCount, bc.StatsKey.AutoNonCmdCardUsedCount)
end

function BattleFavorStatsMgr:OnConsumeEnergy(eventData)
  if not eventData or eventData.cardUid == nil then
    return
  end
  local cost = eventData.realCost
  if not cost or cost <= 0 then
    return
  end
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  self:Add4FavorStats(card, eventData, cost, bc.StatsKey.AwakerConsumeEnergy, bc.StatsKey.AutoAwakerConsumeEnergy, bc.StatsKey.NonCmdConsumeEnergy, bc.StatsKey.AutoNonCmdConsumeEnergy)
end

function BattleFavorStatsMgr:OnConsumeUltiEnergy(eventData)
  if not eventData then
    return
  end
  self:AddUltiEnergyStats(eventData.castRoleUid, eventData.realCost, eventData.isAutoOp == true)
end

function BattleFavorStatsMgr:OnConsumeKeeperEnergy(eventData)
  if not eventData then
    return
  end
  self:AddKeeperEnergyStats(eventData.realCost, eventData.camp, eventData.isAutoOp == true)
end

return BattleFavorStatsMgr
