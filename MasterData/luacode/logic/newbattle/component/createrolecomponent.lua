local Component = require("ecs.component")
local CreaterRoleComponent = dataclass("CreaterRoleComponent", Component)

function CreaterRoleComponent:Ctor(...)
  CreaterRoleComponent.super.Ctor(self, ...)
  self._playerInfoList = {}
end

return CreaterRoleComponent
