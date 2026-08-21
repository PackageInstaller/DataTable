-- chunkname: @IQIGame\\UI\\HomeLandFishBagUI.lua

local HomeLandFishBagUI = {
	CurrentTabIndex = -1,
	ItemCells = {}
}

HomeLandFishBagUI = Base:Extend("HomeLandFishBagUI", "IQIGame.Onigao.UI.HomeLandFishBagUI", HomeLandFishBagUI)

local BagItemCell = require("IQIGame.UI.Bag.BagItemCell")
local ItemTipController = require("IQIGame.UI.Tips.ItemTipController")

function HomeLandFishBagUI:OnInit()
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

	function self.DelegateOnClickAllSellBtn()
		self:OnClickAllSellBtn()
	end

	self:InitCurrencyModule()

	self.EnergyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)

	self.EnergyCell.ViewGo:SetActive(false)
	self:InitTabs()

	local scrollAreaList = self.BagGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderItemCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectedItemCell(cell)
	end

	self.ItemTipController = ItemTipController.New(self.TipContent, nil, function(itemData)
		self:FishItemUse(itemData)
	end)

	UGUIUtil.SetText(self.TitleText, HomeLandFishBagUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.EmptyView, HomeLandFishBagUIApi:GetString("EmptyViewText"))
	UGUIUtil.SetText(self.BtnAllSellLabel, HomeLandFishBagUIApi:GetString("BtnAllSellLabel"))
end

function HomeLandFishBagUI:GetPreloadAssetPaths()
	return {
		AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")
	}
end

function HomeLandFishBagUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandFishBagUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandFishBagUI:GetBGM(userData)
	return nil
end

function HomeLandFishBagUI:OnOpen(userData)
	self.Tabs[1]:GetComponent("Toggle").isOn = true

	self:ShowTab(1)
	self:CheckRedPoint()
	self.DebtBtn:SetActive(PlayerModule.HasItemDebt())
end

function HomeLandFishBagUI:OnClose(userData)
	return
end

function HomeLandFishBagUI:OnAddListeners()
	self.ItemTipController:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClose)
	self.DebtBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickItemDebtBtn)
	self.BtnAllSell:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAllSellBtn)

	local toggle

	for i = 1, #self.Tabs do
		toggle = self.Tabs[i]:GetComponent("Toggle")

		toggle.onValueChanged:AddListener(self.DelegateOnClickTab)
	end

	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function HomeLandFishBagUI:OnRemoveListeners()
	self.ItemTipController:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClose)
	self.DebtBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickItemDebtBtn)
	self.BtnAllSell:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAllSellBtn)

	local toggle

	for i = 1, #self.Tabs do
		toggle = self.Tabs[i]:GetComponent("Toggle")

		toggle.onValueChanged:RemoveListener(self.DelegateOnClickTab)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function HomeLandFishBagUI:OnPause()
	return
end

function HomeLandFishBagUI:OnResume()
	return
end

function HomeLandFishBagUI:OnCover()
	return
end

function HomeLandFishBagUI:OnReveal()
	return
end

function HomeLandFishBagUI:OnRefocus(userData)
	return
end

function HomeLandFishBagUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandFishBagUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandFishBagUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandFishBagUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandFishBagUI:OnDestroy()
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

function HomeLandFishBagUI:InitTabs()
	self.itemTabs = {
		{
			{
				Constant.ItemTab.FISH,
				Constant.ItemTab.TREASURE,
				Constant.ItemTab.BAIT,
				Constant.ItemTab.FISHING_GEAR
			},
			{
				40,
				41,
				Constant.ItemSubType.Fish_Bait,
				Constant.ItemSubType.Fish_Net,
				Constant.ItemSubType.Fish_Spear,
				Constant.ItemSubType.Fish_Torpedo,
				Constant.ItemSubType.Fish_Rod
			}
		},
		{
			{
				Constant.ItemTab.FISH
			},
			{
				Constant.ItemSubType.Fish
			}
		},
		{
			{
				Constant.ItemTab.TREASURE
			},
			{
				Constant.ItemSubType.Fish_Sundries
			}
		},
		{
			{
				Constant.ItemTab.BAIT
			},
			{
				Constant.ItemSubType.Fish_Bait
			}
		},
		{
			{
				Constant.ItemTab.FISHING_GEAR
			},
			{
				Constant.ItemSubType.Fish_Net,
				Constant.ItemSubType.Fish_Spear,
				Constant.ItemSubType.Fish_Torpedo,
				Constant.ItemSubType.Fish_Rod
			}
		}
	}

	local tabTexts = HomeLandFishBagUIApi:GetString("TabTexts")

	self.Tabs = {}
	self.TabRedPoints = {}

	for i = 1, #tabTexts do
		local tabBtn = UnityEngine.Object.Instantiate(self.TogglePrefab)

		tabBtn:GetComponent("ToggleHelperComponent").text = tabTexts[i]

		tabBtn.transform:SetParent(self.TabGroup.transform, false)

		self.Tabs[i] = tabBtn
		self.TabRedPoints[i] = {}
		self.TabRedPoints[i][1] = tabBtn.transform:Find("On/RedPoint").gameObject
		self.TabRedPoints[i][2] = tabBtn.transform:Find("Off/RedPoint").gameObject
	end
end

function HomeLandFishBagUI:OnUpdateItem()
	self:ShowTab(self.CurrentTabIndex, true)
	self:CheckRedPoint()
end

function HomeLandFishBagUI:OnClickTab(isOn)
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

function HomeLandFishBagUI:ShowTab(tabIndex, onlyUpdateData)
	self.CurrentTabIndex = tabIndex

	self.ItemTipController.View:SetActive(false)

	local itemTabs = self.itemTabs[tabIndex][1]
	local itemSubTypes = self.itemTabs[tabIndex][2]

	self.ItemDataList = FishingModule.GetFishItems(itemTabs, itemSubTypes)

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

	local isSell = false

	for i, v in pairs(self.ItemDataList) do
		local have = WarehouseModule.GetItemNumByCfgID(v.cid)

		if v:GetCfg().Type == 2 and (v:GetCfg().SubType == 40 or v:GetCfg().SubType == 41) and have > 0 then
			isSell = true

			break
		end
	end

	self.BtnAllSell:SetActive(self.CurrentTabIndex == 1 and isSell)
end

function HomeLandFishBagUI:OnRenderItemCell(cell)
	local itemData = self.ItemDataList[cell.index + 1]
	local itemCell = self.ItemCells[cell.gameObject]

	if itemCell == nil then
		itemCell = BagItemCell.New(cell.gameObject)
		self.ItemCells[cell.gameObject] = itemCell
	end

	itemCell:SetItem(itemData)
end

function HomeLandFishBagUI:OnSelectedItemCell(cell)
	self:ShowTipView(cell.index + 1)
end

function HomeLandFishBagUI:ShowTipView(itemIndex)
	local itemData = self.ItemDataList[itemIndex]

	self.ItemTipController.View:SetActive(true)
	self.ItemTipController:SetData(itemData, false, false)

	if FishingModule.IsFishingUseItem(itemData) then
		self.ItemTipController.goBtnUse:SetActive(true)
		UGUIUtil.SetTextInChildren(self.ItemTipController.goBtnUse, HomeLandFishBagUIApi:GetString("BtnItemUseLabel", itemData:GetCfg().Type, itemData:GetCfg().SubType))
	end
end

function HomeLandFishBagUI:InitCurrencyModule()
	self.CurrencyControllers = {}

	self:AddCurrencyModule(Constant.ItemID.MONEY)
	self:AddCurrencyModule(Constant.ItemID.TREASURE)
	self:AddCurrencyModule(Constant.ItemID.FISH_PATTERN)
	self:AddCurrencyModule(Constant.ItemID.FISH_CONDENSED_STONE)
end

function HomeLandFishBagUI:AddCurrencyModule(currencyCid)
	local container = self.CurrencyContainer.transform
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(container, false)

	self.CurrencyControllers[#self.CurrencyControllers + 1] = CurrencyCell.New(currencyModule, currencyCid)
end

function HomeLandFishBagUI:OnClickClose()
	UIModule.CloseSelf(self)
end

function HomeLandFishBagUI:CheckRedPoint()
	local needCheckRedPointTabs = {
		Constant.ItemTab.FISH
	}
	local showRedPointInAllTab = false
	local redPointGroup

	for i = 2, #self.TabRedPoints do
		local targetTabHasItem = false
		local tab = i - 1

		if table.indexOf(needCheckRedPointTabs, tab) ~= -1 then
			targetTabHasItem = WarehouseModule.TabNeedShowRedPoint(tab)

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

function HomeLandFishBagUI:OnClickAllSellBtn()
	NoticeModule.ShowNotice(21042042, function()
		FishingModule.ExchangeFishByType(-1)
	end, nil)
end

function HomeLandFishBagUI:OnClickItemDebtBtn()
	UIModule.Open(Constant.UIControllerName.ItemDebtTipsUI, Constant.UILayer.UI)
end

function HomeLandFishBagUI:FishItemUse(itemData)
	UIModule.Open(Constant.UIControllerName.UseNumberFishBagUI, Constant.UILayer.Tooltip, itemData)
end

return HomeLandFishBagUI
