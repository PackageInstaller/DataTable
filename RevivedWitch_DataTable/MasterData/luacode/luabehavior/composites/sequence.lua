-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/composites/sequence.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Behavior_Status = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local Sequence = class("Sequence", Task)
Sequence.Ctor = function(self)
  -- function num : 0_0 , upvalues : Sequence
  ((Sequence.super).Ctor)(self)
  self._index = 1
  self._tasks = {}
end

Sequence.AddTask = function(self, task)
  -- function num : 0_1 , upvalues : _ENV
  (table.insert)(self._tasks, task)
end

Sequence.OnStart = function(self)
  -- function num : 0_2 , upvalues : Sequence
  ((Sequence.super).OnStart)(self)
  self._index = 1
end

Sequence.OnUpdate = function(self, deltaTime)
  -- function num : 0_3 , upvalues : Behavior_Status, _ENV
  local selfStatus = Behavior_Status.Running
  local checkTime = self:GetCheckPoints()
  local delta = (math.min)(checkTime, deltaTime)
  deltaTime = deltaTime - delta
  selfStatus = self:SelfUpdate(delta)
  while selfStatus == Behavior_Status.Running and deltaTime > 0 do
    checkTime = self:GetCheckPoints()
    delta = (math.min)(checkTime, deltaTime)
    deltaTime = deltaTime - delta
    selfStatus = self:SelfUpdate(delta)
  end
  if selfStatus == Behavior_Status.Running then
    return selfStatus
  end
end

Sequence.SelfUpdate = function(self, deltaTime)
  -- function num : 0_4 , upvalues : Behavior_Status
  if #self._tasks > 0 then
    local task = (self._tasks)[self._index]
    if task:GetStatus() == Behavior_Status.Invalid then
      task:OnStart()
      task:SetStatus(Behavior_Status.Running)
    end
    local status = task:SetStatus(task:OnUpdate(deltaTime))
    if status == Behavior_Status.Success then
      task:OnEnd()
      task:SetStatus(Behavior_Status.Invalid)
      if self._index == #self._tasks then
        self._index = 1
        return Behavior_Status.Success
      else
        self._index = self._index + 1
        return self:SelfUpdate(0)
      end
    else
      if status == Behavior_Status.Failure then
        self._index = 1
        task:OnEnd()
        task:SetStatus(Behavior_Status.Invalid)
        return Behavior_Status.Failure
      end
    end
    return Behavior_Status.Running
  else
    do
      do return Behavior_Status.Success end
    end
  end
end

Sequence.OnEnd = function(self)
  -- function num : 0_5 , upvalues : Sequence, Behavior_Status
  ((Sequence.super).OnEnd)(self)
  local task = (self._tasks)[self._index]
  if task and task:GetStatus() ~= Behavior_Status.Invalid then
    task:OnEnd()
    task:SetStatus(Behavior_Status.Invalid)
  end
end

Sequence.GetCheckPoints = function(self)
  -- function num : 0_6 , upvalues : Behavior_Status
  if self._status == Behavior_Status.Invalid then
    return 0
  else
    if #self._tasks > 0 then
      return ((self._tasks)[self._index]):GetCheckPoints()
    else
      return 0
    end
  end
end

return Sequence

