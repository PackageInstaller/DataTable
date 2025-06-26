-- chunkname: @IQIGame\\UI\\GrowthFundUI.lua

require("IQIGame.UIExternalApi.GrowthFundUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local GrowthFundTaskCell = require("IQIGame.UI.GrowthFund.GrowthFundTaskCell")
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")
local GrowthFundUI = {
	MallCid = 0,
	TaskCells = {}
}

GrowthFundUI = Base:Extend("GrowthFundUI", "IQIGame.Onigao.UI.GrowthFundUI", GrowthFundUI)

function GrowthFundUI:OnInit()
	function self.DelegateOnClickClaimRewardBtn()
		self:OnClickClaimRewardBtn()
	end

	function self.DelegateOnClickBuyFundBtn()
		self:OnClickBuyFundBtn()
	end

	function self.DelegateOnClickSpeedUpBtn()
		self:OnClickSpeedUpBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnTaskCommitResponse(cids, rewards)
		self:OnTaskCommitResponse(cids, rewards)
	end

	function self.DelegateOnTaskUpdate(cid)
		self:OnTaskUpdate(cid)
	end

	function self.DelegateOnNotifyPayInfo()
		self:OnNotifyPayInfo()
	end

	self.TaskCellPool = UIObjectPool.New(10, function()
		return GrowthFundTaskCell.New(UnityEngine.Object.Instantiate(self.TaskCellPrefab))
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	UGUIUtil.SetText(self.ClaimTipLabel, GrowthFundUIApi:GetClaimTipLabel())
	UGUIUtil.SetText(self.ClaimTipDescText, GrowthFundUIApi:GetClaimTipDescText())
	UGUIUtil.SetText(self.LockViewLabel, GrowthFundUIApi:GetLockViewLabel())
	UGUIUtil.SetText(self.RewardViewLabel, GrowthFundUIApi:GetRewardViewLabel())
	UGUIUtil.SetTextInChildren(self.SpeedUpUnlockView, GrowthFundUIApi:GetSpeedUpUnlockViewText())
	UGUIUtil.SetTextInChildren(self.SpeedUpLockView, GrowthFundUIApi:GetSpeedUpLockViewText())
	UGUIUtil.SetTextInChildren(self.ClaimRewardBtn, GrowthFundUIApi:GetClaimRewardBtnText())
	UGUIUtil.SetTextInChildren(self.DisabledClaimBtn, GrowthFundUIApi:GetDisabledClaimBtnText())

	self.MallCid = GrowthFundUIApi:GetString("GrowthFundMallCid")
end

function GrowthFundUI:GetPreloadAssetPaths()
	return nil
end

function GrowthFundUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GrowthFundUI:IsManualShowOnOpen(userData)
	return false
end

function GrowthFundUI:GetBGM(userData)
	return nil
end

function GrowthFundUI:OnOpen(userData)
	self:UpdateView()
end

function GrowthFundUI:OnClose(userData)
	return
end

function GrowthFundUI:OnAddListeners()
	self.ClaimRewardBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClaimRewardBtn)
	self.BuyFundBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBuyFundBtn)
	self.SpeedUpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSpeedUpBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.AddEventListener(EventID.NotifyPayInfo, self.DelegateOnNotifyPayInfo)
end

function GrowthFundUI:OnRemoveListeners()
	self.ClaimRewardBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClaimRewardBtn)
	self.BuyFundBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBuyFundBtn)
	self.SpeedUpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSpeedUpBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.RemoveEventListener(EventID.NotifyPayInfo, self.DelegateOnNotifyPayInfo)
end

function GrowthFundUI:OnPause()
	return
end

function GrowthFundUI:OnResume()
	return
end

function GrowthFundUI:OnCover()
	return
end

function GrowthFundUI:OnReveal()
	return
end

function GrowthFundUI:OnRefocus(userData)
	return
end

function GrowthFundUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GrowthFundUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GrowthFundUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GrowthFundUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GrowthFundUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:ClearTaskCells()
	self.TaskCellPool:Dispose()
end

function GrowthFundUI:OnClickClaimRewardBtn()
	local taskDataList, claimableList = self:GetTaskDataList()
	local cids = {}

	for i = 1, #claimableList do
		local taskData = claimableList[i]

		table.insert(cids, taskData.cid)
	end

	TaskModule.SendCommitTaskMsgBatch(cids)
end

function GrowthFundUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function GrowthFundUI:OnClickBuyFundBtn()
	MallModule.BuyMall(1010501024, 1)
end

function GrowthFundUI:OnClickSpeedUpBtn()
	UIModule.Open(Constant.UIControllerName.ExpBonusUI, Constant.UILayer.UI)
end

function GrowthFundUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function GrowthFundUI:UpdateView()
	self:ClearTaskCells()

	local taskDataList, claimableList = self:GetTaskDataList()

	for i = 1, #taskDataList do
		local taskData = taskDataList[i]
		local taskCell = self.TaskCellPool:Obtain()

		taskCell.View:SetActive(true)
		taskCell.View.transform:SetParent(self.CellGrid.transform, false)
		taskCell:SetData(taskData)
		table.insert(self.TaskCells, taskCell)
	end

	local totalRewardNum = 0

	for i = 1, #taskDataList do
		local taskData = taskDataList[i]
		local cfgMainQuestData = CfgMainQuestTable[taskData.cid]

		for j = 1, #cfgMainQuestData.Reward, 2 do
			local itemCid = cfgMainQuestData.Reward[j]
			local itemNum = cfgMainQuestData.Reward[j + 1]

			if itemCid == Constant.ItemID.TREASURE then
				totalRewardNum = totalRewardNum + itemNum
			end
		end
	end

	UGUIUtil.SetText(self.ClaimTipTreasureNumText, GrowthFundUIApi:GetClaimTipTreasureNumText(totalRewardNum))
	self:UpdateActiveOrTaskInfo(taskDataList, claimableList)
	self:UpdateSpeedUpInfo()
end

function GrowthFundUI:ClearTaskCells()
	for i = 1, #self.TaskCells do
		local cell = self.TaskCells[i]

		cell:Reset()
		cell.View.transform:SetParent(self.UIController.transform, false)
		cell.View:SetActive(false)
		self.TaskCellPool:Release(cell)
	end

	self.TaskCells = {}
end

function GrowthFundUI:UpdateActiveOrTaskInfo(taskDataList, claimableList)
	local leftBuyCount = MallModule.GetResidueBuyTimes(self.MallCid)
	local isActive = leftBuyCount == 0

	self.LockView:SetActive(not isActive)
	self.UnlockView:SetActive(isActive)

	if not isActive then
		local cfgMallData = CfgMallTable[self.MallCid]
		local cfgPayData = CfgPayTable[cfgMallData.PayMoney]

		UGUIUtil.SetTextInChildren(self.BuyFundBtn, GrowthFundUIApi:GetBuyFundBtnText(cfgPayData.Amount))
	else
		local hasReward = #claimableList > 0

		self.RewardView:SetActive(hasReward)
		self.TargetView:SetActive(not hasReward)

		if hasReward then
			local rewardTreasureNum = 0

			for i = 1, #claimableList do
				local taskData = claimableList[i]
				local cfgMainQuestData = CfgMainQuestTable[taskData.cid]

				for j = 1, #cfgMainQuestData.Reward, 2 do
					local itemCid = cfgMainQuestData.Reward[j]
					local itemNum = cfgMainQuestData.Reward[j + 1]

					if itemCid == Constant.ItemID.TREASURE then
						rewardTreasureNum = rewardTreasureNum + itemNum
					end
				end
			end

			UGUIUtil.SetText(self.RewardViewTreasureNumText, GrowthFundUIApi:GetRewardViewTreasureNumText(rewardTreasureNum))
		else
			local nextTaskData

			for i = 1, #taskDataList do
				local taskData = taskDataList[i]

				if taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK then
					nextTaskData = taskData

					break
				end
			end

			if nextTaskData ~= nil then
				local cfgMainQuestData = CfgMainQuestTable[nextTaskData.cid]
				local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]
				local diff = cfgTargetData.TargetNum - PlayerModule.PlayerInfo.baseInfo.pLv

				UGUIUtil.SetText(self.TargetViewTipText, GrowthFundUIApi:GetTargetViewTipText(diff))
			else
				UGUIUtil.SetText(self.TargetViewTipText, GrowthFundUIApi:GetTargetViewTipText(0))
			end
		end
	end
end

function GrowthFundUI:UpdateSpeedUpInfo()
	local isSpeedUpActive = PlayerModule.PlayerInfo.baseInfo.pLv < CfgDiscreteDataTable[6520062].Data[1]

	self.SpeedUpView:SetActive(isSpeedUpActive)

	if isSpeedUpActive then
		self.SpeedUpLockView:SetActive(not PlayerModule.PlayerInfo.advanceLevelChaseFlag)
		self.SpeedUpUnlockView:SetActive(PlayerModule.PlayerInfo.advanceLevelChaseFlag)

		local num1 = math.floor(PlayerModule.PlayerInfo.baseInfo.pLv / 10)
		local num2 = PlayerModule.PlayerInfo.baseInfo.pLv % 10

		AssetUtil.LoadImage(self, GrowthFundUIApi:GetNumImage(num1), self.SpeedUpLevelImage1:GetComponent("Image"))
		AssetUtil.LoadImage(self, GrowthFundUIApi:GetNumImage(num2), self.SpeedUpLevelImage2:GetComponent("Image"))
	end
end

function GrowthFundUI:GetTaskDataList()
	local taskDataList = {}
	local claimable = {}
	local leftBuyCount = MallModule.GetResidueBuyTimes(self.MallCid)
	local isActive = leftBuyCount == 0

	if isActive then
		local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.GROWTH_FUND_TASK)
		local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.GROWTH_FUND_TASK)

		for i = 1, #processing do
			local taskData = processing[i]
			local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

			table.insert(taskDataList, uiTaskData)

			if uiTaskData.CurrentNum >= uiTaskData.TargetNum then
				table.insert(claimable, uiTaskData)
			end
		end

		for i = 1, #finished do
			local taskCid = finished[i]
			local cfgMainQuestData = CfgMainQuestTable[taskCid]

			if cfgMainQuestData.FinishIsShow == 1 then
				local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]
				local uiTaskData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

				table.insert(taskDataList, uiTaskData)
			end
		end
	else
		for id, cfgMainQuestData in pairsCfg(CfgMainQuestTable) do
			if cfgMainQuestData.Type == TaskModule.TaskType.GROWTH_FUND_TASK then
				local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]
				local uiTaskData = TaskUIData.New(id, 0, cfgTargetData.TargetNum, TaskModule.TaskStatus.CURRENT_TASK)

				table.insert(taskDataList, uiTaskData)
			end
		end
	end

	table.sort(taskDataList, function(data1, data2)
		return data1.cid < data2.cid
	end)

	return taskDataList, claimable
end

function GrowthFundUI:OnTaskUpdate(cid)
	local cfgMainQuestData = CfgMainQuestTable[cid]

	if cfgMainQuestData.Type == TaskModule.TaskType.GROWTH_FUND_TASK then
		self:UpdateView()
	end
end

function GrowthFundUI:OnNotifyPayInfo(mallCid)
	self:UpdateView()
end

return GrowthFundUI
