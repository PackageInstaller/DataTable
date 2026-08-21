local CommonShowIdleStateCustom = BaseClass("CommonShowIdleStateCustom" , require("RoleBehavior.States.CommonShow.CommonShowIdleState"))
local M = CommonShowIdleStateCustom
--无武器idle
local BehaviorIdleNoWeapon = CS.GameX.EInteractActionBehaviorType.StandBy

function M:OnEnter(needPlay)
    if needPlay then
        --有武器IDLE
        if self._ctrl.holdWeapon then 
            self:_PlayAction(self._behaviorType)
        else --无武器IDLE
            self:_PlayAction(BehaviorIdleNoWeapon)
        end      
    end
    if self._tickTimer then 
        self._tickTimer:Stop()
        self._tickTimer = nil 
    end
    self._time = 0
    self._tickTimer= TimerManager:GetInstance():GetTimer(1,self.Update,self,false)
    self._tickTimer:Start()
end

function M:OnDispose()
    if self._tickTimer then 
        self._tickTimer:Stop()
        self._tickTimer = nil 
    end
    M.super.OnDispose(self)
end

function M:Update()
    self._time = self._time + 1
    --15秒之后切换随机状态
    if  self._time == self._ctrl._randomTime then
        self:ChangeState(RoleStateName.RamdonShow)
    end

    --大于5秒，则会自动转回来
    if Time.realtimeSinceStartup - self._ctrl:GetLastOperateTime() > 20 then 
        self._ctrl:GirlRotationBack()
        self._startTime = Time.realtimeSinceStartup
    end
end

function M:OnDisable()
    M.super.OnDisable(self)
    if self._tickTimer then 
        self._tickTimer:Stop()
        self._tickTimer = nil 
    end
end

function M:OnExit()
    if self._tickTimer then 
        self._tickTimer:Stop()
        self._tickTimer = nil 
    end
end


return M 