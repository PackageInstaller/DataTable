-- chunkname: @modules/logic/critter/controller/CritterController.lua

module("modules.logic.critter.controller.CritterController", package.seeall)

local CritterController = class("CritterController", BaseController)

function CritterController:onInit()
	self._oldWorkPathId = nil
	self._isToastStopWork = false
end

function CritterController:onInitFinish()
	return
end

function CritterController:addConstEvents()
	return
end

function CritterController:reInit()
	self._oldWorkPathId = nil
	self._isToastStopWork = false
end

function CritterController:critterGetInfoReply(msg)
	CritterModel.instance:initCritter(msg.critterInfos)
end

function CritterController:critterInfoPush(msg)
	if not msg.critterInfos then
		for i, critterInfo in ipairs(msg.critterInfos) do
			CritterModel.instance:addCritter(critterInfo)
		end

		self:dispatchEvent(CritterEvent.CritterInfoPushReply)

		self.tempCritterMoList = {}

		for k, critterInfo in ipairs(msg.critterInfos) do
			local critterMO = CritterMO.New()

			critterMO:init(critterInfo)

			self.tempCritterMoList[k] = critterMO
		end
	end
end

function CritterController:startTrainCritterReply(msg)
	local critterMO = CritterModel.instance:getCritterMOByUid(msg.uid)

	if critterMO then
		critterMO.trainInfo.heroId = msg.heroId

		local slotMO = RoomTrainSlotListModel.instance:findWaitingSlotMOByUid(msg.uid) or RoomTrainSlotListModel.instance:findFreeSlotMO()

		if slotMO then
			slotMO:setCritterMO(critterMO)
		end
	end

	self:dispatchEvent(CritterEvent.TrainStartTrainCritterReply, msg.uid, msg.heroId)
end

function CritterController:fastForwardTrainReply(msg)
	self:dispatchEvent(CritterEvent.FastForwardTrainReply)
end

function CritterController:cancelTrainReply(msg)
	local slotMO = RoomTrainSlotListModel.instance:getSlotMOByCritterUi(msg.uid)

	if slotMO then
		slotMO:setCritterMO(nil)
	end

	self:dispatchEvent(CritterEvent.TrainCancelTrainReply, msg.uid)
end

function CritterController:selectEventOptionReply(msg)
	self:dispatchEvent(CritterEvent.TrainSelectEventOptionReply, msg.uid, msg.eventId or 0)
end

function CritterController:finishTrainCritterReply(msg)
	local critterMO = CritterModel.instance:getCritterMOByUid(msg.uid)

	if critterMO then
		local trainInfo = critterMO.trainInfo

		trainInfo.heroId = 0
	end

	local slotMO = RoomTrainSlotListModel.instance:getSlotMOByCritterUi(msg.uid)

	if slotMO then
		slotMO:setCritterMO(nil)
	end

	self:dispatchEvent(CritterEvent.TrainFinishTrainCritterReply, msg.uid, msg.heroId)
end

function CritterController:startTrainCritterPreviewReply(msg)
	local info = msg.info
	local critterUid = info.uid

	if info.trainInfo then
		local heroId = info.trainInfo.heroId
		local mo = CritterModel.instance:getTrainPreviewMO(critterUid, heroId)

		if mo then
			mo:init(info)
		else
			mo = CritterMO.New()

			mo:init(info)
			CritterModel.instance:addTrainPreviewMO(mo)
		end

		self:dispatchEvent(CritterEvent.StartTrainCritterPreviewReply, critterUid, heroId)
	end
end

function CritterController:finishTrainSpecialEventByUid(critterUid)
	local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)

	if critterMO and critterMO:isCultivating() then
		local eventMOList = critterMO.trainInfo.events

		for i = 1, #eventMOList do
			local eventMO = eventMOList[i]

			if eventMO:getEventType() == CritterEnum.EventType.Special and not eventMO:isEventFinish() then
				CritterRpc.instance:sendSelectEventOptionRequest(critterMO.uid, eventMO.eventId, (#eventMO.options > 0 or nil) and eventMO.options[1].optionId)
			end
		end
	end
end

function CritterController:banishCritterReply(msg)
	CritterModel.instance:removeCritters(msg.uids)
	ManufactureController.instance:removeRestingCritterList(msg.uids)
	self:dispatchEvent(CritterEvent.CritterDecomposeReply, msg.uids)
end

function CritterController:lockCritterRequest(msg)
	local critterMO = CritterModel.instance:getCritterMOByUid(msg.uid)

	if critterMO then
		critterMO.lock = msg.lock
	end

	self:dispatchEvent(CritterEvent.CritterChangeLockStatus, msg.uid)
end

function CritterController:critterRenameReply(msg)
	local critterMO = CritterModel.instance:getCritterMOByUid(msg.uid)

	critterMO.name = msg.name

	self:dispatchEvent(CritterEvent.CritterRenameReply, msg.uid)
end

function CritterController:updateCritterPreviewAttr(buildingId, critterUidList, cb, cbObj)
	CritterRpc.instance:sendGetRealCritterAttributeRequest(buildingId, critterUidList, true, cb, cbObj)
end

function CritterController:setManufactureCritterList(buildingId, workingUid, isTransport, filterMO)
	ManufactureCritterListModel.instance:setCritterNewList(workingUid, isTransport, filterMO)

	local previewCritterUidList = ManufactureCritterListModel.instance:getPreviewCritterUidList()

	if buildingId and previewCritterUidList and #previewCritterUidList > 0 then
		self.updateCritterPreviewAttr(self, buildingId, previewCritterUidList, self._setCritterList, self)
	else
		self:_setCritterList()
	end
end

function CritterController:_setCritterList()
	self:dispatchEvent(CritterEvent.CritterListResetScrollPos)
	ManufactureCritterListModel.instance:setManufactureCritterList()
	self:dispatchEvent(CritterEvent.CritterListUpdate)
end

function CritterController:getNextCritterPreviewAttr(buildingId, startIndex)
	if not buildingId then
		return
	end

	local previewCritterUidList = ManufactureCritterListModel.instance:getPreviewCritterUidList(startIndex)

	if previewCritterUidList and #previewCritterUidList > 0 then
		self:updateCritterPreviewAttr(buildingId, previewCritterUidList)
	end
end

function CritterController:clickCritterPlaceItem(buildingUid, critterUid)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if not buildingMO then
		return
	end

	local targetCritterUid = critterUid
	local seatSlotId = buildingMO:isCritterInSeatSlot(critterUid)

	if seatSlotId then
		targetCritterUid = CritterEnum.InvalidCritterUid
	else
		seatSlotId = buildingMO:getNextEmptyCritterSeatSlot()
	end

	if not seatSlotId then
		GameFacade.showToast(ToastEnum.RoomNoEmptySeatSlot)

		return
	end

	self:changeRestCritter(buildingUid, seatSlotId, targetCritterUid)
end

function CritterController:waitSendBuildManufacturAttrByBuid(buildingUid)
	self._waitBuildManufacturBuidList = self._waitBuildManufacturBuidList or {}

	if not buildingUid or tabletool.indexOf(self._waitBuildManufacturBuidList, buildingUid) then
		return
	end

	table.insert(self._waitBuildManufacturBuidList, buildingUid)

	if #self._waitBuildManufacturBuidList == 1 then
		TaskDispatcher.runDelay(self._onRunSendBuildManufacturAll, self, 1)
	end
end

function CritterController:_onRunSendBuildManufacturAll()
	local buildingUidList = self._waitBuildManufacturBuidList

	self._waitBuildManufacturBuidList = nil

	if buildingUidList then
		for i = 1, #buildingUidList do
			self:sendBuildManufacturAttrByBuid(buildingUidList[i])
		end
	end
end

function CritterController:sendBuildManufacturAttrByBtype(buildingType, isWait)
	local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for _, buildingMO in ipairs(buildingMOList) do
		if buildingMO and buildingMO.config and buildingMO.config.buildingType == buildingType then
			if isWait == true then
				self:waitSendBuildManufacturAttrByBuid(buildingMO.id)
			else
				self:sendBuildManufacturAttrByBuid(buildingMO.id)
			end
		end
	end
end

function CritterController:sendBuildManufacturAttrByBuid(buildingUid)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if not buildingMO then
		return
	end

	local allCritterMOList = CritterModel.instance:getAllCritters()
	local critterUidList

	for _, critterMO in ipairs(allCritterMOList) do
		local critterUid = critterMO:getId()

		if critterMO:isMaturity() and critterMO.workInfo and critterMO.workInfo.workBuildingUid == buildingUid or critterMO.restInfo and critterMO.restInfo.restBuildingUid == buildingUid then
			critterUidList = critterUidList or {}

			table.insert(critterUidList, critterUid)
		end
	end

	if critterUidList then
		CritterRpc.instance:sendGetRealCritterAttributeRequest(buildingMO.buildingId, critterUidList, false)
	end
end

function CritterController:clickCritterInCritterBuilding(buildingUid, critterUid)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local seatSlotId = buildingMO and buildingMO:isCritterInSeatSlot(critterUid)
	local selectedBuildingUid, critterSeatSlotId = ManufactureModel.instance:getSelectedCritterSeatSlot()

	if not seatSlotId or selectedBuildingUid == buildingUid and critterSeatSlotId == seatSlotId then
		self:clearSelectedCritterSeatSlot()
	else
		ManufactureModel.instance:setSelectedCritterSeatSlot(buildingUid, seatSlotId)
		self:dispatchEvent(CritterEvent.CritterBuildingSelectCritter)
	end
end

function CritterController:clearSelectedCritterSeatSlot()
	ManufactureModel.instance:setSelectedCritterSeatSlot()
	self:dispatchEvent(CritterEvent.CritterBuildingSelectCritter)
end

function CritterController:changeRestCritter(buildingUid, seatSlotId, critterUid)
	RoomRpc.instance:sendChangeRestCritterRequest(buildingUid, CritterEnum.SeatSlotOperation.Change, seatSlotId, critterUid, 0, self._afterChangeRestCritter, self)
	ManufactureModel.instance:setNewRestCritter(critterUid)

	self._isToastStopWork = false
	self._oldWorkPathId = nil

	local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)
	local hasMood = critterMO and not critterMO:isNoMood()

	if hasMood then
		local workingBuildingUid = ManufactureModel.instance:getCritterWorkingBuilding(critterUid)
		local workingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(critterUid)

		if workingBuildingUid or workingPathMO then
			self._isToastStopWork = true

			if workingPathMO then
				self._oldWorkPathId = workingPathMO.id
			end
		end
	end
end

function CritterController:_afterChangeRestCritter(cmd, resultCode, msg)
	if resultCode ~= 0 then
		self._isToastStopWork = false

		return
	end

	if self._isToastStopWork then
		GameFacade.showToast(ToastEnum.CritterStopWork)
	end

	if self._oldWorkPathId then
		local info = {
			critterUid = CritterEnum.InvalidCritterUid
		}

		RoomTransportPathModel.instance:updateInofoById(self._oldWorkPathId, info)
		RoomMapTransportPathModel.instance:updateInofoById(self._oldWorkPathId, info)
	end

	self._oldWorkPathId = nil
	self._isToastStopWork = false
end

function CritterController:exchangeSeatSlot(buildingUid, seatSlotId, targetSeatSlotId)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local targetSeatSlotMO = buildingMO:getSeatSlotMO(targetSeatSlotId)

	if targetSeatSlotMO then
		RoomRpc.instance:sendChangeRestCritterRequest(buildingUid, CritterEnum.SeatSlotOperation.Exchange, seatSlotId, CritterEnum.InvalidCritterUid, targetSeatSlotId)
	else
		local roomScene = RoomCameraController.instance:getRoomScene()

		if roomScene then
			roomScene.buildingcrittermgr:refreshAllCritterEntityPos()
		end
	end
end

function CritterController:setCritterBuildingInfoList(restBuildingInfoList)
	if not restBuildingInfoList then
		return
	end

	ManufactureModel.instance:setCritterBuildingInfoList(restBuildingInfoList)
	RoomCritterModel.instance:initStayBuildingCritters()
	self:dispatchEvent(CritterEvent.CritterBuildingChangeRestingCritter)
end

function CritterController:buySeatSlot(buildingUid, seatSlotId)
	RoomRpc.instance:sendBuyRestSlotRequest(buildingUid, seatSlotId)
end

function CritterController:buySeatSlotCb(buildingUid, seatSlotId)
	local critterBuildingInfo = ManufactureModel.instance:getCritterBuildingMOById(buildingUid)

	if not critterBuildingInfo then
		return
	end

	critterBuildingInfo:unlockSeatSlot(seatSlotId)
	self:dispatchEvent(CritterEvent.CritterUnlockSeatSlot)
end

function CritterController:openCritterFilterView(filterTypeList, viewName)
	ViewMgr.instance:openView(ViewName.RoomCritterFilterView, {
		filterTypeList = filterTypeList,
		viewName = viewName
	})
end

function CritterController:openCriiterDetailSimpleView(critterMo)
	local param = {
		critterMo = critterMo
	}

	ViewMgr.instance:openView(ViewName.RoomCriiterDetailSimpleView, param)
end

function CritterController:openRoomCritterDetailView(isYoung, critterMo, isPreview, critterMos)
	local param = {
		isYoung = isYoung,
		critterMo = critterMo,
		isPreview = isPreview,
		critterMos = critterMos
	}

	if isYoung then
		ViewMgr.instance:openView(ViewName.RoomCritterDetailYoungView, param)
	else
		ViewMgr.instance:openView(ViewName.RoomCritterDetailMaturityView, param)
	end
end

function CritterController:popUpCritterGetView()
	local critterMOList = self.tempCritterMoList

	if critterMOList and #critterMOList > 0 then
		local param = {
			isSkip = true,
			mode = RoomSummonEnum.SummonType.ItemGet,
			critterMOList = critterMOList
		}

		PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomGetCritterView, ViewName.RoomGetCritterView, param)

		self.tempCritterMoList = nil
	end
end

CritterController.instance = CritterController.New()

return CritterController
