-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/judgement.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EJudgementType = require("luabehavior.agent.ejudgementtype")
local AttributeComponent = require("logic.battle.component.attributecomponent")
local Judgement = class("Judgement", Task)
Judgement.Ctor = function(self, context, judgementType)
  -- function num : 0_0 , upvalues : Judgement
  ((Judgement.super).Ctor)(self)
  self._context = context
  self._judgementType = judgementType
end

Judgement.OnStart = function(self)
  -- function num : 0_1
end

Judgement.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : AttributeComponent, EJudgementType, Behavior_Status
  local attacker = ((self._context)._skill):GetAttacker()
  local attributeComponent = attacker:GetComponent(AttributeComponent)
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
        if attacker then
          return Behavior_Status.Success
        else
          return Behavior_Status.Failure
        end
      end
    end
  end
end

return Judgement

