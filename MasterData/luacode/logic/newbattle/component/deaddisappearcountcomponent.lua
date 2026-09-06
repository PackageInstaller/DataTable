local Component = require("ecs.component")
local DeadDisappearCountComponent = dataclass("DeadDisappearCountComponent", Component)

function DeadDisappearCountComponent:Ctor(...)
  DeadDisappearCountComponent.super.Ctor(self, ...)
  self._deadTotalCount = 0
  self._deadCurrentCount = 0
  self._isDeadDisappear = false
  self._battleEndTotalCount = 0
  self._battleEndCurrentCount = 0
  self._isBattleEnd = false
end

return DeadDisappearCountComponent
