-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/composites/ifelse.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Behavior_Status = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local IfElse = class("IfElse", Task)
IfElse.Ctor = function(self)
  -- function num : 0_0 , upvalues : IfElse
  ((IfElse.super).Ctor)(self)
  self._index = 1
  self._tasks = {}
end

IfElse.AddTask = function(self, condition, trueCase, falseCase)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self._tasks)[1] = condition
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._tasks)[2] = trueCase
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._tasks)[3] = falseCase
end

IfElse.OnStart = function(self)
  -- function num : 0_2
  self._index = 1
end

IfElse.OnUpdate = function(self, deltaTime)
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

IfElse.SelfUpdate = function(self, deltaTime)
  -- function num : 0_4
  if self._index == 1 then
    return self:OnUpdateCondition(deltaTime)
  else
    if self._index == 2 then
      return self:OnUpdateTrueCase(deltaTime)
    else
      if self._index == 3 then
        return self:OnUpdateFalseCase(deltaTime)
      end
    end
  end
end

IfElse.OnEnd = function(self)
  -- function num : 0_5 , upvalues : IfElse, Behavior_Status
  ((IfElse.super).OnEnd)(self)
  if self._index == 1 then
    ((self._tasks)[1]):OnEnd()
    ;
    ((self._tasks)[1]):SetStatus(Behavior_Status.Invalid)
  else
    if self._index == 2 and ((self._tasks)[2]):GetStatus() ~= Behavior_Status.Invalid then
      ((self._tasks)[2]):OnEnd()
      ;
      ((self._tasks)[2]):SetStatus(Behavior_Status.Invalid)
    else
      if self._index == 3 and ((self._tasks)[3]):GetStatus() ~= Behavior_Status.Invalid then
        ((self._tasks)[3]):OnEnd()
        ;
        ((self._tasks)[3]):SetStatus(Behavior_Status.Invalid)
      end
    end
  end
end

IfElse.OnUpdateCondition = function(self, deltaTime)
  -- function num : 0_6 , upvalues : Behavior_Status
  local task = (self._tasks)[1]
  if task:GetStatus() == Behavior_Status.Invalid then
    task:OnStart()
    task:SetStatus(Behavior_Status.Running)
  end
  local status = task:SetStatus(task:OnUpdate(deltaTime))
  if status == Behavior_Status.Success then
    task:OnEnd()
    task:SetStatus(Behavior_Status.Invalid)
    self._index = 2
    return self:OnUpdateTrueCase(0)
  else
    if status == Behavior_Status.Failure then
      task:OnEnd()
      task:SetStatus(Behavior_Status.Invalid)
      self._index = 3
      return self:OnUpdateFalseCase(0)
    end
  end
  return Behavior_Status.Running
end

IfElse.OnUpdateTrueCase = function(self, deltaTime)
  -- function num : 0_7 , upvalues : Behavior_Status
  local task = (self._tasks)[2]
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
      return Behavior_Status.Failure
    end
  end
  return Behavior_Status.Running
end

IfElse.OnUpdateFalseCase = function(self, deltaTime)
  -- function num : 0_8 , upvalues : Behavior_Status
  local task = (self._tasks)[3]
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
      return Behavior_Status.Failure
    end
  end
  return Behavior_Status.Running
end

IfElse.GetCheckPoints = function(self)
  -- function num : 0_9 , upvalues : Behavior_Status
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

return IfElse

