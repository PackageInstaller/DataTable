-- chunkname: @IQIGame\\UI\\EvilErosionEquipListUI.lua

require("IQIGame.UIExternalApi.EvilErosionEquipListUIApi")

local EvilErosionEquipTipController = require("IQIGame.UI.EvilErosion.EvilErosionEquipTipController")
local EvilErosionEquipCard = require("IQIGame.UI.EvilErosion.EvilErosionEquipCard")
local EvilErosionEquipListUI = {
	SelectedCellIndex = -1,
	Mode = 0,
	IsOpen = false,
	EnhanceMode = false,
	DecomposeMode = false,
	BatchDecomposeN = false,
	SortIsDesc = true,
	QuickMode = false,
	BatchDecomposeSR = false,
	SortType = 0,
	BatchDecomposeR = false,
	OptimizeSort = true,
	EquipCells = {},
	DecomposeSelectItemIds = {}
}

EvilErosionEquipListUI = Base:Extend("EvilErosionEquipListUI", "IQIGame.Onigao.UI.EvilErosionEquipListUI", EvilErosionEquipListUI)

function EvilErosionEquipListUI:OnInit()
	function self.DelegateOnClickCloseTipBtn()
		self:OnClickCloseTipBtn()
	end

	function self.DelegateOnClickBatchDecomposeBtn()
		self:OnClickBatchDecomposeBtn()
	end

	function self.DelegateOnQualityToggleSRValueChanged(isOn)
		self:OnQualityToggleSRValueChanged(isOn)
	end

	function self.DelegateOnQualityToggleRValueChanged(isOn)
		self:OnQualityToggleRValueChanged(isOn)
	end

	function self.DelegateOnQualityToggleNValueChanged(isOn)
		self:OnQualityToggleNValueChanged(isOn)
	end

	function self.DelegateOnEnhanceToggleValueChanged(isOn)
		self:OnEnhanceToggleValueChanged(isOn)
	end

	function self.DelegateOnDecomposeToggleValueChanged(isOn)
		self:OnDecomposeToggleValueChanged(isOn)
	end

	function self.DelegateOnClickSortBtn()
		self:OnClickSortBtn()
	end

	function self.DelegateOnClickClearFilterBtn()
		self:OnClickClearFilterBtn()
	end

	function self.DelegateOnClickFilterBtn()
		self:OnClickFilterBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnUpdateItem(items)
		self:OnUpdateItem(items)
	end

	function self.DelegateOnQuickModeToggleValueChanged(isOn)
		self:OnQuickModeToggleValueChanged(isOn)
	end

	function self.DelegateOnWearingEquipChanged()
		self:OnWearingEquipChanged()
	end

	function self.DelegateOnDecomposeComplete()
		self:OnDecomposeComplete()
	end

	function self.DelegateOnUpgradeStarComplete()
		self:OnUpgradeStarComplete()
	end

	function self.DelegateOnOptimizeSortToggleValueChanged(isOn)
		self:OnOptimizeSortToggleValueChanged(isOn)
	end

	self.EquipTipController = EvilErosionEquipTipController.New(self.TipView, function(isByChangeEquip)
		self.CloseTipBtn:SetActive(false)
		self:ClearAllEquipCellSelect()

		if isByChangeEquip then
			self:Close()
		end
	end)

	self.EquipTipController:Hide()

	local scrollAreaList = self.EquipCellGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderEquipCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnClickEquipCell(cell)
	end

	local toggleText1, toggleText2 = EvilErosionEquipListUIApi:GetString("DecomposeToggleText")
	local toggleHelperComponent = self.DecomposeToggle:GetComponent("ToggleHelperComponent")

	toggleHelperComponent:SetTexts({
		toggleText1,
		toggleText2
	})

	toggleText1, toggleText2 = EvilErosionEquipListUIApi:GetString("EnhanceToggleText")
	toggleHelperComponent = self.EnhanceToggle:GetComponent("ToggleHelperComponent")

	toggleHelperComponent:SetTexts({
		toggleText1,
		toggleText2
	})
	UGUIUtil.SetTextInChildren(self.SortBtn, FormationChooseEquipUIApi:GetString("SortBtnText"))
	UGUIUtil.SetTextInChildren(self.FilterBtn, FormationChooseEquipUIApi:GetString("FilterBtnText"))
	UGUIUtil.SetTextInChildren(self.ClearFilterBtn, FormationChooseEquipUIApi:GetString("ClearFilterBtnText"))

	self.QuickModeToggle:GetComponent("ToggleHelperComponent").text = FormationChooseEquipUIApi:GetString("QuickModeToggleText")

	UGUIUtil.SetText(self.TitleText, EvilErosionEquipListUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.HasItemLabel, EvilErosionEquipListUIApi:GetString("HasItemLabel"))
	UGUIUtil.SetText(self.EnhanceTipText, EvilErosionEquipListUIApi:GetString("EnhanceTipText"))
	UGUIUtil.SetText(self.DecomposeTipText, EvilErosionEquipListUIApi:GetString("DecomposeTipText"))
	UGUIUtil.SetText(self.DecomposeGetItemLabel, EvilErosionEquipListUIApi:GetString("DecomposeGetItemLabel"))
	UGUIUtil.SetTextInChildren(self.BatchDecomposeBtn, EvilErosionEquipListUIApi:GetString("BatchDecomposeBtnText"))

	self.OptimizeSortToggle:GetComponent("ToggleHelperComponent").text = EvilErosionEquipListUIApi:GetString("OptimizeSortToggleText")
end

function EvilErosionEquipListUI:GetPreloadAssetPaths()
	return nil
end

function EvilErosionEquipListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EvilErosionEquipListUI:IsManualShowOnOpen(userData)
	return false
end

function EvilErosionEquipListUI:GetBGM(userData)
	return nil
end

function EvilErosionEquipListUI:OnOpen(userData)
	self.IsOpen = true

	local soulPrefabPOD, curIndex

	if userData ~= nil then
		soulPrefabPOD = userData.soulPrefabPOD
		curIndex = userData.curIndex
	end

	self:UpdateView(soulPrefabPOD, curIndex)
end

function EvilErosionEquipListUI:OnClose(userData)
	self.IsOpen = false
	self.SortType = 0
	self.SortIsDesc = true
	self.FilterPattern = nil
end

function EvilErosionEquipListUI:OnAddListeners()
	self.CloseTipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseTipBtn)
	self.BatchDecomposeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBatchDecomposeBtn)
	self.QualityToggleSR:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnQualityToggleSRValueChanged)
	self.QualityToggleR:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnQualityToggleRValueChanged)
	self.QualityToggleN:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnQualityToggleNValueChanged)
	self.EnhanceToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnEnhanceToggleValueChanged)
	self.DecomposeToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnDecomposeToggleValueChanged)
	self.SortBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSortBtn)
	self.ClearFilterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClearFilterBtn)
	self.FilterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFilterBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.QuickModeToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnQuickModeToggleValueChanged)
	self.OptimizeSortToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnOptimizeSortToggleValueChanged)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.EvilErosionWearingEquipChanged, self.DelegateOnWearingEquipChanged)
	EventDispatcher.AddEventListener(EventID.EvilErosionDecomposeComplete, self.DelegateOnDecomposeComplete)
	EventDispatcher.AddEventListener(EventID.EvilErosionUpgradeStarComplete, self.DelegateOnUpgradeStarComplete)
end

function EvilErosionEquipListUI:OnRemoveListeners()
	self.CloseTipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseTipBtn)
	self.BatchDecomposeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBatchDecomposeBtn)
	self.QualityToggleSR:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnQualityToggleSRValueChanged)
	self.QualityToggleR:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnQualityToggleRValueChanged)
	self.QualityToggleN:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnQualityToggleNValueChanged)
	self.EnhanceToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnEnhanceToggleValueChanged)
	self.DecomposeToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnDecomposeToggleValueChanged)
	self.SortBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSortBtn)
	self.ClearFilterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClearFilterBtn)
	self.FilterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFilterBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.QuickModeToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnQuickModeToggleValueChanged)
	self.OptimizeSortToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnOptimizeSortToggleValueChanged)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.EvilErosionWearingEquipChanged, self.DelegateOnWearingEquipChanged)
	EventDispatcher.RemoveEventListener(EventID.EvilErosionDecomposeComplete, self.DelegateOnDecomposeComplete)
	EventDispatcher.RemoveEventListener(EventID.EvilErosionUpgradeStarComplete, self.DelegateOnUpgradeStarComplete)
end

function EvilErosionEquipListUI:OnPause()
	return
end

function EvilErosionEquipListUI:OnResume()
	return
end

function EvilErosionEquipListUI:OnCover()
	return
end

function EvilErosionEquipListUI:OnReveal()
	return
end

function EvilErosionEquipListUI:OnRefocus(userData)
	return
end

function EvilErosionEquipListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EvilErosionEquipListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EvilErosionEquipListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EvilErosionEquipListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EvilErosionEquipListUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for instanceId, cell in pairs(self.EquipCells) do
		cell:Dispose()
	end

	self.EquipTipController:Dispose()
end

function EvilErosionEquipListUI:OnClickCloseTipBtn()
	self.EquipTipController:Hide()
end

function EvilErosionEquipListUI:OnClickBatchDecomposeBtn()
	local itemIdList = {}
	local needConfirm = false

	for i = 1, #self.DecomposeSelectItemIds do
		local itemId = self.DecomposeSelectItemIds[i]
		local itemData = WarehouseModule.GetItemDataById(itemId)
		local cfgItemData = itemData:GetCfg()

		if cfgItemData.Quality == 5 then
			needConfirm = true
		end

		table.insert(itemIdList, itemId)
	end

	if needConfirm then
		NoticeModule.ShowNotice(21065002, function()
			EvilErosionModule.SendDecomposeEquip(itemIdList)
		end)
	else
		EvilErosionModule.SendDecomposeEquip(itemIdList)
	end
end

function EvilErosionEquipListUI:OnQualityToggleSRValueChanged(isOn)
	self.BatchDecomposeSR = isOn

	self:DecomposeBatchSelectCells()
end

function EvilErosionEquipListUI:OnQualityToggleRValueChanged(isOn)
	self.BatchDecomposeR = isOn

	self:DecomposeBatchSelectCells()
end

function EvilErosionEquipListUI:OnQualityToggleNValueChanged(isOn)
	self.BatchDecomposeN = isOn

	self:DecomposeBatchSelectCells()
end

function EvilErosionEquipListUI:DecomposeBatchSelectCells()
	local batchSelectedNonSSRItems = {}

	for i = 1, #self.ItemDataList do
		local itemData = self.ItemDataList[i]
		local cfgItemData = itemData:GetCfg()

		if self.BatchDecomposeSR and cfgItemData.Quality == 4 or self.BatchDecomposeR and cfgItemData.Quality == 3 or self.BatchDecomposeN and cfgItemData.Quality == 2 then
			table.insert(batchSelectedNonSSRItems, itemData.id)
		end
	end

	for i = #self.DecomposeSelectItemIds, 1, -1 do
		local selectItemId = self.DecomposeSelectItemIds[i]

		if table.indexOf(batchSelectedNonSSRItems, selectItemId) == -1 then
			local selectItemData = self:GetItemDataInFilteredListById(selectItemId)
			local quality = selectItemData:GetCfg().Quality

			if quality == 4 or quality == 3 or quality == 2 then
				table.remove(self.DecomposeSelectItemIds, i)
			end
		end
	end

	for i = 1, #batchSelectedNonSSRItems do
		local itemId = batchSelectedNonSSRItems[i]

		if table.indexOf(self.DecomposeSelectItemIds, itemId) == -1 then
			table.insert(self.DecomposeSelectItemIds, itemId)
		end
	end

	for instanceId, cell in pairs(self.EquipCells) do
		cell:SetSelected(false)
	end

	for i, cell in pairs(self.EquipCells) do
		if cell.ItemData ~= nil and table.indexOf(self.DecomposeSelectItemIds, cell.ItemData.id) ~= -1 then
			cell:SetSelected(true)
		end
	end

	self:RefreshDecomposeGetItem()
end

function EvilErosionEquipListUI:GetItemDataInFilteredListById(itemId)
	for i = 1, #self.ItemDataList do
		local itemData = self.ItemDataList[i]

		if itemData.id == itemId then
			return itemData
		end
	end

	return nil
end

function EvilErosionEquipListUI:OnEnhanceToggleValueChanged(isOn)
	self.EnhanceMode = isOn

	self:RefreshModifyModeShow()
	self:ClearAllEquipCellSelect()
	self:RefreshEquipScrollList()
end

function EvilErosionEquipListUI:OnDecomposeToggleValueChanged(isOn)
	self.DecomposeMode = isOn

	self:RefreshModifyModeShow()
	self:ClearAllEquipCellSelect()

	if not isOn then
		self.BatchDecomposeSR = false
		self.BatchDecomposeR = false
		self.BatchDecomposeN = false
		self.QualityToggleSR:GetComponent("Toggle").isOn = false
		self.QualityToggleR:GetComponent("Toggle").isOn = false
		self.QualityToggleN:GetComponent("Toggle").isOn = false
	else
		self:RefreshDecomposeGetItem()
	end
end

function EvilErosionEquipListUI:OnClickSortBtn()
	if self.QuickMode then
		NoticeModule.ShowNotice(21046013)

		return
	end

	self.EquipTipController:Hide()
	UIModule.Open(Constant.UIControllerName.EquipListSortUI, Constant.UILayer.UI, {
		onConfirm = function(type, isDesc)
			if not self.IsOpen then
				return
			end

			self.SortType = type
			self.SortIsDesc = isDesc

			self:RefreshEquipScrollList(true)
			self:RefreshSortTypeView()
		end
	})
end

function EvilErosionEquipListUI:OnClickClearFilterBtn()
	if self.QuickMode then
		NoticeModule.ShowNotice(21046013)

		return
	end

	self.EquipTipController:Hide()

	self.FilterPattern = nil

	self:RefreshEquipScrollList(true)
	EquipModule.ResetEquipListUIScreen()
end

function EvilErosionEquipListUI:OnClickFilterBtn()
	if self.QuickMode then
		NoticeModule.ShowNotice(21046013)

		return
	end

	self.EquipTipController:Hide()
	UIModule.Open(Constant.UIControllerName.EquipListScreenUI, Constant.UILayer.UI, {
		onConfirm = function(filterPattern)
			if not self.IsOpen then
				return
			end

			if EquipListUtil.IsFilterEmpty(filterPattern) then
				filterPattern = nil
			end

			self.FilterPattern = filterPattern

			self:RefreshEquipScrollList(true)
		end
	})
end

function EvilErosionEquipListUI:OnClickCloseBtn()
	self:Close()
end

function EvilErosionEquipListUI:Close()
	UIModule.CloseSelf(self)
end

function EvilErosionEquipListUI:UpdateView(soulPrefabPOD, curIndex)
	self.SoulPrefabPOD = soulPrefabPOD
	self.CurIndex = curIndex or 0

	self:RefreshWearingEquipItemDataList()
	self:RefreshEquipScrollList(true)
	self:RefreshSortTypeView()
	self:RefreshMaterialItem()

	self.QuickModeToggle:GetComponent("Toggle").isOn = false

	self.QuickModeToggle:SetActive(self.SoulPrefabPOD ~= nil)
	self.ModifyView:SetActive(self.SoulPrefabPOD == nil)

	self.OptimizeSortToggle:GetComponent("Toggle").isOn = true
	self.DecomposeToggle:GetComponent("Toggle").isOn = false
	self.EnhanceToggle:GetComponent("Toggle").isOn = false
end

function EvilErosionEquipListUI:RefreshWearingEquipItemDataList()
	self.SoulWearingEquips = {}

	if self.SoulPrefabPOD ~= nil then
		for index, equipId in pairs(self.SoulPrefabPOD.equipments) do
			self.SoulWearingEquips[index] = WarehouseModule.GetItemDataById(equipId)
		end
	end
end

function EvilErosionEquipListUI:RefreshEquipScrollList(refreshPosition)
	if not self.QuickMode then
		local rawItemDataList = WarehouseModule.GetItemsByType(Constant.ItemType.EvilErosionEquip, false)

		self.ItemDataList = self:FilterAndSortList(rawItemDataList)

		self.ClearFilterBtn:SetActive(self.FilterPattern ~= nil)
	end

	local scrollAreaList = self.EquipCellGrid:GetComponent("ScrollAreaList")

	if refreshPosition then
		scrollAreaList:Refresh(#self.ItemDataList)
	else
		scrollAreaList:RenderCellsDynamic(#self.ItemDataList)
	end

	self.EquipEmptyView:SetActive(#self.ItemDataList == 0)
end

function EvilErosionEquipListUI:FilterAndSortList(list)
	local filteredList = EquipListUtil.Filter(list, self.FilterPattern)

	filteredList = EquipListUtil.Sort(filteredList, self.SortType, self.SortIsDesc, self.SoulWearingEquips)

	if self.OptimizeSort then
		local star1Items = {}

		for i = #filteredList, 1, -1 do
			local itemData = filteredList[i]

			if itemData.equipData.star == 1 then
				table.insert(star1Items, 1, itemData)
				table.remove(filteredList, i)
			end
		end

		table.addAll(filteredList, star1Items)
	end

	return filteredList
end

function EvilErosionEquipListUI:RefreshSortTypeView()
	self.SortArrowAsc:SetActive(not self.SortIsDesc)
	self.SortArrowDesc:SetActive(self.SortIsDesc)
end

function EvilErosionEquipListUI:RefreshMaterialItem()
	local cfgItemData = CfgItemTable[Constant.ItemID.EVIL_EROSION_CURRENCY]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.HasItemIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.HasItemText, EvilErosionEquipListUIApi:GetString("HasItemText", WarehouseModule.GetItemNumByCfgID(cfgItemData.Id, true)))
end

function EvilErosionEquipListUI:ShowTip(itemData, selectedEquipIndex)
	self.EquipTipController:Show(self.SoulPrefabPOD, itemData, selectedEquipIndex)
	self.CloseTipBtn:SetActive(true)
end

function EvilErosionEquipListUI:ClearAllEquipCellSelect()
	for instanceId, cell in pairs(self.EquipCells) do
		cell:SetSelected(false)
	end

	self.SelectedCellIndex = -1
	self.DecomposeSelectItemIds = {}
end

function EvilErosionEquipListUI:OnRenderEquipCell(cell)
	local equipCell = self.EquipCells[cell.gameObject:GetInstanceID()]

	if equipCell == nil then
		equipCell = EvilErosionEquipCard.New(cell.gameObject, self)
		self.EquipCells[cell.gameObject:GetInstanceID()] = equipCell
	end

	local itemData = self.ItemDataList[cell.index + 1]

	equipCell:SetData(itemData, self.SoulPrefabPOD)
	equipCell:SetSelected(cell.index == self.SelectedCellIndex or itemData ~= nil and table.indexOf(self.DecomposeSelectItemIds, itemData.id) ~= -1)
end

function EvilErosionEquipListUI:OnClickEquipCell(cell)
	local equipCell = self.EquipCells[cell.gameObject:GetInstanceID()]

	if not self.EnhanceMode and not self.DecomposeMode then
		self:OnClickEquipCellInNormalOrQuickMode(equipCell, cell.index)
	elseif self.EnhanceMode then
		self:OnClickEquipCellInEnhanceMode(equipCell, cell.index)
	elseif self.DecomposeMode then
		self:OnClickEquipCellInDecomposeMode(equipCell, cell.index)
	end
end

function EvilErosionEquipListUI:OnClickEquipCellInNormalOrQuickMode(equipCell, cellIndex)
	if equipCell.IsSelected then
		self.EquipTipController:Hide()
	else
		self:ClearAllEquipCellSelect()

		self.SelectedCellIndex = cellIndex

		equipCell:SetSelected(true)

		if not self.QuickMode then
			self:ShowTip(equipCell.ItemData, self.CurIndex, 0)
		end
	end

	if self.QuickMode then
		local toReplaceIndex = -1

		for index, itemData in pairs(self.SoulWearingEquips) do
			if itemData.id == equipCell.ItemData.id then
				toReplaceIndex = index

				break
			end
		end

		if toReplaceIndex == -1 then
			for i = 1, 3 do
				local itemData = self.SoulWearingEquips[i]

				if itemData == nil then
					toReplaceIndex = i

					break
				end
			end
		end

		if toReplaceIndex ~= -1 then
			EvilErosionModule.ChangeEquip(self.SoulPrefabPOD, toReplaceIndex, equipCell.ItemData)
		end
	end
end

function EvilErosionEquipListUI:OnClickEquipCellInEnhanceMode(equipCell, cellIndex)
	self:ClearAllEquipCellSelect()

	self.SelectedCellIndex = cellIndex

	equipCell:SetSelected(true)
	UIModule.Open(Constant.UIControllerName.EvilErosionEquipStrengthenUI, Constant.UILayer.UI, {
		itemData = equipCell.ItemData,
		onClose = function()
			self:ClearAllEquipCellSelect()
		end
	})
end

function EvilErosionEquipListUI:OnClickEquipCellInDecomposeMode(equipCell, cellIndex)
	local ownerSoulPrefabPOD = EvilErosionModule.GetEquipOwner(equipCell.ItemData.id)

	if ownerSoulPrefabPOD ~= nil then
		NoticeModule.ShowNotice(21065001)

		return
	end

	equipCell:SetSelected(not equipCell.IsSelected)

	if equipCell.IsSelected then
		table.insert(self.DecomposeSelectItemIds, equipCell.ItemData.id)
	else
		local arrIndex = table.indexOf(self.DecomposeSelectItemIds, equipCell.ItemData.id)

		if arrIndex ~= -1 then
			table.remove(self.DecomposeSelectItemIds, arrIndex)
		end
	end

	self:RefreshDecomposeGetItem()
end

function EvilErosionEquipListUI:RefreshDecomposeGetItem()
	local cfgItemData = CfgItemTable[Constant.ItemID.EVIL_EROSION_CURRENCY]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.DecomposeGetItemIcon:GetComponent("Image"))

	local canGetItemNum = 0

	for i = 1, #self.DecomposeSelectItemIds do
		local itemData = self:GetItemDataInFilteredListById(self.DecomposeSelectItemIds[i])
		local itemNumMap = EvilErosionModule.GetDecomposeRecycling(itemData)

		for itemCid, itemNum in pairs(itemNumMap) do
			if itemCid == Constant.ItemID.EVIL_EROSION_CURRENCY then
				canGetItemNum = canGetItemNum + itemNum
			end
		end
	end

	UGUIUtil.SetText(self.DecomposeGetItemText, EvilErosionEquipListUIApi:GetString("DecomposeGetItemText", canGetItemNum))
end

function EvilErosionEquipListUI:OnUpdateItem(items)
	self:RefreshEquipScrollList()
	self:RefreshMaterialItem()
end

function EvilErosionEquipListUI:OnQuickModeToggleValueChanged(isOn)
	self.EquipTipController:Hide()

	self.QuickMode = isOn

	self:RefreshEquipScrollList()
end

function EvilErosionEquipListUI:OnWearingEquipChanged()
	self:RefreshWearingEquipItemDataList()
	self:RefreshEquipScrollList()
end

function EvilErosionEquipListUI:RefreshModifyModeShow()
	self.HasItemView:SetActive(not self.EnhanceMode and not self.DecomposeMode)
	self.EnhanceToggle:SetActive(not self.DecomposeMode)
	self.DecomposeToggle:SetActive(not self.EnhanceMode)
end

function EvilErosionEquipListUI:OnDecomposeComplete()
	self.DecomposeToggle:GetComponent("Toggle").isOn = false

	self:RefreshEquipScrollList(true)
end

function EvilErosionEquipListUI:OnUpgradeStarComplete()
	self:RefreshEquipScrollList(true)
end

function EvilErosionEquipListUI:OnOptimizeSortToggleValueChanged(isOn)
	self.OptimizeSort = isOn

	self:RefreshEquipScrollList(true)
end

return EvilErosionEquipListUI
