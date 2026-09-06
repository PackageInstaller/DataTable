local Component = require("ecs.component")
local BehaviorComponent = dataclass("BehaviorComponent", Component)

function BehaviorComponent:Ctor(...)
  BehaviorComponent.super.Ctor(self, ...)
  self._behavior = {}
end

return BehaviorComponent
