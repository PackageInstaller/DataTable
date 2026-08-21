-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/skin/StoreSkinView.lua

module("logic.extensions.store.view.skin.StoreSkinView", package.seeall)

local M = class("StoreSkinView", StoreFragmentViewBase)

function M:buildUI()
	M.super.buildUI(self)

	self._goodsScroll = self._registry:getGo("store_skin_panel_935890310")
	self._scrollView = LoopListHelper.New(self._goodsScroll)

	self._scrollView:InitListView(0, self._updateCell, self)

	self._items = {}
end

function M:destroyUI()
	self._scrollView:ClearCells()
	self._scrollView:Dispose()

	self._scrollView = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateScrollView, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_ALL_UNLOCK_SKIN_EVENT, self._refreshSkinState, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateScrollView, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_ALL_UNLOCK_SKIN_EVENT, self._refreshSkinState, self)
	end
end

function M:onEnter()
	self._hasUpdateSkinData = false

	M.super.onEnter(self)
	self:_setEvent(true)
end

function M:onExit()
	M.super.onExit(self)
	self:_setEvent(false)

	for k, v in pairs(self._items) do
		v:clear()
	end

	self._items = {}

	StoreModel.instance:setIsNeedShowNew(self._curShowList)
end

function M:_clickStoreCallBack(index, storeMo, isClick)
	M.super._clickStoreCallBack(self, index, storeMo, isClick)

	if self._selectIndex == index and isClick then
		return
	end

	StoreModel.instance:setIsNeedShowNew(self._curShowList)
	self._scrollView:ClearCells()

	self._selectIndex = index

	self:_updateMoneyView(storeMo:getId())
	StoreAgent.instance:sendGetGoodsListRequest({
		storeMo:getId()
	})

	if not self._hasUpdateSkinData then
		HeroSkinAgent.instance:sendGetAllHeroSkinInfoRequest()
	end

	self._hasPlayAnimation = false
end

function M:_updateScrollView(e, refresh)
	if not self._hasUpdateSkinData then
		return
	end

	self._curShowList = StoreModel.instance:getGoodsList(self._tabId, self._targetStoreId)

	if not self._curShowList then
		return
	end

	local count = self._curShowList and #self._curShowList or 0

	self._scrollView:SetListItemCount(count, refresh)
	self._scrollView:RefreshAllShownItem()

	if not self._targetGoodsId then
		self:_playAnimation()

		return
	end

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

	local item = self._scrollView:NewListViewItem("store_skin_item")

	if self._curShowList then
		local itemData = self._curShowList[curIndex]
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, StoreSkinViewItem)

		shower.view = self

		shower:SetItemData(itemData, curIndex)

		if not self._items[shower.id] then
			self._items[shower.id] = shower

			self._items[shower.id]:setEvent(true)
		end
	end

	return item
end

function M:_refreshSkinState()
	self._hasUpdateSkinData = true

	local skinGoodsDatas = StoreModel.instance:getGoodsList(self._tabId, self._targetStoreId)

	if not skinGoodsDatas then
		return
	end

	for i = 1, #skinGoodsDatas do
		local mo = skinGoodsDatas[i]
		local hasBuy = HeroSkinModel.instance:getIsSkinUnlock(mo:getSkinId())

		mo:setSellState(hasBuy)
	end

	self:_updateScrollView()
end

function M:_playAnimation()
	GlobalDispatcher:dispatchEvent(EventType.STORE_PLAY_ITEM_ANIMATION, true)
end

return M
