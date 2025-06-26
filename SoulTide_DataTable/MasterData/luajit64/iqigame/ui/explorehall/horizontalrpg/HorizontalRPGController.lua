-- chunkname: @IQIGame\\UI\\ExploreHall\\HorizontalRPG\\HorizontalRPGController.lua

local m = {
	IsShow = false
}
local HorizontalRPGTicketCell = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGTicketCell")

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickRpgMazeBtn()
		self:OnClickRpgMazeBtn()
	end

	function self.DelegateOnClickExBossBtn()
		self:OnClickExBossBtn()
	end

	function self.DelegateOnClickTaskBtn()
		self:OnClickTaskBtn()
	end

	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateOnClickBossBtn()
		self:OnClickBossBtn()
	end

	function self.DelegateUpdateChallengeBoss()
		self:OnUpdateChallengeBoss()
	end

	function self.DelegateOnUpdateTask()
		self:OnUpdateTask()
	end

	function self.DelegateOnClickIntroductionBtn()
		self:OnClickIntroductionBtn()
	end

	function self.DelegateUnlockBoss()
		self:OnUnlockBoss()
	end

	function self.DelegateOnClickPvBtn()
		self:OnClickPvBtn()
	end

	function self.DelegateUnlockDifficult()
		self:OnUnlockDifficult()
	end

	self.TicketCell = HorizontalRPGTicketCell.New(self.TicketGo)

	local cfgHorizontalRPGControlData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]

	self.TicketCell:Refresh(cfgHorizontalRPGControlData.MoneyId)
end

function m:AddListener()
	self.RpgMazeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRpgMazeBtn)
	self.ExBossBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExBossBtn)

	if self.TaskBtn then
		self.TaskBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTaskBtn)
	end

	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)

	if self.BossBtn then
		self.BossBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBossBtn)
	end

	self.IntroductionBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickIntroductionBtn)
	self.PvBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPvBtn)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateChallengeBoss)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnUpdateTask)
	EventDispatcher.AddEventListener(EventID.HorizontalRPGUnlockBossEvent, self.DelegateUnlockBoss)
	EventDispatcher.AddEventListener(EventID.HorizontalRPGUnLockDifficultEvent, self.DelegateUnlockDifficult)
end

function m:RemoveListener()
	self.RpgMazeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRpgMazeBtn)
	self.ExBossBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExBossBtn)

	if self.TaskBtn then
		self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTaskBtn)
	end

	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)

	if self.BossBtn then
		self.BossBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBossBtn)
	end

	self.PvBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPvBtn)
	self.IntroductionBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickIntroductionBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateChallengeBoss)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnUpdateTask)
	EventDispatcher.RemoveEventListener(EventID.HorizontalRPGUnlockBossEvent, self.DelegateUnlockBoss)
	EventDispatcher.RemoveEventListener(EventID.HorizontalRPGUnLockDifficultEvent, self.DelegateUnlockDifficult)
end

function m:UpdateView()
	if HorizontalRPGModule.dailyDupPOD then
		local cfgDailyDupData = CfgDailyDupTable[HorizontalRPGModule.dailyDupPOD.common.cid]
		local closeTime = HorizontalRPGModule.dailyDupPOD.common.openDate + cfgDailyDupData.AccessibleTime
		local timeText = getDateTimeMText(closeTime)

		UGUIUtil.SetText(self.MazeLimitTimeText, ExploreHallUIApi:GetString("HorizontalRPGLimitTimeText", timeText))
		self:OnUpdateChallengeBoss()
		self:RefreshTaskRedPoint()
		self:RefreshBtnState()
	end
end

function m:OnUnlockDifficult()
	if HorizontalRPGModule.dailyDupPOD then
		self:RefreshBtnState()
	end
end

function m:RefreshBtnState()
	local unlockedDifficulty = HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.unlockedDifficulty
	local isOpenPlot = table.indexOf(unlockedDifficulty, HorizontalRPGConstant.ChallengeType.Type_Plot) ~= -1

	self.PvBtn:SetActive(isOpenPlot)

	local isOpenChallenge = table.indexOf(unlockedDifficulty, HorizontalRPGConstant.ChallengeType.Type_Challenge) ~= -1

	self.RpgMazeBtn:SetActive(isOpenChallenge)
end

function m:OnTaskUpdate(taskCid)
	self:RefreshTaskRedPoint()
end

function m:RefreshTaskRedPoint()
	local showTaskRedPoint = HorizontalRPGModule.CheckHorizontalRPGTaskRedPoint()

	if self.TaskBtn then
		self.TaskBtn.transform:Find("RedPoint").gameObject:SetActive(showTaskRedPoint)
	end
end

function m:Show()
	if self.IsShow and self.View.activeSelf then
		return
	end

	HorizontalRPGModule.CheckResume()

	self.IsShow = true

	self.View:SetActive(true)
	self:AddListener()
	self:UpdateView()

	local cfgDreamMapGlobalData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]

	self.Host.UIController:ChangeBGM(cfgDreamMapGlobalData.BGM)
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "ExploreHallUIHorizontalRPGTab")
end

function m:OnUnlockBoss()
	self:OnUpdateChallengeBoss()
end

function m:Hide()
	if not self.IsShow and not self.View.activeSelf then
		return
	end

	self.IsShow = false

	self.View:SetActive(false)
	self:RemoveListener()
	self.Host.UIController:ChangeBGM(7)
end

function m:OnUpdateChallengeBoss()
	self.ExBossBtn:SetActive(HorizontalRPGModule.ExBossOpen())
end

function m:OnClickRpgMazeBtn()
	UIModule.Open(Constant.UIControllerName.HorizontalRPGChallengeMainUI, Constant.UILayer.UI, {
		openType = HorizontalRPGConstant.ChallengeType.Type_Challenge
	})
end

function m:OnClickPvBtn()
	UIModule.Open(Constant.UIControllerName.HorizontalRPGChallengeMainUI, Constant.UILayer.UI, {
		openType = HorizontalRPGConstant.ChallengeType.Type_Plot
	})
end

function m:OnClickExBossBtn()
	UIModule.Open(Constant.UIControllerName.HorizontalRPGMazeBossChallengeDetailUI, Constant.UILayer.UI, CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid])
end

function m:OnClickTaskBtn()
	UIModule.Open(Constant.UIControllerName.HorizontalRPGMissionUI, Constant.UILayer.UI)
end

function m:OnClickShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.HorizontalRPGShop)
end

function m:OnClickBossBtn()
	UIModule.Open(Constant.UIControllerName.HorizontalRPGMazeBossChallengeEntryUI, Constant.UILayer.UI)
end

function m:OnClickIntroductionBtn()
	UIModule.Open(Constant.UIControllerName.HorizontalRpgIntroduceTipsUI, Constant.UILayer.UI)
end

function m:OnUpdateTask()
	self:RefreshTaskRedPoint()
end

function m:Dispose()
	self.TicketCell:Dispose()

	self.TicketCell = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
