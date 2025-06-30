-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/9.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local taskID = tonumber(params[1])
  do return not ((NekoData.BehaviorManager).BM_Task):GetTask(taskID) or (((NekoData.BehaviorManager).BM_Task):GetTask(taskID)):GetStatus() == tonumber(params[2]) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return func

