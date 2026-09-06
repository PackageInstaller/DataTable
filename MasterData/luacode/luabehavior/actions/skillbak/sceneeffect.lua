local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local ESceneEffectType = require("luabehavior.agent.esceneeffecttype")
local BattlerPositionComponent = require("logic.battle.component.battlerpositioncomponent")
local BattleSceneEffectComponent = require("logic.battle.component.battlesceneeffectcomponent")
local CSkillEffectTable = BeanManager.GetTableByName("skill.cskilleffect")
local SceneEffect = class("SceneEffect", Task)

function SceneEffect:Ctor(context, effectType, effectId)
  SceneEffect.super.Ctor(self)
  self._context = context
  self._effectType = effectType
  self._effectId = effectId
  self._time = 0
  self._totalTime = 0
  if effectId ~= 0 then
    self._totalTime = CSkillEffectTable:GetRecorder(effectId).time
  end
end

function SceneEffect:OnStart()
  self._time = 0
  if self._effectType == ESceneEffectType.EnemyScene then
    local battlerPositionComponent = self._context._skill:GetAttacker():GetComponent(BattlerPositionComponent)
    local bttleSceneEffectComponent = self._context._battleScene:GetComponent(BattleSceneEffectComponent)
    if 0 > battlerPositionComponent._orientation then
      bttleSceneEffectComponent._rightEffectId = self._effectId
      bttleSceneEffectComponent._needRefreshRightEffectId = true
    else
      bttleSceneEffectComponent._leftEffectId = self._effectId
      bttleSceneEffectComponent._needRefreshLeftEffectId = true
    end
  end
end

function SceneEffect:OnUpdate(deltaTime)
  self._time = self._time + deltaTime
  if self._time >= self._totalTime then
    self._time = self._totalTime
  end
  if self._time == self._totalTime then
    return TaskStatus.Success
  else
    return TaskStatus.Running
  end
end

function SceneEffect:GetCheckPoints()
  return self._totalTime - self._time
end

return SceneEffect
