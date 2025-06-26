-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/composites/selectorprobability.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Behavior_Status = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local SelectorProbability = class("SelectorProbability", Task)
SelectorProbability.Ctor = function(self, func)
  -- function num : 0_0 , upvalues : SelectorProbability
  ((SelectorProbability.super).Ctor)(self)
  self._index = 1
  self._tasks = {}
  self._randomFunction = func
end

SelectorProbability.AddTask = function(self, task)
  -- function num : 0_1 , upvalues : _ENV
  (table.insert)(self._tasks, task)
end

SelectorProbability.RandomChoice = function(self, t, i, j)
  -- function num : 0_2
  local totalWeight = 0
  for index = i, j do
    totalWeight = totalWeight + (t[index]):GetWeight()
  end
  local value = (self._randomFunction)(1, totalWeight)
  for index = i, j do
    value = value - (t[index]):GetWeight()
    if value <= 0 then
      return index
    end
  end
  return j
end

SelectorProbability.OnStart = function(self)
  -- function num : 0_3 , upvalues : SelectorProbability
  ((SelectorProbability.super).OnStart)(self)
  local j = 1
  for i = 1, #self._tasks do
    j = self:RandomChoice(self._tasks, i, #self._tasks)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

    -- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._tasks)[i] = (self._tasks)[j]
  end
  self._index = 1
end

SelectorProbability.OnUpdate = function(self, deltaTime)
  -- function num : 0_4 , upvalues : Behavior_Status, _ENV
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

SelectorProbability.SelfUpdate = function(self, deltaTime)
  -- function num : 0_5 , upvalues : Behavior_Status
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
      return Behavior_Status.Success
    else
      if status == Behavior_Status.Failure then
        task:OnEnd()
        task:SetStatus(Behavior_Status.Invalid)
        if self._index == #self._tasks then
          self._index = 1
          return Behavior_Status.Failure
        else
          self._index = self._index + 1
          return self:OnUpdate(0)
        end
      end
    end
    return Behavior_Status.Running
  else
    do
      do return Behavior_Status.Success end
    end
  end
end

SelectorProbability.GetCheckPoints = function(self)
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

return SelectorProbability

