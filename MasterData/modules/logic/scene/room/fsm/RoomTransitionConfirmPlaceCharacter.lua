-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionConfirmPlaceCharacter.lua

module("modules.logic.scene.room.fsm.RoomTransitionConfirmPlaceCharacter", package.seeall)

local RoomTransitionConfirmPlaceCharacter = class("RoomTransitionConfirmPlaceCharacter", SimpleFSMBaseTransition)

function RoomTransitionConfirmPlaceCharacter:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomTransitionConfirmPlaceCharacter:check()
	return true
end

function RoomTransitionConfirmPlaceCharacter:onStart(param)
	self._param = param

	local tempCharacterMO = self._param.tempCharacterMO

	RoomCharacterController.instance:interruptInteraction(tempCharacterMO:getCurrentInteractionId())

	local curEntity = self._scene.charactermgr:getCharacterEntity(tempCharacterMO.id, SceneTag.RoomCharacter)

	if curEntity then
		self._scene.charactermgr:moveTo(curEntity, tempCharacterMO.currentPosition)
		curEntity:playConfirmEffect()
	end

	if not tempCharacterMO:isPlaceSourceState() and RoomModel.instance:getCharacterById(tempCharacterMO.id) then
		tempCharacterMO.sourceState = RoomCharacterEnum.SourceState.Place
	end

	RoomCharacterPlaceListModel.instance:clearSelect()
	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterCanConfirm)
	RoomMapController.instance:dispatchEvent(RoomEvent.ConfirmCharacter)
	self:onDone()
end

function RoomTransitionConfirmPlaceCharacter:stop()
	return
end

function RoomTransitionConfirmPlaceCharacter:clear()
	return
end

return RoomTransitionConfirmPlaceCharacter
