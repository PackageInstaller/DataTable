local ServerGameTimer = {}
local _tasks = {}
local _id = 0
local _servertime = 0
local _forecast = 0
local updating = false
local delay_remove_all = false
local delay_del, delay_add

function ServerGameTimer.AddTask(delay, period, callbackFunction, args)
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

function ServerGameTimer.RemoveAllTask()
  if updating then
    delay_remove_all = true
    for k, v in pairs(_tasks) do
      v.running = false
    end
    return
  end
  for k, _ in pairs(_tasks) do
    _tasks[k] = nil
  end
end

function ServerGameTimer.RemoveTask(taskId)
  if not taskId or not _tasks[taskId] then
    return
  end
  if updating then
    if not delay_del then
      delay_del = {}
    end
    delay_del[#delay_del + 1] = taskId
    _tasks[taskId].running = false
    return
  end
  _tasks[taskId] = nil
end

function ServerGameTimer.GetServerTime()
  return _servertime
end

function ServerGameTimer.GetServerTimeForecast()
  return _servertime + math.tointeger(_forecast * 1000 // 1)
end

function ServerGameTimer.OnClientUpdate(unscaledDeltaTime)
  _forecast = _forecast + unscaledDeltaTime
  updating = true
  for tid, task in pairs(_tasks) do
    if task and task.running then
      task.delay = task.delay - unscaledDeltaTime
      while task.running and task.delay <= 0 do
        task.callbackFunction(task.args)
        if task.running then
          if 0 < task.period then
            task.delay = task.delay + task.period
          else
            ServerGameTimer.RemoveTask(tid)
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

function ServerGameTimer.OnServerUpdate(protocol)
  _forecast = 0
  local deltaTime = protocol.time - _servertime
  _servertime = protocol.time
end

function ServerGameTimer.GetDetailTimeStr(ms)
  local sec = ms and ms // 1000
  local lt = os.date("*t", sec)
  return string.format("%d-%02d-%02d %02d:%02d:%02d", lt.year, lt.month, lt.day, lt.hour, lt.min, lt.sec)
end

function ServerGameTimer.GetTimeHourMinStr(ms)
  local sec = ms and ms // 1000
  local lt = os.date("*t", sec)
  return string.format("%02d:%02d", lt.hour, lt.min)
end

function ServerGameTimer.GetTimeStr(ms)
  local sec1 = ms and ms // 1000
  local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1141).msgTextID
  str = TextManager.GetText(str)
  str = string.gsub(str, "%$parameter1%$", os.date("!%H", sec1))
  str = string.gsub(str, "%$parameter2%$", os.date("!%M", sec1))
  str = string.gsub(str, "%$parameter3%$", os.date("!%S", sec1))
  return str
end

function ServerGameTimer.GetDateForecast()
  local timeZone
  if SdkManager.IsOverseas then
    local channelName = SdkManager.GetChannelName()
    if channelName == "en" then
      timeZone = -25200
    elseif channelName == "kr" then
      timeZone = 32400
    end
  else
    timeZone = 28800
  end
  local date = os.date("!*t", (ServerGameTimer.GetServerTimeForecast() + timeZone * 1000) // 1000)
  return date
end

return ServerGameTimer
