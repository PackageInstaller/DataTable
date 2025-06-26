-- chunkname: @IQIGame\\UI\\PassCheckRewardListUI.lua

local PassCheckRewardListUI = Base:Extend("PassCheckRewardListUI", "IQIGame.Onigao.UI.PassCheckRewardListUI", {
	itemCellPool = {}
})

function PassCheckRewardListUI:OnInit()
	self:Initialize()
end

function PassCheckRewardListUI:GetPreloadAssetPaths()
	return nil
end

function PassCheckRewardListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PassCheckRewardListUI:IsManualShowOnOpen(userData)
	return false
end

function PassCheckRewardListUI:GetBGM(userData)
	return nil
end

function PassCheckRewardListUI:OnOpen(userData)
	self:Refresh(userData)
end

function PassCheckRewardListUI:OnClose(userData)
	self:OnHide()
end

function PassCheckRewardListUI:OnPause()
	return
end

function PassCheckRewardListUI:OnResume()
	return
end

function PassCheckRewardListUI:OnCover()
	return
end

function PassCheckRewardListUI:OnReveal()
	return
end

function PassCheckRewardListUI:OnRefocus(userData)
	return
end

function PassCheckRewardListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PassCheckRewardListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PassCheckRewardListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PassCheckRewardListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PassCheckRewardListUI:Initialize()
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.baseList = self.goBaseList:GetComponent("ScrollAreaList")

	function self.baseList.onRenderCell(cell)
		self:OnRenderBaseCell(cell)
	end

	self.superList = self.goSuperList:GetComponent("ScrollAreaList")

	function self.superList.onRenderCell(cell)
		self:OnRenderSuperCell(cell)
	end

	self.goTitle:GetComponent("Text").text = PassCheckRewardListUIApi:GetString("title")
	self.goBaseTitle:GetComponent("Text").text = PassCheckRewardListUIApi:GetString("baseTitle")
	self.goSuperTitle:GetComponent("Text").text = PassCheckRewardListUIApi:GetString("superTitle")
end

function PassCheckRewardListUI:Refresh(userData)
	self:RefreshBaseReward()
	self:RefreshSuperReward()
end

function PassCheckRewardListUI:OnHide()
	return
end

function PassCheckRewardListUI:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end
end

function PassCheckRewardListUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function PassCheckRewardListUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function PassCheckRewardListUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function PassCheckRewardListUI:OnRenderBaseCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local cellData = self.baseListDatum[luaIndex]
	local itemCell = self.itemCellPool[insID]

	if itemCell == nil then
		itemCell = ItemCell.PackageOrReuseView(self, cell.gameObject.transform:Find("Slot/CommonSlotUI").gameObject, true, true)
		self.itemCellPool[insID] = itemCell
	end

	itemCell:SetItemByCID(cellData[1], cellData[2])
end

function PassCheckRewardListUI:OnRenderSuperCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local cellData = self.superListDatum[luaIndex]
	local itemCell = self.itemCellPool[insID]

	if itemCell == nil then
		itemCell = ItemCell.PackageOrReuseView(self, cell.gameObject.transform:Find("Slot/CommonSlotUI").gameObject, true, true)
		self.itemCellPool[insID] = itemCell
	end

	itemCell:SetItemByCID(cellData[1], cellData[2])
end

function PassCheckRewardListUI:RefreshBaseReward()
	self.baseListDatum = PassCheckModule.GetAllRewardDatum(1)

	self.baseList:Refresh(#self.baseListDatum)
end

function PassCheckRewardListUI:RefreshSuperReward()
	self.superListDatum = PassCheckModule.GetAllRewardDatum(2)

	self.superList:Refresh(#self.superListDatum)
end

return PassCheckRewardListUI
