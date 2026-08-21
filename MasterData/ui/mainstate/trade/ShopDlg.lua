-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\ShopDlg.lua

local EventCenter = EventCenter
local EventConst = require("EventConst")
local ResShop = require("ClientData/ResShop")
local ResShopExchg = require("ClientData/ResShopExchg")
local ResColor = require("ClientData/ResColor")
local ShopUtils = require("UI/MainState/Trade/ShopUtils")
local ShopItem = require("UI/MainState/Trade/ShopItem")
local ResShopRandLib = require("ClientData/ResShopRandLib")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local WelfarePanelBase = require("UI/Welfare/WelfarePanelBase")
local ResShopRefreshCost = require("ClientData/ResShopRefreshCost")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local ResItem = require("ClientData/ResItem")
local ConsumeTips = require("System/ConsumeTips")
local ResShopItemGroup = require("ClientData/ResShopItemGroup")
local PAGE_SHOP = {
	1,
	2,
	3,
	4,
	5
}
local UIControls = UIControls
local strClassName = "ShopDlg"
local ShopDlg = Class(strClassName, WelfarePanelBase)
local REFRESH_TYPE_PERSONAL = 1
local REFRESH_TYPE_SYSTEM = 2
local CAN_REFRESH = 1
local CANT_REFRESH

function ShopDlg:ctor()
	self.curShopID = nil
	self._curItems = {}
	self._shopInfos = {}
	self._slot4CellClick = Slot(self._onShopItemClick, self)
	self._recoverTimer = Timer.New(Slot(self._onRecoverTickFinish, self), 1)
	self._timerUpdate = Timer.New(Slot(self.onTimeUpdate, self), 0.5, -1)

	self:initUI()
end

function ShopDlg:initUI(panelFund, shopTabs)
	self.scrollItems = UIControls.ScrollViewLoopV(self, "ItemList", 0, self._onCellChanged)
	self.btnRefresh = UIControls.Button(self, "BtnRefresh")

	self.btnRefresh:addEventClick(self.onRefreshClick)

	self.txtTime = UIControls.Label(self, "TipsPanel/TextTime")
	self.txtCondition = UIControls.Label(self, "TipsPanel/TextCondition")

	self.txtCondition:setVisible(true)

	if self.mWindow.tabTypeConfig[Const.SHOP_TYPE_HOUSE] == true then
		self.isHouseShop = true
		self.txtHousePutDesc = UIControls.Label(self, "TextSurplusTitle")
		self.txtHousePutNum = UIControls.Label(self, "TextSurplusTitle/TextNum")
		self.imgHouseIcon = UIControls.Image(self, "TextSurplusTitle/Icon")
	end

	self.cells = {}

	self:initShopClientData()
end

function ShopDlg:initShopClientData()
	self.shopGroupList = {}

	for id, data in pairs(ResShop) do
		if not self.shopGroupList[data.show_group] then
			self.shopGroupList[data.show_group] = {}
		end

		table.insert(self.shopGroupList[data.show_group], data.id)
		table.sort(self.shopGroupList[data.show_group])
	end
end

function ShopDlg:onDestroy()
	self._recoverTimer:Stop()

	if self._timerUpdate then
		self._timerUpdate:Stop()
	end
end

function ShopDlg:initPanel()
	self.subCellPrefab = "System/Common/Grid/" .. self.panelConfigData.subCellPrefab or "System/Common/Grid/GridStoreItem"

	if self.panelConfigData.subCellPrefab == "GridBackyardStoreItem" then
		self.cellClass = UIConst.RearHouseShopCellLoop
	elseif self.panelConfigData.subCellPrefab == "GridSkinItem" then
		self.cellClass = UIConst.SkinShopCellLoop
	else
		self.cellClass = UIConst.ShopCellLoop
	end
end

function ShopDlg:onOpenPanel()
	self.btnRefresh:setVisible(false)

	local shopShowGroup = self.panelConfigData.arg1
	local shops = self.shopGroupList[shopShowGroup]
	local shopID = shops[1]

	self.limitTxt = ""

	if #shops > 1 then
		table.sort(shops)

		for _, exclusiveShopId in ipairs(shops) do
			local exclusiveShopData = ResShop[exclusiveShopId]

			if not ConditionLimitManager.inLimitState(exclusiveShopData.condition_id) then
				shopID = exclusiveShopId
			else
				self.limitTxt = ResConditionLimit[exclusiveShopData.condition_id].unlock_desc

				break
			end
		end
	end

	self.txtCondition:setText(self.limitTxt or "")

	self.curShopID = shopID

	self.scrollItems:setTotalCount(0)
	self:_checkHousePutTip()
	RPC.shopEnter(self.curShopID)
end

function ShopDlg:onShopEnterResp(shopID, serverItemInfos)
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
		local item = self:_createItemInfo(shopID, shopItemID, buyNumMap[shopItemID], curAvatar:getTimeCounter(Const.TimeTICounterTypeShop, shopItemID), j)

		if item then
			table.insert(items, item)
		end

		buyNumMap[shopItemID] = nil
	end

	for k, info in pairs(serverItemInfos) do
		if buyNumMap[info.id] then
			local item = self:_createItemInfo(shopID, info.id, info.num, curAvatar:getTimeCounter(Const.TimeTICounterTypeShop, info.id), info.id)

			if item then
				table.insert(items, item)
			end
		end
	end

	self.curShopGroupRandId = nil
	self.shopRandData, self.refreshData = CurAvatar:getShopRandData()

	if self.shopRandData[shopID] then
		local shopGroupRandId = self.shopRandData[shopID].group_index
		local groupIds = shopData.refresh_item_group or {}

		if shopGroupRandId and groupIds[shopGroupRandId] then
			self.curShopGroupRandId = groupIds[shopGroupRandId]
		end
	end

	self._curItems = items

	self:_refreshAllItems(true)
	self.scrollItems:setTotalCount(#self._curItems)
	self:panelTop()

	if shopData.refresh_period_type and shopData.refresh_period_rate then
		self.txtTime:setVisible(true)
		self:setRefreshInfo(shopData)
	else
		self:setRefreshInfo(shopData)
		self.txtTime:setVisible(false)

		if self._timerUpdate then
			self._timerUpdate:Stop()
		end
	end
end

function ShopDlg:_checkHousePutTip(...)
	if self.isHouseShop == true then
		local typeId = self.panelConfigData.arg3

		if typeId ~= nil then
			self.txtHousePutDesc:setVisible(true)

			local name, num = RearHouseCommon.getNameAndLimitNumByType(typeId)

			if RearHouseCommon.isWeightType(typeId) then
				self.txtHousePutDesc:setText(Lang.get(30554))
			else
				self.txtHousePutDesc:setText(string.format(Lang.get(30551), name))
			end

			self.txtHousePutNum:setText(num)

			local iconName = self.panelConfigData.iconName or "Default"

			self.imgHouseIcon:setImage("Atlas/BackyardAtlas/BackyardAtlas", "IconEditTab0" .. typeId)
		else
			self.txtHousePutDesc:setVisible(false)
		end
	end
end

function ShopDlg:setRefreshInfo(shopData)
	if not shopData then
		self.btnRefresh:setVisible(false)

		return
	end

	self.shopRandData, self.shopRefreshData = CurAvatar:getShopRandData()

	if shopData.refresh_type and shopData.refresh_type == REFRESH_TYPE_SYSTEM then
		self.btnRefresh:setVisible(false)
	elseif shopData.refresh_self_enable and shopData.refresh_self_enable == 1 then
		self.btnRefresh:setVisible(true)
	else
		self.btnRefresh:setVisible(false)
	end

	if self.shopRandData and self.shopRandData[self.curShopID] then
		self.timeUpdate = self.shopRandData[self.curShopID].next_refresh_time
	end

	if self._timerUpdate then
		self._timerUpdate:Restart()
	end

	self:onTimeUpdate()
end

function ShopDlg:updateItem(serverItemInfo)
	for idx, item in ipairs(self._curItems) do
		if item.id == serverItemInfo.id then
			local hasBoughtNum = serverItemInfo.num

			item:setBoughtNum(hasBoughtNum)
			self:_refreshAllItems(true)

			break
		end
	end
end

function ShopDlg:onTimeUpdate()
	if self.timeUpdate == nil then
		return
	end

	local timeLeft = self.timeUpdate - ClientUtils.getServerTime()

	if timeLeft < 0 then
		self.timeUpdate = self.timeUpdate + 86400

		RPC.shopEnter(self.curShopID)
	end

	local txtTime

	txtTime = utils.calcTimeTxt(timeLeft)

	local timeStr = utils.getColorfulStr(txtTime, ResColor.ORANGEBTN)
	local preCampStr = ""

	if self.curShopGroupRandId then
		local shopGroupData = ResShopItemGroup[self.curShopGroupRandId] or {}

		if shopGroupData[1] then
			preCampStr = string.format(Lang.get(32779), utils.getColorfulStr(shopGroupData[1].pre_camp, ResColor.ORANGEBTN))
		end

		local showStr = string.format(Lang.get(32780), timeStr, preCampStr)

		self.txtTime:setText(showStr)
	else
		self.txtTime:setText(string.format(Lang.get(30552), timeStr))
	end
end

function ShopDlg:_startRecoverTimer(tick)
	self._recoverTimer:Setting(self._recoverTimer.func, tick, false)
	self._recoverTimer:Restart()
end

function ShopDlg:_onRecoverTickFinish()
	RPC.shopEnter(self.curShopID)
end

function ShopDlg:_checkRecoverTimer()
	local minTick

	for idx, item in ipairs(self._curItems) do
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

function ShopDlg:_createItemInfo(shopID, shopItemID, hasBoughtNum, tick, sortIdx)
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

function ShopDlg:_sortItems()
	table.sort(self._curItems, function(itemA, itemB)
		itemA.indexPriority = itemA.indexPriority or 0
		itemB.indexPriority = itemB.indexPriority or 0

		if itemA:isLocked() ~= itemB:isLocked() then
			return not itemA:isLocked()
		elseif itemA.skinSortId ~= itemB.skinSortId then
			return itemA.skinSortId < itemB.skinSortId
		elseif itemA.indexPriority and itemB.indexPriority and itemA.indexPriority ~= itemB.indexPriority then
			return itemA.indexPriority > itemB.indexPriority
		elseif itemA.sortIdx and itemB.sortIdx then
			return itemA.sortIdx < itemB.sortIdx
		end
	end)
end

function ShopDlg:_refreshAllItems(refreshUI)
	local playerLevel = CurAvatar:getLevel()

	for i, item in ipairs(self._curItems) do
		self:_refreshItem(item, false)
	end

	self:_sortItems()

	if refreshUI then
		self.scrollItems:refreshCells()
	end

	self:_checkRecoverTimer()
end

function ShopDlg:refreshCells(...)
	self.scrollItems:refreshCells()
end

function ShopDlg:_refreshItem(item, refreshUI)
	item:updateState()

	if refreshUI then
		self:_refreshCell(item)
		self:_checkRecoverTimer()
	end
end

function ShopDlg:_onShopItemClick(item)
	if not item:canBuy() then
		local hint = item:getClickHint()

		if hint ~= nil then
			MsgManager.notice(hint)
		end
	elseif item.object.isSkin and item.object:isSkin() then
		local ui = UIManager.getUI("skinBuyBox")

		ui:showShopItem(item, self)
		ui:bindWindow(self)
	else
		local ui = UIManager.getUI("shopBuyBox")

		ui:showShopItem(item, self)
		ui:bindWindow(self)
	end
end

function ShopDlg:onRefreshClick()
	self.shopRandData, self.shopRefreshData = CurAvatar:getShopRandData()

	if self.shopRefreshData == nil or self.shopRandData == nil then
		return
	end

	local refreshShopTab = ResShopRefreshCost[self.curShopData.refresh_price_id]
	local maxTimes = refreshShopTab[#refreshShopTab].refresh_time
	local curRefreshData = self.shopRefreshData[self.curShopID]
	local timesSpand = curRefreshData and curRefreshData.buy_count or 0
	local timesLeft = maxTimes - timesSpand

	self.curRefreshTimesSpand = timesSpand
	self.curRefreshTimesLeft = timesLeft

	if maxTimes < 99999 and (not (timesLeft > 0) or self.timeUpdate == nil) then
		local time = self.timeUpdate - ClientUtils.getServerTime()
		local timeStr = ""

		timeStr = utils.calcTimeTxt(time)

		MsgManager.notice(string.format(Lang.get(30553), timeStr))

		return
	end

	local curTimeInfo

	for _, info in ipairs(refreshShopTab) do
		if info.refresh_time >= timesSpand + 1 then
			curTimeInfo = info

			break
		end
	end

	if curTimeInfo == nil then
		curTimeInfo = refreshShopTab[1]
	end

	local refreshInfo = curTimeInfo

	self.curRefreshInfo = refreshInfo

	local costId = refreshInfo.cost_id
	local costCount = refreshInfo.cost_count
	local constInfo = ResItem[costId] or ""
	local cfmBox = UIManager.getUI("confirmui")

	if maxTimes < 99999 then
		local refeshTipStr = Lang.get(32781)

		if self.curShopData.show_type == Const.SHOP_ENTER_TYPE_MAZE then
			refeshTipStr = ""
		end

		local tipStr = string.format(Lang.get(32782), "<color=#fd8713>" .. costCount .. "</color>", constInfo.name, refeshTipStr, "<color=#fd8713" .. ">" .. timesLeft .. "</color>")
		local strPre
		local strNext = Lang.get(30556)

		if RegionUtils.isCurrentLanguage(RegionConst.LANGUAGE_ENG) then
			strPre = Lang.get(30556)
			strNext = nil
		end

		cfmBox:show(UIConst.CONFIRM_TWOBTN, Lang.get(5), tipStr, Functor(self.showTips, self, costCount))
		cfmBox:startContentTimer(strPre, strNext, self.timeUpdate, Slot(self.onBoxTimerFinish, self))
	else
		local tipStr = string.format(Lang.get(30557), costCount, constInfo.name)

		cfmBox:show(UIConst.CONFIRM_TWOBTN, Lang.get(5), tipStr, Functor(self.showTips, self, costCount))
	end
end

function ShopDlg:showTips(costCount)
	if self.curRefreshInfo.cost_id == Const.MONEY_ID_DIAMOND or self.curRefreshInfo.cost_id == Const.MONEY_ID_FAKE_DIAMOND then
		ConsumeTips.showTipsDiamond(costCount, Const.CONSUME_DIAMOND_REFRESH_SHOP, 1, Slot(self.goRefresh, self))
	else
		self:goRefresh()
	end
end

function ShopDlg:onBoxTimerFinish()
	local time = self.timeUpdate - ClientUtils.getServerTime()
	local periodStr = ""

	if self.curShopData and self.curShopData.refresh_period_type then
		if self.curShopData.refresh_period_type == 1 then
			periodStr = Lang.get(30558)
		elseif self.curShopData.refresh_period_type == 2 then
			periodStr = Lang.get(30559)
		elseif self.curShopData.refresh_period_type == 3 then
			periodStr = Lang.get(16)
		end
	end

	local str = string.format(Lang.get(30560), periodStr)

	UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(5), str)
end

function ShopDlg:goRefresh()
	local function enoughCallback()
		RPC.shopRefresh(self.curShopID, self.curRefreshTimesSpand)
	end

	if self.curRefreshTimesSpand and self.curRefreshTimesSpand >= 0 then
		ClientUtils.checkMoneyChange(self.curRefreshInfo.cost_id, self.curRefreshInfo.cost_count, enoughCallback, nil, true)
	end
end

function ShopDlg:_refreshCell(item)
	for i, cell in pairs(self.cells) do
		if cell.item == item then
			cell:setData(item)
		end
	end
end

function ShopDlg:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = self.cellClass(sender, self.subCellPrefab, newIdx, 452, 148)
		targetCell.mEventClick = self._slot4CellClick
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	local item = self._curItems[newIdx]

	targetCell:setData(item)
end

function ShopDlg:panelTop()
	return
end

function ShopDlg:onNewDay()
	if self.curShopID then
		RPC.shopEnter(self.curShopID)
	end
end

return ShopDlg
