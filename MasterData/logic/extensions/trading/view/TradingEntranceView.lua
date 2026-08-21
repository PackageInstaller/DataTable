-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingEntranceView.lua

module("logic.extensions.trading.view.TradingEntranceView", package.seeall)

local M = class("TradingEntranceView", ViewComponent)

function M:buildUI()
	self._btnDeviceManagement = self:getBtn("facility_yield_main_view_-1771619263")
	self._btnPersonnelManagement = self:getBtn("facility_yield_main_view_-1643899068")
	self._btnDressUp = self:getBtn("facility_yield_main_view_-26135140")

	goutil.setActive(self._btnDressUp.gameObject, false)

	self._btnTradingCentre = self:getBtn("facility_yield_main_view_-578318949")
	self._btnWeeklyOrder = self:getBtn("facility_yield_main_view_2036911419")
	self._btnDailyOrder = self:getBtn("facility_yield_main_view_2078274785")
	self._imgDailyOrderProgress = self:getImage("facility_yield_main_view_1228393749")
	self._txtDailyOrderNum = self:getText("facility_yield_main_view_1271264630")
	self._txtDailyOrderProgress = self:getText("facility_yield_main_view_1721827863")
	self._imgWeeklyOrderProgress = self:getImage("facility_yield_main_view_1469448251")
	self._goWorkersRoot = self:getGo("facility_yield_main_view_-1861251867")

	local workerItemGO1 = goutil.findChild(self:getGo("facility_yield_main_view_1896231206"), "room_head")

	self._workerItem1 = Astral.LuaComponentContainer.Add(workerItemGO1, RoomWorkerItem)

	self._workerItem1:setClickCallback(self._onClickWorkerItem, self)

	local workerItemGO2 = goutil.findChild(self:getGo("facility_yield_main_view_-1745727221"), "room_head")

	self._workerItem2 = Astral.LuaComponentContainer.Add(workerItemGO2, RoomWorkerItem)

	self._workerItem2:setClickCallback(self._onClickWorkerItem, self)

	local workerItemGO3 = goutil.findChild(self:getGo("facility_yield_main_view_-1542203762"), "room_head")

	self._workerItem3 = Astral.LuaComponentContainer.Add(workerItemGO3, RoomWorkerItem)

	self._workerItem3:setClickCallback(self._onClickWorkerItem, self)

	self._arrayWorkerItem = {
		self._workerItem1,
		self._workerItem2,
		self._workerItem3
	}
	self._btnHideUI = self:getBtn("facility_yield_main_view_-511698712")
	self._goHideImgOpen = goutil.findChild(self._btnHideUI.gameObject, "normal")
	self._goHideImgClose = goutil.findChild(self._btnHideUI.gameObject, "hide")
	self._goTitleView = self:getGo("1&title_view_-478490097")
	self._goMoneyView = self:getGo("0&top_currency_1050779625")

	self:setEvent(true)
end

function M:destroyUI()
	self:setEvent(false)
end

function M:bindEvents()
	self._btnDeviceManagement:AddClickListener(self._onClickDeviceManagement, self)
	self._btnPersonnelManagement:AddClickListener(self._onClickPersonnelManagement, self)
	self._btnWeeklyOrder:AddClickListener(self._onClickWeeklyOrder, self)
	self._btnDailyOrder:AddClickListener(self._onClickOrder, self)
	self._btnTradingCentre:AddClickListener(self._onClickTradingCentre, self)
	self._btnHideUI:AddClickListener(self._onClickBtnHideUI, self)
end

function M:unbindEvents()
	self._btnDeviceManagement:RemoveClickListener()
	self._btnPersonnelManagement:RemoveClickListener()
	self._btnWeeklyOrder:RemoveClickListener()
	self._btnDailyOrder:RemoveClickListener()
	self._btnTradingCentre:RemoveClickListener()
	self._btnHideUI:RemoveClickListener()
end

function M:onEnter()
	TradingAgent.instance:sendGetTradePostInfoRequest()
	self:hideViews(false)
	self:_refreshWorkers()
end

function M:hideViews(hide)
	self._isHideViews = hide

	goutil.setActive(self._goHideImgOpen, hide)
	goutil.setActive(self._goHideImgClose, not hide)
	goutil.setActive(self._btnDeviceManagement.gameObject, not hide)
	goutil.setActive(self._btnPersonnelManagement.gameObject, not hide)
	goutil.setActive(self._btnWeeklyOrder.gameObject, not hide)
	goutil.setActive(self._btnDailyOrder.gameObject, not hide)
	goutil.setActive(self._btnTradingCentre.gameObject, not hide)
	goutil.setActive(self._goTitleView, not hide)
	goutil.setActive(self._goMoneyView, not hide)
	goutil.setActive(self._goWorkersRoot, not hide)
end

function M:onExit(closeReasonType)
	if closeReasonType ~= WindowType.WindowCloseReasonType.QuickCloseType then
		HouseDispatcher:dispatchEvent(HouseEventType.ON_FOCUS_ROOM_EXIST)
	end
end

function M:onExitFinished()
	return
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.TRADING_POST_INFO, self._onTradingPostInfoUpdate, self)
		GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self._refreshRightView, self)
		GlobalDispatcher:addEventListener(EventType.TRADING_ORDER_LIST, self._onTradingPostInfoUpdate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.TRADING_POST_INFO, self._onTradingPostInfoUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self._refreshRightView, self)
		GlobalDispatcher:removeEventListener(EventType.TRADING_ORDER_LIST, self._onTradingPostInfoUpdate, self)
	end
end

function M:_refreshRightView()
	TradingAgent.instance:sendGetTradePostInfoRequest()
	self:_refreshWorkers()
end

function M:_refreshWorkers()
	local jobCodeList = HouseEnum.WorkType2JobCodeList[HouseEnum.WorkType.Trading]

	for idx, workerItem in ipairs(self._arrayWorkerItem) do
		local heroId = HouseWorkerModel.instance:getCurrWorkingHero(jobCodeList[idx])

		if heroId then
			workerItem:setHero(heroId)
		elseif idx <= TradingModel.instance:getJobCount() then
			workerItem:setNone()
		else
			workerItem:setLock()
		end
	end
end

function M:_openJobView(idx)
	local jobConfigList = HouseWorkerModel.instance:getJobConfigListByRoomId(HouseEnum.TRADING_ROOM_ID)

	ViewMgr.instance:open(ViewName.JobDetail, {
		roomIndex = jobConfigList[1].houseIndex,
		clickIndex = idx
	})
end

function M:_onClickWorkerItem(item)
	local idx = table.indexof(self._arrayWorkerItem, item) or 1

	if idx <= TradingModel.instance:getJobCount() then
		self:_openJobView(idx)
	end
end

function M:_onClickDeviceManagement()
	ViewMgr.instance:open(ViewName.TradingDeviceManagement)
end

function M:_onClickPersonnelManagement()
	self:_openJobView(1)
end

function M:_onClickOrder()
	ViewMgr.instance:open(ViewName.TradingOrder)
end

function M:_onClickWeeklyOrder()
	ViewMgr.instance:open(ViewName.TradingOrder, {
		orderType = 2
	})
end

function M:_onClickTradingCentre()
	ViewMgr.instance:open(ViewName.TradingCentre)
end

function M:_onClickBtnHideUI()
	self:hideViews(not self._isHideViews)
end

function M:_onTradingPostInfoUpdate()
	local dailyOrderIds = TradingModel.instance:getDailyOrder()
	local weeklyOrderIds = TradingModel.instance:getWeeklyOrder()
	local mo = TradingModel.instance:getTradePostMo()
	local co = TradingConfig.instance:getHouseCoByLevel(mo:getLevel())
	local maxDailyOrderCount = co.maxDailyOrder
	local maxWeeklyOrderCount = co.maxWeeklyOrder

	self._txtDailyOrderProgress.text = string.format("%d/%d", #dailyOrderIds, maxDailyOrderCount)

	local doneGO = goutil.findChild(self._btnWeeklyOrder.gameObject, "done")
	local sevenGO = goutil.findChild(self._btnWeeklyOrder.gameObject, "seven")

	goutil.setActive(doneGO, #weeklyOrderIds == 0)
	goutil.setActive(sevenGO, #weeklyOrderIds > 0)
	self:_refreshWorkers()
end

return M
