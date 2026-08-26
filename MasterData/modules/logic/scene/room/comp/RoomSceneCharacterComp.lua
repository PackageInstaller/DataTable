-- chunkname: @modules/logic/scene/room/comp/RoomSceneCharacterComp.lua

module("modules.logic.scene.room.comp.RoomSceneCharacterComp", package.seeall)

local RoomSceneCharacterComp = class("RoomSceneCharacterComp", BaseSceneComp)

function RoomSceneCharacterComp:onInit()
	self._canMoveStateDict = {
		[RoomEnum.CameraState.Normal] = true,
		[RoomEnum.CameraState.Overlook] = true,
		[RoomEnum.CameraState.ThirdPerson] = true,
		[RoomEnum.CameraState.FirstPerson] = true,
		[RoomEnum.CameraState.InteractBuilding] = true
	}
end

function RoomSceneCharacterComp:init(sceneId, levelId)
	self._scene = self:getCurScene()
	self._lockUpdateTime = 0

	local cameraTrs = self._scene.camera.cameraTrs

	self._cameraRotation = RoomRotateHelper.getMod(cameraTrs.eulerAngles.y, 360)

	TaskDispatcher.runRepeat(self._onUpdate, self, 0)

	self._characterAnimalDict = {}
	self._characterAnimalClickDict = {}
	self._shadowOffset = Vector4.zero

	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.ClickCharacterInNormalCamera, self._clickCharacterInNormalCamera, self)
end

function RoomSceneCharacterComp:_cameraTransformUpdate()
	if RoomController.instance:isEditMode() then
		return
	end

	local cameraTrs = self._scene.camera.cameraTrs
	local currentRotation = RoomRotateHelper.getMod(cameraTrs.eulerAngles.y, 360)

	if math.abs(currentRotation - self._cameraRotation) > 1 or self._lockUpdateTime and self._lockUpdateTime > 0 and math.abs(currentRotation - self._cameraRotation) > 0.0001 then
		self._lockUpdateTime = 0.5
		self._cameraRotation = currentRotation
	end
end

function RoomSceneCharacterComp:_onUpdate()
	if RoomController.instance:isEditMode() then
		return
	end

	self:_updateAnimal()

	if not self._lockUpdateTime or self._lockUpdateTime <= 0 then
		self:_updateMove()
	else
		self._lockUpdateTime = self._lockUpdateTime - Time.deltaTime

		if self._lockUpdateTime <= 0 then
			RoomCharacterController.instance:tryMoveCharacterAfterRotateCamera()
		end
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.UpdateCharacterMove)
end

function RoomSceneCharacterComp:isLock()
	return self._lockUpdateTime and self._lockUpdateTime > 0
end

function RoomSceneCharacterComp:_updateMove()
	if RoomCritterController.instance:isPlayTrainEventStory() then
		return
	end

	local cameraState = self._scene.camera:getCameraState()

	if self._canMoveStateDict[cameraState] then
		local characterMOList = RoomCharacterModel.instance:getList()
		local deltaTime = Time.deltaTime

		for i, characterMO in ipairs(characterMOList) do
			characterMO:updateMove(deltaTime)
		end
	end
end

function RoomSceneCharacterComp:setCharacterAnimal(heroId, isAnimal)
	do return end

	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(heroId)

	if not roomCharacterMO then
		return
	end

	roomCharacterMO.isAnimal = isAnimal
	self._characterAnimalDict[heroId] = isAnimal and Time.time + RoomCharacterEnum.AnimalDuration or nil

	local entity = self._scene.charactermgr:getCharacterEntity(heroId, SceneTag.RoomCharacter)

	if not entity then
		return
	end

	if entity.characterspine then
		entity.characterspine:refreshAnimal()
	end
end

function RoomSceneCharacterComp:_updateAnimal()
	for heroId, time in pairs(self._characterAnimalDict) do
		if time < Time.time then
			self:setCharacterAnimal(heroId, false)
		end
	end

	for heroId, times in pairs(self._characterAnimalClickDict) do
		for i = #times, 1, -1 do
			local time = times[i]

			if time < Time.time then
				table.remove(times, i)
			end
		end
	end
end

function RoomSceneCharacterComp:_clickCharacterInNormalCamera(heroId)
	if RoomController.instance:isEditMode() then
		return
	end

	if self._characterAnimalDict[heroId] then
		return
	end

	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(heroId)
	local interactionId = roomCharacterMO:getCurrentInteractionId()

	if interactionId then
		RoomCharacterController.instance:startInteraction(interactionId, true)

		return
	end

	local isGainFaith = roomCharacterMO.currentFaith > 0 and RoomController.instance:isObMode()

	if isGainFaith then
		RoomCharacterController.instance:gainCharacterFaith({
			heroId
		})
		AudioMgr.instance:trigger(AudioEnum.Room.ui_home_board_upgrade)
	elseif RoomController.instance:isObMode() and RoomCharacterModel.instance:isShowFaithFull(heroId) and RoomCharacterController.instance:isCharacterFaithFull(heroId) then
		RoomCharacterController.instance:hideCharacterFaithFull(heroId)
		GameFacade.showToast(RoomEnum.Toast.GainFaithFull)
	end

	self._characterAnimalClickDict[heroId] = self._characterAnimalClickDict[heroId] or {}

	table.insert(self._characterAnimalClickDict[heroId], Time.time + RoomCharacterEnum.ClickInterval)

	local randomChange = RoomCharacterHelper.checkCharacterAnimalInteraction(heroId)

	if randomChange or #self._characterAnimalClickDict[heroId] >= RoomCharacterEnum.ClickTimes then
		self._characterAnimalClickDict[heroId] = nil

		self:setCharacterAnimal(heroId, true)
	else
		self:setCharacterTouch(heroId, true)

		if not isGainFaith then
			local entity = self._scene.charactermgr:getCharacterEntity(heroId, SceneTag.RoomCharacter)

			if entity then
				entity:playClickEffect()
			end
		end
	end
end

function RoomSceneCharacterComp:setCharacterTouch(heroId, isTouch)
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(heroId)

	if not roomCharacterMO then
		return
	end

	roomCharacterMO.isTouch = isTouch

	local entity = self._scene.charactermgr:getCharacterEntity(heroId, SceneTag.RoomCharacter)

	if not entity then
		return
	end

	if entity.characterspine then
		entity.characterspine:touch(isTouch)
	end

	if entity.followPathComp and entity.followPathComp:getCount() > 0 then
		roomCharacterMO:setLockTime(0.1)
	end
end

function RoomSceneCharacterComp:setShadowOffset(shadowOffset)
	self._shadowOffset = shadowOffset
end

function RoomSceneCharacterComp:getShadowOffset()
	return self._shadowOffset
end

function RoomSceneCharacterComp:onSceneClose()
	TaskDispatcher.cancelTask(self._onUpdate, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.ClickCharacterInNormalCamera, self._clickCharacterInNormalCamera, self)
end

return RoomSceneCharacterComp
