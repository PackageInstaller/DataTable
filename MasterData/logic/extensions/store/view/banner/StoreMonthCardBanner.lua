-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/banner/StoreMonthCardBanner.lua

module("logic.extensions.store.view.banner.StoreMonthCardBanner", package.seeall)

local M = class("StoreMonthCardBanner")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer, parentView)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
end

function M:Awake()
	self:_setEvent(true)
end

function M:setUIRegistry(registry)
	self._btnBuyMonth = ButtonAdapter.Get(registry:findUIElement("2&btn_middle_-31477526"))

	self._btnBuyMonth:AddClickListener(self._onClickBuyMothCard, self)

	self._btnTips = ButtonAdapter.Get(registry:findUIElement("store_super_value_panel_-1140774013"))

	self._btnTips:AddClickListener(self._onClickExplain, self)

	self._goResidueTime = registry:findUIElement("store_super_value_panel_188921666")
	self._txtResidueTime = registry:findUIElement("store_super_value_panel_-1581798162", UIComponentType.Text)
	self._txtPrice = registry:findUIElement("store_super_value_panel_1610147354", UIComponentType.Text)
	self._txtContent1 = registry:findUIElement("store_super_value_panel_1701281098", UIComponentType.Text)
	self._txtContent2 = registry:findUIElement("store_super_value_panel_749780678", UIComponentType.Text)
	self._txtContent3 = registry:findUIElement("store_super_value_panel_1544505989", UIComponentType.Text)
	self._goMonthCard1 = registry:findUIElement("0&rewards_detail_item_2141037416")
	self._goMonthCard2 = registry:findUIElement("1&rewards_detail_item_2141037416")
	self._monthCardDailyCell = Astral.LuaComponentContainer.Add(self._goMonthCard1, StoreItemCell)
	self._monthCardRewardCell = Astral.LuaComponentContainer.Add(self._goMonthCard2, StoreItemCell)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateMonthView, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_MONTH_CARD_DATA, self._updateMonthView, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateMonthView, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_MONTH_CARD_DATA, self._updateMonthView, self)
	end
end

function M:_onClickBuyMothCard()
	if not self._goodsMo then
		return
	end

	if not StoreController.instance:isCanBuyMonthCard(self._goodsMo, true) then
		return
	end

	StoreController.instance:buyMothCard(self._goodsMo)
end

function M:updateView(storeHotTabMo)
	self._storeHotTabMo = storeHotTabMo

	if not self._updateMonthStore or not self._storeMo then
		local storeList = StoreModel.instance:getStoresByStoreType(StoreEnum.MallType.MonthyCard)

		self._storeMo = storeList[1]

		StoreAgent.instance:sendGetGoodsListRequest({
			self._storeMo:getId()
		})

		self._updateMonthStore = true
	else
		self:_updateMonthView()
	end
end

function M:_updateMonthView()
	local goods = StoreModel.instance:getGoodsList(self._storeMo:getTabId(), self._storeMo:getId())

	self._goodsMo = goods[1]

	if not self._goodsMo then
		return
	end

	local remainedDay = self._goodsMo:getRemainedDay()

	goutil.setActive(self._goResidueTime, remainedDay > 0)

	self._txtResidueTime.text = langF("tip_store_monthcard_remaining", remainedDay)
	self._txtPrice.text = StoreUtil.getMoneyMark(self._goodsMo:getPrice())

	local dailyRewardStr = self._goodsMo:getDailyReward()
	local rewardStr = self._goodsMo:getReward()
	local dailyReward = StoreUtil.formatText(dailyRewardStr)[1]
	local itemData1 = ItemUtil.createItemData({
		itemId = dailyReward.itemId,
		count = dailyReward.num
	})

	self._monthCardDailyCell:updateData(itemData1)

	local reward = StoreUtil.formatText(rewardStr)[1]
	local itemData2 = ItemUtil.createItemData({
		itemId = reward.itemId,
		count = reward.num
	})

	self._monthCardRewardCell:updateData(itemData2)
	self:_initContent()
end

function M:_initContent()
	local texts = string.split(self._goodsMo:getDesc(), "|")

	self._txtContent1.text = texts[1]
	self._txtContent2.text = texts[2]
	self._txtContent3.text = texts[3]
end

function M:_onClickExplain()
	if not self._goodsMo then
		return
	end

	ViewMgr.instance:open(ViewName.ImageGuide, {
		self._goodsMo:getExplainId()
	})
end

function M:OnDestroy()
	self:_setEvent(false)
	self._btnBuyMonth:RemoveClickListener()
	self._btnTips:RemoveClickListener()

	self._icon = nil
end

return M
