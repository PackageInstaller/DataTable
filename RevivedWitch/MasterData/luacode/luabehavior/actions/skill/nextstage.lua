-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skill/nextstage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local Logic_SkillSystem = require("logic.battle.system.logic.skillsystem")
local NextStage = class("NextStage", Task)
NextStage.Ctor = function(self, context)
  -- function num : 0_0 , upvalues : NextStage
  ((NextStage.super).Ctor)(self)
  self._context = context
end

NextStage.OnUpdate = function(self, deltaTime)
  -- function num : 0_1 , upvalues : Logic_SkillSystem, TaskStatus
  if (((self._context)._world):GetSystem(Logic_SkillSystem)):CalculateTarget(((self._context)._attacker)._entityId) then
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

return NextStage

