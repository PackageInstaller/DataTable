-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\ActivityShopPanel.lua

local ResShopExchg = require("ClientData/ResShopExchg")
local ShopItem = require("UI/MainState/Trade/ShopItem")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local UIControls = UIControls
local WelfarePanelBase = require("UI/Welfare/WelfarePanelBase")
local classNameStr = "ActivityShopPanel"
local ActivityShopPanel = Class(classNameStr, WelfarePanelBase)

MixinClass(ActivityShopPanel, ActivityPanelMixin)

function ActivityShopPanel:initUI()
	self._slot4CellClick = Slot(self._onShopItemClick, self)
	self.scrollItems = UIControls.ScrollViewLoopV(self, "ItemList", 0, self._onCellChanged)
	self.txtTime = UIControls.Label(self, "TipsPanel/TextTime")
	self.txtCondition = UIControls.Label(self, "TipsPanel/TextCondition")

	self.txtCondition:setVisible(true)

	self.cells = {}
end

function ActivityShopPanel:onOpenPanel(actId, clientTemplateData)
	local CTData, actObj

	if self.panelConfigData then
		self.actId = self.panelConfigData.arg1
		actObj = CurAvatar:getActivityObj(self.actId)
		CTData = actObj.clientTemplateData
		self.relatedActIds = self.panelConfigData.arg4
	else
		self.actId = actId
		actObj = CurAvatar:getActivityObj(self.actId)
		CTData = clientTemplateData
		self.relatedActIds = clientTemplateData.template_args
	end

	for i, actId in ipairs(self.relatedActIds or {}) do
		CurAvatar:addActivityRelated(tonumber(actId), self.mWindow.mUIName, self.actId)
	end

	if actObj then
		self:onShowActivity({
			CTData,
			actObj
		})

		local endStr = Lang.get(48693)

		if clientTemplateData then
			if self.replaceableCellPath and self.replaceableCellPath[1] then
				self.subCellPrefab = "System/Common/Grid/" .. self.replaceableCellPath[1]
			else
				self.subCellPrefab = "System/Common/Grid/GridStoreSkinLotteryItem"
			end

			if self.replaceableCellPath and self.replaceableCellPath[2] then
				self.shopCellImgAtlsPath = self.replaceableCellPath[2]
			end

			endStr = Lang.get(48694)
		end

		ClientTimerManager.AddSecondFormatTickUI(self.txtCondition, actObj:getRemainOpenTime(), false, endStr)
	end
end

function ActivityShopPanel:initPanel()
	if self.panelConfigData then
		self.subCellPrefab = "System/Common/Grid/" .. self.panelConfigData.subCellPrefab or "System/Common/Grid/GridStoreItem"

		if self.panelConfigData.subCellPrefab == "GridBackyardStoreItem" then
			self.cellClass = UIConst.RearHouseShopCellLoop
		elseif self.panelConfigData.subCellPrefab == "GridSkinItem" then
			self.cellClass = UIConst.SkinShopCellLoop
		else
			self.cellClass = UIConst.ShopCellLoop
		end
	else
		self.subCellPrefab = "System/Common/Grid/GridStoreSkinLotteryItem"
		self.cellClass = UIConst.ShopCellLoop
	end
end

function ActivityShopPanel:_setData()
	self:refreshShopItems()
end

function ActivityShopPanel:refreshShopItems(...)
	self._curItems = self.actObj.actData:getCurShopItem()

	for i, actId in ipairs(self.relatedActIds or {}) do
		local actObj = CurAvatar:getActivityObj(tonumber(actId))

		if actObj and actObj:isValid() then
			local items = actObj.actData:getCurShopItem()

			for _, item in ipairs(items) do
				table.insert(self._curItems, item)
			end
		end
	end
end

function ActivityShopPanel:_onShow()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_ACT, self.clientTemplateData.template_id)

	for _, shopItem in ipairs(self._curItems) do
		local actId = shopItem.actId
		local actObj = CurAvatar:getActivityObj(actId)

		shopItem:setBoughtNum(actObj.actData:getHasBuyNum(shopItem.id))

		shopItem.skinSortId = 0

		if shopItem.object.isSkin and shopItem.object:isSkin() == true then
			if shopItem.object:isGet() then
				shopItem.skinSortId = 2
			else
				shopItem.skinSortId = 1
			end
		end
	end

	for index, targetCell in pairs(self.cells) do
		local item = self._curItems[index]

		targetCell:setData(item)
	end

	self:_sortItems()
	self.scrollItems:setTotalCount(#self._curItems, nil, false)
end

function ActivityShopPanel:_sortItems()
	table.sort(self._curItems, function(itemA, itemB)
		itemA.indexPriority = itemA.indexPriority or 0
		itemB.indexPriority = itemB.indexPriority or 0

		if itemA:isLocked() ~= itemB:isLocked() then
			return not itemA:isLocked()
		elseif itemA.indexPriority and itemB.indexPriority and itemA.indexPriority ~= itemB.indexPriority then
			return itemA.indexPriority > itemB.indexPriority
		elseif itemA.id and itemB.id then
			return itemA.id < itemB.id
		end
	end)
end

function ActivityShopPanel:_onCellChanged(sender, targetCell, newIdx)
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

	local item = self._curItems[newIdx]

	targetCell:setData(item)
end

function ActivityShopPanel:_onShopItemClick(item)
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
	else
		local ui = UIManager.getUI("shopBuyBox")

		self.uiBox = ui

		ui:showShopItem(item, self, Slot(self.onBuyCB, self))
		ui:bindWindow(self)
	end
end

function ActivityShopPanel:onBuyCB(exchgid, count)
	local curActObj = CurAvatar:getActivityObj(self.uiBox._curItem.actId)

	self.uiBox = nil

	RPC.opActGetAward(curActObj.opId, exchgid, count)
end

function ActivityShopPanel:refreshData()
	if self.actObj.actData.maxRound and self.actObj.actData.maxRound > 1 and (self.actObj.actData.nowRealRound or 0) > self.nowRealRound then
		self:refreshShopItems()
		self:playAni("ShowStoreItem")
	end

	self:_onShow()
end

function ActivityShopPanel:onClosePanel()
	if self.uiBox and self.uiBox:getVisible() then
		self.uiBox:onBoxClose()
	end

	ActivityShopPanel.super.onClosePanel(self)
end

return ActivityShopPanel
