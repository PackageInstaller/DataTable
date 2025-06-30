-- chunkname: @IQIGame\\Module\\Story\\StoryCharacterAutoMoveController.lua

local E_AutoMoveTargetType = {
	Position = 3,
	Object = 2,
	NPC = 1
}
local StoryCharacterAutoMoveController = {}
local Axis = {
	x = 1,
	y = 2
}

function StoryCharacterAutoMoveController.New(gameObject, storyCharacter)
	local obj = Clone(StoryCharacterAutoMoveController)

	obj:Init(gameObject, storyCharacter)

	return obj
end

function StoryCharacterAutoMoveController:Init(gameObject, storyCharacter)
	self.gameObject = gameObject
	self.storyCharacter = storyCharacter
	self.npcID = storyCharacter.npcID
	self.isMoving = false
	self.npcAutoMoveComponent = LuaUtility.GameObjectGetOrAddComponent(self.gameObject, typeof(IQIGame.Onigao.Game.Story.NPCAutoMoveComponent))

	self:InitMoveComponentProperties()

	function self.npcAutoMoveComponent.setSkeletonAnimationFlipXCallback(isFacingRight)
		if self.moveInfo ~= nil then
			self.storyCharacter:SetFlipX(isFacingRight)
		end
	end

	function self.npcAutoMoveComponent.setSkeletonAnimationCallback(isWalking)
		self:SetAnimationOnMoving(isWalking)
	end
end

function StoryCharacterAutoMoveController:InitMoveComponentProperties()
	self.npcAutoMoveComponent.radius = 0.7
	self.npcAutoMoveComponent.height = 2
	self.npcAutoMoveComponent.gravity = UnityEngine.Vector3.zero
	self.npcAutoMoveComponent.canMove = false
	self.npcAutoMoveComponent.maxSpeed = 5
	self.npcAutoMoveComponent.enableRotation = false
	self.npcAutoMoveComponent.pickNextWaypointDist = 1
	self.npcAutoMoveComponent.maxAcceleration = 50
	self.npcAutoMoveComponent.slowdownDistance = 0
	self.npcAutoMoveComponent.endReachedDistance = 2
	self.npcAutoMoveComponent.aiDestinationSetter.target = nil
	self.npcAutoMoveComponent.aiDestinationSetter.enabled = false
end

function StoryCharacterAutoMoveController:Dispose()
	self:StopAutoMove()

	self.storyCharacter = nil
	self.gameObject = nil
	self.npcAutoMoveComponent = nil
	self.autoMoveNPCInstance = nil
	self.moveInfo = nil
end

function StoryCharacterAutoMoveController:StartAutoMove(autoMoveTargetType, moveTargetInfo, autoMoveNPCInstance, moveInfo)
	self.isMoving = false
	self.autoMoveNPCInstance = autoMoveNPCInstance

	if autoMoveTargetType == E_AutoMoveTargetType.NPC then
		self:MoveToNPC(moveTargetInfo, moveInfo)
	elseif autoMoveTargetType == E_AutoMoveTargetType.Object then
		self:MoveToObject(moveTargetInfo, moveInfo)
	elseif autoMoveTargetType == E_AutoMoveTargetType.Position then
		self:MoveToPosition(moveTargetInfo, moveInfo)
	end

	return true
end

function StoryCharacterAutoMoveController:MoveToNPC(moveTargetInfo, moveInfo)
	local targetCharacterID = moveTargetInfo
	local targetCharacter = BehaviorTreeUtility.GetNPCByNPCID(targetCharacterID)

	if targetCharacter == nil then
		logError("BehaviorTreeUtility.StartAutoMove：无法找到 targetCharacter={0} 的角色.", targetCharacterID)

		return false
	end

	local targetTransform = targetCharacter.transform
	local pos = targetTransform.position

	if moveInfo.IsCloseMove then
		pos = self:CheckAxisToPos(pos, moveInfo.Axis, moveInfo.Offset)
		moveInfo.StopDistance = 0.001
	end

	self:SetAutoMoveInfo(moveInfo)

	if moveInfo.IsFollowingMove then
		self.npcAutoMoveComponent:StartFollowingMove(targetTransform, function(isByForcedStop)
			self:OnMoveComplete(isByForcedStop)
		end)
	else
		if StoryModule.isSkipState then
			LuaUtility.SetPositionWithGameObject(self.gameObject, pos.x, pos.y, pos.z)
			self:FacingTarget(targetTransform.position)
			self:OnMoveComplete(true)

			return
		end

		self:FacingTarget(pos)
		self.npcAutoMoveComponent:StartOnceMove(pos, function(isByForcedStop)
			if self.moveInfo.IsFacingTargetWhenEnd then
				self:FacingTarget(targetTransform.position)
			end

			self:OnMoveComplete(isByForcedStop)
		end)
	end

	self.isMoving = true
end

function StoryCharacterAutoMoveController:MoveToObject(moveTargetInfo, moveInfo)
	local targetTransform = moveTargetInfo
	local pos = targetTransform.position

	if moveInfo.IsCloseMove then
		pos = self:CheckAxisToPos(pos, moveInfo.Axis, moveInfo.Offset)
		moveInfo.StopDistance = 0.001
	end

	self:SetAutoMoveInfo(moveInfo)

	if moveInfo.IsFollowingMove then
		self.npcAutoMoveComponent:StartFollowingMove(targetTransform, function(isByForcedStop)
			self:OnMoveComplete(isByForcedStop)
		end)
	else
		if StoryModule.isSkipState then
			LuaUtility.SetPositionWithGameObject(self.gameObject, pos.x, pos.y, pos.z)
			self:FacingTarget(targetTransform.position)
			self:OnMoveComplete(true)

			return
		end

		self:FacingTarget(pos)
		self.npcAutoMoveComponent:StartOnceMove(pos, function(isByForcedStop)
			if self.moveInfo.IsFacingTargetWhenEnd then
				self:FacingTarget(targetTransform.position)
			end

			self:OnMoveComplete(isByForcedStop)
		end)
	end

	self.isMoving = true
end

function StoryCharacterAutoMoveController:MoveToPosition(moveTargetInfo, moveInfo)
	if moveInfo.IsFollowingMove then
		logError("BehaviorTreeUtility.StartAutoMove：Position类型的移动不支持跟随.")

		return false
	end

	local targetPosition = moveTargetInfo

	if moveInfo.IsCloseMove then
		targetPosition = self:CheckAxisToPos(targetPosition, moveInfo.Axis, moveInfo.Offset)
		moveInfo.StopDistance = 0.001
	end

	self:SetAutoMoveInfo(moveInfo)

	if StoryModule.isSkipState then
		LuaUtility.SetPositionWithGameObject(self.gameObject, targetPosition.x, targetPosition.y, targetPosition.z)
		self:FacingTarget(targetPosition)
		self:OnMoveComplete(true)

		return
	end

	self:FacingTarget(targetPosition)
	self.npcAutoMoveComponent:StartOnceMove(targetPosition, function(isByForcedStop)
		if self.moveInfo.IsFacingTargetWhenEnd then
			self:FacingTarget(targetPosition)
		end

		self:OnMoveComplete(isByForcedStop)
	end)

	self.isMoving = true
end

function StoryCharacterAutoMoveController:StopAutoMove()
	if self.isMoving then
		self.npcAutoMoveComponent:StopMove()

		self.isMoving = false
	end
end

function StoryCharacterAutoMoveController:OnMoveComplete(isClearAll)
	isClearAll = isClearAll ~= nil and isClearAll or false

	if self.autoMoveNPCInstance ~= nil then
		self.autoMoveNPCInstance:Complete()
	end

	if isClearAll then
		self:SetAnimationOnMoving(false)

		self.moveInfo = nil
		self.isMoving = false
	end
end

function StoryCharacterAutoMoveController:StartAutoMoveByTarget(targetPosition, complectCallback, successCallback, moveInfo)
	self:SetAutoMoveInfo(moveInfo)

	self.isMoving = true

	self.npcAutoMoveComponent:StartOnceMove(targetPosition, function(isByForcedStop)
		if complectCallback ~= nil then
			complectCallback(isByForcedStop)
		end
	end, function()
		if successCallback ~= nil then
			successCallback()
		end
	end)
end

function StoryCharacterAutoMoveController:SetAutoMoveInfo(moveInfo)
	self.moveInfo = moveInfo
	self.npcAutoMoveComponent.maxSpeed = moveInfo.MoveSpeed
	self.npcAutoMoveComponent.endReachedDistance = moveInfo.StopDistance
end

function StoryCharacterAutoMoveController:SetAnimationOnMoving(isWalking)
	if isWalking then
		self.storyCharacter:ChangeStateByName(StoryMoveState.Name)
	else
		self.storyCharacter:ChangeStateByName(StoryIdleState.Name)
	end
end

function StoryCharacterAutoMoveController:CheckAxisToPos(v, axis, offset)
	if axis == Axis.x then
		return Vector3.New(v.x + offset, v.y, v.z)
	elseif axis == Axis.y then
		return Vector3.New(v.x, v.y + offset, v.z)
	end
end

function StoryCharacterAutoMoveController:FacingTarget(target)
	local t = self.storyCharacter.transform
	local dotRightResult = Vector3.Dot(t.right, target - t.position)

	self.storyCharacter:SetFlipX(dotRightResult >= 0)
end

return StoryCharacterAutoMoveController
