local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local lastFloorId = tonumber(params[1])
  return NekoData.BehaviorManager.BM_Game:GetLastFloorId() == lastFloorId
end

return func
