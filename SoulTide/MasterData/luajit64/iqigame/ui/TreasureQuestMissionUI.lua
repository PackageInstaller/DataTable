-- chunkname: @IQIGame\\UI\\TreasureQuestMissionUI.lua

require("IQIGame.UIExternalApi.TreasureQuestMissionUIApi")

local TreasureQuestMissionUITaskItem = require("IQIGame.UI.Activity.FreeReward.TreasureQuestMissionUITaskItem")
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")
local TreasureQuestMissionUI = {
	TaskItemMap = {}
}

TreasureQuestMissionUI = Base:Extend("TreasureQuestMissionUI", "IQIGame.Onigao.UI.TreasureQuestMissionUI", TreasureQuestMissionUI)

function TreasureQuestMissionUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.MainRewardItemCell = ItemCell.New(self.CommonSlotUI, true, true, true)

	local scrollAreaList = self.TaskScrollArea:GetComponent("ScrollAreaListGroup")

	function scrollAreaList.onRenderGroupPage(renderPage, groupIndex)
		self:OnRenderTaskTitle(renderPage, groupIndex)
	end

	function scrollAreaList.onRenderGroupCell(renderCell, groupIndex, cellIndex)
		self:OnRenderTaskItem(renderCell, groupIndex, cellIndex)
	end
end

function TreasureQuestMissionUI:GetPreloadAssetPaths()
	return nil
end

function TreasureQuestMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TreasureQuestMissionUI:IsManualShowOnOpen(userData)
	return false
end

function TreasureQuestMissionUI:GetBGM(userData)
	return nil
end

function TreasureQuestMissionUI:OnOpen(userData)
	self:UpdateView(userData.cfgData)
end

function TreasureQuestMissionUI:OnClose(userData)
	return
end

function TreasureQuestMissionUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function TreasureQuestMissionUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function TreasureQuestMissionUI:OnPause()
	return
end

function TreasureQuestMissionUI:OnResume()
	return
end

function TreasureQuestMissionUI:OnCover()
	return
end

function TreasureQuestMissionUI:OnReveal()
	return
end

function TreasureQuestMissionUI:OnRefocus(userData)
	return
end

function TreasureQuestMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TreasureQuestMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TreasureQuestMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TreasureQuestMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TreasureQuestMissionUI:OnDestroy()
	self.MainRewardItemCell:Dispose()

	for instanceId, item in pairs(self.TaskItemMap) do
		item:Dispose()
	end
end

function TreasureQuestMissionUI:UpdateView(cfgData)
	self.CfgTreasureQuestRewardsData = cfgData

	UGUIUtil.SetText(self.DescText, self.CfgTreasureQuestRewardsData.Name)

	local taskTypeLen = 2
	local lengthList = {}

	self.TaskDataD2Arr = {}

	for i = 1, taskTypeLen do
		local taskList = self:GetTasks(i)

		self.TaskDataD2Arr[i] = taskList
		lengthList[i] = #taskList
	end

	local scrollAreaList = self.TaskScrollArea:GetComponent("ScrollAreaListGroup")

	scrollAreaList:RefreshOnLua(lengthList)

	local mainRewardItemCid = self.CfgTreasureQuestRewardsData.Reward[1]
	local mainRewardItemNum = self.CfgTreasureQuestRewardsData.Reward[2]

	self.MainRewardItemCell:SetItemByCID(mainRewardItemCid, mainRewardItemNum)

	local scoreItemCid = self.CfgTreasureQuestRewardsData.NumRequired[1]
	local needScore = self.CfgTreasureQuestRewardsData.NumRequired[2]
	local hasScoreItemNum = WarehouseModule.GetItemNumByCfgID(scoreItemCid)
	local progress = hasScoreItemNum / needScore

	if progress > 1 then
		progress = 1
	end

	UGUIUtil.SetText(self.ProgressText, TreasureQuestMissionUIApi:GetString("ProgressText", hasScoreItemNum, needScore))

	self.ProgressBar:GetComponent("Image").fillAmount = progress
end

function TreasureQuestMissionUI:GetTasks(childType)
	local taskDataList = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.FREE_REWARD_TASK, {
		childType
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.FREE_REWARD_TASK, {
		childType
	})

	for i = 1, #processing do
		local taskData = processing[i]
		local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(taskDataList, uiTaskData)
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

	table.sort(taskDataList, function(data1, data2)
		local finish1 = data1.TaskStatus == TaskModule.TaskStatus.FINISH_TASK and 1 or 0
		local finish2 = data2.TaskStatus == TaskModule.TaskStatus.FINISH_TASK and 1 or 0

		if finish1 == finish2 then
			local targetOK1 = data1.CurrentNum >= data1.TargetNum and 1 or 0
			local targetOK2 = data2.CurrentNum >= data2.TargetNum and 1 or 0

			if targetOK1 == targetOK2 then
				return data1.cid < data2.cid
			end

			return targetOK2 < targetOK1
		end

		return finish1 < finish2
	end)

	return taskDataList
end

function TreasureQuestMissionUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function TreasureQuestMissionUI:OnRenderTaskTitle(renderPage, groupIndex)
	UGUIUtil.SetTextInChildren(renderPage.prefabPage, TreasureQuestMissionUIApi:GetString("TaskTitleText", groupIndex + 1))
end

function TreasureQuestMissionUI:OnRenderTaskItem(cell, groupIndex, cellIndex)
	local item = self.TaskItemMap[cell.gameObject:GetInstanceID()]

	if item == nil then
		item = TreasureQuestMissionUITaskItem.New(cell.gameObject)
		self.TaskItemMap[cell.gameObject:GetInstanceID()] = item
	end

	local taskList = self.TaskDataD2Arr[groupIndex + 1]

	item:SetData(taskList[cellIndex + 1])
end

return TreasureQuestMissionUI
