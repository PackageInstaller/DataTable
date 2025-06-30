-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/utils/gametimer.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GameTimer = {}
local _tasks = {}
local _id = 0
local updating = false
local delay_remove_all = false
local delay_del, delay_add, speed_task = nil, nil, nil
GameTimer.AddTask = function(delay, period, callbackFunction, args, useUnscaleTime)
  -- function num : 0_0 , upvalues : _id, updating, delay_add, _tasks
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

GameTimer.RemoveAllTask = function()
  -- function num : 0_1 , upvalues : updating, delay_remove_all, _ENV, _tasks
  if updating then
    delay_remove_all = true
    for k,v in pairs(_tasks) do
      v.running = false
    end
    return 
  end
  for k,v in pairs(_tasks) do
    _tasks[k] = nil
  end
end

GameTimer.RemoveTask = function(taskId)
  -- function num : 0_2 , upvalues : updating, delay_del, _tasks, delay_add
  if not taskId then
    return 
  end
  if updating then
    if not delay_del then
      delay_del = {}
    end
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    if _tasks[taskId] then
      (_tasks[taskId]).running = false
      delay_del[#delay_del + 1] = taskId
    end
    if delay_add and delay_add[taskId] then
      delay_add[taskId] = nil
    end
    return 
  end
  _tasks[taskId] = nil
end

GameTimer.OnUpdate = function(deltaTime, unscaledDeltaTime)
  -- function num : 0_3 , upvalues : updating, _ENV, _tasks, GameTimer, delay_add, delay_del, delay_remove_all
  updating = true
  for tid,task in pairs(_tasks) do
    if task and task.running then
      if task.useUnscaleTime then
        task.delay = task.delay - unscaledDeltaTime
      else
        task.delay = task.delay - deltaTime
      end
      while 1 do
        while 1 do
          if task.running and task.delay <= 0 then
            (task.callbackFunction)(task.args)
            if task.running then
              if task.period > 0 then
                task.delay = task.delay + task.period
                -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
        ;
        (GameTimer.RemoveTask)(tid)
      end
    end
  end
  if delay_add then
    for k,v in pairs(delay_add) do
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
    for k,_ in pairs(_tasks) do
      _tasks[k] = nil
    end
    delay_remove_all = false
  end
  updating = false
end

return GameTimer

