-- chunkname: @modules/logic/scene/room/comp/RoomSceneFSMComp.lua

module("modules.logic.scene.room.comp.RoomSceneFSMComp", package.seeall)

local RoomSceneFSMComp = class("RoomSceneFSMComp", BaseSceneComp)

function RoomSceneFSMComp:onInit()
	return
end

function RoomSceneFSMComp:init(sceneId, levelId)
	self._scene = self:getCurScene()
	self._context = {}
	self._fsm = SimpleFSM.New(self._context)

	if RoomController.instance:isEditMode() then
		self._fsm:registerState(RoomEditStateIdle.New(RoomEnum.FSMEditState.Idle))
		self._fsm:registerState(RoomEditStatePlaceConfirm.New(RoomEnum.FSMEditState.PlaceConfirm))
		self._fsm:registerState(RoomEditStateBackConfirm.New(RoomEnum.FSMEditState.BackConfirm))
		self._fsm:registerState(RoomEditStatePlaceConfirm.New(RoomEnum.FSMEditState.PlaceBuildingConfirm))
		self._fsm:registerState(SimpleFSMBaseState.New(RoomEnum.FSMEditState.WaterReform))

		local placeJomps = {
			RoomEnum.FSMEditState.BackConfirm
		}
		local blackJomps = {
			RoomEnum.FSMEditState.BackConfirm,
			RoomEnum.FSMEditState.PlaceConfirm
		}

		self._fsm:registerTransition(RoomTransitionConfirmPlaceBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmPlaceBlock, placeJomps))
		self._fsm:registerTransition(RoomTransitionConfirmPlaceBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmPlaceBlock, placeJomps))
		self._fsm:registerTransition(RoomTransitionCancelPlaceBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelPlaceBlock, placeJomps))
		self._fsm:registerTransition(RoomTransitionCancelPlaceBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelPlaceBlock, placeJomps))
		self._fsm:registerTransition(RoomTransitionTryPlaceBlock.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.PlaceConfirm, RoomSceneEvent.TryPlaceBlock))
		self._fsm:registerTransition(RoomTransitionTryPlaceBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.PlaceConfirm, RoomSceneEvent.TryPlaceBlock))
		self._fsm:registerTransition(RoomTransitionTryPlaceBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.PlaceConfirm, RoomSceneEvent.TryPlaceBlock))
		self._fsm:registerTransition(RoomTransitionTryBackBlock.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.BackConfirm, RoomSceneEvent.TryBackBlock, blackJomps))
		self._fsm:registerTransition(RoomTransitionTryBackBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.BackConfirm, RoomSceneEvent.TryBackBlock, blackJomps))
		self._fsm:registerTransition(RoomTransitionConfirmBackBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmBackBlock, blackJomps))
		self._fsm:registerTransition(RoomTransitionConfirmBackBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmBackBlock, blackJomps))
		self._fsm:registerTransition(RoomTransitionCancelBackBlock.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelBackBlock, blackJomps))
		self._fsm:registerTransition(RoomTransitionCancelBackBlock.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelBackBlock, blackJomps))
		self._fsm:registerTransition(RoomTransitionTryPlaceBuilding.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomSceneEvent.TryPlaceBuilding))
		self._fsm:registerTransition(RoomTransitionConfirmPlaceBuilding.New(RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.ConfirmPlaceBuilding))
		self._fsm:registerTransition(RoomTransitionCancelPlaceBuilding.New(RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CancelPlaceBuilding))
		self._fsm:registerTransition(RoomTransitionTryPlaceBuilding.New(RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomSceneEvent.TryPlaceBuilding))
		self._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMEditState.PlaceBuildingConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.UnUseBuilding))
		self._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.Idle, RoomSceneEvent.UnUseBuilding))
		self._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMEditState.BackConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.UnUseBuilding))
		self._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMEditState.PlaceConfirm, RoomEnum.FSMEditState.Idle, RoomSceneEvent.UnUseBuilding))
		self._fsm:registerTransition(RoomTransitionEnterWaterReform.New(RoomEnum.FSMEditState.Idle, RoomEnum.FSMEditState.WaterReform, RoomSceneEvent.EnterWaterReform))
		self._fsm:registerTransition(RoomTransitionCloseWaterReform.New(RoomEnum.FSMEditState.WaterReform, RoomEnum.FSMEditState.Idle, RoomSceneEvent.CloseWaterReform))
		self._fsm:start(RoomEnum.FSMEditState.Idle)
	elseif RoomController.instance:isObMode() then
		self._fsm:registerState(RoomObStateIdle.New(RoomEnum.FSMObState.Idle))
		self._fsm:registerState(RoomObStatePlaceConfirm.New(RoomEnum.FSMObState.PlaceBuildingConfirm))
		self._fsm:registerTransition(RoomTransitionTryPlaceBuilding.New(RoomEnum.FSMObState.Idle, RoomEnum.FSMObState.PlaceBuildingConfirm, RoomSceneEvent.TryPlaceBuilding))
		self._fsm:registerTransition(RoomTransitionConfirmPlaceBuilding.New(RoomEnum.FSMObState.PlaceBuildingConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.ConfirmPlaceBuilding))
		self._fsm:registerTransition(RoomTransitionCancelPlaceBuilding.New(RoomEnum.FSMObState.PlaceBuildingConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.CancelPlaceBuilding))
		self._fsm:registerTransition(RoomTransitionTryPlaceBuilding.New(RoomEnum.FSMObState.PlaceBuildingConfirm, RoomEnum.FSMObState.PlaceBuildingConfirm, RoomSceneEvent.TryPlaceBuilding))
		self._fsm:registerTransition(RoomTransitionUnUseBuilding.New(RoomEnum.FSMObState.PlaceBuildingConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.UnUseBuilding))
		self._fsm:registerState(RoomObStatePlaceConfirm.New(RoomEnum.FSMObState.PlaceCharacterConfirm))
		self._fsm:registerTransition(RoomTransitionTryPlaceCharacter.New(RoomEnum.FSMObState.Idle, RoomEnum.FSMObState.PlaceCharacterConfirm, RoomSceneEvent.TryPlaceCharacter))
		self._fsm:registerTransition(RoomTransitionConfirmPlaceCharacter.New(RoomEnum.FSMObState.PlaceCharacterConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.ConfirmPlaceCharacter))
		self._fsm:registerTransition(RoomTransitionCancelPlaceCharacter.New(RoomEnum.FSMObState.PlaceCharacterConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.CancelPlaceCharacter))
		self._fsm:registerTransition(RoomTransitionTryPlaceCharacter.New(RoomEnum.FSMObState.PlaceCharacterConfirm, RoomEnum.FSMObState.PlaceCharacterConfirm, RoomSceneEvent.TryPlaceCharacter))
		self._fsm:registerTransition(RoomTransitionUnUseCharacter.New(RoomEnum.FSMObState.PlaceCharacterConfirm, RoomEnum.FSMObState.Idle, RoomSceneEvent.UnUseCharacter))
		self._fsm:registerState(RoomObStateIdle.New(RoomEnum.FSMObState.CharacterBuildingShowTime))
		self._fsm:registerTransition(RoomShowTimeCharacterBuilding.New(RoomEnum.FSMObState.Idle, RoomEnum.FSMObState.CharacterBuildingShowTime, RoomSceneEvent.CharacterBuildingShowTime))
		self._fsm:start(RoomEnum.FSMObState.Idle)
	end
end

function RoomSceneFSMComp:triggerEvent(eventId, param)
	if self._fsm then
		self._fsm:triggerEvent(eventId, param)
	end
end

function RoomSceneFSMComp:getCurStateName()
	if self._fsm then
		return self._fsm.curStateName
	end
end

function RoomSceneFSMComp:isTransitioning()
	if self._fsm then
		return self._fsm.isTransitioning
	end
end

function RoomSceneFSMComp:onSceneClose()
	if self._fsm then
		self._fsm:clear()

		self._fsm = nil
	end

	self._context = nil
end

return RoomSceneFSMComp
