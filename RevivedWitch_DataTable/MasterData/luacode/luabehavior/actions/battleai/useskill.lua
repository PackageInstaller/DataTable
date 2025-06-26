-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/useskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local UseSkill = class("UseSkill", Task)
UseSkill.Ctor = function(self, context, skillid)
  -- function num : 0_0 , upvalues : UseSkill, _ENV
  ((UseSkill.super).Ctor)(self)
  self._skillID = skillid
  self._entity = nil
  for i,e in ipairs((context._battleworld)._entitys) do
    if e._entityId == context._entityId then
      self._entity = e
      break
    end
  end
  do
    self._battleWorld = context._battleworld
    self._utility = (BattleECS.Utility).Utility
  end
end

UseSkill.OnStart = function(self)
  -- function num : 0_1
end

UseSkill.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  do
    if self._entity then
      local hittedEntityList = ((self._utility).GetSkillEffectEntity)(self._skillID, (self._entity)._entityId, self._battleWorld)
      if #hittedEntityList ~= 0 then
        LogInfo("技能id.....", self._skillID)
        ;
        ((self._utility).SetSkillID)(self._entity, self._skillID)
        return TaskStatus.Success
      else
        return TaskStatus.Failure
      end
    end
    return TaskStatus.Success
  end
end

UseSkill.OnEnd = function(self)
  -- function num : 0_3
end

return UseSkill

