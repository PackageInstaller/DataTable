local this=oo.class(PetStateBase)
function this:OnEnter(_d)
    PetStateBase.OnEnter(self,_d);
end

function this:Update()
    PetStateBase.Update(self);
end

function this:OnExit()
    PetStateBase.OnExit(self);
end
return this;