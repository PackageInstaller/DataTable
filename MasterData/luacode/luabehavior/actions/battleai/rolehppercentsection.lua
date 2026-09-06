local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local RoleHpPercentSection = class("RoleHpPercentSection", Task)

function RoleHpPercentSection:Ctor(context, hpLeft, hpRight, judgeFitRoleNumParam, compareNum)
  RoleHpPercentSection.super.Ctor(self)
  self._hpLeft = fixedpoint(hpLeft)
  self._hpRight = fixedpoint(hpRight)
  self._condition = judgeFitRoleNumParam
  self._num = compareNum
  self._battleWorld = context._battleworld
end

function RoleHpPercentSection:OnStart()
end

function RoleHpPercentSection:OnUpdate(deltaTime)
  local count = 0
  local HpComponent = BattleECS.Components.HpComponent
  for _, v in ipairs(self._battleWorld._leftPlayerList) do
    local hpComponent = v:GetComponent(HpComponent)
    if hpComponent._currentHp >= hpComponent._maxHp * self._hpLeft / 100 and hpComponent._currentHp <= hpComponent._maxHp * self._hpRight / 100 then
      count = count + 1
    end
  end
  if self._condition == "eq" then
    if count == self._num then
      return TaskStatus.Success
    end
  elseif self._condition == "gt" then
    if count > self._num then
      return TaskStatus.Success
    end
  elseif self._condition == "lt" then
    if count < self._num then
      return TaskStatus.Success
    end
  elseif self._condition == "ge" then
    if count >= self._num then
      return TaskStatus.Success
    end
  elseif self._condition == "le" then
    if count <= self._num then
      return TaskStatus.Success
    end
  elseif self._condition == "ne" and count ~= self._num then
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

function RoleHpPercentSection:OnEnd()
end

return RoleHpPercentSection
