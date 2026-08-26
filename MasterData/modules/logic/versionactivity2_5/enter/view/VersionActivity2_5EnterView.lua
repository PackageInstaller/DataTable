-- chunkname: @modules/logic/versionactivity2_5/enter/view/VersionActivity2_5EnterView.lua

module("modules.logic.versionactivity2_5.enter.view.VersionActivity2_5EnterView", package.seeall)

local VersionActivity2_5EnterView = class("VersionActivity2_5EnterView", VersionActivityEnterBaseViewWithListNew)

function VersionActivity2_5EnterView:_editableInitView()
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#go_tabcontainer/#scroll_tab")
	self.goArrowRedDot = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local rectTrViewPort = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(rectTrViewPort)
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	self._gotabitem1 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	self._gotabitem2 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	self._goline = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivity2_5EnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity2_5EnterViewTabItem2)
	self:setActivityLineGo(self._goline)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementnormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject

	gohelper.setActive(self._btnachievementnormal.gameObject, false)

	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
end

function VersionActivity2_5EnterView:childAddEvents()
	self._btnreplay:AddClickListener(self._btnreplayOnClick, self)
	self._btnachievementnormal:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._scrolltab:AddOnValueChanged(self._onTabScrollChange, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self, LuaEventSystem.Low)
end

function VersionActivity2_5EnterView:childRemoveEvents()
	self._btnreplay:RemoveClickListener()
	self._btnachievementnormal:RemoveClickListener()
	self._btnachievementpreview:RemoveClickListener()
	self._scrolltab:RemoveOnValueChanged()
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self)
end

function VersionActivity2_5EnterView:_btnreplayOnClick()
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

function VersionActivity2_5EnterView:_btnachievementpreviewOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self.curActId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function VersionActivity2_5EnterView:_onTabScrollChange()
	local contentAnchorY = recthelper.getAnchorY(self.rectTrContent)

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem:isShowRedDot() then
			local anchorY = -tabItem:getAnchorY() + VersionActivity2_5Enum.RedDotOffsetY

			if anchorY - contentAnchorY > self.viewPortHeight then
				gohelper.setActive(self.goArrowRedDot, true)

				return
			end
		end
	end

	gohelper.setActive(self.goArrowRedDot, false)
end

function VersionActivity2_5EnterView:refreshRedDot()
	self:_onTabScrollChange()
end

function VersionActivity2_5EnterView:refreshBtnVisible(isOnOpen)
	local showReplay = VersionActivity2_5EnterHelper.GetIsShowReplayBtn(self.curActId)
	local showAchieve = VersionActivity2_5EnterHelper.GetIsShowAchievementBtn(self.curActId)

	gohelper.setActive(self.goReplayBtn, showReplay)
	gohelper.setActive(self.goAchievementBtn, showAchieve)
end

function VersionActivity2_5EnterView:onOpen()
	VersionActivity2_5EnterView.super.onOpen(self)

	if self.curActId == VersionActivity2_5Enum.ActivityId.Dungeon then
		self.viewAnim:Play("open1", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_5Enter.play_ui_tangren_open1)
		self:openBgmLeadSinger()
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

function VersionActivity2_5EnterView:_onOpenView(viewName)
	if self.curActId == VersionActivity2_5Enum.ActivityId.Dungeon and viewName == ViewName.VersionActivity2_5DungeonMapView then
		self:closeBgmLeadSinger()
	end
end

function VersionActivity2_5EnterView:_onCloseView(viewName)
	if self.curActId == VersionActivity2_5Enum.ActivityId.Dungeon and ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self:openBgmLeadSinger()
	end
end

function VersionActivity2_5EnterView:_setAudioSwitchId()
	self.switchGroupId = self.switchGroupId or AudioMgr.instance:getIdFromString("music_vocal_filter")
	self.originalStateId = self.originalStateId or AudioMgr.instance:getIdFromString("original")
	self.accompanimentStateId = self.accompanimentStateId or AudioMgr.instance:getIdFromString("accompaniment")
end

function VersionActivity2_5EnterView:openBgmLeadSinger()
	self:_setAudioSwitchId()
	AudioMgr.instance:setSwitch(self.switchGroupId, self.originalStateId)
end

function VersionActivity2_5EnterView:closeBgmLeadSinger()
	self:_setAudioSwitchId()
	AudioMgr.instance:setSwitch(self.switchGroupId, self.accompanimentStateId)
end

function VersionActivity2_5EnterView:onClickActivity12502(tabItem)
	local actId = VersionActivity2_5Enum.ActivityId.Dungeon

	self._generalOnClick(self, actId, tabItem, self.openBgmLeadSinger, self)
end

function VersionActivity2_5EnterView:onClickActivity12512(tabItem)
	local actId = VersionActivity2_5Enum.ActivityId.LiangYue

	self._generalOnClick(self, actId, tabItem, self.closeBgmLeadSinger, self)
end

function VersionActivity2_5EnterView:_generalOnClick(actId, tabItem, clickCB, clickObj)
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(actId)

	if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
		if clickCB then
			clickCB(clickObj)
		end

		tabItem.animator:Play("click", 0, 0)
		VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, actId, self)
	end

	if toastId then
		GameFacade.showToastWithTableParam(toastId, paramList)
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
end

return VersionActivity2_5EnterView
