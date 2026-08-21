-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/skin/StoreSkinViewItem.lua

module("logic.extensions.store.view.skin.StoreSkinViewItem", package.seeall)

local M = class("StoreSkinViewItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self.id = UIDUtil.getEventUID()
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._btnBuyClick = ButtonAdapter.Get(registry:findUIElement("store_skin_item_1842848277"))

	self._btnBuyClick:AddClickListener(self._clickSelf, self)

	self._imgSkinIcon = registry:findUIElement("store_skin_item_1467334227", UIComponentType.Image)
	self._imgQuality = registry:findUIElement("store_skin_item_1730038279", UIComponentType.Image)
	self._imgPriceIcon = registry:findUIElement("store_skin_item_-1506219612", UIComponentType.Image)
	self._goNewSign = registry:findUIElement("0&new_sigh_291166182")
	self._txtPrice = registry:findUIElement("store_skin_item_-379998055", UIComponentType.Text)
	self._txtFree = registry:findUIElement("store_skin_item_-314235088", UIComponentType.Text)
	self._txtOriginalPrice = registry:findUIElement("store_skin_item_197856301", UIComponentType.Text)
	self._goSellOut = registry:findUIElement("store_skin_item_-717082235")
	self._txtGoodsName = registry:findUIElement("store_skin_item_-1442217565", UIComponentType.Text)
	self._txtSkinName = registry:findUIElement("store_skin_item_1572558550", UIComponentType.Text)
	self._txtTime = registry:findUIElement("store_skin_item_994254071", UIComponentType.Text)
	self._goTime = registry:findUIElement("store_skin_item_-1522953802")
	self._goDiscount = registry:findUIElement("store_skin_item_-1334388834")
	self._txtDiscount = registry:findUIElement("store_skin_item_-378581524", UIComponentType.Text)
	self._goLimit = registry:findUIElement("store_skin_item_-754664488")
	self._txtLimitName = registry:findUIElement("store_skin_item_-754664488", UIComponentType.Text)
	self._txtLimitNum = registry:findUIElement("store_skin_item_-2054259184", UIComponentType.Text)
	self._txtLimitNum.text = "1/1"

	goutil.setActive(self._goLimit, true)

	self._goAnimation = registry:findUIElement("store_skin_item_-1903503231")
	self._canvasGroupAnim = registry:findUIElement("store_skin_item_-1903503231", ComponentType.CanvasGroup)
	self._posX, self._posY = GameUtils.getLocalPos(self._goAnimation)
	self._animation = self._go:GetComponent(ComponentType.Animation)
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

	if self._hasSellOut then
		FloatWordMgr.instance:show(lang("tip_store_already_have"))

		return
	end

	ViewMgr.instance:close(ViewName.StoreMainViewViewPresentor)
	CharacterSkinFacade:showAllSkin(self._skinCfg.heroId, self._skinCfg.id, ViewName.StoreMainViewViewPresentor)
end

function M:SetItemData(itemData, itemIndex)
	self._skinCfg = BackpackConfig.instance:getConfigByKey(ConfigName.ItemHeroSkin, itemData:getSkinId())

	if itemData:getGoodsType() == false or not self._skinCfg then
		goutil.setActive(self._go, false)
		itemData:getGoodsId()
		printError("【皮肤商店】请检查商品配置，商品id：" .. itemData:getGoodsId())

		return
	end

	goutil.setActive(self._go, true)

	self._curIndex = itemIndex
	self._itemData = itemData

	self:_updateCellView(itemData)
end

function M:_updateCellView(data)
	self._txtLimitName.text = StoreUtil.getLimitName(self._itemData)
	self._txtGoodsName.text = data:getName()
	self._txtSkinName.text = self._skinCfg.name

	local quality = data:getQuality()
	local qualityUrl = StoreUtil.getQualityIconPath(StoreEnum.SkinItemQualityIcon[quality])

	if self._qualityUrl ~= qualityUrl then
		self._qualityUrl = qualityUrl

		if qualityUrl then
			goutil.setActive(self._imgQuality.gameObject, true)
			IconLoader.setSprite(self._imgQuality, IconType.StoreIcon, qualityUrl)
		else
			goutil.setActive(self._imgQuality.gameObject, false)
			IconLoader.clearSprite(self._imgQuality)
		end
	end

	IconLoader.setSprite(self._imgSkinIcon, IconType.StoreIcon, "skin/" .. data:getIcon())
	self:_refreshHeroSkinState()
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

	local isFree = not isDiscount and data:getPrice() <= 0

	goutil.setActive(self._txtPrice.gameObject, not isFree)
	goutil.setActive(self._txtFree.gameObject, isFree)
	goutil.setActive(self._txtOriginalPrice.gameObject, isDiscount)

	if itemId then
		MoneyUtil.setMoneyIcon(self._imgPriceIcon, itemId)
	end

	goutil.setActive(self._goDiscount, isDiscount)
end

function M:_checkDiscountTick(data)
	removetimer(self._updateTimer, self)

	self._remainingTime = data:getGoodEndRemainedSeconds()

	goutil.setActive(self._goTime, self._remainingTime > 0)

	if self._remainingTime > 0 then
		self._txtTime.text = self._itemData:getGoodsTimeStr()

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

function M:_refreshHeroSkinState()
	self._hasSellOut = HeroSkinModel.instance:getIsSkinUnlock(self._skinCfg.id)

	goutil.setActive(self._goSellOut, self._hasSellOut)

	local isNew = StoreModel.instance:getIsNeedShowNew(self._itemData)

	goutil.setActive(self._goNewSign, isNew and not self._hasSellOut)
	self:_initCostInfo(self._itemData)
	self:_checkDiscountTick(self._itemData)
end

function M:_playAnimation()
	if not self._go.activeSelf then
		return
	end

	if self._animation then
		self._animation:Stop()
		self._animation:Play("store_skin_item_open")
	end
end

function M:clear()
	self:setEvent(false)

	if self._tweener then
		self._tweener:Kill(false)
	end

	removetimer(self._updateTimer, self)
end

function M:OnDestroy()
	self:clear()
	IconLoader.clearSprite(self._imgSkinIcon)
	IconLoader.clearSprite(self._imgQuality)
	IconLoader.clearSprite(self._imgPriceIcon)

	self._compContainer = nil
	self._go = nil
	self._viewElementsRegistry = nil
	self._curIndex = nil
	self._itemData = nil

	self._btnBuyClick:RemoveClickListener()

	self._btnBuyClick = nil
	self._imgSkinIcon = nil
	self._imgQuality = nil
	self._imgPriceIcon = nil
end

return M
