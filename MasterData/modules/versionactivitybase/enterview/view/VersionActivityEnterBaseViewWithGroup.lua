-- chunkname: @modules/versionactivitybase/enterview/view/VersionActivityEnterBaseViewWithGroup.lua

module("modules.versionactivitybase.enterview.view.VersionActivityEnterBaseViewWithGroup", package.seeall)

local VersionActivityEnterBaseViewWithGroup = class("VersionActivityEnterBaseViewWithGroup", BaseView)

VersionActivityEnterBaseViewWithGroup.ShowActTagEnum = {
	ShowNewStage = 1,
	ShowNewAct = 0
}

function VersionActivityEnterBaseViewWithGroup:onInitView()
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._goGroupController = gohelper.findChild(self.viewGO, "entrance/#go_groupController")
end

function VersionActivityEnterBaseViewWithGroup:addEvents()
	self._btnreplay:AddClickListener(self._btnReplayOnClick, self)
end

function VersionActivityEnterBaseViewWithGroup:removeEvents()
	self._btnreplay:RemoveClickListener()
end

VersionActivityEnterBaseViewWithGroup.ActUnlockAnimationDuration = 2.5

function VersionActivityEnterBaseViewWithGroup:_btnReplayOnClick()
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

function VersionActivityEnterBaseViewWithGroup:onClickGroupBtn(groupItem)
	if groupItem.groupIndex == self.showGroupIndex then
		return
	end

	local actId = self.mainActIdList[groupItem.groupIndex]
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if status == ActivityEnum.ActivityStatus.NotOpen then
			local actInfo = ActivityModel.instance:getActMO(actId)
			local timeOffset = actInfo:getRealStartTimeStamp() - ServerTime.now()
			local actName = actInfo.config.name
			local timeStr = TimeUtil.getFormatTime2(timeOffset)

			GameFacade.showToast(ToastEnum.V1a4_ActPreTips, actName, timeStr)
		elseif toastId then
			GameFacade.showToastWithTableParam(toastId, toastParam)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return
	end

	self.showGroupIndex = groupItem.groupIndex

	local animName = self.showGroupIndex == 1 and "switch_b" or "switch_a"

	self.animator:Play(animName, 0, 0)
	self:beforeClickGroupBtn()
	self:refreshGroupBtnUI()
end

function VersionActivityEnterBaseViewWithGroup:defaultCheckActivityCanClick(activityItem)
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

function VersionActivityEnterBaseViewWithGroup:_activityBtnOnClick(activityItem)
	if activityItem.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	local checkFunc = self["checkActivityCanClickFunc" .. activityItem.index]

	checkFunc = checkFunc or self.defaultCheckActivityCanClick

	if not checkFunc(self, activityItem) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	if not self["onClickActivity" .. activityItem.actId] then
		if self["onClickActivity" .. activityItem.actId] then
			self["onClickActivity" .. activityItem.actId](self)
		end
	end
end

function VersionActivityEnterBaseViewWithGroup:initActivityItem(groupIndex, index, actId, goActivityContainer)
	local activityItem = self:getUserDataTb_()

	activityItem.groupIndex = groupIndex
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

	local normalAnimationPath = VersionActivityEnum.EnterViewNormalAnimationPath[actId]

	if normalAnimationPath then
		local goNormalAnimationNode = gohelper.findChild(goActivityContainer, normalAnimationPath)

		if goNormalAnimationNode then
			activityItem.normalAnimation = goNormalAnimationNode:GetComponent(typeof(UnityEngine.Animation))
		end
	end

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

	local clickarea = gohelper.findChild(goActivityContainer, "clickarea")

	gohelper.setActive(clickarea, false)
	activityItem.click:AddClickListener(self._activityBtnOnClick, self, activityItem)
	gohelper.setActive(activityItem.goRedPointTag, true)
	gohelper.setActive(activityItem.goRedPointTagNewAct, false)
	gohelper.setActive(activityItem.goRedPointTagNewEpisode, false)

	activityItem.redPointTagAnimator = activityItem.goRedPointTag and activityItem.goRedPointTag:GetComponent(typeof(UnityEngine.Animator))

	return activityItem
end

function VersionActivityEnterBaseViewWithGroup:createGroupBtnItem(groupIndex)
	local groupItem = self:getUserDataTb_()

	groupItem.groupIndex = groupIndex
	groupItem.goGroup = gohelper.findChild(self._goGroupController, "tab" .. groupIndex)

	if gohelper.isNil(groupItem.goGroup) then
		logError("not found btn group : " .. tostring(groupIndex))

		return
	end

	groupItem.click = gohelper.getClick(groupItem.goGroup)
	groupItem.goNormal = gohelper.findChild(groupItem.goGroup, "go_normal")
	groupItem.goSelect = gohelper.findChild(groupItem.goGroup, "go_select")
	groupItem.goRedDot = gohelper.findChild(groupItem.goGroup, "go_reddot")

	groupItem.click:AddClickListener(self.onClickGroupBtn, self, groupItem)

	return groupItem
end

function VersionActivityEnterBaseViewWithGroup:initBtnGroup()
	self.groupItemList = {}

	for i = 1, 2 do
		table.insert(self.groupItemList, self:createGroupBtnItem(i))
	end
end

function VersionActivityEnterBaseViewWithGroup:_editableInitView()
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.activityGoContainerList = self:getUserDataTb_()
	self.activityItemListWithGroup = {}
	self.groupGoList = self:getUserDataTb_()
	self.showGroupIndex = 0
	self.playedNewActTagAnimationIdList = nil
	self.animEventWrap = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	self.animEventWrap:AddEventListener("refreshUI", self.onSwitchGroup, self)
	self:initBtnGroup()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.checkNeedRefreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self.refreshAllNewActOpenTagUI, self)
	self.addEventCb(self, NavigateMgr.instance, NavigateEvent.BeforeClickHome, self.beforeClickHome, self)
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
end

function VersionActivityEnterBaseViewWithGroup:onCloseViewFinish()
	self:checkNeedRefreshUI()

	if ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self:playAmbientAudio()
	end
end

function VersionActivityEnterBaseViewWithGroup:onOpenViewFinish()
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self:stopAmbientAudio()
	end
end

function VersionActivityEnterBaseViewWithGroup:beforeClickHome()
	self.clickedHome = true
end

function VersionActivityEnterBaseViewWithGroup:checkNeedRefreshUI()
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if self.clickedHome then
		return
	end

	self:refreshUI()
	ActivityStageHelper.recordActivityStage(self.activityIdListWithGroup[self.mainActIdList[self.showGroupIndex]])
end

function VersionActivityEnterBaseViewWithGroup:initViewParam()
	self.actId = self.viewParam.actId
	self.skipOpenAnim = self.viewParam.skipOpenAnim
	self.activityIdListWithGroup = self.viewParam.activityIdListWithGroup
	self.mainActIdList = self.viewParam.mainActIdList
	self.actId2AmbientDict = self.viewParam.actId2AmbientDict
	self.actId2OpenAudioDict = self.viewParam.actId2OpenAudioDict

	self:initGroupIndex()
end

function VersionActivityEnterBaseViewWithGroup:initGroupIndex()
	for i = #self.mainActIdList, 1, -1 do
		local status = ActivityHelper.getActivityStatus(self.mainActIdList[i])

		if status == ActivityEnum.ActivityStatus.Normal then
			self.showGroupIndex = i

			return
		end
	end

	logError("一个活动都没解锁？")

	self.showGroupIndex = 1
end

function VersionActivityEnterBaseViewWithGroup:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function VersionActivityEnterBaseViewWithGroup:onOpen()
	self.onOpening = true

	self:initViewParam()
	self:initActivityNode()
	self:initActivityItemList()
	self:refreshUI()
	self:playOpenAnimation()
	self:playBgm()
	self:playAmbientAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_switch)
end

function VersionActivityEnterBaseViewWithGroup:initActivityNode()
	for i = 1, 2 do
		local groupGo = gohelper.findChild(self.viewGO, "entrance/#go_group" .. i)

		if gohelper.isNil(groupGo) then
			logError("not found group node : entrance/#go_group" .. i)
		end

		table.insert(self.groupGoList, groupGo)
	end

	local actIndex = 0

	for groupIndex, actId in ipairs(self.mainActIdList) do
		local groupGo = self.groupGoList[groupIndex]
		local activityIdList = self.activityIdListWithGroup[actId]

		for i = 1, #activityIdList do
			actIndex = actIndex + 1

			local goContainer = gohelper.findChild(groupGo, "activityContainer" .. actIndex)

			if gohelper.isNil(goContainer) then
				logError(string.format("not found container node : %s/activityContainer%s", groupGo.name, actIndex))
			end

			table.insert(self.activityGoContainerList, goContainer)
		end
	end
end

function VersionActivityEnterBaseViewWithGroup:initActivityItemList()
	local actIndex = 0

	for groupIndex, actId in ipairs(self.mainActIdList) do
		local activityIdList = self.activityIdListWithGroup[actId]
		local groupItemList = self.activityItemListWithGroup[groupIndex]

		if groupItemList == nil then
			groupItemList = {}
			self.activityItemListWithGroup[groupIndex] = groupItemList
		end

		for _, _actId in ipairs(activityIdList) do
			actIndex = actIndex + 1

			table.insert(groupItemList, self:initActivityItem(groupIndex, actIndex, _actId, self.activityGoContainerList[actIndex]))
		end
	end
end

function VersionActivityEnterBaseViewWithGroup:getVersionActivityItem(actId)
	for _, groupItemList in ipairs(self.activityItemListWithGroup) do
		for _, activityItem in ipairs(groupItemList) do
			if activityItem.actId == actId then
				return activityItem
			end
		end
	end
end

function VersionActivityEnterBaseViewWithGroup:playOpenAnimation()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(self.viewName .. "playOpenAnimation")

	if self.skipOpenAnim then
		self.animator:Play(UIAnimationName.Idle)
		TaskDispatcher.runDelay(self.onOpenAnimationDone, self, 0.5)
	else
		self:beforePlayOpenAnimation()

		local animName = self.showGroupIndex == 1 and "open_a" or "open_b"

		self.animator:Play(animName, 0, 0)
		TaskDispatcher.runDelay(self.onOpenAnimationDone, self, 2.167)
	end
end

function VersionActivityEnterBaseViewWithGroup:refreshUI()
	self:refreshCenterActUI()
	self:refreshActivityUI()
end

function VersionActivityEnterBaseViewWithGroup:refreshCenterActUI()
	self:refreshSingleBgUI()
	self:refreshGroupBtnUI()
end

function VersionActivityEnterBaseViewWithGroup:refreshSingleBgUI()
	return
end

function VersionActivityEnterBaseViewWithGroup:refreshGroupBtnUI()
	for index, groupItem in ipairs(self.groupItemList) do
		gohelper.setActive(groupItem.goNormal, self.showGroupIndex ~= groupItem.groupIndex)
		gohelper.setActive(groupItem.goSelect, self.showGroupIndex == groupItem.groupIndex)

		local actId = self.mainActIdList[index]
		local status = ActivityHelper.getActivityStatus(actId)

		if status == ActivityEnum.ActivityStatus.Normal and not groupItem.redDotComp then
			local co = ActivityConfig.instance:getActivityCo(actId)

			groupItem.redDotComp = RedDotController.instance:addRedDot(groupItem.goRedDot, co.redDotId)
		end
	end
end

function VersionActivityEnterBaseViewWithGroup:refreshActivityUI()
	self.playedActTagAudio = false
	self.playedActUnlockAudio = false

	for groupIndex, groupGo in ipairs(self.groupGoList) do
		gohelper.setActive(groupGo, groupIndex == self.showGroupIndex)
	end

	for _, activityItem in ipairs(self.activityItemListWithGroup[self.showGroupIndex]) do
		self:refreshActivityItem(activityItem)
	end
end

function VersionActivityEnterBaseViewWithGroup:defaultBeforePlayActUnlockAnimation(activityItem)
	gohelper.setActive(activityItem.goTime, false)
	gohelper.setActive(activityItem.goLockContainer, true)

	if activityItem.txtLockGo then
		gohelper.setActive(activityItem.txtLockGo, false)
	end
end

function VersionActivityEnterBaseViewWithGroup:refreshActivityItem(activityItem)
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

	if isNormalStatus and activityItem.redDotId and activityItem.redDotId ~= 0 and not gohelper.isNil(activityItem.goRedPoint) then
		RedDotController.instance:addRedDot(activityItem.goRedPoint, activityItem.redDotId)
	end

	gohelper.setActive(activityItem.goRedPointTag, isNormalStatus)
	gohelper.setActive(activityItem.goRedPointTagNewAct, false)
	gohelper.setActive(activityItem.goRedPointTagNewEpisode, false)

	activityItem.showTag = nil

	if isNormalStatus then
		local isShowNewAct = not ActivityEnterMgr.instance:isEnteredActivity(activityItem.actId)

		if isShowNewAct then
			activityItem.showTag = VersionActivityEnterBaseViewWithGroup.ShowActTagEnum.ShowNewAct

			self:playActTagAnimation(activityItem)
		elseif actInfoMo:isNewStageOpen() then
			activityItem.showTag = VersionActivityEnterBaseViewWithGroup.ShowActTagEnum.ShowNewStage

			self:playActTagAnimation(activityItem)
		end
	end

	local refreshUICallback = self["onRefreshActivity" .. activityItem.index]

	if refreshUICallback then
		refreshUICallback(self, activityItem)
	end
end

function VersionActivityEnterBaseViewWithGroup:refreshLockUI(activityItem, activityStatus)
	local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(activityItem.goLockContainer, not isNormalStatus)
	gohelper.setActive(activityItem.txtLockGo, not isNormalStatus)
	gohelper.setActive(activityItem.goTime, isNormalStatus)

	if not isNormalStatus and activityItem.txtLock then
		local getTextFunc = self["getLockTextFunc" .. activityItem.index]

		getTextFunc = getTextFunc or self.getLockText
		activityItem.txtLock.text = getTextFunc(self, activityItem, activityStatus)
	end
end

function VersionActivityEnterBaseViewWithGroup:getLockText(activityItem, activityStatus)
	local actInfoMo = ActivityModel.instance:getActivityInfo()[activityItem.actId]
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

	return lockText
end

function VersionActivityEnterBaseViewWithGroup:refreshAllNewActOpenTagUI()
	for _, activityItem in ipairs(self.activityItemListWithGroup[self.showGroupIndex]) do
		local activityStatus = ActivityHelper.getActivityStatus(activityItem.actId)
		local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(activityItem.goRedPointTag, isNormalStatus)
		gohelper.setActive(activityItem.goRedPointTagNewAct, isNormalStatus and not ActivityEnterMgr.instance:isEnteredActivity(activityItem.actId))
	end
end

function VersionActivityEnterBaseViewWithGroup:isPlayedActTagAnimation(actId)
	if not self.playedNewActTagAnimationIdList then
		return false
	end

	return tabletool.indexOf(self.playedNewActTagAnimationIdList, actId)
end

function VersionActivityEnterBaseViewWithGroup:playActTagAnimation(activityItem)
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

function VersionActivityEnterBaseViewWithGroup:_playActTagAnimation(activityItem)
	if activityItem.showTag == VersionActivityEnterBaseViewWithGroup.ShowActTagEnum.ShowNewAct then
		gohelper.setActive(activityItem.goRedPointTagNewAct, true)
	elseif activityItem.showTag == VersionActivityEnterBaseViewWithGroup.ShowActTagEnum.ShowNewStage then
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

function VersionActivityEnterBaseViewWithGroup:playActUnlockAnimation(activityItem)
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

function VersionActivityEnterBaseViewWithGroup:_playActUnlockAnimation(activityItem)
	if not activityItem then
		return
	end

	VersionActivityBaseController.instance:playedActivityUnlockAnimation(activityItem.actId)

	if activityItem.lockAnimator then
		if activityItem.goNormalAnimator then
			activityItem.goNormalAnimator.enabled = true
		end

		activityItem.lockAnimator:Play(UIAnimationName.Unlock, 0, 0)
		self:playTimeUnlock(activityItem)

		if not self.playedActUnlockAudio then
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.SwitchPlayer)

			self.playedActUnlockAudio = true
		end

		self.playingUnlockAnimation = true

		TaskDispatcher.runDelay(self.playUnlockAnimationDone, self, VersionActivityEnterBaseViewWithGroup.ActUnlockAnimationDuration)
	end
end

function VersionActivityEnterBaseViewWithGroup:playTimeUnlock(activityItem)
	activityItem.timeAnimator = activityItem.goTime and activityItem.goTime:GetComponent(typeof(UnityEngine.Animator))

	if activityItem.timeAnimator then
		self.needPlayTimeUnlockList = self.needPlayTimeUnlockList or {}

		if not tabletool.indexOf(self.needPlayTimeUnlockList, activityItem) then
			table.insert(self.needPlayTimeUnlockList, activityItem)
		end
	end
end

function VersionActivityEnterBaseViewWithGroup:playAllTimeUnlockAnimation()
	if self.needPlayTimeUnlockList then
		for _, activityItem in ipairs(self.needPlayTimeUnlockList) do
			if activityItem.timeAnimator then
				gohelper.setActive(activityItem.goTime, true)
				activityItem.timeAnimator:Play(UIAnimationName.Open, 0, 0)
			end
		end
	end
end

function VersionActivityEnterBaseViewWithGroup:playUnlockAnimationDone()
	self.playingUnlockAnimation = false

	self:refreshActivityUI()
	self:playAllTimeUnlockAnimation()
	self:playAllNewTagAnimation()
end

function VersionActivityEnterBaseViewWithGroup:onOpenAnimationDone()
	UIBlockMgr.instance:endBlock(self.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)

	local animName = self.showGroupIndex == 1 and "open_a" or "open_b"

	self.animator:Play(animName, 0, 1)

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self.onOpening = false

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

	self.onOpening = false
end

function VersionActivityEnterBaseViewWithGroup:playAllNewTagAnimation()
	if self.needPlayNewActTagActIdList then
		for _, actId in ipairs(self.needPlayNewActTagActIdList) do
			self:_playActTagAnimation(self:getVersionActivityItem(actId))
		end

		self.needPlayNewActTagActIdList = nil
	end
end

function VersionActivityEnterBaseViewWithGroup:everyMinuteCall()
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	self:refreshUI()
end

function VersionActivityEnterBaseViewWithGroup:onSwitchGroup()
	self:refreshUI()
	self:playAmbientAudio()
end

function VersionActivityEnterBaseViewWithGroup:onClose()
	UIBlockMgr.instance:endBlock(self.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:stopBgm()
	self:stopAmbientAudio()
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
	TaskDispatcher.cancelTask(self.onOpenAnimationDone, self)
	TaskDispatcher.cancelTask(self.playUnlockAnimationDone, self)
end

function VersionActivityEnterBaseViewWithGroup:onDestroyView()
	for _, groupItemList in ipairs(self.activityItemListWithGroup) do
		for _, activityItem in ipairs(groupItemList) do
			activityItem.click:RemoveClickListener()
		end
	end

	for _, btnItem in ipairs(self.groupItemList) do
		btnItem.click:RemoveClickListener()
	end

	self.animEventWrap:RemoveAllEventListener()
end

function VersionActivityEnterBaseViewWithGroup:beforeClickGroupBtn()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_switch)
end

function VersionActivityEnterBaseViewWithGroup:getLastNormalActId()
	for i = #self.mainActIdList, 1, -1 do
		local status = ActivityHelper.getActivityStatus(self.mainActIdList[i])

		if status == ActivityEnum.ActivityStatus.Normal then
			return self.mainActIdList[i]
		end
	end

	return self.mainActIdList[1]
end

function VersionActivityEnterBaseViewWithGroup:beforePlayOpenAnimation()
	local actId = self:getLastNormalActId()
	local audio = self.actId2OpenAudioDict[actId]

	if not audio then
		logWarn("no open audio")

		return
	end

	AudioMgr.instance:trigger(audio)
end

function VersionActivityEnterBaseViewWithGroup:playAmbientAudio()
	local actId = self.mainActIdList[self.showGroupIndex]

	if actId == self.playingAmbientActId then
		return
	end

	self:stopAmbientAudio()

	self.playingAmbientActId = actId

	local ambient = self.actId2AmbientDict[actId]

	self.ambientPlayingId = AudioMgr.instance:trigger(ambient)
end

function VersionActivityEnterBaseViewWithGroup:stopAmbientAudio()
	if self.ambientPlayingId then
		AudioMgr.instance:stopPlayingID(self.ambientPlayingId)
	end
end

function VersionActivityEnterBaseViewWithGroup:playBgm()
	return
end

function VersionActivityEnterBaseViewWithGroup:stopBgm()
	return
end

return VersionActivityEnterBaseViewWithGroup
