local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EProjectileType = require("luabehavior.agent.eprojectiletype")
local ProjectileEffectComponent = require("logic.battle.component.projectileeffectcomponent")
local EntityFactory = require("logic.battle.entityfactory")
local CSkillEffectTable = BeanManager.GetTableByName("skill.cskilleffect")
local Projectile = class("Projectile", Task)

function Projectile:Ctor(context, effectType, effectId, projectileSpeedType)
  Projectile.super.Ctor(self)
  self._context = context
  self._effectType = effectType
  self._effectId = effectId
  self._projectileSpeedType = projectileSpeedType
  self._time = 0
  self._totalTime = 0
  if effectId ~= 0 then
    self._totalTime = CSkillEffectTable:GetRecorder(effectId).time
  end
  self._entity = 0
end

function Projectile:OnStart()
  self._time = 0
  self._entity = EntityFactory.CreateProjectileEffect(self._context._world, self._context._skill, self._effectType, self._effectId, self._projectileSpeedType)
end

function Projectile:OnUpdate(deltaTime)
  self._time = self._time + deltaTime
  if self._time >= self._totalTime then
    self._time = self._totalTime
  end
  local projectileEffectComponent = self._entity:GetComponent(ProjectileEffectComponent)
  projectileEffectComponent._time, projectileEffectComponent._totalTime = self._time, self._totalTime
  if self._time == self._totalTime then
    return Behavior_Status.Success
  else
    return Behavior_Status.Running
  end
end

function Projectile:OnEnd()
  if self._time ~= self._totalTime then
    local projectileEffectComponent = self._entity:GetComponent(ProjectileEffectComponent)
    projectileEffectComponent._time, projectileEffectComponent._totalTime = self._totalTime, self._totalTime
  end
end

function Projectile:GetCheckPoints()
  return self._totalTime - self._time
end

return Projectile
