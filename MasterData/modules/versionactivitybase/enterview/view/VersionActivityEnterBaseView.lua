-- chunkname: @modules/versionactivitybase/enterview/view/VersionActivityEnterBaseView.lua

module("modules.versionactivitybase.enterview.view.VersionActivityEnterBaseView", package.seeall)

local VersionActivityEnterBaseView = class("VersionActivityEnterBaseView", BaseView)

VersionActivityEnterBaseView.ShowActTagEnum = {
	ShowNewStage = 1,
	ShowNewAct = 0
}

function VersionActivityEnterBaseView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "logo/#txt_time")
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
end

function VersionActivityEnterBaseView:addEvents()
	self._btnreplay:AddClickListener(self._btnReplayOnClick, self)
end

function VersionActivityEnterBaseView:removeEvents()
	self._btnreplay:RemoveClickListener()
end

VersionActivityEnterBaseView.ActUnlockAnimationDuration = 2

function VersionActivityEnterBaseView:_btnReplayOnClick()
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

			local param = {}

			param.isVersionActivityPV = true

			StoryController.instance:playStory(storyId, param)
		end
	end
end

function VersionActivityEnterBaseView:defaultCheckActivityCanClick(activityItem)
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

function VersionActivityEnterBaseView:_activityBtnOnClick(activityItem)
	if activityItem.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	local checkFunc = self["checkActivityCanClickFunc" .. activityItem.index]

	checkFunc = checkFunc or self.defaultCheckActivityCanClick

	if not checkFunc(self, activityItem) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	local clickCallback = self["onClickActivity" .. activityItem.index]

	if clickCallback then
		clickCallback(self, activityItem.actId)
	end

	ActivityEnterMgr.instance:enterActivity(activityItem.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		activityItem.actId
	})
end

function VersionActivityEnterBaseView:initActivityItem(index, actId, goActivityContainer)
	local activityItem = self:getUserDataTb_()

	activityItem.index = index
	activityItem.actId = actId
	activityItem.rootGo = goActivityContainer

	local activityCo = ActivityConfig.instance:getActivityCo(actId)

	activityItem.openId = activityCo and activityCo.openId
	activityItem.redDotId = activityCo and activityCo.redDotId
	activityItem.animator = activityItem.rootGo:GetComponent(typeof(UnityEngine.Animator))
	activityItem.goNormal = gohelper.findChild(goActivityContainer, "normal")
	activityItem.goNormalAnimator = activityItem.goNormal:GetComponent(typeof(UnityEngine.Animator))

	if activityItem.goNormalAnimator then
		activityItem.goNormalAnimator.enabled = false
	end

	activityItem.goNormalCanvas = activityItem.goNormal:GetComponent(typeof(UnityEngine.CanvasGroup))

	local normalAnimationPath = VersionActivityEnum.EnterViewNormalAnimationPath[actId]

	if normalAnimationPath then
		local goNormalAnimationNode = gohelper.findChild(goActivityContainer, normalAnimationPath)

		if goNormalAnimationNode then
			activityItem.normalAnimation = goNormalAnimationNode:GetComponent(typeof(UnityEngine.Animation))
		end
	end

	activityItem.txtActivityName = gohelper.findChildText(goActivityContainer, "normal/txt_Activity")
	activityItem.goLockContainer = gohelper.findChild(goActivityContainer, "lockContainer")
	activityItem.txtLockGo = gohelper.findChild(goActivityContainer, "lockContainer/lock")
	activityItem.txtLock = gohelper.findChildText(goActivityContainer, "lockContainer/lock/txt_lock")
	activityItem.goRedPoint = gohelper.findChild(goActivityContainer, "redpoint")
	activityItem.goRedPointTag = gohelper.findChild(goActivityContainer, "tag")
	activityItem.goRedPointTagNewAct = gohelper.findChild(goActivityContainer, "tag/new_act")
	activityItem.goRedPointTagNewEpisode = gohelper.findChild(goActivityContainer, "tag/new_episode")
	activityItem.goTime = gohelper.findChild(goActivityContainer, "timeContainer")
	activityItem.txtTime = gohelper.findChildText(goActivityContainer, "timeContainer/time")
	activityItem.txtRemainTime = gohelper.findChildText(goActivityContainer, "timeContainer/TimeBG/remain_time")
	activityItem.click = SLFramework.UGUI.ButtonWrap.Get(goActivityContainer)

	activityItem.click:AddClickListener(self._activityBtnOnClick, self, activityItem)
	gohelper.setActive(activityItem.goRedPointTag, true)
	gohelper.setActive(activityItem.goRedPointTagNewAct, false)
	gohelper.setActive(activityItem.goRedPointTagNewEpisode, false)

	activityItem.redPointTagAnimator = activityItem.goRedPointTag and activityItem.goRedPointTag:GetComponent(typeof(UnityEngine.Animator))

	return activityItem
end

function VersionActivityEnterBaseView:_editableInitView()
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.activityGoContainerList = {}
	self.activityItemList = {}
	self.playedNewActTagAnimationIdList = nil

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.checkNeedRefreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.checkNeedRefreshUI, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self.refreshAllNewActOpenTagUI, self)
	self.addEventCb(self, NavigateMgr.instance, NavigateEvent.BeforeClickHome, self.beforeClickHome, self)
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
	self:playBgm()
end

function VersionActivityEnterBaseView:beforeClickHome()
	self.clickedHome = true
end

function VersionActivityEnterBaseView:checkNeedRefreshUI()
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if self.clickedHome then
		return
	end

	self:refreshUI()
	ActivityStageHelper.recordActivityStage(self.activityIdList)
end

function VersionActivityEnterBaseView:initViewParam()
	self.actId = self.viewParam.actId
	self.skipOpenAnim = self.viewParam.skipOpenAnim
	self.activityIdList = self.viewParam.activityIdList
end

function VersionActivityEnterBaseView:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function VersionActivityEnterBaseView:onOpen()
	self.onOpening = true

	self:initViewParam()
	self:initActivityNode()
	self:initActivityItemList()
	self:refreshUI()
	self:playOpenAnimation()
end

function VersionActivityEnterBaseView:initActivityNode()
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

function VersionActivityEnterBaseView:initActivityItemList()
	for i = 1, #self.activityIdList do
		table.insert(self.activityItemList, self:initActivityItem(i, self.activityIdList[i], self.activityGoContainerList[i]))
	end
end

function VersionActivityEnterBaseView:getVersionActivityItems(actId)
	local items

	for _, activityItem in ipairs(self.activityItemList) do
		if activityItem.actId == actId then
			items = items or {}

			table.insert(items, activityItem)
		end
	end

	return items
end

function VersionActivityEnterBaseView:playOpenAnimation()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(self.viewName .. "playOpenAnimation")

	if self.skipOpenAnim then
		self.animator:Play(UIAnimationName.Idle)
		TaskDispatcher.runDelay(self.onOpenAnimationDone, self, 0.5)
	else
		AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_open)
		self.animator:Play(UIAnimationName.Open)
		TaskDispatcher.runDelay(self.onOpenAnimationDone, self, 2.167)
	end
end

function VersionActivityEnterBaseView:refreshUI()
	self:refreshCenterActUI()
	self:refreshActivityUI()
end

function VersionActivityEnterBaseView:refreshCenterActUI()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if self._txttime then
		self._txttime.text = actInfoMo:getStartTimeStr() .. " ~ " .. actInfoMo:getEndTimeStr()
	end
end

function VersionActivityEnterBaseView:refreshActivityUI()
	self.playedActTagAudio = false
	self.playedActUnlockAudio = false

	for _, activityItem in ipairs(self.activityItemList) do
		self:refreshActivityItem(activityItem)
	end
end

function VersionActivityEnterBaseView:_setCanvasGroupAlpha(canvas, alpha)
	if canvas then
		canvas.alpha = alpha
	end
end

function VersionActivityEnterBaseView:defaultBeforePlayActUnlockAnimation(activityItem)
	gohelper.setActive(activityItem.goTime, false)
	gohelper.setActive(activityItem.goLockContainer, true)
	self:_setCanvasGroupAlpha(activityItem.goNormalCanvas, 0.5)

	if activityItem.txtLockGo then
		gohelper.setActive(activityItem.txtLockGo, false)
	end
end

function VersionActivityEnterBaseView:refreshActivityItem(activityItem)
	if activityItem.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	local activityStatus = ActivityHelper.getActivityStatus(activityItem.actId)

	logNormal("act id : " .. activityItem.actId .. ", status : " .. activityStatus)

	local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal
	local actInfoMo = ActivityModel.instance:getActivityInfo()[activityItem.actId]

	if activityItem.normalAnimation then
		activityItem.normalAnimation.enabled = isNormalStatus
	end

	if isNormalStatus and not VersionActivityBaseController.instance:isPlayedUnlockAnimation(activityItem.actId) then
		activityItem.lockAnimator = activityItem.goLockContainer and activityItem.goLockContainer:GetComponent(typeof(UnityEngine.Animator))

		if not activityItem.lockAnimator then
			self:refreshLockUI(activityItem, activityStatus)
		else
			local beforeFunc = self["beforePlayActUnlockAnimationActivity" .. activityItem.index]

			beforeFunc = beforeFunc or self.defaultBeforePlayActUnlockAnimation

			beforeFunc(self, activityItem)
			self:playActUnlockAnimation(activityItem)
		end
	else
		self:refreshLockUI(activityItem, activityStatus)
	end

	if activityItem.animator then
		if activityStatus == ActivityEnum.ActivityStatus.Normal then
			activityItem.animator:Play(UIAnimationName.Loop)
		else
			activityItem.animator:Play(UIAnimationName.Idle)
		end
	end

	if activityItem.txtTime then
		activityItem.txtTime.text = actInfoMo:getStartTimeStr() .. "~" .. actInfoMo:getEndTimeStr()
	end

	if activityItem.txtRemainTime then
		activityItem.txtRemainTime.text = activityStatus == ActivityEnum.ActivityStatus.Normal and string.format(luaLang("remain"), actInfoMo:getRemainTimeStr2ByEndTime()) or ""
	end

	if activityItem.txtActivityName then
		activityItem.txtActivityName.text = actInfoMo.config.name
	end

	if isNormalStatus and activityItem.redDotId and activityItem.redDotId ~= 0 then
		RedDotController.instance:addRedDot(activityItem.goRedPoint, activityItem.redDotId)
	end

	gohelper.setActive(activityItem.goRedPointTag, isNormalStatus)
	gohelper.setActive(activityItem.goRedPointTagNewAct, false)
	gohelper.setActive(activityItem.goRedPointTagNewEpisode, false)

	activityItem.showTag = nil

	if isNormalStatus then
		local isShowNewAct = not ActivityEnterMgr.instance:isEnteredActivity(activityItem.actId)

		if isShowNewAct then
			activityItem.showTag = VersionActivityEnterBaseView.ShowActTagEnum.ShowNewAct

			self:playActTagAnimation(activityItem)
		elseif actInfoMo:isNewStageOpen() then
			activityItem.showTag = VersionActivityEnterBaseView.ShowActTagEnum.ShowNewStage

			self:playActTagAnimation(activityItem)
		end
	end

	local refreshUICallback = self["onRefreshActivity" .. activityItem.index]

	if refreshUICallback then
		refreshUICallback(self, activityItem)
	end
end

function VersionActivityEnterBaseView:refreshLockUI(activityItem, activityStatus)
	local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal
	local actInfoMo = ActivityModel.instance:getActivityInfo()[activityItem.actId]

	gohelper.setActive(activityItem.goLockContainer, not isNormalStatus)
	self:_setCanvasGroupAlpha(activityItem.goNormalCanvas, not isNormalStatus and 0.5 or 1)
	gohelper.setActive(activityItem.txtLockGo, not isNormalStatus)
	gohelper.setActive(activityItem.goTime, isNormalStatus)

	if not isNormalStatus and activityItem.txtLock then
		local lockText

		if activityStatus == ActivityEnum.ActivityStatus.NotOpen then
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

function VersionActivityEnterBaseView:refreshAllNewActOpenTagUI()
	for _, activityItem in ipairs(self.activityItemList) do
		local activityStatus = ActivityHelper.getActivityStatus(activityItem.actId)
		local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(activityItem.goRedPointTag, isNormalStatus)
		gohelper.setActive(activityItem.goRedPointTagNewAct, isNormalStatus and not ActivityEnterMgr.instance:isEnteredActivity(activityItem.actId))
	end
end

function VersionActivityEnterBaseView:isPlayedActTagAnimation(actId)
	if not self.playedNewActTagAnimationIdList then
		return false
	end

	return tabletool.indexOf(self.playedNewActTagAnimationIdList, actId)
end

function VersionActivityEnterBaseView:playActTagAnimation(activityItem)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if self.onOpening or self.playingUnlockAnimation then
		self.needPlayNewActTagActIdList = self.needPlayNewActTagActIdList or {}

		if not tabletool.indexOf(self.needPlayNewActTagActIdList, activityItem.actId) then
			table.insert(self.needPlayNewActTagActIdList, activityItem.actId)
		end
	else
		self:_playActTagAnimation(activityItem)
	end
end

function VersionActivityEnterBaseView:_playActTagAnimations(activityItems)
	if not activityItems then
		return
	end

	for k, v in pairs(activityItems) do
		self:_playActTagAnimation(v)
	end
end

function VersionActivityEnterBaseView:_playActTagAnimation(activityItem)
	if activityItem.showTag == VersionActivityEnterBaseView.ShowActTagEnum.ShowNewAct then
		gohelper.setActive(activityItem.goRedPointTagNewAct, true)
	elseif activityItem.showTag == VersionActivityEnterBaseView.ShowActTagEnum.ShowNewStage then
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

		if not self.playedActTagAudio and not self.onOpening then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_open)

			self.playedActTagAudio = true
		end
	end
end

function VersionActivityEnterBaseView:playActUnlockAnimation(activityItem)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if self.onOpening then
		self.needPlayUnlockAnimationActIdList = self.needPlayUnlockAnimationActIdList or {}

		if not tabletool.indexOf(self.needPlayUnlockAnimationActIdList, activityItem.actId) then
			table.insert(self.needPlayUnlockAnimationActIdList, activityItem.actId)
		end
	else
		self:_playActUnlockAnimation(activityItem)
	end
end

function VersionActivityEnterBaseView:_playActUnlockAnimations(activityItems)
	if not activityItems then
		return
	end

	for k, v in pairs(activityItems) do
		self:_playActUnlockAnimation(v)
	end
end

function VersionActivityEnterBaseView:_playActUnlockAnimation(activityItem)
	if not activityItem then
		return
	end

	VersionActivityBaseController.instance:playedActivityUnlockAnimation(activityItem.actId)

	if activityItem.lockAnimator then
		if activityItem.goNormalAnimator then
			activityItem.goNormalAnimator.enabled = true
		end

		activityItem.lockAnimator:Play(UIAnimationName.Open, 0, 0)
		self:playTimeUnlock(activityItem)

		if not self.playedActUnlockAudio then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_unlock)

			self.playedActUnlockAudio = true
		end

		self.playingUnlockAnimation = true

		TaskDispatcher.runDelay(self.playUnlockAnimationDone, self, VersionActivityEnterBaseView.ActUnlockAnimationDuration)
	end
end

function VersionActivityEnterBaseView:playTimeUnlock(activityItem)
	activityItem.timeAnimator = activityItem.goTime and activityItem.goTime:GetComponent(typeof(UnityEngine.Animator))

	if activityItem.timeAnimator then
		self.needPlayTimeUnlockList = self.needPlayTimeUnlockList or {}

		if not tabletool.indexOf(self.needPlayTimeUnlockList, activityItem) then
			table.insert(self.needPlayTimeUnlockList, activityItem)
		end
	end
end

function VersionActivityEnterBaseView:playAllTimeUnlockAnimation()
	if self.needPlayTimeUnlockList then
		for _, activityItem in ipairs(self.needPlayTimeUnlockList) do
			if activityItem.timeAnimator then
				gohelper.setActive(activityItem.goTime, true)
				activityItem.timeAnimator:Play(UIAnimationName.Open, 0, 0)
			end
		end
	end
end

function VersionActivityEnterBaseView:playUnlockAnimationDone()
	self.playingUnlockAnimation = false

	self:playAllTimeUnlockAnimation()
	self:playAllNewTagAnimation()
end

function VersionActivityEnterBaseView:onOpenAnimationDone()
	UIBlockMgr.instance:endBlock(self.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self.onOpening = false

		return
	end

	if self.needPlayUnlockAnimationActIdList then
		for _, actId in ipairs(self.needPlayUnlockAnimationActIdList) do
			self:_playActUnlockAnimations(self:getVersionActivityItems(actId))
		end

		self.needPlayUnlockAnimationActIdList = nil
	end

	if not self.playingUnlockAnimation then
		self:playAllNewTagAnimation()
	end

	self.onOpening = false
end

function VersionActivityEnterBaseView:playAllNewTagAnimation()
	if self.needPlayNewActTagActIdList then
		for _, actId in ipairs(self.needPlayNewActTagActIdList) do
			self:_playActTagAnimations(self:getVersionActivityItems(actId))
		end

		self.needPlayNewActTagActIdList = nil
	end
end

function VersionActivityEnterBaseView:everyMinuteCall()
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	self:refreshUI()
end

function VersionActivityEnterBaseView:onClose()
	UIBlockMgr.instance:endBlock(self.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:stopBgm()
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
	TaskDispatcher.cancelTask(self.onOpenAnimationDone, self)
	TaskDispatcher.cancelTask(self.playUnlockAnimationDone, self)
end

function VersionActivityEnterBaseView:onDestroyView()
	for _, activityItem in ipairs(self.activityItemList) do
		activityItem.click:RemoveClickListener()
	end
end

function VersionActivityEnterBaseView:playBgm()
	return
end

function VersionActivityEnterBaseView:stopBgm()
	return
end

return VersionActivityEnterBaseView
