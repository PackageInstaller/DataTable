-- chunkname: @IQIGame\\UI\\NoviceSignUI.lua

local NoviceSignUI = {
	signViewList = {}
}

NoviceSignUI = Base:Extend("NoviceSignUI", "IQIGame.Onigao.UI.NoviceSignUI", NoviceSignUI)

local NoviceSignItemClass = require("IQIGame.UI.NoviceSign.NoviceSignItem")
local constant_RefreshActivityLeftTimeIntervalSec = 1

function NoviceSignUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function NoviceSignUI:InitMembers()
	self.signViewList = {}
end

function NoviceSignUI:InitComponent()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.activityRemainingTimeTimer = Timer.New(function()
		self:RefreshActivityLeftTime()
	end, constant_RefreshActivityLeftTimeIntervalSec, -1)

	for i = 1, 7 do
		self.signViewList[i] = NoviceSignItemClass.New(LuaUtility.GetChild(self.noviceSignContent.transform, i).gameObject, self)
	end
end

function NoviceSignUI:InitDelegate()
	function self.noviceSignEventDelegate()
		self:NoviceSignFresh()
	end
end

function NoviceSignUI:GetPreloadAssetPaths()
	return nil
end

function NoviceSignUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function NoviceSignUI:IsManualShowOnOpen(userData)
	return false
end

function NoviceSignUI:GetBGM(userData)
	return nil
end

function NoviceSignUI:OnOpen(userData)
	self:InitSignData()
	self:RefreshActivityLeftTime()
	self.activityRemainingTimeTimer:Start()
end

function NoviceSignUI:OnClose(userData)
	self.activityRemainingTimeTimer:Stop()
end

function NoviceSignUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.NoviceSignEvent, self.noviceSignEventDelegate)
end

function NoviceSignUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.NoviceSignEvent, self.noviceSignEventDelegate)
end

function NoviceSignUI:OnPause()
	return
end

function NoviceSignUI:OnResume()
	return
end

function NoviceSignUI:OnCover()
	return
end

function NoviceSignUI:OnReveal()
	return
end

function NoviceSignUI:OnRefocus(userData)
	return
end

function NoviceSignUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function NoviceSignUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function NoviceSignUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function NoviceSignUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function NoviceSignUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for k, v in pairs(self.signViewList) do
		v:Dispose()
	end

	if self.activityRemainingTimeTimer.running then
		self.activityRemainingTimeTimer:Stop()
	end

	self.activityRemainingTimeTimer = nil
end

function NoviceSignUI:InitSignData()
	self.signTask = {}

	local list = TaskSystemModule.GetTaskListByConfig(Constant.MainTaskType.Novice_7_DAY_SIGN)

	for k, task in pairs(list) do
		table.insert(self.signTask, task)
	end

	TaskSystemModule.TaskSortFunc(TaskSystemModule.sortType.Schedule, self.signTask)
	self:RefreshSignItemData()
end

function NoviceSignUI:NoviceSignFresh()
	if #self.signTask <= 0 then
		return
	end

	local isFinish = false

	for i = 1, #self.signTask do
		if self.signTask[i].status ~= Constant.TaskStatus.hadGot then
			isFinish = false

			break
		end

		isFinish = true
	end

	if isFinish then
		LuaUtility.SetGameObjectShow(self.finishState, true)
	end

	self:RefreshSignItemData()
end

function NoviceSignUI:RefreshSignItemData()
	for i = 1, #self.signViewList do
		self.signViewList[i]:Refresh(self.signTask[i])
	end
end

function NoviceSignUI:RefreshActivityLeftTime()
	local activityLeftSecondTime = tonumber(ActivityModule.GetActivityPodByID(Constant.ActivityID.Novice_7_SIGN).closeDateTime) / 1000 - PlayerModule.GetServerTime()

	if activityLeftSecondTime < 0 then
		activityLeftSecondTime = 0
	end

	UGUIUtil.SetText(self.timeText, NoviceTaskUIApi:GetTimeFormat(activityLeftSecondTime))
end

return NoviceSignUI
