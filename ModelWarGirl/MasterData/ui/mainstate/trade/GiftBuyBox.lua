-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\GiftBuyBox.lua

local ResColor = require("ClientData/ResColor")
local ResRandClient = require("ClientData/ResRandClient")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResClientNotice = require("ClientData/ResClientNotice")
local EventConst = require("EventConst")
local ResCardClient = require("ClientData/ResCardClient")
local ResRedPacketShow = require("ClientData/ResRedPacketShow")
local ResClientHardCode = require("ClientData/ResClientHardCode")
local DeviceHelper = require("Helper/DeviceHelper")
local VersionUtils = require("System/VersionUtils")
local MAX_BUY_COUNT = 9999
local LayoutElementType = typeof(UnityEngine.UI.LayoutElement)
local GiftCellChild = Class("GiftCellChild", UIControls.Child)

function GiftCellChild:ctor()
	self.imgBG = UIControls.Image(self, "ContentPanel/Icon")
	self.name = UIControls.Label(self, "ContentPanel/TextName")
	self.limit = UIControls.Label(self, "ContentPanel/TextLimit")
	self.Currency = UIControls.Image(self, "ContentPanel/PricePanel/IconCurrency")
	self.txtPrice = UIControls.Label(self, "ContentPanel/PricePanel/TextPrice")
	self.discountPanel = UIControls.Panel(self, "ContentPanel/DiscountPanel")
	self.IconCurrency = UIControls.Image(self, "ContentPanel/DiscountPanel/IconCurrency")
	self.discountPrice = UIControls.Label(self, "ContentPanel/DiscountPanel/TextPrice")
	self.currencyNum = UIControls.Label(self, "ContentPanel/DiscountPanel/ImgDiscount/TextDiscount")
	self.premiumPanel = UIControls.Panel(self, "ContentPanel/DiscountPanel2")
	self.premiumDot = UIControls.Label(self, "ContentPanel/DiscountPanel2/TextPrice")

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "ContentPanel/PricePanel/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "ContentPanel/PricePanel/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function GiftCellChild:setData(data)
	self.data = data

	if data.subIconPath and data.subIconName then
		self.imgBG:setImage("Atlas/" .. data.subIconPath, data.subIconName)
	end

	if data.rechargeId and data.productName then
		self.windowKeyInfo = data.rechargeId .. data.productName
	end

	self.Currency:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", "IconRMB")
	self.IconCurrency:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", "IconRMB")
	self.name:setText(data.productName)
	self.limit:setText(string.format(Lang.get(30537), data.buyTimesLeft))
	self.txtPrice:setText(data.priceText)

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

local strClassName = "GiftBuyBox"
local GiftBuyBox = Class(strClassName, UIControls.Window)

function GiftBuyBox:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBoxClose)

	self.btnBuy = UIControls.Button(self, "BgPanel/BtnConfirm", "Text")

	self.btnBuy:addEventClick(self.onBtnBuyClick)

	self.btnConfirmMulti = UIControls.Button(self, "BgPanel/BtnConfirmMulti", "Text")

	self.btnConfirmMulti:addEventClick(self.onBtnConfirmMultiClick)

	self.cellShop = GiftCellChild(self, "BgPanel/ItemPanel", "System/Common/Grid/GridStoreGiftCommon", 0, 0, true)
	self.btnRedMoney = UIControls.Button(self, "BgPanel/BtnRedMoney")
	self.imgRedMoney = UIControls.Image(self, "BgPanel/BtnRedMoney")

	self.btnRedMoney:addEventClick(self.onBtnRedMoneyClick)

	self.textLock = UIControls.Label(self, "BgPanel/UnlockText")
	self.imgMoney = UIControls.Image(self, "BgPanel/PricePanel/Icon")
	self.txtMoney = UIControls.ShortNumLabel(self, "BgPanel/PricePanel/TextNum")
	self.panelPriceMulti = UIControls.Panel(self, "BgPanel/PriceMultiPanel")
	self.imgMultiMoney = UIControls.Image(self, "BgPanel/PriceMultiPanel/Icon")
	self.txtMultiMoney = UIControls.ShortNumLabel(self, "BgPanel/PriceMultiPanel/TextNum")

	local panel = UIControls.Panel(self, "BgPanel/NumPanel")

	panel:setVisible(false)

	self.numPanel = UIControls.Panel(self, "BgPanel/NumFixPanel")

	self.numPanel:setVisible(true)

	self.txtBuyNum = UIControls.Label(self, "BgPanel/NumFixPanel/Text")

	self.txtBuyNum:setText(1)

	self.panelEmpty = UIControls.Panel(self, "BgPanel/EmptyPanel")
	self.panelContent = UIControls.Panel(self, "BgPanel/ContentPanel")
	self.labelTitle = UIControls.Label(self, "BgPanel/ContentPanel/TextTitle")
	self.labelContent = UIControls.Label(self, "BgPanel/ContentPanel/TextContent")

	self.labelContent:setVisible(false)

	self.awardPanel = UIControls.Panel(self, "BgPanel/ContentPanel/AwardPanel")

	self.awardPanel:setVisible(true)

	self.layoutAwardPreview = self.awardPanel:getComObj().transform:GetComponent(LayoutElementType)
	self._buyCount = 1
	self.timeOver = false
	self._slot4NewDay = Slot(self.onNewDay, self)
	self.titleCard = UIControls.Label(self, "BgPanel/ContentPanel/TextTitle1")
	self.panelAwardCard = UIControls.Panel(self, "BgPanel/ContentPanel/AwardPanel1")
	self.cardAwardGrids = {}

	if ChannelUtil.isDMMGame() then
		if UIControls.checkControlFunc(self, "BgPanel/PricePanel/TextPt") then
			self.priceDmmPanel = UIControls.Panel(self, "BgPanel/PricePanel/TextPt")

			self.priceDmmPanel:setVisible(true)
		end

		if UIControls.checkControlFunc(self, "BgPanel/PriceMultiPanel/TextPt") then
			self.priceDmmPanel2 = UIControls.Panel(self, "BgPanel/PriceMultiPanel/TextPt")

			self.priceDmmPanel2:setVisible(true)
		end
	end

	self._slot4OnItemBuy = nil
	self.txtPettyPayTips = UIControls.Label(self, "BgPanel/TextPettyPayTips")

	self.txtPettyPayTips:setVisible(false)

	self.txtNewcomerBpTips = UIControls.Label(self, "BgPanel/TextNewcomerBPTips")
end

function GiftBuyBox:onOpen()
	GiftBuyBox.super.onOpen(self)
	EventCenter.addEventListener(EventConst.NEW_DAY, self._slot4NewDay)
end

function GiftBuyBox:showMonthCardItem(item, orderUI, giftType, curCellID, actObj, cardData)
	self:showShopItem(item, orderUI, giftType, curCellID, actObj)
end

function GiftBuyBox:checkCardData()
	local monthCardId = self._curItem.monthCardId

	if monthCardId and ResCardClient[monthCardId] then
		local cardData = ResCardClient[monthCardId]

		self.titleCard:setVisible(true)
		self.titleCard:setText(cardData.day_title or "")
		self.panelAwardCard:setVisible(true)
		ClientUtils.CreateBonusGrid(self, self.cardAwardGrids, "BgPanel/ContentPanel/AwardPanel1/GridAwardPanel", cardData.award, true, nil, true)
	end
end

function GiftBuyBox:checkActState()
	local isLock = false
	local lockDes

	if self._curItem and self._curItem:checkLockLimit() then
		isLock = true
		lockDes = self._curItem.lockLimitDes
	elseif self.actObj and self._curItem then
		local actData = self.actObj.actData

		if actData and actData.isProductLocked then
			isLock, lockDes = actData:isProductLocked(self._curItem.rechargeId)
		end
	end

	self.btnBuy:setEnable(not isLock)
	self.textLock:setVisible(isLock)

	if isLock then
		self.textLock:setText(lockDes or "")
	end
end

function GiftBuyBox:showShopItem(item, orderUI, giftType, curCellID, actObj)
	self.timeOver = false

	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_OPEN_UI, item.rechargeId)

	self.giftType = giftType
	self.curCellID = curCellID
	self._curItem = item
	self.actObj = actObj

	self.cellShop:setData(item)
	self:_updateItem()
	self:_updateBuyNum(1)

	if self.giftType and Const.WELFARETYPE_NEWBEE_GROUP[self.giftType] then
		self.timeOver = nil
	end

	if orderUI and orderUI.mWindow then
		self:setOrder(orderUI.mWindow:getOrder() + 5)
	end

	self:checkCardData()
	self:checkActState()
end

function GiftBuyBox:_updateItem()
	if self._curItem == nil then
		return
	end

	if self.awardItems then
		for _, item in ipairs(self.awardItems) do
			item:destroy()
		end
	end

	self.awardItems = nil

	local data = self._curItem

	self.panelContent:setVisible(true)
	self.panelEmpty:setVisible(false)
	self.labelTitle:setText(Lang.get(1673))

	local awardData = ResRandClient[self._curItem.randId]
	local show_flag = awardData.show_flag or {}

	if not self.awardItems then
		self.awardItems = {}

		for idx, id in ipairs(awardData.show_ids) do
			local item = BaseObject.GetObject(id, awardData.show_nums[idx])
			local itemGrid = UIControls.getGridAwardContainer(self, "BgPanel/ContentPanel/AwardPanel/GridAwardPanel")

			itemGrid:setVisible(true)

			itemGrid.mDisableWays = true

			itemGrid:setObj(item)

			itemGrid.grid.isShowPreviewTips = true

			if show_flag[idx] and show_flag[idx] >= 1 then
				itemGrid:setSpe(true, 3, show_flag[idx])
			else
				itemGrid:setSpe(false)
			end

			table.insert(self.awardItems, itemGrid)

			if RegionUtils.isJP() then
				itemGrid:checkGiftFree(ClientUtils.CheckRandomHasDiamond(awardData.show_ids))
			end
		end

		self.layoutAwardPreview.preferredHeight = (math.floor((#self.awardItems - 1) / 6) + 1) * 108
	end

	self.imgMoney:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", "IconRMB")
	self.imgMoney:setObjColor(ResColor.BLACK)
	self.imgMultiMoney:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", "IconRMB")

	if not DeviceHelper.isIOS() and VersionUtils.hasAbilityDMMSuccession() then
		local succ, channel = ChannelUtil.doAnyFunction("getBytedanceChannel", {})

		if succ and channel == "dmm" then
			self.imgMultiMoney:setVisible(false)
			self.imgMoney:setVisible(false)
		end
	end

	self.imgMultiMoney:setObjColor(ResColor.BLACK)

	local redPackageObj = CurAvatar:getRedPackageActivity()

	if redPackageObj then
		self.btnRedMoney:setVisible(true)

		local redPacketShowType = ResClientHardCode[13].value[1]

		if redPacketShowType and redPacketShowType ~= 1 and ResRedPacketShow[redPacketShowType] then
			local imgPath = ResRedPacketShow[redPacketShowType].buytip_image_path
			local imgName = ResRedPacketShow[redPacketShowType].buytip_image_name

			self.imgRedMoney:setImage(imgPath, imgName)
		end
	else
		self.btnRedMoney:setVisible(false)
	end
end

function GiftBuyBox:_updateBuyNum(tgtCount)
	if self._curItem == nil then
		return
	end

	self._maxCount = self._curItem.buyTimesLeft
	self._minCount = 1
	self._buyCount = tgtCount
	self._totalMoney = self._curItem.priceText * self._buyCount

	self.txtMoney:setNum(self._totalMoney)
	self.txtMoney:setFontColor(ResColor.BLACK)

	if self._curItem.mulityLinkId then
		self.multiProduct = RechargeManager.getProductByRechargeId(self._curItem.mulityLinkId)
	end

	if self.multiProduct then
		self.btnConfirmMulti:setVisible(true)
		self.panelPriceMulti:setVisible(true)

		self._totalMultiMoney = self.multiProduct.priceText * self._buyCount

		self.txtMultiMoney:setNum(self._totalMultiMoney)
		self.txtMultiMoney:setFontColor(ResColor.BLACK)
		self.btnConfirmMulti:setText(string.format(Lang.get(30538), self.multiProduct.mulityAddCount or 0))
		self.btnBuy:setText(Lang.get(30539))
	else
		self.btnConfirmMulti:setVisible(false)
		self.panelPriceMulti:setVisible(false)
		self.btnBuy:setText(Lang.get(132))
	end
end

function GiftBuyBox:onBoxClose(sender)
	EventCenter.removeEventListener(EventConst.NEW_DAY, self._slot4NewDay)
	self:setVisible(false)
end

function GiftBuyBox:onNewDay()
	if self.timeOver ~= nil then
		self.timeOver = true
	end
end

function GiftBuyBox:itemBuyCb()
	RPC.shopExchange(self._curItem.shopID, self._curItem.id, self._buyCount, 0)
	self:setVisible(false)
end

local function _buyCb(_curItem)
	local item = {}

	item.type = Const.MONEY_TYPE_DIAMOND
	item.value = ResRandClient[_curItem.randId].show_nums[1]

	UIManager.getUI("commonBonusDlg", true):onShow("", {
		item
	}, {}, {}, {}, {}, {}, Lang.get(1714))
end

function GiftBuyBox:onBtnBuyClick(sender)
	if self._slot4OnItemBuy then
		self._slot4OnItemBuy(self)
	else
		self:onItemBuy(sender)
	end
end

function GiftBuyBox:onItemBuy(sender)
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, self._curItem.rechargeId)

	for index, itemGrid in ipairs(self.awardItems) do
		local obj = itemGrid.object

		if obj and obj:isSkin() then
			ClientUtils.tryBuySkinObj(obj, Slot(self.realBuy, self))

			return
		end
	end

	self:realBuy()
end

function GiftBuyBox:onBtnConfirmMultiClick()
	local function yesFunc()
		CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, self.multiProduct.rechargeId)

		for index, itemGrid in ipairs(self.awardItems) do
			local obj = itemGrid.object

			if obj and obj:isSkin() and obj:isGet() then
				UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), ResClientNotice[284].notice, Slot(self.realBuy, self))

				return
			elseif obj and obj:isSkin() and not obj:isHeroGet() then
				UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), ResClientNotice[280].notice, Slot(self.realBuy, self))

				return
			end
		end

		self:realBuy(self.multiProduct.rechargeId)
	end

	local msgContent = Lang.get(31305)

	if ChannelUtil.isDMMGame() then
		msgContent = utils.replaceString(msgContent, Lang.get(78291), "pt")
	end

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc)
end

function GiftBuyBox:onBtnRedMoneyClick()
	local activityPrivilegePreviewDlg = UIManager.getUI("activityPrivilegePreviewDlg", true)
end

function GiftBuyBox:realBuy(rechargeId)
	local _rechargeId = rechargeId or self._curItem.rechargeId
	local rechargeArgs

	if self._curItem.special then
		rechargeArgs = {
			special = self._curItem.special
		}
	end

	if self.actObj then
		self.timeOver = false

		CurAvatar:activityRPC(Functor(RechargeManager.startRecharge, _rechargeId, rechargeArgs, nil), self.actObj.opId)
	elseif self.timeOver == true then
		MsgManager.notice(Lang.get(30540))

		self.timeOver = false
	else
		RechargeManager.startRecharge(_rechargeId, rechargeArgs, nil)
	end

	EventCenter.removeEventListener(EventConst.NEW_DAY, self._slot4NewDay)
	self:setVisible(false)
end

function GiftBuyBox:setNewcomerSpecialShow(...)
	self.txtNewcomerBpTips:setVisible(true)
	self.btnBuy:setEnable(false)
end

return GiftBuyBox
