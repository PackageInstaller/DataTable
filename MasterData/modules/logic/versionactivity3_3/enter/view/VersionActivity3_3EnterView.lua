-- chunkname: @modules/logic/versionactivity3_3/enter/view/VersionActivity3_3EnterView.lua

module("modules.logic.versionactivity3_3.enter.view.VersionActivity3_3EnterView", package.seeall)

local VersionActivity3_3EnterView = class("VersionActivity3_3EnterView", VersionActivityEnterBaseViewWithListNew)

function VersionActivity3_3EnterView:_editableInitView()
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#go_tabcontainer/#scroll_tab")
	self._scroll = self._scrolltab:GetComponent(gohelper.Type_ScrollRect)
	self.goArrowRedDot = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local rectTrViewPort = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(rectTrViewPort)
	self.viewPortWidth = recthelper.getWidth(rectTrViewPort)
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	self._gotabitem1 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	self._gotabitem2 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	self._goline = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivity3_3EnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity3_3EnterViewTabItem2)
	self:setActivityLineGo(self._goline)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementnormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject
	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
	self._goblackmask = gohelper.findChild(self.viewGO, "#blackmask")
end

function VersionActivity3_3EnterView:childAddEvents()
	self._btnreplay:AddClickListener(self._btnreplayOnClick, self)
	self._btnachievementnormal:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._scrolltab:AddOnValueChanged(self._onTabScrollChange, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnReadyEnterHallView, self._showblackmask, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnExitHallView, self._hideblackmask, self)
end

function VersionActivity3_3EnterView:childRemoveEvents()
	self._btnreplay:RemoveClickListener()
	self._btnachievementnormal:RemoveClickListener()
	self._btnachievementpreview:RemoveClickListener()
	self._scrolltab:RemoveOnValueChanged()
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnReadyEnterHallView, self._showblackmask, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnExitHallView, self._hideblackmask, self)
end

function VersionActivity3_3EnterView:_onCloseViewFinish(viewName)
	if viewName == ViewName.ArcadeHallView then
		self:_hideblackmask()
	end
end

function VersionActivity3_3EnterView:_hideblackmask()
	gohelper.setActive(self._goblackmask, false)
end

function VersionActivity3_3EnterView:_showblackmask()
	TaskDispatcher.cancelTask(self._hideblackmask, self)
	gohelper.setActive(self._goblackmask, true)
	TaskDispatcher.runDelay(self._hideblackmask, self, 2)
end

function VersionActivity3_3EnterView:moveContent(nextItem)
	local viewWidth = recthelper.getWidth(self._scrolltab.transform)
	local contentWidth = recthelper.getWidth(self.rectTrContent)
	local itemMovePosX = -(recthelper.getAnchorX(nextItem.go.transform) - recthelper.getWidth(nextItem.go.transform) / 2)
	local posX = math.min(0, math.max(viewWidth - contentWidth, itemMovePosX))

	recthelper.setAnchorX(self.rectTrContent, posX)
end

function VersionActivity3_3EnterView:_btnreplayOnClick()
	local activityMo = ActivityModel.instance:getActMO(self.curActId)

	if activityMo then
		::label_8_0::

		local var_8_0 = activityMo.config

		if activityMo.config then
			local storyId = activityMo.config.storyId

			if not storyId or storyId == 0 then
				logError(string.format("act id %s dot config story id", self.curActId))

				return
			end

			local param = {}

			param.isVersionActivityPV = true

			StoryController.instance:playStory(storyId, param)
		end
	end
end

function VersionActivity3_3EnterView:_btnachievementpreviewOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self.curActId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function VersionActivity3_3EnterView:_onTabScrollChange()
	if self._scroll.horizontal then
		self:_checkHorizontalScroll()
	else
		self:_checkVerticalScroll()
	end
end

function VersionActivity3_3EnterView:_checkHorizontalScroll()
	local contentAnchorX = recthelper.getAnchorX(self.rectTrContent)

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem:isShowRedDot() then
			local anchorX = -tabItem:getAnchorX() + tabItem:getWidth() / 2 - VersionActivity3_3Enum.RedDotOffsetX

			if anchorX - contentAnchorX < -self.viewPortWidth then
				gohelper.setActive(self.goArrowRedDot, true)

				return
			end
		end
	end

	gohelper.setActive(self.goArrowRedDot, false)
end

function VersionActivity3_3EnterView:_checkVerticalScroll()
	local contentAnchorY = recthelper.getAnchorY(self.rectTrContent)

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem:isShowRedDot() then
			local anchorY = -tabItem:getAnchorY() + VersionActivity3_3Enum.RedDotOffsetY

			if anchorY - contentAnchorY > self.viewPortHeight then
				gohelper.setActive(self.goArrowRedDot, true)

				return
			end
		end
	end

	gohelper.setActive(self.goArrowRedDot, false)
end

function VersionActivity3_3EnterView:refreshRedDot()
	self:_onTabScrollChange()
end

function VersionActivity3_3EnterView:refreshBtnVisible(isOnOpen)
	local showReplay = VersionActivity3_3EnterHelper.GetIsShowReplayBtn(self.curActId)
	local showAchieve = VersionActivity3_3EnterHelper.GetIsShowAchievementBtn(self.curActId)

	gohelper.setActive(self.goReplayBtn, showReplay)
	gohelper.setActive(self.goAchievementBtn, showAchieve)
end

function VersionActivity3_3EnterView:onOpen()
	VersionActivity3_3EnterView.super.onOpen(self)

	local jumpActId = self.viewParam.jumpActId

	if jumpActId and self.activityTabItemList then
		local tabIndex = self:_getActTabIndex(jumpActId)

		tabIndex = tabIndex or VersionActivityEnterHelper.getTabIndex(self.activitySettingList, jumpActId)

		local offset = 3

		if not #self.activityTabItemList then
			self._scrolltab.horizontalNormalizedPosition = tabIndex <= offset and 0 or tabIndex >= #self.activityTabItemList - offset and 1 or GameUtil.clamp(tabIndex / #self.activityTabItemList, 0, 1)
		end
	end

	gohelper.setActive(self._goblackmask, false)
end

function VersionActivity3_3EnterView:_getActTabIndex(jumpActId)
	for i, tabItem in ipairs(self.activityTabItemList) do
		if tabItem.actId == jumpActId then
			return gohelper.getSibling(tabItem.go)
		end
	end

	return 0
end

function VersionActivity3_3EnterView:_playOpenAnim(animNim)
	if not string.nilorempty(animNim) then
		self.viewAnim:Play(animNim, 0, 0)
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

local VIDEO_DURATION = 8

function VersionActivity3_3EnterView:playVideo()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if self.viewParam and self.viewParam.playVideo then
		self:_playOpenAnim("open1")

		self.viewAnim.speed = 0
		self.cgviewgo = self.viewGO:GetComponent(gohelper.Type_CanvasGroup)

		if self.cgviewgo then
			self.cgviewgo.interactable = false
		end

		self.gosubviewCanvasGroup.alpha = 0

		VideoController.instance:openFullScreenVideoView(langVideoUrl(VersionActivity3_3Enum.EnterAnimVideoName), nil, VIDEO_DURATION)
		TimeUtil.setDayFirstLoginRed(VersionActivity3_3Enum.EnterVideoDayKey)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
	else
		self.viewAnim.speed = 1

		self:_playOpenAnim()
	end
end

function VersionActivity3_3EnterView:onPlayVideoDone()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)

	self.gosubviewCanvasGroup.alpha = 1

	if self.cgviewgo then
		self.cgviewgo.interactable = true
	end

	if self.viewAnim.speed == 1 then
		return
	end

	self.viewAnim.speed = 1

	self:_playOpenAnim("open1")
end

function VersionActivity3_3EnterView:_delayPlayOpen1Anim()
	if self.viewAnim.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, VersionActivity3_3Enum.Open1AnimDelayPlayTime)
end

function VersionActivity3_3EnterView:_playOpen1Anim()
	self:onPlayVideoDone()
end

function VersionActivity3_3EnterView:onDestroyView()
	VersionActivity3_3EnterView.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
	TaskDispatcher.cancelTask(self._hideblackmask, self)
end

return VersionActivity3_3EnterView
