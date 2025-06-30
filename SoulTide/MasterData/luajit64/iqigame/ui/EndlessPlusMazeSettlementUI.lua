-- chunkname: @IQIGame\\UI\\EndlessPlusMazeSettlementUI.lua

require("IQIGame.UIExternalApi.EndlessPlusMazeSettlementUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local EndlessPlusMazeRewardCell = require("IQIGame.UI.EndlessPlusMaze.EndlessPlusMazeRewardCell")
local EndlessMazeRuneSuitItem = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneSuitItem")
local EndlessPlusMazeSettlementUI = {
	RewardCells = {},
	SuitItems = {}
}

EndlessPlusMazeSettlementUI = Base:Extend("EndlessPlusMazeSettlementUI", "IQIGame.Onigao.UI.EndlessPlusMazeSettlementUI", EndlessPlusMazeSettlementUI)

function EndlessPlusMazeSettlementUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.RewardCellPool = UIObjectPool.New(3, function()
		return EndlessPlusMazeRewardCell.New(UnityEngine.Object.Instantiate(self.RewardCellPrefab))
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	for i = 1, 6 do
		local item = EndlessMazeRuneSuitItem.New(UnityEngine.Object.Instantiate(self.RuneSuitItemPrefab))

		item.View.transform:SetParent(self.RuneSuitGrid.transform, false)

		self.SuitItems[i] = item
	end

	local titleText1, titleText2 = EndlessPlusMazeSettlementUIApi:GetString("TitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
	UGUIUtil.SetTextInChildren(self.CloseBtn, EndlessPlusMazeSettlementUIApi:GetString("CloseBtnText"))
	UGUIUtil.SetTextInChildren(self.RewardEmptyView, EndlessPlusMazeSettlementUIApi:GetString("RewardEmptyViewText"))
	UGUIUtil.SetTextInChildren(self.RuneEmptyView, EndlessPlusMazeSettlementUIApi:GetString("RuneEmptyViewText"))
end

function EndlessPlusMazeSettlementUI:GetPreloadAssetPaths()
	return nil
end

function EndlessPlusMazeSettlementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessPlusMazeSettlementUI:IsManualShowOnOpen(userData)
	return false
end

function EndlessPlusMazeSettlementUI:GetBGM(userData)
	return nil
end

function EndlessPlusMazeSettlementUI:OnOpen(userData)
	self:UpdateView()
end

function EndlessPlusMazeSettlementUI:OnClose(userData)
	return
end

function EndlessPlusMazeSettlementUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EndlessPlusMazeSettlementUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EndlessPlusMazeSettlementUI:OnPause()
	return
end

function EndlessPlusMazeSettlementUI:OnResume()
	return
end

function EndlessPlusMazeSettlementUI:OnCover()
	return
end

function EndlessPlusMazeSettlementUI:OnReveal()
	return
end

function EndlessPlusMazeSettlementUI:OnRefocus(userData)
	return
end

function EndlessPlusMazeSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessPlusMazeSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessPlusMazeSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessPlusMazeSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessPlusMazeSettlementUI:OnDestroy()
	self:ClearCells()
	self.RewardCellPool:Dispose()

	for i = 1, #self.SuitItems do
		local item = self.SuitItems[i]

		item:Dispose()
	end
end

function EndlessPlusMazeSettlementUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
	MazeModule.ExitMaze()
end

function EndlessPlusMazeSettlementUI:UpdateView()
	local rewardItems = {}

	for i = 1, #MazeDataModule.SettlementData.Rewards do
		local itemCid = MazeDataModule.SettlementData.Rewards[i].cid
		local itemNum = MazeDataModule.SettlementData.Rewards[i].num

		if CfgItemTable[itemCid].IsRewardShow then
			table.insert(rewardItems, {
				cid = itemCid,
				num = itemNum
			})
		end
	end

	table.sort(rewardItems, function(data1, data2)
		local cfgData1 = CfgItemTable[data1.cid]
		local cfgData2 = CfgItemTable[data2.cid]

		if cfgData1.Quality == cfgData2.Quality then
			return cfgData1.Id < cfgData2.Id
		end

		return cfgData1.Quality > cfgData2.Quality
	end)
	self:ClearCells()

	for i = 1, #rewardItems do
		local data = rewardItems[i]
		local cell = self.RewardCellPool:Obtain()

		cell.View.transform:SetParent(self.RewardGrid.transform, false)
		cell.View:SetActive(true)
		cell:SetData(data.cid, data.num)
		table.insert(self.RewardCells, cell)
	end

	self.RewardEmptyView:SetActive(#rewardItems == 0)

	local cidList, numList = MazeModule.GetEndlessMazeRuneSuitData()
	local legendCidList = MazeModule.GetEndlessMazeLegendRuneSuitData(cidList, numList)
	local normalSuitStartIndex = 1

	if #legendCidList > 0 then
		local item = self.SuitItems[1]

		item:SetData(2, nil, #legendCidList)

		normalSuitStartIndex = 2
	end

	for i = normalSuitStartIndex, #self.SuitItems do
		local item = self.SuitItems[i]

		item:SetData(1, cidList[i], numList[i])
	end

	self.RuneEmptyView:SetActive(#legendCidList == 0 and #cidList == 0)
end

function EndlessPlusMazeSettlementUI:ClearCells()
	for i = 1, #self.RewardCells do
		local cell = self.RewardCells[i]

		cell.View:SetActive(false)
		cell.View.transform:SetParent(self.UIController.transform, false)
		self.RewardCellPool:Release(cell)
	end

	self.RewardCells = {}
end

return EndlessPlusMazeSettlementUI
