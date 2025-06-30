-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/effect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EEffectType = require("luabehavior.agent.eeffecttype")
local BattlerEffectComponent = require("logic.battle.component.battlereffectcomponent")
local CSkillEffectTable = (BeanManager.GetTableByName)("skill.cskilleffect")
local Effect = class("Effect", Task)
Effect.Ctor = function(self, context, effectType, effectId)
  -- function num : 0_0 , upvalues : Effect, EEffectType, CSkillEffectTable
  ((Effect.super).Ctor)(self)
  self._context = context
  self._effectType = effectType
  self._effectId = effectId
  self._time = 0
  self._totalTime = 0
  if effectId ~= 0 and effectType == EEffectType.PlayEffect then
    self._totalTime = (CSkillEffectTable:GetRecorder(effectId)).time
  end
end

Effect.OnStart = function(self)
  -- function num : 0_1 , upvalues : BattlerEffectComponent
  self._time = 0
  local battlerEffectComponent = (((self._context)._skill):GetAttacker()):GetComponent(BattlerEffectComponent)
  ;
  (battlerEffectComponent._effects):AddOnceEffect(self._effectId)
end

Effect.OnUpdate = function(self, deltaTime)
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

Effect.GetCheckPoints = function(self)
  -- function num : 0_3
  return self._totalTime - self._time
end

return Effect

