-- chunkname: @modules/logic/activity/view/ActivityBeginnerView.lua

module("modules.logic.activity.view.ActivityBeginnerView", package.seeall)

local ActivityBeginnerView = class("ActivityBeginnerView", BaseView)

function ActivityBeginnerView:onInitView()
	self._gocategory = gohelper.findChild(self.viewGO, "#go_category")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "#go_category/#scroll_categoryitem")
	self._gosubview = gohelper.findChild(self.viewGO, "#go_subview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityBeginnerView:addEvents()
	return
end

function ActivityBeginnerView:removeEvents()
	return
end

function ActivityBeginnerView:_editableInitView()
	self._goblackloading = gohelper.findChild(self.viewGO, "#blackloading")
	self._animLoading = self._goblackloading:GetComponent(typeof(UnityEngine.Animator))
	self._animUI = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._actHideTab = {
		[ActivityEnum.Activity.V3a4_GiftRecommend] = self._isCanOpenV3a4GiftRecommendAct,
		[ActivityEnum.Activity.V3a7_SelfSelect] = self._isCanOpenV3a7SelfSelectAct,
		[ActivityEnum.Activity.S02SceneUIPackageAct] = self._isCanOpenV3a4GiftRecommendAct
	}
end

local activitySubViewDict = {
	[ActivityEnum.Activity.NorSign] = ViewName.ActivityNorSignView,
	[ActivityEnum.Activity.NoviceInsight] = ViewName.ActivityNoviceInsightView,
	[ActivityEnum.Activity.StoryShow] = ViewName.ActivityStoryShowView,
	[ActivityEnum.Activity.DreamShow] = ViewName.ActivityDreamShowView,
	[ActivityEnum.Activity.ClassShow] = ViewName.ActivityClassShowView,
	[ActivityEnum.Activity.VersionActivity1_3Radio] = ViewName.VersionActivity1_3RadioView,
	[ActivityEnum.Activity.SummerSignPart1_1_2] = ViewName.SummerSignPart1View_1_2,
	[ActivityEnum.Activity.SummerSignPart2_1_2] = ViewName.SummerSignPart2View_1_2,
	[ActivityEnum.Activity.DoubleFestivalSign_1_3] = ViewName.ActivityDoubleFestivalSignView_1_3,
	[ActivityEnum.Activity.StarLightSignPart1_1_3] = ViewName.ActivityStarLightSignPart1View_1_3,
	[ActivityEnum.Activity.StarLightSignPart2_1_3] = ViewName.ActivityStarLightSignPart2View_1_3,
	[ActivityEnum.Activity.DailyAllowance] = ViewName.DailyAllowanceView,
	[ActivityEnum.Activity.Activity1_5WarmUp] = ViewName.VersionActivity1_5WarmUpView,
	[ActivityEnum.Activity.RoleSignViewPart1_1_5] = ViewName.V1a5_Role_FullSignView_Part1,
	[ActivityEnum.Activity.RoleSignViewPart2_1_5] = ViewName.V1a5_Role_FullSignView_Part2,
	[ActivityEnum.Activity.DoubleFestivalSign_1_5] = ViewName.V1a5_DoubleFestival_FullSignView,
	[ActivityEnum.Activity.FurnaceTreasure] = ViewName.FurnaceTreasureView,
	[ActivityEnum.Activity.NewYearEve] = ViewName.NewYearEveActivityView,
	[ActivityEnum.Activity.Activity1_6WarmUp] = ViewName.VersionActivity1_6WarmUpView,
	[ActivityEnum.Activity.RoleSignViewPart1_1_7] = ViewName.V1a7_Role_FullSignView_Part1,
	[ActivityEnum.Activity.RoleSignViewPart2_1_7] = ViewName.V1a7_Role_FullSignView_Part2,
	[ActivityEnum.Activity.LanternFestival] = ViewName.LanternFestivalActivityView,
	[ActivityEnum.Activity.Activity1_7WarmUp] = ViewName.VersionActivity1_7WarmUpView,
	[ActivityEnum.Activity.RoleSignViewPart1_1_8] = ViewName.V1a8_Role_FullSignView_Part1,
	[ActivityEnum.Activity.RoleSignViewPart2_1_8] = ViewName.V1a8_Role_FullSignView_Part2,
	[ActivityEnum.Activity.Activity1_8WarmUp] = ViewName.VersionActivity1_8WarmUpView,
	[ActivityEnum.Activity.Work_SignView_1_8] = ViewName.V1a8_Work_FullSignView,
	[ActivityEnum.Activity.RoleSignViewPart1_1_9] = ViewName.V1a9_Role_FullSignView_Part1,
	[ActivityEnum.Activity.RoleSignViewPart2_1_9] = ViewName.V1a9_Role_FullSignView_Part2,
	[ActivityEnum.Activity.DragonBoatFestival] = ViewName.DragonBoatFestivalActivityView,
	[ActivityEnum.Activity.AnniversarySignView_1_9] = ViewName.V1a9_AnniversarySign_FullSignView,
	[ActivityEnum.Activity.RoomGift] = ViewName.RoomGiftView,
	[ActivityEnum.Activity.Activity1_9WarmUp] = ViewName.VersionActivity1_9WarmUpView,
	[ActivityEnum.Activity.V2a2_DecalogPresent] = ViewName.V1a9DecalogPresentFullView,
	[ActivityEnum.Activity.SelfSelectCharacter] = ViewName.Activity136FullView,
	[ActivityEnum.Activity.V1a9_SemmelWeisGift] = ViewName.SemmelWeisGiftFullView,
	[ActivityEnum.Activity.V2a0_SummerSign] = ViewName.V2a0_SummerSign_FullView,
	[ActivityEnum.Activity.V2a0_Role_SignView_Part1] = ViewName.V2a0_Role_FullSignView_Part1,
	[ActivityEnum.Activity.V2a0_Role_SignView_Part2] = ViewName.V2a0_Role_FullSignView_Part2,
	[ActivityEnum.Activity.V2a0_WarmUp] = ViewName.V2a0_WarmUp,
	[ActivityEnum.Activity.V2a1_Role_SignView_Part1] = ViewName.V2a1_Role_FullSignView_Part1,
	[ActivityEnum.Activity.V2a1_Role_SignView_Part2] = ViewName.V2a1_Role_FullSignView_Part2,
	[ActivityEnum.Activity.V2a1_MoonFestival] = ViewName.V2a1_MoonFestival_FullView,
	[ActivityEnum.Activity.V2a1_WarmUp] = ViewName.V2a1_WarmUp,
	[ActivityEnum.Activity.V2a2_Role_SignView_Part1] = ViewName.V2a2_Role_FullSignView_Part1,
	[ActivityEnum.Activity.V2a2_Role_SignView_Part2] = ViewName.V2a2_Role_FullSignView_Part2,
	[ActivityEnum.Activity.V2a2_TurnBack_H5] = ViewName.TurnBackInvitationMainView,
	[ActivityEnum.Activity.V2a2_SummonCustomPickNew] = ViewName.SummonNewCustomPickView,
	[ActivityEnum.Activity.v2a2_RedLeafFestival] = ViewName.V2a2_RedLeafFestival_FullView,
	[VersionActivity2_2Enum.ActivityId.LimitDecorate] = ViewName.Activity173PanelView,
	[ActivityEnum.Activity.V2a2_WarmUp] = ViewName.V2a2_WarmUp,
	[ActivityEnum.Activity.RoomSign] = ViewName.VersionActivity2_2RoomSignView,
	[ActivityEnum.Activity.V2a3_NewCultivationGift] = ViewName.VersionActivity2_3NewCultivationGiftView,
	[ActivityEnum.Activity.V2a3_Role_SignView_Part1] = ViewName.V2a3_Role_FullSignView_Part1,
	[ActivityEnum.Activity.V2a3_Role_SignView_Part2] = ViewName.V2a3_Role_FullSignView_Part2,
	[ActivityEnum.Activity.LinkageActivity_FullView] = ViewName.LinkageActivity_FullView,
	[ActivityEnum.Activity.V2a3_WarmUp] = ViewName.V2a3_WarmUp,
	[ActivityEnum.Activity.V2a3_Special] = ViewName.V2a3_Special_FullSignView,
	[ActivityEnum.Activity.V2a4_Blind_Box_Draw] = ViewName.Activity181MainView,
	[ActivityEnum.Activity.V2a4_Role_SignView_Part1] = ViewName.V2a4_Role_FullSignView_Part1,
	[ActivityEnum.Activity.V2a4_Role_SignView_Part2] = ViewName.V2a4_Role_FullSignView_Part2,
	[ActivityEnum.Activity.V2a4_WarmUp] = ViewName.V2a4_WarmUp,
	[ActivityEnum.Activity.V2a5_Role_SignView_Part1] = ViewName.V2a5_Role_FullSignView_Part1,
	[ActivityEnum.Activity.V2a5_Role_SignView_Part2] = ViewName.V2a5_Role_FullSignView_Part2,
	[ActivityEnum.Activity.V2a5_TurnBack_H5] = ViewName.TurnBackInvitationMainView,
	[ActivityEnum.Activity.V2a5_DecaLogPresent] = ViewName.V2a5DecalogPresentFullView,
	[ActivityEnum.Activity.V2a5_DecorateStore] = ViewName.V2a5_DecorateStoreFullView,
	[ActivityEnum.Activity.V2a5_GoldenMilletPresent] = ViewName.V2a5_GoldenMilletPresentFullView,
	[ActivityEnum.Activity.V2a5_WarmUp] = ViewName.V2a5_WarmUp,
	[ShortenActConfig.instance:getActivityId()] = ViewName.ShortenAct_FullView,
	[ActivityEnum.Activity.V2a6_WeekwalkHeart] = ViewName.V2a6_WeekwalkHeart_FullView,
	[ActivityEnum.Activity.V2a6_WarmUp] = ViewName.V2a6_WarmUp,
	[ActivityEnum.Activity.V2a7_Labor_Sign] = ViewName.V2a7_Labor_FullSignView,
	[ActivityEnum.Activity.V2a7_WarmUp] = ViewName.V2a7_WarmUp,
	[ActivityEnum.Activity.V2a7_SelfSelectSix1] = ViewName.V2a7_SelfSelectSix_FullView,
	[ActivityEnum.Activity.V2a7_TowerGift] = ViewName.TowerGiftFullView,
	[ActivityEnum.Activity.V2a9_VersionSummon_Part1] = ViewName.V2a9_VersionSummonFull_Part1,
	[ActivityEnum.Activity.V2a9_VersionSummon_Part2] = ViewName.V2a9_VersionSummonFull_Part2,
	[ActivityEnum.Activity.V2a9_TurnBackH5] = ViewName.TurnBackInvitationMainView,
	[ActivityEnum.Activity.V2a9_NewCultivationGift] = ViewName.VersionActivity2_3NewCultivationGiftView,
	[ActivityEnum.Activity.V2a7_SelfSelectSix2] = ViewName.V2a7_SelfSelectSix_FullView,
	[ActivityEnum.Activity.V2a8_DecaLogPresent] = ViewName.V2a8DecalogPresentFullView,
	[ActivityEnum.Activity.V2a8_NewCultivationDestiny] = ViewName.VersionActivity2_3NewCultivationGiftView,
	[ActivityEnum.Activity.V2a8_DragonBoat] = ViewName.V2a8_DragonBoat_FullView,
	[ActivityEnum.Activity.V2a8_WuErLiXiGift] = ViewName.V2a8_WuErLiXiGiftFullView,
	[ActivityEnum.Activity.V3a0_NewCultivationGift] = ViewName.VersionActivity2_3NewCultivationGiftView,
	[ActivityEnum.Activity.V3a0_SummerSign] = ViewName.V3a0_SummerSign_FullView,
	[ActivityEnum.Activity.V2a9_WarmUp] = ViewName.V2a9_WarmUp,
	[ActivityEnum.Activity.V2a9_Act208] = ViewName.V2a9_Act208MainView,
	[VersionActivity3_1Enum.ActivityId.SurvivalOperAct] = ViewName.SurvivalOperActFullView,
	[VersionActivity3_1Enum.ActivityId.TowerDeep] = ViewName.TowerDeepOperActFullView,
	[BpModel.instance:getCurVersionOperActId()] = ViewName.V3a1_BpOperActShowView,
	[ActivityEnum.Activity.V3a1_AutumnSign] = ViewName.V3a1_AutumnSign_FullView,
	[ActivityEnum.Activity.V3a1_NewCultivationDestiny] = ViewName.VersionActivity2_3NewCultivationGiftView,
	[VersionActivity3_2Enum.ActivityId.CruiseTripleDrop] = ViewName.V3a6DoubleDropView,
	[ActivityEnum.Activity.V3a3_TowerDeep] = ViewName.V3a3TowerGiftFullView,
	[ActivityEnum.Activity.V3a3_SkinDiscount] = ViewName.SkinDiscountCompensateActivityView,
	[ActivityEnum.Activity.V3a4_GiftRecommend] = ViewName.V3a4GiftRecommendFullview,
	[ActivityEnum.Activity.V3a4_DestinyGift] = ViewName.V3a4DestinyGiftFullView,
	[ActivityEnum.Activity.V3a4_GoldenMilletPresent] = ViewName.V3a4_GoldenMilletPresentFullView,
	[ActivityEnum.Activity.V3a5_SchoolStart] = ViewName.V3a5_SchoolStartView,
	[ActivityEnum.Activity.V3a7_SelfSelect] = ViewName.V3a7SelfSelectFullView,
	[ActivityEnum.Activity.V3a7_SkinGift] = ViewName.V3a7_SkinGiftFullView,
	[ActivityEnum.Activity.SP02_LinkGift] = ViewName.SP02_LinkGiftFullView,
	[ActivityEnum.Activity.V3a8_DragonBoatActivity_FullView] = ViewName.V3a8_DragonBoatActivity_FullView,
	[ActivityEnum.Activity.SP02_WarmUp] = ViewName.WarmUp,
	[ActivityEnum.Activity.V3a9_BDuckLinkage] = ViewName.V3a9_BDuckLinkageFullView
}
local actTypeSubViewDict = {
	[ActivityEnum.ActivityTypeID.OpenTestWarmUp] = ViewName.ActivityWarmUpView,
	[ActivityEnum.ActivityTypeID.DoubleDrop] = ViewName.V1a7_DoubleDropView,
	[ActivityEnum.ActivityTypeID.Act171] = ViewName.TurnBackInvitationMainView,
	[ActivityEnum.ActivityTypeID.Act201] = ViewName.TurnBackFullView
}
local _actCostIdToViewDict = {
	[ActivityEnum.ConstId.Gifg5StarCharacter] = ViewName.V1a9_ActivityShow_MatildagiftView,
	[ActivityEnum.ConstId.Gifg6StarCharacter] = ViewName.V2a8_WuErLiXiGiftFullView
}

function ActivityBeginnerView:onUpdateParam()
	return
end

function ActivityBeginnerView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshView, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, self.setCategoryListInteractable, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.summonShowBlackScreen, self.onReceiveShowBlackScreen, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.summonShowExitAnim, self.startExitLoading, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.summonCloseBlackScreen, self.onReceiveCloseBlackScreen, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.summonMainCloseImmediately, self.closeThis, self)
	self:_initRole_FullSignView()
	self:_initSpecial_FullSignView()
	self:_initLinkageActivity_FullView()
	self:_initWarmUp()
	self:_initWarmUpH5()
	self:_initSelfSelectCharacter()
	self:_initVersionSummon()
	self:_initCultivationDestiny()
	self:_initDoubleDan()
	self:_initNationalGift()
	self:_initDoubleDrop()
	self:_initActivityCollect()
	self:_initActivity()
	self:_initGoldenMilletPresent()
	self:_initFreeMonthCard()
	self:_initSceneUIPackageAct()

	self._needSetSortInfos = true

	self:_refreshView()

	self._needSetSortInfos = false
end

function ActivityBeginnerView:_refreshView()
	local actCo = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)

	if not actCo or not next(actCo) then
		self:closeThis()
	end

	ActivityModel.instance:removeFinishedCategory(actCo)

	self.data = {}

	local isIos = BootNativeUtil.isIOS()

	for _, v in pairs(actCo) do
		if isIos and ActivityEnum.IOSHideActIdMap[tonumber(v)] then
			logNormal("iOS临时屏蔽双端登录活动入口")
		else
			local hasAct = self:_checkHasAct(v)

			if hasAct then
				local o = {}

				o.id = v
				o.co = ActivityConfig.instance:getActivityCo(v)
				o.type = ActivityEnum.ActivityType.Beginner

				table.insert(self.data, o)
			end
		end
	end

	if self._needSetSortInfos then
		self._needSetSortInfos = false

		ActivityBeginnerCategoryListModel.instance:setSortInfos(self.data)
		ActivityBeginnerCategoryListModel.instance:checkTargetCategory(self.data)
	end

	ActivityBeginnerCategoryListModel.instance:setOpenViewTime()
	ActivityBeginnerCategoryListModel.instance:setCategoryList(self.data)
	self:_openSubView()
end

function ActivityBeginnerView:_checkHasAct(id)
	local actHideTab = self._actHideTab[id]

	if actHideTab then
		return (actHideTab(self, id))
	end

	return true
end

function ActivityBeginnerView:_openSubView()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)
	end

	local actId = ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Beginner)

	self._viewName = activitySubViewDict[actId]

	if actId ~= 0 then
		self:setCategoryRedDotData(actId)
	end

	if not self._viewName then
		local co = ActivityConfig.instance:getActivityCo(actId)

		if co then
			if actTypeSubViewDict[co.typeId] then
				self._viewName = actTypeSubViewDict[co.typeId]
			end

			self.viewContainer:refreshHelp(co.typeId)
		else
			self.viewContainer:hideHelp()

			return
		end
	else
		self.viewContainer:hideHelp()
	end

	local viewParam = {
		parent = self._gosubview,
		actId = actId,
		root = self.viewGO
	}

	ViewMgr.instance:openView(self._viewName, viewParam, true)

	local var_9_0 = {
		[StatEnum.EventProperties.ViewName] = "ActivityBeginnerView"
	}

	var_9_0[StatEnum.EventProperties.ButtonName] = self._viewName or ""

	StatController.instance:track(StatEnum.EventName.ButtonClick, var_9_0)
end

function ActivityBeginnerView:setCategoryRedDotData(actId)
	local key = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(key, "hasEnter")

	return key
end

function ActivityBeginnerView:closeSubView()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)

		self._viewName = nil
	end
end

function ActivityBeginnerView:onClose()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshView, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, self.setCategoryListInteractable, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.summonShowBlackScreen, self.onReceiveShowBlackScreen, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.summonShowExitAnim, self.startExitLoading, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.summonCloseBlackScreen, self.onReceiveCloseBlackScreen, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.summonMainCloseImmediately, self.closeThis, self)
	self:closeSubView()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	ActivityBeginnerCategoryListModel.instance:clear()
	TaskDispatcher.cancelTask(self.afterBlackLoading, self)
	TaskDispatcher.cancelTask(self.afterCloseLoading, self)
	UIBlockMgr.instance:endAll()
	PostProcessingMgr.instance:forceRefreshCloseBlur()
end

function ActivityBeginnerView:setCategoryListInteractable(isInteractable)
	self._categoryListCanvasGroup = self._categoryListCanvasGroup or gohelper.onceAddComponent(self._gocategory, typeof(UnityEngine.CanvasGroup))
	self._categoryListCanvasGroup.interactable = isInteractable
	self._categoryListCanvasGroup.blocksRaycasts = isInteractable
	self._categoryListCanvasGroup.blocksRaycasts = isInteractable
end

function ActivityBeginnerView:onReceiveShowBlackScreen()
	gohelper.setActive(self._goblackloading, true)
	self._animLoading:Play("blackloading_open", 0, 0)

	self._isShowBlackScreen = true

	TaskDispatcher.runDelay(self.afterBlackLoading, self, 0.3)
end

function ActivityBeginnerView:afterBlackLoading()
	TaskDispatcher.cancelTask(self.afterBlackLoading, self)
	gohelper.setActive(self.viewGO, false)
	SummonController.instance:onFirstLoadSceneBlock()
end

function ActivityBeginnerView:onReceiveCloseBlackScreen()
	if not gohelper.isNil(self._animLoading) then
		self._animLoading:Play("blackloading_close", 0, 0)
	end

	TaskDispatcher.runDelay(self.afterCloseLoading, self, 0.3)
end

function ActivityBeginnerView:afterCloseLoading()
	TaskDispatcher.cancelTask(self.afterCloseLoading, self)
	self:closeThis()
end

function ActivityBeginnerView:startExitLoading()
	if not gohelper.isNil(self._animUI) then
		self._animUI:Play(UIAnimationName.Close, 0, 0)
	end

	return 0.16
end

function ActivityBeginnerView:onDestroyView()
	return
end

local s_Role_FullSignView = false

function ActivityBeginnerView:_initRole_FullSignView()
	if s_Role_FullSignView then
		return
	end

	s_Role_FullSignView = true

	local roleSignActIdList = ActivityType101Config.instance:getRoleSignActIdList()
	local key1 = GameBranchMgr.instance:Vxax_ActId("Role_SignView_Part1", roleSignActIdList[1])

	if key1 then
		activitySubViewDict[key1] = GameBranchMgr.instance:Vxax_ViewName("Role_FullSignView_Part1", ViewName.Role_FullSignView_Part1)
	end

	local key2 = GameBranchMgr.instance:Vxax_ActId("Role_SignView_Part2", roleSignActIdList[2])

	if key2 then
		activitySubViewDict[key2] = GameBranchMgr.instance:Vxax_ViewName("Role_FullSignView_Part2", ViewName.Role_FullSignView_Part2)
	end
end

local s_Special_FullSignView = false

function ActivityBeginnerView:_initSpecial_FullSignView()
	if s_Special_FullSignView then
		return
	end

	s_Special_FullSignView = true

	local key = GameBranchMgr.instance:Vxax_ActId("Special", ActivityEnum.Activity.V2a3_Special)

	activitySubViewDict[key] = GameBranchMgr.instance:Vxax_ViewName("Special_FullSignView", ViewName.V2a3_Special_FullSignView)
end

local s_LinkageActivity_FullView = false

function ActivityBeginnerView:_initLinkageActivity_FullView()
	if s_LinkageActivity_FullView then
		return
	end

	s_LinkageActivity_FullView = true

	local key = GameBranchMgr.instance:Vxax_ActId("LinkageActivity", ActivityEnum.Activity.LinkageActivity_FullView)

	activitySubViewDict[key] = GameBranchMgr.instance:Vxax_ViewName("LinkageActivity_FullView", ViewName.LinkageActivity_FullView)
end

local s_WarmUp = false

function ActivityBeginnerView:_initWarmUp()
	if s_WarmUp then
		return
	end

	s_WarmUp = true

	local actId = Activity125Config.instance:getWarmUpActId()
	local key = GameBranchMgr.instance:Vxax_ActId("WarmUp", actId)
	local val = GameBranchMgr.instance:Vxax_ViewName("WarmUp", ViewName.WarmUp)

	activitySubViewDict[key] = activitySubViewDict[key] or val

	local actId1 = Activity125Config.instance:getWarmUp1ActId()
	local key1 = GameBranchMgr.instance:Vxax_ActId("WarmUp1", actId1)
	local val1 = GameBranchMgr.instance:Vxax_ViewName("WarmUp1", ViewName.WarmUp1)

	activitySubViewDict[key1] = activitySubViewDict[key1] or val1
end

function ActivityBeginnerView:_initSceneUIPackageAct()
	local actId = SceneUIPackageModel.instance:getActId()

	activitySubViewDict[actId] = ViewName.SceneUIPackageFullView
end

local s_WarmUpH5 = false

function ActivityBeginnerView:_initWarmUpH5()
	if s_WarmUpH5 then
		return
	end

	s_WarmUpH5 = true

	local actIdList = ActivityType100Config.instance:getWarmUpH5ActIdList()

	for _, actId in ipairs(actIdList) do
		activitySubViewDict[actId] = GameBranchMgr.instance:Vxax_ViewName("ActivityWarmUpH5FullView", ViewName.ActivityWarmUpH5FullView)
	end
end

local s_SelfSelectCharacter = false

function ActivityBeginnerView:_initSelfSelectCharacter()
	if s_SelfSelectCharacter then
		return
	end

	s_SelfSelectCharacter = true

	local actId = Activity136Controller.instance:actId()

	activitySubViewDict[actId] = ViewName.Activity136FullView
end

local s_VersionSummon = false

function ActivityBeginnerView:_initVersionSummon()
	if s_VersionSummon then
		return
	end

	s_VersionSummon = true

	local actIdList = ActivityType101Config.instance:getVersionSummonActIdList()
	local key1 = GameBranchMgr.instance:Vxax_ActId("VersionSummon_Part1", actIdList[1])

	if key1 then
		activitySubViewDict[key1] = GameBranchMgr.instance:Vxax_ViewName("VersionSummon_Part1", ViewName.VersionSummonFull_Part1)
	end

	local key2 = GameBranchMgr.instance:Vxax_ActId("VersionSummon_Part2", actIdList[2])

	if key2 then
		activitySubViewDict[key2] = GameBranchMgr.instance:Vxax_ViewName("VersionSummonFull_Part2", ViewName.VersionSummonFull_Part2)
	end
end

local s_CultivationDestiny = false

function ActivityBeginnerView:_initCultivationDestiny()
	if s_CultivationDestiny then
		return
	end

	s_CultivationDestiny = true

	local actId = Activity125Config.instance:getCultivationDestinyActId()

	activitySubViewDict[actId] = activitySubViewDict[actId] or ViewName.VersionActivity2_3NewCultivationGiftView
end

local s_DoubleDan = false

function ActivityBeginnerView:_initDoubleDan()
	if s_DoubleDan then
		return
	end

	s_DoubleDan = true

	local actId = GameBranchMgr.instance:Vxax_ActId("DoubleDan", ActivityType101Config.instance:getDoubleDanActId())

	if actId then
		activitySubViewDict[actId] = GameBranchMgr.instance:Vxax_ViewName("DoubleDanActivity_FullView", ViewName.V3a3_DoubleDanActivity_FullView)
	end
end

local s_NationalGift = false

function ActivityBeginnerView:_initNationalGift()
	if s_NationalGift then
		return
	end

	s_NationalGift = true

	local actId = NationalGiftModel.instance:getCurVersionActId()

	if actId then
		activitySubViewDict[actId] = GameBranchMgr.instance:Vxax_ViewName("NationalGiftFullView", ViewName.NationalGiftFullView)
	end
end

function ActivityBeginnerView:_initDoubleDrop()
	local actIdList = Activity217Config.instance:getActIdList()

	for index, actId in ipairs(actIdList) do
		if ActivityHelper.isOpen(actId) then
			activitySubViewDict[actId] = ViewName.V3a6DoubleDropView
		end
	end
end

function ActivityBeginnerView:_initActivityCollect()
	local actId = ActivityCollectModel.instance:getCurActivityId()

	if actId and not activitySubViewDict[actId] then
		activitySubViewDict[actId] = ViewName.ActivityCollectView
	end
end

function ActivityBeginnerView:_initActivity()
	local tActivityConfig = ActivityConfig.instance

	for actConstId, viewName in pairs(_actCostIdToViewDict) do
		local actId = tActivityConfig:getConstAsNum(actConstId, 0)

		self:_addActivityDict(actId, viewName)
	end
end

function ActivityBeginnerView:_addActivityDict(actId, viewName)
	if actId and actId ~= 0 then
		activitySubViewDict[actId] = viewName
	end
end

function ActivityBeginnerView:_isCanOpenV3a4GiftRecommendAct(actId)
	local isOpenAct = ActivityType101Model.instance:isOpen(actId)

	if not isOpenAct then
		return false
	end

	local signInfo = ActivityType101Model.instance:getType101Info(actId)

	if signInfo then
		for _, info in ipairs(signInfo) do
			if info.state < 2 then
				return true
			end
		end
	end

	local hasScene = SceneUIPackageModel.instance:hasScene(actId)
	local hasUI = SceneUIPackageModel.instance:hasUI(actId)
	local canBuy = SceneUIPackageModel.instance:canBuy(actId)

	if canBuy or not hasScene or not hasUI then
		return true
	end

	return false
end

function ActivityBeginnerView:_isCanOpenV3a7SelfSelectAct(actId)
	local isOpenAct = ActivityType101Model.instance:isOpen(actId)

	if not isOpenAct then
		return false
	end

	local actCo = ActivityConfig.instance:getActivityCo(actId)

	if not actCo then
		return false
	end

	local isCanClaim = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)

	if isCanClaim then
		return true
	end

	local goodsId = tonumber(actCo.patFaceParam)
	local goodsMo = StoreModel.instance:getGoodsMO(goodsId)

	if not goodsMo then
		return false
	end

	local isSoldOut = goodsMo:isSoldOut()

	if isSoldOut then
		return false
	end

	return true
end

local s_GoldenMilletPresent = false

function ActivityBeginnerView:_initGoldenMilletPresent()
	if s_GoldenMilletPresent then
		return
	end

	s_GoldenMilletPresent = true

	local actId = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()

	if actId then
		activitySubViewDict[actId] = GameBranchMgr.instance:Vxax_ViewName("GoldenMilletPresentFull", ViewName.GoldenMilletPresentFull)
	end
end

function ActivityBeginnerView:_initFreeMonthCard()
	activitySubViewDict[ActivityEnum.Activity.V2a9_FreeMonthCard] = ViewName.V2a9_FreeMonthCard_FullView
	activitySubViewDict[VersionActivity3_8Enum.ActivityId.FreeMonthCard] = ViewName.VersionActivity3_8FreeMonthCardFullView
end

return ActivityBeginnerView
