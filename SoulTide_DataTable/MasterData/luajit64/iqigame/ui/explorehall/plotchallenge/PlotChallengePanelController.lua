-- chunkname: @IQIGame\\UI\\ExploreHall\\PlotChallenge\\PlotChallengePanelController.lua

local m = {
	minPox = 0,
	maxPos = 0,
	lastIndex = 0,
	index = 0,
	IsShow = false,
	CurrencyControllers = {},
	plotCellPool = {}
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
	UGUIUtil.SetText(self.ShopBtnText, ExploreHallUIApi:GetString("PlotChallengeShopBtnText"))
	UGUIUtil.SetText(self.StartTile, ExploreHallUIApi:GetString("PlotChallengeStartTile"))
	UGUIUtil.SetText(self.EndTitle, ExploreHallUIApi:GetString("PlotChallengeEndTitle"))
	UGUIUtil.SetText(self.PlotBtnLabel, ExploreHallUIApi:GetString("PlotBtnLabel"))
	UGUIUtil.SetText(self.ChallengeBtnLabel, ExploreHallUIApi:GetString("ChallengeBtnLabel"))
	UGUIUtil.SetTextInChildren(self.ButtonInfo, ExploreHallUIApi:GetString("ButtonInfo"))
	self.MoneyGridMould:SetActive(false)

	function self.delegateBossBtn()
		self:OnBossBtn()
	end

	function self.delegateShopBtn()
		self:OnShopBtn()
	end

	function self.delegatePrizeDraw()
		self:OnPrizeDrawBtn()
	end

	function self.delegateChallengeBtn()
		self:OnChallengeBtn()
	end

	function self.delegatePlotBtn()
		self:OnPlotBtn()
	end

	function self.delegateUpdateChallengeBoss()
		self:OnUpdateChallenge()
	end

	function self.delegateButtonInfo()
		self:OnButtonInfo()
	end

	self.cfgPlotGlobalData = CfgPlotChallengeActivityGlobalTable[PlotChallengeModule.GlobalCid]

	self:AddCurrencyCell(self.cfgPlotGlobalData.ScoreID)
	self:AddCurrencyCell(self.cfgPlotGlobalData.Ticket)
end

function m:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.MoneyGridMould)

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	currencyModule:SetActive(true)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function m:AddListeners()
	self.BossBtn:GetComponent("Button").onClick:AddListener(self.delegateBossBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.delegateShopBtn)

	if self.PrizeDrawBtn then
		self.PrizeDrawBtn:GetComponent("Button").onClick:AddListener(self.delegatePrizeDraw)
	end

	self.PlotBtn:GetComponent("Button").onClick:AddListener(self.delegatePlotBtn)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.delegateChallengeBtn)
	self.ButtonInfo:GetComponent("Button").onClick:AddListener(self.delegateButtonInfo)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateChallengeBoss)
end

function m:RemoveListeners()
	self.BossBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBossBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.delegateShopBtn)

	if self.PrizeDrawBtn then
		self.PrizeDrawBtn:GetComponent("Button").onClick:RemoveListener(self.delegatePrizeDraw)
	end

	self.PlotBtn:GetComponent("Button").onClick:RemoveListener(self.delegatePlotBtn)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateChallengeBtn)
	self.ButtonInfo:GetComponent("Button").onClick:RemoveListener(self.delegateButtonInfo)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateChallengeBoss)
end

function m:OnUpdateChallenge()
	if PlotChallengeModule.IsShow() then
		self:UpdateView(true)
	end
end

function m:UpdateView(playEffect)
	local cfgDailyDupData = CfgDailyDupTable[PlotChallengeModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = PlotChallengeModule.DailyDupPOD.common.openDate
	local accessEndTime = openDate + cfgDailyDupData.AccessibleTime
	local activityEndTime = openDate + cfgDailyDupData.Duration
	local label, startTimeText, endTimeText = ExploreHallUIApi:GetString("PlotChallengeLimitTimeTexts", currentServerTime, openDate, accessEndTime, activityEndTime)

	UGUIUtil.SetText(self.LimitTimeLabel, label)
	UGUIUtil.SetText(self.StartTimeText, startTimeText)
	UGUIUtil.SetText(self.EndTimeText, endTimeText)

	local isOpenPlot = table.indexOf(PlotChallengeModule.DailyDupPOD.challengeDataPOD.unlockedDifficulty, Constant.PlotChallengeType.Type_Plot) ~= -1

	self.PlotBtn:SetActive(isOpenPlot)

	local isChallenge = table.indexOf(PlotChallengeModule.DailyDupPOD.challengeDataPOD.unlockedDifficulty, Constant.PlotChallengeType.Type_Challenge) ~= -1

	self.ChallengeBtn:SetActive(isChallenge)

	local isOpenBoss = PlotChallengeModule.DailyDupPOD.challengeDataPOD.unlockedBoss

	self.BossBtn:SetActive(isOpenBoss)

	local cfgPlotChallengeActivityGlobalData = CfgPlotChallengeActivityGlobalTable[PlotChallengeModule.GlobalCid]

	self.ShopBtn:SetActive(not cfgPlotChallengeActivityGlobalData.IsLotteryMachine)

	if self.PrizeDrawBtn then
		self.PrizeDrawBtn:SetActive(cfgPlotChallengeActivityGlobalData.IsLotteryMachine)
	end
end

function m:ShowHostMoneyCell(top)
	for i = 1, #self.Host.CurrencyControllers do
		self.Host.CurrencyControllers[i].ViewGo:SetActive(top)
	end
end

function m:OnChallengeBtn()
	UIModule.Open(Constant.UIControllerName.DramaChallengeMainUI, Constant.UILayer.UI, {
		openType = Constant.PlotChallengeType.Type_Challenge
	})
end

function m:OnPlotBtn()
	UIModule.Open(Constant.UIControllerName.DramaChallengeMainUI, Constant.UILayer.UI, {
		openType = Constant.PlotChallengeType.Type_Plot
	})
end

function m:OnShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.PlotChallenge)
end

function m:OnPrizeDrawBtn()
	UIModule.Open(Constant.UIControllerName.DramaChallengeLotteryMachineUI, Constant.UILayer.UI)
end

function m:OnBossBtn()
	UIModule.Open(Constant.UIControllerName.ChallengeDramaBossDetailUI, Constant.UILayer.UI, self.cfgPlotGlobalData)
end

function m:OnButtonInfo()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.cfgPlotGlobalData.Desc)
end

function m:Show()
	if self.IsShow and self.View.activeSelf then
		return
	end

	if self.cfgPlotGlobalData.UIAudio > 0 then
		GameEntry.Sound:PlaySound(self.cfgPlotGlobalData.UIAudio, Constant.SoundGroup.UI)
	end

	PlotChallengeModule.CheckResumeDialog()

	self.IsShow = true

	self.View:SetActive(true)
	self:AddListeners()
	self:UpdateView(false)
	self.Host.UIController:ChangeBGM(self.cfgPlotGlobalData.UIBGM)
	self:ShowHostMoneyCell(false)
end

function m:Hide()
	if not self.IsShow and not self.View.activeSelf then
		return
	end

	self.lastIndex = 0
	self.IsShow = false

	self.View:SetActive(false)
	self:RemoveListeners()
	self.Host.UIController:ChangeBGM(7)
	self:ShowHostMoneyCell(true)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
