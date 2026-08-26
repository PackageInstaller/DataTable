-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionCancelPlaceCharacter.lua

module("modules.logic.scene.room.fsm.RoomTransitionCancelPlaceCharacter", package.seeall)

local RoomTransitionCancelPlaceCharacter = class("RoomTransitionCancelPlaceCharacter", SimpleFSMBaseTransition)

function RoomTransitionCancelPlaceCharacter:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomTransitionCancelPlaceCharacter:check()
	return true
end

function RoomTransitionCancelPlaceCharacter:onStart(param)
	self._param = param

	local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

	if tempCharacterMO then
		if tempCharacterMO:isTrainSourceState() or tempCharacterMO:isTraining() then
			self:_finish()
			GameFacade.showToast(ToastEnum.RoomUnUseTrainCharacter)

			return
		end

		local entity = self._scene.charactermgr:getCharacterEntity(tempCharacterMO.id, SceneTag.RoomCharacter)

		if tempCharacterMO.characterState == RoomCharacterEnum.CharacterState.Temp then
			self._toDestroyEntity = entity

			entity.characterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "close", 0, self._animDone, self)

			local disappearEffectGO = self._scene.go:spawnEffect(RoomScenePreloader.ResEffectPressingCharacter, nil, "disappearEffect", nil, 2.5)

			if disappearEffectGO then
				local posX, posY, posZ = transformhelper.getPos(entity.staticContainerGO.transform)

				transformhelper.setPos(disappearEffectGO.transform, posX, posY, posZ)

				local disappearEffectAnim = disappearEffectGO:GetComponent(RoomEnum.ComponentType.Animator)

				if disappearEffectAnim then
					disappearEffectAnim:Play("disappear", 0, 0)
				end
			end
		elseif tempCharacterMO.characterState == RoomCharacterEnum.CharacterState.Revert then
			RoomCharacterModel.instance:removeRevertCharacterMO()

			if entity then
				self._scene.charactermgr:moveTo(entity, tempCharacterMO.currentPosition)
			end

			self:_finish()
		end
	else
		self:_finish()
	end
end

function RoomTransitionCancelPlaceCharacter:_animDone()
	RoomCharacterModel.instance:removeTempCharacterMO()

	if self._toDestroyEntity then
		self._scene.charactermgr:destroyCharacter(self._toDestroyEntity)

		self._toDestroyEntity = nil
	end

	self:_finish()
end

function RoomTransitionCancelPlaceCharacter:_finish()
	RoomCharacterPlaceListModel.instance:clearSelect()
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterCanConfirm)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	self:onDone()
end

function RoomTransitionCancelPlaceCharacter:stop()
	return
end

function RoomTransitionCancelPlaceCharacter:clear()
	self._toDestroyEntity = nil
end

return RoomTransitionCancelPlaceCharacter
