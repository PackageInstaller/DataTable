local System = require("ecs.system")
local FlySkillDataSystem = strictclass("FlySkillDataSystem", System)

function FlySkillDataSystem:Ctor(...)
  FlySkillDataSystem.super.Ctor(self, ...)
  table.insert(self._requiredComponents, BattleECS.Components.FlySkillDataComponent)
  table.insert(self._requiredComponents, BattleECS.Components.PhysicsComponent)
  table.insert(self._requiredComponents, BattleECS.Components.TypeComponent)
end

function FlySkillDataSystem:Destroy()
  FlySkillDataSystem.super.Destroy(self)
end

function FlySkillDataSystem:Update()
  local FlySkillDataComponent = BattleECS.Components.FlySkillDataComponent
  local PhysicsComponent = BattleECS.Components.PhysicsComponent
  local TypeComponent = BattleECS.Components.TypeComponent
  for _, entity in ipairs(self._entitys) do
    local component = entity:GetComponent(FlySkillDataComponent)
    if component and component._randomNum ~= 0 then
      component._currentFlyFraps = component._currentFlyFraps + 1
      if component._currentFlyFraps >= component._onceFlyTime then
        self._world:ChangeFlySkillEffectRadAndSpeed(entity._entityId)
        component._currentFlyFraps = fixedpoint_zero
      end
    end
    if component and 0 < component._colliderLifeTime and (component._skillEffectType == FlySkillDataComponent.SkillEffectType.ConfirmProp or component._skillEffectType == FlySkillDataComponent.SkillEffectType.DefendFlyProp or component._skillEffectType == FlySkillDataComponent.SkillEffectType.ConfirmFlyProp) then
      component._colliderLifeCurrentTime = component._colliderLifeCurrentTime + 1
      if component._colliderLifeCurrentTime >= component._colliderLifeTime then
        component._colliderLifeCurrentTime = 0
        entity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
        entity:GetComponent(TypeComponent)._isNeedDestroy = true
        for i, v in ipairs(self._world._playerSkillEffectEntityList) do
          if v._entityId == entity._entityId then
            table.remove(self._world._playerSkillEffectEntityList, i)
            break
          end
        end
      end
    end
  end
end

return FlySkillDataSystem
