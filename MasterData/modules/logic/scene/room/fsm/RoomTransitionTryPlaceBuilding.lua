-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionTryPlaceBuilding.lua

module("modules.logic.scene.room.fsm.RoomTransitionTryPlaceBuilding", package.seeall)

local RoomTransitionTryPlaceBuilding = class("RoomTransitionTryPlaceBuilding", SimpleFSMBaseTransition)

function RoomTransitionTryPlaceBuilding:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomTransitionTryPlaceBuilding:check()
	return true
end

function RoomTransitionTryPlaceBuilding:onStart(param)
	self._param = param

	local buildingUid = self._param.buildingUid
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not self._param.hexPoint and tempBuildingMO then
		::label_3_0::

		local hexPoint = tempBuildingMO.hexPoint
		local press = self._param.press
		local focus = self._param.focus
		local isRefreshBuiling = true

		if tempBuildingMO and buildingUid and tempBuildingMO.uid ~= buildingUid then
			self:_replaceBuilding()
		elseif tempBuildingMO then
			self:_changeBuilding()

			isRefreshBuiling = false
		else
			self:_placeBuilding()
		end

		if isRefreshBuiling then
			RoomBuildingController.instance:dispatchEvent(RoomEvent.ClientPlaceBuilding, buildingUid)
			self:_startDelayRefresh()
		end

		self:onDone()
		RoomBuildingController.instance:refreshBuildingOccupy()

		if hexPoint and (not press or focus) then
			local pos = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)

			if focus or self:_isOutScreen(pos) then
				local cameraParam = {}

				cameraParam.focusX = pos.x
				cameraParam.focusY = pos.y

				self._scene.camera:tweenCamera(cameraParam, nil, self.onDone, self)
			end
		end
	end
end

function RoomTransitionTryPlaceBuilding:_startDelayRefresh()
	if not self._isStartDelayResfresh then
		self._isStartDelayResfresh = true

		TaskDispatcher.runDelay(self._onDelayRefresh, self, 0.05)
	end
end

function RoomTransitionTryPlaceBuilding:_onDelayRefresh()
	self._isStartDelayResfresh = false

	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
end

function RoomTransitionTryPlaceBuilding:_isOutScreen(pos)
	return RoomHelper.isOutCameraFocus(pos)
end

function RoomTransitionTryPlaceBuilding:_replaceBuilding()
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	self:_addBuildingNearBlock(tempBuildingMO.buildingId, tempBuildingMO.hexPoint, tempBuildingMO.rotate)

	local entity = self._scene.buildingmgr:getBuildingEntity(tempBuildingMO.id, SceneTag.RoomBuilding)

	if tempBuildingMO.buildingState == RoomBuildingEnum.BuildingState.Temp then
		RoomMapBuildingModel.instance:removeTempBuildingMO()

		if entity then
			self._scene.buildingmgr:destroyBuilding(entity)
		end
	elseif tempBuildingMO.buildingState == RoomBuildingEnum.BuildingState.Revert then
		local revertBuildingId, revertHexPoint, revertRotate = RoomMapBuildingModel.instance:removeRevertBuildingMO()

		self:_addBuildingNearBlock(revertBuildingId, revertHexPoint, revertRotate)

		if entity then
			self._scene.buildingmgr:moveTo(entity, revertHexPoint)
			entity:refreshRotation()
			entity:refreshBuilding()
		end

		RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, tempBuildingMO.id)
	end

	self:_placeBuilding()
end

function RoomTransitionTryPlaceBuilding:_changeBuilding()
	local hexPoint = self._param.hexPoint
	local rotate = self._param.rotate
	local press = self._param.press
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	hexPoint = hexPoint or tempBuildingMO.hexPoint
	rotate = rotate or tempBuildingMO.rotate

	self:_addBuildingNearBlock(tempBuildingMO.buildingId, tempBuildingMO.hexPoint, tempBuildingMO.rotate)

	local previousHexPoint = HexPoint(tempBuildingMO.hexPoint.x, tempBuildingMO.hexPoint.y)
	local previousRotate = tempBuildingMO.rotate

	RoomMapBuildingModel.instance:changeTempBuildingMO(hexPoint, rotate)
	self:_addBuildingNearBlock(tempBuildingMO.buildingId, tempBuildingMO.hexPoint, tempBuildingMO.rotate)

	if previousHexPoint ~= hexPoint or press then
		local entity = self._scene.buildingmgr:getBuildingEntity(tempBuildingMO.id, SceneTag.RoomBuilding)

		if entity then
			self._scene.buildingmgr:moveTo(entity, hexPoint)
		end

		if not press then
			self:_playAnimatorOpen(entity)
		end
	end

	if previousRotate ~= rotate then
		local entity = self._scene.buildingmgr:getBuildingEntity(tempBuildingMO.id, SceneTag.RoomBuilding)

		if entity then
			entity:refreshRotation(true)
			entity:refreshBuilding()
		end
	end

	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, tempBuildingMO.id)
end

function RoomTransitionTryPlaceBuilding:_placeBuilding()
	local buildingUid = self._param.buildingUid
	local hexPoint = self._param.hexPoint
	local rotate = self._param.rotate
	local revertBuildingMO = RoomMapBuildingModel.instance:revertTempBuildingMO(buildingUid)

	if not revertBuildingMO then
		local inventoryBuildingMO = RoomInventoryBuildingModel.instance:getBuildingMOById(buildingUid)

		RoomMapBuildingModel.instance:addTempBuildingMO(inventoryBuildingMO, hexPoint)
	end

	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if tempBuildingMO then
		RoomMapBuildingModel.instance:changeTempBuildingMO(hexPoint, rotate)
		self:_addBuildingNearBlock(tempBuildingMO.buildingId, tempBuildingMO.hexPoint, tempBuildingMO.rotate)

		local entity = self._scene.buildingmgr:getBuildingEntity(tempBuildingMO.id, SceneTag.RoomBuilding)

		if entity then
			self._scene.buildingmgr:moveTo(entity, hexPoint)
			entity:refreshRotation()
			entity:refreshBuilding()

			if revertBuildingMO then
				self:_playAnimatorOpen(entity)
			end
		else
			entity = self._scene.buildingmgr:spawnMapBuilding(tempBuildingMO)

			self:_playAnimatorOpen(entity)
		end

		RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, tempBuildingMO.id)
	end

	self:onDone()
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshResourceUIShow)
end

function RoomTransitionTryPlaceBuilding:_addBuildingNearBlock(buildingId, hexPoint, rotate)
	if not hexPoint then
		return
	end

	RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(buildingId, hexPoint, rotate)
end

function RoomTransitionTryPlaceBuilding:_playAnimatorOpen(entity)
	if entity then
		entity:playAnimator("open")

		local toValue = entity:getAlphaThresholdValue() or 0

		entity:tweenAlphaThreshold(1, toValue, 0.5)
	end
end

function RoomTransitionTryPlaceBuilding:stop()
	return
end

function RoomTransitionTryPlaceBuilding:clear()
	return
end

return RoomTransitionTryPlaceBuilding
