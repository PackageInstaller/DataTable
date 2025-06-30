-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/ifhasenoughconditionsuseskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IfHasEnoughConditionsUseSkill = class("IfHasEnoughConditionsUseSkill", Task)
IfHasEnoughConditionsUseSkill.Ctor = function(self, context)
  -- function num : 0_0 , upvalues : IfHasEnoughConditionsUseSkill, _ENV
  ((IfHasEnoughConditionsUseSkill.super).Ctor)(self)
  self._battleworld = context._battleworld
  self._entity = nil
  for i,e in ipairs((self._battleworld)._entitys) do
    if e._entityId == context._entityId then
      self._entity = e
      break
    end
  end
  do
    self._buffUtility = (BattleECS.Utility).BuffUtility
    self._utility = (BattleECS.Utility).Utility
  end
end

IfHasEnoughConditionsUseSkill.OnStart = function(self)
  -- function num : 0_1
end

IfHasEnoughConditionsUseSkill.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus, _ENV
  if self._entity then
    local effectType = {AttackSkill = 1, UseSkill = 2, Both = 3}
    if ((self._buffUtility).IsRoleHasCanNotUseSkillBuff)(self._entity, effectType.Both, 0) then
      return TaskStatus.Failure
    end
    local AnimationEventComponent = (BattleECS.Components).AnimationEventComponent
    if (self._battleworld):GetCampWinState() == "" then
      if not ((self._utility).IsRoleDead)(self._entity) then
        if not ((self._entity):GetComponent(AnimationEventComponent))._roleIsInSkill then
          if ((self._utility).IsToTargetXPoint)(self._entity) then
            return TaskStatus.Success
          else
            return TaskStatus.Failure
          end
        else
          return TaskStatus.Failure
        end
      else
        return TaskStatus.Failure
      end
    else
      return TaskStatus.Failure
    end
  else
    do
      do return TaskStatus.Failure end
    end
  end
end

IfHasEnoughConditionsUseSkill.OnEnd = function(self)
  -- function num : 0_3
end

return IfHasEnoughConditionsUseSkill

