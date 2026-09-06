local CActivityTasks = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")

local function p1(protocol)
  if protocol.activityID ~= CActivityTasks.ANNIVERSARY then
    NekoData.DataManager.DM_ActivityTasks:OnSActivityTasks(protocol)
    if protocol.refresh == 1 then
      LuaNotificationCenter.PostNotification(Common.n_OnSActivityTasks, nil, protocol)
    end
  else
    local str
    for _, v in ipairs(protocol.activityTasks) do
      if not str then
        str = "{"
      else
        str = str .. ", "
      end
      local conditionStr
      for i, value in ipairs(v.conditions) do
        if not conditionStr then
          conditionStr = "{"
        else
          conditionStr = conditionStr .. ", "
        end
        conditionStr = conditionStr .. "[" .. i .. "] = {value = " .. value.value .. ", destValue = " .. value.destValue .. "}"
      end
      if conditionStr then
        conditionStr = conditionStr .. "}"
      else
        conditionStr = "{}"
      end
      str = str .. "[" .. v.taskid .. "] = {taskstatus = " .. v.taskstatus .. ", condition = " .. conditionStr .. "}"
    end
    str = str and str .. "}"
    LogInfoFormat("sactivitytasks", "--- activityTasks = %s ---", str)
    NekoData.DataManager.DM_Anniversary:OnSActivityTasks(protocol)
    LuaNotificationCenter.PostNotification(Common.n_RefreshAnniversaryDailyTaskList, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
