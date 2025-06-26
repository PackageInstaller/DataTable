-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monstercurrenthpmoreequalnumber.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterCurrentHpMoreEqualNumber = class("MonsterCurrentHpMoreEqualNumber", Task)
MonsterCurrentHpMoreEqualNumber.Ctor = function(self, context, hp)
  -- function num : 0_0 , upvalues : MonsterCurrentHpMoreEqualNumber, _ENV
  ((MonsterCurrentHpMoreEqualNumber.super).Ctor)(self)
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
      self._hpComponent = entity:GetComponent((BattleECS.Components).HpComponent)
    end
  end
end

MonsterCurrentHpMoreEqualNumber.OnStart = function(self)
  -- function num : 0_1
end

MonsterCurrentHpMoreEqualNumber.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if self._hpComponent then
    if self._hpNum <= (self._hpComponent)._currentHp then
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  else
    return TaskStatus.Failure
  end
  return TaskStatus.Failure
end

MonsterCurrentHpMoreEqualNumber.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterCurrentHpMoreEqualNumber

