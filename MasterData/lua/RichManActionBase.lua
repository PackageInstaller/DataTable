local this=oo.class()

function this:Init(data)
	self.done=false;
	self.state=nil;
	self.data=data;
end

function this:Enter(playerCtrl)
end

function this:Update(playerCtrl)
	if self.done then
		return true;
	end
end

function this:SetState(state)
	self.state=state;
end

function this:GetState()
	return self.state;
end

function this:Stop()
	self.done=true;
end

function this:IsDone()
	return self.done;
end

return this;