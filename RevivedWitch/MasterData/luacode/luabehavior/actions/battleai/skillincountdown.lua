-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/skillincountdown.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local SkillInCountDown = class("SkillInCountDown", Task)
SkillInCountDown.Ctor = function(self, context)
  -- function num : 0_0 , upvalues : SkillInCountDown, _ENV
  ((SkillInCountDown.super).Ctor)(self)
  self._context = context
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

SkillInCountDown.OnStart = function(self)
  -- function num : 0_1
end

SkillInCountDown.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if self._entity then
    local isCd, skill = ((self._utility).IsInCD)(self._entity, (self._context)._behaviorSkillList)
    if not isCd then
      local TypeComponent = (BattleECS.Components).TypeComponent
      if ((self._utility).IsAttackSkill)(skill) then
        if ((self._entity):GetComponent(TypeComponent))._isImaged then
          ((self._utility).SetSkillID)(self._entity, skill)
        else
          if not ((self._buffUtility).IsRoleHasCanNotAttackSkillBuff)(self._entity) then
            ((self._utility).SetSkillID)(self._entity, skill)
          else
            ;
            ((self._utility).ClearSkillCurrentTime)(self._entity, skill)
          end
        end
      else
        if not ((self._entity):GetComponent(TypeComponent))._isImaged then
          ((self._utility).SetSkillID)(self._entity, skill)
        else
          ;
          ((self._utility).ClearSkillCurrentTime)(self._entity, skill)
        end
      end
    end
  end
  do
    return TaskStatus.Failure
  end
end

SkillInCountDown.OnEnd = function(self)
  -- function num : 0_3
end

return SkillInCountDown

