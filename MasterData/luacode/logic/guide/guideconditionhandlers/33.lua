local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local zoneId = NekoData.BehaviorManager.BM_Game:GetNextFloorId()
  return zoneId and zoneId == tonumber(params[1])
end

return func
