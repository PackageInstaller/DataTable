-- chunkname: @modules/logic/room/controller/RoomTransportController.lua

module("modules.logic.room.controller.RoomTransportController", package.seeall)

local RoomTransportController = class("RoomTransportController", BaseController)

function RoomTransportController:onInit()
	self:clear()
end

function RoomTransportController:reInit()
	self:clear()
end

function RoomTransportController:clear()
	self:_removeEvents()
	RoomTransportPathModel.instance:clear()
	RoomMapTransportPathModel.instance:clear()
end

function RoomTransportController:init()
	self:_addEvents()
end

function RoomTransportController:_addEvents()
	if self._isInitAddEvent then
		return
	end
end

function RoomTransportController:_removeEvents()
	self._isInitAddEvent = false
end

function RoomTransportController:initPathData(roadInfos)
	RoomTransportPathModel.instance:initPath(roadInfos)
	RoomMapTransportPathModel.instance:initPath(roadInfos)
	RoomMapTransportPathModel.instance:updateSiteHexPoint()
end

RoomTransportController.SAME_EDIT_PATH_REQUEST = "RoomTransportController.SAME_EDIT_PATH_REQUEST"

function RoomTransportController:saveEditPath()
	local deleteIds = {}
	local savePathMOList = {}
	local tRoomMapTransportPathModel = RoomMapTransportPathModel.instance
	local tRoomTransportPathModel = RoomTransportPathModel.instance
	local pathMOList = tRoomTransportPathModel:getTransportPathMOList()

	for _, pathMO in ipairs(pathMOList) do
		local mapPathMO = tRoomMapTransportPathModel:getTransportPathMOBy2Type(pathMO.fromType, pathMO.toType)

		if mapPathMO and mapPathMO:isLinkFinish() then
			mapPathMO:updateCritterInfo(pathMO)
			mapPathMO:updateBuildingInfo(pathMO)

			mapPathMO.id = pathMO.id

			table.insert(savePathMOList, mapPathMO)
		elseif pathMO.id > 0 then
			table.insert(deleteIds, pathMO.id)

			local siteType = RoomTransportHelper.fromTo2SiteType(pathMO.fromType, pathMO.toType)

			RoomTransportHelper.saveQuickLink(siteType, false)
		end
	end

	local mpaPathMOList = tRoomMapTransportPathModel:getTransportPathMOList()
	local id = -1

	for _, mapPathMO in ipairs(mpaPathMOList) do
		if mapPathMO:isLinkFinish() then
			if not tabletool.indexOf(savePathMOList, mapPathMO) then
				mapPathMO.critterUid = 0
				mapPathMO.buildingUid = 0
				mapPathMO.buildingId = 0
				mapPathMO.buildingSkinId = 0
				mapPathMO.id = id
				id = id - 1

				table.insert(savePathMOList, mapPathMO)
			end

			if mapPathMO:getIsEdit() and mapPathMO:getIsQuickLink() ~= nil then
				local siteType = RoomTransportHelper.fromTo2SiteType(mapPathMO.fromType, mapPathMO.toType)

				RoomTransportHelper.saveQuickLink(siteType, mapPathMO:getIsQuickLink())
			end
		end
	end

	RoomMapTransportPathModel.instance:setList(savePathMOList)

	self._savePathDeleteOp = #deleteIds > 0
	self._savePathGeneraterOP = #savePathMOList > 0
	self._coutWaitSuccess = 0

	if self._savePathGeneraterOP then
		self._coutWaitSuccess = self._coutWaitSuccess + 1

		RoomRpc.instance:sendGenerateRoadRequest(savePathMOList, deleteIds, self._onGenerateRoadReply, self)
	elseif self._savePathDeleteOp then
		self._coutWaitSuccess = self._coutWaitSuccess + 1

		RoomRpc.instance:sendDeleteRoadRequest(deleteIds, self._onDeleteRoadReply, self)
	end

	if self._savePathGeneraterOP or self._savePathDeleteOp then
		RoomModel.instance:setEditFlag()
	end

	self:waitRefreshPathLineChanged()
	self:updateBlockUseState()
end

function RoomTransportController:_onDeleteRoadReply(cmd, resultCode, msg)
	self._savePathDeleteOp = false

	if resultCode == 0 then
		self._coutWaitSuccess = self._coutWaitSuccess - 1

		RoomTransportPathModel.instance:removeByIds(msg.ids)
		RoomMapTransportPathModel.instance:removeByIds(msg.ids)
	end

	self:_checkSaveEditPath()
end

function RoomTransportController:_onGenerateRoadReply(cmd, resultCode, msg)
	self._savePathGeneraterOP = false

	if resultCode == 0 then
		self._coutWaitSuccess = self._coutWaitSuccess - 1

		local roadInfos = msg.validRoadInfos

		RoomTransportPathModel.instance:removeByIds(msg.ids)
		RoomMapTransportPathModel.instance:removeByIds(msg.ids)
		RoomTransportPathModel.instance:initPath(roadInfos)
		RoomMapTransportPathModel.instance:initPath(roadInfos)
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
	end

	self:_checkSaveEditPath()
end

function RoomTransportController:deleteRoadReply(msg)
	self:deleteRoadByIds(msg.ids)
end

function RoomTransportController:deleteRoadByIds(ids)
	if not ids or #ids < 1 then
		return
	end

	RoomTransportPathModel.instance:removeByIds(ids)
	RoomMapTransportPathModel.instance:removeByIds(ids)
	RoomMapTransportPathModel.instance:updateSiteHexPoint()
	self:updateBlockUseState()
end

function RoomTransportController:allotCritterReply(msg)
	local info = {
		critterUid = msg.critterUid
	}
	local isTransport = self:isTransportWorkingById(msg.id)
	local changeMOList
	local moList = RoomMapTransportPathModel.instance:getTransportPathMOList()

	for i, pathMO in ipairs(moList) do
		if pathMO.id ~= msg.id and pathMO.critterUid == msg.critterUid then
			changeMOList = changeMOList or {}

			table.insert(changeMOList, pathMO)
		end
	end

	if changeMOList then
		local clearInfo = {
			critterUid = 0
		}

		for i, _pathMO in ipairs(changeMOList) do
			RoomTransportPathModel.instance:updateInofoById(_pathMO.id, clearInfo)
			RoomMapTransportPathModel.instance:updateInofoById(_pathMO.id, clearInfo)
		end
	end

	RoomTransportPathModel.instance:updateInofoById(msg.id, info)
	RoomMapTransportPathModel.instance:updateInofoById(msg.id, info)

	if not isTransport and self:isTransportWorkingById(msg.id) then
		GameFacade.showToast(ToastEnum.RoomTransportStartMove)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.TransportCritterChanged)
end

function RoomTransportController:isTransportWorkingById(pathId)
	local pathMO = RoomMapTransportPathModel.instance:getTransportPathMO(pathId)

	if pathMO and pathMO.critterUid and pathMO.critterUid ~= 0 and (RoomBuildingAreaHelper.isHasWorkingByType(pathMO.fromType) or RoomBuildingAreaHelper.isHasWorkingByType(pathMO.toType)) then
		return true
	end

	return false
end

function RoomTransportController:batchCritterReply(roadInfos)
	if not roadInfos then
		return
	end

	for _, roadInfo in ipairs(roadInfos) do
		local info = RoomTransportHelper.serverRoadInfo2Info(roadInfo)

		RoomTransportPathModel.instance:updateInofoById(info.id, info)
		RoomMapTransportPathModel.instance:updateInofoById(info.id, info)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.TransportCritterChanged)
end

function RoomTransportController:allotVehicleReply(msg)
	local info = {
		buildingUid = msg.buildingUid,
		buildingId = msg.buildingDefineId,
		buildingDefineId = msg.buildingDefineId,
		buildingSkinId = msg.skinId
	}
	local pathMO = RoomMapTransportPathModel.instance:getTransportPathMO(msg.id)

	RoomTransportPathModel.instance:updateInofoById(msg.id, info)
	RoomMapTransportPathModel.instance:updateInofoById(msg.id, info)

	if pathMO then
		self:_updateVehicle(pathMO)
	end

	GameFacade.showToast(ToastEnum.RoomTransportSkinChange)
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportBuildingChanged)
end

function RoomTransportController:_updateVehicle(pathMO)
	if not pathMO then
		return
	end

	local scene = RoomCameraController.instance:getRoomScene()

	if not scene then
		return
	end

	local siteType = RoomTransportHelper.fromTo2SiteType(pathMO.fromType, pathMO.toType)
	local vehicleCfg = RoomTransportHelper.getVehicleCfgByBuildingId(pathMO.buildingId, pathMO.buildingSkinId)

	if vehicleCfg then
		local vehicleMO = RoomMapVehicleModel.instance:getVehicleMOBySiteType(siteType)

		if not vehicleMO then
			vehicleMO = RoomMapVehicleModel.instance:createVehicleMOBySiteType(siteType)

			if vehicleMO then
				RoomMapVehicleModel.instance:addAtLast(vehicleMO)
			end
		end

		if vehicleMO then
			vehicleMO.config = vehicleCfg
			vehicleMO.vehicleId = vehicleCfg.id

			local vehicleEntity = scene.vehiclemgr:getVehicleEntity(vehicleMO.id)

			if vehicleEntity then
				vehicleEntity:refreshReplaceType()
				vehicleEntity:refreshVehicle()
			else
				scene.vehiclemgr:spawnMapVehicle(vehicleMO)
			end
		end
	else
		local id = RoomMapVehicleModel.instance:getVehicleIdBySiteType(siteType)
		local vehicleEntity = scene.vehiclemgr:getVehicleEntity(id)

		if vehicleEntity then
			scene.vehiclemgr:destroyVehicle(vehicleEntity)
		end

		local vehicleMO = RoomMapVehicleModel.instance:getVehicleMOBySiteType(siteType)

		if vehicleMO then
			RoomMapVehicleModel.instance:remove(vehicleMO)
		end
	end
end

function RoomTransportController:_checkSaveEditPath()
	if not self._savePathDeleteOp and not self._savePathGeneraterOP then
		UIBlockMgr.instance:endBlock(RoomTransportController.SAME_EDIT_PATH_REQUEST)

		if self._coutWaitSuccess and self._coutWaitSuccess < 1 then
			ViewMgr.instance:closeView(ViewName.RoomTransportPathView)
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanSave)
		end

		self:waitRefreshPathLineChanged()
	end
end

function RoomTransportController:updateBlockUseState()
	local pathMOList = RoomMapTransportPathModel.instance:getTransportPathMOList()
	local tRoomMapBlockModel = RoomMapBlockModel.instance
	local pathIdDict = {}
	local pathId2CleanTypeDict = {}
	local useStateTransportPath = RoomBlockEnum.UseState.TransportPath

	for i = 1, #pathMOList do
		local pathMO = pathMOList[i]
		local hexPointList = pathMO:getHexPointList()

		for _, hexPoint in ipairs(hexPointList) do
			local blockMO = tRoomMapBlockModel:getBlockMO(hexPoint.x, hexPoint.y)

			if blockMO then
				pathIdDict[blockMO.id] = true
				pathId2CleanTypeDict[blockMO.id] = pathMO.blockCleanType
			end
		end
	end

	local fullBlockMOList = tRoomMapBlockModel:getFullBlockMOList()

	for _, blockMO in ipairs(fullBlockMOList) do
		local blockId = blockMO.id
		local useState = blockMO:getUseState()
		local cleanType = blockMO:getCleanType()

		if pathIdDict[blockId] then
			local pathCleanType = pathId2CleanTypeDict[blockMO.id]

			if useState ~= useStateTransportPath or pathCleanType ~= cleanType then
				blockMO:setUseState(useStateTransportPath)
				blockMO:setCleanType(pathCleanType)
				self:waitRefreshBlockById(blockId)
			end
		elseif useState == useStateTransportPath or cleanType ~= RoomBlockEnum.UseState.Normal then
			blockMO:setUseState(nil)
			blockMO:setCleanType(nil)
			self:waitRefreshBlockById(blockId)
		end
	end

	self:waitRefreshPathLineChanged()
end

function RoomTransportController:tweenCameraFocusSite(siteType, isFirstPerson)
	self._tweenCameraFocusSiteParams = nil

	local scene = GameSceneMgr.instance:getCurScene()
	local vehicleMO = RoomMapVehicleModel.instance:getVehicleMOBySiteType(siteType)

	if vehicleMO then
		isFirstPerson = isFirstPerson == true

		local vehicleEntity = scene.vehiclemgr:getVehicleEntity(vehicleMO.id)

		scene.cameraFollow:setFollowTarget(vehicleEntity and vehicleEntity.cameraFollowTargetComp, isFirstPerson)

		if vehicleEntity then
			local vehicleCfg = vehicleMO.config
			local cameraState = RoomEnum.CameraState.ThirdPerson
			local cameraParamId = vehicleCfg and vehicleCfg.thirdCameraId

			if isFirstPerson then
				cameraParamId = vehicleCfg and vehicleCfg.firstCameraId
				cameraState = RoomEnum.CameraState.FirstPerson

				local var_20_0

				if isFirstPerson then
					var_20_0 = RoomEnum.EntityChildKey.FirstPersonCameraGOKey or RoomEnum.EntityChildKey.ThirdPersonCameraGOKey
				end
			end

			vehicleEntity.cameraFollowTargetComp:setFollowGOPath(var_20_0)

			local px, py, pz = vehicleEntity.cameraFollowTargetComp:getPositionXYZ()

			scene.cameraFollow:setIsPass(true, py)

			local cameraParam = {
				focusX = px,
				focusY = pz
			}

			scene.cameraFollow._offsetY = py

			if isFirstPerson then
				local rx, ry, rz = vehicleEntity.cameraFollowTargetComp:getRotateXYZ()

				cameraParam.rotate = RoomRotateHelper.getMod(ry, 360) * Mathf.Deg2Rad
			end

			scene.camera:setChangeCameraParamsById(cameraState, cameraParamId)
			scene.camera:switchCameraState(cameraState, cameraParam, nil, self._onTweenCameraFocusSiteFinsh, self)

			self._tweenCameraFocusSiteParams = true

			scene.fovblock:setLookVehicleUid(cameraState, vehicleMO.id)
		end

		return
	end

	local hexPoint = RoomMapTransportPathModel.instance:getSiteHexPointByType(siteType)

	if hexPoint then
		scene.cameraFollow:setFollowTarget(nil)

		local posX, posZ = HexMath.hexXYToPosXY(hexPoint.x, hexPoint.y, RoomBlockEnum.BlockSize)

		scene.camera:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = posX,
			focusY = posZ
		})
	end
end

function RoomTransportController:_onTweenCameraFocusSiteFinsh()
	if self._tweenCameraFocusSiteParams then
		self._tweenCameraFocusSiteParams = nil

		local scene = RoomCameraController.instance:getRoomScene()

		if scene then
			scene.cameraFollow:setIsPass(false)
		end
	end
end

function RoomTransportController:openTransportSiteView(siteType, replaceCameraState)
	siteType = self:_findLinkPathSiteType(siteType)

	if siteType then
		RoomCameraController.instance:saveCameraStateByKey(ViewName.RoomTransportSiteView, replaceCameraState)

		local isFirstPerson = false

		self:tweenCameraFocusSite(siteType, isFirstPerson)
		ViewMgr.instance:openView(ViewName.RoomTransportSiteView, {
			siteType = siteType,
			isFirstPerson = isFirstPerson
		})
	end
end

function RoomTransportController:_findLinkPathSiteType(siteType)
	local fromType, toType = RoomTransportHelper.getSiteFromToByType(siteType)
	local pathMO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(fromType, toType)

	if pathMO then
		return siteType
	end

	local siteTypeList = RoomTransportHelper.getSiteBuildingTypeList()

	for i, tempType in ipairs(siteTypeList) do
		local fromType, toType = RoomTransportHelper.getSiteFromToByType(tempType)
		local pathMO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(fromType, toType)

		if pathMO and (fromType == siteType or toType == siteType) then
			return tempType
		end
	end
end

function RoomTransportController:openTransportPathView()
	if RoomMapBuildingAreaModel.instance:getCount() < 2 then
		GameFacade.showToast(ToastEnum.RoomTranspathUnableEdite)

		return
	end

	RoomMapTransportPathModel.instance:setIsRemoveBuilding(false)
	ViewMgr.instance:openView(ViewName.RoomTransportPathView)
end

function RoomTransportController:isTransportPathShow()
	return ViewMgr.instance:isOpen(ViewName.RoomTransportPathView)
end

function RoomTransportController:isTransportSitShow()
	return ViewMgr.instance:isOpen(ViewName.RoomTransportSiteView)
end

function RoomTransportController:addConstEvents()
	return
end

function RoomTransportController:waitRefreshBlockById(blockId)
	self._waitingBlockIdList = self._waitingBlockIdList or {}

	if blockId and not tabletool.indexOf(self._waitingBlockIdList, blockId) then
		table.insert(self._waitingBlockIdList, blockId)
		self:_startWaitRunRefreshTask()
	end
end

function RoomTransportController:waitRefreshPathLineChanged()
	self._transportPathLineChanged = true

	self:_startWaitRunRefreshTask()
end

function RoomTransportController:_refreshBlockByIds(waitList)
	if waitList and #waitList > 0 then
		local entityList = {}

		for i = 1, #waitList do
			local blockId = waitList[i]
			local blockMO = RoomMapBlockModel.instance:getFullBlockMOById(blockId)

			if blockMO and blockMO:isInMap() then
				local scene = GameSceneMgr.instance:getCurScene()
				local entity = scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

				if entity and not tabletool.indexOf(entityList, entity) then
					table.insert(entityList, entity)
				end

				local nearMapEntityList = RoomBlockHelper.getNearBlockEntity(false, blockMO.hexPoint, 1, false, true)

				for _, entity in ipairs(nearMapEntityList) do
					if entity and not tabletool.indexOf(entityList, entity) then
						table.insert(entityList, entity)
					end
				end
			end
		end

		RoomBlockHelper.refreshBlockResourceType(entityList)
		RoomBlockHelper.refreshBlockEntity(entityList, "refreshLand")
	end
end

function RoomTransportController:_startWaitRunRefreshTask()
	if not self._hasWaitRunRefreshTask then
		self._hasWaitRunRefreshTask = true

		TaskDispatcher.runDelay(self._onWaitRunRefreshTask, self, 0.001)
	end
end

function RoomTransportController:_onWaitRunRefreshTask()
	self._hasWaitRunRefreshTask = false

	if self._waitingBlockIdList and #self._waitingBlockIdList > 0 then
		local waitList = self._waitingBlockIdList

		self._waitingBlockIdList = {}

		self:_refreshBlockByIds(waitList)

		self._transportPathLineChanged = true
	end

	if self._transportPathLineChanged then
		self._transportPathLineChanged = false

		RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathLineChanged)
	end
end

RoomTransportController.instance = RoomTransportController.New()

return RoomTransportController
