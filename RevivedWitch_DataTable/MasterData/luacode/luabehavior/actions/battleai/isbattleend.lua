-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/isbattleend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsBattleEnd = class("IsBattleEnd", Task)
IsBattleEnd.Ctor = function(self, context)
  -- function num : 0_0 , upvalues : IsBattleEnd
  ((IsBattleEnd.super).Ctor)(self)
  self._context = context
end

IsBattleEnd.OnStart = function(self)
  -- function num : 0_1
end

IsBattleEnd.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if ((self._context)._battleworld):GetCampWinState() ~= "" then
    return TaskStatus.Failure
  else
    return TaskStatus.Success
  end
end

IsBattleEnd.OnEnd = function(self)
  -- function num : 0_3
end

return IsBattleEnd

