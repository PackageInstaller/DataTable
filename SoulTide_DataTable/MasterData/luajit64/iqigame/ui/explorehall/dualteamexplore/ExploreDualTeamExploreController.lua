-- chunkname: @IQIGame\\UI\\ExploreHall\\DualTeamExplore\\ExploreDualTeamExploreController.lua

local DualTeamExploreTicketCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreTicketCell")
local m = {
	IsShow = false
}

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickLevelBtn()
		self:OnClickLevelBtn()
	end

	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateOnClickTaskBtn()
		self:OnClickTaskBtn()
	end

	function self.DelegateOnClickTipBtn()
		self:OnClickTipBtn()
	end

	function self.DelegateOnClickBossBtn()
		self:OnClickBossBtn()
	end

	function self.DelegateOnClickExBossBtn()
		self:OnClickExBossBtn()
	end

	function self.DelegateOnTaskUpdate(taskCid)
		self:OnTaskUpdate(taskCid)
	end

	function self.DelegateUpdateChallengeBoss()
		self:OnUpdateChallengeBoss()
	end

	self.TicketCell = DualTeamExploreTicketCell.New(self.TicketGO)

	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	self.CurrencyCell = CurrencyCell.New(self.CurrencyCellGO, cfgDualTeamExploreControlData.ShopVoucher)

	UGUIUtil.SetTextInChildren(self.LevelBtn, ExploreHallUIApi:GetString("DualTeamExploreLevelBtnText", DualTeamExploreModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetTextInChildren(self.ShopBtn, ExploreHallUIApi:GetString("DualTeamExploreShopBtnText", DualTeamExploreModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetTextInChildren(self.TaskBtn, ExploreHallUIApi:GetString("DualTeamExploreTaskBtnText", DualTeamExploreModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetTextInChildren(self.BossBtn, ExploreHallUIApi:GetString("DualTeamExploreBossBtnText", DualTeamExploreModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetTextInChildren(self.ExBossBtn, ExploreHallUIApi:GetString("DualTeamExploreExBossBtnText", DualTeamExploreModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetTextInChildren(self.TipBtn, ExploreHallUIApi:GetString("DualTeamExploreTipBtnText"))
end

function m:Show()
	if self.IsShow and self.View.activeSelf then
		return
	end

	self.IsShow = true

	self.View:SetActive(true)
	self:AddListeners()
	self:UpdateView()

	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	self.Host.UIController:ChangeBGM(cfgDualTeamExploreControlData.UIBGM)
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "ExploreHallUIDualTeamExploreTab")
end

function m:Hide()
	if not self.IsShow and not self.View.activeSelf then
		return
	end

	self.IsShow = false

	self.View:SetActive(false)
	self:RemoveListeners()
	self.Host.UIController:ChangeBGM(7)
end

function m:AddListeners()
	self.LevelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickLevelBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	self.TaskBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTaskBtn)
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
	self.BossBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBossBtn)
	self.ExBossBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExBossBtn)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateChallengeBoss)
end

function m:RemoveListeners()
	self.LevelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickLevelBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTaskBtn)
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
	self.BossBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBossBtn)
	self.ExBossBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExBossBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateChallengeBoss)
end

function m:OnUpdateChallengeBoss()
	self.ExBossBtn:SetActive(DualTeamExploreModule.ExBossOpen())
end

function m:UpdateView()
	self.ExBossBtn:SetActive(DualTeamExploreModule.ExBossOpen())
	self.TicketCell:Refresh()
	self:UpdateTaskRedPoint()

	local cfgDailyDupData = CfgDailyDupTable[DualTeamExploreModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = DualTeamExploreModule.DailyDupPOD.common.openDate
	local accessEndTime = openDate + cfgDailyDupData.AccessibleTime
	local activityEndTime = openDate + cfgDailyDupData.Duration
	local label, startTimeText, endTimeText = ExploreHallUIApi:GetString("DualTeamExploreLimitTimeTexts", currentServerTime, openDate, accessEndTime, activityEndTime)

	UGUIUtil.SetText(self.LimitTimeLabel, label)
	UGUIUtil.SetText(self.StartTimeText, startTimeText)
	UGUIUtil.SetText(self.EndTimeText, endTimeText)
end

function m:OnClickLevelBtn()
	if not self:CheckIsInChallengeLimitTime() then
		return
	end

	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeDualTeamExplore)

	if unfinishedMazeCid ~= nil then
		MazeModule.SendRestore(unfinishedMazeCid)

		return
	end

	local currentLevelCid = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.currLevelCid

	if currentLevelCid ~= 0 then
		DualTeamExploreModule.SendEnterScene(currentLevelCid, 0, 0)

		return
	end

	local isEasyModeInt = PlayerPrefsUtil.GetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.DualTeamExploreEasyMode)

	if isEasyModeInt == 0 then
		UIModule.Open(Constant.UIControllerName.DualTeamExploreLevelEntryConfirmUI, Constant.UILayer.UI)
	else
		UIModule.Open(Constant.UIControllerName.DualTeamExploreLevelEntryUI, Constant.UILayer.UI)
	end
end

function m:OnClickShopBtn()
	if not self:CheckIsInActivityLimitTime() then
		return
	end

	MallModule.OpenActivityMall(Constant.Mall_EntranceType.DualTeamExploreShop, DualTeamExploreModule.GetMallCidList())
end

function m:OnClickTaskBtn()
	if not self:CheckIsInActivityLimitTime() then
		return
	end

	UIModule.Open(Constant.UIControllerName.DualTeamExploreMissionUI, Constant.UILayer.UI)
end

function m:OnClickTipBtn()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, ExploreHallUIApi:GetString("DualTeamExploreDesc", DualTeamExploreModule.DailyDupPOD.common.openCount))
end

function m:OnClickBossBtn()
	if not self:CheckIsInChallengeLimitTime() then
		return
	end

	UIModule.Open(Constant.UIControllerName.DualTeamExploreBossChallengeUI, Constant.UILayer.UI)
end

function m:OnClickExBossBtn()
	if not DualTeamExploreModule.ExBossOpen() then
		return
	end

	if not self:CheckIsInActivityLimitTime() then
		return
	end

	UIModule.Open(Constant.UIControllerName.DualTeamExploreExBossChallengeUI, Constant.UILayer.UI)
end

function m:OnTaskUpdate(taskCid)
	self:UpdateTaskRedPoint()
end

function m:UpdateTaskRedPoint()
	local hasReward = false
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.DUAL_TEAM_EXPLORE)

	for i = 1, #processing do
		local taskData = processing[i]

		if taskData.finNum >= taskData.tgtNum then
			hasReward = true

			break
		end
	end

	self.TaskBtnRedPoint:SetActive(hasReward)
end

function m:CheckIsInChallengeLimitTime()
	local cfgDailyDupData = CfgDailyDupTable[DualTeamExploreModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = DualTeamExploreModule.DailyDupPOD.common.openDate
	local accessLevelEndTime = openDate + cfgDailyDupData.AccessibleTime
	local isInChallengeLimitTime = openDate <= currentServerTime and currentServerTime <= accessLevelEndTime

	if not isInChallengeLimitTime then
		NoticeModule.ShowNotice(84500004)
	end

	return isInChallengeLimitTime
end

function m:CheckIsInActivityLimitTime()
	local cfgDailyDupData = CfgDailyDupTable[DualTeamExploreModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = DualTeamExploreModule.DailyDupPOD.common.openDate
	local activityEndTime = openDate + cfgDailyDupData.Duration
	local isInActivityLimitTime = openDate <= currentServerTime and currentServerTime <= activityEndTime

	if not isInActivityLimitTime then
		NoticeModule.ShowNotice(84500004)
	end

	return isInActivityLimitTime
end

function m:Dispose()
	self.TicketCell:Dispose()
	self.CurrencyCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
