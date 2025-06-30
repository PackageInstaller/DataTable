-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/utils/servergametimer.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ServerGameTimer = {}
local _tasks = {}
local _id = 0
local _servertime = 0
local _forecast = 0
local updating = false
local delay_remove_all = false
local delay_del, delay_add = nil, nil
ServerGameTimer.AddTask = function(delay, period, callbackFunction, args)
  -- function num : 0_0 , upvalues : _id, updating, delay_add, _tasks
  _id = _id + 1
  local task = {}
  task.delay = delay
  task.period = period
  task.callbackFunction = callbackFunction
  task.args = args
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

ServerGameTimer.RemoveAllTask = function()
  -- function num : 0_1 , upvalues : updating, delay_remove_all, _ENV, _tasks
  if updating then
    delay_remove_all = true
    for k,v in pairs(_tasks) do
      v.running = false
    end
    return 
  end
  for k,_ in pairs(_tasks) do
    _tasks[k] = nil
  end
end

ServerGameTimer.RemoveTask = function(taskId)
  -- function num : 0_2 , upvalues : _tasks, updating, delay_del
  if not taskId or not _tasks[taskId] then
    return 
  end
  if updating then
    if not delay_del then
      delay_del = {}
    end
    delay_del[#delay_del + 1] = taskId
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (_tasks[taskId]).running = false
    return 
  end
  _tasks[taskId] = nil
end

ServerGameTimer.GetServerTime = function()
  -- function num : 0_3 , upvalues : _servertime
  return _servertime
end

ServerGameTimer.GetServerTimeForecast = function()
  -- function num : 0_4 , upvalues : _servertime, _ENV, _forecast
  return _servertime + (math.tointeger)(_forecast * 1000 // 1)
end

ServerGameTimer.OnClientUpdate = function(unscaledDeltaTime)
  -- function num : 0_5 , upvalues : _forecast, updating, _ENV, _tasks, ServerGameTimer, delay_add, delay_del, delay_remove_all
  _forecast = _forecast + unscaledDeltaTime
  updating = true
  for tid,task in pairs(_tasks) do
    if task and task.running then
      task.delay = task.delay - unscaledDeltaTime
      while 1 do
        while 1 do
          if task.running and task.delay <= 0 then
            (task.callbackFunction)(task.args)
            if task.running then
              if task.period > 0 then
                task.delay = task.delay + task.period
                -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
        ;
        (ServerGameTimer.RemoveTask)(tid)
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

ServerGameTimer.OnServerUpdate = function(protocol)
  -- function num : 0_6 , upvalues : _forecast, _servertime
  _forecast = 0
  local deltaTime = protocol.time - _servertime
  _servertime = protocol.time
end

ServerGameTimer.GetDetailTimeStr = function(ms)
  -- function num : 0_7 , upvalues : _ENV
  if ms then
    local sec = ms // 1000
  end
  local lt = (os.date)("*t", sec)
  return (string.format)("%d-%02d-%02d %02d:%02d:%02d", lt.year, lt.month, lt.day, lt.hour, lt.min, lt.sec)
end

ServerGameTimer.GetTimeHourMinStr = function(ms)
  -- function num : 0_8 , upvalues : _ENV
  if ms then
    local sec = ms // 1000
  end
  local lt = (os.date)("*t", sec)
  return (string.format)("%02d:%02d", lt.hour, lt.min)
end

ServerGameTimer.GetTimeStr = function(ms)
  -- function num : 0_9 , upvalues : _ENV
  if ms then
    local sec1 = ms // 1000
  end
  local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1141)).msgTextID
  str = (TextManager.GetText)(str)
  str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", sec1))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", sec1))
  str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", sec1))
  return str
end

ServerGameTimer.GetDateForecast = function()
  -- function num : 0_10 , upvalues : _ENV, ServerGameTimer
  local timeZone = nil
  if SdkManager.IsOverseas then
    local channelName = (SdkManager.GetChannelName)()
    if channelName == "en" then
      timeZone = -25200
    else
      if channelName == "kr" then
        timeZone = 32400
      end
    end
  else
    do
      timeZone = 28800
      local date = (os.date)("!*t", ((ServerGameTimer.GetServerTimeForecast)() + timeZone * 1000) // 1000)
      return date
    end
  end
end

return ServerGameTimer

