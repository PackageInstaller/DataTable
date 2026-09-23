--宠物状态基类
local this=oo.class()

function this:Init(_tweenType,_view)
    self.tweenType=_tweenType;
    self.lua=_view;
    self:CleanCache();
end

function this:GetPetTweenType()
    return self.tweenType or nil;
end

function this:GetStayTime()
    return self.stayTime;
end

function this:CleanCache()
    self.stayTime=0;
    self.stayTrigger=false;
    self.autoChangeTime=nil;
    self.playCount=nil;
    self.holdTime=nil;
    self.onceFullTime=nil;
    self.tempTime=0;
end

function this:OnEnter(_d)
    -- LogError("OnEnter------------->"..tostring(self.tweenType))
    self:CleanCache()
    if self.lua==nil then
        do return end;
    end
    if _d and _d.count>0 then --当前状态持续时间
        self.onceFullTime=self.lua.GetClipTime(self:GetPetTweenType());
        self.playCount=_d.count;
        self.autoChangeTime=self.onceFullTime*self.playCount;
        if PetActivityMgr:IsIdleState(self:GetPetTweenType())~=true then
            PetActivityMgr:SetDisUse(true);
        end
    else
        self.autoChangeTime=nil;
        self.playCount=nil;
        self.onceFullTime=nil;
    end
    local data=self.lua.GetData() or nil
    local holdTime=data and data:GetHoldTime(self:GetPetTweenType()) or 0;
    if holdTime~=nil and holdTime~=0 then
        self.holdTime=holdTime;
    else
        self.holdTime=0;
    end
    self.lua.Play(self:GetPetTweenType());
    EventMgr.Dispatch(EventType.PetActivity_TalkCond_Trigger,{id=self.lua.GetID(),type=self:GetPetTweenType(),trigger=PetTalkCondType.EnterState});
end

function this:Update()
    if self.lua==nil then
        do return end;
    end
    self.stayTime=self.stayTime+Time.deltaTime;
    self.tempTime=self.tempTime+Time.deltaTime;
    if self.playCount and self.playCount>1 and self.onceFullTime and self.onceFullTime<=self.tempTime then--循环动画次数
        self.lua.Play(self:GetPetTweenType());
        self.playCount=self.playCount-1;
        self.tempTime=0;
    end
    if self.autoChangeTime and self.autoChangeTime<self.stayTime and self.lua then
        -- self.lua.SetDefaultState();
        EventMgr.Dispatch(EventType.PetActivity_FSMState_Change,{id=self.lua.GetData():GetID(),state=self.lua.GetData():GetCurrAction(),emoji=self.lua.GetData():GetEmojis()})
    end
    if self.holdTime and self.stayTime>=self.holdTime and self.stayTrigger~=true then
        self.stayTrigger=true;
        EventMgr.Dispatch(EventType.PetActivity_TalkCond_Trigger,{id=self.lua.GetID(),type=self:GetPetTweenType(),trigger=PetTalkCondType.StayState});
    end
end

function this:OnExit()
    if self.lua==nil then
        do return end;
    end
    if self.autoChangeTime then
        PetActivityMgr:SetDisUse(false);
    end
    -- LogError("OnExit------------->"..tostring(self.tweenType))
    EventMgr.Dispatch(EventType.PetActivity_TalkCond_Trigger,{id=self.lua.GetID(),type=self:GetPetTweenType(),trigger=PetTalkCondType.ExitState});
    self:CleanCache()
end

return this;