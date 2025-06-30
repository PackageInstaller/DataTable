-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/isroleinotherskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsRoleInOtherSkill = class("IsRoleInOtherSkill", Task)
IsRoleInOtherSkill.Ctor = function(self, context)
  -- function num : 0_0 , upvalues : IsRoleInOtherSkill, _ENV
  ((IsRoleInOtherSkill.super).Ctor)(self)
  self._entity = nil
  for i,e in ipairs((context._battleworld)._entitys) do
    if e._entityId == context._entityId then
      self._entity = e
      break
    end
  end
end

IsRoleInOtherSkill.OnStart = function(self)
  -- function num : 0_1
end

IsRoleInOtherSkill.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if self._entity then
    local AnimationEventComponent = (BattleECS.Components).AnimationEventComponent
    if ((self._entity):GetComponent(AnimationEventComponent))._roleIsInSkill then
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

IsRoleInOtherSkill.OnEnd = function(self)
  -- function num : 0_3
end

return IsRoleInOtherSkill

