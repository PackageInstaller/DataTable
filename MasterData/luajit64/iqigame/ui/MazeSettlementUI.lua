-- chunkname: @IQIGame\\UI\\MazeSettlementUI.lua

local MazeSettlementUI = Base:Extend("MazeSettlementUI", "IQIGame.Onigao.UI.MazeSettlementUI", {})
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")

function MazeSettlementUI:OnInit()
	function self.DelegateOnQuitMaze()
		self:OnQuitMaze()
	end

	self.RewardCells = {}

	local scrollListComponent = self.ItemGrid:GetComponent("ScrollAreaList")

	function scrollListComponent.onRenderCell(cell)
		local simpleItemData = self.Items[cell.index + 1]
		local rewardCell = self.RewardCells[cell.gameObject:GetInstanceID()]

		if rewardCell == nil then
			rewardCell = MazeRewardCell.New(cell.gameObject)
			self.RewardCells[cell.gameObject:GetInstanceID()] = rewardCell
		end

		if simpleItemData ~= nil then
			rewardCell:SetData(simpleItemData.cid, simpleItemData.num, simpleItemData.isFirst, false)
		else
			rewardCell:SetData(0)
		end
	end

	local titleText1, titleText2 = MazeSettlementUIApi:GetString("TitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
	UGUIUtil.SetText(self.SubTitleText, MazeSettlementUIApi:GetString("SubTitleText"))
	UGUIUtil.SetText(self.NoItemNoticeText, MazeSettlementUIApi:GetString("NoItemNoticeText"))
	UGUIUtil.SetText(self.RewardLabel, MazeSettlementUIApi:GetString("RewardLabel"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, MazeSettlementUIApi:GetString("ConfirmBtnText"))
end

function MazeSettlementUI:GetPreloadAssetPaths()
	return {
		UIGlobalApi.GetItemCellAssetPath()
	}
end

function MazeSettlementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeSettlementUI:OnOpen(userData)
	self:OnShow()
end

function MazeSettlementUI:OnClose(userData)
	return
end

function MazeSettlementUI:OnPause()
	return
end

function MazeSettlementUI:OnResume()
	return
end

function MazeSettlementUI:OnCover()
	return
end

function MazeSettlementUI:OnReveal()
	return
end

function MazeSettlementUI:OnRefocus(userData)
	return
end

function MazeSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeSettlementUI:OnDestroy()
	for i = 1, #self.RewardCells do
		local rewardCell = self.RewardCells[i]

		rewardCell:Dispose()
	end

	self.RewardCells = nil

	local scrollListComponent = self.ItemGrid:GetComponent("ScrollAreaList")

	scrollListComponent.onRenderCell = nil
end

function MazeSettlementUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnQuitMaze)
end

function MazeSettlementUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnQuitMaze)
end

function MazeSettlementUI:OnQuitMaze()
	UIModule.Close(Constant.UIControllerName.MazeSettlementUI)
	MazeModule.ExitMaze()
end

function MazeSettlementUI:Clear()
	self.NoItemNoticeText:SetActive(false)
end

function MazeSettlementUI:OnShow()
	self:Clear()
	self.Content:SetActive(true)
	self.ConfirmBtn:SetActive(true)

	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]

	UGUIUtil.SetText(self.MazeNameText, MazeSettlementUIApi:GetString("MazeNameText", cfgChapterData.Order, cfgMazeInstanceData.Order, cfgMazeInstanceData.Name))
	self:ShowItems()
end

function MazeSettlementUI:ShowItems()
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

return MazeSettlementUI
