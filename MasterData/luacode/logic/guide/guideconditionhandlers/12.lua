local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local tag1 = NekoData.BehaviorManager.BM_SBattleEnd:GetBattleId() == tonumber(params[1]) and NekoData.BehaviorManager.BM_SBattleEnd:GetBattleResult() == tonumber(params[2]) and NekoData.BehaviorManager.BM_SBattleEnd:GetFailTimes() == tonumber(params[3])
  local battleResult = NekoData.BehaviorManager.BM_Game:GetBattleResult()
  local tag2 = battleResult.battleId == tonumber(params[1]) and battleResult.result == tonumber(params[2]) and battleResult.failTime == tonumber(params[3])
  return tag1 or tag2
end

return func
