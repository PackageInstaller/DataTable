-- chunkname: @modules/logic/main/view/MainThumbnailBtnView.lua

module("modules.logic.main.view.MainThumbnailBtnView", package.seeall)

local MainThumbnailBtnView = class("MainThumbnailBtnView", BaseView)

function MainThumbnailBtnView:onInitView()
	self._btnhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_handbook")
	self._goreddotHandbook = gohelper.findChild(self.viewGO, "btns/btn_content/#go_content/#btn_handbook/#go_reddot")
	self._btnsocial = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_social")
	self._gosocialreddot = gohelper.findChild(self.viewGO, "btns/btn_content/#go_content/#btn_social/#go_socialreddot")
	self._btnbell = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_bell")
	self._btnplayercard = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_playercard")
	self._goreddotplayercard = gohelper.findChild(self.viewGO, "btns/btn_content/#go_content/#btn_playercard/#go_reddot")
	self._btnfeedback = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_feedback")
	self._gobelllreddot = gohelper.findChild(self.viewGO, "btns/btn_content/#go_content/#btn_bell/#go_belllreddot")
	self._btncalendar = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_calendar")
	self._gocalendarreddot = gohelper.findChild(self.viewGO, "btns/btn_content/#go_content/#btn_calendar/#go_calendarreddot")
	self._btnsetting = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_setting")
	self._btnzhoubian = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_zhoubian")
	self._btnachievement = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_achievement")
	self._goachievementreddot = gohelper.findChild(self.viewGO, "btns/btn_content/#go_content/#btn_achievement/#go_achievementreddot")
	self._btnrecordvideo = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_recordvideo")
	self._btnteam = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_team")
	self._btnudimo = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_udimo")
	self._btnTeaching = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn_content/#go_content/#btn_teaching")
	self._goRedDotTeaching = gohelper.findChild(self.viewGO, "btns/btn_content/#go_content/#btn_teaching/#go_reddot")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "btns/#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "btns/#btn_right")
	self._gocontent = gohelper.findChild(self.viewGO, "btns/btn_content/#go_content")
	self._gobtncontent1 = gohelper.findChild(self.viewGO, "btns/btn_content/#go_content/#go_btncontent1")
	self._gobtncontent2 = gohelper.findChild(self.viewGO, "btns/btn_content/#go_content/#go_btncontent2")
	self._goscroll = gohelper.findChild(self.viewGO, "btns/#go_scroll")
	self._playercardreddot = RedDotController.instance:addNotEventRedDot(self._goreddotplayercard, self._isShowPlayerCardRedDot, self)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainThumbnailBtnView:addEvents()
	self._btnhandbook:AddClickListener(self._btnhandbookOnClick, self)
	self._btnsocial:AddClickListener(self._btnsocialOnClick, self)
	self._btnplayercard:AddClickListener(self._btnplayercardOnClick, self)
	self._btnbell:AddClickListener(self._btnbellOnClick, self)
	self._btncalendar:AddClickListener(self._btncalendarOnClick, self)
	self._btnsetting:AddClickListener(self._btnsettingOnClick, self)
	self._btnzhoubian:AddClickListener(self._btnzhoubianOnClick, self)
	self._btnfeedback:AddClickListener(self._btnfeedbackOnClick, self)
	self._btnachievement:AddClickListener(self._btnachievementOnClick, self)
	self._btnrecordvideo:AddClickListener(self._btnrecordvideoOnClick, self)
	self._btnteam:AddClickListener(self._btnteamOnClick, self)
	self._btnudimo:AddClickListener(self._btnudimoOnClick, self)
	self._btnTeaching:AddClickListener(self._btnTeachingOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterBook, self._btnhandbookOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterAchievement, self._btnachievementOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterFriend, self._btnsocialOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterTravelCollection, self._btnplayercardOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterNotice, self._btnbellOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterSetting, self._btnsettingOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterFeedback, self._btnfeedbackOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterSign, self._btncalendarOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterStore, self._btnzhoubianOnClick, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.OnCancelShowEnterAnimSettingNewReddot, self._isShowPlayerCardRedDot, self)
end

function MainThumbnailBtnView:removeEvents()
	self._btnhandbook:RemoveClickListener()
	self._btnsocial:RemoveClickListener()
	self._btnplayercard:RemoveClickListener()
	self._btnbell:RemoveClickListener()
	self._btncalendar:RemoveClickListener()
	self._btnsetting:RemoveClickListener()
	self._btnzhoubian:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnfeedback:RemoveClickListener()
	self._btnachievement:RemoveClickListener()
	self._btnrecordvideo:RemoveClickListener()
	self._btnteam:RemoveClickListener()
	self._btnudimo:RemoveClickListener()
	self._btnTeaching:RemoveClickListener()
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterBook, self._btnhandbookOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterAchievement, self._btnachievementOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterFriend, self._btnsocialOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterTravelCollection, self._btnplayercardOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterNotice, self._btnbellOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterSetting, self._btnsettingOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterFeedback, self._btnfeedbackOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterSign, self._btncalendarOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterStore, self._btnzhoubianOnClick, self)
	self.removeEventCb(self, PlayerCardController.instance, PlayerCardEvent.OnCancelShowEnterAnimSettingNewReddot, self._isShowPlayerCardRedDot, self)
end

function MainThumbnailBtnView:_btnhandbookOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Handbook) then
		HandbookController.instance:openView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Handbook))
	end
end

function MainThumbnailBtnView:_btnsocialOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		SocialController.instance:openSocialView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Friend))
	end
end

function MainThumbnailBtnView:_btnbellOnClick()
	if VersionValidator.instance:isInReviewing() then
		logWarn("in reviewing ...")

		return
	end

	UIBlockHelper.instance:startBlock("MainThumbnailBtnView:_btnbellOnClick", 0.5)

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Notice) then
		NoticeController.instance:openNoticeView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Notice))
	end
end

function MainThumbnailBtnView:_btncalendarOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		local data = {}

		data.isBirthday = false

		SignInController.instance:openSignInDetailView(data)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.SignIn))
	end
end

function MainThumbnailBtnView:_btnsettingOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Setting) then
		SettingsController.instance:openView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Setting))
	end
end

function MainThumbnailBtnView:_btnzhoubianOnClick()
	local url = CommonConfig.instance:getConstStr(ConstEnum.MallWebUrl)
	local deepLinkUrl = CommonConfig.instance:getConstStr(ConstEnum.MallDeepLink)

	StatController.instance:track(StatEnum.EventName.Click_Collectibles_Button, {})

	if GameUtil.openDeepLink(url, deepLinkUrl) then
		return
	end

	GameUtil.openURL(url)
end

function MainThumbnailBtnView:_btnfeedbackOnClick()
	if GameFacade.isExternalTest() then
		return
	end

	if SDKNativeUtil.openCostumerService() then
		return
	end

	ViewMgr.instance:openView(ViewName.FeedBackView)
end

function MainThumbnailBtnView:_btnachievementOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementEntryView)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_open)
end

function MainThumbnailBtnView:_btnrecordvideoOnClick()
	if SettingsShowHelper.canShowRecordVideo() then
		SDKMgr.instance:openVideosPage()
	end
end

function MainThumbnailBtnView:_btnteamOnClick()
	HeroGroupPresetController.instance:openHeroGroupPresetTeamView()
end

function MainThumbnailBtnView:_btnudimoOnClick()
	UdimoController.instance:enterUdimo()
end

function MainThumbnailBtnView:_btnTeachingOnClick()
	TeachingController.instance:openTeachingMainView()
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = "MainThumbnailBtnView",
		[StatEnum.EventProperties.ButtonName] = "Teaching"
	})
end

function MainThumbnailBtnView:_btnplayercardOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.PlayerCard) then
		local playerInfo = PlayerModel.instance:getPlayinfo()

		PlayerCardController.instance:openPlayerCardView({
			userId = playerInfo.userId
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.PlayerCard))
	end
end

function MainThumbnailBtnView:_btnleftOnClick()
	self:setTargetPageIndex(self:getTargetPageIndex() - 1)
	self:_updatePage()
end

function MainThumbnailBtnView:_btnrightOnClick()
	self:setTargetPageIndex(self:getTargetPageIndex() + 1)
	self:_updatePage()
end

function MainThumbnailBtnView:setTargetPageIndex(index)
	self._targetPageIndex = index
end

function MainThumbnailBtnView:getTargetPageIndex()
	return self._targetPageIndex
end

function MainThumbnailBtnView:_updatePage()
	self:_updatePageBtns()

	local x = (1 - self:getTargetPageIndex()) * self._space

	ZProj.TweenHelper.DOAnchorPosX(self._gocontent.transform, x, 0.25)
end

function MainThumbnailBtnView:_updatePageBtns()
	gohelper.setActive(self._btnleft.gameObject, self:getTargetPageIndex() > 1)
	gohelper.setActive(self._btnright.gameObject, self:getTargetPageIndex() < self._pageNum and self._pageNum > 1)
end

function MainThumbnailBtnView:onOpen()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._checkOpen, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnFuncUnlockRefresh, self._checkOpen, self)
	self.addEventCb(self, NoticeController.instance, NoticeEvent.OnRefreshRedDot, self._onRefreshNoticeRedDot, self)
	self.addEventCb(self, NoticeController.instance, NoticeEvent.OnGetNoticeInfo, self._onRefreshNoticeRedDot, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuide, self._onRefreshNoticeRedDot, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.SwitchTheme, self._isShowPlayerCardRedDot, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.EnterHandbookSkin, self._onRefreshHandbookRedDot, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.MarkHandbookSkinSuitRedDot, self._onRefreshHandbookRedDot, self)
	self.addEventCb(self, TeachNoteController.instance, TeachNoteEvent.GetServerTopicInfo, self._onRefreshTeachingRedDot, self)
	self.addEventCb(self, TeachingController.instance, TeachingEvent.OnTeachingBonusUpdate, self._onRefreshTeachingRedDot, self)
	self.addEventCb(self, TeachingController.instance, TeachingEvent.OnSelectTeachingId, self._onRefreshTeachingRedDot, self)
end

function MainThumbnailBtnView:_checkOpen()
	self:_checkZhouBianOpen()
end

function MainThumbnailBtnView:_checkZhouBianOpen()
	if self._isGamePad then
		return
	end

	local go = self._btnzhoubian.gameObject

	if go.activeSelf then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ZhouBian) then
		return
	end

	if not ActivityModel.instance:isActOnLine(10004) then
		return
	end

	self._btnNum = self._btnNum + 1
	self._pageNum = math.ceil(self._btnNum / 8)

	gohelper.addChild(self._gobtncontent2, go)
	gohelper.setActive(go, true)
	self:_initDrag(go)
	self:_updatePageBtns()
end

function MainThumbnailBtnView:_editableInitView()
	self._scrollList = self:getUserDataTb_()
	self._btnGoList = self:getUserDataTb_()

	table.insert(self._btnGoList, self._btnhandbook.gameObject)
	table.insert(self._btnGoList, self._btnachievement.gameObject)
	table.insert(self._btnGoList, self._btnsocial.gameObject)
	table.insert(self._btnGoList, self._btnplayercard.gameObject)
	table.insert(self._btnGoList, self._btnbell.gameObject)
	table.insert(self._btnGoList, self._btncalendar.gameObject)
	table.insert(self._btnGoList, self._btnsetting.gameObject)
	table.insert(self._btnGoList, self._btnudimo.gameObject)
	table.insert(self._btnGoList, self._btnTeaching.gameObject)

	if not VersionValidator.instance:isInReviewing() then
		table.insert(self._btnGoList, self._btnteam.gameObject)
	end

	table.insert(self._btnGoList, self._btnfeedback.gameObject)
	table.insert(self._btnGoList, self._btnrecordvideo.gameObject)
	table.insert(self._btnGoList, self._btnzhoubian.gameObject)

	self._isGamePad = SDKNativeUtil.isGamePad()

	self:_refreshBtns()
	self:_refreshRedDot()
	self:initBtnAudio()
	self:_initDrag(self._goscroll)
	gohelper.addUIClickAudio(self._btnzhoubian.gameObject, AudioEnum.UI.play_ui_admission_open)
end

function MainThumbnailBtnView:_initDrag(go)
	local scroll = SLFramework.UGUI.UIDragListener.Get(go)

	scroll:AddDragBeginListener(self._onScrollDragBegin, self)
	scroll:AddDragEndListener(self._onScrollDragEnd, self)

	self._scrollList[go] = scroll
end

function MainThumbnailBtnView:_onScrollDragBegin(param, eventData)
	self._scrollStartPos = eventData.position
end

function MainThumbnailBtnView:_onScrollDragEnd(param, eventData)
	if not self._scrollStartPos then
		return
	end

	local scrollEndPos = eventData.position
	local deltaX = scrollEndPos.x - self._scrollStartPos.x
	local deltaY = scrollEndPos.y - self._scrollStartPos.y

	self._scrollStartPos = nil

	if math.abs(deltaX) < math.abs(deltaY) then
		return
	end

	local targetPageIndex = self:getTargetPageIndex()
	local showRight = targetPageIndex < self._pageNum
	local showLeft = targetPageIndex > 1

	if deltaX > 100 and showLeft then
		self:setTargetPageIndex(targetPageIndex - 1)
		self:_updatePage()
	elseif deltaX < -100 and showRight then
		self:setTargetPageIndex(targetPageIndex + 1)
		self:_updatePage()
	end
end

function MainThumbnailBtnView:initBtnAudio()
	local audioEnum = AudioEnum.UI

	gohelper.addUIClickAudio(self._btnhandbook.gameObject, audioEnum.play_ui_screenplay_open)
	gohelper.addUIClickAudio(self._btncalendar.gameObject, audioEnum.Play_UI_Tipsopen)
	gohelper.addUIClickAudio(self._btnbell.gameObject, audioEnum.play_ui_notice_open)
	gohelper.addUIClickAudio(self._btnfeedback.gameObject, audioEnum.play_ui_feedback_open)
end

function MainThumbnailBtnView:_refreshRedDot()
	RedDotController.instance:addRedDot(self._gosocialreddot, RedDotEnum.DotNode.FriendBtn)
	RedDotController.instance:addRedDot(self._gocalendarreddot, RedDotEnum.DotNode.SignInBtn, nil, self._checkSignInRed, self)
	RedDotController.instance:addRedDot(self._goachievementreddot, RedDotEnum.DotNode.AchievementEntry)

	self.noticeRedDot = RedDotController.instance:addNotEventRedDot(self._gobelllreddot, NoticeModel.hasNotRedNotice, NoticeModel.instance)
	self.handbookskinRedDot = RedDotController.instance:addNotEventRedDot(self._goreddotHandbook, HandbookController.hasAnyHandBookSkinGroupRedDot, HandbookController.instance)
	self.teachingRedDot = RedDotController.instance:addRedDot(self._goRedDotTeaching, RedDotEnum.DotNode.V3a7Teaching, nil, self._checkTeachingRed, self)
end

function MainThumbnailBtnView:_checkSignInRed(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = LifeCircleController.instance:isShowRed()

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function MainThumbnailBtnView:_onRefreshNoticeRedDot()
	self.noticeRedDot:refreshRedDot()
end

function MainThumbnailBtnView:_onRefreshHandbookRedDot()
	self.handbookskinRedDot:refreshRedDot()
end

function MainThumbnailBtnView:_onRefreshTeachingRedDot()
	if self.teachingRedDot then
		self.teachingRedDot:refreshDot()
	end
end

function MainThumbnailBtnView:_isShowPlayerCardRedDot()
	if PlayerCardModel.instance:isShowEnterAnimSettingNewReddot() then
		gohelper.setActive(self._goreddotplayercard, true)

		if self._playercardreddot then
			self._playercardreddot:setShowType(RedDotEnum.Style.NewTag)
		end

		return true
	end

	local isShow = PlayerCardModel.instance:getShowRed()

	if isShow and self._playercardreddot then
		self._playercardreddot:setShowType(RedDotEnum.Style.Normal)
	end

	gohelper.setActive(self._goreddotplayercard, isShow)

	return isShow
end

function MainThumbnailBtnView:_checkTeachingRed(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = TeachingModel.instance:haveCanReceiveRewardTeaching() or TeachNoteModel.instance:hasRewardCouldGet()

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end

	if not redDotIcon.show then
		redDotIcon.show = TeachingModel.instance:haveNewTeaching() or tabletool.len(TeachNoteModel.instance:getNewOpenTopics()) > 0

		redDotIcon:showRedDot(RedDotEnum.Style.Green)
	end
end

local kPageMaxNum = 8

function MainThumbnailBtnView:_refreshBtns()
	for i, go in ipairs(self._btnGoList) do
		gohelper.setActive(go, true)
	end

	local notReview = not VersionValidator.instance:isInReviewing()
	local notExternalTest = not GameFacade.isExternalTest()
	local sdkShowNotice = not SDKMgr.getShowNotice or SDKMgr.instance:getShowNotice()
	local isOpenNotice = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Notice)

	gohelper.setActive(self._btnbell.gameObject, notReview and notExternalTest and sdkShowNotice and isOpenNotice)
	gohelper.setActive(self._btnsetting.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Setting))
	gohelper.setActive(self._btncalendar.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SignIn))
	gohelper.setActive(self._btnsocial.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Friend) and self._isGamePad == false)
	gohelper.setActive(self._btnhandbook.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Handbook))
	gohelper.setActive(self._btnplayercard.gameObject, notReview and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.PlayerCard))
	gohelper.setActive(self._btnachievement.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Achievement))
	gohelper.setActive(self._btnfeedback.gameObject, self._isGamePad == false and notExternalTest)
	gohelper.setActive(self._btnrecordvideo, SettingsShowHelper.canShowRecordVideo())
	gohelper.setActive(self._btnzhoubian.gameObject, not self._isGamePad and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ZhouBian) and ActivityModel.instance:isActOnLine(10004))
	gohelper.setActive(self._btnudimo.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Udimo))
	gohelper.setActive(self._btnTeaching.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Teaching))

	local addNum = 0

	for i, go in ipairs(self._btnGoList) do
		if go.activeSelf then
			addNum = addNum + 1

			if addNum <= kPageMaxNum then
				gohelper.addChild(self._gobtncontent1, go)
			else
				gohelper.addChild(self._gobtncontent2, go)
			end

			self:_initDrag(go)
		end
	end

	self._btnNum = addNum
	self._pageNum = math.ceil(self._btnNum / kPageMaxNum)
	self._space = recthelper.getWidth(self._gobtncontent1.transform)

	self:setTargetPageIndex(1)
	self:_updatePageBtns()
	self:_checkZhouBianOpen()
end

function MainThumbnailBtnView:onDestroyView()
	for k, v in pairs(self._scrollList) do
		v:RemoveDragBeginListener()
		v:RemoveDragEndListener()
	end
end

return MainThumbnailBtnView
