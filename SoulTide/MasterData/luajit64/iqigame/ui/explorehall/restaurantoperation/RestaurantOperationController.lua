-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantOperationController.lua

local m = {
	IsShow = false
}
local ROTicketCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.ROTicketCell")

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

	function self.DelegateTaskBtn()
		self:OnTaskBtn()
	end

	function self.DelegateBtnRestaurantOperation()
		self:OnBtnRestaurantOperation()
	end

	function self.DelegateBtnChallenge()
		self:OnBtnChallenge()
	end

	function self.DelegateBtnExBoss()
		self:OnBtnExBoss()
	end

	function self.DelegateReceiveIncome()
		self:RefreshGetIncome()
	end

	self.cfgControlData = CfgRestaurantOperationControlTable[RestaurantOperationModule.GlobalCid]
	self.roTicketCell = ROTicketCell.New(self.TicketGo)

	self.roTicketCell:RefreshData(self.cfgControlData.ScoreId)
end

function m:AddListener()
	self.IntroductionBtn:GetComponent("Button").onClick:AddListener(self.DelegateIntroductionBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateShopBtn)
	self.TaskBtn:GetComponent("Button").onClick:AddListener(self.DelegateTaskBtn)
	self.BtnRestaurantOperation:GetComponent("Button").onClick:AddListener(self.DelegateBtnRestaurantOperation)
	self.BtnChallenge:GetComponent("Button").onClick:AddListener(self.DelegateBtnChallenge)
	self.BtnExBoss:GetComponent("Button").onClick:AddListener(self.DelegateBtnExBoss)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDupEvent)
	EventDispatcher.AddEventListener(EventID.ROReceiveIncomeEvent, self.DelegateReceiveIncome)
end

function m:RemoveListener()
	self.IntroductionBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateIntroductionBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateShopBtn)
	self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateTaskBtn)
	self.BtnRestaurantOperation:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRestaurantOperation)
	self.BtnChallenge:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnChallenge)
	self.BtnExBoss:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnExBoss)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDupEvent)
	EventDispatcher.RemoveEventListener(EventID.ROReceiveIncomeEvent, self.DelegateReceiveIncome)
end

function m:OnUpdateDailyDupEvent()
	if RestaurantOperationModule.IsShow() and self.View then
		self:UpdateView()
	end
end

function m:UpdateView()
	local cfgDailyDupData = CfgDailyDupTable[RestaurantOperationModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = RestaurantOperationModule.DailyDupPOD.common.openDate
	local accessEndTime = openDate + cfgDailyDupData.AccessibleTime
	local activityEndTime = openDate + cfgDailyDupData.Duration
	local startTimeText, accessEndText, endTimeText = ExploreHallUIApi:GetString("RestaurantOperationTimeTexts", currentServerTime, openDate, accessEndTime, activityEndTime)

	UGUIUtil.SetText(self.TextStartTime, startTimeText)
	UGUIUtil.SetText(self.EndTimeText, endTimeText)
	UGUIUtil.SetText(self.ShopStartTimeText, startTimeText)
	UGUIUtil.SetText(self.ShopEndTimeText, accessEndText)
	self:RefreshTaskRedPoint()
	self:RefreshGetIncome()
end

function m:RefreshGetIncome()
	local isShow, num, maxNum = RestaurantOperationModule.CanGetReceiveIncome()

	UGUIUtil.SetText(self.TextGetIncomeNum, ExploreHallUIApi:GetString("RestaurantOperationIncomeNum", num))
	self.BtnGetIncome:SetActive(isShow)
	self.TextIsFull:SetActive(maxNum <= num)
	self.TextNum:SetActive(num < maxNum)
end

function m:RefreshTaskRedPoint()
	self.TaskRedPoint:SetActive(false)
end

function m:OnBtnExBoss()
	if not RestaurantOperationModule.DailyDupPOD.restaurantOperationPOD.exBossLock then
		NoticeModule.ShowNotice(21045090)

		return
	end

	UIModule.Open(Constant.UIControllerName.RestaurantOperationBossUI, Constant.UILayer.UI)
end

function m:OnBtnChallenge()
	UIModule.Open(Constant.UIControllerName.RestaurantOperationChallengeUI, Constant.UILayer.UI)
end

function m:OnBtnRestaurantOperation()
	RestaurantOperationModule.GetRestaurantInfo()
end

function m:OnTaskBtn()
	UIModule.Open(Constant.UIControllerName.RestaurantOperationMissionUI, Constant.UILayer.UI)
end

function m:OnShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.RestaurantOperationShop)
end

function m:OnIntroductionBtn()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.cfgControlData.Desc)
end

function m:Show()
	if self.IsShow and self.View.activeSelf then
		return
	end

	self.IsShow = true

	self.View:SetActive(true)
	self:AddListener()
	self:UpdateView()
	self.Host.UIController:ChangeBGM(self.cfgControlData.UIBGM)
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
	self.roTicketCell:Dispose()

	self.roTicketCell = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
