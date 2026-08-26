-- chunkname: @modules/logic/versionactivity1_7/enter/view/VersionActivity1_7EnterView.lua

module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterView", package.seeall)

local VersionActivity1_7EnterView = class("VersionActivity1_7EnterView", VersionActivityEnterBaseViewWithList1_7)

function VersionActivity1_7EnterView:onInitView()
	VersionActivity1_7EnterView.super.onInitView(self)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self._btnAchievementNormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._tabScrollRect = gohelper.findChildScrollRect(self.viewGO, "#go_tabcontainer/#scroll_tab")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_7EnterView:addEvents()
	VersionActivity1_7EnterView.super.addEvents(self)
	self._btnreplay:AddClickListener(self._btnReplayOnClick, self)
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._btnAchievementNormal:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._tabScrollRect:AddOnValueChanged(self._onScrollChange, self)
end

function VersionActivity1_7EnterView:removeEvents()
	VersionActivity1_7EnterView.super.removeEvents(self)
	self._btnreplay:RemoveClickListener()
	self._btnachievementpreview:RemoveClickListener()
	self._btnAchievementNormal:RemoveClickListener()
	self._tabScrollRect:RemoveOnValueChanged()
end

function VersionActivity1_7EnterView:_btnachievementpreviewOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self.curActId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function VersionActivity1_7EnterView:_btnReplayOnClick()
	local activityMo = ActivityModel.instance:getActMO(self.curActId)

	if activityMo then
		::label_5_0::

		local var_5_0 = activityMo.config

		if activityMo.config then
			local storyId = activityMo.config.storyId

			if not storyId then
				logError(string.format("act id %s dot config story id", storyId))

				return
			end

			local param = {}

			param.isVersionActivityPV = true

			StoryController.instance:playStory(storyId, param)
		end
	end
end

function VersionActivity1_7EnterView:_onScrollChange()
	local contentAnchorY = recthelper.getAnchorY(self.rectTrContent)

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem:isShowRedDot() then
			local anchorY = -tabItem:getAnchorY() + VersionActivity1_7Enum.RedDotOffsetY

			if anchorY - contentAnchorY > self.viewPortHeight then
				gohelper.setActive(self.goArrowRedDot, true)

				return
			end
		end
	end

	gohelper.setActive(self.goArrowRedDot, false)
end

function VersionActivity1_7EnterView:_editableInitView()
	VersionActivity1_7EnterView.super._editableInitView(self)

	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject
	self.tabAnim = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer", gohelper.Type_Animator)
	self.entranceAnim = gohelper.findChildComponent(self.viewGO, "entrance", gohelper.Type_Animator)
	self.goArrowRedDot = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)

	local rectTrViewPort = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(rectTrViewPort)

	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self, LuaEventSystem.Low)
end

function VersionActivity1_7EnterView:refreshRedDot()
	self:_onScrollChange()
end

function VersionActivity1_7EnterView:onOpen()
	VersionActivity1_7EnterView.super.onOpen(self)
	self:refreshBtnVisible()
	self:_onScrollChange()
	self:playVideo()
end

function VersionActivity1_7EnterView:playVideo()
	if self.viewParam.skipOpenAnim then
		self.tabAnim:Play(UIAnimationName.Open, 0, 1)
		self.entranceAnim:Play(UIAnimationName.Open, 0, 1)
	elseif self.viewParam.playVideo then
		self.tabAnim:Play(UIAnimationName.Open, 0, 0)
		self.entranceAnim:Play(UIAnimationName.Open, 0, 0)

		self.tabAnim.speed = 0
		self.entranceAnim.speed = 0

		VideoController.instance:openFullScreenVideoView("videos/1_7_enter.mp4", nil, 2.1)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	else
		self.tabAnim:Play(UIAnimationName.Open, 0, 0)
		self.entranceAnim:Play(UIAnimationName.Open, 0, 0)

		self.tabAnim.speed = 1
		self.entranceAnim.speed = 1
	end
end

function VersionActivity1_7EnterView:onPlayVideoDone()
	self.tabAnim.speed = 1
	self.entranceAnim.speed = 1

	self.tabAnim:Play(UIAnimationName.Open, 0, 0)
	self.entranceAnim:Play(UIAnimationName.Open, 0, 0)
end

function VersionActivity1_7EnterView:onSelectActId(...)
	VersionActivity1_7EnterView.super.onSelectActId(self, ...)
	self:refreshBtnVisible()
end

function VersionActivity1_7EnterView:refreshBtnVisible()
	local showReplay = VersionActivity1_7Enum.ActId2ShowReplayBtnDict[self.curActId]
	local showAchieve = VersionActivity1_7Enum.ActId2ShowAchievementBtnDict[self.curActId]

	gohelper.setActive(self.goReplayBtn, showReplay)
	gohelper.setActive(self.goAchievementBtn, showAchieve)

	if showReplay or showAchieve then
		self.entranceAnim.speed = 1

		self.entranceAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function VersionActivity1_7EnterView:onClickActivity11704(tabItem)
	local checkActId = VersionActivity1_7Enum.ActivityId.BossRush
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(checkActId)

	if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
		V1a6_BossRush_StoreModel.instance:checkStoreNewGoods()
		tabItem.animator:Play("click", 0, 0)
		VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, checkActId, self)
	end

	if toastId then
		GameFacade.showToastWithTableParam(toastId, paramList)
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
end

return VersionActivity1_7EnterView
