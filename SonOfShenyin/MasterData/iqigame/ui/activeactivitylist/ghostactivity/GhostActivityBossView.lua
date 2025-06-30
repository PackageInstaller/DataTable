-- chunkname: @IQIGame\\UI\\ActiveActivityList\\GhostActivity\\GhostActivityBossView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local m = Clone(ActivityViewBase)

function m:__Init()
	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateOnClickJumpBtn()
		self:OnClickJumpBtn()
	end
end

function m:__AddListeners()
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	self.JumpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickJumpBtn)
end

function m:__RemoveListeners()
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	self.JumpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickJumpBtn)
end

function m:__SetData(activityListCfg)
	self.activityListCfg = activityListCfg
	self.activityPod = ActivityModule.GetActivityPodByID(self.activityListCfg.ActivityID[1])
	self.activityCfg = CfgActivityTable[self.activityListCfg.ActivityID[1]]

	LuaUtility.SetText(self.textDesc, self.activityListCfg.Desc)
	self:RefreshCountdown()
end

function m:OnClickShopBtn()
	UIModule.Open(Constant.UIControllerName.ActivityShopUI, Constant.UILayer.UI, {
		activityPod = self.activityPod
	})
end

function m:OnClickJumpBtn(selectChapterId)
	UIModule.Open(Constant.UIControllerName.GhostBossChallengeUI, Constant.UILayer.UI, {
		activityPod = self.activityPod
	})
end

function m:RefreshCountdown()
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
	local surplusTime = math.floor(tonumber(self.activityPod.closeDateTime) / 1000 - tonumber(PlayerModule.GetServerTime()))

	surplusTime = math.max(0, surplusTime)
	self.ActivityIsOpen = surplusTime ~= 0

	if surplusTime == 0 then
		LuaUtility.SetGameObjectShow(self.ActivityTimeEndParent, true)
		LuaUtility.SetGameObjectShow(self.ActivityTimeParent, false)
	else
		LuaUtility.SetGameObjectShow(self.ActivityTimeEndParent, false)
		LuaUtility.SetGameObjectShow(self.ActivityTimeParent, true)
		LuaUtility.SetText(self.textTime, DateStandardFormation(surplusTime))
	end

	if not self.ActivityIsOpen then
		self:StopTimer()
	end
end

function m:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end
end

function m:__Dispose()
	self:StopTimer()
end

return m
