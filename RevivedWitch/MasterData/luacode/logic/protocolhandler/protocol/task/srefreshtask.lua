-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/task/srefreshtask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local diff = function(lhs, rhs)
  -- function num : 0_0 , upvalues : _ENV
  local result = {}
  for i,v in ipairs(lhs) do
    if v.current ~= (rhs[i]).current then
      result[#result + 1] = {v.current, (rhs[i]).current, v.total; id = v.topmsgid}
    end
  end
  return result
end

local max = function(lhs)
  -- function num : 0_1 , upvalues : _ENV
  local result = {}
  for i,v in ipairs(lhs) do
    result[#result + 1] = {v.current, v.total, v.total; id = v.topmsgid}
  end
  return result
end

local p1 = function(protocol)
  -- function num : 0_2 , upvalues : _ENV, diff, max, Status
  local prev = clone(((NekoData.BehaviorManager).BM_Task):GetTask((protocol.taskinfo).taskid))
  if not prev then
    LogErrorFormat("task", "refresh unaccepted task %d", (protocol.taskinfo).taskid)
    return 
  end
  ;
  ((NekoData.DataManager).DM_Task):OnSRefreshTask(protocol)
  if prev:GetType() == 1 or prev:GetType() == 2 or prev:GetType() == 7 then
    local post = (clone(((NekoData.BehaviorManager).BM_Task):GetTask((protocol.taskinfo).taskid)))
    -- DECOMPILER ERROR at PC45: Overwrote pending register: R3 in 'AssignReg'

    local params = .end
    local prev_progress = prev:GetProgress()
    if post then
      local post_progress = post:GetProgress()
      params = diff(prev_progress, post_progress)
    else
      do
        params = max(prev_progress)
        -- DECOMPILER ERROR at PC79: Unhandled construct in 'MakeBoolean' P1

        if #params == 0 and (protocol.taskinfo).taskstatus == 3 then
          ((NekoData.BehaviorManager).BM_Message):SendTopMessage(200005, {prev:GetName()}, true)
        end
        for _,v in ipairs(params) do
          ((NekoData.BehaviorManager).BM_Message):SendTopMessage(v.id, v, prev:GetStatus() == 3)
        end
        if prev:GetType() == 4 and prev:GetStatus() == Status.PROCESSING and (protocol.taskinfo).taskstatus == Status.FINISHED then
          ((NekoData.BehaviorManager).BM_Message):SendTopMessage(200033, {prev:GetName()}, true)
        end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_3
end

return {p1, p2}

