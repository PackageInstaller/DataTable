--宠物的有限状态机管理
local this={};

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:Reset()
    self.currStateType=nil;
    self.currState=nil;
    self.stateMap=nil;
    self.currStateStayTime=0;
    PetActivityMgr:SetDisUse(false);
end

function this:GetStateStayTime()
    return self.currStateStayTime or 0;
end

function this:GetCurrStateType()
    return self.currStateType;
end

function this:AddState(_stateType,_petState)
    if self.stateMap==nil then
        self.stateMap={};
    end
    if self.currStateType==nil and self.currState==nil then
        self.currStateType=_stateType;
        self.currState=_petState;
    end
    if _stateType and _petState and self.stateMap[_stateType]==nil then
        self.stateMap[_stateType]=_petState;
    end
end

function this:RemoveState(_stateType)
    if _stateType and self.stateMap and self.stateMap[_stateType] then
        self.stateMap[_stateType]=nil;
    end
end

function this:ChangeState(_stateType,_d)
    if _stateType==self.currStateType then
        do return end
    end
    if self.stateMap and self.stateMap[_stateType]==nil then
        LogError("不存在状态："..tostring(_stateType));
        do return end
    end
    if self.currState then
        self.currState:OnExit();
    end
    self.currStateType=_stateType;
    self.currState=self.stateMap[_stateType];
    self.currState:OnEnter(_d);
    self.currStateStayTime=0;
end

function this:Update()
    if self.currState then
        self.currState:Update();
        self.currStateStayTime=self.currStateStayTime+Time.deltaTime;
    end
end

return this;