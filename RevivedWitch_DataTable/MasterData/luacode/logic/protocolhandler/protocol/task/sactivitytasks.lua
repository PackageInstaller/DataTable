-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/task/sactivitytasks.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CActivityTasks = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : CActivityTasks, _ENV
  if protocol.activityID ~= CActivityTasks.ANNIVERSARY then
    ((NekoData.DataManager).DM_ActivityTasks):OnSActivityTasks(protocol)
    if protocol.refresh == 1 then
      (LuaNotificationCenter.PostNotification)(Common.n_OnSActivityTasks, nil, protocol)
    end
  else
    local str = nil
    for _,v in ipairs(protocol.activityTasks) do
      if not str then
        str = "{"
      else
        str = str .. ", "
      end
      local conditionStr = nil
      for i,value in ipairs(v.conditions) do
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
    if str then
      str = str .. "}"
    end
    LogInfoFormat("sactivitytasks", "--- activityTasks = %s ---", str)
    ;
    ((NekoData.DataManager).DM_Anniversary):OnSActivityTasks(protocol)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshAnniversaryDailyTaskList, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

