local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local bannerId = params[1]
  local status = tonumber(params[2]) == 1
  if bannerId then
    local open = NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(tonumber(params[1]))
    return open == status
  end
  return false
end

return func
