-- chunkname: @modules/logic/versionactivity3_6/enter/view/VersionActivity3_6EnterView.lua

module("modules.logic.versionactivity3_6.enter.view.VersionActivity3_6EnterView", package.seeall)

local VersionActivity3_6EnterView = class("VersionActivity3_6EnterView", VersionActivityFixedEnterView)

function VersionActivity3_6EnterView:_editableInitView()
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

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivity3_6EnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity3_6EnterViewTabItem2)
	self:setActivityLineGo(self._goline)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementnormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject

	gohelper.setActive(self._btnachievementnormal.gameObject, false)

	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrolltab.gameObject)
	self._cellList = {}

	self:_initCircleScroll()
end

function VersionActivity3_6EnterView:childAddEvents()
	VersionActivity3_6EnterView.super.childAddEvents(self)

	if self._drag then
		self._drag:AddDragBeginListener(self._onBeginDrag, self)
		self._drag:AddDragEndListener(self._onEndDrag, self)
	end
end

function VersionActivity3_6EnterView:childRemoveEvents()
	VersionActivity3_6EnterView.super.childRemoveEvents(self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
	end
end

function VersionActivity3_6EnterView:_onBeginDrag(data, pointerEventData)
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local cls = tabSetting.cls

		if cls then
			cls:setDrag(true)
		end
	end
end

function VersionActivity3_6EnterView:_onEndDrag(data, pointerEventData)
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local cls = tabSetting.cls

		if cls then
			cls:setDrag(false)
		end
	end
end

function VersionActivity3_6EnterView:onOpen()
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

function VersionActivity3_6EnterView:onClose()
	VersionActivity3_6EnterView.super.onClose(self)

	if self._audioId then
		AudioMgr.instance:stopPlayingID(self._audioId)
	end
end

local VIDEO_DURATION = 6.5

function VersionActivity3_6EnterView:playVideo()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if self.viewParam.jumpActId and self.viewParam.jumpActId ~= VersionActivity3_6Enum.ActivityId.Dungeon then
		return
	end

	if self.viewParam.isExitFight then
		return
	end

	if self.viewParam and self.viewParam.playVideo then
		self.viewAnim:Play("open1", 0, 0)

		self.viewAnim.speed = 0
		self.gosubviewCanvasGroup.alpha = 0

		VideoController.instance:openFullScreenVideoView(VersionActivity3_6Enum.EnterAnimVideoName, nil, VIDEO_DURATION)
		TimeUtil.setDayFirstLoginRed(VersionActivity3_6Enum.EnterVideoDayKey)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)

		self._audioId = AudioMgr.instance:trigger(AudioEnum3_6.VersionActivity3_6.play_ui_renmen_open)
	else
		self.viewAnim.speed = 1

		self:_playOpenAnim()

		self._audioId = AudioMgr.instance:trigger(AudioEnum3_6.VersionActivity3_6.play_ui_renmen_open2)
	end
end

function VersionActivity3_6EnterView:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	self.gosubviewCanvasGroup.alpha = 1

	if self.viewAnim.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity3_6EnterView:_delayPlayOpen1Anim()
	if self.viewAnim.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, VersionActivity3_6Enum.OpenAnimDelayTime)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
end

function VersionActivity3_6EnterView:_playOpen1Anim()
	self.gosubviewCanvasGroup.alpha = 1
	self.viewAnim.speed = 1

	self:_playOpenAnim("open1")
end

function VersionActivity3_6EnterView:_playOpenAnim(animName)
	if not string.nilorempty(animName) then
		self.viewAnim:Play(animName, 0, 0)
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

function VersionActivity3_6EnterView:onDestroyView()
	VersionActivity3_6EnterView.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if ViewMgr.instance:isOpen(ViewName.FullScreenVideoView) then
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	end
end

function VersionActivity3_6EnterView:_initCircleScroll()
	self._circleroot = gohelper.findChild(self.viewGO, "#go_tabcontainer/mask/#scroll_tab/Circle")
	self._csCircleScroll = SLFramework.UGUI.CircleScrollView.Get(self._scrolltab.gameObject)

	local circleCellCount = 18
	local scrollRadius = 420
	local cellRadius = 200
	local firstDegree = 200

	self._csCircleScroll:Init(ScrollEnum.ScrollDirV, ScrollEnum.ScrollRotateCCW, circleCellCount, scrollRadius, cellRadius, firstDegree, false, self._onUpdateCell, self._onSelectCell, self)
end

function VersionActivity3_6EnterView:refreshUI()
	VersionActivity3_6EnterView.super.refreshUI(self)

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
	if actId1 == VersionActivity3_6Enum.ActivityId.Dungeon then
		return true
	end

	if actId2 == VersionActivity3_6Enum.ActivityId.Dungeon then
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

function VersionActivity3_6EnterView:sortTabItemList()
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

function VersionActivity3_6EnterView:_onUpdateCell(cellGO, index)
	return
end

function VersionActivity3_6EnterView:_onSelectCell(cellGO, isSelect)
	return
end

function VersionActivity3_6EnterView:onRefreshActivity(actId)
	if not self.curStoreId then
		local checkActId = self.curActId
		local status = ActivityHelper.getActivityStatus(checkActId)

		if actId == checkActId and (status == ActivityEnum.ActivityStatus.NotOnLine or status == ActivityEnum.ActivityStatus.Expired) then
			MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

			return
		end

		for _, actSetting in ipairs(self.activitySettingList) do
			local _actId = VersionActivityEnterHelper.getActId(actSetting)
			local isShowActTab = _actId == VersionActivity3_6Enum.ActivityId.YaMi or not VersionActivityEnterHelper.isActTabCanRemove(actSetting)
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

function VersionActivity3_6EnterView:createActivityTabItem()
	for i, actSetting in ipairs(self.activitySettingList) do
		local actId = VersionActivityEnterHelper.getActId(actSetting)
		local isShowActTab = actId == VersionActivity3_6Enum.ActivityId.YaMi or not VersionActivityEnterHelper.isActTabCanRemove(actSetting)

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

function VersionActivity3_6EnterView:_checkVerticalScroll()
	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem:isShowRedDot() then
			local tabAnchorY = recthelper.getAnchorY(tabItem.go.transform.parent) or 0

			if -tabAnchorY > self.viewPortHeight * 0.5 then
				gohelper.setActive(self.goArrowRedDot, true)

				return
			end
		end
	end

	gohelper.setActive(self.goArrowRedDot, false)
end

function VersionActivity3_6EnterView:onClickActivity13608(tabItem)
	local actId = VersionActivity3_6Enum.ActivityId.YaMi

	if self.curActId == actId then
		return
	end

	local function cb()
		tabItem.animator:Play("click", 0, 0)
		VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, actId, tabItem)
	end

	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(actId)

	if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
		V3a6YaMiRpc.instance:sendGetAct231InfoRequest(cb, self)
	else
		cb(self)
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
end

return VersionActivity3_6EnterView
