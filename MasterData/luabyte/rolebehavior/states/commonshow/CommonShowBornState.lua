local CommonShowBornState = BaseClass("CommonShowBornState" , require("RoleBehavior.BaseState"))
local M = CommonShowBornState
CommonShowBornState.isPlayedInMainScene = false

function M:OnEnter()
    if self._ctrl.use == RoleUse.MainScene or self._ctrl.use == RoleUse.Shop then 
        if CommonShowBornState.isPlayedInMainScene then 
        self:ChangeState(RoleStateName.Idle,true)
            return
        end
        CommonShowBornState.isPlayedInMainScene = true
    end
    self:_PlayAction(CS.GameX.EInteractActionBehaviorType.ShowGirl_MainScene_Enter)
end

function M:_OnPlayAnimComplete()
    self:ChangeState(RoleStateName.Idle)
end

return M 