local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local tag1 = NekoData.BehaviorManager.BM_SBattleEnd:GetFailTimes() == tonumber(params[1])
  local battleResult = NekoData.BehaviorManager.BM_Game:GetBattleResult()
  local tag2 = battleResult and (battleResult.failTime == tonumber(params[1]) or battleResult.battleId == tonumber(params[2]))
  return tag1 or tag2
end

return func
