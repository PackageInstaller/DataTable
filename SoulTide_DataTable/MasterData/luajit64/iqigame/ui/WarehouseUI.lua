-- chunkname: @IQIGame\\UI\\WarehouseUI.lua

local WarehouseUI = Base:Extend("WarehouseUI", "IQIGame.Onigao.UI.WarehouseUI", {
	CurrentTabIndex = -1,
	ItemCells = {},
	tabIndexValue = {}
})
local BagItemCell = require("IQIGame.UI.Bag.BagItemCell")
local ItemTipController = require("IQIGame.UI.Tips.ItemTipController")

function WarehouseUI:OnInit()
	function self.DelegateOnClickClose()
		self:OnClickClose()
	end

	function self.DelegateOnUpdateItem()
		self:OnUpdateItem()
	end

	function self.DelegateOnClickTab(isOn)
		self:OnClickTab(isOn)
	end

	function self.DelegateOnClickItemDebtBtn()
		self:OnClickItemDebtBtn()
	end

	self:InitCurrencyModule()

	self.EnergyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)

	self:InitTabs()

	local scrollAreaList = self.BagGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderItemCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectedItemCell(cell)
	end

	self.ItemTipController = ItemTipController.New(self.TipContent)
	self.ItemTipController.showJewelryNode = true

	UGUIUtil.SetText(self.TitleText, WarehouseUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.EmptyView, WarehouseUIApi:GetString("EmptyViewText"))
end

function WarehouseUI:GetPreloadAssetPaths()
	return {
		AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")
	}
end

function WarehouseUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WarehouseUI:OnOpen(userData)
	self.Tabs[1]:GetComponent("Toggle").isOn = true

	self:ShowTab(1)
	self:CheckRedPoint()
	self.DebtBtn:SetActive(PlayerModule.HasItemDebt())
end

function WarehouseUI:OnClose(userData)
	return
end

function WarehouseUI:OnAddListeners()
	self.ItemTipController:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClose)
	self.DebtBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickItemDebtBtn)

	local toggle

	for i = 1, #self.Tabs do
		toggle = self.Tabs[i]:GetComponent("Toggle")

		toggle.onValueChanged:AddListener(self.DelegateOnClickTab)
	end

	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function WarehouseUI:OnRemoveListeners()
	self.ItemTipController:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClose)
	self.DebtBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickItemDebtBtn)

	local toggle

	for i = 1, #self.Tabs do
		toggle = self.Tabs[i]:GetComponent("Toggle")

		toggle.onValueChanged:RemoveListener(self.DelegateOnClickTab)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function WarehouseUI:OnPause()
	return
end

function WarehouseUI:OnResume()
	return
end

function WarehouseUI:OnCover()
	return
end

function WarehouseUI:OnReveal()
	return
end

function WarehouseUI:OnRefocus(userData)
	return
end

function WarehouseUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WarehouseUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WarehouseUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WarehouseUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WarehouseUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	local currencyCell

	for i = 1, #self.CurrencyControllers do
		currencyCell = self.CurrencyControllers[i]

		currencyCell:Dispose()
	end

	self.EnergyCell:Dispose()

	self.EnergyCell = nil

	for gameObject, itemCell in pairs(self.ItemCells) do
		itemCell:Dispose()
	end

	self.ItemCells = nil

	self.ItemTipController:Dispose()
end

function WarehouseUI:InitTabs()
	self.tabIndexValue = {
		0,
		Constant.ItemTab.GIFT,
		Constant.ItemTab.SOUL,
		Constant.ItemTab.MATERIAL,
		Constant.ItemTab.Jewelry,
		Constant.ItemTab.OTHER
	}

	local tabTexts = WarehouseUIApi:GetString("TabTexts")

	self.Tabs = {}
	self.TabRedPoints = {}

	for i = 1, #self.tabIndexValue do
		local tabBtn = UnityEngine.Object.Instantiate(self.TogglePrefab)

		tabBtn:GetComponent("ToggleHelperComponent").text = tabTexts[i]

		tabBtn.transform:SetParent(self.TabGroup.transform, false)

		self.Tabs[i] = tabBtn
		self.TabRedPoints[i] = {}
		self.TabRedPoints[i][1] = tabBtn.transform:Find("On/RedPoint").gameObject
		self.TabRedPoints[i][2] = tabBtn.transform:Find("Off/RedPoint").gameObject
	end
end

function WarehouseUI:OnUpdateItem()
	self:ShowTab(self.CurrentTabIndex, true)
	self:CheckRedPoint()
end

function WarehouseUI:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.UIController:GetCurrentTarget()

		for i = 1, #self.Tabs do
			if self.Tabs[i] == currentTarget then
				self:ShowTab(i)

				return
			end
		end
	end
end

function WarehouseUI:ShowTab(tabIndex, onlyUpdateData)
	self.CurrentTabIndex = tabIndex

	self.ItemTipController.View:SetActive(false)

	local itemTabs

	if tabIndex == 1 then
		itemTabs = {}

		for i = 1, #self.Tabs - 1 do
			table.insert(itemTabs, i)
		end
	else
		itemTabs = {
			self.tabIndexValue[tabIndex]
		}
	end

	self.ItemDataList = self:FilterNotShow(WarehouseModule.GetItemsByTabs(itemTabs, true))

	if tabIndex == 5 then
		table.sort(self.ItemDataList, function(a, b)
			if a.jewelryData and b.jewelryData and a.jewelryData.newJewelryEquipmentVoPOD.star ~= b.jewelryData.newJewelryEquipmentVoPOD.star then
				return a.jewelryData.newJewelryEquipmentVoPOD.star > b.jewelryData.newJewelryEquipmentVoPOD.star
			end

			return a:GetCfg().Sort > b:GetCfg().Sort
		end)
	else
		table.sort(self.ItemDataList, function(itemData1, itemData2)
			return itemData1:GetCfg().Sort < itemData2:GetCfg().Sort
		end)
	end

	local dataLength = #self.ItemDataList
	local scrollAreaList = self.BagGrid:GetComponent("ScrollAreaList")

	if onlyUpdateData then
		local selectIndex = -1

		if dataLength > 0 then
			for i = 1, dataLength do
				local itemData = self.ItemDataList[i]

				if itemData.id == self.ItemTipController.itemData.id then
					selectIndex = i
				end
			end
		end

		local finalSelectIndex = selectIndex

		if finalSelectIndex == -1 then
			finalSelectIndex = 1
		end

		scrollAreaList.defaultSelectedToggle = finalSelectIndex - 1

		scrollAreaList:RenderCellsDynamic(dataLength)

		if selectIndex ~= -1 then
			self:ShowTipView(finalSelectIndex)
		end
	else
		scrollAreaList.defaultSelectedToggle = 0

		scrollAreaList:Refresh(dataLength)
	end

	self.EmptyView:SetActive(dataLength == 0)
end

function WarehouseUI:FilterNotShow(items)
	local result = {}

	for i = 1, #items do
		local itemData = items[i]
		local cfgItemData = itemData:GetCfg()

		if cfgItemData.Type ~= Constant.ItemType.Equip then
			table.insert(result, itemData)
		end
	end

	return result
end

function WarehouseUI:OnRenderItemCell(cell)
	local itemData = self.ItemDataList[cell.index + 1]
	local itemCell = self.ItemCells[cell.gameObject]

	if itemCell == nil then
		itemCell = BagItemCell.New(cell.gameObject)
		self.ItemCells[cell.gameObject] = itemCell
	end

	itemCell:SetItem(itemData)
end

function WarehouseUI:OnSelectedItemCell(cell)
	self:ShowTipView(cell.index + 1)
end

function WarehouseUI:ShowTipView(itemIndex)
	local itemData = self.ItemDataList[itemIndex]

	self.ItemTipController.View:SetActive(true)
	self.ItemTipController:SetData(itemData, false, false)
end

function WarehouseUI:InitCurrencyModule()
	self.CurrencyControllers = {}

	self:AddCurrencyModule(Constant.ItemID.MONEY)
	self:AddCurrencyModule(Constant.ItemID.TREASURE)
end

function WarehouseUI:AddCurrencyModule(currencyCid)
	local container = self.CurrencyContainer.transform
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(container, false)

	self.CurrencyControllers[#self.CurrencyControllers + 1] = CurrencyCell.New(currencyModule, currencyCid)
end

function WarehouseUI:OnClickClose()
	UIModule.CloseSelf(self)
end

function WarehouseUI:CheckRedPoint()
	local needCheckRedPointTabs = {
		Constant.ItemTab.GIFT
	}
	local showRedPointInAllTab = false
	local redPointGroup

	for i = 2, #self.TabRedPoints do
		local targetTabHasItem = false
		local tabValue = self.tabIndexValue[i]

		if table.indexOf(needCheckRedPointTabs, tabValue) ~= -1 then
			targetTabHasItem = WarehouseModule.TabNeedShowRedPoint(tabValue)

			if targetTabHasItem then
				showRedPointInAllTab = true
			end
		end

		redPointGroup = self.TabRedPoints[i]

		for j = 1, #redPointGroup do
			redPointGroup[j]:SetActive(targetTabHasItem)
		end
	end

	redPointGroup = self.TabRedPoints[1]

	for i = 1, #redPointGroup do
		redPointGroup[i]:SetActive(showRedPointInAllTab)
	end
end

function WarehouseUI:OnClickItemDebtBtn()
	UIModule.Open(Constant.UIControllerName.ItemDebtTipsUI, Constant.UILayer.UI)
end

return WarehouseUI
