-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingDeviceManagementView.lua

module("logic.extensions.trading.view.TradingDeviceManagementView", package.seeall)

local WorkshopItem = class("WorkshopItem")
local kShopNameMap = {
	lang("tip_trading_lang_15"),
	lang("tip_trading_lang_16"),
	lang("tip_trading_lang_17")
}

function WorkshopItem:ctor(compContainer)
	self._go = compContainer.gameObject

	local go = self._go
	local icon1 = goutil.findChildImageComponent(go, "normal/icon")
	local icon2 = goutil.findChildImageComponent(go, "lock/icon")

	IconLoader.setSprite(icon1, IconType.HouseCompile, "room_order")
	IconLoader.setSprite(icon2, IconType.HouseCompile, "room_order")

	self._goNormal = goutil.findChild(go, "normal")
	self._goLock = goutil.findChild(go, "lock")
	self._txtName = goutil.findChildTextComponent(go, "txtName")

	goutil.setActive(goutil.findChild(go, "imgDi"), false)
	goutil.setActive(goutil.findChild(go, "imgQuality"), false)
end

function WorkshopItem:updateData(data)
	local isNone = data.isNone

	goutil.setActive(self._goNormal, not isNone)
	goutil.setActive(self._goLock, isNone)

	self._txtName.text = kShopNameMap[data.idx]
end

function WorkshopItem:OnDestroy()
	return
end

local M = class("TradingDeviceManagementView", ViewComponent)

function M:buildUI()
	goutil.setActive(self:getGoByPath("bg/maoyizhan"), true)
	goutil.setActive(self:getGoByPath("content1/facility_icon/maoyizhan"), true)

	self._txtDeviceLevel = self:getText("facility_yield_details_view_-861198366")
	self._txtDeviceName = self:getText("facility_yield_details_view_-1628847529")
	self._txtDeviceDesc = self:getText("facility_yield_details_view_-324333741")
	self._txtProductivity = self:getText("facility_yield_details_view_-894415307")
	self._txtProductivityAdd1 = self:getText("facility_yield_details_view_-1971476288")
	self._txtProductivityAdd2 = self:getText("facility_yield_details_view_-296914281")
	self._txtMoodValue = self:getText("facility_yield_details_view_-17638271")
	self._txtMoodValueAdd = self:getText("facility_yield_details_view_-1438586250")
	self._txtProductTitle = self:getText("facility_yield_details_view_-942405310")
	self._txtProductTime = self:getText("facility_yield_details_view_1908690522")
	self._txtUnlockRoomTitle = self:getText("facility_yield_details_view_1983393019")
	self._txtUnlockWorkerTitle = self:getText("facility_yield_details_view_-1720383915")
	self._btnUpgrade = self:getBtn("facility_yield_details_view_-349287854")
	self._goUnlockOrderParent = self:getGo("facility_yield_details_view_-1022886767")
	self._goUnlockOrders = {}
	self._itemWorkshop = {}

	for i = 1, 3 do
		table.insert(self._goUnlockOrders, goutil.findChild(self._goUnlockOrderParent, "order_item" .. i))
		table.insert(self._itemWorkshop, Astral.LuaComponentContainer.Add(self._goUnlockOrders[i], WorkshopItem))
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
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
end

function M:unbindEvents()
	self._btnUpgrade:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self:updateData()
	self:initView()
end

function M:initView()
	self._txtProductTitle.text = lang("tip_trading_lang_1")
	self._txtProductTime.text = lang("tip_trading_lang_2")
	self._txtUnlockRoomTitle.text = lang("tip_trading_lang_3")
	self._txtUnlockWorkerTitle.text = lang("tip_supervisor_lang_5")
end

function M:onExit()
	return
end

function M:onExitFinished()
	self:setEvent(false)
end

function M:updateData()
	local mo = TradingModel.instance:getTradePostMo()

	self._txtDeviceLevel.text = string.format("Lv.%d", mo:getLevel())

	local co = TradingConfig.instance:getHouseCoByLevel(mo:getLevel())

	self._txtDeviceDesc.text = co.desc
	self._txtDeviceName.text = lang("tip_trading_post")

	local surplus = TradingConfig.instance:getConstCoByKey("OrderProductivity").numValue

	self._txtProductivityAdd1.text = mo:getEnterHeroAdd()

	local add1GO = self._txtProductivityAdd1.gameObject.transform.parent.gameObject

	goutil.setActive(add1GO, mo:getHeroAdd() ~= 0)

	local productHouseRatio = MathUtil.preciseDecimal(TradingModel.instance:getProductHouseRatio(), 0)
	local productHouseRatioStr = productHouseRatio > 0 and string.format("%s%%", productHouseRatio) or ""

	self._txtProductivityAdd2.text = productHouseRatioStr

	local add2GO = self._txtProductivityAdd2.gameObject.transform.parent.gameObject

	goutil.setActive(add2GO, productHouseRatio > 0)

	self._txtProductivity.text = TextFormatter.formatExpireTime(surplus / mo:getSpeed() * 60)
	self._txtMoodValue.text = MathUtil.preciseDecimal(SupervisorModel.instance:getTotalMoodCost() * 60, 1)
	self._txtMoodValueAdd.text = "+0%"

	local moodAddGO = self._txtMoodValueAdd.gameObject.transform.parent.gameObject

	goutil.setActive(moodAddGO, false)

	local unlockOrderLevel = mo:getUnlockOrderLevel() or 1

	for k, v in ipairs(self._goUnlockOrders) do
		goutil.setActive(v, true)

		local data = {}

		data.idx = k
		data.isNone = unlockOrderLevel < k

		self._itemWorkshop[k]:updateData(data)
	end

	local unlockJobCount = SupervisorModel.instance:getJobCount()
	local jobCodeList = HouseEnum.WorkType2JobCodeList[HouseEnum.WorkType.Trading]

	for idx, workerItem in ipairs(self._arrayUnlockWorkerItem) do
		local unlock = idx <= unlockJobCount
		local jobCode = jobCodeList[idx]
		local cfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseWorker, jobCode)

		workerItem:setLock(not unlock)
		workerItem:setName(cfg.jobName)
		workerItem:setIcon(IconType.HouseCompile, cfg.icon)
	end

	local nextCo = TradingConfig.instance:getHouseCoByLevel(mo:getLevel() + 1)

	goutil.setActive(self._btnUpgrade.gameObject, nextCo ~= nil)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.TRADING_POST_INFO, self._onTradingPostInfoUpdate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.TRADING_POST_INFO, self._onTradingPostInfoUpdate, self)
	end
end

function M:_onClickUpgrade()
	local currLv = SupervisorModel.instance:getSupervisorLv()
	local cfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, currLv)

	if cfg then
		local muduleLevel = cfg.muduleLevel
		local mo = TradingModel.instance:getTradePostMo()
		local level = mo:getLevel()

		if muduleLevel <= level then
			FloatWordMgr.instance:show(lang("tip_trading_lang_4"))

			return
		end
	else
		FloatWordMgr.instance:show(lang("tip_trading_lang_5"))

		return
	end

	ViewMgr.instance:open(ViewName.TradingDeviceUpgrade)
end

function M:_onTradingPostInfoUpdate(sender, postInfoMo)
	self:updateData()
end

return M
