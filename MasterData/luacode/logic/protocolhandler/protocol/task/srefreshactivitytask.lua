local CActivityTasks = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")

local function p1(protocol)
  if protocol.activityID ~= CActivityTasks.ANNIVERSARY then
    NekoData.DataManager.DM_ActivityTasks:OnSRefreshActivityTask(protocol)
  else
    local conditionStr = ""
    for i, value in ipairs(protocol.taskinfo.conditions) do
      if conditionStr == "" then
        conditionStr = conditionStr .. "{"
      else
        conditionStr = conditionStr .. ", "
      end
      conditionStr = conditionStr .. "[" .. i .. "] = {value = " .. value.value .. ", destValue = " .. value.destValue .. "}"
    end
    if conditionStr ~= "" then
      conditionStr = conditionStr .. "}"
    end
    local str = "[" .. protocol.taskinfo.taskid .. "] = {taskstatus = " .. protocol.taskinfo.taskstatus .. ", condition = " .. conditionStr .. "}"
    LogErrorFormat("srefreshactivitytask", "--- activityTasks = %s ---", str)
    NekoData.DataManager.DM_Anniversary:OnSRefreshActivityTask(protocol)
  end
  LuaNotificationCenter.PostNotification(Common.n_OnSRefreshActivityTask, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
