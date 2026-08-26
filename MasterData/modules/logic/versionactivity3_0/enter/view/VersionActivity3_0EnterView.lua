-- chunkname: @modules/logic/versionactivity3_0/enter/view/VersionActivity3_0EnterView.lua

module("modules.logic.versionactivity3_0.enter.view.VersionActivity3_0EnterView", package.seeall)

local VersionActivity3_0EnterView = class("VersionActivity3_0EnterView", VersionActivityEnterBaseViewWithListNew)

function VersionActivity3_0EnterView:_editableInitView()
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

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivity3_0EnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity3_0EnterViewTabItem2)
	self:setActivityLineGo(self._goline)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementnormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject
	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
end

function VersionActivity3_0EnterView:childAddEvents()
	self._btnreplay:AddClickListener(self._btnreplayOnClick, self)
	self._btnachievementnormal:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._scrolltab:AddOnValueChanged(self._onTabScrollChange, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self, LuaEventSystem.Low)
end

function VersionActivity3_0EnterView:childRemoveEvents()
	self._btnreplay:RemoveClickListener()
	self._btnachievementnormal:RemoveClickListener()
	self._btnachievementpreview:RemoveClickListener()
	self._scrolltab:RemoveOnValueChanged()
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self)
end

function VersionActivity3_0EnterView:moveContent(nextItem)
	local viewWidth = recthelper.getWidth(self._scrolltab.transform)
	local contentWidth = recthelper.getWidth(self.rectTrContent)
	local itemMovePosX = -(recthelper.getAnchorX(nextItem.go.transform) - recthelper.getWidth(nextItem.go.transform) / 2)
	local posX = math.min(0, math.max(viewWidth - contentWidth, itemMovePosX))

	recthelper.setAnchorX(self.rectTrContent, posX)
end

function VersionActivity3_0EnterView:_btnreplayOnClick()
	local activityMo = ActivityModel.instance:getActMO(self.curActId)

	if activityMo then
		::label_5_0::

		local var_5_0 = activityMo.config

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

function VersionActivity3_0EnterView:_btnachievementpreviewOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self.curActId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function VersionActivity3_0EnterView:_onTabScrollChange()
	if self._scroll.horizontal then
		self:_checkHorizontalScroll()
	else
		self:_checkVerticalScroll()
	end
end

function VersionActivity3_0EnterView:_checkHorizontalScroll()
	local contentAnchorX = recthelper.getAnchorX(self.rectTrContent)

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem:isShowRedDot() then
			local anchorX = -tabItem:getAnchorX() + tabItem:getWidth() / 2 - VersionActivity3_0Enum.RedDotOffsetX

			if anchorX - contentAnchorX < -self.viewPortWidth then
				gohelper.setActive(self.goArrowRedDot, true)

				return
			end
		end
	end

	gohelper.setActive(self.goArrowRedDot, false)
end

function VersionActivity3_0EnterView:_checkVerticalScroll()
	local contentAnchorY = recthelper.getAnchorY(self.rectTrContent)

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem:isShowRedDot() then
			local anchorY = -tabItem:getAnchorY() + VersionActivity3_0Enum.RedDotOffsetY

			if anchorY - contentAnchorY > self.viewPortHeight then
				gohelper.setActive(self.goArrowRedDot, true)

				return
			end
		end
	end

	gohelper.setActive(self.goArrowRedDot, false)
end

function VersionActivity3_0EnterView:refreshRedDot()
	self:_onTabScrollChange()
end

function VersionActivity3_0EnterView:refreshBtnVisible(isOnOpen)
	local showReplay = VersionActivity3_0EnterHelper.GetIsShowReplayBtn(self.curActId)
	local showAchieve = VersionActivity3_0EnterHelper.GetIsShowAchievementBtn(self.curActId)

	gohelper.setActive(self.goReplayBtn, showReplay)
	gohelper.setActive(self.goAchievementBtn, showAchieve)
end

function VersionActivity3_0EnterView:onOpen()
	VersionActivity3_0EnterView.super.onOpen(self)

	local jumpActId = self.viewParam.jumpActId

	if jumpActId and self.activityTabItemList then
		local tabIndex = self:_getActTabIndex(jumpActId)

		tabIndex = tabIndex or VersionActivityEnterHelper.getTabIndex(self.activitySettingList, jumpActId)

		local offset = 3

		if not #self.activityTabItemList then
			self._scrolltab.horizontalNormalizedPosition = tabIndex <= offset and 0 or tabIndex >= #self.activityTabItemList - offset and 1 or GameUtil.clamp(tabIndex / #self.activityTabItemList, 0, 1)
		end
	end
end

function VersionActivity3_0EnterView:_getActTabIndex(jumpActId)
	for i, tabItem in ipairs(self.activityTabItemList) do
		if tabItem.actId == jumpActId then
			return gohelper.getSibling(tabItem.go)
		end
	end

	return 0
end

function VersionActivity3_0EnterView:_playOpenAnim(animNim)
	if not string.nilorempty(animNim) then
		self.viewAnim:Play(animNim, 0, 0)
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

local VIDEO_DURATION = 5

function VersionActivity3_0EnterView:playVideo()
	if self.viewParam and self.viewParam.playVideo then
		AudioMgr.instance:trigger(AudioEnum3_0.VersionActivity3_0Enter.play_ui_lushang_open_1)

		self.viewAnim.speed = 0

		VideoController.instance:openFullScreenVideoView(langVideoUrl(VersionActivity3_0Enum.EnterAnimVideoName), nil, VIDEO_DURATION)
		TimeUtil.setDayFirstLoginRed(VersionActivity3_0Enum.EnterVideoDayKey)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	else
		self.viewAnim.speed = 1

		self:_playOpenAnim()
	end
end

function VersionActivity3_0EnterView:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	self.viewAnim.speed = 1

	self:_playOpenAnim("open1")
end

return VersionActivity3_0EnterView
