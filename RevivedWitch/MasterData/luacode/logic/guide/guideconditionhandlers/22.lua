-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/22.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local activityID = tonumber(params[1])
  local taskId = tonumber(params[2])
  local op = tonumber(params[3])
  local status = tonumber(params[4])
  local remoteTaskData = ((NekoData.BehaviorManager).BM_ActivityTasks):GetTasks(activityID)
  if remoteTaskData then
    local task = remoteTaskData[taskId]
    -- DECOMPILER ERROR at PC32: Unhandled construct in 'MakeBoolean' P1

    if task and task:GetStatus() == status then
      do return op ~= -1 end
      -- DECOMPILER ERROR at PC44: Unhandled construct in 'MakeBoolean' P1

      if task and task:GetStatus() ~= status then
        do
          do return op ~= 0 end
          do return false end
          -- DECOMPILER ERROR: 6 unprocessed JMP targets
        end
      end
    end
  end
end

return func

