local GameTimer = {}
local _tasks = {}
local _id = 0
local updating = false
local delay_remove_all = false
local delay_del, delay_add, speed_task

function GameTimer.AddTask(delay, period, callbackFunction, args, useUnscaleTime)
  _id = _id + 1
  local task = {}
  task.delay = delay
  task.period = period
  task.callbackFunction = callbackFunction
  task.args = args
  task.useUnscaleTime = useUnscaleTime or false
  task.running = true
  if updating then
    if not delay_add then
      delay_add = {}
    end
    delay_add[_id] = task
    return _id
  end
  _tasks[_id] = task
  return _id
end

function GameTimer.RemoveAllTask()
  if updating then
    delay_remove_all = true
    for k, v in pairs(_tasks) do
      v.running = false
    end
    return
  end
  for k, v in pairs(_tasks) do
    _tasks[k] = nil
  end
end

function GameTimer.RemoveTask(taskId)
  if not taskId then
    return
  end
  if updating then
    if not delay_del then
      delay_del = {}
    end
    if _tasks[taskId] then
      _tasks[taskId].running = false
      delay_del[#delay_del + 1] = taskId
    end
    if delay_add and delay_add[taskId] then
      delay_add[taskId] = nil
    end
    return
  end
  _tasks[taskId] = nil
end

function GameTimer.OnUpdate(deltaTime, unscaledDeltaTime)
  updating = true
  for tid, task in pairs(_tasks) do
    if task and task.running then
      if task.useUnscaleTime then
        task.delay = task.delay - unscaledDeltaTime
      else
        task.delay = task.delay - deltaTime
      end
      while task.running and task.delay <= 0 do
        task.callbackFunction(task.args)
        if task.running then
          if 0 < task.period then
            task.delay = task.delay + task.period
          else
            GameTimer.RemoveTask(tid)
          end
        end
      end
    end
  end
  if delay_add then
    for k, v in pairs(delay_add) do
      _tasks[k] = v
      delay_add[k] = nil
    end
    delay_add = nil
  end
  if delay_del then
    for i = 1, #delay_del do
      _tasks[delay_del[i]] = nil
    end
    delay_del = nil
  end
  if delay_remove_all then
    for k, _ in pairs(_tasks) do
      _tasks[k] = nil
    end
    delay_remove_all = false
  end
  updating = false
end

return GameTimer
