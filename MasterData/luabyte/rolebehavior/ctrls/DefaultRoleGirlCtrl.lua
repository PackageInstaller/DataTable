local DefaultRoleGirlCtrl = BaseClass("DefaultRoleGirlCtrl",require("RoleBehavior.BaseRoleBehaviorCtrl"))
local  M = DefaultRoleGirlCtrl

function M:__init(showGirl,heroId,startInteractType,idleInteractType)
    self.idleType = idleInteractType
    self.startType = startInteractType
    if self.idleType == nil then 
        Logger.LogError("idleType is nil ")
    end
    if self.startType == nil then 
        Logger.LogError("startType is nil ")
    end 
    self.transform = self._showGirl.transform 
    self.gameObject = self.transform.gameObject
    self._showGirl:SetStandOffset()
end

function  M:InitState()
    -- body
    self:AddState(RoleStateName.Born,require("RoleBehavior.DefaultStates.DefaultRoleStartState"),true)
    self:AddState(RoleStateName.SeatIdle,require("RoleBehavior.DefaultStates.DefaultRoleIdleState"))
end

return DefaultRoleGirlCtrl