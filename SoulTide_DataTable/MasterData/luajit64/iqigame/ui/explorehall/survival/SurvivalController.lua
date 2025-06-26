-- chunkname: @IQIGame\\UI\\ExploreHall\\Survival\\SurvivalController.lua

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

	function self.delegateUpdateDailyDupEvent()
		self:OnUpdateDailyDupEvent()
	end

	function self.DelegateUpGradeBtn()
		self:OnUpGradeBtn()
	end

	function self.DelegateFlightGameBtn()
		self:OnFlightGameBtn()
	end

	function self.DelegateBossChallengeBtn()
		self:OnBossChallengeBtn()
	end

	function self.DelegateButtonInfo()
		self:OnButtonInfo()
	end

	function self.DelegateShopBtn()
		self:OnShopBtn()
	end

	function self.DelegateUpdateItem()
		self:OnUpdateItem()
	end
end

function m:AddListener()
	self.UpGradeBtn:GetComponent("Button").onClick:AddListener(self.DelegateUpGradeBtn)
	self.FlightGameBtn:GetComponent("Button").onClick:AddListener(self.DelegateFlightGameBtn)
	self.BossChallengeBtn:GetComponent("Button").onClick:AddListener(self.DelegateBossChallengeBtn)
	self.ButtonInfo:GetComponent("Button").onClick:AddListener(self.DelegateButtonInfo)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateShopBtn)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateDailyDupEvent)
end

function m:RemoveListener()
	self.UpGradeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateUpGradeBtn)
	self.FlightGameBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateFlightGameBtn)
	self.BossChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBossChallengeBtn)
	self.ButtonInfo:GetComponent("Button").onClick:RemoveListener(self.DelegateButtonInfo)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateShopBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateDailyDupEvent)
end

function m:OnUpdateDailyDupEvent()
	if SurvivalModule.IsShow() and self.View then
		self:UpdateView()
	end
end

function m:OnUpdateItem()
	self:RefreshUpGradeRed()
end

function m:UpdateView()
	if SurvivalModule.dailyDupPOD then
		local cfgDailyDupData = CfgDailyDupTable[SurvivalModule.dailyDupPOD.common.cid]
		local currentServerTime = PlayerModule.GetServerTime()
		local openDate = SurvivalModule.dailyDupPOD.common.openDate
		local accessEndTime = openDate + cfgDailyDupData.AccessibleTime
		local activityEndTime = openDate + cfgDailyDupData.Duration
		local startTimeText, endTimeText = ExploreHallUIApi:GetString("SurvivalLimitTimeTexts", currentServerTime, openDate, accessEndTime, activityEndTime)

		if self.StartTimeText then
			UGUIUtil.SetText(self.StartTimeText, startTimeText)
		end

		if self.EndTimeText then
			UGUIUtil.SetText(self.EndTimeText, endTimeText)
		end

		self:RefreshUpGradeRed()
	end
end

function m:RefreshUpGradeRed()
	local top = SurvivalModule.CheckRedPoint()

	self.ImgRedUpGrade:SetActive(top)
end

function m:Show()
	if self.IsShow and self.View.activeSelf then
		return
	end

	self.IsShow = true

	self.View:SetActive(true)
	self:AddListener()
	self:UpdateView()

	self.cfgControlData = CfgSurvivalChallengeControlTable[SurvivalModule.GlobalCid]

	self.Host.UIController:ChangeBGM(self.cfgControlData.UIBGM)
	SurvivalModule.CheckResumeDialog()
end

function m:OnUpGradeBtn()
	UIModule.Open(Constant.UIControllerName.SurvivalChallengeUpgradeUI, Constant.UILayer.UI)
end

function m:OnFlightGameBtn()
	UIModule.Open(Constant.UIControllerName.SurvivalChallengeLevelUI, Constant.UILayer.UI)
end

function m:OnBossChallengeBtn()
	UIModule.Open(Constant.UIControllerName.SurvivalChallengeFormationUI, Constant.UILayer.UI, {
		Type = FlyGameConstant.ChallengeType.Challenge_Endless_Mode
	})
end

function m:OnButtonInfo()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.cfgControlData.Desc)
end

function m:OnShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.SurvivalShop)
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
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
