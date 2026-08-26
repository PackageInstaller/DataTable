-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionCancelPlaceBuilding.lua

module("modules.logic.scene.room.fsm.RoomTransitionCancelPlaceBuilding", package.seeall)

local RoomTransitionCancelPlaceBuilding = class("RoomTransitionCancelPlaceBuilding", SimpleFSMBaseTransition)

function RoomTransitionCancelPlaceBuilding:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomTransitionCancelPlaceBuilding:check()
	return true
end

function RoomTransitionCancelPlaceBuilding:onStart(param)
	self._param = param

	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if tempBuildingMO then
		RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(tempBuildingMO.buildingId, tempBuildingMO.hexPoint, tempBuildingMO.rotate)

		local entity = self._scene.buildingmgr:getBuildingEntity(tempBuildingMO.id, SceneTag.RoomBuilding)

		RoomResourceModel.instance:clearLightResourcePoint()

		if tempBuildingMO.buildingState == RoomBuildingEnum.BuildingState.Temp then
			RoomMapBuildingModel.instance:removeTempBuildingMO()

			if entity then
				local tempEntity = entity
				local tempMapMgr = self._scene.buildingmgr
				local fValue = tempEntity:getAlphaThresholdValue() or 0
				local duration = 0.16666666666666666

				tempEntity:playAnimator("close")
				tempEntity:tweenAlphaThreshold(fValue, 1, duration)
				tempMapMgr:removeUnitData(SceneTag.RoomBuilding, tempBuildingMO.id)
				tempEntity:removeEvent()
				TaskDispatcher.runDelay(function()
					tempMapMgr:destroyUnit(tempEntity)
				end, self, duration + 0.01)
			end
		elseif tempBuildingMO.buildingState == RoomBuildingEnum.BuildingState.Revert then
			local revertBuildingId, revertHexPoint, revertRotate = RoomMapBuildingModel.instance:removeRevertBuildingMO()

			if entity then
				self._scene.buildingmgr:moveTo(entity, revertHexPoint)
				entity:refreshRotation()
				entity:refreshBuilding()
			end

			RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, tempBuildingMO.id)
			RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(revertBuildingId, revertHexPoint, revertRotate)
		end

		RoomBuildingController.instance:cancelPressBuilding()
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshResourceUIShow)
	RoomShowBuildingListModel.instance:clearSelect()
	self:onDone()
	RoomBuildingController.instance:dispatchEvent(RoomEvent.ClientCancelBuilding)
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
	RoomBuildingController.instance:refreshBuildingOccupy()
end

function RoomTransitionCancelPlaceBuilding:stop()
	return
end

function RoomTransitionCancelPlaceBuilding:clear()
	return
end

return RoomTransitionCancelPlaceBuilding
