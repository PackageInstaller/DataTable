-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/common/StoreGoodsInfoView.lua

module("logic.extensions.store.view.common.StoreGoodsInfoView", package.seeall)

local M = class("StoreGoodsInfoView", ViewComponent)

function M:buildUI()
	self._goodsObj = self:getGo("store_main_view_copy_1540615028")
	self._goodsScrollFor3Go = self:getGo("store_main_view_copy_-2061342322")
	self._scrollViewFor3 = LoopGridViewHelper.New(self._goodsScrollFor3Go)

	self._scrollViewFor3:InitGridView(0, self._updateCell, self)

	self._goodsScrollFor4Go = self:getGo("store_main_view_copy_603202622")
	self._scrollViewFor4 = LoopGridViewHelper.New(self._goodsScrollFor4Go)

	self._scrollViewFor4:InitGridView(0, self._updateCellForFour, self)

	self._btnRefresh = self:getBtn("store_main_view_copy_-197904411")
	self._txtRefreshTime = self:getText("store_main_view_copy_-184086440")
	self._txtResfreshPrice = self:getText("store_main_view_copy_94181025")
	self._imgResfreshIcon = self:getImage("store_main_view_copy_-2022730191")
end

function M:destroyUI()
	self._scrollViewFor3:ClearCells()
	self._scrollViewFor4:ClearCells()
	self._scrollViewFor3:Dispose()

	self._scrollViewFor3 = nil

	self._scrollViewFor4:Dispose()

	self._scrollViewFor4 = nil
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._initDataPanel, self)
	GlobalDispatcher:addEventListener(EventType.REFRESH_STORE_LIST, self._refreshStoreInfo, self)
	GlobalDispatcher:addEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._onRefreshGoods, self)
	GlobalDispatcher:addEventListener(EventType.STORE_STATE_CODE_ERROR, self._onRefreshGoods, self)
	self._btnRefresh:AddClickListener(self._refreshGoodsList, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._initDataPanel, self)
	GlobalDispatcher:removeEventListener(EventType.REFRESH_STORE_LIST, self._refreshStoreInfo, self)
	GlobalDispatcher:removeEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._onRefreshGoods, self)
	GlobalDispatcher:removeEventListener(EventType.STORE_STATE_CODE_ERROR, self._onRefreshGoods, self)
	self._btnRefresh:RemoveClickListener()
end

function M:onEnter()
	StoreMainFacade.instance:registerView(self)
end

function M:onExit()
	IconLoader.clearSprite(self._imgResfreshIcon)

	self._selectStoreId = false

	self:_stopCounter()
end

function M:_updateCell(curIndex, row, column)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._scrollViewFor3:NewListViewItem(self._itemName)

	if self._curShowList then
		local itemData = self._curShowList[curIndex]
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, _G[self._itemClsName])

		shower.view = self

		shower:SetItemData(itemData, curIndex)
	end

	return item
end

function M:_updateCellForFour(curIndex, row, column)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._scrollViewFor4:NewListViewItem(self._itemName)

	if self._curShowList then
		local itemData = self._curShowList[curIndex]
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, StoreGoodsItem)

		shower.view = self

		shower:SetItemData(itemData, curIndex)
	end

	return item
end

function M:_initDataPanel(key, refresh)
	if not self._isActive then
		return
	end

	local data = StoreModel.instance:getCurSelectTab()

	if not data then
		return
	end

	self._tabIndex = data.index
	self._tabId = data.tabId
	self._targetStoreId = data.targetStoreId
	self._selectGoodsId = data.targetGoodsId
	self._curShowList = StoreModel.instance:getGoodsList(self._tabId, self._targetStoreId)

	if not self._curShowList then
		return
	end

	local count = self._curShowList and #self._curShowList or 0

	self._scrollViewFor3:ClearCells()
	self._scrollViewFor4:ClearCells()

	if not self._storeMo then
		return
	end

	local mallType = self._storeMo:getStoreType()

	if mallType == StoreEnum.MallType.CurrencyExchange or mallType == StoreEnum.MallType.RandomOutput or mallType == StoreEnum.MallType.Fixed or mallType == StoreEnum.MallType.GiftBag then
		goutil.setActive(self._goodsScrollFor3Go, false)
		goutil.setActive(self._goodsScrollFor4Go, true)
		self._scrollViewFor4:SetListItemCount(count, refresh)
		self._scrollViewFor4:RefreshAllShownItem()
	elseif mallType == StoreEnum.MallType.DirectPurchase or mallType == StoreEnum.MallType.SecondExchange then
		goutil.setActive(self._goodsScrollFor3Go, true)
		goutil.setActive(self._goodsScrollFor4Go, false)
		self._scrollViewFor3:SetListItemCount(count, refresh)
		self._scrollViewFor3:RefreshAllShownItem()
	end
end

function M:_refreshStoreInfo()
	if self._selectStoreId then
		self._storeMo = StoreModel.instance:getStoreMoByID(self._selectStoreId)

		if not self._storeMo then
			return
		end

		self:_initGoodsView(self._storeMo)
	end
end

function M:_refreshGoodsList()
	if not self._selectStoreId or not self._tabId then
		return
	end

	if self._storeMo then
		local remainedManualRefreshTimes = self._storeMo:getRemainedManualRefreshTimes()

		if remainedManualRefreshTimes <= 0 then
			FloatWordMgr.instance:show(lang("tip_store_refreshtime"))

			return false
		end

		if self._storeMo:getStoreType() == StoreEnum.MallType.RandomOutput then
			local costItems = StoreUtil.formatText(self._storeCo.manualRefreshCost)
			local len = #costItems

			if len == 1 then
				local itemId = costItems[1].itemId
				local num = costItems[1].num
				local myCount = ItemModel.instance:getItemCountByItemId(itemId)

				if myCount < num then
					local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

					FloatWordMgr.instance:show(langF("tip_store_item_not_enough", itemCo.name))

					return false
				end
			else
				if enableErrorLog then
					printError("消耗物品格式不正确,商店ID,", self._storeMo:getId(), self._storeCo.manualRefreshCost)
				end

				return false
			end
		end
	end

	StoreAgent.instance:sendManualRefreshGoodsRequest(self._selectStoreId, self._tabId)
end

function M:setVisible(visble, storeMo)
	self._isActive = visble

	goutil.setActive(self._goodsObj, visble)

	if visble and storeMo then
		self:_initGoodsView(storeMo)
	end
end

function M:_initGoodsView(storeMo)
	self._storeMo = storeMo
	self._selectStoreId = storeMo:getId()
	self._tabId = storeMo:getTabId()

	local mallType = storeMo:getStoreType()

	self._curStoreType = mallType
	self._storeCo = self._storeMo:getStoreCO()

	local autoRefreshType = self._storeCo.autoRefreshType > 0
	local canManualRefresh = self._storeMo:getCanManualRefresh()
	local remainedManualRefreshTimes = self._storeMo:getRemainedManualRefreshTimes()

	goutil.setActive(self._btnRefresh.gameObject, false)
	goutil.setActive(self._txtRefreshTime.gameObject, autoRefreshType)

	self._itemName = "store_common_item"
	self._itemClsName = "StoreGoodsItem"

	if mallType == StoreEnum.MallType.CurrencyExchange then
		-- block empty
	elseif mallType == StoreEnum.MallType.RandomOutput then
		goutil.setActive(self._btnRefresh.gameObject, canManualRefresh)

		if canManualRefresh then
			self:_setManualRefreshItem()
		end
	elseif mallType == StoreEnum.MallType.DirectPurchase then
		self._itemName = "store_currency_item1"
		self._itemClsName = "StoreCurrencyItem1"
	elseif mallType == StoreEnum.MallType.SecondExchange then
		self._itemName = "store_currency_item2"
		self._itemClsName = "StoreCurrencyItem2"
	elseif mallType == StoreEnum.MallType.Fixed then
		goutil.setActive(self._txtRefreshTime.gameObject, false)
	end

	self:_showCountdown()
end

function M:_setGoodsItemName()
	return
end

function M:_showCountdown()
	self._remainSeconds = self._storeMo:getAutoRefreshRemainedSeconds()

	if self._remainSeconds then
		self._remainSeconds = tonumber(self._remainSeconds)

		if self._remainSeconds > 0 then
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

function M:_onRefreshGoods()
	if not self._selectStoreId then
		return
	end

	local mallIds = {}

	table.insert(mallIds, self._selectStoreId)
	StoreAgent.instance:sendGetGoodsListRequest(mallIds)
	StoreAgent.instance:sendGetMallListRequest()
end

function M:_updateTimeView()
	local content = langF("tip_store_refresh_store", TextFormatter.formatFullExpireTime(self._remainSeconds))

	self._txtRefreshTime.text = content
end

function M:_setManualRefreshItem()
	local costItems = StoreUtil.formatText(self._storeCo.manualRefreshCost)
	local len = #costItems

	if len == 1 then
		local itemId = costItems[1].itemId
		local num = costItems[1].num

		self._txtResfreshPrice.text = num

		local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

		if itemCo then
			IconLoader.setSprite(self._imgResfreshIcon, IconType.ItemIcon, itemCo.icon)
		end
	elseif enableErrorLog then
		printError("There are multiple consumable items,ID,", self._storeCo.mallId)
	end
end

return M
