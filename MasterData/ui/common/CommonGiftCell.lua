-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\CommonGiftCell.lua

local RechargeManager = require("System/Recharge/RechargeManager")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "CommonGiftCell"
local CommonGiftCell = Class(strClassName, UIControls.Child)
local CURRENCY = {
	[1] = "IconRMB"
}

function CommonGiftCell:ctor()
	self.bg = UIControls.Image(self, "ContentPanel/Bg")
	self.bg1 = UIControls.Image(self, "ContentPanel/Bg1")
	self.content = UIControls.Panel(self, "")
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onBtnClick)

	self.efx = UIControls.Panel(self, "ContentPanel/Efx")
	self.icon = UIControls.Image(self, "ContentPanel/Icon")
	self.TextName = UIControls.Label(self, "ContentPanel/TextName")
	self.TextLimit = UIControls.Label(self, "ContentPanel/TextLimit")
	self.pricePanel = UIControls.Panel(self, "ContentPanel/PricePanel")
	self.currency = UIControls.Image(self, "ContentPanel/PricePanel/IconCurrency")
	self.curPrice = UIControls.Label(self, "ContentPanel/PricePanel/TextPrice")
	self.imgSoldOut = UIControls.Image(self, "ContentPanel/ImgSoldOut")
	self.imgFree = UIControls.Image(self, "ContentPanel/IconFree")
	self.items = {}
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

	if UIControls.checkControlFunc(self, "ContentPanel/IconGroupon") then
		self.iconGroupon = UIControls.Image(self, "ContentPanel/IconGroupon")
	end
end

function CommonGiftCell:setData(rechargeId, actId)
	self.rechargeId = rechargeId
	self.realShowRechargeId = rechargeId

	if CurAvatar and CurAvatar.rechargeReplaced[rechargeId] then
		local newRechargeInfo = CurAvatar.rechargeReplaced[rechargeId]

		if newRechargeInfo then
			local newRechargeId = newRechargeInfo[1]
			local actObj = newRechargeInfo[2]
			local newProduct = RechargeManager.getProductByRechargeId(newRechargeId)

			if newProduct and actObj and actObj:isValid() then
				self.realShowRechargeId = newRechargeId
				self.replaceProductAct = actObj
			end
		end
	end

	self.realShowRechargeId = RechargeManager.getNestedId(self.realShowRechargeId)
	self.product = RechargeManager.getProductByRechargeId(self.realShowRechargeId)

	if not self.product then
		return
	end

	self.buyTimesLeft = self.product.buyTimesLeft
	self.isSoldOut = false

	if self.buyTimesLeft == 0 then
		self.isSoldOut = true

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

			if not self.product:checkOpenLimit() then
				isLocked = true
				lockDesc = self.product.openLimitDes
			end

			self.panelLockPanel:setVisible(isLocked)

			if isLocked then
				self.btn:setEnable(false)
				self.labelLock:setText(lockDesc or "")
			end
		end
	end

	if self.product.price == 0 then
		self.imgFree:setVisible(true)
		self.pricePanel:setVisible(false)
	else
		self.imgFree:setVisible(false)
		self.pricePanel:setVisible(true)
	end

	if self.product.iconPath and self.product.iconName then
		self.icon:setImage("Atlas/" .. self.product.iconPath, self.product.iconName)
	else
		self.icon:setVisible(false)
	end

	self.currency:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", CURRENCY[1])
	self.IconCurrency:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", CURRENCY[1])
	self.TextName:setText(self.product.productName)
	self.curPrice:setText(self.product.priceText)
	self.TextLimit:setVisible(false)

	local awardData = ResRandClient[self.product.randId]
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

	if self.product.hotIconPath then
		self.iconSp:setImage("Atlas/" .. self.product.hotIconPath, self.product.hotIconName)
		self.iconSp:setVisible(true)
	else
		self.iconSp:setVisible(false)
	end

	if self.product.rateType == 1 then
		self.discountPanel:setVisible(true)
		self.premiumPanel:setVisible(false)
		self.discountPrice:setText(self.product.originalPrice)
		self.currencyNum:setText(self.product.rate10)
	elseif self.product.rateType == 2 then
		self.discountPanel:setVisible(false)
		self.premiumPanel:setVisible(true)
		self.premiumDot:setText(self.product.rate10 .. "%")
	else
		self.discountPanel:setVisible(false)
		self.premiumPanel:setVisible(false)
	end

	if self.iconGroupon then
		local giftDrawData = CurAvatar:checkShowActGiftDrawIcon(self.product)

		if giftDrawData and giftDrawData.gear_icon_path then
			self.iconGroupon:setImage(giftDrawData.gear_icon_path, giftDrawData.gear_icon)
			self.iconGroupon:setVisible(true)
		else
			self.iconGroupon:setVisible(false)
		end
	end
end

function CommonGiftCell:onBtnClick()
	if self.mEventClick then
		self.mEventClick(self)
	end
end

return CommonGiftCell
