local CommonShowRandomStateCustom = BaseClass("CommonShowRandomStateCustom" , require("RoleBehavior.BaseState"))
local M = CommonShowRandomStateCustom

function M:OnEnter()
    self:_PlayAction(CS.GameX.EInteractActionBehaviorType.DevelopRandomShow)
end

function M:_OnPlayAnimComplete()
    self:ChangeState(RoleStateName.Idle)
end

return M 