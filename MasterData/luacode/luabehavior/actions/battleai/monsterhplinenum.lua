local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterHpLineNum = class("MonsterHpLineNum", Task)

function MonsterHpLineNum:Ctor(context, compareType, count)
  MonsterHpLineNum.super.Ctor(self)
  self._context = context
  self._battleWorld = self._context._battleworld
  self._compareType = compareType
  self._num = count
end

function MonsterHpLineNum:OnStart()
end

function MonsterHpLineNum:OnUpdate(deltaTime)
  local count = 0
  for _, v in ipairs(self._battleWorld._bossHpStage) do
    if not v.stage then
      count = count + 1
    end
  end
  if self._compareType == "eq" then
    if count == self._num then
      return TaskStatus.Success
    end
  elseif self._compareType == "gt" then
    if count > self._num then
      return TaskStatus.Success
    end
  elseif self._compareType == "lt" then
    if count < self._num then
      return TaskStatus.Success
    end
  elseif self._compareType == "ge" then
    if count >= self._num then
      return TaskStatus.Success
    end
  elseif self._compareType == "le" then
    if count <= self._num then
      return TaskStatus.Success
    end
  elseif self._compareType == "ne" and count ~= self._num then
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

function MonsterHpLineNum:OnEnd()
end

return MonsterHpLineNum
