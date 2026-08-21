-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monsterhplinenum.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterHpLineNum = class("MonsterHpLineNum", Task)
MonsterHpLineNum.Ctor = function(self, context, compareType, count)
  -- function num : 0_0 , upvalues : MonsterHpLineNum
  ((MonsterHpLineNum.super).Ctor)(self)
  self._context = context
  self._battleWorld = (self._context)._battleworld
  self._compareType = compareType
  self._num = count
end

MonsterHpLineNum.OnStart = function(self)
  -- function num : 0_1
end

MonsterHpLineNum.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  local count = 0
  for _,v in ipairs((self._battleWorld)._bossHpStage) do
    if not v.stage then
      count = count + 1
    end
  end
  -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P1

  if self._compareType == "eq" and count == self._num then
    return TaskStatus.Success
  end
  -- DECOMPILER ERROR at PC28: Unhandled construct in 'MakeBoolean' P1

  if self._compareType == "gt" and self._num < count then
    return TaskStatus.Success
  end
  -- DECOMPILER ERROR at PC37: Unhandled construct in 'MakeBoolean' P1

  if self._compareType == "lt" and count < self._num then
    return TaskStatus.Success
  end
  -- DECOMPILER ERROR at PC46: Unhandled construct in 'MakeBoolean' P1

  if self._compareType == "ge" and self._num <= count then
    return TaskStatus.Success
  end
  -- DECOMPILER ERROR at PC55: Unhandled construct in 'MakeBoolean' P1

  if self._compareType == "le" and count <= self._num then
    return TaskStatus.Success
  end
  if self._compareType == "ne" and count ~= self._num then
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

MonsterHpLineNum.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterHpLineNum

