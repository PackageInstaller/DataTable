-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monsterskillisincd.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterSkillIsInCD = class("MonsterSkillIsInCD", Task)
MonsterSkillIsInCD.Ctor = function(self, context, skillid)
  -- function num : 0_0 , upvalues : MonsterSkillIsInCD, _ENV
  ((MonsterSkillIsInCD.super).Ctor)(self)
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
    self._buffUtility = (BattleECS.Utility).BuffUtility
  end
end

MonsterSkillIsInCD.OnStart = function(self)
  -- function num : 0_1
end

MonsterSkillIsInCD.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if self._entity then
    local effectType = {AttackSkill = 1, UseSkill = 2, Both = 3}
    if ((self._buffUtility).IsRoleHasCanNotUseSkillBuff)(self._entity, effectType.Both, self._skillID) then
      return TaskStatus.Failure
    end
    if ((self._utility).IsMonsterSkillInCD)(self._entity, self._skillID) then
      return TaskStatus.Failure
    else
      return TaskStatus.Success
    end
  else
    do
      do return TaskStatus.Failure end
    end
  end
end

MonsterSkillIsInCD.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterSkillIsInCD

