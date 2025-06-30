-- chunkname: @IQIGame\\UI\\ActivityList\\NoviceSignActivity\\NoviceSignActivityView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local NoviceSignItemClass = require("IQIGame.UI.NoviceSign.NoviceSignItem")
local constant_RefreshActivityLeftTimeIntervalSec = 1
local m = Clone(ActivityViewBase)

m.signViewList = {}

function m:__Init()
	self.activityRemainingTimeTimer = Timer.New(function()
		self:RefreshActivityLeftTime()
	end, constant_RefreshActivityLeftTimeIntervalSec, -1)

	for i = 1, 7 do
		self.signViewList[i] = NoviceSignItemClass.New(LuaUtility.GetChild(self.noviceSignContent.transform, i - 1).gameObject, self)
	end

	function self.noviceSignEventDelegate()
		self:NoviceSignFresh()
	end

	self:InitSignData()
	self:RefreshActivityLeftTime()
	self.activityRemainingTimeTimer:Start()
end

function m:__AddListeners()
	EventDispatcher.AddEventListener(EventID.NoviceSignEvent, self.noviceSignEventDelegate)
end

function m:__RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.NoviceSignEvent, self.noviceSignEventDelegate)
end

function m:__Dispose()
	self.activityRemainingTimeTimer:Stop()
end

function m:NoviceSignFresh()
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

function m:InitSignData()
	self.signTask = {}

	local list = TaskSystemModule.GetTaskListByConfig(Constant.MainTaskType.Novice_7_DAY_SIGN)

	for k, task in pairs(list) do
		table.insert(self.signTask, task)
	end

	TaskSystemModule.TaskSortFunc(TaskSystemModule.sortType.Schedule, self.signTask)
	self:RefreshSignItemData()
end

function m:RefreshSignItemData()
	for i = 1, #self.signViewList do
		self.signViewList[i]:Refresh(self.signTask[i])
	end
end

function m:RefreshActivityLeftTime()
	local activityLeftSecondTime = tonumber(ActivityModule.GetActivityPodByID(Constant.ActivityID.Novice_7_SIGN).closeDateTime) / 1000 - PlayerModule.GetServerTime()

	if activityLeftSecondTime < 0 then
		activityLeftSecondTime = 0
	end

	UGUIUtil.SetText(self.timeText, NoviceTaskUIApi:GetTimeFormat(activityLeftSecondTime))
end

return m
