-- chunkname: @IQIGame\\UI\\DreamlandLevelMissionUI.lua

local DreamlandLevelMissionUI = {
	BranchTaskItems = {}
}

DreamlandLevelMissionUI = Base:Extend("DreamlandLevelMissionUI", "IQIGame.Onigao.UI.DreamlandLevelMissionUI", DreamlandLevelMissionUI)

require("IQIGame.UIExternalApi.DreamlandLevelMissionUIApi")

local DreamlandLevelTaskItem = require("IQIGame.UI.Dreamland.DreamlandLevelTaskItem")

function DreamlandLevelMissionUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickFullScreenCloseBtn()
		self:OnClickFullScreenCloseBtn()
	end

	function self.DelegateOnTaskCommitResponse(cids, rewards)
		self:OnTaskCommitResponse(cids, rewards)
	end

	function self.DelegateOnTaskUpdate(cid)
		self:OnTaskUpdate(cid)
	end

	self.TaskRewardPool = DreamlandLevelTaskItem.CreateRewardPool(12, self.RewardCellPrefab)
	self.MainTaskItem = DreamlandLevelTaskItem.New(self.MainTaskItemGO, self.TaskRewardPool, DreamlandLevelMissionUIApi, true)

	local scrollAreaList = self.BranchTaskScrollArea:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderBranchTaskCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, DreamlandLevelMissionUIApi:GetString("TitleText"))
end

function DreamlandLevelMissionUI:GetPreloadAssetPaths()
	return nil
end

function DreamlandLevelMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DreamlandLevelMissionUI:IsManualShowOnOpen(userData)
	return false
end

function DreamlandLevelMissionUI:GetBGM(userData)
	return nil
end

function DreamlandLevelMissionUI:OnOpen(userData)
	self:UpdateView()
end

function DreamlandLevelMissionUI:OnClose(userData)
	return
end

function DreamlandLevelMissionUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFullScreenCloseBtn)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function DreamlandLevelMissionUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFullScreenCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function DreamlandLevelMissionUI:OnPause()
	return
end

function DreamlandLevelMissionUI:OnResume()
	return
end

function DreamlandLevelMissionUI:OnCover()
	return
end

function DreamlandLevelMissionUI:OnReveal()
	return
end

function DreamlandLevelMissionUI:OnRefocus(userData)
	return
end

function DreamlandLevelMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DreamlandLevelMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DreamlandLevelMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DreamlandLevelMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DreamlandLevelMissionUI:OnDestroy()
	self.MainTaskItem:Dispose()

	for gameObject, item in pairs(self.BranchTaskItems) do
		item:Dispose()
	end

	self.TaskRewardPool:Dispose()
end

function DreamlandLevelMissionUI:UpdateView()
	local mainTaskUIData = DreamlandModule.GetSerialTaskData(2)

	if mainTaskUIData ~= nil then
		self.MainTaskItem:SetData(mainTaskUIData)
	end

	self.BranchTaskDataList = self:GetTaskData(3)

	local firstNewTaskIndex = 1

	for i = 1, #self.BranchTaskDataList do
		local taskUIData = self.BranchTaskDataList[i]

		if DreamlandModule.IsNewTask(taskUIData.cid) then
			firstNewTaskIndex = i

			break
		end
	end

	local scrollAreaList = self.BranchTaskScrollArea:GetComponent("ScrollAreaList")

	scrollAreaList.defaultSelectedToggle = firstNewTaskIndex - 1

	scrollAreaList:Refresh(#self.BranchTaskDataList)
end

function DreamlandLevelMissionUI:GetTaskData(childType)
	local taskDataList = DreamlandModule.GetTaskDataList(childType)

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

function DreamlandLevelMissionUI:OnRenderBranchTaskCell(cell)
	local item = self.BranchTaskItems[cell.gameObject]

	if item == nil then
		item = DreamlandLevelTaskItem.New(cell.gameObject, self.TaskRewardPool, DreamlandLevelMissionUIApi, true)
		self.BranchTaskItems[cell.gameObject] = item
	end

	item:SetData(self.BranchTaskDataList[cell.index + 1])
end

function DreamlandLevelMissionUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function DreamlandLevelMissionUI:OnClickFullScreenCloseBtn()
	UIModule.CloseSelf(self)
end

function DreamlandLevelMissionUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function DreamlandLevelMissionUI:OnTaskUpdate(cid)
	self:UpdateView(false)
end

return DreamlandLevelMissionUI
