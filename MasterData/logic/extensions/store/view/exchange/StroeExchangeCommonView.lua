-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/exchange/StroeExchangeCommonView.lua

module("logic.extensions.store.view.exchange.StroeExchangeCommonView", package.seeall)

local M = class("StroeExchangeCommonView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self.animStartIndex = 99999
	self.animEndIndex = -1
	self._items = {}
end

function M:setUIRegistry(registry)
	self._goodsScroll = registry:findUIElement("store_exchange_panel_1110305673")
	self._scrollView = LoopGridViewHelper.New(self._goodsScroll)

	self._scrollView:InitGridView(0, self._updateCell, self)

	self._txtRefreshTime = registry:findUIElement("store_exchange_panel_216620385", UIComponentType.Text)
	self._btnRefresh = registry:findUIElement("store_exchange_panel_229279946", UIComponentType.ButtonAdapter)
end

function M:bindEvents()
	self._btnRefresh:AddClickListener(self._refreshGoodsList, self)
end

function M:unbindEvents()
	self._btnRefresh:RemoveClickListener()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateScrollView, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_STORE_LIST, self._refreshStoreInfo, self)
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_EVENT, self._handleJump, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateScrollView, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_STORE_LIST, self._refreshStoreInfo, self)
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_EVENT, self._handleJump, self)
	end
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)
	StoreModel.instance:setIsNeedShowNew(self._curShowList or {})

	self._selectStoreId = false

	self:_stopCounter()

	for k, v in pairs(self._items) do
		v:setEvent(false)
	end

	self._items = {}

	StoreModel.instance:setIsNeedShowNew(self._curShowList)
end

function M:destroyUI()
	self._scrollView:ClearCells()
	self._scrollView:Dispose()

	self._scrollView = nil
end

function M:updateView(storeMo, targetGoodsId)
	self:setActive(true)

	self._targetGoodsId = targetGoodsId

	self._scrollView:ClearCells()
	self:_initGoodsView(storeMo)
	StoreAgent.instance:sendGetGoodsListRequest({
		storeMo:getId()
	})
end

function M:setActive(value)
	goutil.setActive(self._go, value)
end

function M:_initGoodsView(storeMo)
	self._storeMo = storeMo
	self._selectStoreId = storeMo:getId()
	self._tabId = storeMo:getTabId()

	self:_updateRefreshTime()
end

function M:_updateRefreshTime()
	self._storeCo = self._storeMo:getStoreCO()

	local autoRefreshType = self._storeCo.autoRefreshType > 0
	local canManualRefresh = self._storeMo:getCanManualRefresh()
	local mallType = self._storeMo:getStoreType()

	self._curStoreType = mallType

	local isRandomOutput = mallType == StoreEnum.MallType.RandomOutput
	local isNotFixed = mallType ~= StoreEnum.MallType.Fixed

	goutil.setActive(self._btnRefresh.gameObject, canManualRefresh and isRandomOutput)
	goutil.setActive(self._txtRefreshTime.gameObject, autoRefreshType and isNotFixed)
	self:_showCountdown()
end

function M:_showCountdown()
	self._remainSeconds = self._storeMo:getAutoRefreshRemainedSeconds()

	if self._remainSeconds then
		self._remainSeconds = tonumber(self._remainSeconds)

		if self._remainSeconds > 0 then
			self._remainSeconds = self._remainSeconds + 1

			self:_startCounter()
			self:_updateTimeView()
		else
			self:_stopCounter()

			self._txtRefreshTime.text = ""
		end
	else
		self._txtRefreshTime.text = ""
	end
end

function M:_startCounter()
	if not self._remainSeconds then
		return
	end

	self:_stopCounter()
	Scheduler.addListener(1, self._onSecond, self, true)
end

function M:_stopCounter()
	Scheduler.removeListener(self._onSecond, self)
end

function M:_onSecond()
	self._remainSeconds = self._remainSeconds - 1

	self:_updateTimeView()

	if self._remainSeconds <= 0 then
		self:_onRefreshGoods()
		self:_stopCounter()

		self._txtRefreshTime.text = ""
	end
end

function M:_updateTimeView()
	local content = langF("tip_store_refresh_store", TextFormatter.formatFullExpireTime(self._remainSeconds))

	self._txtRefreshTime.text = content
end

function M:_onRefreshGoods()
	if not self._selectStoreId or not self._tabId then
		return
	end

	StoreAgent.instance:sendGetMallListRequest()
end

function M:_refreshStoreInfo()
	if not self._selectStoreId or not StoreModel.instance:isStoreOnline(self._selectStoreId) then
		GlobalDispatcher:dispatchEvent(EventType.CLICK_STORE_RIGHT_TAB, self.callBackFunc, self)

		return
	end

	StoreAgent.instance:sendGetGoodsListRequest({
		self._selectStoreId
	})
	GlobalDispatcher:dispatchEvent(EventType.CLICK_STORE_RIGHT_TAB, self.callBackFunc, self)

	self._storeMo = StoreModel.instance:getStoreMoByID(self._selectStoreId)

	if not self._storeMo then
		return
	end

	self:_initGoodsView(self._storeMo)
end

function M:_updateScrollView(e, refresh)
	if not self._go.activeSelf then
		return
	end

	StoreModel.instance:setIsNeedShowNew(self._curShowList)

	self._curShowList = StoreModel.instance:getGoodsList(self._tabId, self._selectStoreId)

	if not self._curShowList then
		return
	end

	local count = self._curShowList and #self._curShowList or 0

	self._scrollView:SetListItemCount(count, refresh)
	self._scrollView:RefreshAllShownItem()

	local moveToIndex = 1

	for i = 1, #self._curShowList do
		if self._curShowList[i]:getGoodsId() == self._targetGoodsId then
			moveToIndex = i - 1

			break
		end
	end

	self._scrollView:MoveToItemIndex(moveToIndex)
	self:_playAnimation()
end

function M:_updateCell(curIndex, row, column)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._scrollView:NewListViewItem("store_exchange_item")

	if self._curShowList then
		local itemData = self._curShowList[curIndex]
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, StoreExchangeViewItem)

		shower.view = self

		shower:SetItemData(itemData, curIndex)

		if not self._items[shower.id] then
			self._items[shower.id] = shower

			self._items[shower.id]:setEvent(true)
		end
	end

	return item
end

function M:_refreshGoodsList()
	if not self._selectStoreId or not self._tabId then
		return
	end

	if self._storeMo then
		local remainedManualRefreshTimes = self._storeMo:getRemainedManualRefreshTimes()

		if remainedManualRefreshTimes <= 0 then
			FloatWordMgr.instance:show(lang("tip_store_refreshtime"))

			return
		end

		if self._storeMo:getStoreType() == StoreEnum.MallType.RandomOutput then
			self._costItems = StoreUtil.formatText(self._storeCo.manualRefreshCost)

			local len = #self._costItems

			if len == 1 then
				local itemId = self._costItems[1].itemId
				local costCount = self._costItems[1].num
				local myCount = ItemModel.instance:getItemCountByItemId(itemId)

				self._isEough = costCount <= myCount

				local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

				self._costItemName = itemCo and itemCo.name or ""
				self._curStoreID = self._selectStoreId

				local info = {}

				info.leftItemData = ItemUtil.createItemData({
					itemId = itemId,
					count = costCount
				})
				info.clickRightCallBackFunc = self._clickRefreshConfirm
				info.clickRightCallBackHandler = self
				info.content = langF("tip_store_refresh_store_confirm", costCount, self._costItemName, self._storeMo:getName())
				info.leftNumColor = self._isEough and "#B6B7B7" or "#b33636"

				ViewMgr.instance:open(ViewName.CommonExchangeTips, info)

				return
			else
				if enableErrorLog then
					printError("消耗物品格式不正确,商店ID,", self._storeMo:getId(), self._storeCo.manualRefreshCost)
				end

				return
			end
		end
	end

	StoreAgent.instance:sendManualRefreshGoodsRequest(self._selectStoreId, self._tabId)
end

function M:_clickRefreshConfirm()
	if not self._isEough then
		FloatWordMgr.instance:show(langF("tip_store_item_not_enough", self._costItemName))

		return false
	end

	StoreAgent.instance:sendManualRefreshGoodsRequest(self._curStoreID, self._tabId)
end

function M:setPlayAnimIndex(index)
	self.animStartIndex = index < self.animStartIndex and index or self.animStartIndex
	self.animEndIndex = index > self.animEndIndex and index or self.animEndIndex
end

function M:_playAnimation()
	GlobalDispatcher:dispatchEvent(EventType.STORE_PLAY_ITEM_ANIMATION, true)
end

function M:_handleJump()
	if self._storeMo == nil then
		return
	end

	local tabId = self._storeMo:getTabId()
	local storeId = self._storeMo:getId()
	local index = StoreModel.instance:getStoreTabIndexById(tabId)

	StoreModel.instance:setJumpInfo({
		index = index,
		tabId = tabId,
		targetStoreId = storeId
	})
end

return M
