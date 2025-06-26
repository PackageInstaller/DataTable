-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/effectontarget.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EEffectType = require("luabehavior.agent.eeffecttype")
local BattlerEffectComponent = require("logic.battle.component.battlereffectcomponent")
local CSkillEffectTable = (BeanManager.GetTableByName)("skill.cskilleffect")
local EffectOnTarget = class("EffectOnTarget", Task)
EffectOnTarget.Ctor = function(self, context, index, effectType, effectId)
  -- function num : 0_0 , upvalues : EffectOnTarget, EEffectType, CSkillEffectTable
  ((EffectOnTarget.super).Ctor)(self)
  self._context = context
  self._index = index
  self._effectType = effectType
  self._effectId = effectId
  self._time = 0
  self._totalTime = 0
  if effectId ~= 0 and effectType == EEffectType.PlayEffect then
    self._totalTime = (CSkillEffectTable:GetRecorder(effectId)).time
  end
end

EffectOnTarget.OnStart = function(self)
  -- function num : 0_1 , upvalues : BattlerEffectComponent
  self._time = 0
  local skill = (self._context)._skill
  if skill:GetTarget(self._index) then
    local battlerEffectComponent = (skill:GetTarget(self._index)):GetComponent(BattlerEffectComponent)
    ;
    (battlerEffectComponent._effects):AddOnceEffect(self._effectId)
  end
end

EffectOnTarget.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : Behavior_Status
  self._time = self._time + deltaTime
  if self._totalTime <= self._time then
    self._time = self._totalTime
  end
  if self._time == self._totalTime then
    return Behavior_Status.Success
  else
    return Behavior_Status.Running
  end
end

EffectOnTarget.GetCheckPoints = function(self)
  -- function num : 0_3
  return self._totalTime - self._time
end

return EffectOnTarget

