-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monsterskillcdrandom.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterSkillTimeDelay = class("MonsterSkillTimeDelay", Task)
MonsterSkillTimeDelay.Ctor = function(self, context, deltaTimeDown, deltaTimeUp)
  -- function num : 0_0 , upvalues : MonsterSkillTimeDelay, _ENV
  ((MonsterSkillTimeDelay.super).Ctor)(self)
  self._context = context
  if deltaTimeUp == deltaTimeDown then
    self._delayTime = deltaTimeDown
  else
    self._delayTime = (((self._context)._battleworld)._randomPcg)(deltaTimeDown, deltaTimeUp)
  end
  self._countIndex = 0
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

MonsterSkillTimeDelay.OnStart = function(self)
  -- function num : 0_1
end

MonsterSkillTimeDelay.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  self._countIndex = self._countIndex + 1
  if self._delayTime <= self._countIndex then
    return TaskStatus.Success
  end
  ;
  ((self._utility).ClearEntityAllSkillCurrentTime)(self._entity)
  return TaskStatus.Failure
end

MonsterSkillTimeDelay.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterSkillTimeDelay

