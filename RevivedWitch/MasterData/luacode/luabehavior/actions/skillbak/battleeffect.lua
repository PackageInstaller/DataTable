-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/battleeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EBattleEffectType = require("luabehavior.agent.ebattleeffecttype")
local BattlerPositionComponent = require("logic.battle.component.battlerpositioncomponent")
local BattleSceneAffectComponent = require("logic.battle.component.battlesceneaffectcomponent")
local BattleEffect = class("BattleEffect", Task)
BattleEffect.Ctor = function(self, context, battleEffectType, boolValue)
  -- function num : 0_0 , upvalues : BattleEffect
  ((BattleEffect.super).Ctor)(self)
  self._context = context
  self._battleEffectType = battleEffectType
  self._boolValue = boolValue
end

BattleEffect.OnStart = function(self)
  -- function num : 0_1 , upvalues : BattleSceneAffectComponent, EBattleEffectType, BattlerPositionComponent
  local battleSceneAffectComponent = ((self._context)._battleScene):GetComponent(BattleSceneAffectComponent)
  if self._battleEffectType == EBattleEffectType.LightDimming then
    battleSceneAffectComponent._lightDimming = self._boolValue
    battleSceneAffectComponent._needRefreshLightDimming = true
  else
    if self._battleEffectType == EBattleEffectType.BulletTime then
      battleSceneAffectComponent._bulletTime = self._boolValue
      battleSceneAffectComponent._needRefreshBulletTime = true
    else
      if self._battleEffectType == EBattleEffectType.NormalShack then
        battleSceneAffectComponent._normalShackOrientation = -((((self._context)._skill):GetAttacker()):GetComponent(BattlerPositionComponent))._orientation
        battleSceneAffectComponent._needRefreshNormalShackOrientation = true
      else
        if self._battleEffectType == EBattleEffectType.SkillShack1 then
          battleSceneAffectComponent._skillShack1 = self._boolValue
          battleSceneAffectComponent._needRefreshSkillShack1 = true
        end
      end
    end
  end
end

BattleEffect.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : Behavior_Status
  return Behavior_Status.Success
end

return BattleEffect

