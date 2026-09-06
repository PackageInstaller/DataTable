local System = require("ecs.system")
local BehaviorSystem = strictclass("BehaviorSystem", System)

function BehaviorSystem:Ctor(...)
  BehaviorSystem.super.Ctor(self, ...)
  table.insert(self._requiredComponents, BattleECS.Components.BehaviorComponent)
end

function BehaviorSystem:Destroy()
  BehaviorSystem.super.Destroy(self)
end

function BehaviorSystem:Update()
  local BehaviorComponent = BattleECS.Components.BehaviorComponent
  for _, entity in ipairs(self._entitys) do
    entity:GetComponent(BehaviorComponent)._behavior:Exec3(0)
  end
end

return BehaviorSystem
