-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionUnUseCharacter.lua

module("modules.logic.scene.room.fsm.RoomTransitionUnUseCharacter", package.seeall)

local RoomTransitionUnUseCharacter = class("RoomTransitionUnUseCharacter", SimpleFSMBaseTransition)

function RoomTransitionUnUseCharacter:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomTransitionUnUseCharacter:check()
	return true
end

function RoomTransitionUnUseCharacter:onStart(param)
	self._param = param

	local tempCharacterMO = self._param.tempCharacterMO
	local anim = self._param.anim

	RoomCharacterController.instance:interruptInteraction(tempCharacterMO:getCurrentInteractionId())

	if tempCharacterMO and (tempCharacterMO:isTrainSourceState() or tempCharacterMO:isTraining()) then
		tempCharacterMO.sourceState = RoomCharacterEnum.SourceState.Train

		self:_animDone()
		GameFacade.showToast(ToastEnum.RoomUnUseTrainCharacter)

		return
	end

	local curEntity = self._scene.charactermgr:getCharacterEntity(tempCharacterMO.id, SceneTag.RoomCharacter)

	if anim and curEntity and curEntity.characterspine then
		curEntity.characterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "close", 0, self._animDone, self)

		local disappearEffectGO = self._scene.go:spawnEffect(RoomScenePreloader.ResEffectPressingCharacter, nil, "disappearEffect", nil, 2.5)

		if disappearEffectGO then
			local posX, posY, posZ = transformhelper.getPos(curEntity.staticContainerGO.transform)

			transformhelper.setPos(disappearEffectGO.transform, posX, posY, posZ)

			local disappearEffectAnim = disappearEffectGO:GetComponent(RoomEnum.ComponentType.Animator)

			if disappearEffectAnim then
				disappearEffectAnim:Play("disappear", 0, 0)
			end
		end
	else
		self:_animDone()
	end
end

function RoomTransitionUnUseCharacter:_animDone()
	local tempCharacterMO = self._param.tempCharacterMO

	if tempCharacterMO:isTrainSourceState() or tempCharacterMO:isTraining() then
		RoomCharacterModel.instance:placeTempCharacterMO()
	else
		local curEntity = self._scene.charactermgr:getCharacterEntity(tempCharacterMO.id, SceneTag.RoomCharacter)

		if curEntity then
			self._scene.charactermgr:destroyCharacter(curEntity)
		end

		RoomCharacterModel.instance:unUseRevertCharacterMO()
	end

	RoomCharacterPlaceListModel.instance:clearSelect()
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterCanConfirm)
	RoomMapController.instance:dispatchEvent(RoomEvent.UnUseCharacter)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	self:onDone()
end

function RoomTransitionUnUseCharacter:stop()
	return
end

function RoomTransitionUnUseCharacter:clear()
	return
end

return RoomTransitionUnUseCharacter
