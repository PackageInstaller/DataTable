-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionUnUseBuilding.lua

module("modules.logic.scene.room.fsm.RoomTransitionUnUseBuilding", package.seeall)

local RoomTransitionUnUseBuilding = class("RoomTransitionUnUseBuilding", SimpleFSMBaseTransition)

function RoomTransitionUnUseBuilding:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomTransitionUnUseBuilding:check()
	return true
end

function RoomTransitionUnUseBuilding:onStart(param)
	self._param = param

	local buildingInfos = self._param.buildingInfos
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()
	local builingInfo

	for i = 1, #buildingInfos do
		local curEntity = self._scene.buildingmgr:getBuildingEntity(buildingInfos[i].uid, SceneTag.RoomBuilding)

		if curEntity then
			curEntity:refreshRotation()
			curEntity:refreshBuilding()

			local buildingMO = curEntity:getMO()

			self._scene.buildingmgr:destroyBuilding(curEntity)

			if buildingMO then
				RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(buildingMO.buildingId, buildingMO.hexPoint, buildingMO.rotate)
				RoomCharacterController.instance:interruptInteraction(buildingMO:getCurrentInteractionId())
			end

			RoomMapBuildingModel.instance:removeBuildingMO(buildingMO)

			if tempBuildingMO and tempBuildingMO.id == curEntity.id then
				RoomMapBuildingModel.instance:removeTempBuildingMO()
			end
		end
	end

	self:onDone()
	RoomMapBuildingModel.instance:refreshAllOccupyDict()
	RoomBuildingController.instance:cancelPressBuilding()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomShowBuildingListModel.instance:clearSelect()
	RoomBuildingController.instance:dispatchEvent(RoomEvent.UnUseBuilding)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshResourceUIShow)
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
	RoomBuildingController.instance:refreshBuildingOccupy()
end

function RoomTransitionUnUseBuilding:_addBlockEntityList(targetList, addList)
	targetList = targetList or {}

	local blockEntity

	for i = 1, #addList do
		if not tabletool.indexOf(targetList, addList[i]) then
			table.insert(targetList, addList[i])
		end
	end

	return targetList
end

function RoomTransitionUnUseBuilding:stop()
	return
end

function RoomTransitionUnUseBuilding:clear()
	return
end

return RoomTransitionUnUseBuilding
