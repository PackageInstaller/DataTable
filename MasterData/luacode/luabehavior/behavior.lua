local Behavior_Status = require("luabehavior.base.taskstatus")
local Behavior = class("Behavior")

function Behavior:Ctor(behaviorName)
  self._behaviorName = behaviorName
  self._root = nil
  self._totalIntegerTime = 0
  self._deltaTime = 0
  self._lastStatus = Behavior_Status.Invalid
end

function Behavior:SetTree(data)
  self._root = require("data.behavior." .. string.gsub(string.lower(self._behaviorName), "/", "."))(self)
end

function Behavior:CheckPoint()
  if self._root then
    return self._root:GetCheckPoints()
  end
  return 0
end

function Behavior:Exec(deltaTime)
  local status = self._root:GetStatus()
  if status == Behavior_Status.Success or status == Behavior_Status.Failure then
    return true, status, deltaTime
  end
  self._deltaTime = self._deltaTime + deltaTime
  deltaTime = math.floor(self._deltaTime)
  self._deltaTime = self._deltaTime - deltaTime
  if self._deltaTime < 0 then
    self._deltaTime = 0
  end
  self._lastStatus = Behavior_Status.Running
  local checkPoint = self._root:GetCheckPoints()
  local delta = math.min(checkPoint, deltaTime)
  deltaTime = deltaTime - delta
  self._lastStatus = self:SelfUpdate(delta)
  if self._lastStatus == Behavior_Status.Running then
    while 0 < deltaTime do
      checkPoint = self._root:GetCheckPoints()
      delta = math.min(checkPoint, deltaTime)
      deltaTime = deltaTime - delta
      self._lastStatus = self:SelfUpdate(delta)
      if self._lastStatus ~= Behavior_Status.Running then
        break
      end
    end
  end
  return self._lastStatus == Behavior_Status.Success or self._lastStatus == Behavior_Status.Failure, self._lastStatus, deltaTime
end

function Behavior:Exec2(deltaTime)
  local status = self._root:GetStatus()
  if status == Behavior_Status.Success or status == Behavior_Status.Failure then
    return status
  end
  self._deltaTime = self._deltaTime + deltaTime
  deltaTime = math.floor(self._deltaTime)
  self._deltaTime = self._deltaTime - deltaTime
  if self._deltaTime < 0 then
    self._deltaTime = 0
  end
  self._lastStatus = Behavior_Status.Running
  local checkPoint = self._root:GetCheckPoints()
  local delta = math.min(checkPoint, deltaTime)
  deltaTime = deltaTime - delta
  self._lastStatus = self:SelfUpdate(delta)
  if self._lastStatus == Behavior_Status.Running then
    while 0 < deltaTime do
      checkPoint = self._root:GetCheckPoints()
      delta = math.min(checkPoint, deltaTime)
      deltaTime = deltaTime - delta
      self._lastStatus = self:SelfUpdate(delta)
      if self._lastStatus ~= Behavior_Status.Running then
        break
      end
    end
  end
  return self._lastStatus
end

function Behavior:Exec3(deltaTime)
  self._deltaTime = self._deltaTime + deltaTime
  deltaTime = math.floor(self._deltaTime)
  self._deltaTime = self._deltaTime - deltaTime
  if self._deltaTime < 0 then
    self._deltaTime = 0
  end
  self._lastStatus = Behavior_Status.Running
  local checkPoint = self._root:GetCheckPoints()
  local delta = math.min(checkPoint, deltaTime)
  deltaTime = deltaTime - delta
  self._lastStatus = self:SelfUpdate(delta)
  return self._lastStatus
end

function Behavior:GetLastStatus()
  if not self._root then
    return Behavior_Status.Failure
  end
  return self._lastStatus
end

function Behavior:SelfUpdate(deltaTime)
  self._totalIntegerTime = self._totalIntegerTime + deltaTime
  local status = self._root:GetStatus()
  if status == Behavior_Status.Invalid then
    self._root:OnStart()
    status = self._root:SetStatus(Behavior_Status.Running)
  end
  status = self._root:SetStatus(self._root:OnUpdate(deltaTime))
  if status == Behavior_Status.Success or status == Behavior_Status.Failure then
    self._root:OnEnd()
    self._root:SetStatus(Behavior_Status.Invalid)
  end
  return status
end

return Behavior
