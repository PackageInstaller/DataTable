-- chunkname: @IQIGame\\UI\\GashaponRewardListUI.lua

local GashaponRewardListUI = {
	cellDatum = {},
	itemCellPool = {},
	tabListDatum = {}
}

GashaponRewardListUI = Base:Extend("GashaponRewardListUI", "IQIGame.Onigao.UI.GashaponRewardListUI", GashaponRewardListUI)

function GashaponRewardListUI:OnInit()
	self:Initialize()
end

function GashaponRewardListUI:GetPreloadAssetPaths()
	return nil
end

function GashaponRewardListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GashaponRewardListUI:IsManualShowOnOpen(userData)
	return false
end

function GashaponRewardListUI:GetBGM(userData)
	return nil
end

function GashaponRewardListUI:OnOpen(userData)
	self:Refresh(userData)
end

function GashaponRewardListUI:OnClose(userData)
	self:OnHide()
end

function GashaponRewardListUI:OnPause()
	return
end

function GashaponRewardListUI:OnResume()
	return
end

function GashaponRewardListUI:OnCover()
	return
end

function GashaponRewardListUI:OnReveal()
	return
end

function GashaponRewardListUI:OnRefocus(userData)
	return
end

function GashaponRewardListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GashaponRewardListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GashaponRewardListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GashaponRewardListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GashaponRewardListUI:Initialize()
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.cellList = self.goList:GetComponent("ScrollAreaList")

	function self.cellList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	self.goTitle:GetComponent("Text").text = GashaponRewardListUIApi:GetString("title")

	for i, v in pairsCfg(CfgFurnitureLotteryProbabilityDisplayTable) do
		self.tabListDatum[#self.tabListDatum + 1] = v
	end

	table.sort(self.tabListDatum, function(a, b)
		return a.Id < b.Id
	end)

	self.tabList = self.goTabList:GetComponent("ScrollAreaList")

	function self.tabList.onRenderCell(cell)
		self:OnRenderTab(cell)
	end

	function self.tabList.onSelectedCell(cell)
		self:OnSelectTab(cell)
	end
end

function GashaponRewardListUI:Refresh(userData)
	self.tabList.defaultSelectedToggle = 0

	self.tabList:Refresh(#self.tabListDatum)
end

function GashaponRewardListUI:OnHide()
	return
end

function GashaponRewardListUI:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end
end

function GashaponRewardListUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function GashaponRewardListUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function GashaponRewardListUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function GashaponRewardListUI:OnClickTg(isOn)
	if isOn then
		self:RefreshTabView(1)
	end
end

function GashaponRewardListUI:OnClickTg2(isOn)
	if isOn then
		self:RefreshTabView(2)
	end
end

function GashaponRewardListUI:RefreshTabView(cfgData)
	self.cellDatum = {}

	for i, v in ipairs(cfgData.ItemListId) do
		self.cellDatum[#self.cellDatum + 1] = {
			v,
			cfgData.probability[i]
		}
	end

	self.cellList:Refresh(#self.cellDatum)
end

function GashaponRewardListUI:OnRenderCell(cell)
	local luaIndex = cell.index + 1
	local cfgItemData = CfgItemTable[self.cellDatum[luaIndex][1]]
	local tfName = cell.transform:Find("Text_01"):GetComponent("Text")
	local tfProbability = cell.transform:Find("Text_02"):GetComponent("Text")
	local insID = cell.gameObject:GetInstanceID()
	local itemCell = self.itemCellPool[insID]

	if itemCell == nil then
		itemCell = ItemCell.PackageOrReuseView(self, cell.transform:Find("Slot_Item/CommonSlotUI").gameObject, true, true)
		self.itemCellPool[insID] = itemCell
	end

	itemCell:SetItemByCID(cfgItemData.Id, 1)

	tfName.text = GashaponRewardListUIApi:GetString("itemName", cfgItemData.Name)
	tfProbability.text = GashaponRewardListUIApi:GetString("itemProbability", self.cellDatum[luaIndex][2])
end

function GashaponRewardListUI:OnRenderTab(cell)
	local luaIndex = cell.index + 1
	local cfgData = self.tabListDatum[luaIndex]
	local go = cell.gameObject

	go:GetComponent("ToggleHelperComponent").text = GashaponRewardListUIApi:GetString("tabName", cfgData.Title)
end

function GashaponRewardListUI:OnSelectTab(cell)
	local luaIndex = cell.index + 1
	local cfgData = self.tabListDatum[luaIndex]

	self:RefreshTabView(cfgData)
end

return GashaponRewardListUI
