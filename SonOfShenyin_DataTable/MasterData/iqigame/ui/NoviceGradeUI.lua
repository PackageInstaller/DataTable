-- chunkname: @IQIGame\\UI\\NoviceGradeUI.lua

local NoviceGradeUI = {
	TaskCellList = {},
	TaskDatas = {}
}

NoviceGradeUI = Base:Extend("NoviceGradeUI", "IQIGame.Onigao.UI.NoviceGradeUI", NoviceGradeUI)

local noviceGradeTaskCell = require("IQIGame.UI.NoviceGradeUI.NoviceGradeTaskCell")
local constant_RefreshActivityLeftTimeIntervalSec = 1

function NoviceGradeUI:OnInit()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.activityRemainingTimeTimer = Timer.New(function()
		self:RefreshActivityLeftTime()
	end, constant_RefreshActivityLeftTimeIntervalSec, -1)
	self.taskScroll = self.gradeScroll:GetComponent("OptimizedScrollRect")

	self.taskScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateTaskScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	function self.DelegateOnTaskNotifyTask(tasks)
		self:OnTaskNotifyTask(tasks)
	end

	function self.DelegateOnTaskNotifyFinish(tasks)
		self:OnTaskNotifyFinish(tasks)
	end
end

function NoviceGradeUI:GetPreloadAssetPaths()
	return nil
end

function NoviceGradeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function NoviceGradeUI:IsManualShowOnOpen(userData)
	return false
end

function NoviceGradeUI:GetBGM(userData)
	return nil
end

function NoviceGradeUI:OnOpen(userData)
	self:Refresh()
	self:RefreshActivityLeftTime()
	self.activityRemainingTimeTimer:Start()
end

function NoviceGradeUI:Refresh()
	self.TaskDatas = TaskSystemModule.GetTaskListByConfig(Constant.MainTaskType.Novice_7_DAY_GRADE)

	self.taskScroll:RefreshByItemCount(#self.TaskDatas)
end

function NoviceGradeUI:UpdateTaskScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex

	if not self.TaskCellList[instanceID] then
		self.TaskCellList[instanceID] = noviceGradeTaskCell.New(viewGameObject)
	end

	self.TaskCellList[instanceID]:Refresh(self.TaskDatas[index + 1])
end

function NoviceGradeUI:OnClose(userData)
	self.activityRemainingTimeTimer:Stop()
end

function NoviceGradeUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyTask)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyFinish)
end

function NoviceGradeUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyTask)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyFinish)
end

function NoviceGradeUI:OnPause()
	return
end

function NoviceGradeUI:OnResume()
	return
end

function NoviceGradeUI:OnCover()
	return
end

function NoviceGradeUI:OnReveal()
	return
end

function NoviceGradeUI:OnRefocus(userData)
	return
end

function NoviceGradeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function NoviceGradeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function NoviceGradeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function NoviceGradeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function NoviceGradeUI:OnDestroy()
	for i, v in pairs(self.TaskCellList) do
		v:Dispose()
	end

	self.commonReturnBtn:Dispose()

	if self.activityRemainingTimeTimer.running then
		self.activityRemainingTimeTimer:Stop()
	end

	self.activityRemainingTimeTimer = nil

	AssetUtil.UnloadAsset(self)
end

function NoviceGradeUI:OnTaskNotifyTask(tasks)
	self:OnTaskNotifyFinish(tasks)
end

function NoviceGradeUI:OnTaskNotifyFinish(tasks)
	self:Refresh()
end

function NoviceGradeUI:RefreshActivityLeftTime()
	local activityLeftSecondTime = tonumber(ActivityModule.GetActivityPodByID(Constant.ActivityID.NOVICE_7_GRADE).closeDateTime) / 1000 - PlayerModule.GetServerTime()

	if activityLeftSecondTime < 0 then
		activityLeftSecondTime = 0
	end

	UGUIUtil.SetText(self.timeText, NoviceTaskUIApi:GetTimeFormat(activityLeftSecondTime))
end

return NoviceGradeUI
