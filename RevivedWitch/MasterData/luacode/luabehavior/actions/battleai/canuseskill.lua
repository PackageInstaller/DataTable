-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/canuseskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local CanUseSkill = class("CanUseSkill", Task)
CanUseSkill.Ctor = function(self, context)
  -- function num : 0_0 , upvalues : CanUseSkill, _ENV
  ((CanUseSkill.super).Ctor)(self)
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

CanUseSkill.OnStart = function(self)
  -- function num : 0_1
end

CanUseSkill.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if ((self._context)._battleworld):GetCampWinState() ~= "" then
    return 
  end
  if self._entity then
    local TypeComponent = (BattleECS.Components).TypeComponent
    local AnimationEventComponent = (BattleECS.Components).AnimationEventComponent
    if ((self._entity):GetComponent(TypeComponent))._summonName == "partner" then
      return TaskStatus.Success
    end
    if ((self._entity):GetComponent(TypeComponent))._isImaged then
      return TaskStatus.Success
    else
      if not ((self._utility).IsRoleDead)(self._entity) then
        if ((self._utility).IsToTargetXPoint)(self._entity) then
          if not ((self._entity):GetComponent(AnimationEventComponent))._roleIsInSkill then
            local effectType = {AttackSkill = 1, UseSkill = 2, Both = 3}
            if not ((self._buffUtility).IsRoleHasCanNotUseSkillBuff)(self._entity, effectType.AttackSkill) then
              return TaskStatus.Success
            else
              return TaskStatus.Failure
            end
          else
            do
              do
                do return TaskStatus.Failure end
                do return TaskStatus.Failure end
                do return TaskStatus.Failure end
                return TaskStatus.Failure
              end
            end
          end
        end
      end
    end
  end
end

CanUseSkill.OnEnd = function(self)
  -- function num : 0_3
end

return CanUseSkill

