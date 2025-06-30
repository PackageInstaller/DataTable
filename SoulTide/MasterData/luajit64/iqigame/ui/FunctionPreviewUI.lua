-- chunkname: @IQIGame\\UI\\FunctionPreviewUI.lua

local FunctionPreviewUI = {
	tabCellPool = {}
}

FunctionPreviewUI = Base:Extend("FunctionPreviewUI", "IQIGame.Onigao.UI.FunctionPreviewUI", FunctionPreviewUI)

local TabCell = require("IQIGame.UI.FunctionPreview.TabCell")
local InfoView = require("IQIGame.UI.FunctionPreview.InfoView")

function FunctionPreviewUI:OnInit()
	self:Initialize()
end

function FunctionPreviewUI:GetPreloadAssetPaths()
	return nil
end

function FunctionPreviewUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FunctionPreviewUI:IsManualShowOnOpen(userData)
	return false
end

function FunctionPreviewUI:GetBGM(userData)
	return nil
end

function FunctionPreviewUI:OnOpen(userData)
	self:Refresh(userData)
end

function FunctionPreviewUI:OnClose(userData)
	self:OnHide()
end

function FunctionPreviewUI:OnPause()
	return
end

function FunctionPreviewUI:OnResume()
	return
end

function FunctionPreviewUI:OnCover()
	return
end

function FunctionPreviewUI:OnReveal()
	return
end

function FunctionPreviewUI:OnRefocus(userData)
	return
end

function FunctionPreviewUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FunctionPreviewUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FunctionPreviewUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FunctionPreviewUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FunctionPreviewUI:Initialize()
	self.tfTitle = self.goTitle:GetComponent("Text")
	self.tfTitleEng = self.goTitleEng:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.tabList = self.goTabList:GetComponent("ScrollAreaList")
	self.infoView = InfoView.New(self.goInfoView)
end

function FunctionPreviewUI:Refresh(userData)
	self:RefreshMisc()
	self:RefreshTabList()
end

function FunctionPreviewUI:OnHide()
	for i, v in pairs(self.tabCellPool) do
		v:OnHide()
	end

	self.infoView:OnHide()
end

function FunctionPreviewUI:OnDestroy()
	for i, v in pairs(self.tabCellPool) do
		v:OnDestroy()
	end

	self.infoView:OnDestroy()
end

function FunctionPreviewUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)

	function self.tabList.onSelectedCell(cell)
		self:OnSelectedTab(cell)
	end

	function self.tabList.onRenderCell(cell)
		self:OnRenderTab(cell)
	end
end

function FunctionPreviewUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)

	self.tabList.onSelectedCell = nil
	self.tabList.onRenderCell = nil
end

function FunctionPreviewUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function FunctionPreviewUI:RefreshMisc()
	self.tfTitle.text = FunctionPreviewUIApi:GetString("goTitle")
	self.tfTitleEng.text = FunctionPreviewUIApi:GetString("goTitleEng")
end

function FunctionPreviewUI:RefreshTabList()
	self.tabListDatum = {}

	for i, v in pairsCfg(CfgFunctionForecastTable) do
		self.tabListDatum[#self.tabListDatum + 1] = v
	end

	table.sort(self.tabListDatum, function(a, b)
		return a.Id < b.Id
	end)

	self.tabList.defaultSelectedToggle = 0

	self.tabList:Refresh(#self.tabListDatum)
end

function FunctionPreviewUI:OnRenderTab(cell)
	local luaIndex = cell.index + 1
	local tabCell = self.tabCellPool[luaIndex]

	if tabCell == nil then
		tabCell = TabCell.New(cell.gameObject)
		self.tabCellPool[luaIndex] = tabCell
	end

	local data = self.tabListDatum[luaIndex]

	tabCell:Refresh(data)
end

function FunctionPreviewUI:OnSelectedTab(cell)
	local luaIndex = cell.index + 1
	local data = self.tabListDatum[luaIndex]

	self.infoView:Refresh(data)
end

return FunctionPreviewUI
