-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMonthCardGiftPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResCardClient = require("ClientData/ResCardClient")
local classNameStr = "ActivityMonthCardGiftPage"
local ActivityMonthCardGiftPage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityMonthCardGiftPage, ActivityPanelMixin)

function ActivityMonthCardGiftPage:initUI()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.panelState = UIControls.Panel(self, "ImgState")
	self.btnConfirm = UIControls.Button(self, "BtnFunc", "TextPrice")

	self.btnConfirm:addEventClick(self._onClickConfirm)

	self.awardItems = {}

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "BtnFunc/TextPrice/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "BtnFunc/TextPrice/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function ActivityMonthCardGiftPage:_setData()
	local allProduct = self.actObj.actData:getAllProduct()

	if allProduct[1] then
		self.product = allProduct[1][1]

		local buyTimesLeft = self.product.buyTimesMax - self.actObj.actData:getHasBuyNum(self.product.rechargeId)

		if buyTimesLeft > 0 then
			self.btnConfirm:setText(self.product.priceText)
			self.btnConfirm:setVisible(true)
			self.panelState:setVisible(false)
		else
			self.btnConfirm:setVisible(false)
			self.panelState:setVisible(true)
		end
	end
end

function ActivityMonthCardGiftPage:onActivityDataRefresh()
	self:_setData()
end

function ActivityMonthCardGiftPage:_onClickConfirm()
	if self.product then
		self.cardData = nil

		for index, cardData in pairs(ResCardClient) do
			for _, rId in ipairs(cardData.recharge_id or {}) do
				if rId == self.product.rechargeId then
					self.cardData = cardData

					break
				end
			end

			if self.cardData then
				break
			end
		end

		local ui = UIManager.getUI("giftBuyBox")

		ui:showMonthCardItem(self.product, self, nil, nil, self.actObj, self.cardData)
		ui:bindWindow(self.mWindow)
		ui:setVisible(true)
	end
end

return ActivityMonthCardGiftPage
