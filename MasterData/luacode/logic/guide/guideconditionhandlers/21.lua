local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local level = tonumber(params[1])
  return NekoData.BehaviorManager.BM_Firefly:GetLevel() == level
end

return func
