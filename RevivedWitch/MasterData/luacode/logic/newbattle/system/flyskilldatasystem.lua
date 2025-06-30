-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/system/flyskilldatasystem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = require("ecs.system")
local FlySkillDataSystem = strictclass("FlySkillDataSystem", System)
FlySkillDataSystem.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FlySkillDataSystem, _ENV
  ((FlySkillDataSystem.super).Ctor)(self, ...)
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).FlySkillDataComponent)
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).PhysicsComponent)
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).TypeComponent)
end

FlySkillDataSystem.Destroy = function(self)
  -- function num : 0_1 , upvalues : FlySkillDataSystem
  ((FlySkillDataSystem.super).Destroy)(self)
end

FlySkillDataSystem.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local FlySkillDataComponent = (BattleECS.Components).FlySkillDataComponent
  local PhysicsComponent = (BattleECS.Components).PhysicsComponent
  local TypeComponent = (BattleECS.Components).TypeComponent
  for _,entity in ipairs(self._entitys) do
    local component = entity:GetComponent(FlySkillDataComponent)
    if component and component._randomNum ~= 0 then
      component._currentFlyFraps = component._currentFlyFraps + 1
      if component._onceFlyTime <= component._currentFlyFraps then
        (self._world):ChangeFlySkillEffectRadAndSpeed(entity._entityId)
        component._currentFlyFraps = fixedpoint_zero
      end
    end
    if component and component._colliderLifeTime > 0 and (component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ConfirmProp or component._skillEffectType == (FlySkillDataComponent.SkillEffectType).DefendFlyProp or component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ConfirmFlyProp) then
      component._colliderLifeCurrentTime = component._colliderLifeCurrentTime + 1
      if component._colliderLifeTime <= component._colliderLifeCurrentTime then
        component._colliderLifeCurrentTime = 0
        ;
        (entity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
        ;
        (entity:GetComponent(TypeComponent))._isNeedDestroy = true
        for i,v in ipairs((self._world)._playerSkillEffectEntityList) do
          if v._entityId == entity._entityId then
            (table.remove)((self._world)._playerSkillEffectEntityList, i)
            break
          end
        end
      end
    end
  end
end

return FlySkillDataSystem

