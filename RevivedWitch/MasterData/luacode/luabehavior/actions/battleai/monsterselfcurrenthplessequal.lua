-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monsterselfcurrenthplessequal.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterSelfCurrentHPLessEqual = class("MonsterSelfCurrentHPLessEqual", Task)
MonsterSelfCurrentHPLessEqual.Ctor = function(self, context, hpPercent)
  -- function num : 0_0 , upvalues : MonsterSelfCurrentHPLessEqual, _ENV
  ((MonsterSelfCurrentHPLessEqual.super).Ctor)(self)
  self._context = context
  self._hpPercent = fixedpoint(hpPercent)
  self._entity = nil
  for i,e in ipairs(((self._context)._battleworld)._entitys) do
    if e._entityId == (self._context)._entityId then
      self._entity = e
      break
    end
  end
end

MonsterSelfCurrentHPLessEqual.OnStart = function(self)
  -- function num : 0_1
end

MonsterSelfCurrentHPLessEqual.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if self._entity then
    local HpComponent = (BattleECS.Components).HpComponent
    local hpComponent = (self._entity):GetComponent(HpComponent)
    if hpComponent then
      if hpComponent._currentHp <= hpComponent._maxHp * (self._hpPercent / 100) then
        return TaskStatus.Success
      else
        return TaskStatus.Failure
      end
    else
      return TaskStatus.Failure
    end
  else
    do
      do return TaskStatus.Failure end
    end
  end
end

MonsterSelfCurrentHPLessEqual.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterSelfCurrentHPLessEqual

