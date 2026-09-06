local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local PersonNum = class("PersonNum", Task)

function PersonNum:Ctor(context, side, compareType, number)
  PersonNum.super.Ctor(self)
  self._context = context
  self._side = side
  self._compareType = compareType
  self._number = number
  self._utility = BattleECS.Utility.Utility
end

function PersonNum:OnStart()
end

function PersonNum:OnUpdate(deltaTime)
  local num = self._utility.GetCampAliveRoleNumber(self._side, self._context._battleworld, self._context._entityId)
  if self._compareType == "eq" then
    if num == self._number then
      return TaskStatus.Success
    end
  elseif self._compareType == "gt" then
    if num > self._number then
      return TaskStatus.Success
    end
  elseif self._compareType == "lt" then
    if num < self._number then
      return TaskStatus.Success
    end
  elseif self._compareType == "ge" then
    if num >= self._number then
      return TaskStatus.Success
    end
  elseif self._compareType == "le" then
    if num <= self._number then
      return TaskStatus.Success
    end
  elseif self._compareType == "ne" and num ~= self._number then
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

function PersonNum:OnEnd()
end

return PersonNum
