local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local unlock = tonumber(params[2]) == 1
  local funcId = tonumber(params[1])
  return NekoData.BehaviorManager.BM_Game:IsUnlockFunction(funcId)
end

return func
