-- chunkname: @IQIGame\\UI\\EvilErosionDailySupplyUI.lua

require("IQIGame.UIExternalApi.EvilErosionDailySupplyUIApi")

local EvilErosionDailySupplyUI = {
	ItemCells = {}
}

EvilErosionDailySupplyUI = Base:Extend("EvilErosionDailySupplyUI", "IQIGame.Onigao.UI.EvilErosionDailySupplyUI", EvilErosionDailySupplyUI)

function EvilErosionDailySupplyUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	local scrollAreaList = self.ItemGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderItemCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, EvilErosionDailySupplyUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.TipText, EvilErosionDailySupplyUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, EvilErosionDailySupplyUIApi:GetString("ConfirmBtnText"))
end

function EvilErosionDailySupplyUI:GetPreloadAssetPaths()
	return nil
end

function EvilErosionDailySupplyUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EvilErosionDailySupplyUI:IsManualShowOnOpen(userData)
	return false
end

function EvilErosionDailySupplyUI:GetBGM(userData)
	return nil
end

function EvilErosionDailySupplyUI:OnOpen(userData)
	self:UpdateView(userData)
end

function EvilErosionDailySupplyUI:OnClose(userData)
	return
end

function EvilErosionDailySupplyUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EvilErosionDailySupplyUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EvilErosionDailySupplyUI:OnPause()
	return
end

function EvilErosionDailySupplyUI:OnResume()
	return
end

function EvilErosionDailySupplyUI:OnCover()
	return
end

function EvilErosionDailySupplyUI:OnReveal()
	return
end

function EvilErosionDailySupplyUI:OnRefocus(userData)
	return
end

function EvilErosionDailySupplyUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EvilErosionDailySupplyUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EvilErosionDailySupplyUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EvilErosionDailySupplyUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EvilErosionDailySupplyUI:OnDestroy()
	for instanceId, itemCell in pairs(self.ItemCells) do
		itemCell:Dispose()
	end
end

function EvilErosionDailySupplyUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)
	EvilErosionModule.SendGetDailySupply()
end

function EvilErosionDailySupplyUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EvilErosionDailySupplyUI:UpdateView()
	self.ItemInfoList = EvilErosionModule.GetDailySupplyPreview()

	local scrollAreaList = self.ItemGrid:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.ItemInfoList)
end

function EvilErosionDailySupplyUI:OnRenderItemCell(cell)
	local itemCell = self.ItemCells[cell.gameObject:GetInstanceID()]

	if itemCell == nil then
		itemCell = ItemCell.New(cell.gameObject, true, true, true)
		self.ItemCells[cell.gameObject:GetInstanceID()] = itemCell
	end

	local itemInfo = self.ItemInfoList[cell.index + 1]

	itemCell:SetItemByCID(itemInfo.cid, itemInfo.num)
end

return EvilErosionDailySupplyUI
