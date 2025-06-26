-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/ifhascurrentbuffbybuffid.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IfHasCurrentBuffByBuffID = class("IfHasCurrentBuffByBuffID", Task)
IfHasCurrentBuffByBuffID.Ctor = function(self, context, buffid)
  -- function num : 0_0 , upvalues : IfHasCurrentBuffByBuffID, _ENV
  ((IfHasCurrentBuffByBuffID.super).Ctor)(self)
  self._context = context
  self._buffID = buffid
  self._entity = nil
  for i,e in ipairs(((self._context)._battleworld)._entitys) do
    if e._entityId == (self._context)._entityId then
      self._entity = e
      break
    end
  end
  do
    self._buffUtility = (BattleECS.Utility).BuffUtility
  end
end

IfHasCurrentBuffByBuffID.OnStart = function(self)
  -- function num : 0_1
end

IfHasCurrentBuffByBuffID.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if self._entity then
    if ((self._buffUtility).IsHasCurrentBuff)(self._entity, self._buffID) then
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  else
    return TaskStatus.Failure
  end
end

IfHasCurrentBuffByBuffID.OnEnd = function(self)
  -- function num : 0_3
end

return IfHasCurrentBuffByBuffID

