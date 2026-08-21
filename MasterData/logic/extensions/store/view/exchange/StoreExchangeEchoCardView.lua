-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/exchange/StoreExchangeEchoCardView.lua

module("logic.extensions.store.view.exchange.StoreExchangeEchoCardView", package.seeall)

local M = class("StoreExchangeEchoCardView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._items = {}
end

function M:setUIRegistry(registry)
	self._goodsScroll = registry:findUIElement("store_exchange_panel_-760961525")
	self._scrollView = LoopListHelper.New(self._goodsScroll)

	self._scrollView:InitListView(0, self._updateCell, self)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateScrollView, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateScrollView, self)
	end
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)
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
end

function M:_updateScrollView(e, refresh)
	if not self._go.activeSelf then
		return
	end

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
end

function M:_updateCell(curIndex, row, column)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._scrollView:NewListViewItem("store_exchange_echo_item")

	if self._curShowList then
		local itemData = self._curShowList[curIndex]
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, StoreExchangeEchoCardViewItem)

		shower.view = self

		shower:SetItemData(itemData, curIndex)

		if not self._items[shower.id] then
			self._items[shower.id] = shower
		end
	end

	return item
end

return M
