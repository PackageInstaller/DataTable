local System = require("ecs.system")
local DeadDisappearCountSystem = strictclass("DeadDisappearCountSystem", System)

function DeadDisappearCountSystem:Ctor(...)
  DeadDisappearCountSystem.super.Ctor(self, ...)
  self._utility = BattleECS.Utility.Utility
  table.insert(self._requiredComponents, BattleECS.Components.DeadDisappearCountComponent)
end

function DeadDisappearCountSystem:Destroy()
  DeadDisappearCountSystem.super.Destroy(self)
end

function DeadDisappearCountSystem:Update()
  local DeadDisappearCountComponent = BattleECS.Components.DeadDisappearCountComponent
  local TypeComponent = BattleECS.Components.TypeComponent
  local PhysicsComponent = BattleECS.Components.PhysicsComponent
  self._world:SetIsMonsterAllDeadDisapper(true)
  self._world:SetIsAllMonsterStateCanBeBattleEnd(true)
  for _, entity in ipairs(self._world._rightPlayerList) do
    if self._utility.IsRoleDead(entity) then
      local component = entity:GetComponent(DeadDisappearCountComponent)
      if not component._isDeadDisappear then
        component._deadCurrentCount = component._deadCurrentCount + 1
        if component._deadCurrentCount >= component._deadTotalCount then
          component._isDeadDisappear = true
          component._deadCurrentCount = 0
        else
          self._world:SetIsMonsterAllDeadDisapper(false)
        end
      end
      if not component._isBattleEnd then
        component._battleEndCurrentCount = component._battleEndCurrentCount + 1
        if component._battleEndCurrentCount >= component._battleEndTotalCount then
          component._isBattleEnd = true
          component._battleEndCurrentCount = 0
        else
          self._world:SetIsAllMonsterStateCanBeBattleEnd(false)
        end
      end
    end
  end
  for _, entity in ipairs(self._world._leftPlayerSummonList) do
    if self._utility.IsRoleDead(entity) then
      local component = entity:GetComponent(DeadDisappearCountComponent)
      if not component._isDeadDisappear then
        component._deadCurrentCount = component._deadCurrentCount + 1
        if component._deadCurrentCount >= component._deadTotalCount then
          component._isDeadDisappear = true
          component._deadCurrentCount = 0
          entity:GetComponent(TypeComponent)._isNeedDestroy = true
          entity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
        end
      end
    end
  end
  for _, entity in ipairs(self._world._rightPlayerSummonList) do
    if self._utility.IsRoleDead(entity) then
      local component = entity:GetComponent(DeadDisappearCountComponent)
      if not component._isDeadDisappear then
        component._deadCurrentCount = component._deadCurrentCount + 1
        if component._deadCurrentCount >= component._deadTotalCount then
          component._isDeadDisappear = true
          component._deadCurrentCount = 0
          entity:GetComponent(TypeComponent)._isNeedDestroy = true
          entity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
        end
      end
    end
  end
end

return DeadDisappearCountSystem
