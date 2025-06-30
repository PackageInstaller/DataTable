-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/judgementontarget.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EJudgementType = require("luabehavior.agent.ejudgementtype")
local AttributeComponent = require("logic.battle.component.attributecomponent")
local JudgementOnTarget = class("JudgementOnTarget", Task)
JudgementOnTarget.Ctor = function(self, context, index, judgementType)
  -- function num : 0_0 , upvalues : JudgementOnTarget
  ((JudgementOnTarget.super).Ctor)(self)
  self._context = context
  self._index = index
  self._judgementType = judgementType
end

JudgementOnTarget.OnStart = function(self)
  -- function num : 0_1
end

JudgementOnTarget.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : AttributeComponent, EJudgementType, Behavior_Status
  local target = ((self._context)._skill):GetTarget(self._index)
  if target then
    local attributeComponent = target:GetComponent(AttributeComponent)
    if self._judgementType == EJudgementType.TargetDead then
      if attributeComponent._hp > 0 then
        return Behavior_Status.Failure
      else
        return Behavior_Status.Success
      end
    else
      if self._judgementType == EJudgementType.TargetDisappear then
        if attributeComponent._deadtype == 2 then
          return Behavior_Status.Success
        else
          return Behavior_Status.Failure
        end
      else
        if self._judgementType == EJudgementType.BattlerExist then
          return Behavior_Status.Success
        end
      end
    end
  else
    do
      if self._judgementType == EJudgementType.BattlerExist then
        return Behavior_Status.Failure
      end
      do return Behavior_Status.Success end
    end
  end
end

return JudgementOnTarget

