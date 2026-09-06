local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EBattleEffectType = require("luabehavior.agent.ebattleeffecttype")
local BattlerPositionComponent = require("logic.battle.component.battlerpositioncomponent")
local BattleSceneAffectComponent = require("logic.battle.component.battlesceneaffectcomponent")
local BattleEffect = class("BattleEffect", Task)

function BattleEffect:Ctor(context, battleEffectType, boolValue)
  BattleEffect.super.Ctor(self)
  self._context = context
  self._battleEffectType = battleEffectType
  self._boolValue = boolValue
end

function BattleEffect:OnStart()
  local battleSceneAffectComponent = self._context._battleScene:GetComponent(BattleSceneAffectComponent)
  if self._battleEffectType == EBattleEffectType.LightDimming then
    battleSceneAffectComponent._lightDimming = self._boolValue
    battleSceneAffectComponent._needRefreshLightDimming = true
  elseif self._battleEffectType == EBattleEffectType.BulletTime then
    battleSceneAffectComponent._bulletTime = self._boolValue
    battleSceneAffectComponent._needRefreshBulletTime = true
  elseif self._battleEffectType == EBattleEffectType.NormalShack then
    battleSceneAffectComponent._normalShackOrientation = -self._context._skill:GetAttacker():GetComponent(BattlerPositionComponent)._orientation
    battleSceneAffectComponent._needRefreshNormalShackOrientation = true
  elseif self._battleEffectType == EBattleEffectType.SkillShack1 then
    battleSceneAffectComponent._skillShack1 = self._boolValue
    battleSceneAffectComponent._needRefreshSkillShack1 = true
  end
end

function BattleEffect:OnUpdate(deltaTime)
  return Behavior_Status.Success
end

return BattleEffect
