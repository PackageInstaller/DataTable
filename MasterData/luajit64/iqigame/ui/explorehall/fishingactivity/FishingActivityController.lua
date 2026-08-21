-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivityController.lua

local m = {
	LastTime = 0,
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

	function self.DelegateUpdateDailyDupEvent()
		self:OnUpdateDailyDupEvent()
	end

	function self.DelegateIntroductionBtn()
		self:OnIntroductionBtn()
	end

	function self.DelegateShopBtn()
		self:OnShopBtn()
	end

	function self.DelegateMaxWeightBtn()
		self:OnMaxWeightBtn()
	end

	function self.DelegateTotalWeightBtn()
		self:OnTotalWeightBtn()
	end

	function self.DelegateFishingBtn()
		self:OnFishingBtn()
	end

	function self.DelegateAutoFishingBtn()
		self:OnAutoFishingBtn()
	end

	function self.DelegateBookBtn()
		self:OnBookBtn()
	end

	function self.DelegateAchievementBtn()
		self:OnAchievementBtn()
	end

	function self.DelegateStoryBtn()
		self:OnStoryBtn()
	end

	function self.DelegateDevelopBtn()
		self:OnDevelopBtn()
	end

	function self.DelegateUpdateFishWeight()
		self:OnUpdateFishWeight()
	end

	function self.DelegateUpdateFinishedTaskOver(cid)
		self:OnUpdateFinishedTaskOver(cid)
	end

	function self.DelegateUpdateEvent()
		self:OnUpdateEvent()
	end

	self.CfgControlData = CfgFishActiveControlTable[FishingActivityModule.globalCid]
	self.MoneyCellBuilder = MoneyCellsBuilder.New(self.CurrencyCom)

	self.MoneyCellBuilder:RefreshView({
		self.CfgControlData.MoneyId
	})
end

function m:AddListener()
	self.IntroductionBtn:GetComponent("Button").onClick:AddListener(self.DelegateIntroductionBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateShopBtn)
	self.MaxWeightBtn:GetComponent("Button").onClick:AddListener(self.DelegateMaxWeightBtn)
	self.TotalWeightBtn:GetComponent("Button").onClick:AddListener(self.DelegateTotalWeightBtn)
	self.FishingBtn:GetComponent("Button").onClick:AddListener(self.DelegateFishingBtn)
	self.AutoFishingBtn:GetComponent("Button").onClick:AddListener(self.DelegateAutoFishingBtn)
	self.DevelopBtn:GetComponent("Button").onClick:AddListener(self.DelegateDevelopBtn)
	self.BookBtn:GetComponent("Button").onClick:AddListener(self.DelegateBookBtn)
	self.AchievementBtn:GetComponent("Button").onClick:AddListener(self.DelegateAchievementBtn)
	self.StoryBtn:GetComponent("Button").onClick:AddListener(self.DelegateStoryBtn)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDupEvent)
	EventDispatcher.AddEventListener(EventID.FishingActivityUpdateWeightEvent, self.DelegateUpdateFishWeight)
	EventDispatcher.AddEventListener(EventID.UpdateFinishedTaskOver, self.DelegateUpdateFinishedTaskOver)
	EventDispatcher.AddEventListener(EventID.FishingActivityUpdateEvent, self.DelegateUpdateEvent)
end

function m:RemoveListener()
	self.IntroductionBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateIntroductionBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateShopBtn)
	self.MaxWeightBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateMaxWeightBtn)
	self.TotalWeightBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateTotalWeightBtn)
	self.FishingBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateFishingBtn)
	self.AutoFishingBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAutoFishingBtn)
	self.DevelopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateDevelopBtn)
	self.BookBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBookBtn)
	self.AchievementBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAchievementBtn)
	self.StoryBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateStoryBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDupEvent)
	EventDispatcher.RemoveEventListener(EventID.FishingActivityUpdateWeightEvent, self.DelegateUpdateFishWeight)
	EventDispatcher.RemoveEventListener(EventID.UpdateFinishedTaskOver, self.DelegateUpdateFinishedTaskOver)
	EventDispatcher.RemoveEventListener(EventID.FishingActivityUpdateEvent, self.DelegateUpdateEvent)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	local nowTime = PlayerModule.GetServerTime()

	if nowTime - self.LastTime > 1 then
		self.LastTime = nowTime

		self:RefreshAutoFishCD()
	end
end

function m:OnUpdateDailyDupEvent()
	if FishingActivityModule.IsShow() and self.View then
		self:UpdateView()
	end
end

function m:UpdateView()
	local cfgDailyDupData = CfgDailyDupTable[FishingActivityModule.dailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = FishingActivityModule.dailyDupPOD.common.openDate
	local accessEndTime = openDate + cfgDailyDupData.AccessibleTime
	local activityEndTime = openDate + cfgDailyDupData.Duration
	local startTimeText, accessEndText, endTimeText = ExploreHallUIApi:GetString("FishingActivityTimeTexts", currentServerTime, openDate, accessEndTime, activityEndTime)

	UGUIUtil.SetText(self.EndTimeText, endTimeText)
	UGUIUtil.SetText(self.ShopEndTimeText, accessEndText)
	self:OnUpdateFishWeight()
end

function m:OnUpdateFishWeight()
	self:RefreshFishWeight()
	self:RefreshBookNum()
	self:RefreshEventRedPoint()
end

function m:OnUpdateEvent()
	self:OnUpdateFishWeight()
end

function m:OnUpdateFinishedTaskOver(cid)
	local cfgMainQuest = CfgMainQuestTable[cid]

	if cfgMainQuest.Type ~= TaskModule.TaskType.FISHING_ACTIVITY_TASK then
		return
	end

	UIModule.Open(Constant.UIControllerName.FishingActivityAchievementTipUI, Constant.UILayer.UI, cid)
end

function m:RefreshAutoFishCD()
	local endTime = FishingActivityModule.dailyDupPOD.fishingActivityPOD.autoFishingRewardsTime or 0
	local cd = endTime - PlayerModule.GetServerTime()

	if cd > 0 then
		self.AutoFishRedPoint:SetActive(false)
		UGUIUtil.SetText(self.TextAutoFishing, GetFormatTime(cd))
		UGUIUtil.SetText(self.TextAutoBtn, ExploreHallUIApi:GetString("FishingActivityTextAutoLabel", false))
	else
		self.AutoFishRedPoint:SetActive(true)
		UGUIUtil.SetText(self.TextAutoFishing, "")
		UGUIUtil.SetText(self.TextAutoBtn, ExploreHallUIApi:GetString("FishingActivityTextAutoLabel", true))
	end
end

function m:RefreshEventRedPoint()
	self.EventRedPoint:SetActive(FishingActivityModule.CanGetRewardEvent())
end

function m:RefreshBookNum()
	local num, totalNum = FishingActivityModule.GetFishIllustratedNum()

	UGUIUtil.SetText(self.TextBooks, ExploreHallUIApi:GetString("FishingActivityTextBooks", num, totalNum))
end

function m:RefreshFishWeight()
	local maxWeight = FishingActivityModule.GetMaxWeight()

	UGUIUtil.SetText(self.TextMaxWeight, ExploreHallUIApi:GetString("FishingActivityTextMaxWeight", maxWeight))

	local totalWeight = FishingActivityModule.dailyDupPOD.fishingActivityPOD.totalWeight or 0

	UGUIUtil.SetText(self.TextTotalWeight, ExploreHallUIApi:GetString("FishingActivityTextTotalWeight", totalWeight))
end

function m:OnDevelopBtn()
	UIModule.Open(Constant.UIControllerName.FishingActivitySkillUI, Constant.UILayer.UI)
end

function m:OnStoryBtn()
	UIModule.Open(Constant.UIControllerName.FishingActivityStoryUI, Constant.UILayer.UI)
end

function m:OnAchievementBtn()
	UIModule.Open(Constant.UIControllerName.FishingActivityMissionUI, Constant.UILayer.UI)
end

function m:OnBookBtn()
	UIModule.Open(Constant.UIControllerName.FishingActivityIllustratedUI, Constant.UILayer.UI)
end

function m:OnAutoFishingBtn()
	local endTime = FishingActivityModule.dailyDupPOD.fishingActivityPOD.autoFishingRewardsTime or 0
	local cd = endTime - PlayerModule.GetServerTime()

	if cd > 0 then
		return
	end

	FishingActivityModule.GetAutoFishingRewards()
end

function m:OnFishingBtn()
	UIModule.Open(Constant.UIControllerName.FishingActivityMainUI, Constant.UILayer.UI)
end

function m:OnTotalWeightBtn()
	UIModule.Open(Constant.UIControllerName.FishingActivityTotalWeightRankUI, Constant.UILayer.UI)
end

function m:OnMaxWeightBtn()
	UIModule.Open(Constant.UIControllerName.FishingActivityRankUI, Constant.UILayer.UI)
end

function m:OnShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.FishingActivityShop)
end

function m:OnIntroductionBtn()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.CfgControlData.Desc)
end

function m:Show()
	if self.IsShow and self.View.activeSelf then
		return
	end

	self.IsShow = true

	self.View:SetActive(true)
	self:AddListener()
	self:UpdateView()
	self.Host.UIController:ChangeBGM(self.CfgControlData.UIBGM)
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

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.MoneyCellBuilder:Dispose()

	self.MoneyCellBuilder = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
