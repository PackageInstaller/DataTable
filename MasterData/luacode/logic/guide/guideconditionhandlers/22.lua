local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local activityID = tonumber(params[1])
  local taskId = tonumber(params[2])
  local op = tonumber(params[3])
  local status = tonumber(params[4])
  local remoteTaskData = NekoData.BehaviorManager.BM_ActivityTasks:GetTasks(activityID)
  if remoteTaskData then
    local task = remoteTaskData[taskId]
    if op == -1 then
      return task and task:GetStatus() ~= status
    elseif op == 0 then
      return task and task:GetStatus() == status
    end
  end
  return false
end

return func
