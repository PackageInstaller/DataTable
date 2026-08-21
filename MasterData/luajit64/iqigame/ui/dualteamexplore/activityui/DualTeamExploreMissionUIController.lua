-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreMissionUIController.lua

require("IQIGame.UIExternalApi.DualTeamExploreMissionUIApi")

local DualTeamExploreMissionItem = require("IQIGame.UI.DualTeamExplore.DualTeamExploreMissionItem")
local DualTeamExploreMissionRewardCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreMissionRewardCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local DualTeamExploreMissionUIController = {
	TaskUpdateFrame = -1,
	MissionItems = {}
}

function DualTeamExploreMissionUIController.New(uiController)
	local obj = Clone(DualTeamExploreMissionUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreMissionUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreMissionUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreMissionUIController:OnInit()
	function self.DelegateOnClickGetAllBtn()
		self:OnClickGetAllBtn()
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

	local scrollAreaList = self.TaskScrollList:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderTaskCell(cell)
	end

	self.RewardCellPool = UIObjectPool.New(5, function()
		return DualTeamExploreMissionRewardCell.New(UnityEngine.Object.Instantiate(self.RewardCellPrefab))
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Instantiate(v)
	end)

	UGUIUtil.SetText(self.TitleText, DualTeamExploreMissionUIApi:GetString("TitleText", DualTeamExploreModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetText(self.TitleText2, DualTeamExploreMissionUIApi:GetString("TitleText2"))
	UGUIUtil.SetTextInChildren(self.GetAllBtn, DualTeamExploreMissionUIApi:GetString("GetAllBtnText"))
end

function DualTeamExploreMissionUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreMissionUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreMissionUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreMissionUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreMissionUIController:OnOpen(userData)
	self:UpdateView()
end

function DualTeamExploreMissionUIController:OnClose(userData)
	self.TaskUpdateFrame = -1
end

function DualTeamExploreMissionUIController:OnAddListeners()
	self.GetAllBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGetAllBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function DualTeamExploreMissionUIController:OnRemoveListeners()
	self.GetAllBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGetAllBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function DualTeamExploreMissionUIController:OnPause()
	return
end

function DualTeamExploreMissionUIController:OnResume()
	return
end

function DualTeamExploreMissionUIController:OnCover()
	return
end

function DualTeamExploreMissionUIController:OnReveal()
	return
end

function DualTeamExploreMissionUIController:OnRefocus(userData)
	return
end

function DualTeamExploreMissionUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.TaskUpdateFrame ~= -1 and UnityEngine.Time.frameCount - self.TaskUpdateFrame > 1 then
		self:UpdateView()

		self.TaskUpdateFrame = -1
	end
end

function DualTeamExploreMissionUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreMissionUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreMissionUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreMissionUIController:OnDestroy()
	for gameObject, item in pairs(self.MissionItems) do
		item:Dispose()
	end

	self.RewardCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreMissionUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function DualTeamExploreMissionUIController:UpdateView()
	self.TaskDataList = self:GetTaskDataList()

	local scrollAreaList = self.TaskScrollList:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.TaskDataList)
	self.EmptyView:SetActive(#self.TaskDataList == 0)

	local canGetRewardTaskCids = self:GetCanGetRewardTaskCids(self.TaskDataList)

	self.GetAllBtn:SetActive(#canGetRewardTaskCids > 0)
	self.DisabledGetAllBtn:SetActive(#canGetRewardTaskCids == 0)
end

function DualTeamExploreMissionUIController:OnRenderTaskCell(cell)
	local missionItem = self.MissionItems[cell.gameObject]

	if missionItem == nil then
		missionItem = DualTeamExploreMissionItem.New(cell.gameObject, self.RewardCellPool)
		self.MissionItems[cell.gameObject] = missionItem
	end

	missionItem:SetData(self.TaskDataList[cell.index + 1])
end

function DualTeamExploreMissionUIController:GetTaskDataList()
	local taskDataList = DualTeamExploreModule.GetTaskDataList()

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

function DualTeamExploreMissionUIController:OnClickGetAllBtn()
	if self.TaskUpdateFrame ~= -1 then
		return
	end

	local canGetRewardTaskCids = self:GetCanGetRewardTaskCids(self.TaskDataList)

	if #canGetRewardTaskCids == 0 then
		return
	end

	TaskModule.SendCommitTaskMsgBatch(canGetRewardTaskCids)
end

function DualTeamExploreMissionUIController:GetCanGetRewardTaskCids(allTaskDataList)
	local canGetRewardTaskCids = {}

	for i, taskUIData in pairs(allTaskDataList) do
		if taskUIData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and taskUIData.CurrentNum >= taskUIData.TargetNum then
			table.insert(canGetRewardTaskCids, taskUIData.cid)
		end
	end

	return canGetRewardTaskCids
end

function DualTeamExploreMissionUIController:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function DualTeamExploreMissionUIController:OnTaskUpdate(cid)
	self.TaskUpdateFrame = UnityEngine.Time.frameCount
end

return DualTeamExploreMissionUIController
