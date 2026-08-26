-- chunkname: @modules/logic/room/entity/comp/RoomCharacterMoveComp.lua

module("modules.logic.room.entity.comp.RoomCharacterMoveComp", package.seeall)

local RoomCharacterMoveComp = class("RoomCharacterMoveComp", RoomBaseFollowPathComp)

function RoomCharacterMoveComp:ctor(entity)
	self.entity = entity
	self._forcePosition = nil
	self._forceLookDir = nil
	self._forceMoveState = nil
end

function RoomCharacterMoveComp:init(go)
	self.go = go
	self._scene = GameSceneMgr.instance:getCurScene()
	self._seeker = ZProj.AStarSeekWrap.Get(self.go)

	local mo = self.entity:getMO()

	self._seeker:SetTagTraversable(RoomEnum.AStarLayerTag.Water, mo:getCanWade())
	self._seeker:SetTagTraversable(RoomEnum.AStarLayerTag.NoWalkRoad, false)
	self:_updateCharacterMove()
end

function RoomCharacterMoveComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, self._updateCharacterMove, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.PauseCharacterMove, self._pauseCharacterMove, self)
	RoomMapController.instance:registerCallback(RoomEvent.CameraStateUpdate, self._cameraStateUpdate, self)
end

function RoomCharacterMoveComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, self._updateCharacterMove, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.PauseCharacterMove, self._pauseCharacterMove, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraStateUpdate, self._cameraStateUpdate, self)

	if not gohelper.isNil(self._seeker) then
		self._seeker:RemoveOnPathCall()
	end

	self._seeker = nil
end

function RoomCharacterMoveComp:_cameraTransformUpdate()
	return
end

function RoomCharacterMoveComp:forcePositionAndLookDir(position, lookDir, moveState)
	self._forcePosition = position
	self._forceLookDir = lookDir
	self._forceMoveState = moveState

	self:_updateCharacterMove()
end

function RoomCharacterMoveComp:clearForcePositionAndLookDir()
	self._forcePosition = nil
	self._forceLookDir = nil
	self._forceMoveState = nil

	self:_updateCharacterMove()
end

function RoomCharacterMoveComp:_updateCharacterMove()
	self:_updateMovingLookDir()
	self:_updateMovingPosition()
	self:_updateMovingState()
end

function RoomCharacterMoveComp:_cameraStateUpdate()
	local cameraState = self._scene.camera:getCameraState()

	if self._lastCameraState == RoomEnum.CameraState.OverlookAll then
		self._lastCameraState = cameraState

		local mo = self.entity:getMO()

		if mo then
			mo:setLockTime(0.5)
		end
	end

	self._lastCameraState = cameraState
end

function RoomCharacterMoveComp:_pauseCharacterMove(pauseTime)
	self.entity.followPathComp:stopMove()
end

function RoomCharacterMoveComp:_updateMovingLookDir()
	if self._forceLookDir then
		self.entity.characterspine:changeLookDir(self._forceLookDir)

		return
	end

	if self.entity.isPressing then
		return
	end

	local mo = self.entity:getMO()

	if not mo then
		return
	end

	local isLock = self._scene.character:isLock()

	if not isLock then
		local scene = GameSceneMgr.instance:getCurScene()
		local moveDir = mo:getMovingDir()

		if mo:getMoveState() ~= RoomCharacterEnum.CharacterMoveState.Move then
			return
		end

		local movingPosition = mo.currentPosition

		movingPosition = Vector3(movingPosition.x, movingPosition.y, movingPosition.z)

		local offsetPosition = movingPosition + Vector3.Normalize(Vector3(moveDir.x, 0, moveDir.y))
		local lookDir = self:getMoveToLookDirByPos(movingPosition, offsetPosition)

		self.entity.characterspine:changeLookDir(lookDir)
	end
end

function RoomCharacterMoveComp:getMoveToLookDirByPos(fromPosition, toPosition)
	local movingBendingPosition = RoomBendingHelper.worldToBendingSimple(fromPosition)
	local movingPositionScreen = self._scene.camera.camera:WorldToScreenPoint(movingBendingPosition)
	local offsetBendingPosition = RoomBendingHelper.worldToBendingSimple(toPosition)
	local offsetPositionScreen = self._scene.camera.camera:WorldToScreenPoint(offsetBendingPosition)

	if offsetPositionScreen.z > 0 then
		if not offsetPositionScreen.x then
			local offsetX = -offsetPositionScreen.x

			if movingPositionScreen.z > 0 then
				if not movingPositionScreen.x then
					local movingX = -movingPositionScreen.x
					local offset = offsetX - movingX

					if offset > 0.0001 then
						return SpineLookDir.Right
					else
						return SpineLookDir.Left
					end
				end
			end
		end
	end
end

function RoomCharacterMoveComp:_updateMovingState()
	if self._forceMoveState then
		self.entity.characterspine:changeMoveState(self._forceMoveState)

		return
	end

	if self.entity.isPressing then
		return
	end

	local mo = self.entity:getMO()

	if not mo then
		return
	end

	local isLock = self._scene.character:isLock()
	local moveState = mo:getMoveState()

	if isLock and moveState == RoomCharacterEnum.CharacterMoveState.Move then
		self.entity.characterspine:changeMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
	else
		self.entity.characterspine:changeMoveState(moveState)
	end
end

function RoomCharacterMoveComp:_updateMovingPosition()
	if self._forcePosition then
		self.entity:setLocalPos(self._forcePosition.x, self._forcePosition.y, self._forcePosition.z)

		return
	end

	if self.entity.isPressing then
		return
	end

	local mo = self.entity:getMO()

	if not mo then
		return
	end

	local curMoveState = mo:getMoveState()
	local curPosCodeId = mo:getPositionCodeId()
	local curIsMove = curMoveState == RoomCharacterEnum.CharacterMoveState.Move and mo:canMove()

	if curIsMove or self._lastMoveState ~= curMoveState or self._lastPositionCodeId ~= curPosCodeId then
		local lastIsMove = self._lastMoveState == RoomCharacterEnum.CharacterMoveState.Move

		self._lastMoveState = curMoveState

		local movingPosition = mo.currentPosition

		if movingPosition then
			self._lastPositionCodeId = curPosCodeId

			self.entity:setLocalPos(movingPosition.x, movingPosition.y, movingPosition.z)

			if self.entity.followPathComp:getCount() > 0 then
				self.entity.followPathComp:addPathPos(Vector3(movingPosition.x, movingPosition.y, movingPosition.z))
			end
		end

		if curIsMove then
			self.entity.followPathComp:moveByPathData()
		elseif lastIsMove then
			self.entity.followPathComp:stopMove()
		end
	end
end

function RoomCharacterMoveComp:getSeeker()
	return self._seeker
end

function RoomCharacterMoveComp:beforeDestroy()
	self:removeEventListeners()
end

return RoomCharacterMoveComp
