-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/clearskillcurrenttime.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local ClearSkillCurrentTime = class("ClearSkillCurrentTime", Task)
ClearSkillCurrentTime.Ctor = function(self, context, skillid)
  -- function num : 0_0 , upvalues : ClearSkillCurrentTime, _ENV
  ((ClearSkillCurrentTime.super).Ctor)(self)
  self._context = context
  self._skillID = skillid
  self._entity = nil
  for i,e in ipairs(((self._context)._battleworld)._entitys) do
    if e._entityId == (self._context)._entityId then
      self._entity = e
      break
    end
  end
  do
    self._utility = (BattleECS.Utility).Utility
  end
end

ClearSkillCurrentTime.OnStart = function(self)
  -- function num : 0_1
end

ClearSkillCurrentTime.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if self._entity then
    ((self._utility).ClearSkillCurrentTime)(self._entity, self._skillID)
  end
  return TaskStatus.Success
end

ClearSkillCurrentTime.OnEnd = function(self)
  -- function num : 0_3
end

return ClearSkillCurrentTime

