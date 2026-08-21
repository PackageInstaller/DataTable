-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/exchange/StoreExchangeEchoCardViewItem.lua

module("logic.extensions.store.view.exchange.StoreExchangeEchoCardViewItem", package.seeall)

local M = class("StoreExchangeEchoCardViewItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self.id = UIDUtil.getEventUID()
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._btnBuyClick = ButtonAdapter.Get(registry:findUIElement("store_exchange_echo_item_730092217"))

	self._btnBuyClick:AddClickListener(self._clickSelf, self)

	self._imgIcon = registry:findUIElement("store_exchange_echo_item_1289524454", UIComponentType.Image)
	self._imgQuality = registry:findUIElement("store_exchange_echo_item_-53626174", UIComponentType.Image)
	self._txtName = registry:findUIElement("store_exchange_echo_item_1175616611", UIComponentType.Text)
	self._txtTime = registry:findUIElement("store_exchange_echo_item_314643386", UIComponentType.Text)
	self._goTime = registry:findUIElement("store_exchange_echo_item_882340063")
end

function M:_clickSelf()
	local rewardList = StoreUtil.formatText(self._goodsData:getReward())

	if #rewardList <= 0 then
		return
	end

	for i = 1, #rewardList do
		local itemData = ItemUtil.createItemData({
			itemId = rewardList[i].itemId,
			count = rewardList[i].num
		})

		if itemData:getSubType() == GameEnum.PropSubTypeEnum.EchoCardPack then
			ViewMgr.instance:open(ViewName.EchoCardPackView, EchoCardPackController.ViewType.Buy, itemData, self._goodsData)

			return
		end
	end
end

function M:SetItemData(GoodsData, itemIndex)
	self._goodsData = GoodsData
	self._goodsType = self._goodsData:getGoodsType()

	self:_updateCellView()
end

function M:_updateCellView()
	self:_setIcon()
	self:_setGoodsName()
	self:_checkDiscountTick(self._goodsData)
end

function M:_setGoodsName()
	local useFirstItemName = string.nilorempty(self._goodsData:getName())

	if not useFirstItemName then
		self._txtName.text = self._goodsData:getName()
	end
end

function M:_setIcon()
	local url = StoreUtil.getEchoCarIconPath(self._goodsData:getIcon())

	if self._url ~= url then
		self._url = url

		IconLoader.setSprite(self._imgIcon, IconType.StoreIcon, url)
	end
end

function M:_setQuality()
	local quality = self._goodsData:getQuality()
	local qualityUrl = StoreUtil.getQualityIconPath(StoreEnum.ExchangeItemQualityIcon[quality])

	if self._qualityUrl ~= qualityUrl then
		self._qualityUrl = qualityUrl

		if qualityUrl then
			goutil.setActive(self._imgQuality.gameObject, true)
			IconLoader.setSprite(self._imgQuality, IconType.StoreIcon, qualityUrl)
		end
	end

	goutil.setActive(self._imgQuality.gameObject, qualityUrl ~= nil)
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
		self._txtTime.text = self._goodsData:getGoodsTimeStr()
	else
		self:_onRefreshGoods()
		goutil.setActive(self._goTime, false)
		removetimer(self._updateTimer, self)
	end
end

function M:_onRefreshGoods()
	GlobalDispatcher:dispatchEvent(EventType.REFRESH_STORE_LIST)
end

function M:OnDestroy()
	removetimer(self._updateTimer, self)
	IconLoader.clearSprite(self._imgIcon)
	IconLoader.clearSprite(self._imgQuality)

	self._compContainer = nil
	self._go = nil
	self._viewElementsRegistry = nil
	self._goodsData = nil

	self._btnBuyClick:RemoveClickListener()

	self._btnBuyClick = nil
	self._imgIcon = nil
	self._imgQuality = nil
end

return M
