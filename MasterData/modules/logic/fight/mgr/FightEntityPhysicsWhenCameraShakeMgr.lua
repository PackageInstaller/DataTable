-- chunkname: @modules/logic/fight/mgr/FightEntityPhysicsWhenCameraShakeMgr.lua

module("modules.logic.fight.mgr.FightEntityPhysicsWhenCameraShakeMgr", package.seeall)

local FightEntityPhysicsWhenCameraShakeMgr = class("FightEntityPhysicsWhenCameraShakeMgr", FightBaseClass)
local SHAKE_GAP_TOLERANCE = 1
local WAIT_SHAKE_TIMEOUT = 30

function FightEntityPhysicsWhenCameraShakeMgr:onConstructor()
	self.cameraShake = CameraMgr.instance:getCameraShake()
	self.entityId2Value = {}

	self:_resetState()
	self:com_registUpdate(self.onUpdate)
end

function FightEntityPhysicsWhenCameraShakeMgr:startShake()
	self.shaking = true
	self.waitTimer = 0
	self.gapTimer = 0
end

function FightEntityPhysicsWhenCameraShakeMgr:onUpdate(deltaTime)
	if not self.shaking then
		return
	end

	if self.cameraShake:IsShaking() then
		self.gapTimer = 0

		if not self.isSet then
			self:_setSpinePhysicsInheritance(false)
		end
	elseif self.isSet then
		self.gapTimer = self.gapTimer + deltaTime

		if self.gapTimer >= SHAKE_GAP_TOLERANCE then
			self:_setSpinePhysicsInheritance(true)
			self:_resetState()
		end
	else
		self.waitTimer = self.waitTimer + deltaTime

		if self.waitTimer >= WAIT_SHAKE_TIMEOUT then
			self:_resetState()
		end
	end
end

function FightEntityPhysicsWhenCameraShakeMgr:_setSpinePhysicsInheritance(restore)
	for k, entity in pairs(FightGameMgr.entityMgr.entityDic) do
		local spine = entity.spine

		if spine then
			local skeletonAnim = spine:getSkeletonAnim()

			if skeletonAnim then
				self.entityId2Value[k] = self.entityId2Value[k] or {
					skeletonAnim.oriPhysicsPos,
					skeletonAnim.oriPhysicsRot
				}

				if restore then
					skeletonAnim.PhysicsPositionInheritanceFactor = self.entityId2Value[k][1]
					skeletonAnim.PhysicsRotationInheritanceFactor = self.entityId2Value[k][2]
				else
					skeletonAnim.PhysicsPositionInheritanceFactor = Vector2.zero
					skeletonAnim.PhysicsRotationInheritanceFactor = 0
				end
			end
		end
	end

	self.isSet = not restore
end

function FightEntityPhysicsWhenCameraShakeMgr:_resetState()
	self.shaking = false
	self.isSet = false
	self.waitTimer = 0
	self.gapTimer = 0
end

function FightEntityPhysicsWhenCameraShakeMgr:onDestructor()
	return
end

return FightEntityPhysicsWhenCameraShakeMgr
