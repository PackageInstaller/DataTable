-- chunkname: @IQIGame\\UI\\ActiveActivityList\\GhostActivity\\GhostGameActivityView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local m = Clone(ActivityViewBase)

function m:__Init(view)
	self:InitDelegate()
end

function m:InitDelegate()
	function self.delegateOnClickStartBtnEvent()
		self:OnClickStartBtnEvent()
	end

	function self.delegateOnClickTaskBtnEvent()
		self:OnClickTaskButtonEvent()
	end

	function self.delegateOnTaskNotifyFinish()
		self:OnTaskNotifyFinish()
	end
end

function m:__AddListeners()
	self.startGameBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickStartBtnEvent)
	self.taskBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickTaskBtnEvent)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.delegateOnTaskNotifyFinish)
end

function m:__RemoveListeners()
	self.startGameBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickStartBtnEvent)
	self.taskBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickTaskBtnEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.delegateOnTaskNotifyFinish)
end

function m:OnClickTaskButtonEvent()
	UIModule.Open(Constant.UIControllerName.GhostGameTaskUI, Constant.UILayer.UI, {
		activityID = self.activityListCfg.ActivityID[1]
	})
end

function m:OnClickStartBtnEvent()
	if self.activityCfg.ExtraParam[1] - self.activityPod.ghostPOD.todayCount <= 0 then
		log("次数已用完")

		return
	end

	SceneTransferModule.MainCityToGhostGame(self.activityListCfg.ActivityID[1])
end

function m:__SetData(activityListCfg)
	self.activityListCfg = activityListCfg
	self.activityCfg = CfgActivityTable[self.activityListCfg.ActivityID[1]]
	self.activityPod = ActivityModule.GetActivityPodByID(self.activityListCfg.ActivityID[1])

	self:Refresh()
end

function m:Refresh()
	UGUIUtil.SetText(self.surplusCountText, self.activityCfg.ExtraParam[1] - self.activityPod.ghostPOD.todayCount)
	UGUIUtil.SetText(self.describeText, self.activityListCfg.Desc)
	UGUIUtil.SetText(self.activityName, self.activityListCfg.Name)
	self:RefreshCountdown()
	self:RefreshTaskRedDot()
end

function m:RefreshCountdown()
	self.endTime = math.floor(tonumber(self.activityPod.closeDateTime) / 1000)

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
	self:RefreshTaskRedDot()
end

function m:RefreshTaskRedDot()
	LuaUtility.SetGameObjectShow(self.taskRedDot, RedDotModule.CheckRedDot_GhostGameTask())
end

function m:__Dispose()
	self:StopTimer()
end

function m:__OnCover()
	return
end

function m:__OnReveal()
	return
end

return m
