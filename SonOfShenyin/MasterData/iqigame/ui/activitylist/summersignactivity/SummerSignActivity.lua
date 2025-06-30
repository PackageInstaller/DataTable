-- chunkname: @IQIGame\\UI\\ActivityList\\SummerSignActivity\\SummerSignActivity.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local summerSignActivityItemCell = require("IQIGame/UI/ActivityList/SummerSignActivity/SummerSignActivityItemCell")
local m = Clone(ActivityViewBase)

function m:__Init()
	function self.DelegateOnTaskNotifyFinish()
		self:OnTaskNotifyFinish()
	end

	self.signItemList = {}

	for i = 1, 7 do
		table.insert(self.signItemList, summerSignActivityItemCell.New(self["ItemDetailPrefab" .. i]))
	end
end

function m:__AddListeners()
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyFinish)
end

function m:__RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyFinish)
end

function m:__SetData(activityListcfg)
	self.activityListcfg = activityListcfg
	self.activityCfg = CfgActivityTable[activityListcfg.ActivityID[1]]

	local subTypes = {}

	for i = 2, #self.activityCfg.ExtraParam do
		table.insert(subTypes, self.activityCfg.ExtraParam[i])
	end

	self.signTaskList = TaskSystemModule.GetTaskListByConfig(self.activityCfg.ExtraParam[1], subTypes)

	table.sort(self.signTaskList, function(a, b)
		return a.cid < b.cid
	end)

	for i = 1, table.len(self.signTaskList) do
		self.signItemList[i]:SetData(self.signTaskList[i])
	end

	self:RefreshCountdown()
end

function m:RefreshCountdown()
	self.endTime = cfgDateTimeToTimeStamp(self.activityCfg.OpenTime) + self.activityCfg.Duration[1]

	self:UpdateSurplusTime()
	self:StopTimer()

	if self.timer == nil then
		self.timer = Timer.New(function()
			self:UpdateSurplusTime()
		end, 1, -1)

		self.timer:Start()
	end
end

function m:UpdateSurplusTime()
	local surplusTime = math.floor(self.endTime - tonumber(PlayerModule.GetServerTime()))

	surplusTime = math.max(0, surplusTime)

	UGUIUtil.SetText(self.timeText, DateStandardFormation(surplusTime))
end

function m:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end
end

function m:OnTaskNotifyFinish()
	self:__SetData(self.activityListcfg)
end

function m:__Dispose()
	for k, v in pairs(self.signItemList) do
		v:Dispose()
	end

	self:StopTimer()
end

return m
