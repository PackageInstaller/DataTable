-- chunkname: @modules/versionactivitybase/fixed/enterview/view/VersionActivityFixedEnterView.lua

module("modules.versionactivitybase.fixed.enterview.view.VersionActivityFixedEnterView", package.seeall)

local VersionActivityFixedEnterView = class("VersionActivityFixedEnterView", VersionActivityEnterBaseViewWithListNew)

function VersionActivityFixedEnterView:_editableInitView()
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#go_tabcontainer/#scroll_tab")
	self.goArrowRedDot = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local rectTrViewPort = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(rectTrViewPort)
	self.viewPortWidth = recthelper.getWidth(rectTrViewPort)
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	self._gotabitem1 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	self._gotabitem2 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	self._goline = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	local tabComp1 = VersionActivityFixedHelper.getVersionActivityEnterViewTabItem1()
	local tabComp2 = VersionActivityFixedHelper.getVersionActivityEnterViewTabItem2()

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, tabComp1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, tabComp2)
	self:setActivityLineGo(self._goline)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementnormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject
	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
end

function VersionActivityFixedEnterView:childAddEvents()
	self._btnreplay:AddClickListener(self._btnreplayOnClick, self)
	self._btnachievementnormal:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._scrolltab:AddOnValueChanged(self._onTabScrollChange, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self, LuaEventSystem.Low)
end

function VersionActivityFixedEnterView:childRemoveEvents()
	self._btnreplay:RemoveClickListener()
	self._btnachievementnormal:RemoveClickListener()
	self._btnachievementpreview:RemoveClickListener()
	self._scrolltab:RemoveOnValueChanged()
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self)
end

function VersionActivityFixedEnterView:_btnreplayOnClick()
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

function VersionActivityFixedEnterView:_btnachievementpreviewOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self.curActId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function VersionActivityFixedEnterView:_onTabScrollChange()
	self._scroll = self._scroll or self._scrolltab:GetComponent(gohelper.Type_ScrollRect)

	if self._scroll.horizontal then
		self:_checkHorizontalScroll()
	else
		self:_checkVerticalScroll()
	end
end

function VersionActivityFixedEnterView:_checkHorizontalScroll()
	local contentAnchorX = recthelper.getAnchorX(self.rectTrContent)

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem:isShowRedDot() then
			local anchorX = -tabItem:getAnchorX() + tabItem:getWidth() / 2 - (VersionActivityFixedHelper.getVersionActivityEnum().RedDotOffsetX or 10)

			if anchorX - contentAnchorX < -self.viewPortWidth then
				gohelper.setActive(self.goArrowRedDot, true)

				return
			end
		end
	end

	gohelper.setActive(self.goArrowRedDot, false)
end

function VersionActivityFixedEnterView:_checkVerticalScroll()
	local contentAnchorY = recthelper.getAnchorY(self.rectTrContent)

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem:isShowRedDot() then
			local anchorY = -tabItem:getAnchorY() + VersionActivityFixedHelper.getVersionActivityEnum().RedDotOffsetY

			if anchorY - contentAnchorY > self.viewPortHeight then
				gohelper.setActive(self.goArrowRedDot, true)

				return
			end
		end
	end

	gohelper.setActive(self.goArrowRedDot, false)
end

function VersionActivityFixedEnterView:refreshRedDot()
	self:_onTabScrollChange()
end

function VersionActivityFixedEnterView:refreshBtnVisible(isOnOpen)
	local showReplay = VersionActivityFixedEnterHelper.GetIsShowReplayBtn(self.curActId)
	local showAchieve = VersionActivityFixedEnterHelper.GetIsShowAchievementBtn(self.curActId)

	gohelper.setActive(self.goReplayBtn, showReplay)
	gohelper.setActive(self.goAchievementBtn, showAchieve)
end

function VersionActivityFixedEnterView:onOpen()
	VersionActivityFixedEnterView.super.onOpen(self)

	local enum = VersionActivityFixedHelper.getVersionActivityEnum()

	if self.curActId == enum.ActivityId.Dungeon then
		self.viewAnim:Play("open1", 0, 0)
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

return VersionActivityFixedEnterView
