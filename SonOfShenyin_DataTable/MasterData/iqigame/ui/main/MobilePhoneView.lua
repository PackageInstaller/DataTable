-- chunkname: @IQIGame\\UI\\Main\\MobilePhoneView.lua

local bannerItemCell = require("IQIGame.UI.Main.BannerItemCell")
local mainUICommonBannerView = require("IQIGame.UI.Main.MainUICommonBannerView")
local m = {
	funcList = {},
	changePageTabList = {}
}

m.AnimationName = {
	Out = "FX_UI_MobilePhone_Out",
	In = "FX_UI_MobilePhone_In_1"
}

function m.New(view, uiController)
	local obj = Clone(m)

	obj:Init(view, uiController)

	return obj
end

function m:Init(view, uiController)
	self.View = view
	self.UIController = uiController

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateSignInBtn()
		self:OnClickSignBtn()
	end

	function self.DelegateFriendBtn()
		self:OnClickFriendBtn()
	end

	function self.DelegateMailBtn()
		self:OnClickMailBtn()
	end

	function self.DelegateNoticeBtn()
		self:OnClickNoticeBtn()
	end

	function self.DelegateSettingBtn()
		self:OnClickSettingBtn()
	end

	function self.OnButtonCompoundClickDelegate()
		self:OnButtonCompoundClick()
	end

	function self.DelegateWarehouseBtn()
		self:OnClickWarehouseBtn()
	end

	function self.DelegateOnScrollDragEnd(index)
		self:OnScrollDragEnd(index)
	end

	function self.DelegateOnClickClosePhoneBtn()
		self:OnClickClosePhoneBtn()
	end

	function self.DelegateOnClickOpenPhoneBtn()
		self:OnClickOpenPhoneBtn()
	end

	function self.DelegateOnTimeShow()
		self:SetTime()
	end

	function self.DelegateOnClickChangeHeroBtn()
		self:OnClickChangeHeroBtn()
	end

	function self.DelegateOnChangeShowHcidSucced()
		self:OnChangeShowHcidSucced()
	end

	function self.DelegateOnSkinChange()
		self:OnChangeShowHcidSucced()
	end

	function self.DelegateOnUnlockFunctionUpdateEvent()
		self:OnRefreshUnlockBtn()
	end

	function self.DelegateMailDataChange()
		self:MailDataChange()
	end

	function self.DelegateUpdataItem()
		self:UpdateItem()
	end

	function self.FileBtnDelegate()
		self:OnFileBtnClick()
	end

	function self.DelegateOnClickPlayeInfoBtn()
		self:OnClickPlayeInfoBtn()
	end

	function self.DelegateOnClickHeroBtn()
		self:OnClickHeroBtn()
	end

	function self.DelegateOnClickTaskBtn()
		self:OnClickTaskBtn()
	end

	function self.DelegateOnClickCommunityBtn()
		self:OnClickCommunityBtn()
	end

	function self.DelegateOnClickChapterBtn()
		self:OnClickChapterBtn()
	end

	function self.DelegateOnClickWelfareCollectionBtn()
		self:OnClickWelfareCollectionBtn()
	end

	function self.DelegateOnClickActivityCollectionBtn()
		self:OnClickActivityCollectionBtn()
	end

	function self.DelegateQuestionnairBtnClick()
		self:QuestionnairBtnClick()
	end

	function self.ActivityPassUIActiveEvent(state)
		self:RefreshBtnVisable()
	end

	function self.DelegateQuestionnairStateChange()
		self:OnOpenQuestionnair()
	end

	function self.DelegateOpenActivityEvent()
		self:OnOpenActivityEvent()
	end

	function self.DelegateCloseActivityEvent()
		self:OnCloseActivityEvent()
	end

	function self.DelegateOnServerParamChangeEvent()
		self:OnServerParamChangeEvent()
	end

	self.ScrollPageExt = self.MainPhoneParent:GetComponent(typeof(ScrollRectPageExt))
	self.ScrollPageExt.OnDrageEnd = self.DelegateOnScrollDragEnd
	self.funcList[Constant.UnlockType.FUNC_SING] = self.SignInBtn
	self.funcList[Constant.UnlockType.FUNC_MAIL] = self.MailBtn
	self.lotteryBannerView = mainUICommonBannerView.New(self.MainUICommonBanner_Lottery)
	self.shopBannerView = mainUICommonBannerView.New(self.MainUICommonBanner_Shop)
	self.activityBannerView = mainUICommonBannerView.New(self.MainUIConmmonBanner_Activity)
	self.BatteryImgCom = self.BatteryImg:GetComponent("Image")

	self:InitShowInfo()
	self:AddListeners()
end

function m:AddListeners()
	self.SignInBtn:GetComponent("Button").onClick:AddListener(self.DelegateSignInBtn)
	self.FriendBtn:GetComponent("Button").onClick:AddListener(self.DelegateFriendBtn)
	self.MailBtn:GetComponent("Button").onClick:AddListener(self.DelegateMailBtn)
	self.NoticeBtn:GetComponent("Button").onClick:AddListener(self.DelegateNoticeBtn)
	self.SettingBtn:GetComponent("Button").onClick:AddListener(self.DelegateSettingBtn)
	self.WarehouseBtn:GetComponent("Button").onClick:AddListener(self.DelegateWarehouseBtn)
	self.ClosePhoneBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClosePhoneBtn)
	self.OpenPhoneBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickOpenPhoneBtn)
	self.ChangeHeroBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeHeroBtn)
	self.CompoundBtn:GetComponent("Button").onClick:AddListener(self.OnButtonCompoundClickDelegate)
	self.FileBtn:GetComponent("Button").onClick:AddListener(self.FileBtnDelegate)
	self.HeroBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHeroBtn)
	self.TaskBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTaskBtn)
	self.CommunityBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCommunityBtn)
	self.ChapterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChapterBtn)
	self.WelfareCollectionBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickWelfareCollectionBtn)
	self.QuestionnairBtn:GetComponent("Button").onClick:AddListener(self.DelegateQuestionnairBtnClick)
	self.ActivityCollectionBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickActivityCollectionBtn)
	EventDispatcher.AddEventListener(EventID.ChangeShowHcid, self.DelegateOnChangeShowHcidSucced)
	EventDispatcher.AddEventListener(EventID.NotifyPlayerDataChange, self.DelegateOnSkinChange)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.DelegateOnUnlockFunctionUpdateEvent)
	EventDispatcher.AddEventListener(EventID.ActivityPassUIActive, self.ActivityPassUIActiveEvent)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.ActivityPassUIActiveEvent)
	EventDispatcher.AddEventListener(EventID.MailDataChangeEvent, self.DelegateMailDataChange)
	EventDispatcher.AddEventListener(EventID.GetAllMailsEvent, self.DelegateMailDataChange)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdataItem)
	EventDispatcher.AddEventListener(EventID.QuestionnairStateChange, self.DelegateQuestionnairStateChange)
	EventDispatcher.AddEventListener(EventID.ActivityOpenEvent, self.DelegateOpenActivityEvent)
	EventDispatcher.AddEventListener(EventID.ActivityCloseEvent, self.DelegateCloseActivityEvent)
	EventDispatcher.AddEventListener(EventID.ServerParamChangeEvent, self.DelegateOnServerParamChangeEvent)
end

function m:RemoveListeners()
	self.SignInBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateSignInBtn)
	self.FriendBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateFriendBtn)
	self.MailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateMailBtn)
	self.NoticeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateNoticeBtn)
	self.SettingBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateSettingBtn)
	self.WarehouseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateWarehouseBtn)
	self.ClosePhoneBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClosePhoneBtn)
	self.OpenPhoneBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickOpenPhoneBtn)
	self.ChangeHeroBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeHeroBtn)
	self.CompoundBtn:GetComponent("Button").onClick:RemoveListener(self.OnButtonCompoundClickDelegate)
	self.FileBtn:GetComponent("Button").onClick:RemoveListener(self.FileBtnDelegate)
	self.HeroBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHeroBtn)
	self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTaskBtn)
	self.CommunityBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCommunityBtn)
	self.ChapterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChapterBtn)
	self.WelfareCollectionBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickWelfareCollectionBtn)
	self.QuestionnairBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateQuestionnairBtnClick)
	self.ActivityCollectionBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickActivityCollectionBtn)
	EventDispatcher.RemoveEventListener(EventID.ChangeShowHcid, self.DelegateOnChangeShowHcidSucced)
	EventDispatcher.RemoveEventListener(EventID.NotifyPlayerDataChange, self.DelegateOnSkinChange)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.DelegateOnUnlockFunctionUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.ActivityPassUIActive, self.ActivityPassUIActiveEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.ActivityPassUIActiveEvent)
	EventDispatcher.RemoveEventListener(EventID.MailDataChangeEvent, self.DelegateMailDataChange)
	EventDispatcher.RemoveEventListener(EventID.GetAllMailsEvent, self.DelegateMailDataChange)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdataItem)
	EventDispatcher.RemoveEventListener(EventID.QuestionnairStateChange, self.DelegateQuestionnairStateChange)
	EventDispatcher.RemoveEventListener(EventID.ActivityOpenEvent, self.DelegateOpenActivityEvent)
	EventDispatcher.RemoveEventListener(EventID.ActivityCloseEvent, self.DelegateCloseActivityEvent)
	EventDispatcher.RemoveEventListener(EventID.ServerParamChangeEvent, self.DelegateOnServerParamChangeEvent)
end

function m:AddRedDotEventListener()
	RedDotModule.Subscribe(Constant.E_RedDotPath.MobilePhone, self.MessageEffect)
	RedDotModule.Subscribe(Constant.E_RedDotPath.LeftMenu_Friend, self.FriendBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Warehouse, self.WarehouseBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Task, self.TaskBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Warlock, self.HeroBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Community, self.CommunityBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.MobilePhone_Questionnair, self.QuestionnairBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.WelfareList, self.WelfareCollectionBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.ActivityList, self.ActivityCollectionBtn.transform:Find("RedDot").gameObject)
end

function m:RemoveRedDotEventListener()
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.MobilePhone, self.MessageEffect)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.LeftMenu_Friend, self.FriendBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Warehouse, self.WarehouseBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Task, self.TaskBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Warlock, self.HeroBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Community, self.CommunityBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.MobilePhone_Questionnair, self.QuestionnairBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.WelfareList, self.WelfareCollectionBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.ActivityList, self.ActivityCollectionBtn.transform:Find("RedDot").gameObject)
end

function m:InitShowInfo()
	self:TimeShow()
	self:InitMobilePhoneScroll()
end

function m:InitMobilePhoneScroll()
	self.ScrollPageExt.allPageCount = 2

	self.ScrollPageExt:ListPageValueInit()

	for i = 1, #self.changePageTabList do
		LuaUtility.SetGameObjectShow(self.changePageTabList[i], i <= self.ScrollPageExt.allPageCount)
	end

	for i = 1, self.ScrollPageExt.allPageCount do
		local tab = self:CreateChangeTab(i)
	end

	self.ScrollPageExt:SetHorizontalPos(0)
end

function m:CreateChangeTab(index)
	local tab = self.changePageTabList[index]

	if tab == nil then
		tab = UnityEngine.Object.Instantiate(self.TabItemPrefab)

		tab.transform:SetParent(self.phonePageToggle.transform, false)

		self.changePageTabList[index] = tab
	end

	tab:GetComponent("Toggle").isOn = false

	LuaUtility.SetGameObjectShow(tab, true)

	return tab
end

function m:OnScrollDragEnd(index)
	self.changePageTabList[index + 1]:GetComponent("Toggle").isOn = true
	self.bannerTimes = 1
end

function m:RefreshBannerScroll()
	self.lotteryBannerView:SetData(self:GetBannerDataCfg(2))
	self.shopBannerView:SetData(self:GetBannerDataCfg(1))
	LuaUtility.SetGameObjectShow(self.NotActivity, true)
end

function m:GetBannerDataCfg(type)
	local bannerCfgs = {}

	for k, v in pairsCfg(CfgPayActivityTable) do
		if v.Type == type then
			table.insert(bannerCfgs, v)
		end
	end

	table.sort(bannerCfgs, function(a, b)
		return a.Id < b.Id
	end)

	return bannerCfgs
end

function m:OnRefreshBatteryLevel()
	local batteryLevel = UnityEngine.SystemInfo.batteryLevel

	if batteryLevel == -1 then
		self.BatteryImgCom.fillAmount = 1

		return
	end

	self.BatteryImgCom.fillAmount = batteryLevel
end

function m:Dispose()
	self:__HideSkinSpine()

	if self.timer_TimeShow ~= nil then
		self.timer_TimeShow:Stop()

		self.timer_TimeShow = nil
	end

	self:StopBannerTimer()
	self.lotteryBannerView:Dispose()
	self.shopBannerView:Dispose()
	self.activityBannerView:Dispose()

	self.ScrollPageExt = nil
	self.lastMin = nil

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil

	AssetUtil.UnloadAsset(self)
end

function m:TimeShow()
	self.timer_TimeShow = Timer.New(self.DelegateOnTimeShow, 1, -1)

	self.timer_TimeShow:Start()
end

function m:SetTime()
	local TimeTable = os.date("*t", PlayerModule.GetServerTime())

	if self.lastMin == TimeTable.min then
		return
	end

	self.lastMin = TimeTable.min

	local timeText

	if TimeTable.min < 10 then
		timeText = TimeTable.hour .. ":0" .. TimeTable.min

		UGUIUtil.SetText(self.WallpaperTimeText, TimeTable.hour .. ":0" .. TimeTable.min)
	else
		timeText = TimeTable.hour .. ":" .. TimeTable.min
	end

	UGUIUtil.SetText(self.WallpaperTimeText, timeText)
	UGUIUtil.SetText(self.topTimeText, timeText)
end

function m:OnSetMobilePhoneState(state)
	self.ClosePhoneBtn:SetActive(state)
	self.MobilePhone:SetActive(state)

	if state == true then
		self:OnOpen()
		self:SetMainScrollAndBannerScrollState(true)
	end

	if state == false then
		GuideModule.TriggerGuide(Constant.GuideTriggerType.OpenUI, "MainUI")
	end
end

function m:OnOpen()
	self:OnRefreshBatteryLevel()
	self:RefreshMailState()
	self:RefreshWarehouseCapacity()
end

function m:RefreshData()
	self:OnSetHeroImg()
	self:RefreshBannerScroll()
	self:OnRefreshUnlockBtn()
	self:RefreshBtnStateByServerState()
	self:OnOpenQuestionnair()
	self:OnSetMobilePhoneState(false)
end

function m:RefreshMailState()
	local noReadCount = MailModule.GetNoReadMailCount()
	local isHasNoRead = noReadCount > 0

	LuaUtility.SetGameObjectShow(self.off, not isHasNoRead)
	LuaUtility.SetGameObjectShow(self.on, isHasNoRead)
	UGUIUtil.SetText(self.mailNumText, noReadCount)
end

function m:RefreshWarehouseCapacity()
	UGUIUtil.SetText(self.presentNumText, WarehouseModule.GetAllItemCount())
	UGUIUtil.SetText(self.allNumText, UserInfoModule.GetTalentAttr(Constant.TalentAttrType.PLAYER_WAREHOUSE_LIMIT, CfgDiscreteDataTable[48].Data[1], true))
end

function m:RefreshRedDot()
	return
end

function m:OnSetHeroImg()
	local curSkinCfg = SkinModule.GetHeroCurrentSkinConfig(PlayerModule.PlayerInfo.baseInfo.showHeroCid)

	self.CurSelectSkinCid = curSkinCfg.Id

	local path = SkinModule.GetHeroSkinImgPathByType(curSkinCfg, Constant.SkinType.StaticImage)

	self:LoadImage(path, self.WallpaperHeroImg:GetComponent("Image"))
	self:__HideSkinSpine()

	if curSkinCfg.UIDynamicEntityID ~= nil and curSkinCfg.UIDynamicEntityID ~= 0 then
		self.WallpaperHeroImg.gameObject:SetActive(false)
		self.skinSpineRoot.gameObject:SetActive(true)

		self.skinUniqueEntityID = EntityUtility.GetHeroUIEntityByDynamicPrefabCid(curSkinCfg.UIDynamicEntityID, self.skinSpineRoot.transform, Vector3.zero, function(_entityComponent)
			if _entityComponent.Id ~= self.skinUniqueEntityID then
				EntityUtility.HideEntity(_entityComponent)

				return
			end

			local previewSpine = _entityComponent.gameObject

			previewSpine.transform.localPosition = SkinModule.GetHeroDynamicSkinOffsetWithUIName(self.CurSelectSkinCid, Constant.DynamicSkinShowPosition.MobilePhone)

			local skeletonGraphic = previewSpine:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

			skeletonGraphic:Initialize(true)
			skeletonGraphic.AnimationState:SetAnimation(0, "stay", true)
		end)
	else
		self.WallpaperHeroImg.gameObject:SetActive(true)
		self.skinSpineRoot.gameObject:SetActive(false)
	end
end

function m:__HideSkinSpine()
	if self.skinUniqueEntityID == nil then
		return
	end

	if self.skinUniqueEntityID == 0 then
		return
	end

	EntityUtility.HideEntityByEntityID(self.skinUniqueEntityID)

	self.skinUniqueEntityID = 0
end

function m:OnChangeShowHcidSucced()
	self:OnSetHeroImg()
end

function m:MailDataChange()
	self:RefreshMailState()
end

function m:UpdateItem()
	self:RefreshWarehouseCapacity()
end

function m:OnClickOpenPhoneBtn()
	self.AnimCo = coroutine.start(function()
		self:OnSetMobilePhoneState(true)
		LuaUtility.RePlayAnimationWithName(self.MobilePhoneAnim, m.AnimationName.In)
		EventDispatcher.Dispatch(EventID.OpenMobilePhoneEvent, true)
		coroutine.wait(LuaUtility.GetAnimationLengthWithName(self.MobilePhoneAnim, m.AnimationName.In) - 0.5)
		coroutine.wait(0.5)
		self.ClosePhoneBtn:SetActive(true)

		self.AnimCo = nil
	end)
end

function m:OnClickClosePhoneBtn()
	self.AnimCo = coroutine.start(function()
		self.ClosePhoneBtn:SetActive(false)
		LuaUtility.RePlayAnimationWithName(self.MobilePhoneAnim, m.AnimationName.Out)
		coroutine.wait(LuaUtility.GetAnimationLengthWithName(self.MobilePhoneAnim, m.AnimationName.Out))
		self:StopBannerTimer()
		self:OnSetMobilePhoneState(false)
		EventDispatcher.Dispatch(EventID.OpenMobilePhoneEvent, false)

		self.AnimCo = nil
	end)
end

function m:OnClickSignBtn()
	if not UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_SING) then
		NoticeModule.ShowNotice(11009)

		return
	end

	UIModule.Open(Constant.UIControllerName.SignInUI, Constant.UILayer.UI)
end

function m:OnClickFriendBtn()
	UIModule.Open(Constant.UIControllerName.FriendUI, Constant.UILayer.UI)
end

function m:OnClickMailBtn()
	UIModule.Open(Constant.UIControllerName.MailUI, Constant.UILayer.UI)
end

function m:OnClickNoticeBtn()
	UIModule.Open(Constant.UIControllerName.NoticeUI, Constant.UILayer.UI, false)
end

function m:OnClickSettingBtn()
	UIModule.Open(Constant.UIControllerName.SettingUI, Constant.UILayer.UI)
end

function m:OnClickWarehouseBtn()
	UIModule.Open(Constant.UIControllerName.WarehouseUI, Constant.UILayer.UI)
end

function m:OnClickChangeHeroBtn()
	local userdata = {
		[2] = Constant.UIControllerName.FormatRoleUI
	}

	UIModule.Open(Constant.UIControllerName.WarlockChoosePanel, Constant.UILayer.UI, userdata)
end

function m:OnButtonCompoundClick()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_Compound) then
		UIModule.Open(Constant.UIControllerName.TransformUI, Constant.UILayer.UI)
	else
		NoticeModule.ShowNotice(19001)
	end
end

function m:OnFileBtnClick()
	UIModule.Open(Constant.UIControllerName.ArchivesUI, Constant.UILayer.UI)
end

function m:OnClickPlayeInfoBtn()
	UIModule.Open(Constant.UIControllerName.UserInfoUI, Constant.UILayer.UI, {
		UserInfoModule.GetPlayerInfo(),
		true
	})
end

function m:OnClickHeroBtn()
	UIModule.Open(Constant.UIControllerName.WarlockChoosePanel, Constant.UILayer.UI)
end

function m:OnClickTaskBtn()
	UIModule.Open(Constant.UIControllerName.TaskSystemUI, Constant.UILayer.UI)
end

function m:SetMainScrollAndBannerScrollState(state)
	LuaUtility.SetGameObjectShow(self.MobilePhoneScroll, state)
end

function m:OnClickCommunityBtn()
	UIModule.Open(Constant.UIControllerName.CommunityUI, Constant.UILayer.UI)
end

function m:OnClickChapterBtn()
	UIModule.Open(Constant.UIControllerName.PlayingMethodUI, Constant.UILayer.UI)
end

function m:OnClickWelfareCollectionBtn()
	UIModule.Open(Constant.UIControllerName.ActivityListUI, Constant.UILayer.UI, {
		teamID = Constant.ActivityListTeamID.Welfare
	})
end

function m:OnClickActivityCollectionBtn()
	UIModule.Open(Constant.UIControllerName.ActivityListUI, Constant.UILayer.UI, {
		teamID = Constant.ActivityListTeamID.Activity
	})
end

function m:QuestionnairBtnClick()
	local url = PlayerModule.GetQuestionUrl(self.questionConfig.Url, self.questionConfig.Id, self.questionConfig.Activity)

	Application.OpenURL(url)
	RedDotModule.ClearRedDotByRedDotID(Constant.E_RedDotPath.MobilePhone_Questionnair)
end

function m:OnOpenQuestionnair()
	local questionConfig = PlayerModule.GetIsOpenQuestionnaire()

	self.questionConfig = questionConfig

	LuaUtility.SetGameObjectShow(self.QuestionnairBtn, self.questionConfig ~= nil)
end

function m:OnRefreshUnlockBtn()
	UnlockFunctionModule.FuncSwitchHandler(self.funcList)
	self:RefreshBtnVisable()
end

function m:RefreshBtnStateByServerState()
	LuaUtility.SetGameObjectShow(self.CommunityBtn, false)

	local result = PlayerModule.GetServerParamByKey(Constant.ServerParams.GM_COMMUNITY)

	if result == nil or result == "false" then
		LuaUtility.SetGameObjectShow(self.CommunityBtn, false)
		RedDotModule.ClearRedDotByRedDotID(Constant.E_RedDotPath.Community)
	else
		LuaUtility.SetGameObjectShow(self.CommunityBtn, true)
	end
end

function m:RefreshWelfareBtnAndActivityBtnState()
	local activityTabList = ActivityListModule.GetActivityListByTeamID(Constant.ActivityListTeamID.Activity)

	LuaUtility.SetGameObjectShow(self.ActivityCollectionBtn, table.len(activityTabList) > 0)

	activityTabList = ActivityListModule.GetActivityListByTeamID(Constant.ActivityListTeamID.Welfare)

	LuaUtility.SetGameObjectShow(self.WelfareCollectionBtn, table.len(activityTabList) > 0)
end

function m:OnOpenActivityEvent()
	self:OnOpenQuestionnair()
	self:RefreshWelfareBtnAndActivityBtnState()
end

function m:OnCloseActivityEvent()
	self:OnOpenQuestionnair()
	self:RefreshWelfareBtnAndActivityBtnState()
end

function m:OnServerParamChangeEvent()
	self:RefreshBtnStateByServerState()
end

function m:RefreshBtnVisable()
	self:RefreshBannerScroll()
	self:RefreshWelfareBtnAndActivityBtnState()
end

function m:BannerRoll()
	self:StopBannerTimer()

	if self.BannerScrollPageExt.allPageCount <= 1 then
		return
	end

	self.bannerSelectIndex = 0

	self.BannerScrollPageExt:ResetHorizontalPos()
	self.BannerScrollPageExt:SetHorizontalPos(0)

	self.bannerRollTimer = Timer.New(function()
		self.bannerTimes = self.bannerTimes + 1

		if self.bannerTimes >= self.bannerTotalTimes then
			self.bannerSelectIndex = self.bannerSelectIndex + 1

			if self.bannerSelectIndex > self.BannerScrollPageExt.allPageCount then
				self.bannerSelectIndex = 1
			end

			self.BannerScrollPageExt:SetHorizontalPos(self.bannerSelectIndex - 1)
		end
	end, 1, -1)

	self.bannerRollTimer:Start()
end

function m:StopBannerTimer()
	if self.bannerRollTimer ~= nil then
		self.bannerRollTimer:Stop()

		self.bannerRollTimer = nil
	end
end

function m:LoadImage(path, imgobj)
	AssetUtil.LoadImage(self, path, imgobj, self.LoadImageSucess, nil, imgobj)
end

function m:LoadImageSucess(assetName, asset, duration, userData)
	userData:SetNativeSize()
	LuaUtility.SetImageRectTransformPivot(userData.rectTransform, userData)
end

return m
