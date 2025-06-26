-- chunkname: @IQIGame\\UI\\ShopUI.lua

local NPCActionView = require("IQIGame.UI.NPCAction.NPCActionView")
local ShopItemCell = require("IQIGame.UI.Shop.ShopItemCell")
local ShopEquipCell = require("IQIGame.UI.Shop.ShopEquipCell")
local ShopUI = {
	npcGroupId = 0,
	curTabIndex = 1,
	curShopRefreshType = 0,
	shop3ItemContainer = {},
	shop4ItemContainer = {}
}

ShopUI = Base:Extend("ShopUI", "IQIGame.Onigao.UI.ShopUI", ShopUI)

function ShopUI:OnInit()
	self:__OnInitialize()
end

function ShopUI:OnOpen(userData)
	self.tabList:Refresh(#self.shopIds)
end

function ShopUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self:__UpdateNpc(elapseSeconds, realElapseSeconds)
	self:__UpdateShopCountDownTime(elapseSeconds, realElapseSeconds)
end

function ShopUI:OnPause()
	return
end

function ShopUI:OnResume()
	return
end

function ShopUI:OnCover()
	return
end

function ShopUI:OnReveal()
	return
end

function ShopUI:OnRefocus(userData)
	return
end

function ShopUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ShopUI:GetPreloadAssetPaths()
	return nil
end

function ShopUI:GetOpenPreloadAssetPaths(userData)
	return self:__OnPrepareShopData(userData)
end

function ShopUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ShopUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ShopUI:OnClose(userData)
	self:__StopCVTimer()
end

function ShopUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.__btnCloseClickEventProxy)
	self.goBtnRefresh:GetComponent("Button").onClick:AddListener(self.__btnRefreshClickEventProxy)
	EventDispatcher.AddEventListener(EventID.ShopUpdate, self.__shopUpdateEventProxy)
	EventDispatcher.AddEventListener(EventID.BuyShopItemEvent, self.__buyShopItemEventProxy)
	EventDispatcher.AddEventListener(EventID.BatchExchangeSuccess, self.__batchExchangeSuccessEventProxy)
end

function ShopUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.__btnCloseClickEventProxy)
	self.goBtnRefresh:GetComponent("Button").onClick:RemoveListener(self.__btnRefreshClickEventProxy)
	EventDispatcher.RemoveEventListener(EventID.ShopUpdate, self.__shopUpdateEventProxy)
	EventDispatcher.RemoveEventListener(EventID.BuyShopItemEvent, self.__buyShopItemEventProxy)
	EventDispatcher.RemoveEventListener(EventID.BatchExchangeSuccess, self.__batchExchangeSuccessEventProxy)
end

function ShopUI:__OnPrepareShopData(userData)
	local result = {}

	self.shopType = userData[1] == nil and 1 or userData[1]
	self.curTabIndex = userData[2] == nil and 1 or userData[2]
	self.shopIds = {}

	for i, v in pairsCfg(CfgShopTable) do
		if v.Type == self.shopType and ShopModule.CheckExistShop(v.Id) then
			table.insert(self.shopIds, v.Id)

			local cfgActionData = NPCActionModule.GetAction(v.npcGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)
			local npcPath = UIGlobalApi.GetPrefabRoot(cfgActionData.NPC)

			table.insert(result, npcPath)
		end
	end

	table.sort(self.shopIds, function(a, b)
		return a < b
	end)

	return result
end

function ShopUI:__OnInitialize()
	self:__OnPrepareEventProxy()

	self.goTitleText:GetComponent("Text").text = ShopUIApi:GetString("goTitle")
	self.goRefreshTimeDesc:GetComponent("Text").text = ShopUIApi:GetString("goRefreshTimeDesc")
	self.shopRefreshTime = self.goRefreshTime:GetComponent("Text")
	self.costItemImg = self.goCostItemImg:GetComponent("Image")
	self.costItemNumText = self.goCostItemNumText:GetComponent("Text")
	self.goBtnRefreshText:GetComponent("Text").text = ShopUIApi:GetString("goBtnRefreshTxt")
	self.refreshCountText = self.goRefreshCountText:GetComponent("Text")
	self.goPayRefreshBlockTitle:GetComponent("Text").text = ShopUIApi:GetString("RefreshCostTitleTxt")
	self.payRefreshBlockImg = self.goPayRefreshBlockImg:GetComponent("Image")
	self.goMoneyFree.transform:Find("Text_02"):GetComponent("Text").text = ShopUIApi:GetString("MoneyFreeTxt")

	self.goMoneyFree.gameObject:SetActive(false)

	self.goMoneyOver.transform:Find("Text_02"):GetComponent("Text").text = ShopUIApi:GetString("MoneyOverLabTxt")

	self.goMoneyOver.gameObject:SetActive(false)

	self.npcView = NPCActionView.New(self.goNpcView)
	self.tabList = self.goTabList:GetComponent("ScrollAreaList")

	function self.tabList.onRenderCell(cell)
		self:__OnRenderTabEventHandler(cell)
	end

	function self.tabList.onSelectedCell(cell)
		self:__OnSelectTabEventHandler(cell)
	end

	self.shopArea_3 = self.ScrollArea_3:GetComponent("ScrollAreaList")

	function self.shopArea_3.onRenderCell(cell)
		self:__OnRenderArea3CellEventHandler(cell)
	end

	function self.shopArea_3.onSelectedCell(cell)
		self:__OnSelectArea3CellEventHandler(cell)
	end

	self.shopArea_4 = self.ScrollArea_4:GetComponent("ScrollAreaList")

	function self.shopArea_4.onRenderCell(cell)
		self:__OnRenderArea4CellEventHandler(cell)
	end

	function self.shopArea_4.onSelectedCell(cell)
		self:__OnSelectArea4CellEventHandler(cell)
	end
end

function ShopUI:__OnPrepareEventProxy()
	function self.__btnCloseClickEventProxy()
		self:__OnCloseBtnClickEventHandler()
	end

	function self.__btnRefreshClickEventProxy()
		self:__OnBtnRefreshClickEventHandler()
	end

	function self.__shopUpdateEventProxy(shopId)
		self:__OnShopUpdateEventHandler(shopId)
	end

	function self.__buyShopItemEventProxy(shopId)
		self:__OnBuyShopItemEventHandler(shopId)
	end

	function self.__batchExchangeSuccessEventProxy()
		self:__OnBatchExchangeSuccessEventHandler()
	end
end

function ShopUI:__OnCloseBtnClickEventHandler()
	UIModule.Close(Constant.UIControllerName.ShopUI)
end

function ShopUI:__OnBtnRefreshClickEventHandler()
	if self.curShopRefreshType == Constant.ShopRefreshType.Free then
		self:__OnRefreshByFree()
	elseif self.curShopRefreshType == Constant.ShopRefreshType.Item then
		self:__OnRefreshByItem()
	elseif self.curShopRefreshType == Constant.ShopRefreshType.Pay then
		self:__OnRefreshByPay()
	else
		NoticeModule.ShowNoticeNoCallback(21040016)
	end
end

function ShopUI:__OnRenderTabEventHandler(cell)
	local luaIndex = cell.index + 1
	local id = self.shopIds[luaIndex]
	local cfgShopData = CfgShopTable[id]
	local toggle = cell.gameObject:GetComponent("Toggle")

	toggle.transform:Find("goUp/Text_Name_01"):GetComponent("Text").text = ShopUIApi:GetString("goTabName", cfgShopData.Name)
	toggle.transform:Find("goDown/Text_Name_01"):GetComponent("Text").text = ShopUIApi:GetString("goTabName", cfgShopData.Name)
	toggle.isOn = luaIndex == self.curTabIndex
end

function ShopUI:__OnSelectTabEventHandler(cell)
	local luaIndex = cell.index + 1

	self:__ShowTab(luaIndex)
end

function ShopUI:__OnRenderArea3CellEventHandler(cell)
	self:__DoRenderCell(ShopItemCell, self.shop3ItemContainer, cell)
end

function ShopUI:__OnSelectArea3CellEventHandler(cell)
	self:__OnSelectCell(cell, self.shop3ItemContainer)
end

function ShopUI:__OnRenderArea4CellEventHandler(cell)
	self:__DoRenderCell(ShopItemCell, self.shop4ItemContainer, cell)
end

function ShopUI:__OnSelectArea4CellEventHandler(cell)
	self:__OnSelectCell(cell, self.shop4ItemContainer)
end

function ShopUI:__DoRenderCell(class, container, cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local goodsId = self.curShopData.goodsList[luaIndex]

	cell.gameObject.name = "ShopGrid_Mould" .. luaIndex

	local itemCell = container[insID]

	if itemCell == nil then
		itemCell = class.New(cell.gameObject)
		container[insID] = itemCell
	end

	itemCell:Refresh(CfgGoodsTable[goodsId], luaIndex, self.curShopData.cid)
end

function ShopUI:__OnSelectCell(cell, container)
	local insID = cell.gameObject:GetInstanceID()
	local cell = container[insID]

	cell:OnClickBtnBuy()
end

function ShopUI:__OnShopUpdateEventHandler(shopId)
	for _tableIndex, _shopId in ipairs(self.shopIds) do
		if _shopId == shopId then
			self:__ShowTab(_tableIndex)

			break
		end
	end

	UIModule.Close(Constant.UIControllerName.ShopBuyPanelUI)
end

function ShopUI:__OnBuyShopItemEventHandler(shopId)
	local cfgActionData = NPCActionModule.GetAction(self.npcGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.BuyOnShop, self.curShopData.cid)

	if cfgActionData == nil then
		return
	end

	self:__StopCVTimer()
	self.npcView:ShowCV(cfgActionData.CVid)
end

function ShopUI:__OnBatchExchangeSuccessEventHandler()
	self:__ShowTab(self.curTabIndex)
end

function ShopUI:__ShowTab(tabIndex)
	self.curTabIndex = tabIndex

	local shopCid = self.shopIds[self.curTabIndex]
	local cfgShopData = CfgShopTable[shopCid]

	if cfgShopData.ShowType == Constant.ShopShowType.Normal then
		self.curShopArea = self.shopArea_3

		self.ScrollArea_3.gameObject:SetActive(true)
		self.ScrollArea_4.gameObject:SetActive(false)
	elseif cfgShopData.ShowType == Constant.ShopShowType.Maze then
		self.curShopArea = self.shopArea_4

		self.ScrollArea_3.gameObject:SetActive(false)
		self.ScrollArea_4.gameObject:SetActive(true)
	else
		self.curShopArea = nil

		self.ScrollArea_3.gameObject:SetActive(false)
		self.ScrollArea_4.gameObject:SetActive(false)
	end

	self:__RefreshShopItems(true)
	self:__RefreshNpc(cfgShopData.npcGroupId)
	self:__RefreshRefreshBtnState()
	self:__RefreshMoneyView(cfgShopData.ShowCost)
end

function ShopUI:__RefreshMoneyView(showCost)
	local itemId = showCost[1]

	if self.curShowCostId ~= itemId then
		self.curShowCostId = itemId

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[itemId].Icon), self.costItemImg)
	end

	local ownCount = WarehouseModule.GetItemNumByCfgID(itemId)

	self.costItemNumText.text = ShopUIApi:GetString("GetMoneyTxt", ownCount)
end

function ShopUI:__RefreshShopItems(refreshAll)
	if self.curShopArea == nil then
		return
	end

	local shopCid = self.shopIds[self.curTabIndex]

	self.curShopData = ShopModule.GetShopDataByShopId(shopCid)

	if self.curShopData == nil then
		logError("ShopUI can not find itemData with: " .. tostring(shopCid))

		return
	end

	if refreshAll then
		self.curShopArea:Refresh(#self.curShopData.goodsList)
	else
		self.curShopArea:RenderCellsDynamic(#self.curShopData.goodsList)
	end
end

function ShopUI:__UpdateShopCountDownTime(elapseSeconds, realElapseSeconds)
	if self.curShopData == nil then
		self.goRefreshTimeRoot.gameObject:SetActive(false)

		return
	end

	local countDownTime = self.curShopData.nextRefreshTime - PlayerModule.GetServerTime()

	if countDownTime >= 0 then
		self.shopRefreshTime.text = ShopUIApi:GetString("goRefreshTime", countDownTime)

		self.goRefreshTimeRoot.gameObject:SetActive(true)
	else
		self.goRefreshTimeRoot.gameObject:SetActive(false)
	end
end

function ShopUI:__RefreshRefreshBtnState()
	self.curShopRefreshType = Constant.ShopRefreshType.Normal

	if self.curShopData == nil then
		return
	end

	local cfgShopData = CfgShopTable[self.curShopData.cid]
	local result = self:__ShowFreeRefresh(cfgShopData)

	if result then
		self.curShopRefreshType = Constant.ShopRefreshType.Free

		return
	end

	result = self:__ShowCostItemRefresh(cfgShopData)

	if result then
		self.curShopRefreshType = Constant.ShopRefreshType.Item

		return
	end

	result = self:__ShowPayRefresh(cfgShopData)

	if result then
		self.curShopRefreshType = Constant.ShopRefreshType.Pay

		return
	end

	self.refreshCountText.text = ShopUIApi:GetString("GetLastRefreshCountTxt", 0, 0)

	self.goMoneyOver.gameObject:SetActive(true)
	self.goPayRefreshBlock.gameObject:SetActive(false)
	self.goMoneyFree.gameObject:SetActive(false)
	self.goBtnRefresh.gameObject:SetActive(false)
end

function ShopUI:__ShowFreeRefresh(cfgShopData)
	local freeRefreshNum = cfgShopData.FreeRefreshNumber - self.curShopData.freeRefreshCnt

	if freeRefreshNum <= 0 then
		return false
	end

	self.refreshCountText.text = ShopUIApi:GetString("GetLastRefreshCountTxt", cfgShopData.FreeRefreshNumber, self.curShopData.freeRefreshCnt)

	self.goPayRefreshBlock.gameObject:SetActive(false)
	self.goMoneyOver.gameObject:SetActive(false)
	self.goMoneyFree.gameObject:SetActive(true)
	self.goBtnRefresh.gameObject:SetActive(true)

	return true
end

function ShopUI:__OnRefreshByFree()
	ShopModule.SendRefreshMsg(self.curShopData.cid, Constant.ShopRefreshType.Free)
end

function ShopUI:__ShowCostItemRefresh(cfgShopData)
	local itemRefreshNum = cfgShopData.ItemRefreshNumber - self.curShopData.itemRefreshCnt

	if itemRefreshNum <= 0 then
		return false
	end

	self.refreshCountText.text = ShopUIApi:GetString("GetLastRefreshCountTxt", cfgShopData.ItemRefreshNumber, self.curShopData.itemRefreshCnt)

	local costIndex = (self.curShopData.itemRefreshCnt + 1) * 2 - 1

	if costIndex > #cfgShopData.ItemRefreshCost - 1 then
		costIndex = #cfgShopData.ItemRefreshCost - 1
	end

	local itemId = cfgShopData.ItemRefreshCost[costIndex]
	local costNum = cfgShopData.ItemRefreshCost[costIndex + 1]
	local ownNum = WarehouseModule.GetItemNumByCfgID(itemId)

	self.goPayRefreshBlock:SetActive(true)

	local cfgItemData = CfgItemTable[itemId]

	self.goPayRefreshBlockCost:GetComponent("Text").text = ShopUIApi:GetString("goCostNum", costNum, ownNum)

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.payRefreshBlockImg)
	self.goMoneyOver.gameObject:SetActive(false)
	self.goMoneyFree.gameObject:SetActive(false)
	self.goBtnRefresh.gameObject:SetActive(true)

	return true
end

function ShopUI:__OnRefreshByItem()
	ShopModule.SendRefreshMsg(self.curShopData.cid, Constant.ShopRefreshType.Item)
end

function ShopUI:__ShowPayRefresh(cfgShopData)
	local payRefreshNum = cfgShopData.PayRefreshNumber - self.curShopData.payRefreshCnt

	if payRefreshNum <= 0 then
		return false
	end

	self.refreshCountText.text = ShopUIApi:GetString("GetLastRefreshCountTxt", cfgShopData.PayRefreshNumber, self.curShopData.payRefreshCnt)

	local itemId, costNum = self:__GetRefreshByPayCost(cfgShopData)

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[itemId].Icon), self.payRefreshBlockImg)

	self.goPayRefreshBlockCost:GetComponent("Text").text = ShopUIApi:GetString("moneyPayNum", costNum)

	self.goPayRefreshBlock:SetActive(true)
	self.goMoneyOver.gameObject:SetActive(false)
	self.goMoneyFree.gameObject:SetActive(false)
	self.goBtnRefresh.gameObject:SetActive(true)

	return true
end

function ShopUI:__OnRefreshByPay()
	local itemId, costNum = self:__GetRefreshByPayCost()

	if costNum <= WarehouseModule.GetItemNumByCfgID(itemId) then
		ShopModule.SendRefreshMsg(self.curShopData.cid, Constant.ShopRefreshType.Pay)
	else
		NoticeModule.ShowNoticeNoCallback(21040112, CfgItemTable[itemId].Name)
	end
end

function ShopUI:__GetRefreshByPayCost(cfgShopData)
	if cfgShopData == nil then
		cfgShopData = CfgShopTable[self.curShopData.cid]
	end

	local costIndex = (self.curShopData.payRefreshCnt + 1) * 2 - 1

	if costIndex > #cfgShopData.PayRefreshCost - 1 then
		costIndex = #cfgShopData.PayRefreshCost - 1
	end

	local itemId = cfgShopData.PayRefreshCost[costIndex]
	local costNum = cfgShopData.PayRefreshCost[costIndex + 1]

	return itemId, costNum
end

function ShopUI:__UpdateNpc(elapseSeconds, realElapseSeconds)
	if self.npcView == nil then
		return
	end

	self.npcView:Update(elapseSeconds, realElapseSeconds)
end

function ShopUI:__RefreshNpc(npcGroupId)
	self:__StopCVTimer()

	if self.npcGroupId == npcGroupId then
		self:__ShowRandomCV(Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)

		return
	end

	self.npcGroupId = npcGroupId

	local cfgActionData = NPCActionModule.GetAction(self.npcGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)
	local npcPath = UIGlobalApi.GetPrefabRoot(cfgActionData.NPC)
	local goNpc = UnityEngine.GameObject.Instantiate(self.UIController:GetPreloadedAsset(npcPath))

	self.npcView:Refresh(cfgActionData, goNpc, self.npcPath, self.goNpcRoot.transform, cfgActionData.Position, cfgActionData.Scale, cfgActionData.TalkPosition, function()
		self:__OnCVTimerCallback()
	end)
end

function ShopUI:__OnCVTimerCallback()
	self:__StopCVTimer()
	self:__OnCVTimerDelay(ShopUIApi.GetCVDelay())
end

function ShopUI:__OnCVTimerDelay(delay)
	self.cvTimer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.ShopUI, function()
		self:__ShowRandomCV(Constant.NPCTriggerType.Standby)
	end, delay, false)

	self.cvTimer:Start()
end

function ShopUI:__StopCVTimer()
	if self.cvTimer == nil then
		return
	end

	ModuleTimerUtil.StopTimer(self.cvTimer)

	self.cvTimer = nil
end

function ShopUI:__ShowRandomCV(triggerType, triggerParam)
	local cfgActionData = NPCActionModule.GetAction(self.npcGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, triggerType, triggerParam)

	self.npcView:ShowCV(cfgActionData.CVid)
end

function ShopUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.npcView:OnDestroy()
end

return ShopUI
