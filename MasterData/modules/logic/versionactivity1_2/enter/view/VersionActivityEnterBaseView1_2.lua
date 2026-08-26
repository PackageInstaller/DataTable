-- chunkname: @modules/logic/versionactivity1_2/enter/view/VersionActivityEnterBaseView1_2.lua

module("modules.logic.versionactivity1_2.enter.view.VersionActivityEnterBaseView1_2", package.seeall)

local VersionActivityEnterBaseView1_2 = class("VersionActivityEnterBaseView1_2", BaseView)

VersionActivityEnterBaseView1_2.ShowActTagEnum = {
	ShowNewStage = 1,
	ShowNewAct = 0
}

function VersionActivityEnterBaseView1_2:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "logo/#txt_time")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "logo/#txt_remaintime")
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
end

function VersionActivityEnterBaseView1_2:addEvents()
	self._btnreplay:AddClickListener(self._btnReplayOnClick, self)
end

function VersionActivityEnterBaseView1_2:removeEvents()
	self._btnreplay:RemoveClickListener()
end

VersionActivityEnterBaseView1_2.ActUnlockAnimationDuration = 2

function VersionActivityEnterBaseView1_2:_btnReplayOnClick()
	local activityMo = ActivityModel.instance:getActMO(self.actId)

	if activityMo then
		::label_4_0::

		local var_4_0 = activityMo.config

		if activityMo.config then
			local storyId = activityMo.config.storyId

			if not storyId then
				logError(string.format("act id %s dot config story id", storyId))

				return
			end

			StoryController.instance:playStory(storyId, nil, nil, nil, {
				isVersionActivityPV = true
			})
		end
	end
end

function VersionActivityEnterBaseView1_2:defaultCheckActivityCanClick(activityItem)
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(activityItem.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return true
end

function VersionActivityEnterBaseView1_2:_activityBtnOnClick(activityItem)
	if activityItem.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	local checkFunc = self["checkActivityCanClickFunc" .. activityItem.index]

	checkFunc = checkFunc or self.defaultCheckActivityCanClick

	if not checkFunc(self, activityItem) then
		return
	end

	if activityItem.audioId then
		AudioMgr.instance:trigger(activityItem.audioId)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)
	end

	local clickCallback = self["onClickActivity" .. activityItem.index]

	if clickCallback then
		clickCallback(self)
	end
end

function VersionActivityEnterBaseView1_2:initActivityItem(index, actId, goActivityContainer)
	local activityItem = self:getUserDataTb_()

	activityItem.index = index
	activityItem.actId = actId
	activityItem.rootGo = goActivityContainer
	activityItem.activityCo = ActivityConfig.instance:getActivityCo(actId)
	activityItem.openId = activityItem.activityCo and activityItem.activityCo.openId
	activityItem.redDotId = activityItem.activityCo and activityItem.activityCo.redDotId
	activityItem.goNormal = gohelper.findChild(goActivityContainer, "normal")
	activityItem.imageNormal = gohelper.findChildImage(goActivityContainer, "normal/bg")
	activityItem.txtActivityName = gohelper.findChildText(goActivityContainer, "normal/txt_actname")
	activityItem.goLockContainer = gohelper.findChild(goActivityContainer, "lockContainer")
	activityItem.goDefaultLock = gohelper.findChild(goActivityContainer, "lockContainer/go_defaultlock")
	activityItem.txtLock = gohelper.findChildText(goActivityContainer, "lockContainer/go_defaultlock/txt_lock")
	activityItem.goLockSuo = gohelper.findChild(goActivityContainer, "lockContainer/go_defaultlock/suo_icon")
	activityItem.goRedPoint = gohelper.findChild(goActivityContainer, "redpoint")
	activityItem.goRedPointTag = gohelper.findChild(goActivityContainer, "tag")
	activityItem.goRedPointTagNewAct = gohelper.findChild(goActivityContainer, "tag/new_act")
	activityItem.goRedPointTagNewEpisode = gohelper.findChild(goActivityContainer, "tag/new_episode")
	activityItem.goTime = gohelper.findChild(goActivityContainer, "timeContainer")
	activityItem.txtTime = gohelper.findChildText(goActivityContainer, "timeContainer/time")
	activityItem.txtRemainTime = gohelper.findChildText(goActivityContainer, "timeContainer/remain_time")
	activityItem.click = gohelper.findChildClick(goActivityContainer, "clickarea")

	activityItem.click:AddClickListener(self._activityBtnOnClick, self, activityItem)
	gohelper.setActive(activityItem.goRedPointTag, true)
	gohelper.setActive(activityItem.goRedPointTagNewAct, false)
	gohelper.setActive(activityItem.goRedPointTagNewEpisode, false)
	gohelper.setActive(activityItem.goDefaultLock, true)

	activityItem.redPointTagAnimator = activityItem.goRedPointTag and activityItem.goRedPointTag:GetComponent(typeof(UnityEngine.Animator))

	return activityItem
end

function VersionActivityEnterBaseView1_2:_editableInitView()
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.activityGoContainerList = {}
	self.activityItemList = {}
	self.playedNewActTagAnimationIdList = nil

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.checkNeedRefreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.checkNeedRefreshUI, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self.refreshAllNewActOpenTagUI, self)
	self.addEventCb(self, NavigateMgr.instance, NavigateEvent.BeforeClickHome, self.beforeClickHome, self)
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
end

function VersionActivityEnterBaseView1_2:beforeClickHome()
	self.clickedHome = true
end

function VersionActivityEnterBaseView1_2:checkNeedRefreshUI()
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if self.clickedHome then
		return
	end

	self:refreshUI()
	ActivityStageHelper.recordActivityStage(self.activityIdList)
end

function VersionActivityEnterBaseView1_2:initViewParam()
	self.actId = self.viewParam.actId
	self.skipOpenAnim = self.viewParam.skipOpenAnim
	self.activityIdList = self.viewParam.activityIdList
end

function VersionActivityEnterBaseView1_2:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function VersionActivityEnterBaseView1_2:onOpen()
	self.onOpening = true

	self:initViewParam()
	self:initActivityNode()
	self:initActivityItemList()
	self:initActivityName()
	self:refreshUI()
	self:playOpenAnimation()
end

function VersionActivityEnterBaseView1_2:initActivityNode()
	local goContainer

	for i = 1, #self.activityIdList do
		goContainer = self.activityGoContainerList[i]

		if not self.activityGoContainerList[i] then
			goContainer = gohelper.findChild(self.viewGO, "entrance/activityContainer" .. i)

			if gohelper.isNil(goContainer) then
				logError("not found container node : entrance/activityContainer" .. i)
			end

			table.insert(self.activityGoContainerList, goContainer)
		end

		gohelper.setActive(goContainer, true)
	end

	for i = #self.activityIdList + 1, #self.activityGoContainerList do
		gohelper.setActive(self.activityGoContainerList[i], false)
	end
end

function VersionActivityEnterBaseView1_2:initActivityItemList()
	for i = 1, #self.activityIdList do
		table.insert(self.activityItemList, self:initActivityItem(i, self.activityIdList[i], self.activityGoContainerList[i]))
	end
end

function VersionActivityEnterBaseView1_2:initActivityName()
	for _, activityItem in ipairs(self.activityItemList) do
		activityItem.txtActivityName.text = activityItem.activityCo.name
	end
end

function VersionActivityEnterBaseView1_2:getVersionActivityItem(actId)
	for _, activityItem in ipairs(self.activityItemList) do
		if activityItem.actId == actId then
			return activityItem
		end
	end
end

function VersionActivityEnterBaseView1_2:playOpenAnimation()
	if self.skipOpenAnim then
		self.animator:Play(UIAnimationName.Idle)

		self.onOpening = false
	else
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(self.viewName .. "playOpenAnimation")
		AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_open)
		self.animator:Play(UIAnimationName.Open)
		TaskDispatcher.runDelay(self.onOpenAnimationDone, self, 2.167)
	end
end

function VersionActivityEnterBaseView1_2:refreshUI()
	self:refreshCenterActUI()
	self:refreshActivityUI()
end

function VersionActivityEnterBaseView1_2:refreshCenterActUI()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if self._txttime then
		self._txttime.text = string.format("<color=#578425>%s ~ %s(%s)</color>", actInfoMo:getStartTimeStr(), actInfoMo:getEndTimeStr(), ServerTime.GetUTCOffsetStr())
	end

	if self._txtremaintime then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
		local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
		local hourSecond = offsetSecond % TimeUtil.OneDaySecond
		local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
		local remainTime = day .. luaLang("time_day") .. hour .. luaLang("time_hour2")

		self._txtremaintime.text = string.format(luaLang("remain"), remainTime)
	end
end

function VersionActivityEnterBaseView1_2:refreshActivityUI()
	self.playedActTagAudio = false
	self.playedActUnlockAudio = false

	for _, activityItem in ipairs(self.activityItemList) do
		self:refreshActivityItem(activityItem)
	end
end

function VersionActivityEnterBaseView1_2:defaultBeforePlayActUnlockAnimation(activityItem)
	local circleGo = gohelper.findChild(activityItem.rootGo, "lockContainer/go_defaultlock/circle")

	gohelper.setActive(circleGo, false)
	gohelper.setActive(activityItem.txtLock.gameObject, false)
	gohelper.setActive(activityItem.goLockContainer, true)
	gohelper.setActive(activityItem.goDefaultLock, true)
end

function VersionActivityEnterBaseView1_2:refreshActivityItem(activityItem)
	if activityItem.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	local activityStatus = ActivityHelper.getActivityStatus(activityItem.actId)

	logNormal("act id : " .. activityItem.actId .. ", status : " .. activityStatus)

	local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

	if isNormalStatus and not VersionActivityBaseController.instance:isPlayedUnlockAnimation(activityItem.actId) then
		activityItem.lockAnimator = activityItem.goDefaultLock and activityItem.goDefaultLock:GetComponent(typeof(UnityEngine.Animator))

		if activityItem.lockAnimator then
			local beforeFunc = self["beforePlayActUnlockAnimationActivity" .. activityItem.index]

			beforeFunc = beforeFunc or self.defaultBeforePlayActUnlockAnimation

			beforeFunc(self, activityItem)
			self:playActUnlockAnimation(activityItem)
		else
			self:refreshLockUI(activityItem, activityStatus)
		end
	else
		self:refreshLockUI(activityItem, activityStatus)
	end

	self:refreshTimeContainer(activityItem, activityStatus)
	self:refreshRedDotContainer(activityItem, isNormalStatus)

	local refreshUICallback = self["onRefreshActivity" .. activityItem.index]

	if refreshUICallback then
		refreshUICallback(self, activityItem)
	end
end

function VersionActivityEnterBaseView1_2:refreshLockUI(activityItem, activityStatus)
	local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(activityItem.goLockContainer, not isNormalStatus)
	gohelper.setActive(activityItem.goLockSuo, activityStatus == ActivityEnum.ActivityStatus.NotOpen or activityStatus == ActivityEnum.ActivityStatus.NotUnlock)

	if not isNormalStatus and activityItem.txtLock then
		local lockText = ""

		if activityStatus == ActivityEnum.ActivityStatus.NotOpen then
			local actInfoMo = ActivityModel.instance:getActivityInfo()[activityItem.actId]

			lockText = string.format(luaLang("test_task_unlock_time"), actInfoMo:getRemainTimeStr2ByOpenTime())
		elseif activityStatus == ActivityEnum.ActivityStatus.Expired then
			lockText = luaLang("p_activityenter_finish")
		elseif activityStatus == ActivityEnum.ActivityStatus.NotUnlock then
			lockText = luaLang("p_versionactivitytripenter_lock")
		elseif activityStatus == ActivityEnum.ActivityStatus.NotOnLine then
			lockText = luaLang("p_activityenter_finish")
		elseif activityStatus == ActivityEnum.ActivityStatus.None then
			lockText = luaLang("p_activityenter_finish")
		end

		activityItem.txtLock.text = lockText
	end
end

function VersionActivityEnterBaseView1_2:refreshTimeContainer(activityItem, activityStatus)
	local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(activityItem.goTime, isNormalStatus)

	if not isNormalStatus then
		return
	end

	local actInfoMo = ActivityModel.instance:getActivityInfo()[activityItem.actId]

	if activityItem.txtTime then
		activityItem.txtTime.text = actInfoMo:getStartTimeStr() .. "~" .. actInfoMo:getEndTimeStr()
	end

	if activityItem.txtRemainTime then
		activityItem.txtRemainTime.text = isNormalStatus and string.format(luaLang("remain"), actInfoMo:getRemainTimeStr2ByEndTime()) or ""
	end
end

function VersionActivityEnterBaseView1_2:refreshRedDotContainer(activityItem, isNormalStatus)
	if isNormalStatus and activityItem.redDotId and activityItem.redDotId ~= 0 then
		RedDotController.instance:addRedDot(activityItem.goRedPoint, activityItem.redDotId)
	end

	self:refreshRedDotTag(activityItem, isNormalStatus)
end

function VersionActivityEnterBaseView1_2:refreshRedDotTag(activityItem, isNormalStatus)
	gohelper.setActive(activityItem.goRedPointTag, isNormalStatus)
	gohelper.setActive(activityItem.goRedPointTagNewAct, false)
	gohelper.setActive(activityItem.goRedPointTagNewEpisode, false)

	activityItem.showTag = nil

	if isNormalStatus then
		local isShowNewAct = not ActivityEnterMgr.instance:isEnteredActivity(activityItem.actId)

		if isShowNewAct then
			activityItem.showTag = VersionActivityEnterBaseView1_2.ShowActTagEnum.ShowNewAct

			self:playActTagAnimation(activityItem)
		else
			local actInfoMo = ActivityModel.instance:getActivityInfo()[activityItem.actId]

			if actInfoMo:isNewStageOpen() then
				activityItem.showTag = VersionActivityEnterBaseView1_2.ShowActTagEnum.ShowNewStage

				self:playActTagAnimation(activityItem)
			end
		end
	end
end

function VersionActivityEnterBaseView1_2:refreshAllNewActOpenTagUI()
	for _, activityItem in ipairs(self.activityItemList) do
		local activityStatus = ActivityHelper.getActivityStatus(activityItem.actId)
		local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(activityItem.goRedPointTag, isNormalStatus)
		gohelper.setActive(activityItem.goRedPointTagNewAct, isNormalStatus and not ActivityEnterMgr.instance:isEnteredActivity(activityItem.actId))
	end
end

function VersionActivityEnterBaseView1_2:isPlayedActTagAnimation(actId)
	if not self.playedNewActTagAnimationIdList then
		return false
	end

	return tabletool.indexOf(self.playedNewActTagAnimationIdList, actId)
end

function VersionActivityEnterBaseView1_2:playActTagAnimation(activityItem)
	if self.onOpening or self.playingUnlockAnimation then
		self.needPlayNewActTagActIdList = self.needPlayNewActTagActIdList or {}

		if not tabletool.indexOf(self.needPlayNewActTagActIdList, activityItem.actId) then
			table.insert(self.needPlayNewActTagActIdList, activityItem.actId)
		end
	else
		self:_playActTagAnimation(activityItem)
	end
end

function VersionActivityEnterBaseView1_2:_playActTagAnimation(activityItem)
	if activityItem.showTag == VersionActivityEnterBaseView1_2.ShowActTagEnum.ShowNewAct then
		gohelper.setActive(activityItem.goRedPointTagNewAct, true)
	elseif activityItem.showTag == VersionActivityEnterBaseView1_2.ShowActTagEnum.ShowNewStage then
		gohelper.setActive(activityItem.goRedPointTagNewEpisode, true)
	end

	self.playedNewActTagAnimationIdList = self.playedNewActTagAnimationIdList or {}

	if not activityItem.redPointTagAnimator then
		table.insert(self.playedNewActTagAnimationIdList, activityItem.actId)

		return
	end

	if not self:isPlayedActTagAnimation(activityItem.actId) then
		activityItem.redPointTagAnimator:Play(UIAnimationName.Open)
		table.insert(self.playedNewActTagAnimationIdList, activityItem.actId)

		if not self.playedActTagAudio then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_open)

			self.playedActTagAudio = true
		end
	end
end

function VersionActivityEnterBaseView1_2:playActUnlockAnimation(activityItem)
	if self.onOpening then
		self.needPlayUnlockAnimationActIdList = self.needPlayUnlockAnimationActIdList or {}

		if not tabletool.indexOf(self.needPlayUnlockAnimationActIdList, activityItem.actId) then
			table.insert(self.needPlayUnlockAnimationActIdList, activityItem.actId)
		end
	else
		self:_playActUnlockAnimation(activityItem)
	end
end

function VersionActivityEnterBaseView1_2:_playActUnlockAnimation(activityItem)
	if not activityItem then
		return
	end

	VersionActivityBaseController.instance:playedActivityUnlockAnimation(activityItem.actId)

	if activityItem.lockAnimator then
		activityItem.lockAnimator:Play(UIAnimationName.Open, 0, 0)
		self:playTimeUnlock(activityItem)

		if not self.playedActUnlockAudio then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_level_unlock)

			self.playedActUnlockAudio = true
		end

		self.playingUnlockAnimation = true

		TaskDispatcher.runDelay(self.playUnlockAnimationDone, self, VersionActivityEnterBaseView1_2.ActUnlockAnimationDuration)
	end
end

function VersionActivityEnterBaseView1_2:playTimeUnlock(activityItem)
	activityItem.timeAnimator = activityItem.goTime and activityItem.goTime:GetComponent(typeof(UnityEngine.Animator))

	if activityItem.timeAnimator then
		self.needPlayTimeUnlockList = self.needPlayTimeUnlockList or {}

		if not tabletool.indexOf(self.needPlayTimeUnlockList, activityItem) then
			table.insert(self.needPlayTimeUnlockList, activityItem)
		end
	end
end

function VersionActivityEnterBaseView1_2:playAllTimeUnlockAnimation()
	if self.needPlayTimeUnlockList then
		for _, activityItem in ipairs(self.needPlayTimeUnlockList) do
			if activityItem.timeAnimator then
				gohelper.setActive(activityItem.goTime, true)
				activityItem.timeAnimator:Play(UIAnimationName.Open, 0, 0)
			end
		end
	end
end

function VersionActivityEnterBaseView1_2:playUnlockAnimationDone()
	self.playingUnlockAnimation = false

	self:playAllTimeUnlockAnimation()
	self:playAllNewTagAnimation()
end

function VersionActivityEnterBaseView1_2:onOpenAnimationDone()
	UIBlockMgr.instance:endBlock(self.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)

	self.onOpening = false

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self.needPlayUnlockAnimationActIdList = nil

		return
	end

	if self.needPlayUnlockAnimationActIdList then
		for _, actId in ipairs(self.needPlayUnlockAnimationActIdList) do
			self:_playActUnlockAnimation(self:getVersionActivityItem(actId))
		end

		self.needPlayUnlockAnimationActIdList = nil
	end

	if not self.playingUnlockAnimation then
		self:playAllNewTagAnimation()
	end
end

function VersionActivityEnterBaseView1_2:playAllNewTagAnimation()
	if self.needPlayNewActTagActIdList then
		for _, actId in ipairs(self.needPlayNewActTagActIdList) do
			self:_playActTagAnimation(self:getVersionActivityItem(actId))
		end

		self.needPlayNewActTagActIdList = nil
	end
end

function VersionActivityEnterBaseView1_2:everyMinuteCall()
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	self:refreshUI()
end

function VersionActivityEnterBaseView1_2:onClose()
	UIBlockMgr.instance:endBlock(self.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
	TaskDispatcher.cancelTask(self.onOpenAnimationDone, self)
	TaskDispatcher.cancelTask(self.playUnlockAnimationDone, self)
end

function VersionActivityEnterBaseView1_2:onDestroyView()
	for _, activityItem in ipairs(self.activityItemList) do
		activityItem.click:RemoveClickListener()
	end
end

return VersionActivityEnterBaseView1_2
