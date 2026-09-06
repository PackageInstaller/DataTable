local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local guideID = tonumber(params[1])
  local value = tonumber(params[2])
  if value == 0 then
    return not NekoData.BehaviorManager.BM_Guide:HasFinished(guideID)
  elseif value == 1 then
    return NekoData.BehaviorManager.BM_Guide:HasFinished(guideID)
  end
end

return func
