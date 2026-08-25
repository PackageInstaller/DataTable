local System = require("System.System")
local BattleScheduler, _ = System.NewClass("BattleScheduler")

function BattleScheduler:ctor(battleEngine)
  self.battleEngine = battleEngine
  self:Reset()
end

function BattleScheduler:Reset()
  self.schedulerList = {}
  self.passTime = 0
  self._genUid = 0
  if self._timerKey then
    self._timerKey = nil
  end
end

function BattleScheduler:Tick(deltaTime)
  self.passTime = self.passTime + deltaTime
  self:TickCheckCall()
end

function BattleScheduler:GetPassTime()
  return self.passTime
end

function BattleScheduler:AddTimer(key, delay, callback)
  self._timerKey = self._timerKey or {}
  if self._timerKey[key] then
    self:RemoveTimer(key)
  end
  local schedulerId = self:PerformWithDelay(delay, function()
    self._timerKey[key] = nil
    callback()
  end, self)
  self._timerKey[key] = schedulerId
end

function BattleScheduler:RepeatFunc(key, delay)
  local cb = self._timerKey[key]
  if cb then
    cb()
    self:PerformWithDelay(delay, function()
      self:RepeatFunc(key, delay)
    end, self)
  end
end

function BattleScheduler:AddRepeatTimer(key, delay, callback)
  self._timerKey = self._timerKey or {}
  self._timerKey[key] = callback
  self:PerformWithDelay(delay, function()
    self:RepeatFunc(key, delay)
  end, self)
end

function BattleScheduler:HasTimer(key)
  return self._timerKey and self._timerKey[key] ~= nil
end

function BattleScheduler:RemoveTimer(key)
  if self._timerKey then
    self:UnperformWithDelay(self._timerKey[key])
    self._timerKey[key] = nil
  end
end

function BattleScheduler:PerformWithDelay(delayTime, callback, target)
  self._genUid = self._genUid + 1
  local callTime = self.passTime + delayTime
  local schedulerData = {
    schedulerId = self._genUid,
    callTime = callTime,
    callback = callback,
    target = target,
    isDeleted = false
  }
  table.insert(self.schedulerList, schedulerData)
  return schedulerData.schedulerId
end

function BattleScheduler:UnperformWithDelay(schedulerId)
  for index = 1, #self.schedulerList do
    local schedulerData = self.schedulerList[index]
    if schedulerData.schedulerId == schedulerId then
      schedulerData.isDeleted = true
    end
  end
end

function BattleScheduler:UnperformWithAllDelaysByTarget(target)
  for index = 1, #self.schedulerList do
    local schedulerData = self.schedulerList[index]
    if schedulerData.target == target then
      schedulerData.isDeleted = true
    end
  end
end

function BattleScheduler:TickCheckCall()
  for index = 1, #self.schedulerList do
    local schedulerData = self.schedulerList[index]
    if not schedulerData.isDeleted and schedulerData.callTime <= self.passTime then
      schedulerData.isDeleted = true
      schedulerData.callback()
    end
  end
  for index = #self.schedulerList, 1, -1 do
    local schedulerData = self.schedulerList[index]
    if schedulerData.isDeleted then
      table.remove(self.schedulerList, index)
    end
  end
end

function BattleScheduler:Dispose()
  for index = #self.schedulerList, 1, -1 do
    self.schedulerList[index] = nil
  end
  self.schedulerList = {}
  self.battleEngine = nil
end

return BattleScheduler
