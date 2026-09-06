local Component = require("ecs.component")
local RoleDeadCountComponent = dataclass("RoleDeadCountComponent", Component)

function RoleDeadCountComponent:Ctor(...)
  RoleDeadCountComponent.super.Ctor(self, ...)
  self._maxCount = 0
  self._currentCount = 0
  self._roleDeadDisappear = false
end

return RoleDeadCountComponent
