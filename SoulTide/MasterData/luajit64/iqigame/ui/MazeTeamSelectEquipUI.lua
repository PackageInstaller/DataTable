-- chunkname: @IQIGame\\UI\\MazeTeamSelectEquipUI.lua

local MazeTeamSelectEquipUI = {
	SortIsDesc = false,
	SelectedCellIndex = -1,
	SortType = 0,
	Position = 0,
	DefaultSelectCellIndex = 0,
	EquipCells = {}
}

MazeTeamSelectEquipUI = Base:Extend("MazeTeamSelectEquipUI", "IQIGame.Onigao.UI.MazeTeamSelectEquipUI", MazeTeamSelectEquipUI)

local EquipDetailView = require("IQIGame.UI.EquipChangeUI.EquipDetailView")
local FormationEquipCell = require("IQIGame.UI.FormationUI.FormationEquipCell")

function MazeTeamSelectEquipUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickSortBtn()
		self:OnClickSortBtn()
	end

	function self.DelegateOnClickEquipBtn()
		self:OnClickEquipBtn()
	end

	function self.DelegateOnClickUnloadBtn()
		self:OnClickUnloadBtn()
	end

	self.WearingCompareController = EquipDetailView.New(self.WearingTip)
	self.SelectedEquipController = EquipDetailView.New(self.SelectingTip)

	local scrollAreaList = self.EquipCellGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderEquipCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnClickEquipCell(cell)
	end

	UGUIUtil.SetText(self.WearingText, MazeTeamSelectEquipUIApi:GetString("WearingText"))
	UGUIUtil.SetTextInChildren(self.EquipBtn, MazeTeamSelectEquipUIApi:GetString("EquipBtnText"))
	UGUIUtil.SetTextInChildren(self.UnloadBtn, MazeTeamSelectEquipUIApi:GetString("UnloadBtnText"))
end

function MazeTeamSelectEquipUI:GetPreloadAssetPaths()
	return nil
end

function MazeTeamSelectEquipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeTeamSelectEquipUI:IsManualShowOnOpen(userData)
	return false
end

function MazeTeamSelectEquipUI:GetBGM(userData)
	return nil
end

function MazeTeamSelectEquipUI:OnOpen(userData)
	self:UpdateView(userData.wearing, userData.position, userData.dollPOD)
end

function MazeTeamSelectEquipUI:OnClose(userData)
	return
end

function MazeTeamSelectEquipUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.SortBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSortBtn)
	self.EquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEquipBtn)
	self.UnloadBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnloadBtn)
end

function MazeTeamSelectEquipUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.SortBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSortBtn)
	self.EquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEquipBtn)
	self.UnloadBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnloadBtn)
end

function MazeTeamSelectEquipUI:OnPause()
	return
end

function MazeTeamSelectEquipUI:OnResume()
	return
end

function MazeTeamSelectEquipUI:OnCover()
	return
end

function MazeTeamSelectEquipUI:OnReveal()
	return
end

function MazeTeamSelectEquipUI:OnRefocus(userData)
	return
end

function MazeTeamSelectEquipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeTeamSelectEquipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeTeamSelectEquipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeTeamSelectEquipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeTeamSelectEquipUI:OnDestroy()
	self.WearingCompareController:OnDestroy()
	self.SelectedEquipController:OnDestroy()

	for gameObject, cell in pairs(self.EquipCells) do
		cell:Dispose()
	end
end

function MazeTeamSelectEquipUI:UpdateView(wearingItem, position, dollPOD)
	self.WearingItem = wearingItem
	self.Position = position
	self.DollPOD = dollPOD
	self.SortType = Constant.EquipSortType.TypeQuality
	self.SortIsDesc = true

	if wearingItem ~= nil then
		self.WearingCompareController:Refresh(wearingItem, nil, dollPOD.soulCid, self:GetEquipCids(dollPOD))
	end

	self.SelectedEquip = nil

	self:RefreshTips()
	self:RefreshSortTypeView()

	self.SelectedCellIndex = -1

	self:RefreshEquipCellList()
end

function MazeTeamSelectEquipUI:GetEquipCids(dollPOD)
	local equipCids = {}

	for index, mazeEquipPOD in pairs(dollPOD.equipments) do
		table.insert(equipCids, mazeEquipPOD.cid)
	end

	return equipCids
end

function MazeTeamSelectEquipUI:RefreshTips()
	self.WearingTipView:SetActive(self.WearingItem ~= nil)
	self.SelectingTipView:SetActive(self.SelectedEquip ~= nil)
	self.CompareImage:SetActive(self.WearingItem ~= nil and self.SelectedEquip ~= nil)
end

function MazeTeamSelectEquipUI:RefreshSortTypeView()
	self.SortArrowAsc:SetActive(not self.SortIsDesc)
	self.SortArrowDesc:SetActive(self.SortIsDesc)
	UGUIUtil.SetTextInChildren(self.SortBtn, MazeTeamSelectEquipUIApi:GetString("SortBtnText", self.SortType))
end

function MazeTeamSelectEquipUI:RefreshEquipCellList()
	local rawItemDataList, equipOnDollNum = MazeDataModule.GetEquipListByPosition(self.Position)

	self.ItemDataList = self:FilterAndSortList(rawItemDataList)
	self.DefaultSelectCellIndex = equipOnDollNum

	self:ClearAllEquipCellSelect()

	local scrollAreaList = self.EquipCellGrid:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.ItemDataList)
end

function MazeTeamSelectEquipUI:FilterAndSortList(list)
	local wearingEquipMap = MazeDataModule.GetWearingEquipMap(self.DollPOD.soulCid)
	local filteredList = EquipListUtil.Sort(list, self.SortType, self.SortIsDesc, wearingEquipMap)

	return filteredList
end

function MazeTeamSelectEquipUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function MazeTeamSelectEquipUI:OnRenderEquipCell(cell)
	local equipCell = self.EquipCells[cell.gameObject]

	if equipCell == nil then
		equipCell = FormationEquipCell.New(cell.gameObject, self)
		equipCell.View.name = "Cell_" .. cell.index + 1
		self.EquipCells[cell.gameObject] = equipCell
	end

	equipCell:SetData(self.ItemDataList[cell.index + 1], self.DollPOD, true)

	local selectedIndex

	if self.SelectedCellIndex == -1 then
		selectedIndex = self.DefaultSelectCellIndex
	else
		selectedIndex = self.SelectedCellIndex
	end

	if cell.index == selectedIndex and equipCell.ItemCell.ItemCfgOrData ~= nil then
		self:SelectCell(equipCell, cell.index)
	end
end

function MazeTeamSelectEquipUI:OnClickEquipCell(cell)
	local equipCell = self.EquipCells[cell.gameObject]

	self:SelectCell(equipCell, cell.index)
end

function MazeTeamSelectEquipUI:SelectCell(equipCell, index)
	if self.SelectedCellIndex == index and equipCell.IsSelected then
		return
	end

	self:ClearAllEquipCellSelect()

	self.SelectedCellIndex = index

	equipCell:SetSelected(true)

	local isEquip, ownerDollId = MazeDataModule.CheckEquipIsOnDoll(equipCell.ItemCell.ItemCfgOrData)

	if not isEquip or ownerDollId ~= self.DollPOD.id then
		local dollPOD = self:GetEquipOwnerDoll(equipCell.ItemCell.ItemCfgOrData)

		self.SelectedEquipController:Refresh(equipCell.ItemCell.ItemCfgOrData, self.WearingItem, dollPOD == nil and 0 or dollPOD.soulCid, self:GetEquipCids(self.DollPOD))

		self.SelectedEquip = equipCell.ItemCell.ItemCfgOrData
	else
		self.SelectedEquip = nil
	end

	self:RefreshTips()
end

function MazeTeamSelectEquipUI:GetEquipOwnerDoll(itemData)
	for i = 1, #MazeDataModule.DollDataList do
		local dollPOD = MazeDataModule.DollDataList[i]
		local equipMap = MazeDataModule.GetWearingEquipMap(dollPOD.soulCid)

		for index, wearingEquipItemData in pairs(equipMap) do
			if wearingEquipItemData.id == itemData.id then
				return dollPOD
			end
		end
	end

	return nil
end

function MazeTeamSelectEquipUI:ClearAllEquipCellSelect()
	for gameObject, cell in pairs(self.EquipCells) do
		cell:SetSelected(false)
	end

	self.SelectedCellIndex = -1
end

function MazeTeamSelectEquipUI:OnClickSortBtn()
	UIModule.Open(Constant.UIControllerName.EquipListSortUI, Constant.UILayer.UI, {
		onConfirm = function(type, isDesc)
			self.SortType = type
			self.SortIsDesc = isDesc

			self:RefreshSortTypeView()
			self:RefreshEquipCellList()
		end
	})
end

function MazeTeamSelectEquipUI:OnClickEquipBtn()
	UIModule.CloseSelf(self)

	local dollPOD = self:GetEquipOwnerDoll(self.SelectedEquip)

	if dollPOD ~= nil and dollPOD.id ~= self.DollPOD.id then
		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_DUMP_EQUIPMENT, {
			DollId = dollPOD.id,
			Id = self.SelectedEquip.id
		})
	end

	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_WEAR_EQUIPMENT, {
		DollId = self.DollPOD.id,
		Id = self.SelectedEquip.id,
		Pos = self.Position
	})
end

function MazeTeamSelectEquipUI:OnClickUnloadBtn()
	UIModule.CloseSelf(self)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_DUMP_EQUIPMENT, {
		DollId = self.DollPOD.id,
		Id = self.WearingItem.id
	})
end

return MazeTeamSelectEquipUI
