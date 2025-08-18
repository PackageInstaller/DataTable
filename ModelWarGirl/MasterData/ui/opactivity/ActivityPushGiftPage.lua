-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityPushGiftPage.lua

local RechargeManager = require("System/Recharge/RechargeManager")
local ResPushGiftPkg = require("ClientData/ResPushGiftPkg")
local ResRandClient = require("ClientData/ResRandClient")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local EventConst = require("EventConst")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local className = "ActivityPushGiftPage"
local ActivityPushGiftPage = Class(className, UIControls.Child)

MixinClass(ActivityPushGiftPage, ActivityPanelMixin)

function ActivityPushGiftPage:ctor()
	self.items = {}
end

function ActivityPushGiftPage:initUI()
	self.txtPrice = UIControls.Label(self, "DiscountPanel/TextPrice")
	self.txtDescrib = UIControls.Label(self, "TextDes")
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.btnBuy = UIControls.Button(self, "BtnFunc", "TextPrice")
	self.panelSoldOut = UIControls.Panel(self, "ImgState")

	self.btnBuy:addEventClick(self.onBuy)

	self._slot4ProductLoaded = Slot(self.resetUI, self)

	EventCenter.addEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
end

function ActivityPushGiftPage:_setData()
	if self.actObj and self.actObj.fakeActKey then
		local pushData = CurAvatar:getPushGift()

		if pushData then
			self.data = pushData[self.actObj.fakeActKey]
		else
			return
		end
	else
		return
	end

	local product = RechargeManager.getProductByRechargeId(self.data.recharge_id)

	if not product then
		return
	end

	self.txtPrice:setText(700)
	self.txtDescrib:setText(ResPushGiftPkg[self.data.gift_id].describe)
	self.btnBuy:setText(product.priceText)

	local awardData = ResRandClient[product.randId]

	for _, item in ipairs(self.items) do
		item:setVisible(false)
	end

	for idx, id in ipairs(awardData.show_ids) do
		local item = BaseObject.GetObject(id, awardData.show_nums[idx])

		if not self.items[idx] then
			self.items[idx] = UIControls.getGridChild(item, self, "AwardPanel")
		end

		self.items[idx]:setVisible(true)

		self.items[idx].mDisableWays = true
		self.items[idx].isShowPreviewTips = true

		self.items[idx]:setObj(item)
	end
end

function ActivityPushGiftPage:resetUI()
	if not self:getVisible() then
		return
	end

	local product = RechargeManager.getProductByRechargeId(self.data.recharge_id)

	if not product then
		return
	end

	if product.buyTimesLeft == 0 then
		self.panelSoldOut:setVisible(true)
		self.btnBuy:setVisible(false)
	else
		self.panelSoldOut:setVisible(false)
		self.btnBuy:setVisible(true)
	end
end

function ActivityPushGiftPage:_onShow(isOnPageShow)
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_PUSH_GIFT, self.data.recharge_id)

	local vioceId = UIMiscConfig.VOCAL_ID_PUSH_GIFT

	if isOnPageShow == true then
		CueManager.playGroupVocal(vioceId)
	end
end

function ActivityPushGiftPage:onRefreshBanner()
	return
end

function ActivityPushGiftPage:onClose()
	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
	ActivityPushGiftPage.super.onClose(self)
end

function ActivityPushGiftPage:timeDownCB()
	self:setVisible(false)
end

function ActivityPushGiftPage:onBuy()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, self.data.recharge_id)

	local svrTime = ClientUtils.getServerTime()

	if svrTime <= self.data.endTime then
		RechargeManager.startRecharge(self.data.recharge_id, nil, nil)
	else
		MsgManager.notice(Lang.get(1870))
	end
end

function ActivityPushGiftPage:onDestroy(...)
	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
	ActivityPushGiftPage.super.onDestroy(self)
end

return ActivityPushGiftPage
