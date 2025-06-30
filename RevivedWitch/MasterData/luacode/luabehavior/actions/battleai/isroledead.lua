-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/isroledead.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsRoleDead = class("IsRoleDead", Task)
IsRoleDead.Ctor = function(self, context)
  -- function num : 0_0 , upvalues : IsRoleDead, _ENV
  ((IsRoleDead.super).Ctor)(self)
  self._entity = nil
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

IsRoleDead.OnStart = function(self)
  -- function num : 0_1
end

IsRoleDead.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if self._entity then
    if ((self._utility).IsRoleDead)(self._entity) then
      return TaskStatus.Failure
    else
      return TaskStatus.Success
    end
  else
    return TaskStatus.Failure
  end
end

IsRoleDead.OnEnd = function(self)
  -- function num : 0_3
end

return IsRoleDead

