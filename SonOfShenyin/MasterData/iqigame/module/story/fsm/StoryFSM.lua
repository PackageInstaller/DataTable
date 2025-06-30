-- chunkname: @IQIGame\\Module\\Story\\FSM\\StoryFSM.lua

StoryFSM = class(nil, FiniteStateMachine)

function StoryFSM:ctor(storyCharacter)
	self.storyCharacter = storyCharacter
end

function StoryFSM:Update(deltaTime)
	if self.CurrentState then
		self.CurrentState:OnUpdate(deltaTime)
	end
end

function StoryFSM:ChangeStateByName(stateName, changeEvent)
	local nextState = self.states[stateName]

	if nextState then
		self:ChangeState(nextState, changeEvent)
	end
end

function StoryFSM:ChangeState(nextState, changeEvent)
	if nextState == self.CurrentState then
		return
	end

	if changeEvent then
		changeEvent()
	end

	if self.CurrentState then
		self.CurrentState:OnExit()

		self.PreviousState = self.CurrentState
	end

	nextState:OnEnter()

	self.CurrentState = nextState
end

function StoryFSM:GetCurrentStateName()
	return self.CurrentState.Name
end

return StoryFSM
