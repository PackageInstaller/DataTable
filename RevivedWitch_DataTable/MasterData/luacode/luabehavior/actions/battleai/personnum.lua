-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/personnum.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local PersonNum = class("PersonNum", Task)
PersonNum.Ctor = function(self, context, side, compareType, number)
  -- function num : 0_0 , upvalues : PersonNum, _ENV
  ((PersonNum.super).Ctor)(self)
  self._context = context
  self._side = side
  self._compareType = compareType
  self._number = number
  self._utility = (BattleECS.Utility).Utility
end

PersonNum.OnStart = function(self)
  -- function num : 0_1
end

PersonNum.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  local num = ((self._utility).GetCampAliveRoleNumber)(self._side, (self._context)._battleworld, (self._context)._entityId)
  -- DECOMPILER ERROR at PC15: Unhandled construct in 'MakeBoolean' P1

  if self._compareType == "eq" and num == self._number then
    return TaskStatus.Success
  end
  -- DECOMPILER ERROR at PC24: Unhandled construct in 'MakeBoolean' P1

  if self._compareType == "gt" and self._number < num then
    return TaskStatus.Success
  end
  -- DECOMPILER ERROR at PC33: Unhandled construct in 'MakeBoolean' P1

  if self._compareType == "lt" and num < self._number then
    return TaskStatus.Success
  end
  -- DECOMPILER ERROR at PC42: Unhandled construct in 'MakeBoolean' P1

  if self._compareType == "ge" and self._number <= num then
    return TaskStatus.Success
  end
  -- DECOMPILER ERROR at PC51: Unhandled construct in 'MakeBoolean' P1

  if self._compareType == "le" and num <= self._number then
    return TaskStatus.Success
  end
  if self._compareType == "ne" and num ~= self._number then
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

PersonNum.OnEnd = function(self)
  -- function num : 0_3
end

return PersonNum

