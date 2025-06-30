-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monstercurrenthplessequalnumber.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterCurrentHpLessEqualNumber = class("MonsterCurrentHpLessEqualNumber", Task)
MonsterCurrentHpLessEqualNumber.Ctor = function(self, context, hp)
  -- function num : 0_0 , upvalues : MonsterCurrentHpLessEqualNumber, _ENV
  ((MonsterCurrentHpLessEqualNumber.super).Ctor)(self)
  self._hpNum = hp
  local entity = nil
  for i,e in ipairs((context._battleworld)._entitys) do
    if e._entityId == context._entityId then
      entity = e
      break
    end
  end
  do
    if entity then
      self._HpComponnet = entity:GetComponent((BattleECS.Components).HpComponent)
    end
  end
end

MonsterCurrentHpLessEqualNumber.OnStart = function(self)
  -- function num : 0_1
end

MonsterCurrentHpLessEqualNumber.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if self._HpComponnet then
    if (self._HpComponnet)._currentHp <= self._hpNum then
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  else
    return TaskStatus.Failure
  end
  return TaskStatus.Failure
end

MonsterCurrentHpLessEqualNumber.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterCurrentHpLessEqualNumber

