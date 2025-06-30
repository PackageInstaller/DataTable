-- chunkname: @IQIGame\\UI\\IllusionMazeSettlementUI.lua

local IllusionMazeSettlementUI = Base:Extend("IllusionMazeSettlementUI", "IQIGame.Onigao.UI.IllusionMazeSettlementUI", {})
local IllusionMazeRewardCell = require("IQIGame.UI.Maze.IllusionMazeRewardCell")

function IllusionMazeSettlementUI:OnInit()
	function self.DelegateOnQuitMaze()
		self:OnQuitMaze()
	end

	self.RewardCells = {}

	local scrollListComponent = self.ItemGrid:GetComponent("ScrollAreaList")

	function scrollListComponent.onRenderCell(cell)
		local simpleItemData = self.Items[cell.index + 1]
		local rewardCell = self.RewardCells[cell.gameObject:GetInstanceID()]

		if rewardCell == nil then
			rewardCell = IllusionMazeRewardCell.New(cell.gameObject, UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetItemCellAssetPath())))
			self.RewardCells[cell.gameObject:GetInstanceID()] = rewardCell
		end

		if simpleItemData ~= nil then
			rewardCell:SetData(simpleItemData.cid, simpleItemData.num, simpleItemData.isFirst, false)
		else
			rewardCell:SetData(0)
		end
	end

	local titleText1, titleText2 = IllusionMazeSettlementUIApi:GetString("TitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
	UGUIUtil.SetText(self.SubTitleText, IllusionMazeSettlementUIApi:GetString("SubTitleText"))
	UGUIUtil.SetText(self.NoItemNoticeText, IllusionMazeSettlementUIApi:GetString("NoItemNoticeText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, IllusionMazeSettlementUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetText(self.RewardLabel, IllusionMazeSettlementUIApi:GetString("RewardLabel"))
end

function IllusionMazeSettlementUI:GetPreloadAssetPaths()
	return {
		UIGlobalApi.GetItemCellAssetPath()
	}
end

function IllusionMazeSettlementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function IllusionMazeSettlementUI:IsManualShowOnOpen(userData)
	return false
end

function IllusionMazeSettlementUI:GetBGM(userData)
	return nil
end

function IllusionMazeSettlementUI:OnOpen(userData)
	self:OnShow()
end

function IllusionMazeSettlementUI:OnClose(userData)
	return
end

function IllusionMazeSettlementUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnQuitMaze)
end

function IllusionMazeSettlementUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnQuitMaze)
end

function IllusionMazeSettlementUI:OnPause()
	return
end

function IllusionMazeSettlementUI:OnResume()
	return
end

function IllusionMazeSettlementUI:OnCover()
	return
end

function IllusionMazeSettlementUI:OnReveal()
	return
end

function IllusionMazeSettlementUI:OnRefocus(userData)
	return
end

function IllusionMazeSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function IllusionMazeSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function IllusionMazeSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function IllusionMazeSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function IllusionMazeSettlementUI:OnDestroy()
	for i = 1, #self.RewardCells do
		local rewardCell = self.RewardCells[i]

		rewardCell:Dispose()
	end

	self.RewardCells = nil

	local scrollListComponent = self.ItemGrid:GetComponent("ScrollAreaList")

	scrollListComponent.onRenderCell = nil
end

function IllusionMazeSettlementUI:OnQuitMaze()
	UIModule.Close(Constant.UIControllerName.MazeSettlementUI)
	MazeModule.ExitMaze()
end

function IllusionMazeSettlementUI:Clear()
	self.Content:SetActive(false)
	self.ConfirmBtn:SetActive(false)
	self.NoItemNoticeText:SetActive(false)
end

function IllusionMazeSettlementUI:OnShow()
	self:Clear()
	self.Content:SetActive(true)
	self.ConfirmBtn:SetActive(true)

	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	UGUIUtil.SetText(self.MazeNameText, cfgMazeInstanceData.Name)
	UGUIUtil.SetText(self.CommentText, IllusionMazeSettlementUIApi:GetString("CommentText", MazeDataModule.PlayerInfo.PlayerParams))
	self:ShowItems()
end

function IllusionMazeSettlementUI:ShowItems()
	local normalItems = {}

	for i = 1, #MazeDataModule.SettlementData.Rewards do
		local itemCid = MazeDataModule.SettlementData.Rewards[i].cid
		local itemNum = MazeDataModule.SettlementData.Rewards[i].num

		if CfgItemTable[itemCid].IsRewardShow then
			table.insert(normalItems, {
				isFirst = false,
				cid = itemCid,
				num = itemNum
			})
		end
	end

	table.sort(normalItems, function(data1, data2)
		local cfgData1 = CfgItemTable[data1.cid]
		local cfgData2 = CfgItemTable[data2.cid]

		if cfgData1.Quality == cfgData2.Quality then
			return cfgData1.Id < cfgData2.Id
		end

		return cfgData1.Quality > cfgData2.Quality
	end)

	self.Items = {}

	for i = 1, #MazeDataModule.SettlementData.FirstRewards do
		local itemCid = MazeDataModule.SettlementData.FirstRewards[i].cid
		local itemNum = MazeDataModule.SettlementData.FirstRewards[i].num

		if CfgItemTable[itemCid].IsRewardShow then
			table.insert(self.Items, {
				isFirst = true,
				cid = itemCid,
				num = itemNum
			})
		end
	end

	for i = 1, #normalItems do
		table.insert(self.Items, normalItems[i])
	end

	local scrollListComponent = self.ItemGrid:GetComponent("ScrollAreaList")

	scrollListComponent:Refresh(#self.Items)
	self.NoItemNoticeText:SetActive(#self.Items == 0)
	self.ItemGrid:SetActive(#self.Items > 0)
end

return IllusionMazeSettlementUI
