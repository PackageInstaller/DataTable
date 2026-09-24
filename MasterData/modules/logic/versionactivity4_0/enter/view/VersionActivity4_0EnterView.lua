-- chunkname: @modules/logic/versionactivity4_0/enter/view/VersionActivity4_0EnterView.lua

module("modules.logic.versionactivity4_0.enter.view.VersionActivity4_0EnterView", package.seeall)

local VersionActivity4_0EnterView = class("VersionActivity4_0EnterView", VersionActivityFixedEnterView)

function VersionActivity4_0EnterView:_editableInitView()
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#go_tabcontainer/mask/#scroll_tab")
	self._godrag = gohelper.findChild(self.viewGO, "#go_tabcontainer/mask/#scroll_tab/#go_drag")
	self.goArrowRedDot = gohelper.findChild(self.viewGO, "#go_tabcontainer/mask/#scroll_tab/arrow/#go_arrowreddot")

	local rectTrViewPort = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/mask/#scroll_tab/Circle/ViewPort", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(rectTrViewPort)
	self.viewPortWidth = recthelper.getWidth(rectTrViewPort)
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/mask/#scroll_tab/Circle/ViewPort/Content", gohelper.Type_RectTransform)
	self._gotabitem1 = gohelper.findChild(self.viewGO, "#go_tabcontainer/mask/#scroll_tab/Circle/ViewPort/Content/#go_tabitem1")
	self._gotabitem2 = gohelper.findChild(self.viewGO, "#go_tabcontainer/mask/#scroll_tab/Circle/ViewPort/Content/#go_tabitem2")
	self._goline = gohelper.findChild(self.viewGO, "#go_tabcontainer/mask/#scroll_tab/Circle/ViewPort/Content/#go_line")

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivity4_0EnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity4_0EnterViewTabItem2)
	self:setActivityLineGo(self._goline)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementnormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject

	gohelper.setActive(self._btnachievementnormal.gameObject, false)

	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
	self.goentranceCanvasGroup = gohelper.findChildComponent(self.viewGO, "entrance", gohelper.Type_CanvasGroup)
	self.gotopleftCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_topleft", gohelper.Type_CanvasGroup)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrolltab.gameObject)
	self._cellList = {}

	self:_initCircleScroll()
end

function VersionActivity4_0EnterView:childAddEvents()
	VersionActivity4_0EnterView.super.childAddEvents(self)

	if self._drag then
		self._drag:AddDragBeginListener(self._onBeginDrag, self)
		self._drag:AddDragEndListener(self._onEndDrag, self)
	end
end

function VersionActivity4_0EnterView:childRemoveEvents()
	VersionActivity4_0EnterView.super.childRemoveEvents(self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
	end
end

function VersionActivity4_0EnterView:_onBeginDrag(data, pointerEventData)
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local cls = tabSetting.cls

		if cls then
			cls:setDrag(true)
		end
	end
end

function VersionActivity4_0EnterView:_onEndDrag(data, pointerEventData)
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local cls = tabSetting.cls

		if cls then
			cls:setDrag(false)
		end
	end
end

function VersionActivity4_0EnterView:onOpen()
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

function VersionActivity4_0EnterView:onClose()
	VersionActivity4_0EnterView.super.onClose(self)

	if self._audioId then
		AudioMgr.instance:stopPlayingID(self._audioId)
	end
end

function VersionActivity4_0EnterView:playVideo()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if self.viewParam.jumpActId and self.viewParam.jumpActId ~= VersionActivity4_0Enum.ActivityId.Dungeon then
		return
	end

	if self.viewParam.isExitFight then
		return
	end

	if self.viewParam and self.viewParam.playVideo then
		self.viewAnim:Play("open1", 0, 0)

		self.viewAnim.speed = 0
		self.gosubviewCanvasGroup.alpha = 0
		self.goentranceCanvasGroup.interactable = false
		self.goentranceCanvasGroup.blocksRaycasts = false
		self.gotopleftCanvasGroup.interactable = false
		self.gotopleftCanvasGroup.blocksRaycasts = false

		local isCanSkip = GameUtil.playerPrefsGetNumberByUserId(VersionActivity4_0Enum.EnterVideoFirstKey, 0) ~= 0

		if not isCanSkip then
			GameUtil.playerPrefsSetNumberByUserId(VersionActivity4_0Enum.EnterVideoFirstKey, 1)
		end

		local timeoutValue = VersionActivity4_0Enum.OpenAnimDelayTime + 2

		VideoController.instance:openFullScreenVideoView(VersionActivity4_0Enum.EnterAnimVideoName, nil, timeoutValue, nil, nil, {
			couldSkip = isCanSkip
		})
		TimeUtil.setDayFirstLoginRed(VersionActivity4_0Enum.EnterVideoDayKey)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
	else
		self.viewAnim.speed = 1

		self:_playOpenAnim()
	end
end

function VersionActivity4_0EnterView:onPlayVideoDone()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	self.gosubviewCanvasGroup.alpha = 1

	if self.viewAnim.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity4_0EnterView:_delayPlayOpen1Anim()
	if self.viewAnim.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, VersionActivity4_0Enum.OpenAnimDelayTime)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
end

function VersionActivity4_0EnterView:_playOpen1Anim()
	self.gosubviewCanvasGroup.alpha = 1
	self.goentranceCanvasGroup.interactable = true
	self.goentranceCanvasGroup.blocksRaycasts = true
	self.gotopleftCanvasGroup.interactable = true
	self.gotopleftCanvasGroup.blocksRaycasts = true
	self.viewAnim.speed = 1

	self:_playOpenAnim("open1")
end

function VersionActivity4_0EnterView:_playOpenAnim(animName)
	if not string.nilorempty(animName) then
		self.viewAnim:Play(animName, 0, 0)
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

function VersionActivity4_0EnterView:onDestroyView()
	VersionActivity4_0EnterView.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if ViewMgr.instance:isOpen(ViewName.FullScreenVideoView) then
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	end
end

function VersionActivity4_0EnterView:_initCircleScroll()
	self._circleroot = gohelper.findChild(self.viewGO, "#go_tabcontainer/mask/#scroll_tab/Circle")
	self._csCircleScroll = SLFramework.UGUI.CircleScrollView.Get(self._scrolltab.gameObject)

	local circleCellCount = 18
	local scrollRadius = 500
	local cellRadius = 500
	local firstDegree = 180

	self._csCircleScroll:Init(ScrollEnum.ScrollDirV, ScrollEnum.ScrollRotateCCW, circleCellCount, scrollRadius, cellRadius, firstDegree, false, self._onUpdateCell, self._onSelectCell, self)
end

function VersionActivity4_0EnterView:refreshUI()
	VersionActivity4_0EnterView.super.refreshUI(self)

	self._csCircleScroll.totalCellNum = #self.activityTabItemList + 1

	for actId, tabItem in pairs(self.activityTabItemDict) do
		local index = self._sortActIds[actId]
		local cellGO = self._circleroot.transform:GetChild(index).gameObject

		if cellGO then
			cellGO.name = actId

			gohelper.addChild(cellGO, tabItem.go)
			recthelper.setAnchor(tabItem.go.transform, 0, 0)
		end
	end
end

local function openActSortFunc(actId1, actId2)
	if actId1 == VersionActivity4_0Enum.ActivityId.Dungeon then
		return true
	end

	if actId2 == VersionActivity4_0Enum.ActivityId.Dungeon then
		return false
	end

	local act1Info = ActivityModel.instance:getActMO(actId1)
	local act2Info = ActivityModel.instance:getActMO(actId2)

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

function VersionActivity4_0EnterView:sortTabItemList()
	tabletool.clear(self.openActIdList)
	tabletool.clear(self.noOpenActList)

	self._sortActIds = {}

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem.go.activeSelf then
			local status = ActivityHelper.getActivityStatus(tabItem.actId)

			if status == ActivityEnum.ActivityStatus.Normal then
				table.insert(self.openActIdList, tabItem.actId)
			else
				table.insert(self.noOpenActList, tabItem.actId)
			end
		end
	end

	table.sort(self.openActIdList, openActSortFunc)

	for index, actId in ipairs(self.openActIdList) do
		self._sortActIds[actId] = index
	end

	if #self.noOpenActList < 1 then
		gohelper.setActive(self._goActivityLine, false)

		return
	end

	gohelper.setActive(self._goActivityLine, true)

	local activeActLen = #self.openActIdList

	table.sort(self.noOpenActList, noOpenActSortFunc)

	for index, actId in ipairs(self.noOpenActList) do
		self._sortActIds[actId] = activeActLen + index
	end
end

function VersionActivity4_0EnterView:_onUpdateCell(cellGO, index)
	return
end

function VersionActivity4_0EnterView:_onSelectCell(cellGO, isSelect)
	return
end

function VersionActivity4_0EnterView:onRefreshActivity(actId)
	if not self.curStoreId then
		local checkActId = self.curActId
		local status = ActivityHelper.getActivityStatus(checkActId)

		if actId == checkActId and (status == ActivityEnum.ActivityStatus.NotOnLine or status == ActivityEnum.ActivityStatus.Expired) then
			MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

			return
		end

		for _, actSetting in ipairs(self.activitySettingList) do
			local _actId = VersionActivityEnterHelper.getActId(actSetting)
			local isShowActTab = not VersionActivityEnterHelper.isActTabCanRemove(actSetting)
			local tabItem = self.activityTabItemDict[actSetting.actId]

			if tabItem then
				gohelper.setActive(tabItem.go, isShowActTab)
			end
		end

		for _, tabItem in ipairs(self.activityTabItemList) do
			if tabItem:updateActId() and tabItem.go.activeSelf then
				self.activityTabItemDict[tabItem.actId] = tabItem
			end
		end

		self:sortTabItemList()
	end
end

function VersionActivity4_0EnterView:createActivityTabItem()
	for i, actSetting in ipairs(self.activitySettingList) do
		local actId = VersionActivityEnterHelper.getActId(actSetting)
		local isShowActTab = not VersionActivityEnterHelper.isActTabCanRemove(actSetting)

		if isShowActTab then
			local goTab, cls = self:getItemGoAndCls(actSetting.actLevel)

			if goTab and cls then
				local newTabGo = gohelper.cloneInPlace(goTab, actId)
				local tabItem = MonoHelper.addNoUpdateLuaComOnceToGo(newTabGo, cls)

				tabItem:setData(i, actSetting)
				tabItem:refreshSelect(self.curActId)

				local customClick = self["onClickActivity" .. actId]

				if customClick then
					tabItem:setClickFunc(customClick, self)
				end

				self.activityTabItemDict[actId] = tabItem

				table.insert(self.activityTabItemList, tabItem)
			end
		end
	end
end

function VersionActivity4_0EnterView:_checkVerticalScroll()
	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem:isShowRedDot() then
			local tabAnchorY = recthelper.getAnchorY(tabItem.go.transform.parent) or 0

			if -tabAnchorY - 180 > self.viewPortHeight * 0.5 then
				gohelper.setActive(self.goArrowRedDot, true)

				return
			end
		end
	end

	gohelper.setActive(self.goArrowRedDot, false)
end

return VersionActivity4_0EnterView
