-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/ishighestelementdamege.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsHighestElementDamege = class("IsHighestElementDamege", Task)
IsHighestElementDamege.Ctor = function(self, context, elementType)
  -- function num : 0_0 , upvalues : IsHighestElementDamege, _ENV
  ((IsHighestElementDamege.super).Ctor)(self)
  self._entity = nil
  self._elementType = elementType
  for i,e in ipairs((context._battleworld)._entitys) do
    if e._entityId == context._entityId then
      self._entity = e
      break
    end
  end
  do
    self._utility = (BattleECS.Utility).Utility
  end
end

IsHighestElementDamege.OnStart = function(self)
  -- function num : 0_1
end

IsHighestElementDamege.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if ((self._utility).IsEntityHighestElementDamage)(self._entity, self._elementType) then
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

IsHighestElementDamege.OnEnd = function(self)
  -- function num : 0_3
end

return IsHighestElementDamege

