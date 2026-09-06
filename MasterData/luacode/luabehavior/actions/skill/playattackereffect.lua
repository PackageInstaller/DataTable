local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local BattlerEffectComponent = require("logic.battle.component.battlereffectcomponent")
local BattlerPositionComponent = require("logic.battle.component.battlerpositioncomponent")
local BattleSceneEffectUtility = require("logic.battle.utility.battlesceneeffectutility")
local CSkillEffectTable = BeanManager.GetTableByName("skill.cskilleffect")
local PlayAttackerEffect = class("PlayAttackerEffect", Task)

function PlayAttackerEffect:Ctor(context, effectId)
  PlayAttackerEffect.super.Ctor(self)
  self._context = context
  self._effectId = effectId
  self._time = 0
  self._skillRecord = CSkillEffectTable:GetRecorder(effectId)
  if self._skillRecord then
    self._totalTime = self._skillRecord.time
  else
    self._totalTime = 0
  end
end

function PlayAttackerEffect:OnStart()
  self._time = 0
  local battlerEffectComponent = self._context._attacker:GetComponent(BattlerEffectComponent)
  battlerEffectComponent._effects:AddOnceEffect(self._effectId)
  if self._skillRecord and self._skillRecord.shackType == 1 then
    BattleSceneEffectUtility.SkillShack(self._context._world, self._context._attacker:GetComponent(BattlerPositionComponent)._orientation, self._skillRecord.shackOffset)
  end
end

function PlayAttackerEffect:OnUpdate(deltaTime)
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

function PlayAttackerEffect:GetCheckPoints()
  return self._totalTime - self._time
end

return PlayAttackerEffect
