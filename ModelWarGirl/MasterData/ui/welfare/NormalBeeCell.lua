-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\NormalBeeCell.lua

local ResRandClient = require("ClientData/ResRandClient")
local RechargeManager = require("System/Recharge/RechargeManager")
local NormalBeeCell = Class("NormalBeeCell", UIControls.ScrollViewLoopCell)
local CURRENCY = {
	[1] = "IconRMB"
}

function NormalBeeCell:ctor()
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onBtnClick)

	self.content = UIControls.Panel(self, "")
	self.efx = UIControls.Panel(self, "ContentPanel/Efx")
	self.icon = UIControls.Image(self, "ContentPanel/Icon")
	self.iconSp = UIControls.Image(self, "ContentPanel/IconSp")
	self.iconNew = UIControls.Image(self, "ContentPanel/IconNew")
	self.TextName = UIControls.Label(self, "ContentPanel/TextName")
	self.TextLimit = UIControls.Label(self, "ContentPanel/TextLimit")
	self.currency = UIControls.Image(self, "ContentPanel/PricePanel/IconCurrency")
	self.curPrice = UIControls.Label(self, "ContentPanel/PricePanel/TextPrice")
	self.iconFree = UIControls.Image(self, "ContentPanel/IconFree")
	self.iconNewRedDot = UIControls.Image(self, "ContentPanel/IconFree/IconNew")
	self.discountPanel = UIControls.Panel(self, "ContentPanel/DiscountPanel")
	self.IconCurrency = UIControls.Image(self, "ContentPanel/DiscountPanel/IconCurrency")
	self.discountPrice = UIControls.Label(self, "ContentPanel/DiscountPanel/TextPrice")
	self.currencyNum = UIControls.Label(self, "ContentPanel/DiscountPanel/ImgDiscount/TextDiscount")
	self.premiumPanel = UIControls.Panel(self, "ContentPanel/DiscountPanel2")
	self.premiumDot = UIControls.Label(self, "ContentPanel/DiscountPanel2/TextPrice")
	self.imgSoldOut = UIControls.Image(self, "ContentPanel/ImgSoldOut")
	self.txtSoldOut = UIControls.Label(self, "ContentPanel/ImgSoldOut/Text")

	if UIControls.checkControlFunc(self, "ContentPanel/StoreGiftLockPanel") then
		self.panelLockPanel = UIControls.Panel(self, "ContentPanel/StoreGiftLockPanel")
		self.labelLock = UIControls.Label(self, "ContentPanel/StoreGiftLockPanel/Text")
	end

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "ContentPanel/PricePanel/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "ContentPanel/PricePanel/TextPt")

		self.priceDmmPanel:setVisible(true)
	end

	if UIControls.checkControlFunc(self, "ContentPanel/IconGroupon") then
		self.iconGroupon = UIControls.Image(self, "ContentPanel/IconGroupon")
	end

	self.grids = {}
end

function NormalBeeCell:setData(data, preNestedId, actObj, pageType)
	self.actObj = actObj

	local newProductId, passedDict = RechargeManager.getNestedId(data.rechargeId)

	data = RechargeManager.getProductByRechargeId(newProductId)
	self.productData = data

	self.btn:setVisible(true)
	self.icon:setImage("Atlas/" .. data.iconPath, data.iconName)
	self.currency:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", CURRENCY[1])
	self.IconCurrency:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", CURRENCY[1])
	self.TextName:setText(data.productName)

	local getLeftTimes = self.productData:getGetLeftTimes()

	if getLeftTimes > 0 then
		self.TextLimit:setText(string.format(Lang.get(103888), getLeftTimes))
	elseif pageType == Const.WELFARETYPE_DAYBEE then
		self.TextLimit:setText(string.format(Lang.get(30777), data.buyTimesLeft))
	elseif pageType == Const.WELFARETYPE_WEEKBEE then
		self.TextLimit:setText(string.format(Lang.get(30778), data.buyTimesLeft))
	elseif pageType == Const.WELFARETYPE_MONTHBEE then
		self.TextLimit:setText(string.format(Lang.get(30779), data.buyTimesLeft))
	else
		self.TextLimit:setText(string.format(Lang.get(30537), data.buyTimesLeft))
	end

	if data.hotIconName then
		self.iconSp:setImage("Atlas/" .. data.hotIconPath, data.hotIconName)
		self.iconSp:setVisible(true)
	else
		self.iconSp:setVisible(false)
	end

	if preNestedId and passedDict[preNestedId] then
		self.iconSp:setVisible(false)
		self.iconNew:setVisible(true)
	else
		self.iconNew:setVisible(false)
	end

	local awardData = ResRandClient[data.randId] or {}
	local show_flag = awardData.show_flag or {}
	local itemIndex = 1

	for index, cell in ipairs(self.grids) do
		cell:setVisible(false)
	end

	for idx, id in ipairs(awardData.show_ids or {}) do
		if id ~= Const.MONEY_ID_VIP_POINT and itemIndex <= 3 then
			local item = BaseObject.GetObject(id, awardData.show_nums[idx])

			if not self.grids[itemIndex] then
				self.grids[itemIndex] = UIControls.getGridAwardContainer(self, "ContentPanel/AwardPanel")
			end

			self.grids[itemIndex]:setVisible(true)

			self.grids[itemIndex].mDisableWays = true

			self.grids[itemIndex]:setObj(item)

			self.grids[itemIndex].grid.isShowPreviewTips = true

			if show_flag[idx] and show_flag[idx] >= 1 then
				self.grids[itemIndex]:setSpe(true, 3, show_flag[idx])
			else
				self.grids[itemIndex]:setSpe(false)
			end

			if RegionUtils.isJP() then
				self.grids[itemIndex]:checkGiftFree(ClientUtils.CheckRandomHasDiamond(awardData.show_ids))
			end

			itemIndex = itemIndex + 1
		end
	end

	if data.priceText == 0 or getLeftTimes > 0 then
		self.iconFree:setVisible(true)
		self.curPrice:setVisible(false)
	else
		self.iconFree:setVisible(false)
		self.curPrice:setText(data.priceText)
		self.curPrice:setVisible(true)
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

	local soldOutText = Lang.get(44)

	if self.productData.mulityLinkId then
		local multiProduct = RechargeManager.getProductByRechargeId(self.productData.mulityLinkId)

		if multiProduct and multiProduct.buyTimesLeft == 0 then
			soldOutText = Lang.get(30780)
		end
	end

	self.txtSoldOut:setText(soldOutText)

	if data.buyTimesLeft == 0 then
		self.content:setObjGray(true)
		self.imgSoldOut:setVisible(true)
		self.efx:setVisible(false)
		self.btn:setEnable(false)
		self.iconNewRedDot:setVisible(false)
	else
		self.content:setObjGray(false)
		self.imgSoldOut:setVisible(false)
		self.efx:setVisible(true)
		self.btn:setEnable(true)

		if data.mulityLinkNoNew == 1 then
			self.iconNewRedDot:setVisible(false)
		else
			self.iconNewRedDot:setVisible(true)
		end

		if self.panelLockPanel then
			local isLocked, lockDesc

			if not data:checkOpenLimit() then
				isLocked = true
				lockDesc = data.openLimitDes
			end

			self.panelLockPanel:setVisible(isLocked)

			if isLocked then
				self.btn:setEnable(false)
				self.labelLock:setText(lockDesc or "")
			end
		end
	end

	if self.iconGroupon then
		local giftDrawData = CurAvatar:checkShowActGiftDrawIcon(data)

		if giftDrawData and giftDrawData.gear_icon_path then
			self.iconGroupon:setImage(giftDrawData.gear_icon_path, giftDrawData.gear_icon)
			self.iconGroupon:setVisible(true)
		else
			self.iconGroupon:setVisible(false)
		end
	end
end

function NormalBeeCell:onBtnClick()
	if self.mEventClick then
		self.mEventClick(self.productData, self.actObj)
	end
end

return NormalBeeCell
