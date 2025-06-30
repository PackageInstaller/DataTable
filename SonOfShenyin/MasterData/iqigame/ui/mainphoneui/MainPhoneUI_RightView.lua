-- chunkname: @IQIGame\\UI\\MainPhoneUI\\MainPhoneUI_RightView.lua

local MainPhoneUI_RightView_TopBanner = require("IQIGame/UI/MainPhoneUI/MainPhoneUI_RightView_TopBanner")
local RightView = {}

function RightView.New(view)
	local obj = Clone(RightView)

	obj:__Init(view)

	return obj
end

function RightView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.topBanner = MainPhoneUI_RightView_TopBanner.New(self.TopBannerRoot)

	self.DailyTaskBtn.transform:Find("RedDot").gameObject:SetActive(false)

	function self.delegateOnClickButtonMessage()
		self:OnClickButtonMessage()
	end

	self:__OnAddListeners()
end

function RightView:__OnAddListeners()
	UIEventUtil.AddClickEventListener_Button(self, "StorageBtn")
	UIEventUtil.AddClickEventListener_Button(self, "MailBtn")
	UIEventUtil.AddClickEventListener_Button(self, "SkinBtn")
	UIEventUtil.AddClickEventListener_Button(self, "SwitchBtn")
	UIEventUtil.AddClickEventListener_Button(self, "HideBtn")
	UIEventUtil.AddClickEventListener_Button(self, "MainTaskBtn")
	UIEventUtil.AddClickEventListener_Button(self, "DailyTaskBtn")
	UIEventUtil.AddClickEventListener_Button(self, "SummerActivityBtn", self.__OnSummerActivityBtnClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "ShopFreeBtn", self.__OnShopFreeBtnBtnClickHandler)
	self.buttonMessage:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonMessage)
	EventUtil.AddEventListener(self, EventID.NetFavorResponse_NotifyEntry)
	EventUtil.AddEventListener(self, EventID.UnlockFunction)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Home_Mail, self.MailBtn.transform:Find("RedDot").gameObject)
end

function RightView:__OnRemoveListeners()
	UIEventUtil.ClearEventListener(self)
	self.buttonMessage:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonMessage)
	EventUtil.ClearEventListener(self)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Home_Mail, self.MailBtn.transform:Find("RedDot").gameObject)
end

function RightView:__OnUnlockFunctionHandler()
	local funcList = {}

	funcList[Constant.UnlockType.FUNC_Affinity] = self.buttonMessage

	UnlockFunctionModule.FuncSwitchHandler(funcList)
end

function RightView:__OnNetFavorResponse_NotifyEntryHandler()
	LuaUtility.SetGameObjectShow(self.newsImg, AffinityModule.GetAffinityHaveNew())
end

function RightView:Show()
	self.gameObject:SetActive(true)
	self.topBanner:Show()
	self:__RefreshMainTaskView()
	self:__RefreshSummerActivityBtn()
	self:__OnUnlockFunctionHandler()
	LuaUtility.SetGameObjectShow(self.newsImg, AffinityModule.GetAffinityHaveNew())

	if not EventUtil.HasEventListener(self, EventID.PlayerLvChange) then
		EventUtil.AddEventListener(self, EventID.PlayerLvChange, self.__RefreshSummerActivityBtn)
	end

	if not EventUtil.HasEventListener(self, EventID.PlayerLvChange) then
		EventUtil.AddEventListener(self, EventID.ActivityUpdateEvent, self.__RefreshSummerActivityBtn)
	end
end

function RightView:Hide()
	EventUtil.RemoveEventListener(self, EventID.PlayerLvChange)
	EventUtil.RemoveEventListener(self, EventID.ActivityUpdateEvent)
	self.topBanner:Hide()
	self.gameObject:SetActive(false)
end

function RightView:Dispose()
	self.topBanner:Dispose()
	UIEventUtil.ClearEventListener(self)
	EventUtil.ClearEventListener(self)
	self:__OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function RightView:__OnSummerActivityBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.ActiveActivityListUI, Constant.UILayer.UI, {
		teamID = Constant.ActivityListTeamID.SummerActivity
	})
end

function RightView:__OnStorageBtnClickHandler()
	EventDispatcher.Dispatch(EventID.SetMainPhoneUIStorageViewActive, true)
end

function RightView:__OnMailBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.MailUI, Constant.UILayer.UI)
end

function RightView:__OnSkinBtnClickHandler()
	EventDispatcher.Dispatch(EventID.SetMainPhoneUIRoleDisplaySetViewActive, true)
end

function RightView:__OnSwitchBtnClickHandler()
	EventDispatcher.Dispatch(EventID.SwitchMainPhoneUIDisplayView)
end

function RightView:__OnHideBtnClickHandler()
	EventDispatcher.Dispatch(EventID.SwitchMainPhoneUIRoleDisplayModel)
end

function RightView:__OnMainTaskBtnClickHandler()
	EventDispatcher.Dispatch(EventID.OpenMobilePhoneEvent, false)
end

function RightView:__OnDailyTaskBtnClickHandler()
	local userData = {}

	userData.ToggleType = Constant.WorldAreaUIToggleType.Day

	UIModule.Open(Constant.UIControllerName.WorldAreaUI, Constant.UILayer.UI, userData)
end

function RightView:OnClickButtonMessage()
	UIModule.Open(Constant.UIControllerName.AffinityChatUI, Constant.UILayer.UI)
end

function RightView:__OnShopFreeBtnBtnClickHandler()
	local userData = {
		enterType = Constant.ShopEnterType.Normal
	}

	UIModule.Open(Constant.UIControllerName.ShopFreeUI, Constant.UILayer.UI, userData)
end

function RightView:__RefreshMainTaskView()
	local parentTask, childTask = WorldMapModule.GetCurrentMainTask()

	if parentTask == nil then
		LuaUtility.SetGameObjectShow(self.MainLineProgressRoot, false)

		return
	end

	LuaUtility.SetGameObjectShow(self.MainLineProgressRoot, true)

	local cfgParentTask = CfgUtil.GetTaskCfgWithID(parentTask.cid)

	LuaUtility.SetText(self.MainTaskName, cfgParentTask.Name)
end

function RightView:__RefreshSummerActivityBtn()
	local activityList = ActiveActivityListModule.GetActivityListByTeamID(Constant.ActivityListTeamID.SummerActivity)

	if #activityList > 0 then
		LuaUtility.SetGameObjectShow(self.SummerActivityBtn.gameObject, true)
	else
		LuaUtility.SetGameObjectShow(self.SummerActivityBtn.gameObject, false)
	end
end

return RightView
