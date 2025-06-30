-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skill/playtargeteffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local SkillComponent = require("logic.battle.component.skillcomponent")
local BattlerEffectComponent = require("logic.battle.component.battlereffectcomponent")
local BattlerPositionComponent = require("logic.battle.component.battlerpositioncomponent")
local BattleSceneEffectUtility = require("logic.battle.utility.battlesceneeffectutility")
local CSkillEffectTable = (BeanManager.GetTableByName)("skill.cskilleffect")
local PlayTargetEffect = class("PlayTargetEffect", Task)
PlayTargetEffect.Ctor = function(self, context, effectId)
  -- function num : 0_0 , upvalues : PlayTargetEffect, CSkillEffectTable
  ((PlayTargetEffect.super).Ctor)(self)
  self._context = context
  self._effectId = effectId
  self._time = 0
  self._skillRecord = CSkillEffectTable:GetRecorder(effectId)
  if self._skillRecord then
    self._totalTime = (self._skillRecord).time
  else
    self._totalTime = 0
  end
end

PlayTargetEffect.OnStart = function(self)
  -- function num : 0_1 , upvalues : SkillComponent, _ENV, BattlerEffectComponent, BattleSceneEffectUtility, BattlerPositionComponent
  self._time = 0
  if self._skillRecord then
    local skillComponent = ((self._context)._attacker):GetComponent(SkillComponent)
    if (self._skillRecord).flyItemType == 0 then
      for k,v in pairs(skillComponent._targets) do
        local battlerEffectComponent = v:GetComponent(BattlerEffectComponent)
        ;
        (battlerEffectComponent._effects):AddOnceEffect(self._effectId)
      end
    else
      do
        if (self._skillRecord).flyItemType == 2 then
          (BattleSceneEffectUtility.BattleSceneEffect)((self._context)._world, (((skillComponent._targets)[1]):GetComponent(BattlerPositionComponent))._orientation, self._effectId)
        end
        if (self._skillRecord).shackType == 1 and (skillComponent._targets)[1] then
          (BattleSceneEffectUtility.SkillShack)((self._context)._world, (((skillComponent._targets)[1]):GetComponent(BattlerPositionComponent))._orientation, (self._skillRecord).shackOffset)
        end
      end
    end
  end
end

PlayTargetEffect.OnUpdate = function(self, deltaTime)
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

PlayTargetEffect.GetCheckPoints = function(self)
  -- function num : 0_3
  return self._totalTime - self._time
end

return PlayTargetEffect

