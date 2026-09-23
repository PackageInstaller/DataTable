local this=oo.class(PetStateBase)
function this:OnEnter(_d)
    PetStateBase.OnEnter(self,_d);
end

function this:Update()
    PetStateBase.Update(self);
    if self:GetStayTime()>g_PetMoveChangeTime then
        EventMgr.Dispatch(EventType.PetActivity_FSMState_Change,{id=self.lua.GetData():GetID(),state=PetTweenType.move,emoji=self.lua.GetData():GetEmojis()})
    end
end

function this:OnExit()
    PetStateBase.OnExit(self);
end
return this;
