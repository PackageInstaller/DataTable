-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/hotgoods/StoreHotListViewCell.lua

module("logic.extensions.store.view.hotgoods.StoreHotListViewCell", package.seeall)

local M = class("StoreHotListViewCell")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._btnBuyClick = ButtonAdapter.Get(registry:findUIElement("store_exchange_item2_1933081139"))

	self._btnBuyClick:AddClickListener(self._clickSelf, self)

	self._itemIcon = registry:findUIElement("store_exchange_item2_1170474463", UIComponentType.Image)
	self._itemQuality = registry:findUIElement("store_hot_list_cell_235058305", UIComponentType.Image)
	self._doubleHintSign = registry:findUIElement("store_exchange_item2_-544790487")
	self._txtDoubleHint = registry:findUIElement("store_exchange_item2_1053097440", UIComponentType.Text)
	self._txtPrice1 = registry:findUIElement("store_exchange_item2_856295982", UIComponentType.Text)
	self._txtOriginalPrice = registry:findUIElement("store_exchange_item2_-1611026884", UIComponentType.Text)
	self._txtPrice2 = registry:findUIElement("store_exchange_item2_-898363160", UIComponentType.Text)
	self._imgCostIcon = registry:findUIElement("store_exchange_item2_2023859428", UIComponentType.Image)
	self._goSellOut = registry:findUIElement("store_hot_list_cell_-710977666")
	self._txtName = registry:findUIElement("store_exchange_item2_50551331", UIComponentType.Text)
	self._goAnimation = registry:findUIElement("store_hot_list_cell_741178043")
	self._canvasGroupAnim = registry:findUIElement("store_hot_list_cell_741178043", ComponentType.CanvasGroup)
	self._posX, self._posY = GameUtils.getLocalPos(self._goAnimation)
	self._animation = self._go:GetComponent(ComponentType.Animation)

	goutil.setActive(self._txtOriginalPrice.gameObject, false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.STORE_PLAY_ITEM_ANIMATION, self._playAnimation, self)
	else
		GlobalDispatcher:removeEventListener(EventType.STORE_PLAY_ITEM_ANIMATION, self._playAnimation, self)
	end
end

function M:SetItemData(itemData, itemIndex)
	if itemData:getGoodsType() == false then
		goutil.setActive(self._go, false)
		printError("【商店】请检查商品配置，商品id：" .. itemData:getGoodsId())

		return
	end

	goutil.setActive(self._go, true)

	self._curIndex = itemIndex
	self._itemData = itemData
	self._hasSellOut = false
	self._hasSellOutToday = false

	self:_updateCellView(itemData)
end

function M:_updateCellView(data)
	local isFirstMoney = data:getGoodsType() == StoreEnum.GoodsType.FirstMoney

	self._txtName.text = data:getName()

	IconLoader.setSprite(self._itemIcon, IconType.StoreIcon, "hot_sale/" .. data:getIcon())

	local qualityIcon = isFirstMoney and StoreEnum.HotListItemQualityIcon2 or StoreEnum.HotListItemQualityIcon
	local url = StoreUtil.getQualityIconPath(qualityIcon[data:getQuality()])

	IconLoader.setSprite(self._itemQuality, IconType.StoreIcon, url)
	goutil.setActive(self._goSellOut, self._hasSellOut or self._hasSellOutToday)
	goutil.setActive(self._doubleHintSign, not isFirstMoney)

	if isFirstMoney then
		self:_updateFirstMoneyItem(data)
	else
		self:_updateSecondMoneyItem(data)
	end
end

function M:_updateFirstMoneyItem(data)
	self._txtPrice1.text = langF("tip_store_price", data:getPrice())

	goutil.setActive(self._txtPrice1.gameObject, true)
	goutil.setActive(self._txtPrice2.gameObject, false)
	goutil.setActive(self._txtDoubleHint.gameObject, false)
end

function M:_updateSecondMoneyItem(data)
	local isSecondMoney = data:getGoodsType() == StoreEnum.GoodsType.SecondMoney
	local isFirst = data:getIsFirst()
	local addNum = isFirst and data:getFrstExtraExchangeNum() or data:getNormalExtraExchangeNum()

	goutil.setActive(self._doubleHintSign, isSecondMoney and isFirst)

	self._txtPrice2.text = data:getCostFirstMoneyNum()

	goutil.setActive(self._txtPrice1.gameObject, false)
	goutil.setActive(self._txtPrice2.gameObject, true)

	if not self._hasInitCostIcon then
		self._hasInitCostIcon = true

		MoneyUtil.setMoneyIcon(self._imgCostIcon, GameEnum.CurrencyCodeEnum.CfjzCode)
	end

	self._txtDoubleHint.text = addNum

	goutil.setActive(self._txtDoubleHint.gameObject, addNum > 0)
end

function M:_clickSelf()
	if self._itemData:getGoodsType() == StoreEnum.GoodsType.FirstMoney then
		self:_clickFirstMoneyItem()
	else
		self:_clickSecondMoneyItem()
	end
end

function M:_clickFirstMoneyItem()
	if self._hasSellOutToday then
		FloatWordMgr.instance:show(lang("tip_store_item_has_sellout"))

		return
	end

	if self._hasSellOut then
		return
	end

	if not self._itemData then
		return
	end

	local _goodIds = self._itemData:getGoodsId()
	local _tabId = self._itemData:getTabId()
	local _payMoney = self._itemData:getPrice()
	local _coinName = self._itemData:getName()
	local _moreCharge = 0
	local _payType = 0
	local _productName = self._itemData:getName()
	local _coinsAmount = 1
	local _rate = 10
	local _platformGoodsId = self._itemData:getSdkPayId()
	local _exStr

	StoreAgent.instance:sendBuyGoodsRequestBySDK(_goodIds, 1, _tabId, _payMoney, _coinName, _moreCharge, _payType, _productName, _coinsAmount, _rate, _platformGoodsId, _exStr)
end

function M:_clickSecondMoneyItem()
	if self._hasSellOutToday or self._hasSellOut then
		FloatWordMgr.instance:show(lang("tip_store_item_has_sellout"))

		return
	end

	if not self._itemData then
		return
	end

	self._goodsMo = self._itemData

	local baseExchangeNum = self:_getExcahngeNum()
	local costCount = self._goodsMo:getCostFirstMoneyNum()
	local firstMoney = GameEnum.CurrencyCodeEnum.CfjzCode
	local secondMoney = GameEnum.CurrencyCodeEnum.YtjjCode
	local myCount = ItemModel.instance:getItemCountByItemId(firstMoney)

	self._firstName = BackpackConfig.instance:getConfigByKey(ConfigName.ItemCurrency, firstMoney).name

	local secondName = BackpackConfig.instance:getConfigByKey(ConfigName.ItemCurrency, secondMoney).name

	self._isEough = costCount <= myCount

	local info = {}

	info.leftItemData = ItemUtil.createItemData({
		itemId = firstMoney,
		count = costCount
	})
	info.rightItemData = ItemUtil.createItemData({
		itemId = secondMoney,
		count = baseExchangeNum
	})
	info.clickRightCallBackFunc = self._clickBuyConfirm
	info.clickRightCallBackHandler = self
	info.content = langF("tip_store_exchange_tips", costCount, self._firstName, baseExchangeNum, secondName)
	info.leftNumColor = self._isEough and "#B6B7B7" or "#b33636"

	ViewMgr.instance:open(ViewName.CommonExchangeTips, info)
end

function M:_getExcahngeNum()
	local baseExchangeNum = self._goodsMo:getExchangeNum()

	if self._goodsMo:getIsFirst() then
		if self._goodsMo:getFrstExtraExchangeNum() > 0 then
			baseExchangeNum = baseExchangeNum + self._goodsMo:getFrstExtraExchangeNum()
		end
	elseif self._goodsMo:getNormalExtraExchangeNum() > 0 then
		baseExchangeNum = baseExchangeNum + self._goodsMo:getNormalExtraExchangeNum()
	end

	return baseExchangeNum
end

function M:_clickBuyConfirm()
	if not self._isEough then
		local info = {}

		info.clickRightCallBackFunc = self._clickJumpConfirm
		info.clickRightCallBackHandler = self
		info.content = langF("tip_store_first_money_not_enough", self._firstName, self._firstName)
		info.leftTxt = lang("tip_common_cancel")
		info.rightTxt = lang("tip_common_confirm")

		ViewMgr.instance:open(ViewName.CommonConfirmTips, info)

		return
	end

	local firstMoneyId = GameEnum.CurrencyCodeEnum.CfjzCode
	local costCount = self._goodsMo:getCostFirstMoneyNum()
	local costItems = StoreUtil.createCostItems(firstMoneyId, costCount)

	StoreAgent.instance:sendBuyGoodsRequest(self._goodsMo:getGoodsId(), 1, costItems)
end

function M:_clickJumpConfirm()
	local storeList = StoreModel.instance:getStoresByStoreType(StoreEnum.MallType.DirectPurchase)

	if #storeList <= 0 then
		return
	end

	local tabId = storeList[1]:getTabId()
	local storeId = storeList[1]:getId()

	StoreMainFacade.instance:jumpToStore(tabId, storeId)
end

function M:_playAnimation()
	if not self._go.activeSelf then
		return
	end

	if self._animation then
		self._animation:Stop()
		self._animation:Play("store_hot_list_item3_cell_open")
	end
end

function M:OnDestroy()
	self:setEvent(false)

	if self._tweener then
		self._tweener:Kill(false)
	end

	IconLoader.clearSprite(self._itemIcon)
	IconLoader.clearSprite(self._itemQuality)

	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._viewElementsRegistry = nil
	self._itemData = nil

	self._btnBuyClick:RemoveClickListener()

	self._btnBuyClick = nil
	self._itemIcon = nil
	self._itemQuality = nil
	self._doubleHintSign = nil
	self._txtDoubleHint = nil
	self._txtPrice1 = nil
	self._txtPrice2 = nil
	self._txtName = nil
end

return M
