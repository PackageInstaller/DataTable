-- chunkname: @IQIGame\\UI\\ActiveActivityList\\SummerActivity\\SummerActivityMainView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local m = Clone(ActivityViewBase)

function m:__Init()
	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateOnClickJumpBtn()
		self:OnClickJumpBtn()
	end

	function self.openStageEvent(selectChapterId)
		self:OnClickJumpBtn(selectChapterId)
	end

	function self.openShopEvent()
		self:OnClickShopBtn()
	end
end

function m:__AddListeners()
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	self.JumpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickJumpBtn)
	EventDispatcher.AddEventListener(EventID.SummerActivityMainView_OpenStage, self.openStageEvent)
	EventDispatcher.AddEventListener(EventID.SummerActivityMainView_OpenShop, self.openShopEvent)
end

function m:__RemoveListeners()
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	self.JumpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickJumpBtn)
	EventDispatcher.RemoveEventListener(EventID.SummerActivityMainView_OpenStage, self.openStageEvent)
	EventDispatcher.RemoveEventListener(EventID.SummerActivityMainView_OpenShop, self.openShopEvent)
end

function m:__SetData(activityListCfg)
	self.ActivityIsOpen = true
	self.ActivityIsOpen = false
	self.activityListCfg = activityListCfg
	self.activityCfg = CfgActivityTable[self.activityListCfg.ActivityID[1]]
	self.activityPod = ActivityModule.GetActivityPodByID(self.activityListCfg.ActivityID[1])

	UGUIUtil.SetText(self.SummerDesc, self.activityListCfg.Desc)
	self:RefreshCountdown()
end

function m:RefreshCountdown()
	local durationLen = table.len(self.activityCfg.Duration)

	self.activityEndTime = ActivityModule.GetActivityStageEndTime(self.activityCfg.Id, durationLen - 1)
	self.shopEndTime = ActivityModule.GetActivityStageEndTime(self.activityCfg.Id, durationLen)

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
	local surplusTime = math.floor(self.activityEndTime - tonumber(PlayerModule.GetServerTime()))

	surplusTime = math.max(0, surplusTime)
	self.ActivityIsOpen = surplusTime ~= 0

	if surplusTime == 0 then
		LuaUtility.SetGameObjectShow(self.ActivityTimeEndParent, true)
		LuaUtility.SetGameObjectShow(self.ActivityTimeParent, false)
	else
		LuaUtility.SetGameObjectShow(self.ActivityTimeEndParent, false)
		LuaUtility.SetGameObjectShow(self.ActivityTimeParent, true)
		UGUIUtil.SetText(self.activityTimeText, DateStandardFormation(surplusTime))
	end

	surplusTime = math.floor(self.shopEndTime - tonumber(PlayerModule.GetServerTime()))
	surplusTime = math.max(0, surplusTime)
	self.ShopIsOpen = surplusTime ~= 0

	if surplusTime == 0 then
		LuaUtility.SetGameObjectShow(self.ShopTimeParent, false)
		LuaUtility.SetGameObjectShow(self.ShopTimeEndParent, true)
	else
		LuaUtility.SetGameObjectShow(self.ShopTimeParent, true)
		LuaUtility.SetGameObjectShow(self.ShopTimeEndParent, false)
		UGUIUtil.SetText(self.shopTimeText, DateStandardFormation(surplusTime))
	end

	if not self.ShopIsOpen and not self.ActivityIsOpen then
		self:StopTimer()
	end
end

function m:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end
end

function m:OnClickShopBtn()
	if not self.ShopIsOpen then
		return
	end

	UIModule.Open(Constant.UIControllerName.ActivityShopUI, Constant.UILayer.UI, {
		activityPod = self.activityPod
	})
end

function m:OnClickJumpBtn(selectChapterId)
	if not self.ActivityIsOpen then
		return
	end

	UIModule.Open(Constant.UIControllerName.SummerActivityStageUI, Constant.UILayer.UI, {
		activityPod = self.activityPod,
		selectChapterId = selectChapterId
	})
end

function m:__Dispose()
	self:StopTimer()
end

return m
