-- chunkname: @modules/logic/versionactivity2_4/enter/view/VersionActivity2_4EnterView.lua

module("modules.logic.versionactivity2_4.enter.view.VersionActivity2_4EnterView", package.seeall)

local VersionActivity2_4EnterView = class("VersionActivity2_4EnterView", VersionActivityEnterBaseViewWithListNew)

function VersionActivity2_4EnterView:_editableInitView()
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#go_tabcontainer/#scroll_tab")
	self.goArrowRedDot = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local rectTrViewPort = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(rectTrViewPort)
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	self._gotabitem1 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	self._gotabitem2 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	self._goline = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivity2_4EnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity2_4EnterViewTabItem2)
	self:setActivityLineGo(self._goline)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementnormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject
	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
end

function VersionActivity2_4EnterView:childAddEvents()
	self._btnreplay:AddClickListener(self._btnreplayOnClick, self)
	self._btnachievementnormal:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._scrolltab:AddOnValueChanged(self._onTabScrollChange, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self, LuaEventSystem.Low)
end

function VersionActivity2_4EnterView:childRemoveEvents()
	self._btnreplay:RemoveClickListener()
	self._btnachievementnormal:RemoveClickListener()
	self._btnachievementpreview:RemoveClickListener()
	self._scrolltab:RemoveOnValueChanged()
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self)
end

function VersionActivity2_4EnterView:_btnreplayOnClick()
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

function VersionActivity2_4EnterView:_btnachievementpreviewOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self.curActId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function VersionActivity2_4EnterView:_onTabScrollChange()
	local contentAnchorY = recthelper.getAnchorY(self.rectTrContent)

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem:isShowRedDot() then
			local anchorY = -tabItem:getAnchorY() + VersionActivity2_4Enum.RedDotOffsetY

			if anchorY - contentAnchorY > self.viewPortHeight then
				gohelper.setActive(self.goArrowRedDot, true)

				return
			end
		end
	end

	gohelper.setActive(self.goArrowRedDot, false)
end

function VersionActivity2_4EnterView:refreshRedDot()
	self:_onTabScrollChange()
end

function VersionActivity2_4EnterView:refreshBtnVisible(isOnOpen)
	local showReplay = VersionActivity2_4EnterHelper.GetIsShowReplayBtn(self.curActId)
	local showAchieve = VersionActivity2_4EnterHelper.GetIsShowAchievementBtn(self.curActId)

	gohelper.setActive(self.goReplayBtn, showReplay)
	gohelper.setActive(self.goAchievementBtn, showAchieve)
	gohelper.setActive(self._btnachievementnormal, showAchieve)

	if isOnOpen then
		return
	end
end

function VersionActivity2_4EnterView:onOpen()
	VersionActivity2_4EnterView.super.onOpen(self)

	if self.curActId == VersionActivity2_4Enum.ActivityId.Dungeon then
		self.viewAnim:Play("open1", 0, 0)
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

return VersionActivity2_4EnterView
