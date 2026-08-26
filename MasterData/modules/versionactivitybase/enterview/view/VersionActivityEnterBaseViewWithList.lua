-- chunkname: @modules/versionactivitybase/enterview/view/VersionActivityEnterBaseViewWithList.lua

module("modules.versionactivitybase.enterview.view.VersionActivityEnterBaseViewWithList", package.seeall)

local VersionActivityEnterBaseViewWithList = class("VersionActivityEnterBaseViewWithList", BaseView)
local ShowActTagEnum = VersionActivityEnterViewTabEnum.ActTabFlag

function VersionActivityEnterBaseViewWithList:onInitView()
	self._goCategory = gohelper.findChild(self.viewGO, "#go_category")
	self._goEntrance = gohelper.findChild(self.viewGO, "entrance")
	self._categoryAnimator = self._goCategory:GetComponent(typeof(UnityEngine.Animator))
	self._entranceAnimator = self._goEntrance:GetComponent(typeof(UnityEngine.Animator))
	self._goActivityItem = gohelper.findChild(self.viewGO, "#go_category/#scroll_category/Viewport/Content/#go_categoryitem")
	self._goActivityOpeningTitle = gohelper.findChild(self.viewGO, "#go_category/#scroll_category/Viewport/Content/#txt_title")
end

function VersionActivityEnterBaseViewWithList:addEvents()
	return
end

function VersionActivityEnterBaseViewWithList:removeEvents()
	return
end

function VersionActivityEnterBaseViewWithList:_editableInitView()
	gohelper.setActive(self._goActivityItem, false)
	gohelper.setActive(self._goActivityOpeningTitle, false)

	self.activityItemList = {}
	self.activityItemDict = {}
	self.showItemNum = 0
	self.playedNewActTagAnimationIdList = nil

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.checkNeedRefreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.checkNeedRefreshUI, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self.refreshAllNewActOpenTagUI, self)
	self.addEventCb(self, NavigateMgr.instance, NavigateEvent.BeforeClickHome, self.beforeClickHome, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.checkTabRedDot, self)
	self:addActivityStateEvents()

	self._defaultTabIdx = 1
	self._curTabIdx = -1
end

function VersionActivityEnterBaseViewWithList:onOpen()
	self.onOpening = true
	self._curActId = 0

	self:initViewParam()
	self:initActivityItemList()
	self:refreshUI()
	self:playOpenAnimation()
	self:_selectActivityItem(self._defaultTabIdx, true, self._showEnterVideo and true)
	self:refreshAllTabSelectState()
	self:addPerMinuteRefresh()
	self:addPerSecondRefresh()
end

function VersionActivityEnterBaseViewWithList:initViewParam()
	self.actId = self.viewParam.actId
	self.skipOpenAnim = self.viewParam.skipOpenAnim
	self.activityIdList = self.viewParam.activityIdList

	local jumpActId = self.viewParam.jumpActId

	if jumpActId and jumpActId > 0 then
		for i, v in ipairs(self.activityIdList) do
			if self:checkIsSameAct(v, jumpActId) then
				self._defaultTabIdx = i

				break
			end
		end
	end

	local defaultActId = self.activityIdList[self._defaultTabIdx]
	local checkStatusFunc = self["checkStatusFunc" .. defaultActId]
	local status = checkStatusFunc and checkStatusFunc() or ActivityHelper.getActivityStatus(defaultActId)

	if status == ActivityEnum.ActivityStatus.Expired then
		for i = 1, #self.activityIdList do
			local actList = self.activityIdList[i]
			local actId = self:getActId(actList)
			local status = ActivityHelper.getActivityStatus(actId)

			if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock or status == ActivityEnum.ActivityStatus.NotOpen then
				self._defaultTabIdx = i

				break
			end
		end
	end
end

function VersionActivityEnterBaseViewWithList:onOpenFinish()
	if self.viewParam then
		if self.viewParam then
			self:clickTargetActivityItem(self.viewParam)
		end

		self:checkTabRedDot()
	end
end

function VersionActivityEnterBaseViewWithList:onClose()
	UIBlockMgr.instance:endBlock(self.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:clearTimerTask()
	TaskDispatcher.cancelTask(self.onOpenAnimationDone, self)
end

function VersionActivityEnterBaseViewWithList:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function VersionActivityEnterBaseViewWithList:onDestroyView()
	for _, activityItem in ipairs(self.activityItemList) do
		activityItem.click:RemoveClickListener()
	end
end

function VersionActivityEnterBaseViewWithList:addActivityStateEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self.checkActivity, self)
end

function VersionActivityEnterBaseViewWithList:checkActivity(actId)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName, {
		ViewName.GMToolView
	}) then
		return
	end

	self:checkCurActivityIsEnd()
end

function VersionActivityEnterBaseViewWithList:checkActivityIsEnd(actId)
	if string.nilorempty(actId) or actId == 0 then
		return
	end

	local checkStatusFunc = self["checkStatusFunc" .. actId]
	local status = checkStatusFunc and checkStatusFunc(actId) or ActivityHelper.getActivityStatus(actId)

	return status == ActivityEnum.ActivityStatus.Expired
end

function VersionActivityEnterBaseViewWithList:doActivityShow()
	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
end

function VersionActivityEnterBaseViewWithList:checkCurActivityIsEnd()
	if self:checkActivityIsEnd(self._curActId) then
		local status = ActivityHelper.getActivityStatus(self._curActId)

		self:doActivityShow()
	end
end

function VersionActivityEnterBaseViewWithList:initActivityItemList()
	for i = 1, #self.activityIdList do
		local actList = self.activityIdList[i]
		local actId = self:getActId(actList)
		local activityItemGo = gohelper.cloneInPlace(self._goActivityItem, actId)

		gohelper.setActive(activityItemGo, true)

		local activityItem = self:createActivityItem(i, actId, activityItemGo)

		activityItem.actList = actList
		self.activityItemList[#self.activityItemList + 1] = activityItem
		self.activityItemDict[actId] = activityItem
	end
end

function VersionActivityEnterBaseViewWithList:createActivityItem(index, actId, goActivityContainer)
	local activityItem = VersionActivityEnterViewTabItem.New()

	activityItem:init(index, actId, goActivityContainer)
	activityItem:setClickFunc(self._activityItemOnClick, self)
	self:onCreateActivityItem(activityItem)

	return activityItem
end

function VersionActivityEnterBaseViewWithList:onCreateActivityItem(activityItem)
	return
end

function VersionActivityEnterBaseViewWithList:getActivityItems(actId)
	local items

	for _, activityItem in ipairs(self.activityItemList) do
		if activityItem.actId == actId then
			items = items or {}

			table.insert(items, activityItem)
		end
	end

	return items
end

function VersionActivityEnterBaseViewWithList:_selectActivityItem(selectTabId, focusScroll, isDefaultSelect)
	if self._curTabIdx == selectTabId then
		return
	end

	self._curTabIdx = selectTabId

	local activityItem = self.activityItemList[selectTabId]

	self._curActId = activityItem.actId

	local actInfoMo = ActivityModel.instance:getActivityInfo()[activityItem.actId]
	local activityId = activityItem.actId

	ActivityEnterMgr.instance:enterActivity(activityId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		activityId
	})
	self:setSelectActId(activityId)
	activityItem:refreshActivityItemTag()
	activityItem:refreshTimeInfo()
	self:onRefreshTabView(selectTabId, isDefaultSelect)

	if focusScroll then
		self:onFocusToTab(activityItem)
	end

	self.viewContainer:selectActTab(selectTabId, activityId)
end

function VersionActivityEnterBaseViewWithList:refreshCurItemView()
	local selectTabId = self._curTabIdx
	local activityItem = self.activityItemList[selectTabId]
	local actInfoMo = ActivityModel.instance:getActMO(activityItem.actId)
	local activityId = activityItem.actId

	self._curActId = activityId

	ActivityEnterMgr.instance:enterActivity(activityId)
	self:setSelectActId(activityId)
	activityItem:refreshActivityItemTag()

	if activityItem.showTag == ShowActTagEnum.ShowNewAct or activityItem.showTag == ShowActTagEnum.ShowNewStage then
		self:playActTagAnimation(activityItem)
	end

	self:onRefreshTabView(selectTabId)
	self.viewContainer:selectActTab(selectTabId, activityId)
end

function VersionActivityEnterBaseViewWithList:onFocusToTab(activityItem)
	return
end

function VersionActivityEnterBaseViewWithList:setSelectActId(actId)
	return
end

function VersionActivityEnterBaseViewWithList:onRefreshTabView(selectTabId)
	self._entranceAnimator:Play(UIAnimationName.Open, 0, 0)
end

function VersionActivityEnterBaseViewWithList:_activityItemOnClick(activityItem)
	if activityItem.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	local checkFunc = self["checkActivityCanClickFunc" .. activityItem.actId]

	checkFunc = checkFunc or self.defaultCheckActivityClick

	if not checkFunc(self, activityItem) then
		return
	end

	local clickCallback = self["onClickActivity" .. activityItem.actId]

	if clickCallback then
		clickCallback(self)
	end

	self:_selectActivityItem(activityItem.index)
	self:refreshAllTabSelectState()
end

function VersionActivityEnterBaseViewWithList:defaultCheckActivityClick(activityItem)
	local actId = activityItem.actId
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(actId)

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

function VersionActivityEnterBaseViewWithList:CheckActivityStatusClickAble(status)
	self._activtiyStatusClickAble = self._activtiyStatusClickAble or {
		[ActivityEnum.ActivityStatus.Normal] = true,
		[ActivityEnum.ActivityStatus.NotUnlock] = true
	}

	return self._activtiyStatusClickAble[status]
end

function VersionActivityEnterBaseViewWithList.openActItemSortFunc(actId1, actId2)
	local act1Info = ActivityModel.instance:getActMO(actId1)
	local act2Info = ActivityModel.instance:getActMO(actId2)
	local displayOrder1 = act1Info.config.displayPriority
	local displayOrder2 = act2Info.config.displayPriority

	if displayOrder1 ~= displayOrder2 then
		return displayOrder1 < displayOrder2
	end

	local act1OpenTime = act1Info:getRealStartTimeStamp()
	local act2OpenTime = act2Info:getRealStartTimeStamp()

	if act1OpenTime ~= act2OpenTime then
		return act2OpenTime < act1OpenTime
	end

	return actId1 < actId2
end

function VersionActivityEnterBaseViewWithList.noOpenActItemSortFunc(actId1, actId2)
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

function VersionActivityEnterBaseViewWithList:beforeClickHome()
	self.clickedHome = true
end

function VersionActivityEnterBaseViewWithList:checkNeedRefreshUI()
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName, {
		ViewName.GMToolView
	}) then
		return
	end

	if self.clickedHome then
		return
	end

	self:refreshUI()
	ActivityStageHelper.recordActivityStage(self.activityIdList)
end

function VersionActivityEnterBaseViewWithList:refreshUI()
	self:refreshActivityUI()
	self:refreshItemSiblingAndActive()
end

function VersionActivityEnterBaseViewWithList:refreshActivityUI()
	self.playedActTagAudio = false
	self.playedActUnlockAudio = false

	local changeDict, removeList

	for _, activityItem in ipairs(self.activityItemList) do
		local actId = self:getActId(activityItem.actList)

		if actId == activityItem.actId then
			self:refreshActivityItem(activityItem)
		else
			if not changeDict then
				changeDict = {}
				removeList = {}
			end

			table.insert(removeList, activityItem.actId)

			changeDict[actId] = activityItem

			self:changeActivityItem(activityItem, actId)
		end
	end

	if removeList then
		for i, v in ipairs(removeList) do
			self.activityItemDict[v] = nil
		end
	end

	if changeDict then
		for k, v in pairs(changeDict) do
			self.activityItemDict[k] = v
		end

		if changeDict[self._curActId] then
			self:refreshCurItemView()
		end
	end
end

function VersionActivityEnterBaseViewWithList:clickTargetActivityItem(actId)
	if not actId and not ActivityModel.instance:getActMO(actId) then
		return
	end

	for key, activityItem in pairs(self.activityItemList) do
		if activityItem.actId == actId then
			self:_activityItemOnClick(activityItem)
		end
	end
end

function VersionActivityEnterBaseViewWithList:changeActivityItem(activityItem, actId)
	activityItem.actId = actId

	local activityCo = ActivityConfig.instance:getActivityCo(actId)

	activityItem.openId = activityCo and activityCo.openId
	activityItem.redDotId = activityCo and activityCo.redDotId

	self:refreshActivityItem(activityItem)
end

function VersionActivityEnterBaseViewWithList:refreshItemSiblingAndActive()
	local activeActList = {}
	local noOpenActList = {}
	local hideActList = {}

	for actId, v in pairs(self.activityItemDict) do
		local checkStatusFunc = self["checkStatusFunc" .. actId]
		local status = checkStatusFunc and checkStatusFunc(actId) or ActivityHelper.getActivityStatus(actId)

		if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
			table.insert(activeActList, actId)
		elseif status == ActivityEnum.ActivityStatus.NotOpen then
			table.insert(noOpenActList, actId)
		else
			table.insert(hideActList, actId)
		end
	end

	table.sort(activeActList, self.openActItemSortFunc)

	for i = 1, #activeActList do
		local actId = activeActList[i]
		local activityItem = self.activityItemDict[actId]

		gohelper.setSibling(activityItem.rootGo, i)
		gohelper.setActive(activityItem.rootGo, true)
	end

	gohelper.setSibling(self._goActivityOpeningTitle, #activeActList + 1)
	gohelper.setActive(self._goActivityOpeningTitle, #noOpenActList > 0)
	table.sort(noOpenActList, self.noOpenActItemSortFunc)

	for i = 1, #noOpenActList do
		local actId = noOpenActList[i]
		local activityItem = self.activityItemDict[actId]

		gohelper.setSibling(activityItem.rootGo, #activeActList + 1 + i)
		gohelper.setActive(activityItem.rootGo, true)
	end

	for i = 1, #hideActList do
		local actId = hideActList[i]
		local activityItem = self.activityItemDict[actId]

		gohelper.setActive(activityItem.rootGo, false)
	end

	self.showItemNum = #activeActList + #noOpenActList
end

function VersionActivityEnterBaseViewWithList:refreshActivityItem(activityItem)
	if activityItem.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	local actInfoMo = ActivityModel.instance:getActivityInfo()[activityItem.actId]

	if not actInfoMo then
		return
	end

	local activityStatus = ActivityHelper.getActivityStatus(activityItem.actId)

	activityItem:refreshActivityItemTag()

	if activityItem.showTag == ShowActTagEnum.ShowNewAct or activityItem.showTag == ShowActTagEnum.ShowNewStage then
		self:playActTagAnimation(activityItem)
	end

	if activityItem.actId == V1a6_CachotEnum.ActivityId and V1a6_CachotModel.instance:isOnline() then
		V1a6_CachotController.instance:checkRogueStateInfo()
	end

	activityItem:refreshTimeInfo()
	activityItem:refreshNameText()
	activityItem:addRedDot()
	self:onRefreshActivityTabIcon(activityItem)

	local refreshUICallback = self["onRefreshActivity" .. activityItem.index]

	if refreshUICallback then
		refreshUICallback(self, activityItem)
	end
end

function VersionActivityEnterBaseViewWithList:refreshActvityItemsTimeInfo()
	for actId, item in pairs(self.activityItemDict) do
		item:refreshTimeInfo()
	end
end

function VersionActivityEnterBaseViewWithList:onRefreshActivityTabIcon(activityItem)
	return
end

function VersionActivityEnterBaseViewWithList:_setCanvasGroupAlpha(canvas, alpha)
	if canvas then
		canvas.alpha = alpha
	end
end

function VersionActivityEnterBaseViewWithList:refreshAllTabSelectState()
	for _, activityItem in ipairs(self.activityItemList) do
		local tabIdx = activityItem.index
		local select = tabIdx == self._curTabIdx

		activityItem:refreshSelectState(select)
		self:refreshTabSelectState(activityItem, select)
	end
end

function VersionActivityEnterBaseViewWithList:refreshTabSelectState(activityItem, select)
	return
end

function VersionActivityEnterBaseViewWithList:playOpenAnimation()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(self.viewName .. "playOpenAnimation")

	if self.skipOpenAnim then
		self:onOpenAnimationDone()
	else
		self._entranceAnimator:Play(UIAnimationName.Open, 0, 0)
		self._categoryAnimator:Play(UIAnimationName.Open, 0, 0)
		self:onPlayOpenAnimation()
		TaskDispatcher.runDelay(self.onOpenAnimationDone, self, 0.3)
	end
end

function VersionActivityEnterBaseViewWithList:onPlayOpenAnimation()
	return
end

function VersionActivityEnterBaseViewWithList:onOpenAnimationDone()
	UIBlockMgr.instance:endBlock(self.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self.onOpening = false

		return
	end

	self:playAllNewTagAnimation()

	self.onOpening = false
end

function VersionActivityEnterBaseViewWithList:playAllNewTagAnimation()
	if self.needPlayNewActTagActIdList then
		for _, actId in ipairs(self.needPlayNewActTagActIdList) do
			self:_playActTagAnimations(self:getActivityItems(actId))
		end

		self.needPlayNewActTagActIdList = nil
	end
end

function VersionActivityEnterBaseViewWithList:refreshAllNewActOpenTagUI()
	for _, activityItem in ipairs(self.activityItemList) do
		local activityStatus = ActivityHelper.getActivityStatus(activityItem.actId)
		local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(activityItem.goRedPointTag, isNormalStatus)
		gohelper.setActive(activityItem.goRedPointTagNewAct, isNormalStatus and not ActivityEnterMgr.instance:isEnteredActivity(activityItem.actId))
	end
end

function VersionActivityEnterBaseViewWithList:isPlayedActTagAnimation(actId)
	if not self.playedNewActTagAnimationIdList then
		return false
	end

	return tabletool.indexOf(self.playedNewActTagAnimationIdList, actId)
end

function VersionActivityEnterBaseViewWithList:playActTagAnimation(activityItem)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if self.onOpening then
		self.needPlayNewActTagActIdList = self.needPlayNewActTagActIdList or {}

		if not tabletool.indexOf(self.needPlayNewActTagActIdList, activityItem.actId) then
			table.insert(self.needPlayNewActTagActIdList, activityItem.actId)
		end
	else
		self:_playActTagAnimation(activityItem)
	end
end

function VersionActivityEnterBaseViewWithList:_playActTagAnimations(activityItems)
	if not activityItems then
		return
	end

	for k, v in pairs(activityItems) do
		self:_playActTagAnimation(v)
	end
end

function VersionActivityEnterBaseViewWithList:_playActTagAnimation(activityItem)
	if activityItem.showTag == ShowActTagEnum.ShowNewAct then
		gohelper.setActive(activityItem.newActivityFlags.select, true)
		gohelper.setActive(activityItem.newActivityFlags.normal, true)
	elseif activityItem.showTag == ShowActTagEnum.ShowNewStage then
		gohelper.setActive(activityItem.newEpisodeFlags.select, true)
		gohelper.setActive(activityItem.newEpisodeFlags.normal, true)
	end

	self.playedNewActTagAnimationIdList = self.playedNewActTagAnimationIdList or {}

	if not activityItem.redPointTagAnimator then
		table.insert(self.playedNewActTagAnimationIdList, activityItem.actId)

		return
	end

	if not self:isPlayedActTagAnimation(activityItem.actId) then
		activityItem.redPointTagAnimator:Play(UIAnimationName.Open)
		table.insert(self.playedNewActTagAnimationIdList, activityItem.actId)

		if not self.playedActTagAudio and not self.onOpening then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_open)

			self.playedActTagAudio = true
		end
	end
end

function VersionActivityEnterBaseViewWithList:checkTabRedDot()
	local activityItemList = self.activityItemList

	if not activityItemList then
		return
	end

	self._redDotItems = {}

	for _, actItem in ipairs(activityItemList) do
		local status = ActivityHelper.getActivityStatus(actItem.actId)
		local showItem = status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotOpen or status == ActivityEnum.ActivityStatus.NotUnlock
		local redDotInfoGroup = RedDotModel.instance:getRedDotInfo(actItem.redDotId)

		if showItem and redDotInfoGroup and redDotInfoGroup.infos then
			for _, info in pairs(redDotInfoGroup.infos) do
				if info.value > 0 then
					self._redDotItems[#self._redDotItems + 1] = actItem
				end
			end
		end
	end
end

function VersionActivityEnterBaseViewWithList:addPerSecondRefresh()
	TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
end

function VersionActivityEnterBaseViewWithList:everySecondCall()
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName, {
		ViewName.GMToolView
	}) then
		return
	end

	self:refreshActvityItemsTimeInfo()
	self:checkCurActivityIsEnd()
end

function VersionActivityEnterBaseViewWithList:addPerMinuteRefresh()
	local serverTime = ServerTime.now()
	local second = math.floor(serverTime % TimeUtil.OneMinuteSecond)

	if second > 0 then
		TaskDispatcher.runDelay(self._addPerMinuteRefresh, self, TimeUtil.OneMinuteSecond - second + 1)
	else
		self:_addPerMinuteRefresh()
	end
end

function VersionActivityEnterBaseViewWithList:_addPerMinuteRefresh()
	self:everyMinuteCall()
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
end

function VersionActivityEnterBaseViewWithList:everyMinuteCall()
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	self:refreshUI()
end

function VersionActivityEnterBaseViewWithList:clearTimerTask()
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
	TaskDispatcher.cancelTask(self._addPerMinuteRefresh, self)
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivityEnterBaseViewWithList:checkIsSameAct(t, actId)
	if type(t) == "table" then
		for _, v in ipairs(t) do
			if v == actId then
				return true
			end
		end

		return false
	end

	return t == actId
end

function VersionActivityEnterBaseViewWithList:getActId(t)
	if type(t) == "table" then
		for _, v in ipairs(t) do
			local status = ActivityHelper.getActivityStatus(v)

			if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
				return v
			end
		end

		return t[1]
	end

	return t
end

return VersionActivityEnterBaseViewWithList
