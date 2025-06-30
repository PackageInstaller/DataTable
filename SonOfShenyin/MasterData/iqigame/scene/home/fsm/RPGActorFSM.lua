-- chunkname: @IQIGame\\Scene\\Home\\FSM\\RPGActorFSM.lua

local m = class(nil, FiniteStateMachine)

function m:ctor(actor)
	self.actor = actor
end

function m:Update(deltaTime)
	if self.CurrentState then
		self.CurrentState:OnUpdate(deltaTime)
	end
end

function m:ChangeStateByName(stateName, args)
	local nextState = self.states[stateName]

	if nextState then
		self:ChangeState(nextState, args)
	end
end

function m:ChangeState(nextState, args)
	if self.CurrentState then
		self.CurrentState:OnExit()

		self.PreviousState = self.CurrentState
	end

	nextState:OnEnter(args)

	self.CurrentState = nextState
end

function m:GetCurrentStateName()
	return self.CurrentState.Name
end

return m
