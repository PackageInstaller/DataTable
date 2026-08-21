-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesProductView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesProductView", package.seeall)

local M = class("LivingFacilitiesProductView", ViewComponent)
local kRequestInterval = 600

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._txtTitle = self:getText("1&title_view_-788888785")

	goutil.setActive(self:getGo("facility_holding_report_view_2131130190"), false)

	local workerItemGO1 = goutil.findChild(self:getGo("room_orders_view_-1306594165"), "room_head")

	self._workerItem = Astral.LuaComponentContainer.Add(workerItemGO1, RoomWorkerItem)

	self._workerItem:setClickCallback(self._onClickWorkerItem, self)

	local workerItemGO2 = goutil.findChild(self:getGo("room_orders_view_-1420932701"), "room_head")

	goutil.setActive(workerItemGO2, false)

	local workerItemGO3 = goutil.findChild(self:getGo("room_orders_view_1912493006"), "room_head")

	goutil.setActive(workerItemGO3, false)

	local contentGO = self:getGo("room_orders_view_2053887595")
	local productGO1 = goutil.findChild(contentGO, "room_orders_item1")

	goutil.setActive(productGO1, false)

	local productGO2 = goutil.findChild(contentGO, "room_orders_item2")

	self._productCell = Astral.LuaComponentContainer.Add(productGO2, RoomProductCell)

	self._productCell:setBtnGetCallback(self._onClickGetMaterial, self)

	local productGO3 = goutil.findChild(contentGO, "room_orders_item3")

	goutil.setActive(productGO3, false)

	self._refreshTimer = SchedulerCtrl.New(self._refreshProgress, self)
	self._requestTimer = SchedulerCtrl.New(self._requestHeroFeatureAgent, self)
end

function M:destroyUI()
	self._refreshTimer:clear()

	self._refreshTimer = nil

	self._requestTimer:clear()

	self._requestTimer = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:_setEvents(isOn)
	if isOn then
		self._requestTimer:stop(kRequestInterval, true)
		GlobalDispatcher:addEventListener(EventType.HERO_MOOD_UPDATE, self._onMoodUpdate, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._onZoneInfoUpdate, self)
		HouseDispatcher:addEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self._onFurnitureUpdate, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_PRODUCT_UPDATE, self._onProductUpdate, self)
	else
		self._requestTimer:stop()
		GlobalDispatcher:removeEventListener(EventType.HERO_MOOD_UPDATE, self._onMoodUpdate, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._onZoneInfoUpdate, self)
		HouseDispatcher:removeEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self._onFurnitureUpdate, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_PRODUCT_UPDATE, self._onProductUpdate, self)
	end
end

function M:onEnter()
	self._zoneMO = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	self._txtTitle.text = lang("tip_product_fragment_lang_1")

	self:refreshView()
	self:_setEvents(true)
	self:_requestHeroFeatureAgent()
end

function M:onExit()
	self._refreshTimer:stop()
	self:_setEvents(false)
end

function M:_requestHeroFeatureAgent()
	local members = self._zoneMO:getRoomMember()
	local heroId = members[1]

	if heroId then
		HouseAgent.instance:sendGetSingleHeroFeatureRequest(heroId)
	end
end

function M:refreshView()
	self:_refreshWorker()
	self:_refreshProduct()
end

function M:_refreshWorker()
	local members = self._zoneMO:getRoomMember()
	local heroId = members[1]

	if heroId then
		self._workerItem:setVisible(true)
		self._workerItem:setHero(heroId)
	else
		local bunkList = self._zoneMO:getBunkList()

		if #bunkList > 0 then
			self._workerItem:setVisible(true)
			self._workerItem:setNone()
		else
			self._workerItem:setVisible(false)
		end
	end
end

function M:_refreshProduct()
	local itemId = self._zoneMO:getShowFragmentId()
	local currStore = self._zoneMO:getCurrStore()
	local limitStore = self._zoneMO:getLimitStore()
	local members = self._zoneMO:getRoomMember()
	local heroId = members[1]

	self._productCell:setLock(false)
	self._productCell:setNoPlan(false)
	self._productCell:setMaterial(itemId)

	if currStore > 0 then
		self._productCell:setBtnGetVisible(true)
		self._productCell:setDoing(false)
	else
		self._productCell:setBtnGetVisible(false)

		if heroId then
			self._productCell:setDoing(true)
		else
			self._productCell:setDoing(false)
		end
	end

	self._productCell:setStore(currStore, limitStore)
	self:_refreshProgress()
	self._refreshTimer:stop()

	if not self._zoneMO:isStoreFulled() then
		self._refreshTimer:restart(1, true)
	end
end

function M:_refreshProgress()
	local progress = 1
	local remainTime = -1

	if self._zoneMO:getInRoomHeroCount() > 0 and not self._zoneMO:isStoreFulled() then
		progress = self._zoneMO:getNextProductProgress()
		remainTime = self._zoneMO:getRemainTimeToFull()
	end

	self._productCell:setProgress(progress, remainTime)
end

function M:_onClickWorkerItem(item)
	ViewMgr.instance:open(ViewName.LivingFacilitiesAdjustSchedule, self._zoneMO)
end

function M:_onClickGetMaterial()
	LivingFacilitiesAgent.instance:sendReceiveSpRoomStoreRequest(self._zoneMO:getId())
end

function M:_onMoodUpdate()
	self:_refreshWorker()
end

function M:_onZoneInfoUpdate()
	self:refreshView()
end

function M:_onFurnitureUpdate()
	self:refreshView()
end

function M:_onProductUpdate()
	self:refreshView()
end

return M
