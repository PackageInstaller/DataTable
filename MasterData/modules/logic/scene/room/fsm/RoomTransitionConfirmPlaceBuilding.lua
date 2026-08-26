-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionConfirmPlaceBuilding.lua

module("modules.logic.scene.room.fsm.RoomTransitionConfirmPlaceBuilding", package.seeall)

local RoomTransitionConfirmPlaceBuilding = class("RoomTransitionConfirmPlaceBuilding", SimpleFSMBaseTransition)

function RoomTransitionConfirmPlaceBuilding:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomTransitionConfirmPlaceBuilding:check()
	return true
end

function RoomTransitionConfirmPlaceBuilding:onStart(param)
	self._param = param

	local buildingInfo = self._param.buildingInfo
	local tempBuildingMO = self._param.tempBuildingMO

	RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(tempBuildingMO.buildingId, tempBuildingMO.hexPoint, tempBuildingMO.rotate)

	local curEntity = self._scene.buildingmgr:getBuildingEntity(tempBuildingMO.id, SceneTag.RoomBuilding)

	if curEntity then
		self._scene.buildingmgr:moveTo(curEntity, tempBuildingMO.hexPoint)
		curEntity:refreshBuilding()
		curEntity:refreshRotation()
		curEntity:playSmokeEffect()
	end

	RoomBuildingController.instance:cancelPressBuilding()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, tempBuildingMO.id)
	RoomShowBuildingListModel.instance:clearSelect()
	RoomBuildingController.instance:dispatchEvent(RoomEvent.ConfirmBuilding, buildingInfo.defineId)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshResourceUIShow)
	self:onDone()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_fix)
	RoomBuildingController.instance:refreshBuildingOccupy()
end

function RoomTransitionConfirmPlaceBuilding:stop()
	return
end

function RoomTransitionConfirmPlaceBuilding:clear()
	return
end

return RoomTransitionConfirmPlaceBuilding
