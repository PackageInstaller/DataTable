local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local tag = tonumber(params[1])
  local state = tonumber(params[2])
  if GlobalGameFSM then
    if tag == -1 then
      return GlobalGameFSM:GetLastState() == DataCommon.GameFSM[state]
    elseif tag == 0 then
      return GlobalGameFSM:GetCurrentState() == DataCommon.GameFSM[state]
    end
  else
    return false
  end
end

return func
