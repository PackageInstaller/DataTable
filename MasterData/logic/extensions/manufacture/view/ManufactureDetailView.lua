-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/view/ManufactureDetailView.lua

module("logic.extensions.manufacture.view.ManufactureDetailView", package.seeall)

local M = class("ManufactureDetailView", ViewComponent)

function M:buildUI()
	self._btnUpgrade = self:getBtn("facility_yield_details_view_-349287854")
	self._txtTitle = self:getText("6&title_view_-788888785")
	self._txtDeviceName = self:getText("facility_yield_details_view_-1628847529")
	self._txtDeviceLv = self:getText("facility_yield_details_view_-861198366")
	self._txtDeviceDesc = self:getText("facility_yield_details_view_-324333741")

	goutil.setActive(self:getGoByPath("bg/zhizaochang"), true)
	goutil.setActive(self:getGoByPath("content1/facility_icon/zhizaochang"), true)

	self._goProductIcon = self:getGo("facility_yield_details_view_-2076788158")
	self._txtProductTitle = self:getText("facility_yield_details_view_-942405310")
	self._txtProductValueAll = self:getText("facility_yield_details_view_-894415307")
	self._imgProdectValueAdd1Bg = self:getImage("facility_yield_details_view_-272852578")
	self._txtProductValueAdd1 = self:getText("facility_yield_details_view_-1971476288")
	self._imgProdectValueAdd2Bg = self:getImage("facility_yield_details_view_-444389593")
	self._txtProductValueAdd2 = self:getText("facility_yield_details_view_-296914281")
	self._goMoodIcon = self:getGo("facility_yield_details_view_686403396")
	self._txtMoodTitle = self:getText("facility_yield_details_view_1908690522")
	self._txtMoodValueAll = self:getText("facility_yield_details_view_-17638271")
	self._imgMoodValueAdd1Bg = self:getImage("facility_yield_details_view_1937748410")
	self._txtMoodValueAdd1 = self:getText("facility_yield_details_view_-1438586250")
	self._txtUnlockRoomTitle = self:getText("facility_yield_details_view_1983393019")
	self._txtUnlockWorkerTitle = self:getText("facility_yield_details_view_-1720383915")

	local unlockPlanItemRoot = self:getGo("facility_yield_details_view_-1022886767")

	self._arrayUnlockPlantItem = {}

	for i = 1, 3 do
		local itemGO = goutil.findChild(unlockPlanItemRoot, string.format("order_item%s", i))
		local plantItem = Astral.LuaComponentContainer.Add(itemGO, RoomOrderIconItem)

		plantItem:setVisible(true)
		table.insert(self._arrayUnlockPlantItem, plantItem)
	end

	local unlockWorkerItemRoot = self:getGo("facility_yield_details_view_-159515791")

	self._arrayUnlockWorkerItem = {}

	for i = 1, 3 do
		local itemGO = goutil.findChild(unlockWorkerItemRoot, string.format("duty_item%s", i))
		local workerItem = Astral.LuaComponentContainer.Add(itemGO, RoomOrderIconItem)

		workerItem:setVisible(true)
		table.insert(self._arrayUnlockWorkerItem, workerItem)
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnUpgrade:AddClickListener(self._onClickBtnUpgrade, self)
end

function M:unbindEvents()
	self._btnUpgrade:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.MANUFACTURE_INFO_REPLY, self._onManufactureInfoReply, self)
		GlobalDispatcher:addEventListener(EventType.MANUFACTURE_PLANT_INFO_CHANGE, self._onManufactureInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MANUFACTURE_INFO_REPLY, self._onManufactureInfoReply, self)
		GlobalDispatcher:removeEventListener(EventType.MANUFACTURE_PLANT_INFO_CHANGE, self._onManufactureInfoChange, self)
	end
end

function M:onEnter()
	self:initView()
	self:refreshView()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)
end

function M:initView()
	self._txtTitle.text = lang("tip_manufacturer")
	self._txtDeviceName.text = lang("tip_manufacturer")
	self._txtProductTitle.text = lang("tip_productivity_minute")
	self._txtMoodTitle.text = lang("tip_mood_hour")
	self._txtUnlockRoomTitle.text = lang("tip_unlock_workshop")
	self._txtUnlockWorkerTitle.text = lang("tip_unlock_authorized_strength")
end

function M:refreshView()
	local mo = ManufactureModel.instance:getPlantById(1)
	local lv = ManufactureModel.instance:getLv()

	self._txtDeviceLv.text = string.format("Lv.%s", lv)
	self._txtDeviceDesc.text = ManufactureModel.instance:getDescription()
	self._txtProductValueAll.text = MathUtil.preciseDecimal(mo:getProductSpeed(), 1)

	local productHero = MathUtil.preciseDecimal(mo:getProductHero(), 0)
	local productHeroStr = productHero > 0 and string.format("%s%%", productHero) or ""

	self._txtProductValueAdd1.text = productHeroStr

	goutil.setActive(self._imgProdectValueAdd1Bg.gameObject, productHero > 0)

	local productHouseRatio = MathUtil.preciseDecimal(mo:getProductHouseRatio(), 0)
	local productHouseRatioStr = productHouseRatio > 0 and string.format("%s%%", productHouseRatio) or ""

	self._txtProductValueAdd2.text = productHouseRatioStr

	goutil.setActive(self._imgProdectValueAdd2Bg.gameObject, productHouseRatio > 0)

	self._txtMoodValueAdd1.text = ""

	goutil.setActive(self._imgMoodValueAdd1Bg.gameObject, false)

	self._txtMoodValueAll.text = MathUtil.preciseDecimal(SupervisorModel.instance:getTotalMoodCost() * 60, 1)

	for idx, plantItem in ipairs(self._arrayUnlockPlantItem) do
		local plantMO = ManufactureModel.instance:getPlantById(idx)
		local unlock = not plantMO:isLock()

		plantItem:setLock(not unlock)
		plantItem:setName(lang("tip_workshop_" .. idx))
		plantItem:setIcon(IconType.HouseWorkShop, "room_workshop" .. idx)
	end

	local unlockJobCount = ManufactureModel.instance:getJobCount()
	local jobCodeList = HouseEnum.WorkType2JobCodeList[HouseEnum.WorkType.Manufacturing]

	for idx, workerItem in ipairs(self._arrayUnlockWorkerItem) do
		local unlock = idx <= unlockJobCount
		local jobCode = jobCodeList[idx]
		local cfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseWorker, jobCode)

		workerItem:setLock(not unlock)
		workerItem:setName(cfg.jobName)
		workerItem:setIcon(IconType.HouseCompile, cfg.icon)
	end

	local maxLv = SupervisorConfig.instance:getMaxModuleLv()
	local limitLv = ManufactureModel.instance:getLimitLv()

	goutil.setActive(self._btnUpgrade.gameObject, lv < maxLv)
end

function M:_onClickBtnUpgrade()
	ViewMgr.instance:open(ViewName.ManufactureUpgrade)
end

function M:_onManufactureInfoReply()
	self:refreshView()
end

function M:_onManufactureInfoChange()
	self:refreshView()
end

return M
