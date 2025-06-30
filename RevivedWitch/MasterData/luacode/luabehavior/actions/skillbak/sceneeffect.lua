-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/sceneeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local ESceneEffectType = require("luabehavior.agent.esceneeffecttype")
local BattlerPositionComponent = require("logic.battle.component.battlerpositioncomponent")
local BattleSceneEffectComponent = require("logic.battle.component.battlesceneeffectcomponent")
local CSkillEffectTable = (BeanManager.GetTableByName)("skill.cskilleffect")
local SceneEffect = class("SceneEffect", Task)
SceneEffect.Ctor = function(self, context, effectType, effectId)
  -- function num : 0_0 , upvalues : SceneEffect, CSkillEffectTable
  ((SceneEffect.super).Ctor)(self)
  self._context = context
  self._effectType = effectType
  self._effectId = effectId
  self._time = 0
  self._totalTime = 0
  if effectId ~= 0 then
    self._totalTime = (CSkillEffectTable:GetRecorder(effectId)).time
  end
end

SceneEffect.OnStart = function(self)
  -- function num : 0_1 , upvalues : ESceneEffectType, BattlerPositionComponent, BattleSceneEffectComponent
  self._time = 0
  if self._effectType == ESceneEffectType.EnemyScene then
    local battlerPositionComponent = (((self._context)._skill):GetAttacker()):GetComponent(BattlerPositionComponent)
    local bttleSceneEffectComponent = ((self._context)._battleScene):GetComponent(BattleSceneEffectComponent)
    if battlerPositionComponent._orientation < 0 then
      bttleSceneEffectComponent._rightEffectId = self._effectId
      bttleSceneEffectComponent._needRefreshRightEffectId = true
    else
      bttleSceneEffectComponent._leftEffectId = self._effectId
      bttleSceneEffectComponent._needRefreshLeftEffectId = true
    end
  end
end

SceneEffect.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  self._time = self._time + deltaTime
  if self._totalTime <= self._time then
    self._time = self._totalTime
  end
  if self._time == self._totalTime then
    return TaskStatus.Success
  else
    return TaskStatus.Running
  end
end

SceneEffect.GetCheckPoints = function(self)
  -- function num : 0_3
  return self._totalTime - self._time
end

return SceneEffect

