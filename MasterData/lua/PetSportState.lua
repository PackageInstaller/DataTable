local this=oo.class(PetStateBase)
function this:OnEnter(_d)
    PetStateBase.OnEnter(self,_d);
    if self.lua and self.lua.GetData()~=nil then
        EventMgr.Dispatch(EventType.PetActivity_SportScene_Check,{id=self.lua.GetID()});
    end
    self.isSport=true;
end

function this:Update()
    PetStateBase.Update(self);
    --检查剩余运动时间，超出则转回默认状态
    if self.lua and self.lua.GetData()~=nil then
        if TimeUtil:GetTime()>=PetActivityMgr:GetPetSportIntervalTimeStamp(self.lua.GetData()) then
            self.lua.CountAttr();
        end
        if self.lua.GetData():GetCurrAction()~=self.tweenType and self.isSport then
            -- LogError("PetSport Exit Update-------------------")
            self.isSport=false;
            --转换到对应状态
            EventMgr.Dispatch(EventType.PetActivity_FSMState_Change,{id=self.lua.GetData():GetID(),state=self.lua.GetData():GetCurrAction(),emoji=self.lua.GetData():GetEmojis()})
        end
    end
end

function this:OnExit()
    PetStateBase.OnExit(self);
    self.isSport=false;
    -- LogError("PetSport Exit-------------------")
    EventMgr.Dispatch(EventType.PetActivity_Exit_Sport);
    if self.lua and self.lua.GetData()~=nil then
        EventMgr.Dispatch(EventType.PetActivity_SportScene_Check,{id=self.lua.GetID()});
    end
end
return this;