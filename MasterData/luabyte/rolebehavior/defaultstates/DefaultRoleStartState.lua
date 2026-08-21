local DefaultRoleStartState = BaseClass("DefaultRoleStartState",require("RoleBehavior.BaseState"))
local M = DefaultRoleStartState

function M:OnEnter()
    self:_PlayAction(self._ctrl.startType)
end

function M:_OnPlayAnimComplete()
    self:ChangeState(RoleStateName.Idle)
end

return DefaultRoleStartState