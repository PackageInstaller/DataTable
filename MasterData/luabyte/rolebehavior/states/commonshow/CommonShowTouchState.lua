--点击之后的行为播放 
local CommonShowTouchState = BaseClass("CommonShowTouchState",require("RoleBehavior.BaseState"))
local M = CommonShowTouchState
local HitPointType = require "Config.HitPointTypeConst"

function M:OnEnter(hitPointType)
    local isPlayOk = false 
    if hitPointType == HitPointType.Body or hitPointType == HitPointType.Chest then 
        isPlayOk = self:_PlayAction(CS.GameX.EInteractActionBehaviorType.BridgeTouchChest)
    elseif hitPointType == HitPointType.Head then 
        isPlayOk = self:_PlayAction(CS.GameX.EInteractActionBehaviorType.BridgeTouchHead)
    elseif hitPointType == HitPointType.Leg then 
        isPlayOk = self:_PlayAction(CS.GameX.EInteractActionBehaviorType.TouchLeg)
    else
        return 
    end
    if not isPlayOk then 
        self:_PlayAction(CS.GameX.EInteractActionBehaviorType.Defult_Click)
    end
end

function M:_OnPlayAnimComplete()
    self:ChangeState(RoleStateName.Idle)
end

return M 