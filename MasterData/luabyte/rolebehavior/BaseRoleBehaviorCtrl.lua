local BaseRoleBehaviorCtrl = BaseClass("BaseRoleBehaviorCtrl")
local M = BaseRoleBehaviorCtrl

function M:__init(showGril,heroId)
    -- body
    self.heroId = heroId 
    self.skinId = showGril.m_JSkin.id
    self._allState = {}
    self._curState = nil 
    self._showGirl = showGril 
    self._defaultStateName = nil 
    self._eventHandles = {}
    self.disposeCallback = nil 
    self._showGirl.onDisableCall = Bind(self,self._OnDisable)
    self._showGirl.onDestoryCall = Bind(self,self._OnMonoDestory)
    self.use = 0
    self.holdWeapon = false
    self.isDisposed = false
    -- self:Run()
end

function M:GetShowGirl()
    return self._showGirl
end

function M:_OnMonoDestory(showGirl)
    self._showGirl = nil
end

function M:_OnDisable(showGirl)
    for stateName, state in pairs(self._allState) do
        -- body
        if state then 
            state:OnDisable()
        end
    end
end

function  M:AddEvents()
    -- body
  
end


function M:RemoveEvents()

end


function  M:Run(firstState, ...)
    -- body
    if firstState ~= RoleStateName.None and firstState then 
        self:ChangeState(firstState,...)
    else
        if self._defaultStateName then
            self:ChangeState(self._defaultStateName)
        end 
    end
end

function  M:GetGirl()
    -- body
    return self._showGirl 
end

function  M:InitState()
    -- body

end

function M:AddState(stateName,stateClass,isDefault,...)
    -- body
    self._allState[stateName] = stateClass.New(self,...)
    if isDefault then 
        self._defaultStateName = stateName 
    end
end

function M:ChangeState(stateName, ...)
    -- body
    if self._curState then 
        self._curState:OnExit()
    end
    if IsNull(self._showGirl) then 
        return 
    end
    self._showGirl:CloseAllObj()
    if self._allState[stateName] then 
        self._allState[stateName]:OnEnter(...)
        self._curState = self._allState[stateName]
    end
end

function M:DestorySelf()
    if not IsNull(self._showGirl) then
        self._showGirl:DestorySelf()
    end
    self:OnDispose()
end

function M:OnDispose()
    if not IsNull( self._showGirl) and not self._showGirl.isDestoryed then 
        self._showGirl.onDisableCall = nil 
        GameUtil.DestroyGo(self._showGirl.gameObject)
    end
    self._showGirl = nil 
    -- body
    if self._allState then 
        for stateName, state in pairs(self._allState) do
            -- body
            if state then 
                state:OnDispose()
            end
        end
    end
    
    self:RemoveEvents()
    self._allState = nil 
    local call = self.disposeCallback
    self.disposeCallback = nil 
    if call then 
        call(self.heroId)
    end
    
end

function M:ShowWeapon(isShow)
    if isShow == nil then 
        isShow = false
    end
    if IsNull(self._showGirl) then 
        return 
    end
    if IsNull(self._showGirl.avatar) then 
        return 
    end
    self._showGirl.avatar:ShowWeapon(isShow)
end

return BaseRoleBehaviorCtrl