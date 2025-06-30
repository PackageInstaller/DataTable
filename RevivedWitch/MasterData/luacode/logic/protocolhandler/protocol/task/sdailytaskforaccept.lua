-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/task/sdailytaskforaccept.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Task_Every) and (table.nums)(protocol.dailyTasks) == 0 then
    LogError("task", "服务器发了空的日常任务列表")
  end
  ;
  ((NekoData.DataManager).DM_Task):OnSDailyTaskForAccept(protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

