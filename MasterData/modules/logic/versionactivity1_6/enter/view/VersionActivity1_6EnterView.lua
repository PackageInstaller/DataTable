-- chunkname: @modules/logic/versionactivity1_6/enter/view/VersionActivity1_6EnterView.lua

module("modules.logic.versionactivity1_6.enter.view.VersionActivity1_6EnterView", package.seeall)

local VersionActivity1_6EnterView = class("VersionActivity1_6EnterView", VersionActivityEnterBaseViewWithList)
local selectTabColor = {
	orange = 2,
	green = 1,
	yellow = 3
}
local ActIdEnum = VersionActivity1_6Enum.ActivityId
local ActivtiyId2SelectTabColor = {
	[ActIdEnum.Season] = selectTabColor.green,
	[ActIdEnum.Dungeon] = selectTabColor.green,
	[ActIdEnum.BossRush] = selectTabColor.orange,
	[ActIdEnum.Role1] = selectTabColor.green,
	[ActIdEnum.Role2] = selectTabColor.yellow,
	[ActIdEnum.Cachot] = selectTabColor.green,
	[ActIdEnum.Reactivity] = selectTabColor.yellow,
	[ActIdEnum.RoleStory] = selectTabColor.orange,
	[ActIdEnum.RoleStory2] = selectTabColor.orange,
	[ActIdEnum.Explore] = selectTabColor.green
}
local ShowActivtiyRemainDayTab = {
	[ActIdEnum.Role1] = true,
	[ActIdEnum.Role2] = true,
	[ActIdEnum.RoleStory] = true,
	[ActIdEnum.RoleStory2] = true
}
local showRemainTimeDayNum = 3

function VersionActivity1_6EnterView:onInitView()
	VersionActivity1_6EnterView.super.onInitView(self)

	self._goBtnReplay = gohelper.findChild(self.viewGO, "entrance/#btn_replay")
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._goBtnAchievement = gohelper.findChild(self.viewGO, "entrance/#btn_achievementpreview")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self._goBtnAchievementNormal = gohelper.findChild(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnAchievementNormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._tabScrollRect = gohelper.findChildScrollRect(self.viewGO, "#go_category/#scroll_category")
	self._goContent = gohelper.findChild(self.viewGO, "#go_category/#scroll_category/Viewport/Content")
	self._goTabListDownFlag = gohelper.findChild(self.viewGO, "#go_category/tips/down")
	self._goTabListArrow = gohelper.findChild(self.viewGO, "#go_category/arrow")
	self._arrowAnimator = self._goTabListArrow:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_6EnterView:addEvents()
	VersionActivity1_6EnterView.super.addEvents(self)
	self._btnreplay:AddClickListener(self._btnReplayOnClick, self)
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._btnAchievementNormal:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._tabScrollRect:AddOnValueChanged(self._onScrollChange, self)
end

function VersionActivity1_6EnterView:removeEvents()
	VersionActivity1_6EnterView.super.removeEvents(self)
	self._btnreplay:RemoveClickListener()
	self._btnachievementpreview:RemoveClickListener()
	self._btnAchievementNormal:RemoveClickListener()
	self._tabScrollRect:RemoveOnValueChanged()
end

function VersionActivity1_6EnterView:_btnachievementpreviewOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self._curActId)
	local achievementGroup = activityCfg and activityCfg.achievementGroup

	if achievementGroup and achievementGroup ~= 0 then
		AchievementController.instance:openAchievementGroupPreView(self._curActId)
	else
		local defaultAchieveTab = AchievementEnum.Type.GamePlay

		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			selectType = defaultAchieveTab
		})
	end
end

function VersionActivity1_6EnterView:_btnReplayOnClick()
	local activityMo = ActivityModel.instance:getActMO(self._curActId)

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

function VersionActivity1_6EnterView:_editableInitView()
	VersionActivity1_6EnterView.super._editableInitView(self)
	self.addEventCb(self, VersionActivity1_6EnterController.instance, VersionActivity1_6EnterEvent.OnEnterVideoFinished, self._onFinishEnterVideo, self)
end

function VersionActivity1_6EnterView:onOpen()
	VersionActivity1_6EnterView.super.onOpen(self)
end

function VersionActivity1_6EnterView:onOpenFinish()
	VersionActivity1_6EnterView.super.onOpenFinish(self)

	self._scrollHeight = recthelper.getHeight(self._tabScrollRect.transform)

	self:refreshTabListFlag()

	if self._showEnterVideo then
		ViewMgr.instance:openView(ViewName.VersionActivity1_6EnterVideoView)
	end
end

function VersionActivity1_6EnterView:_onFinishEnterVideo()
	self:playOpenAnimation()
	AudioMgr.instance:trigger((self._curActId == VersionActivity1_6Enum.ActivityId.Dungeon or nil) and (AudioEnum.UI.Act1_6EnterViewMainActTabSelect or AudioEnum.UI.Act1_6EnterViewTabSelect))
end

function VersionActivity1_6EnterView:onDestroyView()
	VersionActivity1_6EnterView.super.onDestroyView(self)
end

function VersionActivity1_6EnterView:everyMinuteCall()
	VersionActivity1_6EnterView.super.everyMinuteCall(self)
end

function VersionActivity1_6EnterView:_onScrollChange(value)
	self:refreshTabListArrow()

	if not self._redDotItems or #self._redDotItems == 0 then
		if self._goTabListArrow.activeSelf then
			self._arrowAnimator:Play(UIAnimationName.Idle)
		end

		return
	end

	self:refreshTabListFlag()
end

function VersionActivity1_6EnterView:initViewParam()
	VersionActivity1_6EnterView.super.initViewParam(self)

	self._showEnterVideo = self.viewParam.enterVideo
end

local VisableItemCount = 5
local ItemCellHeight = 150

function VersionActivity1_6EnterView:refreshTabListFlag()
	self._contentHeight = recthelper.getHeight(self._goContent.transform)

	if not self.showItemNum then
		if self.showItemNum <= VisableItemCount then
			gohelper.setActive(self._goTabListDownFlag, false)
			gohelper.setActive(self._goTabListArrow, false)
		else
			local bottomY = 0

			for _, actItem in ipairs(self._redDotItems) do
				local tabGo = actItem.rootGo
				local tabTrans = tabGo.transform
				local y = tabTrans.localPosition.y

				bottomY = math.min(y, bottomY)
			end

			local deepestRedDotHeight = math.abs(bottomY)
			local contentTrans = self._goContent.transform
			local y = contentTrans.localPosition.y
			local showArrowEffect = deepestRedDotHeight - self._scrollHeight - y > ItemCellHeight / 2

			if showArrowEffect then
				self._arrowAnimator:Play(UIAnimationName.Loop)
			else
				self._arrowAnimator:Play(UIAnimationName.Idle)
			end

			gohelper.setActive(self._goTabListDownFlag, showArrowEffect)
		end
	end
end

function VersionActivity1_6EnterView:refreshTabListArrow()
	self._contentHeight = recthelper.getHeight(self._goContent.transform)

	if not self.showItemNum then
		if self.showItemNum <= VisableItemCount then
			gohelper.setActive(self._goTabListDownFlag, false)
			gohelper.setActive(self._goTabListArrow, false)
		else
			local contentTrans = self._goContent.transform
			local y = contentTrans.localPosition.y
			local lastContentHeight = self._contentHeight - self._scrollHeight - y

			gohelper.setActive(self._goTabListArrow, lastContentHeight > 0)
		end
	end
end

function VersionActivity1_6EnterView:_refreshTabs(actId)
	self.viewContainer:selectActTab(actId)
end

function VersionActivity1_6EnterView:onCreateActivityItem(activityItem)
	local actId = activityItem.actId

	activityItem:setShowRemainDayToggle(ShowActivtiyRemainDayTab[actId], showRemainTimeDayNum)

	local createItemCallback = self["onCreateActivityItem" .. actId]

	if createItemCallback then
		createItemCallback(self, activityItem)
	end
end

function VersionActivity1_6EnterView:onRefreshTabView(selectTabId, isDefaultSelect)
	VersionActivity1_6EnterView.super.onRefreshTabView(self)

	local activityItem = self.activityItemList[selectTabId]
	local activityId = activityItem.actId
	local showReplayBtn, showAchivermentBtn = ActivityConfig.instance:getActivityTabButtonState(activityId)

	gohelper.setActive(self._goBtnReplay, showReplayBtn)

	if showAchivermentBtn then
		gohelper.setActive(self._goBtnAchievement, activityId == VersionActivity1_6Enum.ActivityId.Dungeon)
		gohelper.setActive(self._goBtnAchievementNormal, activityId ~= VersionActivity1_6Enum.ActivityId.Dungeon)
	else
		gohelper.setActive(self._goBtnAchievement, false)
		gohelper.setActive(self._goBtnAchievementNormal, false)
	end

	if not isDefaultSelect then
		AudioMgr.instance:trigger((activityId == VersionActivity1_6Enum.ActivityId.Dungeon or nil) and (AudioEnum.UI.Act1_6EnterViewMainActTabSelect or AudioEnum.UI.Act1_6EnterViewTabSelect))
	end
end

function VersionActivity1_6EnterView:onFocusToTab(activityItem)
	local tabGo = activityItem.rootGo
	local sibling = gohelper.getSibling(tabGo)
	local contentPos = self._goContent.transform.localPosition

	self._goContent.transform.localPosition = Vector3(contentPos.x, (sibling - 1) * ItemCellHeight, contentPos.z)
end

function VersionActivity1_6EnterView:onRefreshActivityTabIcon(item)
	local actId = item.actId
	local tabIcons = ActivityConfig.instance:getActivityTabBgPathes(actId)

	if tabIcons and #tabIcons == 2 then
		local selectIcon = tabIcons[1]
		local normalIcon = tabIcons[2]

		UISpriteSetMgr.instance:setV1a6EnterSprite(item.imageIcons.select, selectIcon, true)
		UISpriteSetMgr.instance:setV1a6EnterSprite(item.imageIcons.normal, normalIcon, true)
	end
end

function VersionActivity1_6EnterView:setSelectActId(actId)
	VersionActivity1_6EnterController.instance:setSelectActId(actId)
end

function VersionActivity1_6EnterView:refreshTabSelectState(activityItem, select)
	if not select then
		return
	end

	local activityId = activityItem.actId
	local selectEffectObjIdx = ActivtiyId2SelectTabColor[activityId]
	local selectEffectObjList = {
		gohelper.findChild(activityItem.go_selected, "eff/1"),
		gohelper.findChild(activityItem.go_selected, "eff/2"),
		gohelper.findChild(activityItem.go_selected, "eff/3")
	}

	for idx, go in ipairs(selectEffectObjList) do
		gohelper.setActive(go, idx == selectEffectObjIdx)
	end
end

function VersionActivity1_6EnterView:checkActivityCanClickFunc11602(activityItem)
	return true
end

function VersionActivity1_6EnterView:checkStatusFunc11602()
	return ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.DungeonStore)
end

function VersionActivity1_6EnterView:checkStatusFunc11600()
	return ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.SeasonStore)
end

function VersionActivity1_6EnterView:checkActivityCanClickFunc11600()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.SeasonStore)

	if self:CheckActivityStatusClickAble(status) then
		return true
	else
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end
end

function VersionActivity1_6EnterView:checkStatusFunc11104()
	return ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.ReactivityStore)
end

function VersionActivity1_6EnterView:checkActivityCanClickFunc11104()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.ReactivityStore)

	if self:CheckActivityStatusClickAble(status) then
		return true
	else
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end
end

function VersionActivity1_6EnterView:onClickActivity11610()
	local isOpen = V1a6_CachotModel.instance:isReallyOpen()

	if isOpen then
		RogueRpc.instance:sendGetRogueStateRequest()
	end
end

function VersionActivity1_6EnterView:onCreateActivityItem11605(activityItem)
	activityItem.redDotUid = VersionActivity1_6Enum.ActivityId.Role1
end

function VersionActivity1_6EnterView:onCreateActivityItem11606(activityItem)
	activityItem.redDotUid = VersionActivity1_6Enum.ActivityId.Role2
end

return VersionActivity1_6EnterView
