-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/task/srefreshactivitytask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CActivityTasks = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : CActivityTasks, _ENV
  if protocol.activityID ~= CActivityTasks.ANNIVERSARY then
    ((NekoData.DataManager).DM_ActivityTasks):OnSRefreshActivityTask(protocol)
  else
    local conditionStr = ""
    for i,value in ipairs((protocol.taskinfo).conditions) do
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
    local str = "[" .. (protocol.taskinfo).taskid .. "] = {taskstatus = " .. (protocol.taskinfo).taskstatus .. ", condition = " .. conditionStr .. "}"
    LogErrorFormat("srefreshactivitytask", "--- activityTasks = %s ---", str)
    ;
    ((NekoData.DataManager).DM_Anniversary):OnSRefreshActivityTask(protocol)
  end
  do
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnSRefreshActivityTask, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

