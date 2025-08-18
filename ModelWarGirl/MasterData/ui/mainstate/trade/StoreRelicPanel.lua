-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\StoreRelicPanel.lua

local ResShop = require("ClientData/ResShop")
local RelicStoreCellMixin = require("UI/MainState/Trade/RelicStoreCellMixin")
local RelicPkgStoreCellMixin = require("UI/MainState/Trade/RelicPkgStoreCellMixin")
local ShopDlg = require("UI/MainState/Trade/ShopDlg")
local ResShopExchg = require("ClientData/ResShopExchg")
local ShopItem = require("UI/MainState/Trade/ShopItem")
local RelicStoreCellLoop = Class("RelicStoreCellLoop", UIControls.ScrollViewLoopCell)

MixinClass(RelicStoreCellLoop, RelicStoreCellMixin, true)

function RelicStoreCellLoop:ctor()
	self:ctorMixin(true)

	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onCellClick)
end

function RelicStoreCellLoop:onCellClick(sender)
	if self.mEventClick ~= nil then
		self.mEventClick(self.item)
	end
end

local RelicPkgStoreCellLoop = Class("RelicPkgStoreCellLoop", UIControls.ScrollViewLoopCell)

MixinClass(RelicPkgStoreCellLoop, RelicPkgStoreCellMixin, true)

function RelicPkgStoreCellLoop:ctor()
	self:ctorMixin(true)

	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onCellClick)
end

function RelicPkgStoreCellLoop:onCellClick(sender)
	if self.mEventClick ~= nil then
		self.mEventClick(self.item)
	end
end

local strClassName = "StoreRelicPanel"
local StoreRelicPanel = Class(strClassName, ShopDlg)

function StoreRelicPanel:initUI(panelFund, shopTabs)
	self.scrollItems = UIControls.ScrollViewLoopH(self, "ItemListPanel/ItemList", 0, self._onCellChanged)
	self.scrollRelicPkg = UIControls.ScrollViewLoopH(self, "ItemPackListPanel/ItemPackList", 0, self._onPkgCellChanged)
	self.panelScrollRelic = UIControls.Panel(self, "ItemListPanel")
	self.imgItemListArrow = UIControls.Image(self, "ItemListPanel/ImgArrow2")
	self.panelScrollRelicPkg = UIControls.Panel(self, "ItemPackListPanel")
	self.imgPkgListArrow = UIControls.Image(self, "ItemPackListPanel/ImgArrow1")
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.cells = {}
	self.pkgCells = {}
	self._curRelicItems = {}
	self._curRelicPkgItems = {}

	self:initShopClientData()
end

function StoreRelicPanel:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_RELIC_STORE)
end

function StoreRelicPanel:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = RelicStoreCellLoop(sender, "System/Common/Grid/GridStoreRelicItem", newIdx)
		targetCell.mEventClick = self._slot4CellClick
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	local item = self._curRelicItems[newIdx]

	targetCell:setData(item)
end

function StoreRelicPanel:_onPkgCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = RelicPkgStoreCellLoop(sender, "System/Common/Grid/GridStoreRelicPackItem", newIdx)
		targetCell.mEventClick = self._slot4CellClick
	else
		self.pkgCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.pkgCells[newIdx] = targetCell

	local item = self._curRelicPkgItems[newIdx]

	targetCell:setData(item)
end

function StoreRelicPanel:_onShopItemClick(item)
	if not item:canBuy() then
		local hint = item:getClickHint()

		if hint ~= nil then
			MsgManager.notice(hint)
		end
	elseif item.object.itemType == Const.ITEM_TYPE_RELIC then
		if CurAvatar.bagRelics[item.object.id] then
			MsgManager.clientNotice(282)
		else
			local ui = UIManager.getUI("buyRelicConfirmDlg")

			ui:showShopItem(item, self)
			ui:bindWindow(self)
		end
	elseif CurAvatar:isRelicBagCanUse(item.object) then
		local ui = UIManager.getUI("buyRelicPackConfirmDlg")

		ui:showShopItem(item, self)
		ui:bindWindow(self)
	else
		MsgManager.clientNotice(283)
	end
end

function StoreRelicPanel:_sortItems()
	table.sort(self._curRelicPkgItems, function(itemA, itemB)
		itemA.indexPriority = itemA.indexPriority or 0
		itemB.indexPriority = itemB.indexPriority or 0

		if itemA:isLocked() ~= itemB:isLocked() then
			return not itemA:isLocked()
		elseif itemA.isRelicValid ~= itemB.isRelicValid then
			return itemA.isRelicValid > itemB.isRelicValid
		elseif itemA.indexPriority and itemB.indexPriority and itemA.indexPriority ~= itemB.indexPriority then
			return itemA.indexPriority > itemB.indexPriority
		elseif itemA.sortIdx and itemB.sortIdx then
			return itemA.sortIdx < itemB.sortIdx
		end
	end)
	table.sort(self._curRelicItems, function(itemA, itemB)
		itemA.indexPriority = itemA.indexPriority or 0
		itemB.indexPriority = itemB.indexPriority or 0

		if itemA:isLocked() ~= itemB:isLocked() then
			return not itemA:isLocked()
		elseif itemA.isRelicValid ~= itemB.isRelicValid then
			return itemA.isRelicValid > itemB.isRelicValid
		elseif itemA.indexPriority and itemB.indexPriority and itemA.indexPriority ~= itemB.indexPriority then
			return itemA.indexPriority > itemB.indexPriority
		elseif itemA.sortIdx and itemB.sortIdx then
			return itemA.sortIdx < itemB.sortIdx
		end
	end)
end

function StoreRelicPanel:_refreshAllItems(refreshUI)
	for i, item in ipairs(self._curRelicItems) do
		self:_refreshItem(item, false)

		local isHave = CurAvatar.bagRelics and CurAvatar.bagRelics[item.object.id] ~= nil

		item.isRelicValid = (item:isSoldOut() or isHave) and 0 or 1
	end

	for i, item in ipairs(self._curRelicPkgItems) do
		self:_refreshItem(item, false)

		item.isRelicValid = (item:isSoldOut() or not CurAvatar:isRelicBagCanUse(item.object)) and 0 or 1
	end

	self:_sortItems()

	if refreshUI then
		self.scrollItems:refreshCells()
		self.scrollRelicPkg:refreshCells()
	end
end

function StoreRelicPanel:_refreshItem(item, refreshUI)
	item:updateState()

	if refreshUI then
		self:_refreshCell(item)
	end
end

function StoreRelicPanel:_refreshCell(item)
	for i, cell in pairs(self.cells) do
		if cell.item == item then
			cell:setData(item)
		end
	end

	for i, cell in pairs(self.pkgCells) do
		if cell.item == item then
			cell:setData(item)
		end
	end
end

function StoreRelicPanel:onOpenPanel()
	local shopShowGroup = self.panelConfigData.arg1
	local shops = self.shopGroupList[shopShowGroup]
	local shopID = shops[1]

	self.curShopID = shopID

	self.scrollItems:setTotalCount(0)
	self.scrollRelicPkg:setTotalCount(0)
	RPC.shopEnter(self.curShopID)
end

function StoreRelicPanel:onShopEnterResp(shopID, serverItemInfos)
	if shopID ~= self.curShopID then
		return
	end

	local shopData = ResShop[shopID]

	self.curShopData = shopData

	local buyNumMap = {}

	for i, info in ipairs(serverItemInfos) do
		buyNumMap[info.id] = info.num
	end

	local curAvatar = CurAvatar
	local items = {}

	for j, shopItemID in ipairs(shopData.exchgid or {}) do
		local item = self:_createItemInfo(shopID, shopItemID, buyNumMap[shopItemID], curAvatar:getTimeCounter(Const.TimeTICounterTypeShop, shopItemID))

		if item then
			item.sortIdx = j

			table.insert(items, item)
		end

		buyNumMap[shopItemID] = nil
	end

	for k, info in pairs(serverItemInfos) do
		if buyNumMap[info.id] then
			local item = self:_createItemInfo(shopID, info.id, info.num, curAvatar:getTimeCounter(Const.TimeTICounterTypeShop, info.id))

			if item then
				item.sortIdx = info.id

				table.insert(items, item)
			end
		end
	end

	self._curItems = items
	self._curRelicItems = {}
	self._curRelicPkgItems = {}

	for _, shopItem in ipairs(self._curItems) do
		if shopItem.object.itemType == Const.ITEM_TYPE_RELIC then
			local isHave = curAvatar.bagRelics and curAvatar.bagRelics[shopItem.object.id] ~= nil

			shopItem.isRelicValid = (shopItem:isSoldOut() or isHave) and 0 or 1

			table.insert(self._curRelicItems, shopItem)
		else
			shopItem.isRelicValid = (shopItem:isSoldOut() or not curAvatar:isRelicBagCanUse(shopItem.object)) and 0 or 1

			table.insert(self._curRelicPkgItems, shopItem)
		end
	end

	self.panelScrollRelic:setVisible(#self._curRelicItems > 0)
	self.imgItemListArrow:setVisible(#self._curRelicItems > 6)
	self.scrollItems:setTotalCount(#self._curRelicItems)
	self.panelScrollRelicPkg:setVisible(#self._curRelicPkgItems > 0)
	self.imgPkgListArrow:setVisible(#self._curRelicPkgItems > 6)
	self.scrollRelicPkg:setTotalCount(#self._curRelicPkgItems)
	self:_refreshAllItems(true)
end

return StoreRelicPanel
