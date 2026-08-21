local CommonShowIdleState = BaseClass("CommonShowIdleState" , require("RoleBehavior.BaseState"))
local M = CommonShowIdleState

function M:OnEnter(needPlay)
    if needPlay then
        self:_PlayAction(CS.GameX.EInteractActionBehaviorType.StandBy)
    end
    --self:_PlayAction(CS.GameX.EInteractActionBehaviorType.StandBy)
    if self._tickTimer then 
        self._tickTimer:Stop()
        self._tickTimer = nil 
    end
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