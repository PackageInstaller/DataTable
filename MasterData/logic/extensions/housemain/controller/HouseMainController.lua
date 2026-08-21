-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/controller/HouseMainController.lua

module("logic.extensions.housemain.controller.HouseMainController", package.seeall)

local M = class("HouseMainController", BaseController)

function M:ctor()
	self._roomViewName = {}
	self._roomViewName[HouseEnum.RoomType.Supervisor] = {
		ViewName.SupervisorMain,
		ViewName.SupervisorDetail,
		ViewName.SupervisorMaterial,
		ViewName.SupervisorUpgrade
	}
	self._roomViewName[HouseEnum.RoomType.Trading] = {
		ViewName.TradingEntrance,
		ViewName.TradingDeviceManagement,
		ViewName.TradingDeviceUpgrade,
		ViewName.TradingCentre,
		ViewName.TradingOrder,
		ViewName.TradingOrderRefresh,
		ViewName.TradingOrderInfo,
		ViewName.TradingProductDetail
	}
	self._roomViewName[HouseEnum.RoomType.Manufacturing] = {
		ViewName.ManufactureMain,
		ViewName.ManufactureDetail,
		ViewName.ManufactureUpgrade,
		ViewName.ManufactureMaterial,
		ViewName.ManufactureSpeedUp,
		ViewName.ManufactureScheme,
		ViewName.ManufactureSchemeEnsure
	}
	self._roomViewName[HouseEnum.RoomType.Shelter] = {
		ViewName.FacilityHoldingMainView,
		ViewName.FacilityHoldingManageView,
		ViewName.FacilityHoldingChangeView,
		ViewName.FacilityHoldingInformationTipsView,
		ViewName.FacilityHoldingUpgradeView,
		ViewName.FacilityHoldingPrototypeInfoView,
		ViewName.FacilityHoldingModuleTipsView,
		ViewName.FacilityHoldingReportDetailsView,
		ViewName.FacilityHoldingReportSettlementView,
		ViewName.FacilityHoldingReportSpeedupTipsView,
		ViewName.FacilityHoldingReportView,
		ViewName.FacilityHoldingUnlockConditionTipsView,
		ViewName.FacilityHoldingPreviewView
	}
	self._roomViewName[HouseEnum.RoomType.Living] = {
		ViewName.LivingFacilitiesMain,
		ViewName.LivingExchangeFacilityTips,
		ViewName.LivingFacilitiesAdjustSchedule,
		ViewName.LivingFacilitiesAtmosValueTip,
		ViewName.LivingFacilitiesFurnitureThemeTips,
		ViewName.LivingFacilitiesRoomManage,
		ViewName.LivingFacilitiesStaticsTips,
		ViewName.LivingMoudleCollectTips,
		ViewName.LivingAdjustScheduleTip,
		ViewName.HouseDormAdjust
	}
end

function M:onInit()
	return
end

function M:onReset()
	self:_setEvent(false)

	self._isInit = nil
end

function M:checkInit()
	if not self._isInit then
		self:_setEvent(true)
		self:onInit()

		self._isInit = true
	end
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self.handleHouseHoldRoomInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self.handleChangeHouseWorkerSucceed, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_FOCUS_ROOM_ENTER, self.handleOnFocusRoomEnter, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_FOCUS_ROOM_EXIST, self.handleOnFocusRoomExist, self)
		HouseDispatcher:addEventListener(HouseEventType.TRY_JUMP_OUT_HOUSEMAIN, self.handleTryJumpOutHouseMain, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_REPORT_DETAIL_EXIST, self.handleOnReportDetailExist, self)
		HouseDispatcher:addEventListener(HouseEventType.HOUSE_GOODS_STORE_CHANGE, self.handleHouseGoodsStoreChange, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self.handleLiveZoneInfoRefresh, self)
		GlobalDispatcher:addEventListener(EventType.TRADING_POST_INFO, self._onTradingPostInfoUpdate, self)
		GlobalDispatcher:addEventListener(EventType.TRADING_ORDER_LIST, self._onTradingOrderList, self)
		GlobalDispatcher:addEventListener(EventType.TRADING_REFRESH_TIME, self._onTradingRefreshTime, self)
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_EVENT, self.handleJumpViewEvent, self)
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_ADD_EVENT, self.handleGainItemAdd, self)
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.handleCostItemCount, self)
		GlobalDispatcher:addEventListener(EventType.SUPERVISOR_INFO_REPLY, self.handleSupervisorInfoReply, self)
		GlobalDispatcher:addEventListener(EventType.SUPERVISOR_INFO_CHANGE, self.handleSupervisorInfoReply, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self.handleHouseHoldRoomInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self.handleChangeHouseWorkerSucceed, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_FOCUS_ROOM_ENTER, self.handleOnFocusRoomEnter, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_FOCUS_ROOM_EXIST, self.handleOnFocusRoomExist, self)
		HouseDispatcher:removeEventListener(HouseEventType.TRY_JUMP_OUT_HOUSEMAIN, self.handleTryJumpOutHouseMain, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_REPORT_DETAIL_EXIST, self.handleOnReportDetailExist, self)
		HouseDispatcher:removeEventListener(HouseEventType.HOUSE_GOODS_STORE_CHANGE, self.handleHouseGoodsStoreChange, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self.handleLiveZoneInfoRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.TRADING_POST_INFO, self._onTradingPostInfoUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.TRADING_ORDER_LIST, self._onTradingOrderList, self)
		GlobalDispatcher:removeEventListener(EventType.TRADING_REFRESH_TIME, self._onTradingRefreshTime, self)
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_EVENT, self.handleJumpViewEvent, self)
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_ADD_EVENT, self.handleGainItemAdd, self)
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.handleCostItemCount, self)
		GlobalDispatcher:removeEventListener(EventType.SUPERVISOR_INFO_REPLY, self.handleSupervisorInfoReply, self)
		GlobalDispatcher:removeEventListener(EventType.SUPERVISOR_INFO_CHANGE, self.handleSupervisorInfoReply, self)
	end
end

function M:handleHouseHoldRoomInfoChange()
	local reportNum = ContainmentModel.instance:getHasReportRoomCount()

	HouseMainRoomModel.instance:setHarvestNum(HouseMainEnum.HarvestTyp.HoldReport, reportNum)
end

function M:handleJumpViewEvent(e, jumpId, ...)
	if not SystemJumpController.instance:canJump(jumpId) then
		return
	end

	local curSceneFlowTyp = SceneFace.instance:getCurSceneFlowTyp()

	if curSceneFlowTyp and curSceneFlowTyp == SceneType.House then
		self._isJumpingOutHouseMain = true
	end
end

function M:handleTryJumpOutHouseMain(e)
	local curSceneFlowTyp = SceneFace.instance:getCurSceneFlowTyp()

	if curSceneFlowTyp and curSceneFlowTyp == SceneType.House then
		self._isJumpingOutHouseMain = true
	end
end

function M:handleOnFocusRoomEnter(e)
	self._isJumpingOutHouseMain = false
end

function M:handleOnFocusRoomExist(e)
	if self._isJumpingOutHouseMain then
		self._isJumpingOutHouseMain = false

		return
	end

	local curSceneFlowTyp = SceneFace.instance:getCurSceneFlowTyp()

	if curSceneFlowTyp and curSceneFlowTyp == SceneType.House then
		HouseMainStateModel.instance:changeState(HouseMainEnum.State.Normal)
		HouseMainRoomModel.instance:setFocusRoomId(nil)
	end
end

function M:handleOnReportDetailExist(e, info)
	local state = HouseMainStateModel.instance:getState()

	if state == HouseMainEnum.State.FailReportReplay then
		HouseMainStateModel.instance:changeState(HouseMainEnum.State.FocusRoom)

		if info then
			-- block empty
		end
	end
end

function M:handleHouseGoodsStoreChange(e)
	self:_checkUpTradeGoodsFull()
end

function M:handleGainItemAdd(e)
	local curSceneFlowTyp = SceneFace.instance:getCurSceneFlowTyp()

	if curSceneFlowTyp and curSceneFlowTyp == SceneType.House then
		local point = HouseMainRoomModel.instance:getBackLogTypNum(HouseMainEnum.BackLogTyp.tradeGoodsFull)

		if point == 0 then
			self:_checkUpTradeGoodsFull()
		end
	end
end

function M:handleCostItemCount()
	local curSceneFlowTyp = SceneFace.instance:getCurSceneFlowTyp()

	if curSceneFlowTyp and curSceneFlowTyp == SceneType.House then
		local point = HouseMainRoomModel.instance:getBackLogTypNum(HouseMainEnum.BackLogTyp.tradeGoodsFull)

		if point > 0 then
			self:_checkUpTradeGoodsFull()
		end
	end
end

function M:_checkUpTradeGoodsFull()
	local full = RoomBackpackModel.instance:getIsTradeMaterialFull()

	HouseMainRoomModel.instance:setBackLogNum(HouseMainEnum.BackLogTyp.tradeGoodsFull, full and 1 or 0)
end

function M:handleChangeHouseWorkerSucceed(e)
	local curSceneFlowTyp = SceneFace.instance:getCurSceneFlowTyp()

	if curSceneFlowTyp and curSceneFlowTyp == SceneType.House then
		local curSceneFlow = SceneFace.instance:getCurSceneFlow()
		local unitMgr = curSceneFlow and curSceneFlow.unitMgr or nil

		if unitMgr then
			unitMgr:updatePlayerUnit()
		end
	end
end

function M:_onTradingPostInfoUpdate(e, tradingPostMo)
	self:_checkUpTradeOrderFull()
end

function M:_onTradingOrderList(e)
	self:_checkUpTradeOrderFull()
end

function M:_checkUpTradeOrderFull()
	return
end

function M:_onTradingGoodPriceChange()
	HouseMainRoomModel.instance:setBackLogNum(HouseMainEnum.BackLogTyp.tradePriceChange, 1)
end

function M:_onTradingRefreshTime(e, time)
	HouseMainRoomModel.instance:setTradeGoodsRefreshTime(time)
end

function M:handleSupervisorInfoReply(e)
	HouseMainRoomModel.instance:setBackLogNum(HouseMainEnum.BackLogTyp.spLivingRoomRemain, 0)
end

function M:handleLiveZoneInfoRefresh(e, zoneId)
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, zoneId)

	if roomCO and roomCO.roomType == HouseEnum.RoomType.Living then
		HouseMainRoomModel.instance:setBackLogNum(HouseMainEnum.BackLogTyp.spLivingRoomRemain, 0)
	end
end

function M:onReceiveHouseRewards(msg)
	local managerStor = msg.managerStore or 0
	local plantStore = msg.plantStore

	if SupervisorModel.instance:isStoreFulled() then
		SupervisorModel.instance:updateNextProductTimeStamp()
	end

	SupervisorModel.instance:setCurrStore(managerStor)
	GlobalDispatcher:dispatchEvent(EventType.SUPERVISOR_INFO_CHANGE)

	if plantStore and #plantStore > 0 then
		for _, KeyValue in ipairs(plantStore) do
			local plant = KeyValue.key
			local store = KeyValue.value
			local mo = ManufactureModel.instance:getPlantById(plant)

			if mo:isStoreFulled() then
				mo:updateNextProductTimeStamp()
			end

			mo:setCurrStore(store)
			ManufactureModel.instance:setTotalStoreToMainView()
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.MANUFACTURE_PLANT_INFO_CHANGE)

	local info = {
		intelligences = msg.intelligences,
		managerRewards = msg.managerRewards,
		manufactureRewards = msg.manufactureRewards,
		holdRewards = msg.holdRewards
	}

	ViewMgr.instance:open(ViewName.RoomGainView, info)
end

function M:initBackLogAndHarvestNum()
	HouseMainRoomModel.instance:setBackLogNum(HouseMainEnum.BackLogTyp.tradeGoodsFull, RoomBackpackModel.instance:getIsTradeMaterialFull() and 1 or 0)
	TradingAgent.instance:sendGetTradePostInfoRequest()
	HouseMainRoomModel.instance:setHarvestNum(HouseMainEnum.HarvestTyp.HoldReport, ContainmentModel.instance:getHasReportRoomCount())
	SupervisorAgent.instance:sendGetManagerInfoRequest()
	ManufactureAgent.instance:sendGetManufactureInfoRequest()
end

function M:onHouseSceneEnterDealJumpInfo(jumpInfoTable)
	if jumpInfoTable then
		local jumpInfo = jumpInfoTable.jumpInfo
		local otherParams = jumpInfoTable.otherParams

		if jumpInfo == nil then
			return
		end

		local viewName = jumpInfo.viewName

		if viewName == ViewName.RoomMainView then
			-- block empty
		else
			local executeData

			if otherParams.isCustomJump then
				executeData = self:_dealCustomJump(jumpInfo, otherParams)
			else
				executeData = self:_dealJumpInfo(viewName, jumpInfo)
			end

			local targetRoomId = executeData.targetRoomId
			local otherViewName = executeData.otherViewName
			local otherViewOpenParam = executeData.otherViewOpenParam

			if targetRoomId > 0 then
				local focusRoomId = HouseMainRoomModel.instance:getFocusRoomId()

				if focusRoomId then
					printWarn("上次聚焦房间 ", focusRoomId)
					self:closeRoomView(focusRoomId)
				end

				HouseMainStateModel.instance:changeState(HouseMainEnum.State.Normal)
				HouseMainRoomModel.instance:setFocusRoomId(nil)

				local ringTyp = NavMeshUtil.getRingTypeByZoneId(targetRoomId)

				HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CHANGE_RING_TYPE, ringTyp)
				HouseDispatcher:dispatchEvent(HouseEventType.TRY_FOCUS_ROOM, targetRoomId, true, function()
					self:_openView(otherViewName, otherViewOpenParam)
				end, self)
			else
				self:_openView(otherViewName, otherViewOpenParam)
			end
		end
	end

	HouseMainRoomModel.instance:setJumpInfo(nil)
end

function M:closeRoomView(roomId)
	return
end

function M:_openView(viewName, openParam)
	if not string.nilorempty(viewName) then
		if ViewMgr.instance:isOpen(viewName) then
			ViewMgr.instance:close(viewName)
		end

		ViewMgr.instance:open(viewName, openParam)
	end
end

function M:_dealCustomJump(jumpInfo, otherInfo)
	local executeData = {
		targetRoomId = 0,
		otherViewOpenParam = {}
	}

	executeData.targetRoomId = otherInfo.roomId
	executeData.otherViewName = otherInfo.otherViewName
	executeData.otherViewOpenParam = otherInfo.otherViewOpenParam

	return executeData
end

function M:_dealJumpInfo(viewName, jumpInfo)
	local executeData = {
		targetRoomId = 0,
		otherViewOpenParam = {}
	}

	if not string.nilorempty(jumpInfo.extValue1) then
		executeData.targetRoomId = tonumber(jumpInfo.extValue1)
	end

	if not string.nilorempty(jumpInfo.extValue2) then
		executeData.otherViewName = jumpInfo.extValue2
	end

	if viewName == ViewName.FacilityHoldingInformationTipsView then
		executeData = self:_specialDealJumpInfo_ToProtomer(jumpInfo, executeData)
	end

	return executeData
end

function M:_specialDealJumpInfo_ToProtomer(jumpInfo, executeData)
	executeData.otherViewName = nil

	if not string.nilorempty(jumpInfo.param) then
		local protomerId = tonumber(jumpInfo.param)
		local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(protomerId)

		if protomerInfoMo then
			if protomerInfoMo:getRoomId() > 0 then
				executeData.targetRoomId = protomerInfoMo:getRoomId()
			else
				executeData.otherViewName = ViewName.FacilityHoldingInformationTipsView
				executeData.otherViewOpenParam = {
					roomId = executeData.targetRoomId,
					protomerId = protomerId
				}
			end
		end
	end

	return executeData
end

M.instance = M.New()

return M
