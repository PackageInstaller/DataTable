-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/skilltomaster.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local SkillToMaster = class("SkillToMaster", Task)
SkillToMaster.Ctor = function(self, context, skillId)
  -- function num : 0_0 , upvalues : SkillToMaster, _ENV
  ((SkillToMaster.super).Ctor)(self)
  self._context = context
  self._skillId = skillId
  self._battleWorld = (self._context)._battleworld
  self._entitys = (self._battleWorld)._entitys
  self._entity = nil
  for i,e in ipairs(self._entitys) do
    if e._entityId == (self._context)._entityId then
      self._entity = e
      break
    end
  end
  do
    self._utility = (BattleECS.Utility).Utility
    self._buffUtility = (BattleECS.Utility).BuffUtility
    self._animationUtility = (BattleECS.Utility).AnimationUtility
  end
end

SkillToMaster.OnStart = function(self)
  -- function num : 0_1
end

SkillToMaster.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if self._entity then
    local TypeComponent = (BattleECS.Components).TypeComponent
    local SkillComponent = (BattleECS.Components).SkillComponent
    local fatherEntityId = ((self._entity):GetComponent(TypeComponent))._summonFatherEntityid
    local fatherEntity = nil
    for i,e in ipairs(self._entitys) do
      if e._entityId == fatherEntityId then
        fatherEntity = e
        break
      end
    end
    do
      do
        if fatherEntity then
          (fatherEntity:GetComponent(SkillComponent))._skillId = 0
          if ((self._utility).IsSkillNeedInitAnimationEventComponentInfo)(fatherEntity, self._skillId) then
            ((self._animationUtility).InitMonsterOrRoleAnimationEventComponentRoleInSkillInfo)(fatherEntity, self._skillId)
          end
          ;
          (self._battleWorld):CreateSkillEntity(self._skillId, fatherEntityId, 1, {fatherEntity})
          if not ((self._utility).IsSkillHasNoColliderEffect)(self._skillId) then
            ((self._buffUtility).SetBuffListToOwnCampEntityBySkillID)(fatherEntity, fatherEntity, self._skillId, self._battleWorld)
          end
        end
        return TaskStatus.Success
      end
    end
  end
end

SkillToMaster.OnEnd = function(self)
  -- function num : 0_3
end

return SkillToMaster

