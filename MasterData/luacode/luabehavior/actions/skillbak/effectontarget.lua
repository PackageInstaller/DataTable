local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EEffectType = require("luabehavior.agent.eeffecttype")
local BattlerEffectComponent = require("logic.battle.component.battlereffectcomponent")
local CSkillEffectTable = BeanManager.GetTableByName("skill.cskilleffect")
local EffectOnTarget = class("EffectOnTarget", Task)

function EffectOnTarget:Ctor(context, index, effectType, effectId)
  EffectOnTarget.super.Ctor(self)
  self._context = context
  self._index = index
  self._effectType = effectType
  self._effectId = effectId
  self._time = 0
  self._totalTime = 0
  if effectId ~= 0 and effectType == EEffectType.PlayEffect then
    self._totalTime = CSkillEffectTable:GetRecorder(effectId).time
  end
end

function EffectOnTarget:OnStart()
  self._time = 0
  local skill = self._context._skill
  if skill:GetTarget(self._index) then
    local battlerEffectComponent = skill:GetTarget(self._index):GetComponent(BattlerEffectComponent)
    battlerEffectComponent._effects:AddOnceEffect(self._effectId)
  end
end

function EffectOnTarget:OnUpdate(deltaTime)
  self._time = self._time + deltaTime
  if self._time >= self._totalTime then
    self._time = self._totalTime
  end
  if self._time == self._totalTime then
    return Behavior_Status.Success
  else
    return Behavior_Status.Running
  end
end

function EffectOnTarget:GetCheckPoints()
  return self._totalTime - self._time
end

return EffectOnTarget
