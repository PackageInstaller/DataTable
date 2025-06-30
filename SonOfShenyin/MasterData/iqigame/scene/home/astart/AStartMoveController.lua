-- chunkname: @IQIGame\\Scene\\Home\\AStart\\AStartMoveController.lua

local AStartMoveController = {}

function AStartMoveController.New(go, actor)
	local o = Clone(AStartMoveController)

	o:Initialize(go, actor)

	return o
end

function AStartMoveController:Initialize(go, actor)
	self.gameObject = go
	self.actor = actor
	self.npcAutoMoveComponent = LuaUtility.GameObjectGetOrAddComponent(self.gameObject, typeof(IQIGame.Onigao.Game.Story.NPCAutoMoveComponent))

	function self.npcAutoMoveComponent.setSkeletonAnimationFlipXCallback(isFacingRight)
		self.actor:SetFlipX(isFacingRight)
	end

	function self.npcAutoMoveComponent.setSkeletonAnimationCallback(isWalking)
		self:SetAnimationOnMoving(isWalking)
	end

	self:InitMoveComponentProperties()
end

function AStartMoveController:InitMoveComponentProperties()
	self.npcAutoMoveComponent.radius = 0.01
	self.npcAutoMoveComponent.height = 2
	self.npcAutoMoveComponent.gravity = UnityEngine.Vector3.zero
	self.npcAutoMoveComponent.canMove = false
	self.npcAutoMoveComponent.maxSpeed = 5
	self.npcAutoMoveComponent.enableRotation = false
	self.npcAutoMoveComponent.pickNextWaypointDist = 2
	self.npcAutoMoveComponent.maxAcceleration = 50
	self.npcAutoMoveComponent.slowdownDistance = 0
	self.npcAutoMoveComponent.endReachedDistance = 0.01
	self.npcAutoMoveComponent.aiDestinationSetter.target = nil
	self.npcAutoMoveComponent.aiDestinationSetter.enabled = false
end

function AStartMoveController:StartMove(endPos, callBack)
	self:FacingTarget(endPos)
	self.npcAutoMoveComponent:StartOnceMove(endPos, function(isByForcedStop)
		self:SetAnimationOnMoving(false)

		if callBack then
			callBack()
		end
	end)
end

function AStartMoveController:StopAutoMove()
	self.npcAutoMoveComponent:StopMove()
end

function AStartMoveController:FacingTarget(target)
	local t = self.gameObject.transform
	local dotRightResult = Vector3.Dot(t.right, target - t.position)

	self.actor:SetFlipX(dotRightResult >= 0)
end

function AStartMoveController:SetAnimationOnMoving(isWalking)
	if isWalking then
		self.actor:PlayAnimation(self.walkingAnimateName, true)
	else
		self.actor:PlayAnimation(self.idleAnimateName, true)
	end
end

function AStartMoveController:SetWalkingAnimateName(animateName)
	self.walkingAnimateName = animateName
end

function AStartMoveController:SetIdleAnimateName(animateName)
	self.idleAnimateName = animateName
end

function AStartMoveController:SetSpeed(value)
	self.npcAutoMoveComponent.maxSpeed = value
end

function AStartMoveController:OnDestroy()
	self:StopAutoMove()

	self.gameObject = nil
	self.npcAutoMoveComponent = nil
end

return AStartMoveController
