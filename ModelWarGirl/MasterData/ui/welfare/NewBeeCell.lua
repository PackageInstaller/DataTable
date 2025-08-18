-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\NewBeeCell.lua

local NewBeeCell = Class("NewBeeCell", UIControls.ScrollViewLoopCell)
local CURRENCY = {
	[1] = "IconRMB"
}

function NewBeeCell:ctor()
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onBtnClick)

	self.icon = UIControls.Image(self, "ContentPanel/Icon")
	self.iconSp = UIControls.Image(self, "ContentPanel/IconSp")
	self.TextName = UIControls.Label(self, "ContentPanel/TextName")
	self.TextLimit = UIControls.Label(self, "ContentPanel/TextLimit")
	self.Currency = UIControls.Image(self, "ContentPanel/PricePanel/IconCurrency")
	self.curPrice = UIControls.Label(self, "ContentPanel/PricePanel/TextPrice")
	self.discountPanel = UIControls.Panel(self, "ContentPanel/DiscountPanel")
	self.IconCurrency = UIControls.Image(self, "ContentPanel/DiscountPanel/IconCurrency")
	self.discountPrice = UIControls.Label(self, "ContentPanel/DiscountPanel/TextPrice")
	self.currencyNum = UIControls.Label(self, "ContentPanel/DiscountPanel/ImgDiscount/TextDiscount")
	self.premiumPanel = UIControls.Panel(self, "ContentPanel/DiscountPanel2")
	self.premiumDot = UIControls.Label(self, "ContentPanel/DiscountPanel2/TextPrice")
	self.imgSoldOut = UIControls.Image(self, "ContentPanel/ImgSoldOut")

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "ContentPanel/PricePanel/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "ContentPanel/PricePanel/TextPt")

		self.priceDmmPanel:setVisible(true)
	end

	if UIControls.checkControlFunc(self, "ContentPanel/IconGroupon") then
		self.iconGroupon = UIControls.Image(self, "ContentPanel/IconGroupon")
	end
end

function NewBeeCell:initData(data)
	return
end

function NewBeeCell:setData(data, preNestedId, actObj)
	self.actObj = actObj
	self.data = data

	self.icon:setImage("Atlas/" .. data.iconPath, data.iconName)
	self.Currency:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", CURRENCY[1])
	self.IconCurrency:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", CURRENCY[1])
	self.TextName:setText(data.productName)
	self.TextLimit:setText(string.format(Lang.get(30537), data.buyTimesLeft))
	self.curPrice:setText(data.priceText)

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

	if data.buyTimesLeft == 0 then
		self.imgSoldOut:setVisible(true)
		self.btn:setEnable(false)
	end

	if data.hotIconPath then
		self.iconSp:setImage("Atlas/" .. data.hotIconPath, data.hotIconName)
		self.iconSp:setVisible(true)
	else
		self.iconSp:setVisible(false)
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

function NewBeeCell:onBtnClick()
	if self.mEventClick then
		self.mEventClick(self.data, self.actObj)
	end
end

return NewBeeCell
