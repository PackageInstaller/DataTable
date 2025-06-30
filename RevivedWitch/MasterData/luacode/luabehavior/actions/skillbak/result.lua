-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/result.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EResultType = require("luabehavior.agent.eresulttype")
local Result = class("Result", Task)
Result.Ctor = function(self, context, resultType)
  -- function num : 0_0 , upvalues : Result
  ((Result.super).Ctor)(self)
  self._context = context
  self._resultType = resultType
end

Result.OnUpdate = function(self, deltaTime)
  -- function num : 0_1 , upvalues : Behavior_Status
  ((self._context)._skill):CalculateResult()
  return Behavior_Status.Success
end

return Result

