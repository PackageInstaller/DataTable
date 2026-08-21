-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/giftbag/StoreGiftBagViewItem.lua

module("logic.extensions.store.view.giftbag.StoreGiftBagViewItem", package.seeall)

local M = class("StoreGiftBagViewItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self.id = UIDUtil.getEventUID()
	self._isNew = false
	self._animationName = "open"
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._btnBuyClick = ButtonAdapter.Get(registry:findUIElement("store_gift_bag_item_1086125666"))

	self._btnBuyClick:AddClickListener(self._clickSelf, self)

	self._btnMonthTips = ButtonAdapter.Get(registry:findUIElement("store_gift_bag_item_1840229449"))

	self._btnMonthTips:AddClickListener(self._clickMonthTips, self)

	self._imgIcon = registry:findUIElement("store_gift_bag_item_669265981", UIComponentType.Image)
	self._imgQuality = registry:findUIElement("store_gift_bag_item_-1745543655", UIComponentType.Image)
	self._goLimit = registry:findUIElement("store_gift_bag_item_-283041430")
	self._txtLimitName = registry:findUIElement("store_gift_bag_item_-283041430", UIComponentType.Text)
	self._txtLimitNum = registry:findUIElement("store_gift_bag_item_-2075056934", UIComponentType.Text)
	self._txtMonth = registry:findUIElement("store_gift_bag_item_1269119653", UIComponentType.Text)
	self._imgPriceIcon = registry:findUIElement("store_gift_bag_item_397149805", UIComponentType.Image)
	self._txtPrice = registry:findUIElement("store_gift_bag_item_1854719669", UIComponentType.Text)
	self._txtPriceMonth = registry:findUIElement("store_gift_bag_item_1234390978", UIComponentType.Text)
	self._txtFree = registry:findUIElement("store_gift_bag_item_1170544165", UIComponentType.Text)
	self._txtOriginalPrice = registry:findUIElement("store_gift_bag_item_1082753649", UIComponentType.Text)
	self._goNewSign = registry:findUIElement("0&new_sigh_291166182")
	self._goSellOut = registry:findUIElement("store_gift_bag_item_-1097804382")
	self._txtTime = registry:findUIElement("store_gift_bag_item_-613196543", UIComponentType.Text)
	self._goTime = registry:findUIElement("store_gift_bag_item_1891614501")
	self._txtName = registry:findUIElement("store_gift_bag_item_757782712", UIComponentType.Text)
	self._goDiscount = registry:findUIElement("store_gift_bag_item_-1058579984")
	self._txtDiscount = registry:findUIElement("store_gift_bag_item_-1711357054", UIComponentType.Text)
	self._goRedPoint = registry:findUIElement("1&red_point_-1414002736")
	self._goAnimation = registry:findUIElement("store_gift_bag_item_72503522")
	self._canvasGroupAnim = registry:findUIElement("store_gift_bag_item_72503522", ComponentType.CanvasGroup)
	self._guiAnimation = self._go:GetComponent(typeof(Astral.GUITimelineAniLua))
end

function M:OnEnable()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName(self._animationName)
	self._guiAnimation:JumpAniTimeToEnd(self._animationName)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.STORE_PLAY_ITEM_ANIMATION, self._playAnimation, self)
	else
		GlobalDispatcher:removeEventListener(EventType.STORE_PLAY_ITEM_ANIMATION, self._playAnimation, self)
	end
end

function M:_clickSelf()
	goutil.setActive(self._goNewSign, false)
	StoreModel.instance:setIsNeedShowNew({
		self._itemData
	})

	self._isNew = false

	self:_updateRedPoint()

	if self._hasSellOut then
		FloatWordMgr.instance:show(lang("tip_store_item_has_sellout"))

		return
	end

	if self._goodsType == StoreEnum.GoodsType.MonthlyCard and not StoreController.instance:isCanBuyMonthCard(self._itemData, true) then
		return
	end

	ViewMgr.instance:open(ViewName.StoreBuyConfirmView, self._itemData)
end

function M:_clickMonthTips()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		self._itemData:getExplainId()
	})
end

function M:SetItemData(itemData, itemIndex)
	self._canvasGroupAnim.alpha = 1

	if itemData:getGoodsType() == false then
		goutil.setActive(self._go, false)
		printError("【礼包商店】请检查商品配置，商品id：" .. itemData:getGoodsId())

		return
	end

	goutil.setActive(self._go, true)

	self._curIndex = itemIndex
	self._itemData = itemData
	self._goodsType = self._itemData:getGoodsType()

	if self._goodsType == StoreEnum.GoodsType.MonthlyCard then
		self:_updateMonthCardCellView()
	else
		self:_updateCellView()
	end
end

function M:_updateMonthCardCellView()
	goutil.setActive(self._goSellOut, false)
	goutil.setActive(self._goTime, false)

	self._remainedDay = self._itemData:getRemainedDay()

	goutil.setActive(self._goLimit, false)
	goutil.setActive(self._txtMonth.gameObject, self._remainedDay > 0)

	self._txtMonth.text = langF("tip_store_monthcard_remaining", self._remainedDay)

	goutil.setActive(self._goDiscount, false)
	self:_setIcon()

	self._txtPriceMonth.text = StoreUtil.getMoneyMark(self._itemData:getPrice())

	goutil.setActive(self._txtPriceMonth.gameObject, true)
	goutil.setActive(self._txtPrice.gameObject, false)
	goutil.setActive(self._txtOriginalPrice.gameObject, false)
	self:_setPriceIcon(self._itemData:getCostItemId())

	self._hasSellOut = false
	self._txtName.text = self._itemData:getName()

	goutil.setActive(self._txtFree.gameObject, false)
end

function M:_updateCellView()
	goutil.setActive(self._goSellOut, false)
	goutil.setActive(self._goDiscount, false)

	local isBatch = self._itemData:getBatchBuyNum() > 0
	local limit = isBatch and 1 or self._itemData:getBuyLimit()
	local isLimit = limit > 0 or isBatch

	goutil.setActive(self._goLimit, isLimit)
	goutil.setActive(self._txtMonth.gameObject, false)

	local remainedNum = isBatch and 1 or self._itemData:getRemainedNum()

	self._hasSellOut = self._itemData:getSellOut()

	if isLimit then
		remainedNum = self._hasSellOut and 0 or remainedNum
		self._txtLimitNum.text = langF("tip_store_limmit_show", remainedNum, limit)
		self._txtLimitName.text = StoreUtil.getLimitName(self._itemData)
	end

	goutil.setActive(self._goSellOut, self._hasSellOut)
	self:_setIcon()

	self._txtName.text = self._itemData:getName()

	self:_checkDiscountTick(self._itemData)
	self:_initCostInfo(self._itemData)

	self._isNew = StoreModel.instance:getIsNeedShowNew(self._itemData)

	goutil.setActive(self._goNewSign, self._isNew and not self._hasSellOut)
	self:_updateRedPoint()
end

function M:_updateRedPoint()
	local isShowRed = not self._isNew and self._isFree and not self._hasSellOut

	goutil.setActive(self._goRedPoint, isShowRed)
end

function M:_setIcon()
	local url = StoreUtil.getGiftBagIconPath(self._itemData:getIcon())

	if self._url ~= url then
		self._url = url

		IconLoader.setSprite(self._imgIcon, IconType.StoreIcon, url)
	end

	local iconName = "shop_gift_bg" .. self._itemData:getQuality()
	local qualityUrl = StoreUtil.getGiftBagIconPath(iconName)

	if self._qualityUrl ~= qualityUrl then
		self._qualityUrl = qualityUrl

		IconLoader.setSprite(self._imgQuality, IconType.StoreIcon, qualityUrl)
	end
end

function M:_setPriceIcon(itemId)
	if itemId then
		MoneyUtil.setMoneyIcon(self._imgPriceIcon, itemId)
	end
end

function M:_initCostInfo(data)
	local itemId
	local isDiscount = data:getIsDiscount()

	if isDiscount then
		self._txtPrice.text = data:getDiscountPrice()
		self._txtOriginalPrice.text = data:getPrice()
		self._txtDiscount.text = StoreUtil.getDiscount(data:getDiscount())
		itemId = data:getDiscountedCostItemId()
	else
		self._txtPrice.text = data:getPrice()
		itemId = data:getCostItemId()
	end

	goutil.setActive(self._txtPriceMonth.gameObject, false)

	self._isFree = not isDiscount and data:getPrice() <= 0

	if self._isFree then
		goutil.setActive(self._txtFree.gameObject, true)
		goutil.setActive(self._txtPrice.gameObject, false)
	else
		goutil.setActive(self._txtFree.gameObject, false)
		goutil.setActive(self._txtPrice.gameObject, true)
	end

	goutil.setActive(self._txtOriginalPrice.gameObject, isDiscount)
	goutil.setActive(self._goDiscount, isDiscount and not self._hasSellOut)
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
	GlobalDispatcher:dispatchEvent(EventType.REFRESH_STORE_LIST)
end

function M:_playAnimation()
	if not self._go.activeSelf then
		return
	end

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName(self._animationName)
end

function M:clear()
	self:setEvent(false)
	removetimer(self._updateTimer, self)
end

function M:OnDestroy()
	self:clear()
	IconLoader.clearSprite(self._imgPriceIcon)
	IconLoader.clearSprite(self._imgIcon)

	self._compContainer = nil
	self._go = nil
	self._viewElementsRegistry = nil
	self._curIndex = nil
	self._itemData = nil

	self._btnBuyClick:RemoveClickListener()
	self._btnMonthTips:RemoveClickListener()

	self._btnBuyClick = nil
	self._btnMonthTips = nil
	self._imgPriceIcon = nil
	self._imgIcon = nil
end

return M
