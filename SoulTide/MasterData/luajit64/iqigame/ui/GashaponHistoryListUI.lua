-- chunkname: @IQIGame\\UI\\GashaponHistoryListUI.lua

local GashaponHistoryListUI = {
	listCellPool = {}
}

GashaponHistoryListUI = Base:Extend("GashaponHistoryListUI", "IQIGame.Onigao.UI.GashaponHistoryListUI", GashaponHistoryListUI)

local GashRewardCell = require("IQIGame.UI.GashaponHistoryList.GashRewardCell")

function GashaponHistoryListUI:OnInit()
	self:Initialize()
end

function GashaponHistoryListUI:GetPreloadAssetPaths()
	return nil
end

function GashaponHistoryListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GashaponHistoryListUI:IsManualShowOnOpen(userData)
	return false
end

function GashaponHistoryListUI:GetBGM(userData)
	return nil
end

function GashaponHistoryListUI:OnOpen(userData)
	self:Refresh(userData)
end

function GashaponHistoryListUI:OnClose(userData)
	self:OnHide()
end

function GashaponHistoryListUI:OnPause()
	return
end

function GashaponHistoryListUI:OnResume()
	return
end

function GashaponHistoryListUI:OnCover()
	return
end

function GashaponHistoryListUI:OnReveal()
	return
end

function GashaponHistoryListUI:OnRefocus(userData)
	return
end

function GashaponHistoryListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GashaponHistoryListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GashaponHistoryListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GashaponHistoryListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GashaponHistoryListUI:Initialize()
	self.list = self.goList:GetComponent("ScrollAreaList")

	function self.list.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.goTitle:GetComponent("Text").text = GashaponHistoryListUIApi:GetString("title")
	self.goDesc:GetComponent("Text").text = GashaponHistoryListUIApi:GetString("desc")
end

function GashaponHistoryListUI:Refresh(userData)
	local index = userData

	self.listDatum = {}

	for i, v in pairsCfg(CfgFurnitureRewardListTable) do
		if v.Team == index then
			self.listDatum[#self.listDatum + 1] = v
		end
	end

	table.sort(self.listDatum, function(a, b)
		return a.Id < b.Id
	end)
	self.list:Refresh(#self.listDatum)
end

function GashaponHistoryListUI:OnHide()
	for i, v in pairs(self.listCellPool) do
		v:OnHide()
	end
end

function GashaponHistoryListUI:OnDestroy()
	for i, v in pairs(self.listCellPool) do
		v:OnDestroy()
	end
end

function GashaponHistoryListUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function GashaponHistoryListUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function GashaponHistoryListUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function GashaponHistoryListUI:OnRenderCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local rewardCell = self.listCellPool[insID]

	if rewardCell == nil then
		rewardCell = GashRewardCell.New(cell.gameObject)
		self.listCellPool[insID] = rewardCell
	end

	rewardCell:Refresh(self.listDatum[luaIndex])
end

return GashaponHistoryListUI
