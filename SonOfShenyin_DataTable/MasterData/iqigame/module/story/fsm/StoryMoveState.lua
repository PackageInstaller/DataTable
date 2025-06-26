-- chunkname: @IQIGame\\Module\\Story\\FSM\\StoryMoveState.lua

StoryMoveState = class(nil, FSMState)
StoryMoveState.Name = "StoryMoveState"

function StoryMoveState:ctor()
	return
end

function StoryMoveState:OnEnter()
	return
end

local moveState
local lastState = 0

function StoryMoveState:OnUpdate(deltaTime)
	local storyCharacter = self.FSM.storyCharacter

	if storyCharacter.type == Constant.StoryCharacterType.Player then
		local storyPlayer = storyCharacter

		if storyPlayer:GetIsJoyStickControl() then
			if storyPlayer.joystickControl.joyStickDragSpeed > storyPlayer.moveToRunThreshold then
				moveState = 1
			else
				moveState = 2
			end

			if lastState ~= moveState then
				if moveState == 1 then
					storyPlayer:PlayAnimation(storyPlayer.runAnimationName, true)
				elseif moveState == 2 then
					storyPlayer:PlayAnimation(storyPlayer.walkAnimationName, true)
				end

				lastState = moveState
			end
		else
			storyPlayer:PlayAnimation(storyPlayer.autoMoveAnimation, true)
		end
	elseif storyCharacter.type == Constant.StoryCharacterType.RoleNPC then
		if storyCharacter:GetIsJoyStickControl() then
			storyCharacter:PlayAnimation(storyCharacter.joystickControl.ControlAnimation and storyCharacter.joystickControl.EnterAnimation or storyCharacter.walkAnimationName, true)
		else
			storyCharacter:PlayAnimation(storyCharacter.autoMoveAnimation, true)
		end
	end
end

function StoryMoveState:OnExit()
	lastState = 0
	moveState = nil
end

return StoryMoveState
