-- chunkname: @IQIGame\\UI\\IllusionMazeSweepResultUI.lua

local IllusionMazeSweepResultUI = {
	ItemCells = {}
}

IllusionMazeSweepResultUI = Base:Extend("IllusionMazeSweepResultUI", "IQIGame.Onigao.UI.IllusionMazeSweepResultUI", IllusionMazeSweepResultUI)

require("IQIGame.UIExternalApi.IllusionMazeSweepResultUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function IllusionMazeSweepResultUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.ItemCellPool = UIObjectPool.New(4, function()
		return ItemCell.New(UnityEngine.Object.Instantiate(self.ResultItemPrefab))
	end, function(cell)
		local v = cell.ViewGo

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	UGUIUtil.SetText(self.TitleText, IllusionMazeSweepResultUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.ResultLabel, IllusionMazeSweepResultUIApi:GetString("ResultLabel"))
	UGUIUtil.SetTextInChildren(self.CloseBtn, IllusionMazeSweepResultUIApi:GetString("CloseBtnText"))
end

function IllusionMazeSweepResultUI:GetPreloadAssetPaths()
	return nil
end

function IllusionMazeSweepResultUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function IllusionMazeSweepResultUI:IsManualShowOnOpen(userData)
	return false
end

function IllusionMazeSweepResultUI:GetBGM(userData)
	return nil
end

function IllusionMazeSweepResultUI:OnOpen(userData)
	self:UpdateView(userData.results)
end

function IllusionMazeSweepResultUI:OnClose(userData)
	return
end

function IllusionMazeSweepResultUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function IllusionMazeSweepResultUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function IllusionMazeSweepResultUI:OnPause()
	return
end

function IllusionMazeSweepResultUI:OnResume()
	return
end

function IllusionMazeSweepResultUI:OnCover()
	return
end

function IllusionMazeSweepResultUI:OnReveal()
	return
end

function IllusionMazeSweepResultUI:OnRefocus(userData)
	return
end

function IllusionMazeSweepResultUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function IllusionMazeSweepResultUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function IllusionMazeSweepResultUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function IllusionMazeSweepResultUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function IllusionMazeSweepResultUI:OnDestroy()
	self:ClearItemCells()
	self.ItemCellPool:Dispose()
end

function IllusionMazeSweepResultUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function IllusionMazeSweepResultUI:UpdateView(results)
	local itemShowPODList = {}

	for i = 1, #results do
		local itemShowPODs = results[i].rewards

		for j = 1, #itemShowPODs do
			table.insert(itemShowPODList, itemShowPODs[j])
		end
	end

	self:ClearItemCells()

	for i = 1, #itemShowPODList do
		local itemCell = self.ItemCellPool:Obtain()

		itemCell.ViewGo:SetActive(true)
		itemCell.ViewGo.transform:SetParent(self.ResultGrid.transform, false)

		local itemShowPOD = itemShowPODList[i]

		itemCell:SetItemByCID(itemShowPOD.cid, itemShowPOD.num)
		table.insert(self.ItemCells, itemCell)
	end
end

function IllusionMazeSweepResultUI:ClearItemCells()
	for i = 1, #self.ItemCells do
		local cell = self.ItemCells[i]

		cell.ViewGo:SetActive(false)
		self.ItemCellPool:Release(cell)
	end

	self.ItemCells = {}
end

return IllusionMazeSweepResultUI
