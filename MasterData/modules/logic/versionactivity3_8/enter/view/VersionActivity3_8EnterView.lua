-- chunkname: @modules/logic/versionactivity3_8/enter/view/VersionActivity3_8EnterView.lua

module("modules.logic.versionactivity3_8.enter.view.VersionActivity3_8EnterView", package.seeall)

local VersionActivity3_8EnterView = class("VersionActivity3_8EnterView", VersionActivityFixedEnterView)

function VersionActivity3_8EnterView:_editableInitView()
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#go_tabcontainer/#scroll_tab")
	self._godrag = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/#go_drag")
	self.goArrowRedDot = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local rectTrViewPort = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(rectTrViewPort)
	self.viewPortWidth = recthelper.getWidth(rectTrViewPort)
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	self._gotabitem1 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	self._gotabitem2 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	self._goline = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivity3_8EnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity3_8EnterViewTabItem2)
	self:setActivityLineGo(self._goline)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementnormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject

	gohelper.setActive(self._btnachievementnormal.gameObject, false)

	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)

	gohelper.setActive(self._goActivityLine, false)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrolltab.gameObject)
end

function VersionActivity3_8EnterView:childAddEvents()
	VersionActivity3_8EnterView.super.childAddEvents(self)

	if self._drag then
		self._drag:AddDragBeginListener(self._onBeginDrag, self)
		self._drag:AddDragEndListener(self._onEndDrag, self)
	end

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivity3_8EnterView:childRemoveEvents()
	VersionActivity3_8EnterView.super.childRemoveEvents(self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
	end

	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivity3_8EnterView:_onCloseView(viewName)
	if viewName == ViewName.FullScreenVideoView then
		self:_skipPlayVideo()
	end
end

function VersionActivity3_8EnterView:_onBeginDrag(data, pointerEventData)
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local cls = tabSetting.cls

		if cls then
			cls:setDrag(true)
		end
	end
end

function VersionActivity3_8EnterView:_onEndDrag(data, pointerEventData)
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local cls = tabSetting.cls

		if cls then
			cls:setDrag(false)
		end
	end
end

function VersionActivity3_8EnterView:onOpen()
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local go = tabSetting.go

		gohelper.setActive(go, false)
	end

	gohelper.setActive(self._goActivityLine, false)
	self:initViewParam()
	self:createActivityTabItem()
	self:playVideo()
	self:refreshUI()
	self:refreshRedDot()
	self:refreshBtnVisible(true)
end

function VersionActivity3_8EnterView:onClose()
	VersionActivity3_8EnterView.super.onClose(self)

	if self._audioId then
		AudioMgr.instance:stopPlayingID(self._audioId)
	end
end

local VIDEO_DURATION = 8

function VersionActivity3_8EnterView:playVideo()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if self.viewParam.jumpActId and self.viewParam.jumpActId ~= VersionActivity3_8Enum.ActivityId.Dungeon then
		return
	end

	if self.viewParam.isExitFight then
		return
	end

	if self.viewParam and self.viewParam.playVideo then
		self.viewAnim:Play("open1", 0, 0)

		self.viewAnim.speed = 0
		self.gosubviewCanvasGroup.alpha = 0

		local isCanSkip = GameUtil.playerPrefsGetNumberByUserId(VersionActivity3_8Enum.EnterVideoFirstKey, 0) ~= 0

		if not isCanSkip then
			GameUtil.playerPrefsSetNumberByUserId(VersionActivity3_8Enum.EnterVideoFirstKey, 1)
		end

		VideoController.instance:openFullScreenVideoView(VersionActivity3_8Enum.EnterAnimVideoName, nil, VIDEO_DURATION, nil, nil, {
			couldSkip = isCanSkip
		})
		TimeUtil.setDayFirstLoginRed(VersionActivity3_8Enum.EnterVideoDayKey)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)

		self._audioId = AudioMgr.instance:trigger(AudioEnum3_8.VersionActivity3_8.play_ui_shiji_3_8_open_1)
	else
		self.viewAnim.speed = 1

		self:_playOpenAnim()

		self._audioId = AudioMgr.instance:trigger(AudioEnum3_8.VersionActivity3_8.play_ui_shiji_3_8_open_2)
	end
end

function VersionActivity3_8EnterView:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	self.gosubviewCanvasGroup.alpha = 1

	if self.viewAnim.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity3_8EnterView:_delayPlayOpen1Anim()
	if self.viewAnim.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, VersionActivity3_8Enum.OpenAnimDelayTime)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
end

function VersionActivity3_8EnterView:_skipPlayVideo()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
	self:_playOpen1Anim()

	if self._audioId then
		AudioMgr.instance:stopPlayingID(self._audioId)
	end
end

function VersionActivity3_8EnterView:_playOpen1Anim()
	self.gosubviewCanvasGroup.alpha = 1
	self.viewAnim.speed = 1

	self:_playOpenAnim("open1")
end

function VersionActivity3_8EnterView:_playOpenAnim(animName)
	if not string.nilorempty(animName) then
		self.viewAnim:Play(animName, 0, 0)
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

function VersionActivity3_8EnterView:onDestroyView()
	VersionActivity3_8EnterView.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if ViewMgr.instance:isOpen(ViewName.FullScreenVideoView) then
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	end

	if self.activityTabItemList then
		for _, activityItem in ipairs(self.activityTabItemList) do
			activityItem._originalAnchorY = nil
			activityItem._originalAnchorX = nil

			if activityItem.tweenId then
				ZProj.TweenHelper.KillById(activityItem.tweenId)

				activityItem.tweenId = nil
			end

			activityItem:dispose()
		end
	end

	self.activityTabItemList = nil
	self.activityTabItemDict = nil
end

local function openActSortFunc(actId1, actId2)
	local act1Info = ActivityModel.instance:getActMO(actId1)
	local act2Info = ActivityModel.instance:getActMO(actId2)

	if actId1 == VersionActivity3_8Enum.ActivityId.Dungeon then
		return true
	end

	if actId2 == VersionActivity3_8Enum.ActivityId.Dungeon then
		return false
	end

	if act1Info then
		if not act1Info.config.displayPriority then
			local displayOrder1 = 0

			if act2Info then
				if not act2Info.config.displayPriority then
					local displayOrder2 = 0

					if displayOrder1 ~= displayOrder2 then
						return displayOrder1 < displayOrder2
					end

					local act1OpenTime = act1Info and act1Info:getRealStartTimeStamp() or 0
					local act2OpenTime = act2Info and act2Info:getRealStartTimeStamp() or 0

					if act1OpenTime ~= act2OpenTime then
						return act2OpenTime < act1OpenTime
					end

					return actId1 < actId2
				end
			end
		end
	end
end

local function noOpenActSortFunc(actId1, actId2)
	local act1Info = ActivityModel.instance:getActMO(actId1)
	local act2Info = ActivityModel.instance:getActMO(actId2)
	local act1OpenTime = act1Info:getRealStartTimeStamp()
	local act2OpenTime = act2Info:getRealStartTimeStamp()

	if act1OpenTime ~= act2OpenTime then
		return act1OpenTime < act2OpenTime
	end

	local displayOrder1 = act1Info.config.displayPriority
	local displayOrder2 = act2Info.config.displayPriority

	if displayOrder1 ~= displayOrder2 then
		return displayOrder1 < displayOrder2
	end

	return actId1 < actId2
end

local itemSpacing = 80

function VersionActivity3_8EnterView:sortTabItemList()
	tabletool.clear(self.openActIdList)
	tabletool.clear(self.noOpenActList)

	for i, tabItem in ipairs(self.activityTabItemList) do
		if tabItem.go.activeSelf then
			local status = ActivityHelper.getActivityStatus(tabItem.actId)

			if status == ActivityEnum.ActivityStatus.NotOpen then
				table.insert(self.noOpenActList, tabItem.actId)
			else
				table.insert(self.openActIdList, tabItem.actId)
			end
		end
	end

	local offsetWidth

	table.sort(self.openActIdList, openActSortFunc)

	local anchorX = 0

	for index, actId in ipairs(self.openActIdList) do
		local activityItem = self.activityTabItemDict[actId]

		gohelper.setSibling(activityItem.go, index)

		if anchorX == 0 then
			anchorX = activityItem:getWidth() * 0.5
		end

		recthelper.setAnchor(activityItem.go.transform, anchorX, 0)

		anchorX = anchorX + activityItem:getWidth() + itemSpacing
		offsetWidth = activityItem:getWidth()
	end

	if #self.noOpenActList < 1 then
		recthelper.setWidth(self.rectTrContent, anchorX - offsetWidth)

		return
	end

	local activeActLen = #self.openActIdList

	gohelper.setSibling(self._goActivityLine, activeActLen + 1)
	table.sort(self.noOpenActList, noOpenActSortFunc)

	for index, actId in ipairs(self.noOpenActList) do
		local activityItem = self.activityTabItemDict[actId]

		gohelper.setSibling(activityItem.go, activeActLen + 1 + index)
		recthelper.setAnchor(activityItem.go.transform, anchorX, 0)

		anchorX = anchorX + activityItem:getWidth() + itemSpacing
		offsetWidth = activityItem:getWidth()
	end

	recthelper.setWidth(self.rectTrContent, anchorX - offsetWidth)
end

function VersionActivity3_8EnterView:_recordTabItemBaseY()
	for _, tabItem in ipairs(self.activityTabItemList) do
		tabItem._originalAnchorY = recthelper.getAnchorY(tabItem.go.transform)
	end
end

function VersionActivity3_8EnterView:_checkHorizontalScroll()
	local contentAnchorX = recthelper.getAnchorX(self.rectTrContent)
	local viewportCenterX = -self.viewPortWidth / 2
	local ARC_RADIUS = 500
	local STRAIGHT_LEN = 300
	local EXTEND_SLOPE = 0.1
	local X_COMPRESS_RATIO = 0.8
	local hasRedDotOutOfView = false
	local width = recthelper.getWidth(self._scrolltab.transform)

	self._screenRatio = width / 1440
	STRAIGHT_LEN = math.min(ARC_RADIUS, STRAIGHT_LEN * self._screenRatio * self._screenRatio)

	for i, tabItem in ipairs(self.activityTabItemList) do
		if not tabItem._originalAnchorX then
			local baseAnchorX = tabItem:getAnchorX()
			local itemCenterX = -baseAnchorX + tabItem:getWidth() / 2 - contentAnchorX - 100

			itemCenterX = itemCenterX * 0.3

			if tabItem:isShowRedDot() then
				local anchorX = itemCenterX - (VersionActivityFixedHelper.getVersionActivityEnum().RedDotOffsetX or 10)

				if anchorX < -self.viewPortWidth then
					hasRedDotOutOfView = true
				end
			end

			tabItem._originalAnchorY = tabItem._originalAnchorY or recthelper.getAnchorY(tabItem.go.transform)
			tabItem._originalAnchorX = tabItem._originalAnchorX or tabItem:getAnchorX()

			local dx = viewportCenterX - itemCenterX
			local yOffset = 0

			if dx >= 0 then
				yOffset = 0
			elseif dx >= -STRAIGHT_LEN then
				yOffset = 0
			elseif dx >= -(STRAIGHT_LEN + ARC_RADIUS) then
				local arcDx = -dx - STRAIGHT_LEN

				yOffset = ARC_RADIUS - math.sqrt(ARC_RADIUS * ARC_RADIUS - arcDx * arcDx)
			else
				local arcDx = -dx - STRAIGHT_LEN

				yOffset = ARC_RADIUS + (arcDx - ARC_RADIUS) * EXTEND_SLOPE
			end

			local xOffset = yOffset * X_COMPRESS_RATIO - 200

			recthelper.setAnchorY(tabItem.go.transform, tabItem._originalAnchorY + yOffset)
			recthelper.setAnchorX(tabItem.go.transform, tabItem._originalAnchorX + xOffset)
		end
	end

	gohelper.setActive(self.goArrowRedDot, hasRedDotOutOfView)
end

return VersionActivity3_8EnterView
