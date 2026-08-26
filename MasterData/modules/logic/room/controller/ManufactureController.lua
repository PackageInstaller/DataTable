-- chunkname: @modules/logic/room/controller/ManufactureController.lua

module("modules.logic.room.controller.ManufactureController", package.seeall)

local ManufactureController = class("ManufactureController", BaseController)
local OPEN_VIEW_DELAY = 0.2

function ManufactureController:onInit()
	return
end

function ManufactureController:reInit()
	return
end

function ManufactureController:clear()
	TaskDispatcher.cancelTask(self._realOpenManufactureBuildingView, self)
	TaskDispatcher.cancelTask(self._realOpenCritterBuildingView, self)
end

function ManufactureController:addConstEvents()
	return
end

function ManufactureController:checkManufactureInfoUpdate()
	local needUpdate = false
	local allPlacedManufactureBuildingList = ManufactureModel.instance:getAllPlacedManufactureBuilding()

	for _, buildingMO in ipairs(allPlacedManufactureBuildingList) do
		local progressSlotId = buildingMO:getSlotIdInProgress()
		local progress = buildingMO:getSlotProgress(progressSlotId)

		if progress >= 1 then
			needUpdate = true

			break
		end
	end

	if needUpdate then
		self:getManufactureServerInfo()
	end
end

function ManufactureController:updateTraceNeedItemDict()
	local isRoomScene = RoomController.instance:isRoomScene()
	local isGetOrderInfo = RoomTradeModel.instance:isGetOrderInfo()

	if isRoomScene and isGetOrderInfo then
		RoomTradeModel.instance:calTracedItemDict()
	end
end

function ManufactureController:getManufactureServerInfo()
	local isUnlock = ManufactureModel.instance:isManufactureUnlock()

	if not isUnlock then
		return
	end

	RoomRpc.instance:sendGetManufactureInfoRequest()
end

function ManufactureController:setManufactureItems(buildingUid, slotOperationInfoList)
	RoomRpc.instance:sendSelectSlotProductionPlanRequest(buildingUid, slotOperationInfoList)
end

function ManufactureController:upgradeManufactureBuilding(buildingUid)
	RoomRpc.instance:sendManuBuildingUpgradeRequest(buildingUid)
end

function ManufactureController:allocateCritter(buildingUid, critterUid, critterSlotId)
	RoomRpc.instance:sendDispatchCritterRequest(buildingUid, critterUid, critterSlotId)
end

function ManufactureController:useAccelerateItem(buildingUid, itemId, itemCount, slotId)
	if not slotId then
		logError("ManufactureController:useAccelerateItem error, slotId is nil")

		return
	end

	self:clearSelectedSlotItem()

	local accelerateItem = {
		type = MaterialEnum.MaterialType.Item,
		id = itemId,
		quantity = itemCount
	}

	RoomRpc.instance:sendManufactureAccelerateRequest(buildingUid, accelerateItem, slotId)
end

function ManufactureController:gainCompleteManufactureItem(buildingUid)
	buildingUid = buildingUid or RoomManufactureEnum.InvalidBuildingUid

	RoomRpc.instance:sendReapFinishSlotRequest(buildingUid)
end

function ManufactureController:updateManufactureInfo(manufactureInfo)
	ManufactureModel.instance:resetDataBeforeSetInfo()

	if manufactureInfo then
		ManufactureModel.instance:setManufactureInfo(manufactureInfo)
		RoomCritterModel.instance:initStayBuildingCritters()
	end

	self:dispatchEvent(ManufactureEvent.ManufactureInfoUpdate)
end

function ManufactureController:updateTradeLevel(tradeLevel)
	ManufactureModel.instance:setTradeLevel(tradeLevel)
	self:dispatchEvent(ManufactureEvent.TradeLevelChange)
end

function ManufactureController:updateManuBuildingInfoList(manuBuildingInfos, isCalAllFrozen)
	if not manuBuildingInfos then
		return
	end

	ManufactureModel.instance:setManuBuildingInfoList(manuBuildingInfos)

	local updateBuildingDict = {}

	for _, manuBuildingInfo in ipairs(manuBuildingInfos) do
		updateBuildingDict[manuBuildingInfo.buildingUid] = true
	end

	RoomCritterModel.instance:initStayBuildingCritters()

	if isCalAllFrozen then
		ManufactureModel.instance:clientCalAllFrozenItemDict()
	end

	self:dispatchEvent(ManufactureEvent.ManufactureBuildingInfoChange, updateBuildingDict)
end

function ManufactureController:updateManuBuildingInfo(manuBuildingInfo)
	if not manuBuildingInfo then
		return
	end

	ManufactureModel.instance:setManuBuildingInfo(manuBuildingInfo, true)
	RoomCritterModel.instance:initStayBuildingCritters()
	self:dispatchEvent(ManufactureEvent.ManufactureBuildingInfoChange, {
		[manuBuildingInfo.buildingUid] = true
	})
end

function ManufactureController:updateWorkCritterInfo(buildingUid)
	self:dispatchEvent(ManufactureEvent.CritterWorkInfoChange, buildingUid)
end

function ManufactureController:updateFrozenItem(frozenItemInfo)
	ManufactureModel.instance:setFrozenItemDict(frozenItemInfo)
end

function ManufactureController:jumpToManufactureBuildingLevelUpView(buildingUid)
	local result = false
	local isUnlock = ManufactureModel.instance:isManufactureUnlock(true)

	if isUnlock then
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

		if buildingMO then
			local isManufacture = ManufactureConfig.instance:isManufactureBuilding(buildingMO.buildingId)

			if isManufacture then
				local isOpenCritterBuildingView = ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView)

				if isOpenCritterBuildingView then
					self:closeCritterBuildingView(true)
				end

				local isOpenTradeView = ViewMgr.instance:isOpen(ViewName.RoomTradeView)

				if isOpenTradeView then
					ViewMgr.instance:closeView(ViewName.RoomTradeView, false)
				end

				ViewMgr.instance:closeAllPopupViews({
					ViewName.RoomTradeView
				})

				local recordCameraState, recordCameraParam = ManufactureModel.instance:getCameraRecord()

				self:openManufactureBuildingViewByBuilding(buildingMO, (recordCameraState or recordCameraParam) and true, true)

				result = true
			else
				logError(string.format("ManufactureController:jumpToManufactureBuildingLevelUpView error, not manufacture building, buildingUid:%s", buildingUid))
			end
		else
			logError(string.format("ManufactureController:jumpToManufactureBuildingLevelUpView error, not find building, buildingUid:%s", buildingUid))
		end
	end

	return result
end

function ManufactureController:openManufactureBuildingViewByBuilding(buildingMO, notUpdateCameraRecord, jump2Upgrade, addManuItem)
	local isUnlock = ManufactureModel.instance:isManufactureUnlock(true)

	if not isUnlock then
		return
	end

	if not buildingMO then
		return
	end

	local buildingType = RoomConfig.instance:getBuildingType(buildingMO.buildingId)

	self:openManufactureBuildingViewByType(buildingType, buildingMO.uid, notUpdateCameraRecord, jump2Upgrade, addManuItem)
end

function ManufactureController:openManufactureBuildingViewByType(buildingType, defaultBuildingUid, notUpdateCameraRecord, jump2Upgrade, addManuItem)
	local isUnlock = ManufactureModel.instance:isManufactureUnlock(true)

	if not isUnlock then
		return
	end

	if buildingType ~= RoomBuildingEnum.BuildingType.Collect and buildingType ~= RoomBuildingEnum.BuildingType.Process and buildingType ~= RoomBuildingEnum.BuildingType.Manufacture then
		return
	end

	local buildingList = RoomMapBuildingModel.instance:getBuildingListByType(buildingType)

	if not buildingList or #buildingList <= 0 then
		GameFacade.showToast(ToastEnum.RoomNoPlaceManufactureBuilding)

		return
	end

	local curBuildingMO
	local isDefaultBuildingValid = false

	if defaultBuildingUid then
		curBuildingMO = RoomMapBuildingModel.instance:getBuildingMOById(defaultBuildingUid)

		if curBuildingMO and curBuildingMO.config and curBuildingMO.config.buildingType == buildingType then
			isDefaultBuildingValid = true
		end
	end

	if not isDefaultBuildingValid then
		curBuildingMO = buildingList[1]
		defaultBuildingUid = buildingList[1].buildingUid
	end

	self._tmpManuBuildingViewParam = {
		buildingType = buildingType,
		defaultBuildingUid = defaultBuildingUid,
		addManuItem = addManuItem
	}
	self._tmpJumpLvUpBuildingUid = jump2Upgrade and defaultBuildingUid or nil

	local curBuildingId = curBuildingMO.buildingId
	local firstCamera = ManufactureConfig.instance:getBuildingCameraIdByIndex(curBuildingId)
	local roomCamera = RoomCameraController.instance:getRoomCamera()

	if roomCamera and firstCamera then
		if not notUpdateCameraRecord then
			local cameraState = roomCamera:getCameraState()
			local cameraParam = roomCamera:getCameraParam()
			local recordCameraParam = LuaUtil.deepCopy(cameraParam)

			ManufactureModel.instance:setCameraRecord(cameraState, recordCameraParam)
		end

		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(defaultBuildingUid, firstCamera)
		TaskDispatcher.cancelTask(self._realOpenManufactureBuildingView, self)
		TaskDispatcher.runDelay(self._realOpenManufactureBuildingView, self, OPEN_VIEW_DELAY)
	else
		self:_realOpenManufactureBuildingView()
	end

	self:dispatchEvent(ManufactureEvent.OnEnterManufactureBuildingView)
	self:dispatchEvent(ManufactureEvent.ManufactureBuildingViewChange, {
		inManufactureBuildingView = true
	})
end

function ManufactureController:openRoomManufactureBuildingDetailView(buildingUid, isRight)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if buildingMO and (buildingMO:checkSameType(RoomBuildingEnum.BuildingType.Collect) or buildingMO:checkSameType(RoomBuildingEnum.BuildingType.Process) or buildingMO:checkSameType(RoomBuildingEnum.BuildingType.Manufacture)) then
		ViewMgr.instance:openView(ViewName.RoomManufactureBuildingDetailView, {
			buildingUid = buildingUid,
			buildingMO = buildingMO,
			showIsRight = isRight
		})

		return true
	end

	return false
end

function ManufactureController:_realOpenManufactureBuildingView()
	local isUnlock = ManufactureModel.instance:isManufactureUnlock(true)

	if not isUnlock then
		return
	end

	if self._tmpManuBuildingViewParam then
		local buildingType = self._tmpManuBuildingViewParam.buildingType

		if not buildingType then
			return
		end

		ViewMgr.instance:openView(ViewName.RoomManufactureBuildingView, self._tmpManuBuildingViewParam)

		self._tmpManuBuildingViewParam = nil

		self:jump2ManufactureUpgradeView()
	end
end

function ManufactureController:jump2ManufactureUpgradeView(jumpBuildingUid)
	if not self._tmpJumpLvUpBuildingUid and not jumpBuildingUid then
		return
	end

	self:openManufactureBuildingLevelUpView(jumpBuildingUid or self._tmpJumpLvUpBuildingUid)

	self._tmpJumpLvUpBuildingUid = nil
end

function ManufactureController:openManufactureBuildingLevelUpView(buildingUid)
	local isMaxLevel = ManufactureModel.instance:isMaxLevel(buildingUid)

	if isMaxLevel then
		return
	end

	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local upgradeGroup = ManufactureConfig.instance:getBuildingUpgradeGroup(buildingMO.buildingId)

	if upgradeGroup == 0 then
		return
	end

	local viewParam = ManufactureModel.instance:getManufactureLevelUpParam(buildingUid)

	ViewMgr.instance:openView(ViewName.RoomBuildingLevelUpView, viewParam)
end

function ManufactureController:openManufactureAccelerateView(buildingUid)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local state = buildingMO and buildingMO:getManufactureState()

	if state ~= RoomManufactureEnum.ManufactureState.Running then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomManufactureAccelerateView, {
		buildingUid = buildingUid
	})
end

function ManufactureController:openRoomRecordView(tab)
	tab = tab or RoomRecordEnum.View.Task

	if tab == RoomRecordEnum.View.Task then
		RoomRpc.instance:sendGetTradeTaskInfoRequest(function()
			self:_reallyOpenRoomRecordView(tab)
		end, self)
	else
		self:_reallyOpenRoomRecordView(tab)
	end
end

function ManufactureController:_reallyOpenRoomRecordView(tab)
	ViewMgr.instance:openView(ViewName.RoomRecordView, tab)
end

function ManufactureController:openCritterBuildingView(buildingUid, defaultTab, critterUid)
	local isCritterUnlock = CritterModel.instance:isCritterUnlock(true)

	if not isCritterUnlock then
		return
	end

	local buildingList = ManufactureModel.instance:getCritterBuildingListInOrder()

	if not buildingList or #buildingList <= 0 then
		GameFacade.showToast(ToastEnum.RoomNoPlaceCritterBuilding)

		return
	end

	local curBuildingMO

	if not buildingUid then
		curBuildingMO = buildingList[1]
		buildingUid = buildingList[1].buildingUid
	else
		curBuildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	end

	local curBuildingType = curBuildingMO and curBuildingMO.config.buildingType

	if curBuildingType ~= RoomBuildingEnum.BuildingType.Rest then
		return
	end

	local curBuildingId = curBuildingMO.buildingId
	local firstCamera = ManufactureConfig.instance:getBuildingCameraIdByIndex(curBuildingId, defaultTab)
	local roomCamera = RoomCameraController.instance:getRoomCamera()

	if roomCamera and firstCamera then
		local cameraState = roomCamera:getCameraState()
		local cameraParam = roomCamera:getCameraParam()
		local recordCameraParam = LuaUtil.deepCopy(cameraParam)

		ManufactureModel.instance:setCameraRecord(cameraState, recordCameraParam)

		self._tmpCritterBuildingUid = buildingUid
		self._tmpCritterDefaultTab = defaultTab
		self._tmpCritterUid = critterUid

		local isCultivating = false

		if defaultTab == RoomCritterBuildingViewContainer.SubViewTabId.Training and critterUid then
			local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)

			isCultivating = critterMO and critterMO:isCultivating()
		end

		TaskDispatcher.cancelTask(self._realOpenCritterBuildingView, self)

		if isCultivating then
			self:_realOpenCritterBuildingView(buildingUid, defaultTab, critterUid)
		else
			RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(buildingUid, firstCamera, self._openCritterBuildingViewCameraTweenFinish, self)
			TaskDispatcher.runDelay(self._realOpenCritterBuildingView, self, OPEN_VIEW_DELAY)
		end
	else
		self:_realOpenCritterBuildingView(buildingUid, defaultTab, critterUid)
	end

	CritterController.instance:dispatchEvent(CritterEvent.onEnterCritterBuildingView)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewChange, {
		inCritterBuildingView = true
	})

	return true
end

function ManufactureController:_realOpenCritterBuildingView(buildingUid, defaultTab, critterUid)
	buildingUid = buildingUid or self._tmpCritterBuildingUid
	defaultTab = defaultTab or self._tmpCritterDefaultTab
	critterUid = critterUid or self._tmpCritterUid

	if not buildingUid then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomCritterBuildingView, {
		buildingUid = buildingUid,
		defaultTab = defaultTab,
		critterUid = critterUid
	})
	self:dispatchEvent(ManufactureEvent.PlayCritterBuildingBgm, 0, true)
end

function ManufactureController:closeCritterBuildingView(isDelayAudio)
	if isDelayAudio then
		self:dispatchEvent(ManufactureEvent.PlayCritterBuildingBgm, RoomManufactureEnum.AudioDelayTime, false)
	end

	ViewMgr.instance:closeView(ViewName.RoomCritterBuildingView)
end

function ManufactureController:_openCritterBuildingViewCameraTweenFinish()
	self._tmpCritterBuildingUid = nil
	self._tmpCritterDefaultTab = nil
	self._tmpCritterUid = nil

	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingCameraTweenFinish, self._tmpCritterDefaultTab)
end

function ManufactureController:openCritterPlaceView(buildingUid)
	ViewMgr.instance:openView(ViewName.RoomCritterPlaceView, {
		buildingUid = buildingUid
	})
end

function ManufactureController:openOverView(openFromRest)
	local isUnlock = ManufactureModel.instance:isManufactureUnlock(true)

	if not isUnlock then
		return
	end

	local allPlacedManufactureBuildingList = ManufactureModel.instance:getAllPlacedManufactureBuilding()

	if not allPlacedManufactureBuildingList or #allPlacedManufactureBuildingList <= 0 then
		GameFacade.showToast(ToastEnum.RoomNoPlaceManufactureBuilding)

		return
	end

	ViewMgr.instance:openView(ViewName.RoomOverView, {
		openFromRest = openFromRest
	})

	return true
end

function ManufactureController:openRoomTradeView(buildingUid, defaultTab)
	local unlockLevel = RoomTradeTaskModel.instance:getOpenOrderLevel()

	if unlockLevel > ManufactureModel.instance:getTradeLevel() then
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

		return
	end

	local buildingList = ManufactureModel.instance:getTradeBuildingListInOrder()

	if not buildingList or #buildingList <= 0 then
		GameFacade.showToast(ToastEnum.RoomNoTradeBuilding)

		return
	end

	RoomRpc.instance:sendGetFrozenItemInfoRequest()

	buildingUid = buildingUid or buildingList[1].buildingUid

	local roomCamera = RoomCameraController.instance:getRoomCamera()

	local function openViewFunc()
		defaultTab = defaultTab or 1

		ViewMgr.instance:openView(ViewName.RoomTradeView, {
			defaultTab = defaultTab
		})
	end

	if roomCamera and buildingUid then
		local cameraState = roomCamera:getCameraState()
		local cameraParam = roomCamera:getCameraParam()
		local recordCameraParam = LuaUtil.deepCopy(cameraParam)

		ManufactureModel.instance:setCameraRecord(cameraState, recordCameraParam)
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(buildingUid, RoomTradeEnum.CameraId, openViewFunc)
	else
		openViewFunc()
	end

	return true
end

function ManufactureController:openRoomBackpackView()
	local isUnlock = ManufactureModel.instance:isManufactureUnlock(true)

	if not isUnlock then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomBackpackView)

	return true
end

function ManufactureController:jump2PlaceManufactureBuildingView()
	local isEditMode = RoomController.instance:isEditMode()

	if isEditMode then
		GameFacade.showToast(RoomEnum.Toast.TaskAlreadyInEditMode)
	else
		local isOpenTradeView = ViewMgr.instance:isOpen(ViewName.RoomTradeView)

		if isOpenTradeView then
			RoomTradeController.instance:dispatchEvent(RoomTradeEvent.PlayCloseTVAnim)
		end

		local isOpenRoomBackpackView = ViewMgr.instance:isOpen(ViewName.RoomBackpackView)
		local isOpenOverView = ViewMgr.instance:isOpen(ViewName.RoomOverView)

		if isOpenRoomBackpackView or isOpenOverView then
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_normal)
		end

		ViewMgr.instance:closeView(ViewName.RoomManufactureMaterialTipView)
		ManufactureModel.instance:setIsJump2ManufactureBuildingList(true)
		RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
	end
end

function ManufactureController:clickWrongBtn(buildingUid, isRight)
	local isShowing = ViewMgr.instance:isOpen(ViewName.RoomManufactureWrongTipView)

	if isShowing and self._lastWrongBuildingUid == buildingUid then
		self:closeWrongTipView()
	else
		self:clearSelectedSlotItem()
		self:clearSelectCritterSlotItem()
		ViewMgr.instance:openView(ViewName.RoomManufactureWrongTipView, {
			buildingUid = buildingUid,
			isRight = isRight
		})

		self._lastWrongBuildingUid = buildingUid
	end
end

function ManufactureController:clickWrongJump(wrongType, manufactureItem, buildingType, param)
	if not wrongType then
		return
	end

	local handlerFunc = RoomManufactureEnum.WrongTypeHandlerFunc[wrongType]

	if not handlerFunc then
		return
	end

	local result = handlerFunc(self, manufactureItem, buildingType, param)

	if result then
		self:closeWrongTipView()
	end
end

function ManufactureController:_addPreMat(manufactureItem, buildingType, param)
	local targetBuildingMO
	local isOverView = param.isOverView
	local isCollect = buildingType == RoomBuildingEnum.BuildingType.Collect
	local buildingMOList = RoomMapBuildingModel.instance:getBuildingListByType(buildingType, true)

	if buildingMOList and #buildingMOList > 0 then
		if isCollect then
			for _, buildingMO in ipairs(buildingMOList) do
				local nextEmptySlotId = self:getNextEmptySlot(buildingMO.id)

				if nextEmptySlotId then
					targetBuildingMO = buildingMO

					break
				end
			end

			targetBuildingMO = targetBuildingMO or buildingMOList[1]
		else
			for _, buildingMO in ipairs(buildingMOList) do
				local isBelong = ManufactureConfig.instance:isManufactureItemBelongBuilding(buildingMO.buildingId, manufactureItem)

				if isBelong then
					targetBuildingMO = buildingMO

					break
				end
			end
		end
	end

	if not targetBuildingMO then
		return false
	end

	if isOverView then
		self:dispatchEvent(ManufactureEvent.ManufactureOverViewFocusAddPop, targetBuildingMO.id, manufactureItem)
	else
		self:openManufactureBuildingViewByBuilding(targetBuildingMO, true, false, manufactureItem)
	end

	return true
end

function ManufactureController:_lvUpBuilding(manufactureItem, buildingType, param)
	local targetBuildingMO
	local tmpTargetLv = 0
	local buildingMOList = RoomMapBuildingModel.instance:getBuildingListByType(buildingType, true)

	if buildingMOList and #buildingMOList > 0 then
		for _, buildingMO in ipairs(buildingMOList) do
			local buildingUid = buildingMO.id
			local isBelong = ManufactureConfig.instance:isManufactureItemBelongBuilding(buildingMO.buildingId, manufactureItem)

			if isBelong then
				local isMaxLevel = ManufactureModel.instance:isMaxLevel(buildingUid)
				local buildingLevel = buildingMO.level

				if not isMaxLevel and tmpTargetLv < buildingLevel then
					targetBuildingMO = buildingMO
					tmpTargetLv = buildingLevel
				end
			end
		end
	end

	if not targetBuildingMO then
		return false
	end

	self:jumpToManufactureBuildingLevelUpView(targetBuildingMO.id)

	return true
end

function ManufactureController:_linPath(manufactureItem, buildingType, param)
	local tradeLv = ManufactureModel.instance:getTradeLevel()
	local unlockLv = ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.TransportSystemOpen)
	local isOpen = unlockLv <= tradeLv

	if isOpen then
		local pathMO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(buildingType, param.pathToType)
		local isLinkFinish = pathMO and pathMO:isLinkFinish()
		local hasCritterWork = pathMO and pathMO:hasCritterWorking()

		if isLinkFinish and not hasCritterWork then
			self:closeWrongTipView()
			ViewMgr.instance:closeView(ViewName.RoomOverView, true)

			local siteType = RoomTransportHelper.fromTo2SiteType(buildingType, param.pathToType)

			RoomTransportController.instance:openTransportSiteView(siteType, RoomEnum.CameraState.Overlook)

			local isOpenCritterBuildingView = ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView)

			if isOpenCritterBuildingView then
				self:closeCritterBuildingView(true)
			end

			local isOpenManufactureBuildingView = ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView)

			if isOpenManufactureBuildingView then
				ViewMgr.instance:closeView(ViewName.RoomManufactureBuildingView)
				ManufactureModel.instance:setCameraRecord()
			end
		else
			RoomJumpController.instance:jumpToTransportSiteView()
		end
	else
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)
	end
end

function ManufactureController:closeWrongTipView()
	ViewMgr.instance:closeView(ViewName.RoomManufactureWrongTipView)
end

function ManufactureController:clickSlotItem(buildingUid, slotId, isOverView, clickProductBtn, slotIndex, highLightManufactureItem)
	if not clickProductBtn then
		local slotState = RoomManufactureEnum.SlotState.Locked
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

		if buildingMO then
			slotState = buildingMO:getSlotState(slotId)
		end

		if slotState == RoomManufactureEnum.SlotState.Locked then
			local upgradeGroup = ManufactureConfig.instance:getBuildingUpgradeGroup(buildingMO.buildingId)
			local unlockLevel = ManufactureConfig.instance:getSlotUnlockNeedLevel(upgradeGroup, slotIndex)

			GameFacade.showToast(ToastEnum.RoomSlotLocked, unlockLevel)

			return
		end

		if slotState == RoomManufactureEnum.SlotState.Complete then
			if isOverView then
				self:gainCompleteManufactureItem()
			else
				self:gainCompleteManufactureItem(buildingUid)
			end

			return
		end
	end

	local selectedBuildingUid = ManufactureModel.instance:getSelectedSlot()
	local isShowAddPop = ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView)

	if isShowAddPop and selectedBuildingUid == buildingUid then
		self:clearSelectedSlotItem()
	else
		self:refreshSelectedSlotId(buildingUid, true)
		self:clearSelectCritterSlotItem()
		self:closeWrongTipView()
		ManufactureModel.instance:setReadNewManufactureFormula(buildingUid)
		ViewMgr.instance:openView(ViewName.RoomManufactureAddPopView, {
			inRight = isOverView,
			highLightManufactureItem = highLightManufactureItem
		})
		self:dispatchEvent(ManufactureEvent.ManufactureReadNewFormula)
	end
end

function ManufactureController:refreshSelectedSlotId(buildingUid, forceSet)
	if not forceSet then
		local isShowAddPop = ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView)

		if not isShowAddPop then
			self:clearSelectedSlotItem()

			return
		end
	end

	local nextEmptySlotId = self:getNextEmptySlot(buildingUid)

	ManufactureModel.instance:setSelectedSlot(buildingUid, nextEmptySlotId)
	self:dispatchEvent(ManufactureEvent.ChangeSelectedSlotItem)
end

function ManufactureController:clearSelectedSlotItem()
	ViewMgr.instance:closeView(ViewName.RoomManufactureAddPopView)
	ManufactureModel.instance:setSelectedSlot()
	self:dispatchEvent(ManufactureEvent.ChangeSelectedSlotItem)
end

function ManufactureController:setManufactureFormulaItemList(buildingUid)
	local isGetOrderInfo = RoomTradeModel.instance:isGetOrderInfo()

	if isGetOrderInfo then
		ManufactureFormulaListModel.instance:setManufactureFormulaItemList(buildingUid)
	else
		RoomRpc.instance:sendGetOrderInfoRequest(function()
			ManufactureFormulaListModel.instance:setManufactureFormulaItemList(buildingUid)
		end, self)
	end
end

function ManufactureController:clickFormulaItem(manufactureItemId)
	local selectedBuildingUid, selectedSlot = ManufactureModel.instance:getSelectedSlot()

	if not selectedBuildingUid or not selectedSlot then
		GameFacade.showToast(ToastEnum.RoomNotSelectedSlot)

		return
	end

	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(selectedBuildingUid)
	local slotState = buildingMO and buildingMO:getSlotState(selectedSlot)

	if not slotState or slotState ~= RoomManufactureEnum.SlotState.None then
		logError(string.format("ManufactureController:clickFormulaItem error, slot not empty, buildingUid:%s slotId:%s slotState:%s", selectedBuildingUid, selectedSlot, slotState))

		return
	end

	local slotOperationInfo = {
		priority = -1,
		slotId = selectedSlot,
		operation = RoomManufactureEnum.SlotOperation.Add,
		productionId = manufactureItemId
	}

	self:setManufactureItems(selectedBuildingUid, {
		slotOperationInfo
	})
end

function ManufactureController:clickRemoveSlotManufactureItem(buildingUid, slotId)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local manufactureItemId = buildingMO and buildingMO:getSlotManufactureItemId(slotId)

	if not manufactureItemId or manufactureItemId == 0 then
		return
	end

	local slotOperationInfo = {
		priority = -1,
		slotId = slotId,
		operation = RoomManufactureEnum.SlotOperation.Cancel,
		productionId = manufactureItemId
	}
	local slotState = buildingMO and buildingMO:getSlotState(slotId, true)

	if slotState == RoomManufactureEnum.SlotState.Stop or slotState == RoomManufactureEnum.SlotState.Running then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomRemoveHasProgressManufactureItem, MsgBoxEnum.BoxType.Yes_No, function()
			self:setManufactureItems(buildingUid, {
				slotOperationInfo
			})
		end)
	else
		self:setManufactureItems(buildingUid, {
			slotOperationInfo
		})
	end
end

function ManufactureController:moveManufactureItem(buildingUid, slotId, isDown)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local manufactureItemId = buildingMO and buildingMO:getSlotManufactureItemId(slotId)

	if not manufactureItemId or manufactureItemId == 0 then
		return
	end

	local slotState = buildingMO and buildingMO:getSlotState(slotId, true)
	local isRunning = slotState == RoomManufactureEnum.SlotState.Running
	local isStop = slotState == RoomManufactureEnum.SlotState.Stop
	local isWait = slotState == RoomManufactureEnum.SlotState.Wait

	if isRunning or isStop or isWait then
		local priority = buildingMO:getSlotPriority(slotId)
		local isFirst = priority == RoomManufactureEnum.FirstSlotPriority
		local isValid = isFirst and isDown or not isFirst and not isDown

		if isValid then
			local var_54_0 = {
				productionId = 0,
				priority = -1,
				slotId = slotId
			}

			if isDown then
				var_54_0.operation = RoomManufactureEnum.SlotOperation.MoveBottom or RoomManufactureEnum.SlotOperation.MoveTop
			end

			local slotOperationInfo = var_54_0

			self:setManufactureItems(buildingUid, {
				slotOperationInfo
			})
		end
	end
end

function ManufactureController:getFormatTime(timeSecond, useEn)
	local result = ""

	if useEn then
		if not TimeUtil.DateEnFormat.Day then
			local daySuffix = luaLang("time_day")

			if useEn then
				if not TimeUtil.DateEnFormat.Hour then
					local hourSuffix = luaLang("time_hour2")

					if useEn then
						if not TimeUtil.DateEnFormat.Minute then
							local minuteSuffix = luaLang("time_minute2")
							local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(timeSecond)

							if day > 0 then
								result = string.format("%s%s%s%s", day, daySuffix, hour, hourSuffix)
							elseif hour > 0 then
								result = min > 0 and string.format("%s%s%s%s", hour, hourSuffix, min, minuteSuffix) or string.format("%s%s", hour, hourSuffix)
							else
								if min <= 0 then
									min = "<1"
								end

								result = string.format("%s%s", min, minuteSuffix)
							end

							return result
						end
					end
				end
			end
		end
	end
end

function ManufactureController:getNextEmptySlot(buildingUid)
	local result
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(buildingUid)

	return (manufactureInfo or nil) and manufactureInfo:getNextEmptySlot()
end

function ManufactureController:checkPlaceProduceBuilding(manufactureItemId)
	local result = false
	local manufactureBuildingType = ManufactureConfig.instance:getManufactureItemBelongBuildingType(manufactureItemId)
	local placedManufactureBuildingList = RoomMapBuildingModel.instance:getBuildingListByType(manufactureBuildingType)

	if placedManufactureBuildingList and #placedManufactureBuildingList > 0 then
		for _, buildingMO in ipairs(placedManufactureBuildingList) do
			local isBelong = ManufactureConfig.instance:isManufactureItemBelongBuilding(buildingMO.buildingId, manufactureItemId)

			if isBelong then
				result = true

				break
			end
		end
	end

	return result
end

function ManufactureController:checkProduceBuildingLevel(manufactureItemId)
	local buildingUid
	local needUpgrade = true
	local needLevel = 0
	local manufactureBuildingType = ManufactureConfig.instance:getManufactureItemBelongBuildingType(manufactureItemId)
	local placedManufactureBuildingList = RoomMapBuildingModel.instance:getBuildingListByType(manufactureBuildingType)

	if placedManufactureBuildingList and #placedManufactureBuildingList > 0 then
		for _, buildingMO in ipairs(placedManufactureBuildingList) do
			local buildingId = buildingMO.buildingId
			local isBelong = ManufactureConfig.instance:isManufactureItemBelongBuilding(buildingId, manufactureItemId)

			if isBelong then
				buildingUid = buildingMO.id

				local buildingLevel = buildingMO:getLevel()

				needLevel = ManufactureConfig.instance:getManufactureItemNeedLevel(buildingId, manufactureItemId)

				if needLevel <= buildingLevel then
					needUpgrade = false

					break
				end
			end
		end
	end

	return needUpgrade, buildingUid, needLevel
end

function ManufactureController:oneKeySelectCustomManufactureItem(manufactureItemId, count, forceSet)
	local curManufactureItem, curCount = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if not forceSet and curManufactureItem == manufactureItemId and count == curCount then
		return
	end

	OneKeyAddPopListModel.instance:setSelectedManufactureItem(manufactureItemId, count)
	self:dispatchEvent(ManufactureEvent.OneKeySelectCustomManufactureItem)
end

function ManufactureController:clickCritterSlotItem(buildingUid, critterSlotId)
	local isUnlock = false
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if buildingMO then
		local critterCount = buildingMO:getCanPlaceCritterCount()

		if critterCount >= critterSlotId + 1 then
			isUnlock = true
		end
	end

	if not isUnlock then
		return
	end

	local isShowCritterListView = ViewMgr.instance:isOpen(ViewName.RoomCritterListView)
	local lastSelectedBuildingUid = ManufactureModel.instance:getSelectedCritterSlot()

	if isShowCritterListView and lastSelectedBuildingUid == buildingUid then
		self:clearSelectCritterSlotItem()
	else
		self:clearSelectedSlotItem()
		self:closeWrongTipView()
		self:refreshSelectedCritterSlotId(buildingUid, true)
		ViewMgr.instance:openView(ViewName.RoomCritterListView, {
			buildingUid = buildingUid
		})
	end
end

function ManufactureController:refreshSelectedCritterSlotId(buildingUid, forceSet)
	if not forceSet then
		local isShowCritterListView = ViewMgr.instance:isOpen(ViewName.RoomCritterListView)

		if not isShowCritterListView then
			self:clearSelectCritterSlotItem()

			return
		end
	end

	local nextEmptyCritterSlotId = self:getNextEmptyCritterSlot(buildingUid)

	ManufactureModel.instance:setSelectedCritterSlot(buildingUid, nextEmptyCritterSlotId)
	self:dispatchEvent(ManufactureEvent.ChangeSelectedCritterSlotItem)
end

function ManufactureController:getNextEmptyCritterSlot(buildingUid)
	local result
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(buildingUid)

	return (manufactureInfo or nil) and manufactureInfo:getNextEmptyCritterSlot()
end

function ManufactureController:clearSelectCritterSlotItem()
	ViewMgr.instance:closeView(ViewName.RoomCritterListView)
	ManufactureModel.instance:setSelectedCritterSlot()
	self:dispatchEvent(ManufactureEvent.ChangeSelectedCritterSlotItem)
end

function ManufactureController:clickCritterItem(critterUid)
	local selectedBuildingUid, selectedCritterSlot = ManufactureModel.instance:getSelectedCritterSlot()

	if not selectedBuildingUid then
		logError(string.format("ManufactureController:clickCritterItem error, not select building"))

		return
	end

	local workingBuildingUid = ManufactureModel.instance:getCritterWorkingBuilding(critterUid)
	local isWorkInSelectBuilding = workingBuildingUid == selectedBuildingUid

	if isWorkInSelectBuilding then
		local workingBuildingMO = RoomMapBuildingModel.instance:getBuildingMOById(workingBuildingUid)
		local workSlotId = workingBuildingMO and workingBuildingMO:getCritterWorkSlot(critterUid)

		self:allocateCritter(workingBuildingUid, CritterEnum.InvalidCritterUid, workSlotId)
	else
		local isReplace = false
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(selectedBuildingUid)

		if not buildingMO then
			logError(string.format("ManufactureController:clickCritterItem error, can not find buildingUId:%s", selectedBuildingUid))

			return
		end

		local critterCount = buildingMO:getCanPlaceCritterCount()

		if critterCount == 1 then
			selectedCritterSlot = 0
			isReplace = true
		end

		if not selectedCritterSlot then
			GameFacade.showToast(ToastEnum.RoomNotSelectedCritterSlot)

			return
		end

		if not ((critterCount >= selectedCritterSlot + 1 or nil) and true) then
			logError(string.format("ManufactureController:clickCritterItem error, critter slot not unlock, buildingUid:%s critterSlotId:%s", selectedBuildingUid, selectedCritterSlot))

			return
		end

		local oldCritterUid = buildingMO:getWorkingCritter(selectedCritterSlot)

		if oldCritterUid and not isReplace then
			logError(string.format("ManufactureController:clickCritterItem error, slot has critter, buildingUid:%s critterSlotId:%s", selectedBuildingUid, selectedCritterSlot))

			return
		end

		local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)

		if ((critterMO or nil) and critterMO:getMoodValue()) <= 0 then
			GameFacade.showToast(ToastEnum.RoomCritterNoMoodWork)

			return
		end

		if oldCritterUid and isReplace then
			self:allocateCritter(selectedBuildingUid, CritterEnum.InvalidCritterUid, selectedCritterSlot)
		end

		self:allocateCritter(selectedBuildingUid, critterUid, selectedCritterSlot)
	end
end

function ManufactureController:clickTransportCritterSlotItem(pathId)
	local isShowCritterListView = ViewMgr.instance:isOpen(ViewName.RoomCritterListView)
	local lastSelectedPath = ManufactureModel.instance:getSelectedTransportPath()

	if isShowCritterListView and lastSelectedPath == pathId then
		self:clearSelectTransportPath()
	else
		ManufactureModel.instance:setSelectedTransportPath(pathId)
		ViewMgr.instance:openView(ViewName.RoomCritterListView, {
			pathId = pathId
		})
		self:dispatchEvent(ManufactureEvent.ChangeSelectedTransportPath)
	end
end

function ManufactureController:clearSelectTransportPath()
	ViewMgr.instance:closeView(ViewName.RoomCritterListView)
	ManufactureModel.instance:setSelectedTransportPath()
	self:dispatchEvent(ManufactureEvent.ChangeSelectedTransportPath)
end

function ManufactureController:clickTransportCritterItem(critterUid)
	local allotPathId = ManufactureModel.instance:getSelectedTransportPath()

	if not allotPathId then
		logError(string.format("ManufactureController:clickTransportCritterItem error, not select transport path"))

		return
	end

	local allotCritterUid
	local workingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(critterUid)
	local workingPathId = workingPathMO and workingPathMO.id
	local isWorkingInCurPath = workingPathId == allotPathId

	if isWorkingInCurPath then
		allotCritterUid = CritterEnum.InvalidCritterUid
	else
		local allotPathMO = RoomMapTransportPathModel.instance:getTransportPathMO(allotPathId)
		local pathCritterUid = allotPathMO and allotPathMO.critterUid

		if not allotPathMO or pathCritterUid and pathCritterUid ~= CritterEnum.InvalidCritterUid and pathCritterUid ~= tonumber(CritterEnum.InvalidCritterUid) then
			GameFacade.showToast(ToastEnum.RoomNotSelectedCritterSlot)

			return
		end

		local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)

		if ((critterMO or nil) and critterMO:getMoodValue()) <= 0 then
			GameFacade.showToast(ToastEnum.RoomCritterNoMoodWork)

			return
		end

		allotCritterUid = critterUid
	end

	if allotPathId and allotCritterUid then
		RoomRpc.instance:sendAllotCritterRequestt(allotPathId, allotCritterUid)
	end
end

function ManufactureController:checkTradeLevelCondition(buildingUid)
	local result = false
	local failToast, needDesc, needTradeLevel
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local upgradeGroup = ManufactureConfig.instance:getBuildingUpgradeGroup(buildingMO and buildingMO.buildingId)

	if upgradeGroup ~= 0 then
		local tradeLevel = ManufactureModel.instance:getTradeLevel()

		needTradeLevel = ManufactureConfig.instance:getNeedTradeLevel(upgradeGroup, buildingMO.level + 1)

		if needTradeLevel then
			result = needTradeLevel <= tradeLevel
		end
	end

	if not result then
		failToast = ToastEnum.RoomUpgradeFailByTradeLevel

		local lang = luaLang("room_manufacutre_building_level_up_need_trade_level")
		local cfg = ManufactureConfig.instance:getTradeLevelCfg(needTradeLevel)

		needDesc = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, cfg.dimension, cfg.job)
	end

	return result, failToast, needDesc
end

function ManufactureController:oneKeyManufactureItem(oneKeyType)
	local isCanFill = self:checkCanFill(oneKeyType)

	if not isCanFill then
		return
	end

	local buildingType, buildingId, itemId, quantity

	if oneKeyType == RoomManufactureEnum.OneKeyType.Customize then
		OneKeyAddPopListModel.instance:recordSelectManufactureItem()

		local curManufactureItem, curCount = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

		buildingType = ManufactureConfig.instance:getManufactureItemBelongBuildingType(curManufactureItem)

		if buildingType ~= RoomBuildingEnum.BuildingType.Collect then
			local produceBuildingList = ManufactureConfig.instance:getManufactureItemBelongBuildingList(curManufactureItem)

			buildingId = produceBuildingList and produceBuildingList[1]
		end

		itemId = ManufactureConfig.instance:getItemId(curManufactureItem)

		local _, minUnitCount = ManufactureConfig.instance:getManufactureItemUnitCountRange(curManufactureItem)

		quantity = minUnitCount * curCount
	end

	ManufactureModel.instance:setRecordOneKeyType(oneKeyType)
	RoomStatController.instance:oneKeyDispatch(false, oneKeyType)
	RoomRpc.instance:sendBatchAddProctionsRequest(oneKeyType, buildingType, buildingId, itemId, quantity)
	ViewMgr.instance:closeView(ViewName.RoomOneKeyView)
end

function ManufactureController:checkCanFill(oneKeyType)
	local result = true

	if oneKeyType == RoomManufactureEnum.OneKeyType.TracedOrder then
		local hasTraceOrder = false
		local orders = RoomTradeModel.instance:getDailyOrders()

		for i, orderMO in ipairs(orders) do
			if orderMO.isTraced then
				hasTraceOrder = true

				break
			end
		end

		if not hasTraceOrder then
			GameFacade.showToast(ToastEnum.RoomTraceOrderIsEnough)

			result = false
		end
	elseif oneKeyType == RoomManufactureEnum.OneKeyType.Customize then
		local curManufactureItem = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

		if curManufactureItem then
			local _, noEmptySlot = ManufactureModel.instance:getMaxCanProductCount(curManufactureItem)

			if noEmptySlot then
				GameFacade.showToast(ToastEnum.RoomNoEmptyManufactureSlot)

				result = false
			end
		else
			GameFacade.showToast(ToastEnum.RoomNotSelectedManufactureItem)

			result = false
		end
	end

	return result
end

function ManufactureController:oneKeyCritter(isTransport)
	if isTransport then
		if not CritterEnum.OneKeyType.Transport then
			local type = CritterEnum.OneKeyType.Manufacture

			RoomStatController.instance:oneKeyDispatch(true, type)
			RoomRpc.instance:sendBatchDispatchCrittersRequest(type)
		end
	end
end

function ManufactureController:openRouseCritterView(msg)
	local infoList = {}

	for _, batchDispatchInfo in ipairs(msg.infos) do
		local info = {
			buildingUid = batchDispatchInfo.buildingUid,
			roadId = batchDispatchInfo.roadId,
			critterUids = {}
		}

		for _, critterUid in ipairs(batchDispatchInfo.critterUids) do
			table.insert(info.critterUids, critterUid)
		end

		table.insert(infoList, info)
	end

	if #infoList <= 0 then
		GameFacade.showToast(ToastEnum.NoCritterCanWork)

		return
	end

	ViewMgr.instance:openView(ViewName.RoomCritterOneKeyView, {
		type = msg.type,
		infoList = infoList
	})
end

function ManufactureController:sendRouseCritter(type, infoList)
	RoomRpc.instance:sendRouseCrittersRequest(type, infoList)
end

function ManufactureController:removeRestingCritterList(critterList)
	if not critterList then
		return
	end

	local hasChangeRest = false

	for _, critterUid in ipairs(critterList) do
		local restBuildingUid = ManufactureModel.instance:getCritterRestingBuilding(critterUid)
		local critterBuildingInfo = ManufactureModel.instance:getCritterBuildingMOById(restBuildingUid)

		if critterBuildingInfo then
			critterBuildingInfo:removeRestingCritter(critterUid)

			hasChangeRest = true
		end
	end

	if hasChangeRest then
		RoomCritterModel.instance:initStayBuildingCritters()
		CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangeRestingCritter)
	end
end

function ManufactureController:removeRestingCritter(critterUid)
	local hasChangeRest = false
	local restBuildingUid = ManufactureModel.instance:getCritterRestingBuilding(critterUid)
	local critterBuildingInfo = ManufactureModel.instance:getCritterBuildingMOById(restBuildingUid)

	if critterBuildingInfo then
		critterBuildingInfo:removeRestingCritter(critterUid)

		hasChangeRest = true
	end

	if hasChangeRest then
		RoomCritterModel.instance:initStayBuildingCritters()
		CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangeRestingCritter)
	end
end

function ManufactureController:resetCameraOnCloseView()
	local roomScene = RoomCameraController.instance:getRoomScene()
	local recordCameraState, recordCameraParam = ManufactureModel.instance:getCameraRecord()

	if roomScene and recordCameraState and recordCameraParam then
		roomScene.camera:switchCameraState(recordCameraState, recordCameraParam)
	end

	ManufactureModel.instance:setCameraRecord()
end

function ManufactureController:getPlayAddEffDict(manuBuildingInfos)
	if not manuBuildingInfos then
		return
	end

	local playAddEffDict = {}

	for _, manuBuildingInfo in ipairs(manuBuildingInfos) do
		local buildingUid = manuBuildingInfo.buildingUid
		local manufactureInfo = ManufactureModel.instance:getManufactureMOById(buildingUid)

		if manufactureInfo then
			for _, slotInfo in ipairs(manuBuildingInfo.slotInfos) do
				local slotId = slotInfo.slotId
				local oldSlotMO = manufactureInfo:getSlotMO(slotId)
				local oldManufactureItemId = oldSlotMO and oldSlotMO:getSlotManufactureItemId()

				if (not oldManufactureItemId or oldManufactureItemId == 0) and slotInfo.productionId and slotInfo.productionId ~= 0 then
					playAddEffDict[buildingUid] = playAddEffDict[buildingUid] or {}
					playAddEffDict[buildingUid][slotId] = true
				end
			end
		end
	end

	return playAddEffDict
end

ManufactureController.instance = ManufactureController.New()

return ManufactureController
