-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityGiftCell.lua

local WelfareBase = require("UI/Welfare/WelfarePanelBase")
local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")
local EventConst = require("EventConst")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResRandClient = require("ClientData/ResRandClient")
local ResColor = require("ClientData/ResColor")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local strClassName = "ActivityGiftCell"
local ActivityGiftCell = Class(strClassName, UIControls.Child)
local CURRENCY = {
	[1] = "IconRMB"
}

function ActivityGiftCell:ctor()
	self.bg = UIControls.Image(self, "ContentPanel/Bg")
	self.bg1 = UIControls.Image(self, "ContentPanel/Bg1")
	self.content = UIControls.Panel(self, "")
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onBtnClick)

	self.efx = UIControls.Panel(self, "ContentPanel/Efx")
	self.icon = UIControls.Image(self, "ContentPanel/Icon")
	self.iconNew = UIControls.Image(self, "ContentPanel/IconNew")
	self.iconNewRed = UIControls.Image(self, "ContentPanel/IconFree/IconNew")
	self.TextName = UIControls.Label(self, "ContentPanel/TextName")
	self.TextLimit = UIControls.Label(self, "ContentPanel/TextLimit")
	self.pricePanel = UIControls.Panel(self, "ContentPanel/PricePanel")
	self.currency = UIControls.Image(self, "ContentPanel/PricePanel/IconCurrency")
	self.curPrice = UIControls.Label(self, "ContentPanel/PricePanel/TextPrice")
	self.imgSoldOut = UIControls.Image(self, "ContentPanel/ImgSoldOut")
	self.imgFree = UIControls.Image(self, "ContentPanel/IconFree")
	self.items = {}
	self.isNewGift = false
	self.iconSp = UIControls.Image(self, "ContentPanel/IconSp")
	self.discountPanel = UIControls.Panel(self, "ContentPanel/DiscountPanel")
	self.IconCurrency = UIControls.Image(self, "ContentPanel/DiscountPanel/IconCurrency")
	self.discountPrice = UIControls.Label(self, "ContentPanel/DiscountPanel/TextPrice")
	self.currencyNum = UIControls.Label(self, "ContentPanel/DiscountPanel/ImgDiscount/TextDiscount")
	self.premiumPanel = UIControls.Panel(self, "ContentPanel/DiscountPanel2")
	self.premiumDot = UIControls.Label(self, "ContentPanel/DiscountPanel2/TextPrice")

	if UIControls.checkControlFunc(self, "ContentPanel/StoreGiftLockPanel") then
		self.panelLockPanel = UIControls.Panel(self, "ContentPanel/StoreGiftLockPanel")
		self.labelLock = UIControls.Label(self, "ContentPanel/StoreGiftLockPanel/Text")
	end

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "ContentPanel/PricePanel/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "ContentPanel/PricePanel/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function ActivityGiftCell:initData(data, svrData)
	self.actObj = self.mParent.actObj
	self.lastFloor = 1
	self.svrData = svrData

	if data[2] then
		if data[2].bg_path then
			self.bg:setImage("Atlas/" .. data[2].bg_path, data[2].bg_icon)
		end

		if data[2].bg2_path then
			self.bg1:setImage("Atlas/" .. data[2].bg2_path, data[2].bg2_icon)
		end
	end

	for i, item in ipairs(self.items) do
		item:destroy()
	end

	self.items = {}

	self:setData(data[1])
end

function ActivityGiftCell:setData(data)
	self.rechargeId = data.rechargeId

	local count = self.actObj.actData:getHasBuyNum(data.rechargeId)

	self.buyTimesLeft = data.buyTimesMax - count
	self.isSoldOut = false

	if self.buyTimesLeft == 0 then
		self.isSoldOut = true

		if data.nestedId then
			local product = RechargeManager.getProductByRechargeId(data.nestedId)

			if not product then
				return
			end

			local nestCount = 0

			if self.svrData and self.svrData[product.rechargeId] and self.svrData[product.rechargeId].count then
				nestCount = self.svrData[product.rechargeId].count
			end

			self.lastFloor = self.lastFloor + 1

			self:setData(product, nestCount)

			return
		end

		self.isNewGift = false

		self.content:setObjGray(true)
		self.imgSoldOut:setVisible(true)
		self.efx:setVisible(false)
		self.btn:setEnable(false)
	else
		self.isSoldOut = false

		self.content:setObjGray(false)
		self.imgSoldOut:setVisible(false)
		self.efx:setVisible(true)
		self.btn:setEnable(true)

		if self.panelLockPanel then
			local isLocked, lockDesc

			if not data:checkOpenLimit() then
				isLocked = true
				lockDesc = data.openLimitDes
			else
				isLocked, lockDesc = self.actObj.actData:isProductLocked(self.rechargeId)
			end

			self.panelLockPanel:setVisible(isLocked)

			if isLocked then
				self.btn:setEnable(false)
				self.labelLock:setText(lockDesc or "")
			end
		end
	end

	self.data = data

	if self.isNewGift == false then
		if self.floor and self.floor ~= self.lastFloor and self.lastFloor ~= 1 then
			self.isNewGift = true
		else
			self.isNewGift = false
		end
	end

	self.iconNew:setVisible(self.isNewGift)

	if self.data.price == 0 then
		self.imgFree:setVisible(true)
		self.pricePanel:setVisible(false)
		self.iconNewRed:setVisible(self.buyTimesLeft ~= 0)
	else
		self.imgFree:setVisible(false)
		self.pricePanel:setVisible(true)
	end

	self.floor = self.lastFloor

	if data.iconPath and data.iconName then
		self.icon:setImage("Atlas/" .. data.iconPath, data.iconName)
	else
		self.icon:setVisible(false)
	end

	self.currency:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", CURRENCY[1])
	self.IconCurrency:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", CURRENCY[1])
	self.TextName:setText(data.productName)
	self.curPrice:setText(data.priceText)
	self.TextLimit:setText(string.format(Lang.get(30537), self.buyTimesLeft))
	self:_setItems(data)

	if data.hotIconPath then
		self.iconSp:setImage("Atlas/" .. data.hotIconPath, data.hotIconName)
		self.iconSp:setVisible(true)
	else
		self.iconSp:setVisible(false)
	end

	if data.rateType == 1 then
		self.discountPanel:setVisible(true)
		self.premiumPanel:setVisible(false)
		self.discountPrice:setText(data.originalPrice)
		self.currencyNum:setText(data.rate10)
	elseif data.rateType == 2 then
		self.discountPanel:setVisible(false)
		self.premiumPanel:setVisible(true)
		self.premiumDot:setText(data.rate10 .. "%")
	else
		self.discountPanel:setVisible(false)
		self.premiumPanel:setVisible(false)
	end
end

function ActivityGiftCell:_setItems(data)
	local awardData = ResRandClient[data.randId]
	local show_flag = awardData.show_flag or {}
	local itemIndex = 1

	for idx, id in ipairs(awardData.show_ids) do
		if id ~= Const.MONEY_ID_VIP_POINT and itemIndex <= 3 then
			local item = BaseObject.GetObject(id, awardData.show_nums[idx])
			local itemGrid = UIControls.getGridAwardContainer(self, "ContentPanel/AwardPanel")

			itemGrid:setVisible(true)

			itemGrid.mDisableWays = true

			itemGrid:setObj(item)

			itemGrid.grid.isShowPreviewTips = true

			if show_flag[idx] and show_flag[idx] >= 1 then
				itemGrid:setSpe(true, 3, show_flag[idx])
			else
				itemGrid:setSpe(false)
			end

			itemGrid:setIconGray(self.isSoldOut)
			table.insert(self.items, itemGrid)

			if RegionUtils.isJP() then
				itemGrid:checkGiftFree(ClientUtils.CheckRandomHasDiamond(awardData.show_ids))
			end

			itemIndex = itemIndex + 1
		end
	end
end

function ActivityGiftCell:onBtnClick()
	if self.mEventClick then
		self.isNewGift = false

		self.mEventClick(self)
	end
end

return ActivityGiftCell
