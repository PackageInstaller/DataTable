-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/task/salltasks.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  if (table.nums)(protocol.majorTasks) == 0 then
    LogError("task", "服务器发了空的主线任务列表")
  end
  ;
  ((NekoData.DataManager).DM_Task):OnSAllTasks(protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

