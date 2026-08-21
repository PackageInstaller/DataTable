-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/cell/AirWorkShopStoreItemCell.lua

module("logic.extensions.airworkshop.cell.AirWorkShopStoreItemCell", package.seeall)

local M = class("AirWorkShopStoreItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._btnBuyClick = UIComponentType.ButtonAdapter(registry:findUIElement("air_workshop_store_item_-465412311"))
	self._imgIcon = registry:findUIElement("air_workshop_store_item_-1248927276", UIComponentType.Image)
	self._imgQuality = registry:findUIElement("air_workshop_store_item_-1284385419", UIComponentType.Image)
	self._goLimit = registry:findUIElement("air_workshop_store_item_-1496364313")
	self._txtLimit = registry:findUIElement("air_workshop_store_item_171758398", UIComponentType.Text)
	self._imgPriceIcon = registry:findUIElement("air_workshop_store_item_2071185456", UIComponentType.Image)
	self._txtPrice = registry:findUIElement("air_workshop_store_item_-446944082", UIComponentType.Text)
	self._txtOriginalPrice = registry:findUIElement("air_workshop_store_item_-622518017", UIComponentType.Text)
	self._goSellOut = registry:findUIElement("air_workshop_store_item_1366831857")
	self._goTime = registry:findUIElement("air_workshop_store_item_1069771316")
	self._txtTime = registry:findUIElement("air_workshop_store_item_-504036062", UIComponentType.Text)
	self._txtName = registry:findUIElement("air_workshop_store_item_-213271000", UIComponentType.Text)
	self._goDiscount = registry:findUIElement("air_workshop_store_item_802016290")
	self._txtDiscount = registry:findUIElement("air_workshop_store_item_607414715", UIComponentType.Text)
	self._goNewSign = goutil.findChild(mainGO, "new_sigh").gameObject
end

function M:destroyUI()
	self:setHandler(nil)

	if self._tweener then
		self._tweener:Kill(false)
	end

	removetimer(self._updateTimer, self)
	IconLoader.clearSprite(self._imgPriceIcon)
	IconLoader.clearSprite(self._imgIcon)
	IconLoader.clearSprite(self._imgQuality)
	self:setClickSelfFunc(nil, nil)

	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end
end

function M:bindEvents()
	self._btnBuyClick:AddClickListener(self._onClickBuy, self)
end

function M:unbindEvents()
	self._btnBuyClick:RemoveClickListener()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:setClickSelfFunc(func, handler)
	self._funcClickSelf = func
	self._funcClickSelfHandler = handler
end

function M:SetItemData(itemData, itemIndex)
	self._curIndex = itemIndex
	self._itemData = itemData
	self._goodsType = self._itemData:getGoodsType()
	self._hasSellOut = false
	self._hasSellOutToday = false

	self:_updateCellView()
end

function M:_onClickBuy()
	goutil.setActive(self._goNewSign, false)
	StoreModel.instance:setIsNeedShowNew({
		self._itemData
	})

	if self._hasSellOut or self._hasSellOutToday then
		FloatWordMgr.instance:show(lang("tip_store_item_has_sellout"))

		return
	end

	if self._funcClickSelf then
		if self._funcClickSelfHandler then
			self._funcClickSelf(self._funcClickSelfHandler, self._itemData)
		else
			self._funcClickSelf(self._itemData)
		end

		return
	end

	ViewMgr.instance:open(ViewName.StoreBuyConfirmView, self._itemData)
end

function M:_updateCellView()
	self:_setBuyLimity(self._itemData)
	self:_setIcon(self._itemData)
	self:_setQuality()
	self:_setGoodsName(self._itemData)
	self:_checkDiscountTick(self._itemData)
	self:_initCostInfo(self._itemData)
	self:_setIsNew()
end

function M:_setIsNew()
	local isNew = StoreModel.instance:getIsNeedShowNew(self._itemData)

	goutil.setActive(self._goNewSign, isNew and not self._hasSellOut)
end

function M:_setGoodsName(data)
	local useFirstItemName = string.nilorempty(data:getName())

	if not useFirstItemName then
		self._txtName.text = data:getName()
	end
end

function M:_setBuyLimity(data)
	local isLimit = self._itemData:getRemainedNum() > 0

	goutil.setActive(self._goLimit, isLimit)

	self._hasSellOut = false

	local remainedNum = data:getRemainedNum()

	if remainedNum >= 0 then
		local buyLimit = data:getBuyLimit()
		local hisBuyLimit = data:getHisBuyLimit()
		local dailyBuyLimit = data:getDailyBuyMaxNum()
		local limit = 0

		limit = StoreUtil.getMinLimit(limit, buyLimit)
		limit = StoreUtil.getMinLimit(limit, hisBuyLimit)
		limit = StoreUtil.getMinLimit(limit, dailyBuyLimit)
		self._txtLimit.text = langF("tip_store_limmit_show", remainedNum, limit)

		if data:getRemainedNum() == 0 then
			self._hasSellOut = true
			self._hasSellOutToday = true
		end
	end

	goutil.setActive(self._goSellOut, self._hasSellOut)
end

function M:_setIcon(data)
	local useFirstItemName = string.nilorempty(data:getName())
	local firstReward = data:getFirstReward()
	local useItemIcon = string.nilorempty(data:getIcon())
	local itemData = ItemUtil.createItemData({
		count = 0,
		itemId = firstReward.itemId
	})

	if not useItemIcon then
		IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, data:getIcon())
	elseif itemData then
		if useFirstItemName then
			self._txtName.text = itemData:getName()
		end

		if useItemIcon then
			IconLoader.setSpriteByItemType(self._imgIcon, itemData:getType(), itemData:getIcon())
		end
	end
end

function M:_setQuality()
	local quality = self._itemData:getQuality()
	local qualityUrl = CommEnum.Quality2AirStoreBg[quality]

	if self._qualityUrl ~= qualityUrl then
		self._qualityUrl = qualityUrl

		if qualityUrl then
			goutil.setActive(self._imgQuality.gameObject, true)
			IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_Store, qualityUrl)
		end
	end

	goutil.setActive(self._imgQuality.gameObject, qualityUrl ~= nil)
end

function M:_setPriceIcon(itemId)
	if itemId then
		MoneyUtil.setMoneyIcon(self._imgPriceIcon, itemId)
	end
end

function M:_initCostInfo(data)
	local itemId
	local isDiscount = not self._hasSellOut and data:getIsDiscount()

	if isDiscount then
		self._txtPrice.text = data:getDiscountPrice()
		self._txtOriginalPrice.text = data:getPrice()
		self._txtDiscount.text = StoreUtil.getDiscount(data:getDiscount())
		itemId = data:getDiscountedCostItemId()
	else
		self._txtPrice.text = data:getPrice()
		itemId = data:getCostItemId()
	end

	goutil.setActive(self._txtOriginalPrice.gameObject, isDiscount)
	goutil.setActive(self._goDiscount, isDiscount)
	self:_setPriceIcon(itemId)
end

function M:_checkDiscountTick(data)
	removetimer(self._updateTimer, self)

	self._remainingTime = data:getGoodEndRemainedSeconds()

	goutil.setActive(self._goTime, self._remainingTime > 0)

	if self._remainingTime > 0 then
		self._txtTime.text = data:getGoodsTimeStr()

		settimer(1, self._updateTimer, self, true)
	end
end

function M:_updateTimer()
	if self._remainingTime >= 0 then
		self._remainingTime = self._remainingTime - 1
		self._txtTime.text = self._itemData:getGoodsTimeStr()
	else
		self:_onRefreshGoods()
		goutil.setActive(self._goTime, false)
		removetimer(self._updateTimer, self)
	end
end

function M:_onRefreshGoods()
	GlobalDispatcher:dispatchEvent(EventType.STORE_STATE_CODE_ERROR)
end

return M
