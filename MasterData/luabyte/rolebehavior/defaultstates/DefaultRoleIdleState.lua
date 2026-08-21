local DefaultRoleIdleState = BaseClass("DefaultRoleIdleState",require("RoleBehavior.BaseState"))
local M = DefaultRoleIdleState

function M:OnEnter()
    self:_PlayAction(self._ctrl.idleType)
end

return DefaultRoleIdleState