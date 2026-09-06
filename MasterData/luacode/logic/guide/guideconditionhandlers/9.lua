local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local taskID = tonumber(params[1])
  return NekoData.BehaviorManager.BM_Task:GetTask(taskID) and NekoData.BehaviorManager.BM_Task:GetTask(taskID):GetStatus() == tonumber(params[2])
end

return func
