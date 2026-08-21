-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivitDoubleGiftPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local RechargeManager = require("System/Recharge/RechargeManager")
local DoubleGiftCell = Class("DoubleGiftCell", UIControls.Panel)

function DoubleGiftCell:ctor()
	self.btn = UIControls.Button(self, self.mPath .. "")

	self.btn:addEventClick(self.onClick)

	self.nmlPanel = UIControls.Panel(self, self.mPath .. "/BuyNmlState")
	self.disPanel = UIControls.Panel(self, self.mPath .. "/BuyDisState")
	self.txtLimit = UIControls.Label(self, self.mPath .. "/BuyNmlState/TextLimitTitle")
	self.txtPrice = UIControls.Label(self, self.mPath .. "/BuyNmlState/BgPrice/TextPrice")

	if UIControls.checkControlFunc(self, self.mPath .. "/BuyNmlState/BgNum/TextNum") then
		self.txtNum = UIControls.Label(self, self.mPath .. "/BuyNmlState/BgNum/TextNum")
	end

	self.soldOut = false

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, self.mPath .. "/BuyNmlState/BgPrice/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, self.mPath .. "/BuyNmlState/BgPrice/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function DoubleGiftCell:setData(data, svrData)
	self.rechargeId = data.param[1]

	if not self.rechargeId then
		return
	end

	local product = RechargeManager.getProductByRechargeId(data.param[1])

	if not product then
		return
	end

	self.product = product

	local buyTimesLeft = product.buyTimesMax - svrData.count

	if buyTimesLeft == 0 then
		self.soldOut = true
	else
		self.soldOut = false
	end

	self.product.buyTimesLeft = buyTimesLeft

	self.txtLimit:setText(string.format(Lang.get(30595), buyTimesLeft))
	self.txtPrice:setText(product.priceText)
	self.txtLimit:setVisible(not self.soldOut)
	self.nmlPanel:setVisible(not self.soldOut)
	self.disPanel:setVisible(self.soldOut)

	if self.txtNum then
		if self.product.rateType == 2 then
			self.txtNum:setText(self.product.rate10 .. "%")
			self.txtNum:setVisible(true)
		else
			self.txtNum:setVisible(false)
		end
	end
end

function DoubleGiftCell:onClick()
	if self.mEventClick then
		self:mEventClick()
	end
end

local strClassName = "ActivitDoubleGiftPage"
local ActivitDoubleGiftPage = Class(strClassName, UIControls.Child)

MixinClass(ActivitDoubleGiftPage, ActivityPanelMixin)

function ActivitDoubleGiftPage:initUI()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.cells = {}
	self.clientData = {}
end

function ActivitDoubleGiftPage:_onShow()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_ACT, self.clientTemplateData.template_id)
end

function ActivitDoubleGiftPage:_setData()
	self.clientData = {}

	local detailData = self.actObj.actData.clientData
	local svrData = self.actObj.actData.serverData

	for idx, dDate in pairs(detailData) do
		self.clientData[#self.clientData + 1] = dDate
	end

	table.sort(self.clientData, function(a, b)
		local productA = RechargeManager.getProductByRechargeId(a.param[1])
		local productB = RechargeManager.getProductByRechargeId(b.param[1])

		if productA and productB then
			return productA.price > productB.price
		end

		return false
	end)
	self:_setCells(detailData, svrData)
end

function ActivitDoubleGiftPage:_setCells(detailData, svrData)
	for i = #self.cells + 1, #self.clientData do
		self.cells[i] = DoubleGiftCell(self, "GiftPanel/BtnGift" .. i)
		self.cells[i].mEventClick = Slot(self.onCellClick, self)
	end

	for i = 1, #self.clientData do
		local data = self.clientData[i]
		local sData = svrData[data.param[1]] or {
			count = 0
		}

		if sData then
			self.cells[i]:setData(data, sData)
		end
	end
end

function ActivitDoubleGiftPage:onCellClick(sender)
	if sender.soldOut == true then
		MsgManager.notice(Lang.get(30596))
	else
		if not sender.product then
			return
		end

		local ui = UIManager.getUI("giftBuyBox")

		ui:showShopItem(sender.product, self, nil, sender.rechargeId, self.actObj)
		ui:bindWindow(self)

		if sender.product.price == 0 then
			ui:onItemBuy()
		else
			ui:setVisible(true)
		end
	end
end

function ActivitDoubleGiftPage:onActivityDataRefresh(actObj)
	self:_setData()
end

return ActivitDoubleGiftPage
