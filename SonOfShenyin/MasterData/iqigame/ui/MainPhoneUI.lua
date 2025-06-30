-- chunkname: @IQIGame\\UI\\MainPhoneUI.lua

local CommonRoleDisplayView = require("IQIGame/UI/Common/CommonRoleDisplayView")
local CommonAppearanceView = require("IQIGame/UI/Common/CommonAppearanceView")
local MainPhoneUI_RightView = require("IQIGame/UI/MainPhoneUI/MainPhoneUI_RightView")
local MainPhoneUI_StorageView = require("IQIGame/UI/MainPhoneUI/MainPhoneUI_StorageView")
local MainPhoneUI_SwitchDisplayView = require("IQIGame/UI/MainPhoneUI/MainPhoneUI_SwitchDisplayView")
local MainPhoneUI_SkinView = require("IQIGame/UI/MainPhoneUI/MainPhoneUI_SkinView")
local MainPhoneUI = {
	bgmSerialID = 0
}

function MainPhoneUI.New(view)
	local obj = Clone(MainPhoneUI)

	obj:__OnInit(view)

	return obj
end

function MainPhoneUI:__OnInit(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:OnInit()
end

function MainPhoneUI:OnInit()
	self.moneyCell = CurrencyCell.New(self.MoneyRoot)
	self.roleDisplayView = CommonRoleDisplayView.New(self.RoleDisplayViewRoot, Constant.DynamicSkinShowPosition.MobilePhone)
	self.appearanceView = CommonAppearanceView.New(self.AppearanceTimelineRoot)
	self.rightView = MainPhoneUI_RightView.New(self.RightViewRoot)
	self.storageView = MainPhoneUI_StorageView.New(self.StorageViewRoot)
	self.switchDisplayView = MainPhoneUI_SwitchDisplayView.New(self.SwitchViewRoot)
	self.skinView = MainPhoneUI_SkinView.New(self.SkinViewRoot)
	self.animationCom = self.gameObject:GetComponent(typeof(UnityEngine.Animation))

	function self.DelegateQuestionnairBtnClick()
		self:QuestionnairBtnClick()
	end

	function self.DelegateHomeTaskBtnClick()
		self:__OnHomeTaskBtnClickHandler()
	end

	self:__SetSkinDisplayMode(true, false)
	self.gameObject.gameObject:SetActive(false)
	self:__InitDynamicsActivityBtn()
end

function MainPhoneUI:GetPreloadAssetPaths()
	return nil
end

function MainPhoneUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MainPhoneUI:IsManualShowOnOpen(userData)
	return false
end

function MainPhoneUI:GetBGM(userData)
	return nil
end

function MainPhoneUI:OnOpen(userData)
	self:BgmIn()
	self.gameObject.gameObject:SetActive(true)

	local showAppearance = false

	if userData ~= nil then
		showAppearance = TryToBoolean(userData.showAppearance, false)
	end

	self.moneyCell:RefreshItem(Constant.TopMoneyType.MainPhoneUI)
	self.storageView:Hide()
	self.switchDisplayView:Hide()
	self.skinView:Hide()
	self.appearanceView:Hide()
	self:__InitPlayerInfo()
	self:__RefreshButtonStatus()
	self:__InitRedDotShow()
	self.rightView:Show()
	self:__RefreshDynamicsActivityBtn()

	local isRandom = SettingModule.GetRoleDisplayRandomState()

	self:__RefreshRoleDisplayView(1, isRandom, showAppearance)
end

function MainPhoneUI:BgmIn()
	if self.bgmSerialID == 0 then
		self.bgmSerialID = LuaUtility.PlayBGMWithID(11000024)
	else
		LuaUtility.ReplaceBGM(self.bgmSerialID, 11000024)
	end

	local room = HomeModule.GetCurrentHomeRoom()

	if room then
		room:PauseEnvironmentSound()
	end
end

function MainPhoneUI:BgmOut()
	local room = HomeModule.GetCurrentHomeRoom()

	if room then
		room:ResumeEnvironmentSound()
	end

	if self.bgmSerialID == 0 then
		return
	end

	LuaUtility.RemoveBGM(self.bgmSerialID)

	self.bgmSerialID = 0
end

function MainPhoneUI:OnClose(userData)
	self:__SetSkinDisplayMode(true, false)
	self.gameObject.gameObject:SetActive(false)
	self.roleDisplayView:Hide()
	self.rightView:Hide()
	self:BgmOut()

	if StoryModule.IsStoring then
		StoryModule.ContinueStory()
	end
end

function MainPhoneUI:OnAddListeners()
	UIEventUtil.AddClickEventListener_Button(self, "PlayerInfoBtn")
	UIEventUtil.AddClickEventListener_Button(self, "PassActivityBtn")
	UIEventUtil.AddClickEventListener_Button(self, "WelfareBtn")
	UIEventUtil.AddClickEventListener_Button(self, "ActivityListBtn")
	UIEventUtil.AddClickEventListener_Button(self, "FirstRechargeBtn")
	UIEventUtil.AddClickEventListener_Button(self, "PushGiftBtn")
	UIEventUtil.AddClickEventListener_Button(self, "ActivityRewardBtn")
	UIEventUtil.AddClickEventListener_Button(self, "RechargeRebateBtn")
	UIEventUtil.AddClickEventListener_Button(self, "ShopBtn", self.__OnShopBtnClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "HeroBtn")
	UIEventUtil.AddClickEventListener_Button(self, "WarehouseBtn")
	UIEventUtil.AddClickEventListener_Button(self, "TaskBtn")
	UIEventUtil.AddClickEventListener_Button(self, "LotteryBtn")
	UIEventUtil.AddClickEventListener_Button(self, "ActivityBtn", self.__OnActivityBtnClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "HomeTaskBtn", self.__OnHomeTaskBtnClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "ShowAppearanceBtn", self.__OnShowAppearanceBtnClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "ClosePreviewBtn", self.__OnClosePreviewBtnClickHandler)
	self.QuestionnairBtn:GetComponent("Button").onClick:AddListener(self.DelegateQuestionnairBtnClick)
	EventUtil.AddEventListener(self, EventID.LotteryNotifyDrawPoolUpdate)
	EventUtil.AddEventListener(self, EventID.SwitchMainPhoneUIDisplayView)
	EventUtil.AddEventListener(self, EventID.SetMainPhoneUIStorageViewActive)
	EventUtil.AddEventListener(self, EventID.SetMainPhoneUIRoleDisplaySetViewActive)
	EventUtil.AddEventListener(self, EventID.SetMainPhoneUIRoleDisplaySelectViewActive)
	EventUtil.AddEventListener(self, EventID.NotifyLimitedTimePkg, self.__OnNotifyLimitedTimePkgHandler)
	EventUtil.AddEventListener(self, EventID.PushGiftUIClosed, self.__OnPushGiftUIClosedHandler)
	EventUtil.AddEventListener(self, EventID.UnlockFunction, self.__OnUnlockFunctionHandler)
	EventUtil.AddEventListener(self, EventID.SwitchMainPhoneUIRoleDisplayModel, self.__OnSwitchMainPhoneUIRoleDisplayModelHandler)
	EventUtil.AddEventListener(self, EventID.ActivityPassUIActive, self.__OnUnlockFunctionHandler)
	EventUtil.AddEventListener(self, EventID.ActivityUpdateEvent, self.__OnUnlockFunctionHandler)
	EventUtil.AddEventListener(self, EventID.ActivityOpenEvent, self.__OnUnlockFunctionHandler)
	EventUtil.AddEventListener(self, EventID.ActivityCloseEvent, self.__OnUnlockFunctionHandler)
	EventUtil.AddEventListener(self, EventID.TaskNotifyFinish, self.__OnUnlockFunctionHandler)
	EventUtil.AddEventListener(self, EventID.OnChangeKanBanPOD, self.__OnChangeKanBanPODHandler)
	EventUtil.AddEventListener(self, EventID.UIGroupTopUIChange, self.__OnUIGroupTopUIChangeEventHandler)
	EventUtil.AddEventListener(self, EventID.ChangeShowHcid, self.__OnChangeShowCidEventHandler)
	EventUtil.AddEventListener(self, EventID.NotifyPlayerDataChange, self.__OnNotifyPlayerDataChangeEventHandler)
	self:__AddRedDotEventListener()
end

function MainPhoneUI:OnRemoveListeners()
	self.QuestionnairBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateQuestionnairBtnClick)
	UIEventUtil.ClearEventListener(self)
	EventUtil.ClearEventListener(self)
	self:__RemoveRedDotEventListener()
end

function MainPhoneUI:OnPause()
	return
end

function MainPhoneUI:OnResume()
	return
end

function MainPhoneUI:OnCover()
	return
end

function MainPhoneUI:OnReveal()
	return
end

function MainPhoneUI:OnRefocus(userData)
	return
end

function MainPhoneUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MainPhoneUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MainPhoneUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MainPhoneUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MainPhoneUI:OnDestroy()
	UIEventUtil.ClearEventListener(self)
	EventUtil.ClearEventListener(self)
	self.moneyCell:Dispose()
	self.roleDisplayView:Dispose()
	self.rightView:Dispose()
	self.storageView:Dispose()
	self.switchDisplayView:Dispose()
	self.skinView:Dispose()
	self.appearanceView:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)

	self.gameObject = nil
end

function MainPhoneUI:__InitPlayerInfo()
	self:__RefreshPlayerHead()
	self:__RefreshPlayerLevel()
	self:__RefreshPlayerName()
end

function MainPhoneUI:__RefreshPlayerHead()
	local skinCid = PlayerModule.GetPlayerKanBanSkinCid()
	local path = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinCid, Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, path, self.PlayerHeadImg:GetComponent("Image"))
end

function MainPhoneUI:__RefreshPlayerLevel()
	UGUIUtil.SetText(self.PlayerLevelText, PlayerModule.PlayerInfo.baseInfo.pLv)
	self:__RefreshActivityPassBtnState()
end

function MainPhoneUI:__RefreshPlayerName()
	UGUIUtil.SetText(self.PlayerNameText, PlayerModule.PlayerInfo.baseInfo.pName)
end

function MainPhoneUI:__OnPlayerInfoBtnClickHandler()
	local userData = {
		UserInfoModule.GetPlayerInfo(),
		true
	}

	UIModule.Open(Constant.UIControllerName.UserInfoUI, Constant.UILayer.UI, userData)
end

function MainPhoneUI:__OnPassActivityBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.ActivityPassUI, Constant.UILayer.UI)
end

function MainPhoneUI:__OnWelfareBtnClickHandler()
	local userData = {
		teamID = Constant.ActivityListTeamID.Welfare
	}

	UIModule.Open(Constant.UIControllerName.ActivityListUI, Constant.UILayer.UI, userData)
end

function MainPhoneUI:__OnActivityListBtnClickHandler()
	local userData = {
		teamID = Constant.ActivityListTeamID.Activity
	}

	UIModule.Open(Constant.UIControllerName.ActivityListUI, Constant.UILayer.UI, userData)
end

function MainPhoneUI:__OnFirstRechargeBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.FirstRechargeUI, Constant.UILayer.UI)
end

function MainPhoneUI:__OnPushGiftBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.PushShopListUI, Constant.UILayer.UI)
end

function MainPhoneUI:__OnActivityRewardBtnClickHandler(teamID)
	local userData = {
		teamID = teamID
	}

	UIModule.Open(Constant.UIControllerName.ActiveActivityListUI, Constant.UILayer.UI, userData)
end

function MainPhoneUI:__OnRechargeRebateBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.RechargeRebateUI, Constant.UILayer.UI)
end

function MainPhoneUI:__OnHomeTaskBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.HomeLandMissionUI)
end

function MainPhoneUI:__OnShopBtnClickHandler()
	local userData = {
		enterType = Constant.ShopEnterType.Normal
	}

	UIModule.Open(Constant.UIControllerName.ShopUI, Constant.UILayer.UI, userData)
end

function MainPhoneUI:__OnHeroBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.WarlockChoosePanel, Constant.UILayer.UI, {
		showUnlockHero = true
	})
end

function MainPhoneUI:__OnWarehouseBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.WarehouseUI, Constant.UILayer.UI)
end

function MainPhoneUI:__OnTaskBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.TaskSystemUI, Constant.UILayer.UI)
end

function MainPhoneUI:__OnLotteryBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.LotteryUI, Constant.UILayer.UI)
end

function MainPhoneUI:__OnActivityBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.NoviceTaskUI, Constant.UILayer.UI)
end

function MainPhoneUI:__OnShowAppearanceBtnClickHandler()
	local skinCid = self.roleDisplayView.skinCid

	local function __callback()
		self:__OnPlayAppearanceComplete(skinCid)
	end

	self:__PlayAppearance(skinCid, false, __callback)
end

function MainPhoneUI:__OnClosePreviewBtnClickHandler()
	self:__SetSkinDisplayMode(false, false)
end

function MainPhoneUI:__OnLotteryNotifyDrawPoolUpdateHandler()
	self:__RefreshLotteryBtnRedDot()
end

function MainPhoneUI:__OnSwitchMainPhoneUIDisplayViewHandler()
	if self.__displaySkinCount <= 1 then
		NoticeModule.ShowNotice(MainUIAPI:GetSwitchRoleDisplayFailNoticeCid())

		return
	end

	local index = self.roleDisplayShowIndex + 1

	self:__RefreshRoleDisplayView(index, false)
end

function MainPhoneUI:__OnSwitchMainPhoneUIRoleDisplayModelHandler()
	self:__SetSkinDisplayMode(self.TopRoot.gameObject.activeSelf, true)
end

function MainPhoneUI:__SetSkinDisplayMode(enable, isPreview)
	self.TopRoot.gameObject:SetActive(not enable)

	if isPreview == true then
		self.ClosePreviewBtn.gameObject:SetActive(enable)

		local skinCfg = CfgHeroSkinTable[self.roleDisplayView.skinCid]

		if LuaUtility.StrIsNullOrEmpty(skinCfg.AppearanceTimeline) then
			self.ShowAppearanceBtn.gameObject:SetActive(false)
		else
			self.ShowAppearanceBtn.gameObject:SetActive(enable)
		end
	else
		self.ClosePreviewBtn.gameObject:SetActive(false)
		self.ShowAppearanceBtn.gameObject:SetActive(false)
	end
end

function MainPhoneUI:__OnSetMainPhoneUIStorageViewActiveHandler(active)
	if active then
		self.storageView:Show()
	else
		self.storageView:Hide()
	end
end

function MainPhoneUI:__OnSetMainPhoneUIRoleDisplaySetViewActiveHandler(active)
	if active then
		self.switchDisplayView:Show()
	else
		self.switchDisplayView:Hide()
	end
end

function MainPhoneUI:__OnSetMainPhoneUIRoleDisplaySelectViewActiveHandler(active, skinCid)
	if active then
		self.skinView:Show(skinCid)
		self.roleDisplayView:OnCover()
	else
		self.skinView:Hide()
		self.roleDisplayView:OnReveal()
	end
end

function MainPhoneUI:__OnNotifyLimitedTimePkgHandler()
	self:__RefreshPushGiftBtnState()
end

function MainPhoneUI:__OnPushGiftUIClosedHandler()
	self:__RefreshPushGiftBtnState()
end

function MainPhoneUI:__OnUnlockFunctionHandler()
	self:__RefreshButtonStatus()
	self:__RefreshDynamicsActivityBtn()
end

function MainPhoneUI:__OnChangeKanBanPODHandler()
	local skinCidList = PlayerModule.GetDisplaySkinList()
	local realSkinCidList = {}

	ForPairs(skinCidList, function(_, _skinCid)
		if _skinCid == 0 then
			return
		end

		table.insert(realSkinCidList, _skinCid)
	end)

	self.__displaySkinCount = #realSkinCidList

	self:__RefreshRoleDisplayData(true)
end

function MainPhoneUI:__OnUIGroupTopUIChangeEventHandler(groupName, uiName)
	if not self.gameObject.activeSelf then
		return
	end

	if UIModule.MainUIIsVisible() then
		self:BgmIn()
	else
		self:BgmOut()
	end
end

function MainPhoneUI:__OnChangeShowCidEventHandler()
	self:__RefreshPlayerHead()
end

function MainPhoneUI:__OnNotifyPlayerDataChangeEventHandler()
	self:__InitPlayerInfo()
end

function MainPhoneUI:__RefreshButtonStatus()
	self:__RefreshRechargeRebateBtn()
	self:__RefreshActivityPassBtnState()
	self:__RefreshPushGiftBtnState()
	self:__RefreshWelfareBtnAndActivityBtnState()
	self:__RefreshQuestionnairState()
	self:__RefreshFirstRechargeBtn()
	self:__RefreshHomeTaskBtn()
	LuaUtility.SetGameObjectShow(self.LotteryBtn, UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_DRAW))
	LuaUtility.SetGameObjectShow(self.ShopBtn, UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_STORE))

	local isFinishAll = TaskSystemModule.isFinishAll(Constant.MainTaskType.Novice_7_DAY_TASK)

	LuaUtility.SetGameObjectShow(self.ActivityBtn, ActivityModule.IsOpenByTime(Constant.ActivityID.Novice_7_TASK) and not isFinishAll)
end

function MainPhoneUI:__RefreshRechargeRebateBtn()
	local isShow = PlayerModule.PlayerInfo.baseInfo.rebate ~= nil

	isShow = isShow and tonumber(PlayerModule.PlayerInfo.baseInfo.rebate.id) ~= 0

	LuaUtility.SetGameObjectShow(self.RechargeRebateBtn, isShow)
end

function MainPhoneUI:__RefreshFirstRechargeBtn()
	local taskList = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Recharge, Constant.ExtendTaskType.Recharge_Frist)
	local isShow = taskList ~= nil and table.len(taskList) > 0 and UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_STORE)

	LuaUtility.SetGameObjectShow(self.FirstRechargeBtn, isShow)
end

function MainPhoneUI:__RefreshHomeTaskBtn()
	local isShow = UnlockFunctionModule.IsUnlock(Constant.UnlockType.Saunter)

	LuaUtility.SetGameObjectShow(self.HomeTaskBtn, isShow)
end

function MainPhoneUI:__RefreshActivityPassBtnState()
	local isShow = ActivityPassModule.isOpen

	isShow = isShow and UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_PASS_CARD)
	isShow = isShow and ConditionModule.Check(UnlockFunctionModule.GetFuncSwitchByType(Constant.UnlockType.FUNC_PASS_CARD).Condition)

	LuaUtility.SetGameObjectShow(self.PassActivityBtn, isShow)
end

function MainPhoneUI:__RefreshWelfareBtnAndActivityBtnState()
	local activityTabList = ActivityListModule.GetActivityListByTeamID(Constant.ActivityListTeamID.Activity)

	LuaUtility.SetGameObjectShow(self.ActivityListBtn, table.len(activityTabList) > 0)

	activityTabList = ActivityListModule.GetActivityListByTeamID(Constant.ActivityListTeamID.Welfare)

	LuaUtility.SetGameObjectShow(self.WelfareBtn, table.len(activityTabList) > 0)
end

function MainPhoneUI:__RefreshQuestionnairState()
	local questionConfig = PlayerModule.GetIsOpenQuestionnaire()

	self.questionConfig = questionConfig

	LuaUtility.SetGameObjectShow(self.QuestionnairBtn, self.questionConfig ~= nil)
end

function MainPhoneUI:__RefreshPushGiftBtnState()
	local isPop, expireCommodityID = PlayerModule.GetPushGiftCommoditysIsPop()

	LuaUtility.SetGameObjectShow(self.PushGiftBtn, not isPop)

	if expireCommodityID ~= nil then
		LuaUtility.SetGameObjectShow(self.pushGiftTimeText, true)
		self:__RefreshPushGiftCountdown(PlayerModule.GetLimitTimeGiftDataByID(expireCommodityID))
	else
		LuaUtility.SetGameObjectShow(self.pushGiftTimeText, false)
	end

	LuaUtility.SetGameObjectShow(self.PushGiftBtn.transform:Find("RedDot").gameObject, RedDotModule.CheckRedDot_PushGift())
end

function MainPhoneUI:__RefreshPushGiftCountdown(endTime)
	self:__UpdateSurplusTime(endTime)

	if self.pushGiftCountdownTimer ~= nil then
		self.pushGiftCountdownTimer:Stop()

		self.pushGiftCountdownTimer = nil
	end

	if self.pushGiftCountdownTimer == nil then
		self.pushGiftCountdownTimer = Timer.New(function()
			self:__UpdateSurplusTime(endTime)
		end, 1, -1)

		self.pushGiftCountdownTimer:Start()
	end
end

function MainPhoneUI:__UpdateSurplusTime(endTime)
	local surplusTime = tonumber(endTime) - math.floor(tonumber(PlayerModule.GetServerTime()))

	if surplusTime <= 0 then
		surplusTime = 0
	end

	UGUIUtil.SetText(self.pushGiftTimeText, DateTimeFormat(surplusTime, BuyEnergyUIApi:GetTimeFormat(surplusTime)))
end

function MainPhoneUI:__InitRedDotShow()
	self:__RefreshLotteryBtnRedDot()
end

function MainPhoneUI:__AddRedDotEventListener()
	RedDotModule.Subscribe(Constant.E_RedDotPath.Shop_FreeItem, self.ShopBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Warlock, self.HeroBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Warehouse, self.WarehouseBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Task, self.TaskBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.PassActivity, self.PassActivityBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.WelfareList, self.WelfareBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.ActivityList, self.ActivityListBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.FirstRecharge, self.FirstRechargeBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.HomeLand_Task, self.HomeTaskBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.MobilePhone_NoviceActivity_TaskTab, self.ActivityBtn.transform:Find("RedDot").gameObject)
end

function MainPhoneUI:__RemoveRedDotEventListener()
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Shop_FreeItem, self.ShopBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Warlock, self.HeroBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Warehouse, self.WarehouseBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Task, self.TaskBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.PassActivity, self.PassActivityBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.WelfareList, self.WelfareBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.ActivityList, self.ActivityListBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.FirstRecharge, self.FirstRechargeBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.HomeLand_Task, self.HomeTaskBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.MobilePhone_NoviceActivity_TaskTab, self.ActivityBtn.transform:Find("RedDot").gameObject)
end

function MainPhoneUI:__RefreshLotteryBtnRedDot()
	local hasFreeDraw = LotteryModule.CheckHasFreeDraw()

	self.LotteryBtn.transform:Find("RedDot").gameObject:SetActive(hasFreeDraw)
end

function MainPhoneUI:__RefreshRoleDisplayData(showAppearance)
	local isRandom = SettingModule.GetRoleDisplayRandomState()

	self:__RefreshRoleDisplayView(1, isRandom, showAppearance)
end

function MainPhoneUI:__RefreshRoleDisplayView(index, isRandom, showAppearance)
	local _index, skinCid = self:__GetNextRoleDisplaySkinCid(index, isRandom)

	self.roleDisplayShowIndex = _index

	if skinCid == 0 then
		self.animationCom:Play()

		local time = Timer.New(function()
			self.roleDisplayView:Hide()
			self:__SetSkinDisplayMode(false, false)
			self.appearanceView:Hide()
		end, 0.1)

		time:Start()

		return
	end

	local function __showDisplay()
		self.animationCom:Play()

		local time = Timer.New(function()
			self:__OnPlayAppearanceComplete(skinCid)
			self:__SetSkinDisplayMode(false, false)
		end, 0.1)

		time:Start()
	end

	if not showAppearance then
		__showDisplay()

		return
	end

	if not SkinModule.CanShowAppearance(skinCid) then
		__showDisplay()

		return
	end

	self:__PlayAppearance(skinCid, true, __showDisplay)
end

function MainPhoneUI:__PlayAppearance(skinCid, playBGM, callback)
	local userData = {}

	function userData.callback(_userData)
		callback()
	end

	userData.position = Constant.DynamicSkinShowPosition.MobilePhone

	if playBGM then
		local heroSkinData = CfgHeroSkinTable[skinCid]
		local bgmCid = TryToNumber(heroSkinData.BGM, 0)

		if bgmCid ~= 0 then
			self.roleDisplayView:PlayBGM(bgmCid)
		end
	end

	if self.appearanceView:PlayAppearance(skinCid, userData) then
		self.roleDisplayView:Hide()
	else
		callback()
	end
end

function MainPhoneUI:__OnPlayAppearanceComplete(skinCid)
	self.roleDisplayView:Show(skinCid)
	self.appearanceView:Hide()
end

function MainPhoneUI:QuestionnairBtnClick()
	local url = PlayerModule.GetQuestionUrl(self.questionConfig.Url, self.questionConfig.Id, self.questionConfig.Activity)

	Application.OpenURL(url)
	RedDotModule.ClearRedDotByRedDotID(Constant.E_RedDotPath.MobilePhone_Questionnair)
end

function MainPhoneUI:__GetNextRoleDisplaySkinCid(index, isRandom)
	local skinCidList = PlayerModule.GetDisplaySkinList()
	local realSkinCidList = {}

	ForPairs(skinCidList, function(_, _skinCid)
		if _skinCid == 0 then
			return
		end

		table.insert(realSkinCidList, _skinCid)
	end)

	self.__displaySkinCount = #realSkinCidList

	if self.__displaySkinCount == 0 then
		return 0, 0
	end

	if self.__displaySkinCount == 1 then
		return 1, realSkinCidList[1]
	end

	local realIndex = index

	if isRandom then
		realIndex = math.random(1, self.__displaySkinCount)

		return realIndex, realSkinCidList[realIndex]
	end

	if index > self.__displaySkinCount then
		return 1, realSkinCidList[1]
	end

	return index, realSkinCidList[index]
end

function MainPhoneUI:__InitDynamicsActivityBtn()
	self.__dynamicsActivityBtnTable = {}

	ForTransformChild(self.ActivityBtnRoot.transform, function(_trans, _index)
		local activityCid = TryToNumber(_trans.name, 0)

		if activityCid == 0 then
			return
		end

		table.insert(self.__dynamicsActivityBtnTable, {
			ActivityCid = activityCid,
			BtnGo = _trans.gameObject
		})
	end)
	self:__RefreshDynamicsActivityBtn()
end

function MainPhoneUI:__RefreshDynamicsActivityBtn()
	ForPairs(self.__dynamicsActivityBtnTable, function(_, _tabData)
		local active = GameNoticeModule.CheckActivityBtnShow(_tabData.ActivityCid)

		_tabData.BtnGo.gameObject:SetActive(active)

		if not active then
			return
		end

		local btnInjectName = _tabData.BtnGo.name

		if self[btnInjectName] == nil then
			self[btnInjectName] = _tabData.BtnGo
		end

		if UIEventUtil.HasClickEventListener_Button(self, btnInjectName) then
			return
		end

		UIEventUtil.AddClickEventListener_Button(self, btnInjectName, function()
			self:__OnDynamicsActivityBtnClickHandler(_tabData.ActivityCid)
		end)
	end)
end

function MainPhoneUI:__OnDynamicsActivityBtnClickHandler(activityCid)
	local activityCfg = CfgPayActivityTable[activityCid]

	if activityCfg == nil then
		return
	end

	if activityCfg.Skip == 0 then
		return
	end

	JumpModule.Jump(activityCfg.Skip)
end

return MainPhoneUI
