-- chunkname: @IQIGame\\Module\\Story\\FSM\\StoryIdleState.lua

StoryIdleState = class(nil, FSMState)
StoryIdleState.Name = "StoryIdleState"

function StoryIdleState:OnEnter()
	local storyCharacter = self.FSM.storyCharacter

	if storyCharacter:HasAnimation(storyCharacter.idleAnimationName) then
		storyCharacter:PlayAnimation(storyCharacter.idleAnimationName, true)
	end
end

function StoryIdleState:OnUpdate(deltaTime)
	return
end

function StoryIdleState:OnFixedUpdate(fixedDeltaTime)
	return
end

function StoryIdleState:OnExit()
	return
end

return StoryIdleState
