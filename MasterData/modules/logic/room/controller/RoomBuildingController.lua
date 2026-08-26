-- chunkname: @modules/logic/room/controller/RoomBuildingController.lua

module("modules.logic.room.controller.RoomBuildingController", package.seeall)

local RoomBuildingController = class("RoomBuildingController", BaseController)

function RoomBuildingController:onInit()
	self:clear()
end

function RoomBuildingController:reInit()
	self:clear()
end

function RoomBuildingController:clear()
	self._isBuildingListShow = false
	self._pressBuildingUid = nil
	self._pressBuildingHexPoint = nil
end

function RoomBuildingController:addConstEvents()
	RoomBuildingController.instance:registerCallback(RoomEvent.GuideFocusBuilding, self._onGuideFocusBuilding, self)
end

function RoomBuildingController:_onGuideFocusBuilding(buildingId)
	self:focusBuilding(tonumber(buildingId))
end

function RoomBuildingController:pressBuildingUp(pos, buildingUid)
	if buildingUid then
		self._pressBuildingUid = buildingUid
	end

	if not self._pressBuildingUid then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local entity = scene.buildingmgr:getBuildingEntity(self._pressBuildingUid, SceneTag.RoomBuilding)

	if not entity then
		return
	end

	if buildingUid then
		local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

		if not tempBuildingMO or tempBuildingMO.id ~= buildingUid then
			local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

			scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
				press = true,
				buildingUid = buildingUid,
				hexPoint = buildingMO.hexPoint,
				rotate = buildingMO.rotate
			})
		elseif tempBuildingMO then
			self:addWaitRefreshBuildingNearBlock(tempBuildingMO.buildingId, tempBuildingMO.hexPoint, tempBuildingMO.rotate)
		end

		entity:tweenUp()
		entity:refreshBuilding()
		RoomShowBuildingListModel.instance:setSelect(buildingUid)
	end

	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	self._pressBuildingHexPoint = self._pressBuildingHexPoint or tempBuildingMO.hexPoint

	local prePressBuildingHexPoint = self._pressBuildingHexPoint
	local pressBuildingHexPoint = RoomBendingHelper.screenPosToHex(pos)

	if not pressBuildingHexPoint then
		return
	end

	self._pressBuildingHexPoint = pressBuildingHexPoint

	if prePressBuildingHexPoint ~= pressBuildingHexPoint or buildingUid then
		RoomMapBuildingModel.instance:clearLightResourcePoint()
		RoomMapBuildingModel.instance:clearTempOccupyDict()
		RoomMapBuildingModel.instance:changeTempBuildingMO(pressBuildingHexPoint, tempBuildingMO.rotate)
		RoomResourceModel.instance:clearLightResourcePoint()
		self:refreshBuildingOccupy()
	end

	local worldPos = RoomBendingHelper.screenToWorld(pos)

	if worldPos then
		entity:setLocalPos(worldPos.x, 0, worldPos.y)
	end

	self:dispatchEvent(RoomEvent.PressBuildingUp)
	self:_cancelDelayBuildingDown()
end

function RoomBuildingController:refreshBuildingOccupy()
	local scene = GameSceneMgr.instance:getCurScene()
	local count = RoomConfig.instance:getMaxBuildingOccupyNum()

	for i = 1, count do
		local entity = scene.buildingmgr:spawnMapBuildingOccupy(i)

		if entity then
			entity:refreshTempOccupy()
		end
	end
end

function RoomBuildingController:addWaitRefreshBuildingNearBlock(buildingId, hexPoint, rotate)
	if not hexPoint then
		return
	end

	if self._waitMapBlockMOList then
		if not #self._waitMapBlockMOList then
			local count = 0

			self._waitMapBlockMOList, self._waitMapBlockMODict = RoomBlockHelper.getBlockMOListByPlaceBuilding(buildingId, hexPoint, rotate, self._waitMapBlockMOList, self._waitMapBlockMODict)

			if count <= 0 and self._waitMapBlockMOList and #self._waitMapBlockMOList > 0 then
				TaskDispatcher.runDelay(self._runWaitRefreshBuildingNearBlock, self, 0.017)
			end
		end
	end
end

function RoomBuildingController:_runWaitRefreshBuildingNearBlock()
	local nearBlockMOList = self._waitMapBlockMOList

	if nearBlockMOList and #nearBlockMOList > 0 then
		self._waitMapBlockMOList = nil
		self._waitMapBlockMODict = nil

		RoomMapController.instance:updateBlockReplaceDefineId(nearBlockMOList)

		for i, blockMO in ipairs(nearBlockMOList) do
			blockMO:refreshRiver()
		end

		local scene = GameSceneMgr.instance:getCurScene()
		local mapmgr = scene.mapmgr

		if mapmgr then
			for i, blockMO in ipairs(nearBlockMOList) do
				local entity = mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

				if entity then
					entity:refreshLand()
					entity:refreshRotation()
				end
			end
		end
	end
end

function RoomBuildingController:getPressBuildingHexPoint()
	return self._pressBuildingHexPoint
end

function RoomBuildingController:dropBuildingDown(pos)
	if not self._pressBuildingUid then
		return
	end

	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._pressBuildingUid)

	if not buildingMO then
		return
	end

	local hexPoint, rotate
	local expectHexPoint = pos and RoomBendingHelper.screenPosToHex(pos)

	if expectHexPoint then
		hexPoint, rotate = RoomBuildingHelper.getNearCanPlaceHexPoint(self._pressBuildingUid, expectHexPoint)
	end

	hexPoint = hexPoint or buildingMO.hexPoint
	rotate = rotate or buildingMO.rotate

	local scene = GameSceneMgr.instance:getCurScene()
	local param = {
		press = false,
		hexPoint = hexPoint,
		rotate = rotate
	}

	self:cancelPressBuilding(hexPoint, rotate)
	scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, param)
end

function RoomBuildingController:cancelPressBuilding(refreshBuildingHexPoint, refreshRotate)
	if not self._pressBuildingUid then
		return
	end

	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()
	local refreshBuildingId = tempBuildingMO and tempBuildingMO.buildingId
	local scene = GameSceneMgr.instance:getCurScene()
	local entity = scene.buildingmgr:getBuildingEntity(self._pressBuildingUid, SceneTag.RoomBuilding)

	if not entity then
		return
	end

	self._pressBuildingUid = nil
	self._pressBuildingHexPoint = nil

	if refreshBuildingId and refreshBuildingHexPoint and refreshRotate then
		RoomMapBuildingModel.instance:clearTempOccupyDict()
		self:addWaitRefreshBuildingNearBlock(refreshBuildingId, refreshBuildingHexPoint, refreshRotate)
	end

	if refreshBuildingHexPoint then
		local position = HexMath.hexToPosition(refreshBuildingHexPoint, RoomBlockEnum.BlockSize)

		entity:setLocalPos(position.x, 0, position.y)
	end

	entity:tweenDown()
	entity:refreshBuilding()
	self:_addDelayBuildingDown()
end

function RoomBuildingController:_addDelayBuildingDown()
	self:_cancelDelayBuildingDown()

	self._hasWaitingRunBuildingDown = false

	TaskDispatcher.runDelay(self._runDelayBuildingDown, self, 0.21)
end

function RoomBuildingController:_cancelDelayBuildingDown()
	if self._hasWaitingRunBuildingDown then
		self._hasWaitingRunBuildingDown = false

		TaskDispatcher.cancelTask(self._runDelayBuildingDown, self)
	end
end

function RoomBuildingController:_runDelayBuildingDown()
	self._hasWaitingRunBuildingDown = false

	self:dispatchEvent(RoomEvent.DropBuildingDown)
end

function RoomBuildingController:isPressBuilding()
	return self._pressBuildingUid
end

function RoomBuildingController:setBuildingListShow(isShow, isNotSelectBlock)
	self._isBuildingListShow = isShow

	local scene = GameSceneMgr.instance:getCurScene()

	if isShow then
		local cameraState = scene.camera:getCameraState()

		if cameraState == RoomEnum.CameraState.Normal then
			scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {})
		end
	end

	self:dispatchEvent(RoomEvent.BuildingListShowChanged, isShow)

	if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) then
		scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
	end

	if RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.BackConfirm) then
		scene.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	end

	if isNotSelectBlock ~= true then
		RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
end

function RoomBuildingController:isBuildingListShow()
	return self._isBuildingListShow
end

RoomBuildingController.SEND_BUY_BUILDING_RPC = "RoomBuildingController.SEND_BUY_BUILDING_RPC"

function RoomBuildingController:sendBuyManufactureBuildingRpc(buildingId)
	UIBlockMgr.instance:startBlock(RoomBuildingController.SEND_BUY_BUILDING_RPC)
	RoomRpc.instance:sendBuyManufactureBuildingRequest(buildingId, self._onBuyManufactureBuildingRpcReply, self)
end

function RoomBuildingController:_onBuyManufactureBuildingRpcReply(cmd, resultCode, msg)
	UIBlockMgr.instance:endBlock(RoomBuildingController.SEND_BUY_BUILDING_RPC)

	if resultCode == 0 then
		local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

		if tempBuildingMO and tempBuildingMO.buildingId == msg.buildingId then
			local hexPoint = tempBuildingMO.hexPoint
			local canConfirmParam, errorCode = RoomBuildingHelper.canConfirmPlace(tempBuildingMO.buildingId, hexPoint, tempBuildingMO.rotate, nil, nil, false, tempBuildingMO.levels, true)

			if canConfirmParam then
				RoomMapController.instance:useBuildingRequest(msg.buildingUid, tempBuildingMO.rotate, hexPoint.x, hexPoint.y)
			end
		end

		ViewMgr.instance:closeView(ViewName.RoomManufacturePlaceCostView)
	end
end

function RoomBuildingController:buyManufactureBuildingInfoReply(msg)
	local buildingInfos = {
		{
			use = false,
			rotate = 0,
			level = 0,
			uid = msg.buildingUid,
			defineId = msg.buildingId
		}
	}

	RoomModel.instance:updateBuildingInfos(buildingInfos)
	RoomModel.instance:updateBuildingInfos(buildingInfos)
	RoomInventoryBuildingModel.instance:addBuilding(buildingInfos)

	local changeSuccess, oldUid = RoomMapBuildingModel.instance:changeTempBuildingMOUid(msg.buildingUid, msg.buildingId)

	if changeSuccess then
		local scene = GameSceneMgr.instance:getCurScene()

		if scene and scene.buildingmgr then
			scene.buildingmgr:changeBuildingEntityId(oldUid, msg.buildingUid)
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.NewBuildingPush)
end

function RoomBuildingController:focusBuilding(buildingId)
	local list = RoomMapBuildingModel.instance:getBuildingMOList()

	for i, v in ipairs(list) do
		if v.buildingId == buildingId then
			self:tweenCameraFocusBuilding(v.buildingUid)

			return
		end
	end
end

function RoomBuildingController:tweenCameraFocusBuilding(buildingUid)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if not buildingMO then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local buildingConfigParam = RoomMapModel.instance:getBuildingConfigParam(buildingMO.buildingId)
	local offset = buildingConfigParam.offset
	local rotate = buildingMO.rotate
	local offsetX = offset.x * math.cos(rotate) + offset.y * math.sin(rotate)
	local offsetY = offset.y * math.cos(rotate) - offset.x * math.sin(rotate)
	local pos = HexMath.hexToPosition(buildingMO.hexPoint, RoomBlockEnum.BlockSize)

	scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		focusX = pos.x + offsetX,
		focusY = pos.y + offsetY
	})
end

function RoomBuildingController:tweenCameraFocusPart(partId, cameraState, zoom)
	partId = partId or 0
	cameraState = cameraState or RoomEnum.CameraState.Overlook

	local scene = GameSceneMgr.instance:getCurScene()
	local buildingGO = partId == 0 and scene.buildingmgr:getInitBuildingGO() or scene.buildingmgr:getPartBuildingGO(partId)

	if not buildingGO then
		return
	end

	local position = RoomBuildingHelper.getCenterPosition(buildingGO)
	local cameraParam = LuaUtil.deepCopy(scene.camera:getCameraParam())

	cameraParam.focusX = position.x
	cameraParam.focusY = position.z
	cameraParam.zoom = zoom

	if cameraState == RoomEnum.CameraState.Normal then
		cameraParam.isPart = true

		local realCameraParam = scene.camera:cameraParamToRealCameraParam(cameraParam, RoomEnum.CameraState.Normal)
		local partRealCameraParam = RoomInitBuildingHelper.getPartRealCameraParam(partId)

		if partRealCameraParam then
			for key, value in pairs(realCameraParam) do
				if partRealCameraParam[key] then
					realCameraParam[key] = partRealCameraParam[key]
				end
			end
		end

		scene.camera:switchCameraStateWithRealCameraParam(cameraState, realCameraParam)
	else
		scene.camera:switchCameraState(cameraState, cameraParam)
	end
end

RoomBuildingController.instance = RoomBuildingController.New()

return RoomBuildingController
