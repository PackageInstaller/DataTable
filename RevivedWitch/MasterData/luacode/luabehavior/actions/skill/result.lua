-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skill/result.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local Logic_SkillSystem = require("logic.battle.system.logic.skillsystem")
local Result = class("Result", Task)
Result.Ctor = function(self, context, stageNum)
  -- function num : 0_0 , upvalues : Result
  ((Result.super).Ctor)(self)
  self._context = context
  self._stageNum = stageNum
end

Result.OnUpdate = function(self, deltaTime)
  -- function num : 0_1 , upvalues : Logic_SkillSystem, TaskStatus
  (((self._context)._world):GetSystem(Logic_SkillSystem)):CalculateResult(((self._context)._attacker)._entityId)
  return TaskStatus.Success
end

return Result

