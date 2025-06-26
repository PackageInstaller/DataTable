-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/rolehppercentsection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local RoleHpPercentSection = class("RoleHpPercentSection", Task)
RoleHpPercentSection.Ctor = function(self, context, hpLeft, hpRight, judgeFitRoleNumParam, compareNum)
  -- function num : 0_0 , upvalues : RoleHpPercentSection, _ENV
  ((RoleHpPercentSection.super).Ctor)(self)
  self._hpLeft = fixedpoint(hpLeft)
  self._hpRight = fixedpoint(hpRight)
  self._condition = judgeFitRoleNumParam
  self._num = compareNum
  self._battleWorld = context._battleworld
end

RoleHpPercentSection.OnStart = function(self)
  -- function num : 0_1
end

RoleHpPercentSection.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  local count = 0
  local HpComponent = (BattleECS.Components).HpComponent
  for _,v in ipairs((self._battleWorld)._leftPlayerList) do
    local hpComponent = v:GetComponent(HpComponent)
    if hpComponent._maxHp * self._hpLeft / 100 <= hpComponent._currentHp and hpComponent._currentHp <= hpComponent._maxHp * self._hpRight / 100 then
      count = count + 1
    end
  end
  -- DECOMPILER ERROR at PC36: Unhandled construct in 'MakeBoolean' P1

  if self._condition == "eq" and count == self._num then
    return TaskStatus.Success
  end
  -- DECOMPILER ERROR at PC45: Unhandled construct in 'MakeBoolean' P1

  if self._condition == "gt" and self._num < count then
    return TaskStatus.Success
  end
  -- DECOMPILER ERROR at PC54: Unhandled construct in 'MakeBoolean' P1

  if self._condition == "lt" and count < self._num then
    return TaskStatus.Success
  end
  -- DECOMPILER ERROR at PC63: Unhandled construct in 'MakeBoolean' P1

  if self._condition == "ge" and self._num <= count then
    return TaskStatus.Success
  end
  -- DECOMPILER ERROR at PC72: Unhandled construct in 'MakeBoolean' P1

  if self._condition == "le" and count <= self._num then
    return TaskStatus.Success
  end
  if self._condition == "ne" and count ~= self._num then
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

RoleHpPercentSection.OnEnd = function(self)
  -- function num : 0_3
end

return RoleHpPercentSection

