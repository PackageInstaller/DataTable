local BaseState = BaseClass("BaseState")
local M = BaseState

function M:__init(ctrl,behaviorType)
    -- body
    self._ctrl = ctrl
    self._behaviorType = behaviorType
    self._curAnimPath = nil
    self._playCompleteHandler = Bind(self, self._OnPlayAnimComplete)
end

function M:OnEvent(eventName, ...)
    -- body

end

function M:OnEnter()
    -- body
end

function M:OnExit()
    -- body
end

function M:_PlayAction(intercatType)
    return IRoleActionMgr:ExcuteAction(self._ctrl.skinId, intercatType, self._playCompleteHandler)
end

function M:_PlayAnim(animPath, transitionDuration)
    -- body
    if not transitionDuration then
        transitionDuration = 0
    end
    self._curAnimPath = animPath
    local animLength = self._ctrl:GetGirl():ChangeAnimatorState(animPath, transitionDuration)
    if self._timer then
        self._timer:Stop()
    end
    self._timer = TimerManager:GetInstance():GetTimer(animLength, self._playCompleteHandler, nil, true)
    self._timer:Start()
end

function M:_OnPlayAnimComplete()
    -- body
    if self._timer then
        self._timer:Stop()
    end
end

function M:ChangeState(stateName, ...)
    if self._ctrl == nil then
        return
    end
    -- body
    self._ctrl:ChangeState(stateName, ...)
end

function M:OnDisable()
    if self._timer then
        self._timer:Stop()
    end
    self._timer = nil
end

function M:OnDispose()
    if not self._ctrl.isDisposed then
        --只有1个角色播放行为时，才需要销毁播放器
        if RoleBehaviorCtrl:GetInstance():GetRuningNum(self._ctrl.heroId) == 1 then 
            IRoleActionMgr:Stop(self._ctrl.heroId)
        end
    end
    
    -- body
    if self._timer then
        self._timer:Stop()
    end
    if self._ctrl then 
        self._ctrl.isDisposed = true
    end
    self._timer = nil
    self._ctrl = nil

end

return BaseState
