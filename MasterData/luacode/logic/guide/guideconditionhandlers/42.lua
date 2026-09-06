local function func(conditionInfo)
  local params = conditionInfo.parm
  
  return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):GetLastBattleResult() == tonumber(params[1])
end

return func
