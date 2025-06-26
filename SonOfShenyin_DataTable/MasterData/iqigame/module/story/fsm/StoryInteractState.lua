-- chunkname: @IQIGame\\Module\\Story\\FSM\\StoryInteractState.lua

StoryInteractState = class(nil, FSMState)
StoryInteractState.Name = "StoryInteractState"

function StoryInteractState:OnEnter()
	local storyPlayer = self.FSM.storyCharacter

	storyPlayer:StopMove()
end

function StoryInteractState:OnUpdate(deltaTime)
	return
end

function StoryInteractState:OnFixedUpdate(fixedDeltaTime)
	return
end

function StoryInteractState:OnExit()
	return
end

return StoryInteractState
