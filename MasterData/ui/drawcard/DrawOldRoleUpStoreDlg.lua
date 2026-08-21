-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawOldRoleUpStoreDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local DrawRoleUpGiftCell = Class("DrawRoleUpGiftCell", UIControls.Panel)

function DrawRoleUpGiftCell:ctor()
	self.btnSensor = UIControls.Button(self, self.mPath)

	self.btnSensor:addEventClick(self.onSensorClick)

	self.panelNml = UIControls.Panel(self, self.mPath .. "/BuyNmlState")

	if UIControls.checkControlFunc(self, self.mPath .. "/BuyNmlState/BgStock/TextStock") then
		self.txtStock = UIControls.Label(self, self.mPath .. "/BuyNmlState/BgStock/TextStock")
	end

	self.panelDis = UIControls.Panel(self, self.mPath .. "/BuyDisState")
	self.textPrice = UIControls.Label(self, self.mPath .. "/BuyNmlState/BgPrice/TextPrice")

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, self.mPath .. "/BuyNmlState/BgPrice/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, self.mPath .. "/BuyNmlState/BgPrice/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function DrawRoleUpGiftCell:setData(product, giftActObj)
	self.product = product

	local count = giftActObj.actData:getHasBuyNum(product.rechargeId)

	self.giftActObj = giftActObj
	self.buyTimesLeft = product.buyTimesMax - count

	self.panelNml:setVisible(self.buyTimesLeft > 0)
	self.panelDis:setVisible(self.buyTimesLeft <= 0)
	self.btnSensor:setEnable(self.buyTimesLeft > 0)
	self.textPrice:setText(self.product.price)

	if self.txtStock then
		self.txtStock:setText(string.format("%d", self.buyTimesLeft))
	end
end

function DrawRoleUpGiftCell:onSensorClick()
	if self.buyTimesLeft > 0 then
		local ui = UIManager.getUI("giftBuyBox")

		ui:showShopItem(self.product, self, nil, nil, self.giftActObj)
		ui:bindWindow(self.mWindow)
		ui:setVisible(true)
	end
end

local strClassName = "DrawOldRoleUpStoreDlg"
local DrawOldRoleUpStoreDlg = Class(strClassName, UIControls.Window)

MixinClass(DrawOldRoleUpStoreDlg, ActivityPanelMixin)

function DrawOldRoleUpStoreDlg:initUI()
	self.closeBtn = UIControls.Button(self, "BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.giftCells = {}

	for index = 1, 4 do
		if UIControls.checkControlFunc(self, "BgPanel/GiftPanel/BtnGift" .. index) then
			local newCell = DrawRoleUpGiftCell(self, "BgPanel/GiftPanel/BtnGift" .. index)

			table.insert(self.giftCells, newCell)
		end
	end

	if UIControls.checkControlFunc(self, "BgPanel/GiftPanel/TextTime") then
		self.textRefreshTime = UIControls.Label(self, "BgPanel/GiftPanel/TextTime")
	end
end

function DrawOldRoleUpStoreDlg:_setData()
	self.actId = self.actObj.actId
	self.actData = self.actObj.actData

	for aType, aData in pairs(self.actData.clientData or {}) do
		self.achieveType = aType

		break
	end

	if not self.achieveType then
		return
	end

	local allProducts = self.actData:getAllProduct() or {}

	for index, cell in ipairs(self.giftCells) do
		if allProducts[index] then
			cell:setVisible(true)
			cell:setData(allProducts[index][1], self.actObj)
		else
			cell:setVisible(false)
		end
	end

	if self.textRefreshTime then
		local leftSecond = ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime()
		local slotOfTimerBeat = Slot(self._setData, self)

		ClientTimerManager.AddSecondFormatTickUI(self.textRefreshTime, leftSecond, false, Lang.get(48670), slotOfTimerBeat)
	end
end

function DrawOldRoleUpStoreDlg:updateActivityData()
	self:_setData()
end

function DrawOldRoleUpStoreDlg:_onClickClose()
	self:setVisible(false)
end

return DrawOldRoleUpStoreDlg
