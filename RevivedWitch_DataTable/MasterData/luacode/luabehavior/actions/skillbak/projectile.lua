-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/projectile.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EProjectileType = require("luabehavior.agent.eprojectiletype")
local ProjectileEffectComponent = require("logic.battle.component.projectileeffectcomponent")
local EntityFactory = require("logic.battle.entityfactory")
local CSkillEffectTable = (BeanManager.GetTableByName)("skill.cskilleffect")
local Projectile = class("Projectile", Task)
Projectile.Ctor = function(self, context, effectType, effectId, projectileSpeedType)
  -- function num : 0_0 , upvalues : Projectile, CSkillEffectTable
  ((Projectile.super).Ctor)(self)
  self._context = context
  self._effectType = effectType
  self._effectId = effectId
  self._projectileSpeedType = projectileSpeedType
  self._time = 0
  self._totalTime = 0
  if effectId ~= 0 then
    self._totalTime = (CSkillEffectTable:GetRecorder(effectId)).time
  end
  self._entity = 0
end

Projectile.OnStart = function(self)
  -- function num : 0_1 , upvalues : EntityFactory
  self._time = 0
  self._entity = (EntityFactory.CreateProjectileEffect)((self._context)._world, (self._context)._skill, self._effectType, self._effectId, self._projectileSpeedType)
end

Projectile.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : ProjectileEffectComponent, Behavior_Status
  self._time = self._time + deltaTime
  if self._totalTime <= self._time then
    self._time = self._totalTime
  end
  local projectileEffectComponent = (self._entity):GetComponent(ProjectileEffectComponent)
  projectileEffectComponent._time = self._time
  if self._time == self._totalTime then
    return Behavior_Status.Success
  else
    return Behavior_Status.Running
  end
end

Projectile.OnEnd = function(self)
  -- function num : 0_3 , upvalues : ProjectileEffectComponent
  if self._time ~= self._totalTime then
    local projectileEffectComponent = (self._entity):GetComponent(ProjectileEffectComponent)
    projectileEffectComponent._time = self._totalTime
  end
end

Projectile.GetCheckPoints = function(self)
  -- function num : 0_4
  return self._totalTime - self._time
end

return Projectile

