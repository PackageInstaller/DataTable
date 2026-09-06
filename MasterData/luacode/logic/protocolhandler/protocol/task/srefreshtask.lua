local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")

local function diff(lhs, rhs)
  local result = {}
  for i, v in ipairs(lhs) do
    if v.current ~= rhs[i].current then
      result[#result + 1] = {
        id = v.topmsgid,
        v.current,
        rhs[i].current,
        v.total
      }
    end
  end
  return result
end

local function max(lhs)
  local result = {}
  for i, v in ipairs(lhs) do
    result[#result + 1] = {
      id = v.topmsgid,
      v.current,
      v.total,
      v.total
    }
  end
  return result
end

local function p1(protocol)
  local prev = clone(NekoData.BehaviorManager.BM_Task:GetTask(protocol.taskinfo.taskid))
  if not prev then
    LogErrorFormat("task", "refresh unaccepted task %d", protocol.taskinfo.taskid)
    return
  end
  NekoData.DataManager.DM_Task:OnSRefreshTask(protocol)
  if prev:GetType() == 1 or prev:GetType() == 2 or prev:GetType() == 7 then
    local post = clone(NekoData.BehaviorManager.BM_Task:GetTask(protocol.taskinfo.taskid))
    local params
    local prev_progress = prev:GetProgress()
    if post then
      local post_progress = post:GetProgress()
      params = diff(prev_progress, post_progress)
    else
      params = max(prev_progress)
    end
    if #params == 0 then
      if protocol.taskinfo.taskstatus == 3 then
        NekoData.BehaviorManager.BM_Message:SendTopMessage(200005, {
          prev:GetName()
        }, true)
      end
    else
      for _, v in ipairs(params) do
        NekoData.BehaviorManager.BM_Message:SendTopMessage(v.id, v, prev:GetStatus() == 3)
      end
    end
  end
  if prev:GetType() == 4 and prev:GetStatus() == Status.PROCESSING and protocol.taskinfo.taskstatus == Status.FINISHED then
    NekoData.BehaviorManager.BM_Message:SendTopMessage(200033, {
      prev:GetName()
    }, true)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
