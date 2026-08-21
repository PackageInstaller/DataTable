-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfarePushGiftDlg.lua

local welfareBase = require("UI/Welfare/WelfarePanelBase")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResPushGiftPkg = require("ClientData/ResPushGiftPkg")
local ResRandClient = require("ClientData/ResRandClient")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local className = "WelfarePushGiftDlg"
local WelfarePushGiftDlg = Class(className, UIControls.Window)

function WelfarePushGiftDlg:ctor()
	self:initUI()

	self.items = {}
	self.hasSendOssLog = false
end

function WelfarePushGiftDlg:onOpen()
	local vioceId = UIMiscConfig.VOCAL_ID_PUSH_GIFT

	CueManager.playGroupVocal(vioceId)
	WelfarePushGiftDlg.super.onOpen(self)
end

function WelfarePushGiftDlg:initUI()
	self.txtPrice = UIControls.Label(self, "Bg/DiscountPanel/TextPrice")
	self.txtDescrib = UIControls.Label(self, "Bg/TextDes")
	self.txtTime = UIControls.Label(self, "Bg/TextTime")
	self.btnBuy = UIControls.Button(self, "Bg/BtnFunc", "TextPrice")
	self._slot4Buy = Slot(self.onBuy, self)

	self.btnBuy:addEventClick(self._slot4Buy)

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "Bg/BtnFunc/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "Bg/BtnFunc/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function WelfarePushGiftDlg:setData(data, closeCb)
	if not self.hasSendOssLog then
		CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_PUSH_GIFT, data.recharge_id)

		self.hasSendOssLog = true
	end

	self.data = data
	self._closeCb = closeCb

	local product = RechargeManager.getProductByRechargeId(data.recharge_id)

	if not product then
		return
	end

	self.txtPrice:setText(product.rate10)
	self.txtDescrib:setText(ResPushGiftPkg[data.gift_id].describe)

	local lastTime = self.data.endTime - ClientUtils.getServerTime()

	if lastTime > 86400 then
		self.txtTime:setText(string.format(Lang.get(30798), math.floor(lastTime / 86400)))
	else
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, lastTime, nil, Lang.get(48701), Slot(self.timeDownCB, self))
	end

	self.btnBuy:setText(product.priceText)

	local awardData = ResRandClient[product.randId]

	for _, item in ipairs(self.items) do
		item:setVisible(false)
	end

	for idx, id in ipairs(awardData.show_ids) do
		local item = BaseObject.GetObject(id, awardData.show_nums[idx])

		if not self.items[idx] then
			self.items[idx] = UIControls.getGridContainer(self, "Bg/AwardPanel")
		end

		self.items[idx]:setObj(item)
		self.items[idx]:setVisible(true)

		self.items[idx].grid.mDisableWays = true
		self.items[idx].grid.isShowPreviewTips = true
	end
end

function WelfarePushGiftDlg:onClose()
	if self._closeCb then
		self:_closeCb()
	end

	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	WelfarePushGiftDlg.super.onClose(self)
end

function WelfarePushGiftDlg:timeDownCB()
	self:setVisible(false)
end

function WelfarePushGiftDlg:onBuy()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, self.data.recharge_id)
	RechargeManager.startRecharge(self.data.recharge_id, nil, nil)
end

function WelfarePushGiftDlg:destroy(...)
	if self._closeCb then
		self:_closeCb()
	end

	WelfarePushGiftDlg.super.destroy(self)
end

return WelfarePushGiftDlg
