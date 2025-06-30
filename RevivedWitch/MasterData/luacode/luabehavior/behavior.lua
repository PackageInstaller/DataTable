-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/behavior.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Behavior_Status = require("luabehavior.base.taskstatus")
local Behavior = class("Behavior")
Behavior.Ctor = function(self, behaviorName)
  -- function num : 0_0 , upvalues : Behavior_Status
  self._behaviorName = behaviorName
  self._root = nil
  self._totalIntegerTime = 0
  self._deltaTime = 0
  self._lastStatus = Behavior_Status.Invalid
end

Behavior.SetTree = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  self._root = (require("data.behavior." .. (string.gsub)((string.lower)(self._behaviorName), "/", ".")))(self)
end

Behavior.CheckPoint = function(self)
  -- function num : 0_2
  if self._root then
    return (self._root):GetCheckPoints()
  end
  return 0
end

Behavior.Exec = function(self, deltaTime)
  -- function num : 0_3 , upvalues : Behavior_Status, _ENV
  local status = (self._root):GetStatus()
  if status == Behavior_Status.Success or status == Behavior_Status.Failure then
    return true, status, deltaTime
  end
  self._deltaTime = self._deltaTime + deltaTime
  deltaTime = (math.floor)(self._deltaTime)
  self._deltaTime = self._deltaTime - deltaTime
  if self._deltaTime < 0 then
    self._deltaTime = 0
  end
  self._lastStatus = Behavior_Status.Running
  local checkPoint = (self._root):GetCheckPoints()
  local delta = (math.min)(checkPoint, deltaTime)
  deltaTime = deltaTime - delta
  self._lastStatus = self:SelfUpdate(delta)
  while self._lastStatus == Behavior_Status.Running and deltaTime > 0 do
    checkPoint = (self._root):GetCheckPoints()
    delta = (math.min)(checkPoint, deltaTime)
    deltaTime = deltaTime - delta
    self._lastStatus = self:SelfUpdate(delta)
  end
  do return (self._lastStatus == Behavior_Status.Running and self._lastStatus == Behavior_Status.Success) or self._lastStatus == Behavior_Status.Failure, self._lastStatus, deltaTime end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Behavior.Exec2 = function(self, deltaTime)
  -- function num : 0_4 , upvalues : Behavior_Status, _ENV
  local status = (self._root):GetStatus()
  if status == Behavior_Status.Success or status == Behavior_Status.Failure then
    return status
  end
  self._deltaTime = self._deltaTime + deltaTime
  deltaTime = (math.floor)(self._deltaTime)
  self._deltaTime = self._deltaTime - deltaTime
  if self._deltaTime < 0 then
    self._deltaTime = 0
  end
  self._lastStatus = Behavior_Status.Running
  local checkPoint = (self._root):GetCheckPoints()
  local delta = (math.min)(checkPoint, deltaTime)
  deltaTime = deltaTime - delta
  self._lastStatus = self:SelfUpdate(delta)
  while self._lastStatus == Behavior_Status.Running and deltaTime > 0 do
    checkPoint = (self._root):GetCheckPoints()
    delta = (math.min)(checkPoint, deltaTime)
    deltaTime = deltaTime - delta
    self._lastStatus = self:SelfUpdate(delta)
  end
  if self._lastStatus == Behavior_Status.Running then
    return self._lastStatus
  end
end

Behavior.Exec3 = function(self, deltaTime)
  -- function num : 0_5 , upvalues : _ENV, Behavior_Status
  self._deltaTime = self._deltaTime + deltaTime
  deltaTime = (math.floor)(self._deltaTime)
  self._deltaTime = self._deltaTime - deltaTime
  if self._deltaTime < 0 then
    self._deltaTime = 0
  end
  self._lastStatus = Behavior_Status.Running
  local checkPoint = (self._root):GetCheckPoints()
  local delta = (math.min)(checkPoint, deltaTime)
  deltaTime = deltaTime - delta
  self._lastStatus = self:SelfUpdate(delta)
  return self._lastStatus
end

Behavior.GetLastStatus = function(self)
  -- function num : 0_6 , upvalues : Behavior_Status
  if not self._root then
    return Behavior_Status.Failure
  end
  return self._lastStatus
end

Behavior.SelfUpdate = function(self, deltaTime)
  -- function num : 0_7 , upvalues : Behavior_Status
  self._totalIntegerTime = self._totalIntegerTime + deltaTime
  local status = (self._root):GetStatus()
  if status == Behavior_Status.Invalid then
    (self._root):OnStart()
    status = (self._root):SetStatus(Behavior_Status.Running)
  end
  status = (self._root):SetStatus((self._root):OnUpdate(deltaTime))
  if status == Behavior_Status.Success or status == Behavior_Status.Failure then
    (self._root):OnEnd()
    ;
    (self._root):SetStatus(Behavior_Status.Invalid)
  end
  return status
end

return Behavior

