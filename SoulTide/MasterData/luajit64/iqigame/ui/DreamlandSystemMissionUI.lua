-- chunkname: @IQIGame\\UI\\DreamlandSystemMissionUI.lua

local DreamlandSystemMissionUI = {
	TaskItems = {}
}

DreamlandSystemMissionUI = Base:Extend("DreamlandSystemMissionUI", "IQIGame.Onigao.UI.DreamlandSystemMissionUI", DreamlandSystemMissionUI)

require("IQIGame.UIExternalApi.DreamlandSystemMissionUIApi")

local DreamlandLevelTaskItem = require("IQIGame.UI.Dreamland.DreamlandLevelTaskItem")

function DreamlandSystemMissionUI:OnInit()
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

	function self.DelegateBtnGetAll()
		self:OnBtnGetAll()
	end

	self.TaskRewardPool = DreamlandLevelTaskItem.CreateRewardPool(12, self.RewardCellPrefab)

	local scrollAreaList = self.TaskScrollArea:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderTaskCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, DreamlandSystemMissionUIApi:GetString("TitleText"))
end

function DreamlandSystemMissionUI:GetPreloadAssetPaths()
	return nil
end

function DreamlandSystemMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DreamlandSystemMissionUI:IsManualShowOnOpen(userData)
	return false
end

function DreamlandSystemMissionUI:GetBGM(userData)
	return nil
end

function DreamlandSystemMissionUI:OnOpen(userData)
	self:UpdateView()
end

function DreamlandSystemMissionUI:OnClose(userData)
	return
end

function DreamlandSystemMissionUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFullScreenCloseBtn)
	self.BtnGetAll:GetComponent("Button").onClick:AddListener(self.DelegateBtnGetAll)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function DreamlandSystemMissionUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFullScreenCloseBtn)
	self.BtnGetAll:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnGetAll)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function DreamlandSystemMissionUI:OnPause()
	return
end

function DreamlandSystemMissionUI:OnResume()
	return
end

function DreamlandSystemMissionUI:OnCover()
	return
end

function DreamlandSystemMissionUI:OnReveal()
	return
end

function DreamlandSystemMissionUI:OnRefocus(userData)
	return
end

function DreamlandSystemMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DreamlandSystemMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DreamlandSystemMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DreamlandSystemMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DreamlandSystemMissionUI:OnDestroy()
	for gameObject, item in pairs(self.TaskItems) do
		item:Dispose()
	end

	self.TaskRewardPool:Dispose()
end

function DreamlandSystemMissionUI:UpdateView()
	self.TaskDataList = self:GetTaskData(1)

	local scrollAreaList = self.TaskScrollArea:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.TaskDataList)

	local tasks = self:GetRewardTasks()

	self.BtnGetAll:SetActive(#tasks > 0)
end

function DreamlandSystemMissionUI:GetTaskData(childType)
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

function DreamlandSystemMissionUI:OnRenderTaskCell(cell)
	local item = self.TaskItems[cell.gameObject]

	if item == nil then
		item = DreamlandLevelTaskItem.New(cell.gameObject, self.TaskRewardPool, DreamlandSystemMissionUIApi, false)
		self.TaskItems[cell.gameObject] = item
	end

	item:SetData(self.TaskDataList[cell.index + 1])
end

function DreamlandSystemMissionUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function DreamlandSystemMissionUI:OnClickFullScreenCloseBtn()
	UIModule.CloseSelf(self)
end

function DreamlandSystemMissionUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function DreamlandSystemMissionUI:OnTaskUpdate(cid)
	self:UpdateView()
end

function DreamlandSystemMissionUI:GetRewardTasks()
	local tasks = {}

	for i, v in pairs(self.TaskDataList) do
		if v.TaskStatus ~= TaskModule.TaskStatus.FINISH_TASK and v.CurrentNum >= v.TargetNum then
			table.insert(tasks, v.cid)
		end
	end

	return tasks
end

function DreamlandSystemMissionUI:OnBtnGetAll()
	local tasks = self:GetRewardTasks()

	if #tasks > 0 then
		TaskModule.SendCommitTaskMsgBatch(tasks)
	end
end

return DreamlandSystemMissionUI
