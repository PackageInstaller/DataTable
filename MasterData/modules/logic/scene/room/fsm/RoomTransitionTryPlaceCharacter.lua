-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionTryPlaceCharacter.lua

module("modules.logic.scene.room.fsm.RoomTransitionTryPlaceCharacter", package.seeall)

local RoomTransitionTryPlaceCharacter = class("RoomTransitionTryPlaceCharacter", SimpleFSMBaseTransition)

function RoomTransitionTryPlaceCharacter:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomTransitionTryPlaceCharacter:check()
	return true
end

function RoomTransitionTryPlaceCharacter:onStart(param)
	self._param = param

	local heroId = self._param.heroId
	local press = self._param.press
	local uidrag = self._param.uidrag

	self._playingAnimName = nil
	self._playingAnimEntity = nil
	self._cameraTweening = false

	local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

	self._heroId = heroId or tempCharacterMO and tempCharacterMO.heroId

	if tempCharacterMO and heroId and tempCharacterMO.heroId ~= heroId then
		self:_replaceCharacter()
	elseif tempCharacterMO then
		self:_changeCharacter()
	else
		self:_placeCharacter()
	end

	tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

	if tempCharacterMO and not press and not uidrag then
		local currentPosition = tempCharacterMO.currentPosition
		local worldX = currentPosition.x
		local worldZ = currentPosition.z
		local characterFocus = RoomCharacterController.instance:getCharacterFocus()
		local paddingBottom

		if RoomHelper.isOutCameraFocusByPlaceCharacter(worldX, worldZ, (characterFocus == RoomCharacterEnum.CameraFocus.MoreShowList or nil) and 580) then
			self._cameraTweening = true

			RoomCharacterController.instance:tweenCameraFocus(worldX, worldZ, characterFocus, self._cameraDone, self)
		end
	end

	self:_checkDone()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientPlaceCharacter)
end

function RoomTransitionTryPlaceCharacter:_replaceCharacter()
	local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()
	local entity = self._scene.charactermgr:getCharacterEntity(tempCharacterMO.id, SceneTag.RoomCharacter)

	if tempCharacterMO.characterState == RoomCharacterEnum.CharacterState.Temp then
		RoomCharacterModel.instance:removeTempCharacterMO()

		if entity then
			self._scene.charactermgr:destroyCharacter(entity)
		end
	elseif tempCharacterMO.characterState == RoomCharacterEnum.CharacterState.Revert then
		RoomCharacterModel.instance:removeRevertCharacterMO()

		if entity then
			self._scene.charactermgr:moveTo(entity, tempCharacterMO.currentPosition)
			self:_delayCritterFollow(0.05)
		end
	end

	self:_placeCharacter()
end

function RoomTransitionTryPlaceCharacter:_changeCharacter()
	local position = self._param.position
	local isPressing = self._param.isPressing
	local uidrag = self._param.uidrag
	local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

	position = position or tempCharacterMO.currentPosition

	local previousPosition = tempCharacterMO.currentPosition

	RoomCharacterModel.instance:changeTempCharacterMO(position)

	if previousPosition ~= position then
		local entity = self._scene.charactermgr:getCharacterEntity(tempCharacterMO.id, SceneTag.RoomCharacter)

		if entity then
			if isPressing or uidrag or Vector3.Distance(previousPosition, position) < RoomBlockEnum.BlockSize then
				self._scene.charactermgr:moveTo(entity, tempCharacterMO.currentPosition)
				self:_delayCritterFollow(0.05)
			else
				self:_playCharacterTransferAnim(entity, previousPosition, tempCharacterMO.currentPosition)
			end
		end
	end
end

function RoomTransitionTryPlaceCharacter:_placeCharacter()
	local heroId = self._param.heroId
	local skinId = self._param.skinId
	local position = self._param.position
	local uidrag = self._param.uidrag
	local revertCharacterMO = RoomCharacterModel.instance:revertTempCharacterMO(heroId)

	if not revertCharacterMO then
		local tempCharacterMO = RoomCharacterModel.instance:addTempCharacterMO(heroId, position, skinId)

		RoomCharacterModel.instance:changeTempCharacterMO(position)

		local entity = self._scene.charactermgr:getCharacterEntity(tempCharacterMO.id, SceneTag.RoomCharacter)

		if entity == nil then
			entity = self._scene.charactermgr:spawnRoomCharacter(tempCharacterMO)
		end

		if not uidrag then
			self:_playCharacterInAnim(entity)
		end
	else
		position = revertCharacterMO.currentPosition

		local entity = self._scene.charactermgr:getCharacterEntity(revertCharacterMO.id, SceneTag.RoomCharacter)

		RoomCharacterModel.instance:changeTempCharacterMO(position)

		if entity then
			self._scene.charactermgr:moveTo(entity, revertCharacterMO.currentPosition)
			entity.characterspine:refreshAnimState()
			entity.interactActionComp:endIneract()
			self:_delayCritterFollow(0.05)
		end
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterCanConfirm)
end

function RoomTransitionTryPlaceCharacter:_playCharacterInAnim(entity)
	entity.charactermove:forcePositionAndLookDir(nil, SpineLookDir.Left, RoomCharacterEnum.CharacterMoveState.Move)

	self._playingAnimName = "open"
	self._playingAnimEntity = entity

	TaskDispatcher.runDelay(self._animDone, self, 0.5)
	self:_delayCritterFollow(0.5)
	entity.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, self._playingAnimName, 0)

	local cameraRotate = self._scene.camera:getCameraRotate()
	local rotationY = cameraRotate * Mathf.Rad2Deg
	local posX, posY, posZ = transformhelper.getPos(entity.go.transform)

	self:_playPlaceEffect(Vector3(posX, posY, posZ), rotationY)
	transformhelper.setLocalRotation(entity.go.transform, 0, rotationY, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_door_effect_put)
end

function RoomTransitionTryPlaceCharacter:_playCharacterTransferAnim(entity, fromPosition, toPosition)
	entity.charactermove:forcePositionAndLookDir(fromPosition, SpineLookDir.Left, RoomCharacterEnum.CharacterMoveState.Move)

	self._playingAnimName = "door"
	self._playingAnimEntity = entity
	self._toPosition = toPosition

	TaskDispatcher.runDelay(self._animDone, self, 0.8)
	self:_delayCritterFollow(0.8)
	entity.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, self._playingAnimName, 0, self._moveEntity, self)

	local cameraRotate = self._scene.camera:getCameraRotate()
	local rotationY = cameraRotate * Mathf.Rad2Deg

	self:_playPlaceEffect(fromPosition, rotationY, "right")
	self:_playPlaceEffect(toPosition, rotationY, "left")
	transformhelper.setLocalRotation(entity.go.transform, 0, rotationY, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_door_effect_move)
end

function RoomTransitionTryPlaceCharacter:_playPlaceEffect(position, rotationY, animName)
	local placeEffectGO = self._scene.go:spawnEffect(RoomScenePreloader.ResEffectPlaceCharacter, nil, "placeCharacterEffect", nil, 2)

	if placeEffectGO then
		local placeEffectGOTrs = placeEffectGO.transform

		transformhelper.setPos(placeEffectGOTrs, position.x, position.y, position.z)
		transformhelper.setLocalRotation(placeEffectGOTrs, 0, rotationY, 0)

		if not string.nilorempty(animName) then
			local animator = gohelper.findChildComponent(placeEffectGO, "anim", RoomEnum.ComponentType.Animator)

			if animator then
				animator:Play(animName)
			end
		end
	end
end

function RoomTransitionTryPlaceCharacter:_moveEntity()
	if self._playingAnimEntity and self._toPosition then
		self._playingAnimName = "out"

		self._playingAnimEntity.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, self._playingAnimName, 0)
		self._playingAnimEntity.charactermove:forcePositionAndLookDir(self._toPosition, SpineLookDir.Left, RoomCharacterEnum.CharacterMoveState.Move)
	end
end

function RoomTransitionTryPlaceCharacter:_skipAnim()
	TaskDispatcher.cancelTask(self._animDone, self)

	if self._playingAnimName and self._playingAnimEntity then
		if self._playingAnimName == "door" then
			self._playingAnimName = "out"
		end

		self._playingAnimEntity.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, self._playingAnimName, 1)
	end

	self:_animDone()
end

function RoomTransitionTryPlaceCharacter:_animDone()
	TaskDispatcher.cancelTask(self._animDone, self)

	if self._playingAnimEntity then
		self._playingAnimEntity.charactermove:clearForcePositionAndLookDir()

		if self._playingAnimEntity.characterspine then
			self._playingAnimEntity.characterspine:clearAnim()
		end
	end

	self._playingAnimName = nil
	self._playingAnimEntity = nil

	self:_checkDone()
end

function RoomTransitionTryPlaceCharacter:_cameraDone()
	self._cameraTweening = false

	self:_checkDone()
end

function RoomTransitionTryPlaceCharacter:_checkDone()
	if not self._playingAnimName and not self._cameraTweening then
		self:onDone()
	end
end

function RoomTransitionTryPlaceCharacter:_delayCritterFollow(delay)
	local charcterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)

	if charcterMO and charcterMO.trainCritterUid then
		self._scene.crittermgr:delaySetFollow(charcterMO.trainCritterUid, delay)
	end
end

function RoomTransitionTryPlaceCharacter:stop()
	return
end

function RoomTransitionTryPlaceCharacter:clear()
	TaskDispatcher.cancelTask(self._animDone, self)

	if self._playingAnimEntity then
		self._playingAnimEntity.charactermove:clearForcePositionAndLookDir()

		if self._playingAnimEntity.characterspine then
			self._playingAnimEntity.characterspine:clearAnim()
		end
	end
end

return RoomTransitionTryPlaceCharacter
