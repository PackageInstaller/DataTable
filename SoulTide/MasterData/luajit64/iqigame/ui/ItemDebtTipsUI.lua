-- chunkname: @IQIGame\\UI\\ItemDebtTipsUI.lua

local ItemDebtTipsUI = {
	ItemDebtTipCells = {}
}

ItemDebtTipsUI = Base:Extend("ItemDebtTipsUI", "IQIGame.Onigao.UI.ItemDebtTipsUI", ItemDebtTipsUI)

local ItemDebtTipCell = require("IQIGame.UI.Bag.ItemDebtTipCell")

function ItemDebtTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	local scrollAreaList = self.ScrollAreaList:GetComponent(typeof(Components.UI.Scroll.ScrollAreaList))

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, ItemDebtTipsUIApi:GetString("TitleText"))
end

function ItemDebtTipsUI:GetPreloadAssetPaths()
	return nil
end

function ItemDebtTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ItemDebtTipsUI:IsManualShowOnOpen(userData)
	return false
end

function ItemDebtTipsUI:GetBGM(userData)
	return nil
end

function ItemDebtTipsUI:OnOpen(userData)
	self:UpdateView()
end

function ItemDebtTipsUI:OnClose(userData)
	return
end

function ItemDebtTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function ItemDebtTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function ItemDebtTipsUI:OnPause()
	return
end

function ItemDebtTipsUI:OnResume()
	return
end

function ItemDebtTipsUI:OnCover()
	return
end

function ItemDebtTipsUI:OnReveal()
	return
end

function ItemDebtTipsUI:OnRefocus(userData)
	return
end

function ItemDebtTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ItemDebtTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ItemDebtTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ItemDebtTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ItemDebtTipsUI:OnDestroy()
	for gameObject, itemDebtTipCell in pairs(self.ItemDebtTipCells) do
		itemDebtTipCell:Dispose()
	end
end

function ItemDebtTipsUI:UpdateView()
	self.ItemDebts = {}

	for cid, debtValue in pairs(PlayerModule.PlayerInfo.itemDebts) do
		table.insert(self.ItemDebts, {
			cid = cid,
			num = debtValue
		})
	end

	table.sort(self.ItemDebts, function(data1, data2)
		return data1.cid < data2.cid
	end)

	local scrollAreaList = self.ScrollAreaList:GetComponent(typeof(Components.UI.Scroll.ScrollAreaList))

	scrollAreaList:Refresh(#self.ItemDebts)
end

function ItemDebtTipsUI:OnRenderCell(cell)
	local itemDebtTipCell = self.ItemDebtTipCells[cell.gameObject]

	if itemDebtTipCell == nil then
		itemDebtTipCell = ItemDebtTipCell.New(cell.gameObject)
		self.ItemDebtTipCells[cell.gameObject] = itemDebtTipCell
	end

	local data = self.ItemDebts[cell.index + 1]

	itemDebtTipCell:SetData(data.cid, data.num)
end

function ItemDebtTipsUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return ItemDebtTipsUI
