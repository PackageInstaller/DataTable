-- chunkname: @modules/logic/versionactivity2_0/enter/view/VersionActivity2_0EnterView.lua

module("modules.logic.versionactivity2_0.enter.view.VersionActivity2_0EnterView", package.seeall)

local VersionActivity2_0EnterView = class("VersionActivity2_0EnterView", VersionActivityEnterBaseViewWithListNew)
local VIDEO_DURATION = 2.1

function VersionActivity2_0EnterView:_editableInitView()
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#go_tabcontainer/#scroll_tab")
	self.goArrowRedDot = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local rectTrViewPort = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(rectTrViewPort)
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	self._gotabitem1 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	self._gotabitem2 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	self._goline = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivity2_0EnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity2_0EnterViewTabItem2)
	self:setActivityLineGo(self._goline)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject
	self.entranceAnim = gohelper.findChildComponent(self.viewGO, "entrance", gohelper.Type_Animator)
	self.tabAnim = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer", gohelper.Type_Animator)
	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function VersionActivity2_0EnterView:childAddEvents()
	self._btnreplay:AddClickListener(self._btnreplayOnClick, self)
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._scrolltab:AddOnValueChanged(self._onTabScrollChange, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self, LuaEventSystem.Low)
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.selectAct, self, LuaEventSystem.Low)
end

function VersionActivity2_0EnterView:childRemoveEvents()
	self._btnreplay:RemoveClickListener()
	self._btnachievementpreview:RemoveClickListener()
	self._scrolltab:RemoveOnValueChanged()
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self)
	self.removeEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.selectAct, self, LuaEventSystem.Low)
end

function VersionActivity2_0EnterView:_btnreplayOnClick()
	local activityMo = ActivityModel.instance:getActMO(self.curActId)

	if activityMo then
		::label_4_0::

		local var_4_0 = activityMo.config

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

function VersionActivity2_0EnterView:_btnachievementpreviewOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self.curActId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function VersionActivity2_0EnterView:_onTabScrollChange()
	local contentAnchorY = recthelper.getAnchorY(self.rectTrContent)

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem:isShowRedDot() then
			local anchorY = -tabItem:getAnchorY() + VersionActivity2_0Enum.RedDotOffsetY

			if anchorY - contentAnchorY > self.viewPortHeight then
				gohelper.setActive(self.goArrowRedDot, true)

				return
			end
		end
	end

	gohelper.setActive(self.goArrowRedDot, false)
end

function VersionActivity2_0EnterView:playVideo()
	self.tabAnim:Play(UIAnimationName.Open, 0, 0)
	self.entranceAnim:Play(UIAnimationName.Open, 0, 0)
	self.viewAnim:Play("open1", 0, 0)

	if self.viewParam.playVideo then
		self.tabAnim.speed = 0
		self.entranceAnim.speed = 0
		self.gosubviewCanvasGroup.alpha = 0

		VideoController.instance:openFullScreenVideoView(VersionActivity2_0Enum.EnterAnimVideoPath, nil, VIDEO_DURATION)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	else
		self.tabAnim.speed = 1
		self.entranceAnim.speed = 1
		self.gosubviewCanvasGroup.alpha = 1

		self:onPlayVideoDone()
	end
end

function VersionActivity2_0EnterView:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	self.tabAnim.speed = 1

	self.tabAnim:Play(UIAnimationName.Open, 0, 0)

	self.entranceAnim.speed = 1

	self.entranceAnim:Play(UIAnimationName.Open, 0, 0)

	self.gosubviewCanvasGroup.alpha = 1
end

function VersionActivity2_0EnterView:refreshRedDot()
	self:_onTabScrollChange()
end

function VersionActivity2_0EnterView:refreshBtnVisible(isOnOpen)
	local showReplay = VersionActivity2_0EnterHelper.GetIsShowReplayBtn(self.curActId)
	local showAchieve = VersionActivity2_0EnterHelper.GetIsShowAchievementBtn(self.curActId)

	gohelper.setActive(self.goReplayBtn, showReplay)
	gohelper.setActive(self.goAchievementBtn, showAchieve)

	if isOnOpen then
		return
	end

	if showReplay or showAchieve then
		self.entranceAnim.speed = 1

		self.entranceAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function VersionActivity2_0EnterView:selectAct()
	self.viewAnim:Play(UIAnimationName.Open, 0, 0)
	self.viewContainer:markPlayedSubViewAnim()
end

return VersionActivity2_0EnterView
