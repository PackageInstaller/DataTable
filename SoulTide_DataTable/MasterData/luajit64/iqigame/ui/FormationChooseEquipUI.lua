-- chunkname: @IQIGame\\UI\\FormationChooseEquipUI.lua

local FormationChooseEquipUI = {
	SortIsDesc = false,
	SelectedCellIndex = -1,
	IsOpen = false,
	SortType = 0,
	QuickMode = false,
	EquipCells = {}
}

FormationChooseEquipUI = Base:Extend("FormationChooseEquipUI", "IQIGame.Onigao.UI.FormationChooseEquipUI", FormationChooseEquipUI)

local FormationEquipCard = require("IQIGame.UI.FormationUI.FormationEquipCard")
local FormationSuitEffectItem = require("IQIGame.UI.FormationUI.FormationSuitEffectItem")
local FormationEquipCell = require("IQIGame.UI.FormationUI.FormationEquipCell")
local FormationEquipTipController = require("IQIGame.UI.FormationUI.FormationEquipTipController")
local FormationEquipPrefabPanel = require("IQIGame.UI.FormationUI.FormationEquipPrefabPanel")
local FormationSoulInfoItem = require("IQIGame.UI.FormationUI.FormationSoulInfoItem")

function FormationChooseEquipUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickCloseTipBtn()
		self:OnClickCloseTipBtn()
	end

	function self.DelegateOnEquipPutOnSuccess(equipItemDataId)
		self:OnEquipPutOnSuccess(equipItemDataId)
	end

	function self.DelegateOnEquipTakeOffSuccess(equipItemDataId)
		self:OnEquipTakeOffSuccess(equipItemDataId)
	end

	function self.DelegateOnClickEquipPrefabBtn()
		self:OnClickEquipPrefabBtn()
	end

	function self.DelegateOnClickSortBtn()
		self:OnClickSortBtn()
	end

	function self.DelegateOnClickFilterBtn()
		self:OnClickFilterBtn()
	end

	function self.DelegateOnClickClearFilterBtn()
		self:OnClickClearFilterBtn()
	end

	function self.DelegateOnClickUnloadAllBtn()
		self:OnClickUnloadAllBtn()
	end

	function self.DelegateOnClickShowSuitViewBtn()
		self:OnClickShowSuitViewBtn()
	end

	function self.DelegateOnClickHideSuitViewBtn()
		self:OnClickHideSuitViewBtn()
	end

	function self.DelegateOnClickGoSoulBtn()
		self:OnClickGoSoulBtn()
	end

	function self.DelegateOnQuickModeToggleValueChanged(isOn)
		self:OnQuickModeToggleValueChanged(isOn)
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnUpdateItem(items)
		self:OnUpdateItem(items)
	end

	function self.DelegateOnEquipSkinChanged(skinCid)
		self:OnEquipSkinChanged(skinCid)
	end

	self.EquipCards = {}

	for i = 1, 3 do
		local card = FormationEquipCard.New(UnityEngine.Object.Instantiate(self.EquipCardPrefab), i, function(card)
			self:OnClickEquipCard(card)
		end, function(card)
			self:OnLongClickEquipCard(card)
		end)

		card.View.transform:SetParent(self.EquipCardGrid.transform, false)

		self.EquipCards[i] = card
	end

	local suitEffectDataList = {}

	for id, cfgSoulPaintingRareSuitData in pairsCfg(CfgSoulPaintingRareSuitTable) do
		table.insert(suitEffectDataList, cfgSoulPaintingRareSuitData)
	end

	table.sort(suitEffectDataList, function(cfgData1, cfgData2)
		return cfgData1.Quality < cfgData2.Quality
	end)

	self.SuitEffectItems = {}

	for i = 1, 4 do
		local cfgSoulPaintingRareSuitData = suitEffectDataList[i]
		local item = FormationSuitEffectItem.New(UnityEngine.Object.Instantiate(self.SuitEffectPrefab), cfgSoulPaintingRareSuitData)

		item.View.transform:SetParent(self.SuitEffectGrid.transform, false)

		self.SuitEffectItems[i] = item
	end

	local scrollAreaList = self.EquipCellGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderEquipCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnClickEquipCell(cell)
	end

	self.EquipTipController = FormationEquipTipController.New(self.TipView, function()
		self.CloseTipBtn:SetActive(false)
		self:ClearAllEquipCellSelect()
	end, function(itemData)
		self:OpenEquipUI(itemData, 1)
	end, function(itemData)
		self:OpenEquipUI(itemData, 2)
	end)

	self.EquipTipController:Hide()

	self.EquipPrefabPanel = FormationEquipPrefabPanel.New(self.EquipPrefabView, function()
		self.EquipListPanel:SetActive(true)
		self.EquipListPanelBottomButtons:SetActive(true)
	end)

	self.EquipPrefabPanel:Hide()

	self.SoulInfoItem = FormationSoulInfoItem.New(self.SoulInfoView, true)

	UGUIUtil.SetText(self.TitleText, FormationChooseEquipUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.EquipPrefabBtn, FormationChooseEquipUIApi:GetString("EquipPrefabBtnText"))
	UGUIUtil.SetTextInChildren(self.SortBtn, FormationChooseEquipUIApi:GetString("SortBtnText"))
	UGUIUtil.SetTextInChildren(self.FilterBtn, FormationChooseEquipUIApi:GetString("FilterBtnText"))
	UGUIUtil.SetTextInChildren(self.ClearFilterBtn, FormationChooseEquipUIApi:GetString("ClearFilterBtnText"))
	UGUIUtil.SetTextInChildren(self.UnloadAllBtn, FormationChooseEquipUIApi:GetString("UnloadAllBtnText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, FormationChooseEquipUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetTextInChildren(self.GoSoulBtn, FormationChooseEquipUIApi:GetString("GoSoulBtnText"))
	UGUIUtil.SetTextInChildren(self.GoEquipText, FormationChooseEquipUIApi:GetString("GoEquipText"))
	UGUIUtil.SetTextInChildren(self.EquipEmptyView, FormationChooseEquipUIApi:GetString("EquipEmptyViewText"))

	self.QuickModeToggle:GetComponent("ToggleHelperComponent").text = FormationChooseEquipUIApi:GetString("QuickModeToggleText")
end

function FormationChooseEquipUI:GetPreloadAssetPaths()
	return nil
end

function FormationChooseEquipUI:GetOpenPreloadAssetPaths(userData)
	local soulPrefabData = SoulPrefabModule.GetPrefab(userData.prefabId)
	local soulData = SoulModule.GetSoulData(soulPrefabData.soulCid)

	return {
		FormationChooseEquipUIApi:GetString("SoulPortraitPath", soulPrefabData.soulCid, soulData:GetCfgDress2D().SoulResID)
	}
end

function FormationChooseEquipUI:IsManualShowOnOpen(userData)
	return false
end

function FormationChooseEquipUI:GetBGM(userData)
	return nil
end

function FormationChooseEquipUI:OnOpen(userData)
	self.IsOpen = true

	self.SuitView:SetActive(false)
	self:UpdateView(userData.prefabId, userData.formationIndex)
end

function FormationChooseEquipUI:OnClose(userData)
	self.IsOpen = false

	self.SoulInfoItem:OnClose()

	self.SortType = 0
	self.SortIsDesc = false
end

function FormationChooseEquipUI:OnAddListeners()
	self.SoulInfoItem:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseTipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseTipBtn)
	self.EquipPrefabBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEquipPrefabBtn)
	self.SortBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSortBtn)
	self.FilterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFilterBtn)
	self.ClearFilterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClearFilterBtn)
	self.UnloadAllBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnloadAllBtn)
	self.ShowSuitViewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShowSuitViewBtn)
	self.HideSuitViewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHideSuitViewBtn)
	self.GoSoulBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGoSoulBtn)
	self.QuickModeToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnQuickModeToggleValueChanged)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	EventDispatcher.AddEventListener(EventID.EquipPuOnSuccess, self.DelegateOnEquipPutOnSuccess)
	EventDispatcher.AddEventListener(EventID.EquipTakeOffSuccess, self.DelegateOnEquipTakeOffSuccess)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.EquipSkinChanged, self.DelegateOnEquipSkinChanged)
end

function FormationChooseEquipUI:OnRemoveListeners()
	self.SoulInfoItem:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseTipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseTipBtn)
	self.EquipPrefabBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEquipPrefabBtn)
	self.SortBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSortBtn)
	self.FilterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFilterBtn)
	self.ClearFilterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClearFilterBtn)
	self.UnloadAllBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnloadAllBtn)
	self.ShowSuitViewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShowSuitViewBtn)
	self.HideSuitViewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHideSuitViewBtn)
	self.GoSoulBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGoSoulBtn)
	self.QuickModeToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnQuickModeToggleValueChanged)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	EventDispatcher.RemoveEventListener(EventID.EquipPuOnSuccess, self.DelegateOnEquipPutOnSuccess)
	EventDispatcher.RemoveEventListener(EventID.EquipTakeOffSuccess, self.DelegateOnEquipTakeOffSuccess)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.EquipSkinChanged, self.DelegateOnEquipSkinChanged)
end

function FormationChooseEquipUI:OnPause()
	return
end

function FormationChooseEquipUI:OnResume()
	return
end

function FormationChooseEquipUI:OnCover()
	return
end

function FormationChooseEquipUI:OnReveal()
	return
end

function FormationChooseEquipUI:OnRefocus(userData)
	return
end

function FormationChooseEquipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FormationChooseEquipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FormationChooseEquipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FormationChooseEquipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FormationChooseEquipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.EquipCards do
		local card = self.EquipCards[i]

		card:Dispose()
	end

	for i = 1, #self.SuitEffectItems do
		local item = self.SuitEffectItems[i]

		item:Dispose()
	end

	for gameObject, cell in pairs(self.EquipCells) do
		cell:Dispose()
	end

	self.EquipCells = nil

	self.EquipTipController:Dispose()
	self.EquipPrefabPanel:Dispose()
	self.SoulInfoItem:Dispose()
end

function FormationChooseEquipUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function FormationChooseEquipUI:OnRenderEquipCell(cell)
	local equipCell = self.EquipCells[cell.gameObject]

	if equipCell == nil then
		equipCell = FormationEquipCell.New(cell.gameObject, self)
		equipCell.View.name = "Cell_" .. cell.index + 1
		self.EquipCells[cell.gameObject] = equipCell
	end

	equipCell:SetData(self.ItemDataList[cell.index + 1], self.SoulPrefabData)
	equipCell:SetSelected(cell.index == self.SelectedCellIndex)
end

function FormationChooseEquipUI:OnClickEquipCell(cell)
	local equipCell = self.EquipCells[cell.gameObject]

	if equipCell.IsSelected then
		self.EquipTipController:Hide()
	else
		self:ClearAllEquipCellSelect()

		self.SelectedCellIndex = cell.index

		equipCell:SetSelected(true)

		if not self.QuickMode then
			self:ShowTip(equipCell.ItemCell.ItemCfgOrData, self.SelectedEquipCard.Index, 0, true)
		end
	end

	if self.QuickMode then
		local toReplaceIndex = -1

		for index, itemData in pairs(self.SoulPrefabData.equipItemDatum) do
			if itemData.id == equipCell.ItemCell.ItemCfgOrData.id then
				toReplaceIndex = index

				break
			end
		end

		if toReplaceIndex == -1 then
			for i = 1, 3 do
				local itemData = self.SoulPrefabData.equipItemDatum[i]

				if itemData == nil then
					toReplaceIndex = i

					break
				end
			end
		end

		if toReplaceIndex ~= -1 then
			FormationModule.ChangeEquip(self.SoulPrefabData.id, toReplaceIndex, equipCell.ItemCell.ItemCfgOrData)
		end
	end
end

function FormationChooseEquipUI:ClearAllEquipCellSelect()
	for gameObject, cell in pairs(self.EquipCells) do
		cell:SetSelected(false)
	end

	self.SelectedCellIndex = -1
end

function FormationChooseEquipUI:ShowTip(itemData, selectedEquipIndex, tipPointType, isLinkCellOnLeft)
	self.EquipTipController:Show(self.SoulPrefabData.id, self.FormationIndex, itemData, selectedEquipIndex, tipPointType, isLinkCellOnLeft)
	self.CloseTipBtn:SetActive(true)
end

function FormationChooseEquipUI:UpdateView(prefabId, formationIndex)
	self.FormationIndex = formationIndex
	self.SortType = Constant.EquipSortType.TypeQuality
	self.SortIsDesc = true
	self.SoulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

	local soulData = SoulModule.GetSoulData(self.SoulPrefabData.soulCid)

	self.SoulInfoItem:SetData(soulData, self.SoulPrefabData, formationIndex)
	self:RefreshWearingEquips()
	self:RefreshSelectedEquip()
	self:RefreshEquipScrollList(true)
	self:RefreshSortTypeView()

	self.QuickModeToggle:GetComponent("Toggle").isOn = false
	self.QuickMode = false
end

function FormationChooseEquipUI:RefreshSortTypeView()
	self.SortArrowAsc:SetActive(not self.SortIsDesc)
	self.SortArrowDesc:SetActive(self.SortIsDesc)
end

function FormationChooseEquipUI:RefreshSelectedEquip()
	local index = -1

	for i = 1, #self.EquipCards do
		local equipCard = self.EquipCards[i]

		if equipCard.EquipCell.itemData == nil then
			index = i

			break
		end
	end

	if index == -1 then
		if self.SelectedEquipCard == nil then
			self:SelectEquipCard(self.EquipCards[1])
		else
			self:SelectEquipCard(self.SelectedEquipCard)
		end
	else
		self:SelectEquipCard(self.EquipCards[index])
	end
end

function FormationChooseEquipUI:OnClickEquipCard(card)
	self:SelectEquipCard(card)

	if card.EquipCell.itemData ~= nil then
		self:ShowTip(card.EquipCell.itemData, card.Index, card.Index, false)
	end
end

function FormationChooseEquipUI:OnLongClickEquipCard(card)
	self:OpenEquipUI(card.EquipCell.itemData, 1)
end

function FormationChooseEquipUI:OpenEquipUI(itemData, tab)
	if itemData ~= nil then
		local allEquipDataList = {}
		local isWearingEquip = false

		for i = 1, #self.EquipCards do
			local equipCard = self.EquipCards[i]

			if equipCard.EquipCell.itemData ~= nil then
				table.insert(allEquipDataList, equipCard.EquipCell.itemData)
			end

			if equipCard.EquipCell.itemData == itemData then
				isWearingEquip = true
			end
		end

		if not isWearingEquip then
			allEquipDataList = {
				itemData
			}
		end

		UIModule.Open(Constant.UIControllerName.EquipUI, Constant.UILayer.UI, {
			data = allEquipDataList,
			defaultItemData = itemData,
			tab = tab
		})
	end
end

function FormationChooseEquipUI:SelectEquipCard(card)
	if self.SelectedEquipCard ~= nil then
		self.SelectedEquipCard:SetSelected(false)
	end

	card:SetSelected(true)

	self.SelectedEquipCard = card

	EventDispatcher.Dispatch(EventID.FormationChooseEquipCard, card.Index)
end

function FormationChooseEquipUI:OnClickCloseTipBtn()
	self.EquipTipController:Hide()
end

function FormationChooseEquipUI:OnEquipPutOnSuccess(equipItemDataId)
	self:RefreshWearingEquips()
	self:RefreshSelectedEquip()
	self:RefreshEquipScrollList()
end

function FormationChooseEquipUI:OnEquipTakeOffSuccess(equipItemDataId)
	self:RefreshWearingEquips()
	self:RefreshEquipScrollList()
end

function FormationChooseEquipUI:RefreshWearingEquips()
	local hasEquip = false

	for i = 1, #self.EquipCards do
		local card = self.EquipCards[i]
		local itemData = self.SoulPrefabData.equipItemDatum[i]

		card:SetData(itemData)

		if itemData ~= nil then
			hasEquip = true
		end
	end

	if not hasEquip then
		for i, v in pairs(self.SoulPrefabData.newJewelrySpeeds) do
			hasEquip = true

			break
		end
	end

	local equipCount = 0
	local minQuality = 5

	for i, itemData in pairs(self.SoulPrefabData.equipItemDatum) do
		minQuality = math.min(minQuality, itemData:GetCfg().Quality)
		equipCount = equipCount + 1
	end

	local isSuitActive = equipCount >= #self.EquipCards

	if not isSuitActive then
		minQuality = 0
	end

	for i = 1, #self.SuitEffectItems do
		local item = self.SuitEffectItems[i]

		item:SetData(minQuality)
	end

	self.SuitActiveIcon:SetActive(isSuitActive)
	self.SuitInActiveIcon:SetActive(not isSuitActive)
	UGUIUtil.SetText(self.SuitTipText, FormationChooseEquipUIApi:GetString("SuitTipText", isSuitActive, minQuality))

	self.UnloadAllBtn:GetComponent("Button").interactable = hasEquip
	self.UnloadAllBtn:GetComponent("ButtonDisabledComponent").IsDisabled = not hasEquip
end

function FormationChooseEquipUI:RefreshEquipScrollList(refreshPosition)
	if not self.QuickMode then
		local rawItemDataList = WarehouseModule.GetItemsByType(Constant.ItemType.Equip, true)

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

function FormationChooseEquipUI:OnClickEquipPrefabBtn()
	self.EquipPrefabPanel:Show(self.SoulPrefabData)
	self.EquipListPanel:SetActive(false)
	self.EquipListPanelBottomButtons:SetActive(false)
end

function FormationChooseEquipUI:OnClickSortBtn()
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

function FormationChooseEquipUI:OnClickFilterBtn()
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

function FormationChooseEquipUI:OnClickClearFilterBtn()
	if self.QuickMode then
		NoticeModule.ShowNotice(21046013)

		return
	end

	self.EquipTipController:Hide()

	self.FilterPattern = nil

	self:RefreshEquipScrollList(true)
	EquipModule.ResetEquipListUIScreen()
end

function FormationChooseEquipUI:FilterAndSortList(list)
	local filteredList = EquipListUtil.Filter(list, self.FilterPattern)

	filteredList = EquipListUtil.Sort(filteredList, self.SortType, self.SortIsDesc, self.SoulPrefabData.equipItemDatum)

	return filteredList
end

function FormationChooseEquipUI:OnClickUnloadAllBtn()
	NoticeModule.ShowNotice(21046005, function()
		EquipModule.ReqCoverEquipments(self.SoulPrefabData.id, {})
	end)
end

function FormationChooseEquipUI:OnClickShowSuitViewBtn()
	self.SuitView:SetActive(true)
end

function FormationChooseEquipUI:OnClickHideSuitViewBtn()
	self.SuitView:SetActive(false)
end

function FormationChooseEquipUI:OnClickGoSoulBtn()
	UIModule.CloseSelf(self)
	UIModule.Open(Constant.UIControllerName.FormationChooseSoulUI, Constant.UILayer.UI, {
		formationIndex = self.FormationIndex,
		prefabId = self.SoulPrefabData.id
	})
end

function FormationChooseEquipUI:OnQuickModeToggleValueChanged(isOn)
	self.EquipTipController:Hide()

	self.QuickMode = isOn

	self:RefreshEquipScrollList()

	for i = 1, #self.EquipCards do
		local card = self.EquipCards[i]

		card:SetIsQuickMode(isOn)
	end
end

function FormationChooseEquipUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)
end

function FormationChooseEquipUI:OnUpdateItem(items)
	self:RefreshWearingEquips()
	self:RefreshEquipScrollList()
end

function FormationChooseEquipUI:OnEquipSkinChanged(skinCid)
	self:RefreshWearingEquips()
	self:RefreshEquipScrollList()
end

return FormationChooseEquipUI
