-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\CommonAndActShopPanel.lua

local ResShopExchg = require("ClientData/ResShopExchg")
local ResShop = require("ClientData/ResShop")
local ResClientNotice = require("ClientData/ResClientNotice")
local ShopItem = require("UI/MainState/Trade/ShopItem")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local UIControls = UIControls
local WelfarePanelBase = require("UI/Welfare/WelfarePanelBase")
local classNameStr = "CommonAndActShopPanel"
local CommonAndActShopPanel = Class(classNameStr, WelfarePanelBase)

MixinClass(CommonAndActShopPanel, ActivityPanelMixin)

function CommonAndActShopPanel:ctor()
	self._slot4CellClick = Slot(self._onShopItemClick, self)

	if UIControls.checkControlFunc(self, "AwardList") then
		self.scrollItems = UIControls.ScrollViewLoopV(self, "AwardList", 0, self._onCellChanged)
	elseif UIControls.checkControlFunc(self, "ItemList") then
		self.scrollItems = UIControls.ScrollViewLoopV(self, "ItemList", 0, self._onCellChanged)
	end

	self.txtTime = UIControls.Label(self, "TipsPanel/TextTime")
	self.cells = {}
end

function CommonAndActShopPanel:initUI()
	return
end

function CommonAndActShopPanel:onOpenPanel()
	self.actIds = self.panelConfigData.arg4

	for i, id in pairs(self.actIds or {}) do
		local actObj = CurAvatar:getActivityObj(id)

		if actObj and actObj:isValid() then
			self.actObj = actObj
		end
	end

	if self.actObj then
		local endStr = ResClientNotice[679].notice

		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, self.actObj:getRemainOpenTime(), false, endStr)
		self.txtTime:setVisible(true)
	else
		self.txtTime:setVisible(false)
	end

	self.curShopID = self.panelConfigData.arg1

	RPC.shopEnter(self.curShopID)
end

function CommonAndActShopPanel:initPanel()
	if self.panelConfigData then
		self.subCellPrefab = "System/Common/Grid/" .. self.panelConfigData.subCellPrefab or "System/Common/Grid/GridStoreItem"

		if self.panelConfigData.subCellPrefab == "GridBackyardStoreItem" then
			self.cellClass = UIConst.RearHouseShopCellLoop
		elseif self.panelConfigData.subCellPrefab == "GridSkinItem" then
			self.cellClass = UIConst.SkinShopCellLoop
		else
			self.cellClass = UIConst.ShopCellLoop
		end

		self.shopCellImgAtlsPath = self.panelConfigData.arg2
	else
		self.subCellPrefab = "System/Common/Grid/GridStoreSkinLotteryItem"
		self.cellClass = UIConst.ShopCellLoop
	end
end

function CommonAndActShopPanel:_setData()
	return
end

function CommonAndActShopPanel:onShopEnterResp(shopID, serverItemInfos)
	if shopID ~= self.curShopID then
		return
	end

	local shopData = ResShop[shopID]

	self.curShopData = shopData

	local buyNumMap = {}

	for i, info in ipairs(serverItemInfos) do
		buyNumMap[info.id] = info.num
	end

	local items = {}

	for j, shopItemID in ipairs(shopData.exchgid or {}) do
		local item = self:_createItemInfo(shopID, shopItemID, buyNumMap[shopItemID], CurAvatar:getTimeCounter(Const.TimeTICounterTypeShop, shopItemID), j)

		if item then
			table.insert(items, item)
		end

		buyNumMap[shopItemID] = nil
	end

	for k, info in pairs(serverItemInfos) do
		if buyNumMap[info.id] then
			local item = self:_createItemInfo(shopID, info.id, info.num, CurAvatar:getTimeCounter(Const.TimeTICounterTypeShop, info.id), info.id)

			if item then
				table.insert(items, item)
			end
		end
	end

	self.allItems = items

	self:getActivityShopItem()
	self:_refreshAllItems(true)
	self.scrollItems:setTotalCount(#self.allItems)
end

function CommonAndActShopPanel:getActivityShopItem()
	if self.actObj then
		local actShopItems = self.actObj.actData:getCurShopItem()

		for i, shopItem in ipairs(actShopItems or {}) do
			shopItem:setBoughtNum(self.actObj.actData:getHasBuyNum(shopItem.id))

			shopItem.isActShopItem = true

			table.insert(self.allItems, shopItem)
		end
	end
end

function CommonAndActShopPanel:_createItemInfo(shopID, shopItemID, hasBoughtNum, tick, sortIdx)
	local shopData = ResShopExchg[shopItemID]

	if shopData then
		if shopData.condition_id and ConditionLimitManager.inLimitState(shopData.condition_id) then
			return nil
		end

		local shopItem = ShopItem(shopID, shopItemID, hasBoughtNum, tick)

		if not shopItem:isInHide() then
			shopItem.skinSortId = 0

			if shopItem.object.isSkin and shopItem.object:isSkin() == true then
				if shopItem.object:isGet() then
					shopItem.skinSortId = 2
				else
					shopItem.skinSortId = 1
				end
			end

			shopItem.sortIdx = sortIdx

			return shopItem
		end
	end
end

function CommonAndActShopPanel:_refreshAllItems(refreshUI)
	for i, item in ipairs(self.allItems or {}) do
		self:_refreshItem(item, refreshUI)
	end

	self:_sortItems()
end

function CommonAndActShopPanel:_refreshItem(item, refreshUI)
	item:updateState()

	if refreshUI then
		self:_refreshCell(item)
	end
end

function CommonAndActShopPanel:_refreshCell(item)
	for i, cell in pairs(self.cells) do
		if cell.item == item then
			cell:setData(item)
		end
	end
end

function CommonAndActShopPanel:_sortItems()
	if self.allItems then
		table.sort(self.allItems, function(itemA, itemB)
			itemA.indexPriority = itemA.indexPriority or 0
			itemB.indexPriority = itemB.indexPriority or 0

			if itemA:isLocked() ~= itemB:isLocked() then
				return not itemA:isLocked()
			elseif itemA.isActShopItem ~= itemB.isActShopItem then
				return itemA.isActShopItem == true
			elseif itemA.indexPriority and itemB.indexPriority and itemA.indexPriority ~= itemB.indexPriority then
				return itemA.indexPriority > itemB.indexPriority
			elseif itemA.sortIdx and itemB.sortIdx then
				return itemA.sortIdx < itemB.sortIdx
			end
		end)
	end
end

function CommonAndActShopPanel:updateItem(serverItemInfo)
	for idx, item in ipairs(self.allItems) do
		if item.id == serverItemInfo.id then
			local hasBoughtNum = serverItemInfo.num

			item:setBoughtNum(hasBoughtNum)
			self:_refreshAllItems(true)

			break
		end
	end
end

function CommonAndActShopPanel:_checkRecoverTimer()
	local minTick

	for idx, item in ipairs(self.allItems) do
		local curTick = item:getRecoverTick()

		if curTick ~= nil and (minTick == nil or curTick < minTick) then
			minTick = curTick
		end
	end

	if minTick ~= nil then
		self:_startRecoverTimer(minTick + 1)
	else
		self._recoverTimer:Stop()
	end
end

function CommonAndActShopPanel:_startRecoverTimer(tick)
	self._recoverTimer:Setting(self._recoverTimer.func, tick, false)
	self._recoverTimer:Restart()
end

function CommonAndActShopPanel:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = self.cellClass(sender, self.subCellPrefab, newIdx, 452, 148)

		if targetCell.setQualityAtlsPath and self.shopCellImgAtlsPath then
			targetCell:setQualityAtlsPath(self.shopCellImgAtlsPath)
		end

		targetCell.mEventClick = self._slot4CellClick
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	local item = self.allItems[newIdx]

	targetCell:setData(item)
end

function CommonAndActShopPanel:_onShopItemClick(item)
	if item.object.isSkin and item.object:isSkin() and item.object:isGet() and item.object.clientData then
		local skinData = item.object.clientData
		local skinPreviewTips = UIManager.getUI("skinPreviewTips")

		skinPreviewTips:setObject(skinData, item.object, self)

		return
	end

	if not item:canBuy() then
		local hint = item:getClickHint()

		if hint ~= nil then
			MsgManager.notice(hint)
		end
	elseif item.object.isSkin and item.object:isSkin() then
		local ui = UIManager.getUI("skinBuyBox")

		if item.isActShopItem then
			ui:showShopItem(item, self, Slot(self.onBuyCB, self))
		else
			ui:showShopItem(item, self)
		end

		ui:bindWindow(self)
	else
		local ui = UIManager.getUI("shopBuyBox")

		if item.isActShopItem then
			ui:showShopItem(item, self, Slot(self.onBuyCB, self))
		else
			ui:showShopItem(item, self)
		end

		ui:bindWindow(self)
	end
end

function CommonAndActShopPanel:onBuyCB(exchgid, count)
	self.uiBox = nil

	RPC.opActGetAward(self.actObj.opId, exchgid, count)
end

function CommonAndActShopPanel:refreshData()
	for idx, item in ipairs(self.allItems or {}) do
		if item.isActShopItem then
			item:setBoughtNum(self.actObj.actData:getHasBuyNum(item.id))
		end
	end

	self:_refreshAllItems(true)
end

function CommonAndActShopPanel:updateActivityData()
	self:refreshData()
end

function CommonAndActShopPanel:onClosePanel()
	if self.uiBox and self.uiBox:getVisible() then
		self.uiBox:onBoxClose()
	end

	CommonAndActShopPanel.super.onClosePanel(self)
end

return CommonAndActShopPanel
