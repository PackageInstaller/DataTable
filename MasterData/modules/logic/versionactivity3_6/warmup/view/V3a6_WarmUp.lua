-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUp.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUp", package.seeall)

local V3a6_WarmUp = class("V3a6_WarmUp", BaseView)

function V3a6_WarmUp:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "reward_panel/#simage_fullbg")
	self._simagefullbg2 = gohelper.findChildSingleImage(self.viewGO, "reward_panel/#simage_fullbg2")
	self._txtname = gohelper.findChildText(self.viewGO, "reward_panel/#simage_fullbg2/Days/day01/#txt_name")
	self._txttag1 = gohelper.findChildText(self.viewGO, "reward_panel/#simage_fullbg2/Days/day01/#txt_tag1")
	self._txttag2 = gohelper.findChildText(self.viewGO, "reward_panel/#simage_fullbg2/Days/day01/#txt_tag2")
	self._gofinish = gohelper.findChild(self.viewGO, "reward_panel/#simage_fullbg2/Days/day02/#go_finish")
	self._gounlock = gohelper.findChild(self.viewGO, "reward_panel/#simage_fullbg2/Days/day02/#go_unlock")
	self._golock = gohelper.findChild(self.viewGO, "reward_panel/#simage_fullbg2/Days/day02/#go_lock")
	self._gorole = gohelper.findChild(self.viewGO, "reward_panel/#simage_fullbg2/Days/#go_role")
	self._btnClickBigDay1 = gohelper.findChildButtonWithAudio(self.viewGO, "main_panel/#btn_ClickBigDay1")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/#txt_LimitTime")
	self._btnraward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_raward")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "Right/go_task/goto/#btn_goto")
	self._gofiinish = gohelper.findChild(self.viewGO, "Right/go_task/#go_fiinish")
	self._txtnum = gohelper.findChildText(self.viewGO, "Right/go_task/#txt_num")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Right/go_task/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6_WarmUp:addEvents()
	self._btnClickBigDay1:AddClickListener(self._btnClickBigDay1OnClick, self)
	self._btnraward:AddClickListener(self._btnrawardOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
end

function V3a6_WarmUp:removeEvents()
	self._btnClickBigDay1:RemoveClickListener()
	self._btnraward:RemoveClickListener()
	self._btngoto:RemoveClickListener()
end

local csAnimatorPlayer = SLFramework.AnimatorPlayer
local kOnPassEventParam = "Activity125Controller;Activity125Event;OnGameFinished"
local kAnimEvt = "onSwitch"

function V3a6_WarmUp:_btngotoOnClick()
	local taskInfo = self:_getLatestTaskInfo()

	if not taskInfo then
		return
	end

	local taskCO = taskInfo.taskCO
	local jumpId = taskCO.jumpId

	if jumpId == 0 then
		return
	end

	if GameFacade.jump(jumpId) then
		-- block empty
	end
end

function V3a6_WarmUp:_btnClickBigDay1OnClick()
	local episodeId = self.viewContainer:day1Episode()

	if not self.viewContainer:checkPassedPreTask(episodeId) then
		GameFacade.showToast(ToastEnum.V3a6WarmupPreTaskNotCompleted)

		return
	end

	self._startFlow(self, episodeId, self._onDay1Pass, self)
end

function V3a6_WarmUp:_onDay1Pass()
	gohelper.setActive(self._imghandGo, false)
	self:_setActive_vxGetGo(true)
	gohelper.setActive(self._btnClickBigDay1Go, false)
	self._playAnim(self, UIAnimationName.Switch, self._onDay1SwitchAnimDone, self)
end

function V3a6_WarmUp:_onSwitch()
	AudioMgr.instance:trigger(AudioEnum2_8.WarmUp.play_ui_fuleyuan_yure_paper)

	local day1 = self.viewContainer:day1Episode()

	self:_playDaysGoAnim(day1)
end

function V3a6_WarmUp:_onDay1SwitchAnimDone()
	self:_btnrawardOnClick()
end

function V3a6_WarmUp:_btnrawardOnClick()
	ViewMgr.instance:openView(ViewName.V3a6_WarmUp_TaskView)
end

function V3a6_WarmUp:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function V3a6_WarmUp:_getbPassedAndbClaimable(episodeId)
	episodeId = episodeId or self:_episodeId()

	local isRecevied, localIsPlay, isOld, bClaimable = self.viewContainer:getRLOC(episodeId)
	local bPassed = localIsPlay or isRecevied

	return bPassed, bClaimable, isRecevied
end

function V3a6_WarmUp:_editableInitView()
	self._btngotoGo = self._btngoto.gameObject
	self._btnClickBigDay1Go = self._btnClickBigDay1.gameObject
	self._goTask = gohelper.findChild(self.viewGO, "Right/go_task")
	self._txtgoto = gohelper.findChildText(self._goTask, "txt_goto")
	self._txtdesc.text = ""
	self._txtnum.text = ""
	self._vxGetGo = gohelper.findChild(self._btnraward.gameObject, "vx_get")
	self._imghandGo = gohelper.findChild(self.viewGO, "img_hand")
	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._animEvent = gohelper.onceAddComponent(self.viewGO, gohelper.Type_AnimationEventWrap)

	self._animEvent:AddEventListener(kAnimEvt, self._onSwitch, self)
	self:_setActive_vxGetGo(false)
	self:_setActiveTaskGoto(true)
	self:_editableInitView_dayItems()
end

local kCount = 5

function V3a6_WarmUp:_editableInitView_dayItems()
	local maxEpisodeCount = self.viewContainer:getEpisodeCount()

	if isDebugBuild then
		assert(maxEpisodeCount <= kCount, "invalid config json_activity125 actId: " .. self.viewContainer:actId())
	end

	self._dayItemList = {}
	self._daysGo = gohelper.findChild(self.viewGO, "reward_panel/#simage_fullbg2/Days")
	self._daysAnimatorPlayer = csAnimatorPlayer.Get(self._daysGo)
	self._daysAnimator = self._daysAnimatorPlayer.animator
	self._daysAnimEvent = gohelper.onceAddComponent(self._daysGo, gohelper.Type_AnimationEventWrap)

	local dayGo1 = gohelper.findChild(self._daysGo, "day01")
	local dayItem1 = self:_create_V3a6_WarmUpDayItem(dayGo1, 1)

	table.insert(self._dayItemList, dayItem1)

	for i = 2, maxEpisodeCount do
		local dayGo = gohelper.findChild(self._daysGo, string.format("day0%s", i))

		if gohelper.isNil(dayGo) then
			break
		end

		local item = self:_create_V3a6_WarmUpDayItem(dayGo, i)

		table.insert(self._dayItemList, item)
	end

	self._daysAnimEvent:AddEventListener("play_ui_activity_role_move", self._play_ui_activity_role_move, self)
end

function V3a6_WarmUp:_setActiveTaskGoto(bActiveGoto)
	gohelper.setActive(self._btngotoGo, bActiveGoto)
	gohelper.setActive(self._gofiinish, not bActiveGoto)
end

function V3a6_WarmUp:onDataUpdateFirst()
	self:_refreshOnce()
end

function V3a6_WarmUp:onDataUpdate()
	self:_refresh()
end

function V3a6_WarmUp:onUpdateParam()
	self:_refreshOnce()
	self:_refresh()
end

function V3a6_WarmUp:onOpenFinish()
	local day1 = self.viewContainer:day1Episode()
	local bPassedDay1 = self:_getbPassedAndbClaimable(day1)

	if bPassedDay1 then
		self:_tryOnOpen()
	end
end

function V3a6_WarmUp:onOpen()
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self._refreshTaskInfo, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._refreshTaskInfo, self)
end

function V3a6_WarmUp:onClose()
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, self._refreshTaskInfo, self)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, self._refreshTaskInfo, self)
	TaskDispatcher.cancelTask(self._refreshTaskGoto, self)
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function V3a6_WarmUp:onDestroyView()
	self.__bOnOpend = false

	TaskDispatcher.cancelTask(self._refreshTaskGoto, self)
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	self._animEvent:RemoveAllEventListener()
	self._daysAnimEvent:RemoveAllEventListener()
	GameUtil.onDestroyViewMember(self, "_flow")
	GameUtil.onDestroyViewMemberList(self, "_dayItemList")
end

function V3a6_WarmUp:_refreshOnce()
	self:_autoSelectTab()
	self:_tryOnOpen()
	self:_showDeadline()
	self:_refreshDayList()
	self:_refreshTaskInfo()
end

function V3a6_WarmUp:_tryOnOpen()
	if self.__bOnOpend then
		return
	end

	local day1 = self.viewContainer:day1Episode()
	local bPassedDay1 = self:_getbPassedAndbClaimable(day1)

	gohelper.setActive(self._btnClickBigDay1Go, not bPassedDay1)

	if bPassedDay1 then
		self._playAnim(self, "open2", self._onOpenAnimDone, self)

		local playingEpisodeId = self.viewContainer:getCurPlayingEpisodeId()
		local bPassed = self:_getbPassedAndbClaimable(playingEpisodeId)

		AudioMgr.instance:trigger(AudioEnum2_8.WarmUp.play_ui_fuleyuan_yure_paper)
		self:_simplePlayDaysIdleAnim(playingEpisodeId, bPassed)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.AutoChess.play_ui_fuleyuan_comity_open)
		self._playAnim(self, "open1", self._onOpenAnimDone, self)
		self:_simplePlayDaysIdleAnim(day1, false)
	end

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self.__bOnOpend = true
end

function V3a6_WarmUp:_onOpenAnimDone()
	self:_tryPlayUnlockAnim()
end

function V3a6_WarmUp:_tryPlayUnlockAnim()
	local playingEpisodeId = self.viewContainer:getCurPlayingEpisodeId()

	if playingEpisodeId == self.viewContainer:day1Episode() then
		return
	end

	if not self.viewContainer:isEpisodeReallyOpen(playingEpisodeId) then
		return
	end

	if self.viewContainer:getSavedPlayedUnlock(playingEpisodeId) then
		return
	end

	local dayItem = self:_getDayItem(playingEpisodeId)

	if not dayItem then
		return
	end

	local bPassed, bClaimable = self:_getbPassedAndbClaimable(playingEpisodeId)

	if bPassed or bClaimable then
		return
	end

	dayItem:playUnlockAnim(self._onPlayUnlockAnimDone, self)
end

function V3a6_WarmUp:_onPlayUnlockAnimDone()
	local playingEpisodeId = self.viewContainer:getCurPlayingEpisodeId()

	self.viewContainer:savePlayedUnlock(playingEpisodeId, true)
end

function V3a6_WarmUp:_refresh()
	self.viewContainer:dispatchRedEvent()
	self:_autoSelectTab()
	self:_refreshTaskReward()
end

function V3a6_WarmUp:_refreshTaskReward()
	local _, bClaimable = self:_getbPassedAndbClaimable()

	self:_setActive_vxGetGo(bClaimable)
end

function V3a6_WarmUp:_autoSelectTab()
	local episodeId = self.viewContainer:getCurPlayingEpisodeId()

	self.viewContainer:setCurSelectEpisodeIdSlient(episodeId)

	local bPassed = self:_getbPassedAndbClaimable(episodeId)

	self:_simplePlayDaysIdleAnim(episodeId, bPassed)
end

function V3a6_WarmUp:_refreshDayList()
	for i, dayItem in ipairs(self._dayItemList or {}) do
		local episodeId = i

		dayItem:onUpdateMO(episodeId)
	end
end

function V3a6_WarmUp:_refreshTaskInfo()
	local taskInfo = self:_getLatestTaskInfo()

	gohelper.setActive(self._goTask, taskInfo and true or false)
	gohelper.setActive(self._imghandGo, false)

	if not taskInfo then
		return
	end

	local taskCO = taskInfo.taskCO
	local taskMO = taskInfo.taskMO
	local isFinished = taskMO:isFinished()

	self._txtdesc.text = taskCO.desc
	self._txtnum.text = string.format(luaLang("V3a6_WarmUp_txtnum"), taskMO.progress, taskCO.maxProgress)

	self:_setActiveTaskGoto(not isFinished)
	self:_refreshTaskGoto()
end

function V3a6_WarmUp:_getLatestTaskInfo()
	local episodeId = self.viewContainer:getCurPlayingEpisodeId()

	return self.viewContainer:getPreTaskInfo(episodeId)
end

function V3a6_WarmUp:_showDeadline()
	self:_showLeftTime()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
end

function V3a6_WarmUp:_showLeftTime()
	self._txtLimitTime.text = self.viewContainer:getActivityRemainTimeStr()
end

function V3a6_WarmUp:_create_V3a6_WarmUpDayItem(srcGo, index)
	if index == 1 then
		if not V3a6_WarmUpDayItem1 then
			local cls = V3a6_WarmUpDayItem2_5
			local item = cls.New({
				parent = self,
				baseViewContainer = self.viewContainer
			})

			item:setIndex(index)
			item:init(srcGo)

			return item
		end
	end
end

function V3a6_WarmUp:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a6_WarmUp:_playDaysAnim(name, cb, cbObj)
	self._daysAnimatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a6_WarmUp:_playDaysIdleAnim(name)
	self._daysAnimator.enabled = true

	self._daysAnimator:Play(name, 0, 1)
end

function V3a6_WarmUp:_simplePlayDaysIdleAnim(day, bFinished)
	if not day then
		return
	end

	if bFinished then
		self:_playDaysFinishedIdle(day)
	else
		self:_playDaysIdle(day)
	end
end

local function _getDayAnimName(index)
	return "days_" .. tostring(index)
end

function V3a6_WarmUp:_playDaysFinishedIdle(day)
	local animName = _getDayAnimName(day)

	self:_playDaysIdleAnim(animName)
end

function V3a6_WarmUp:_playDaysIdle(day)
	if day == 1 then
		self:_playDaysIdleAnim(UIAnimationName.Idle)
	else
		local animName = _getDayAnimName(day - 1)

		self:_playDaysIdleAnim(animName)
	end
end

local kBlock_Click = "V3a6_WarmUp:_playDaysGoAnim"
local kTimeout = 5

function V3a6_WarmUp:_playDaysGoAnim(day, cb_, cbObj_)
	UIBlockHelper.instance:startBlock(kBlock_Click, kTimeout, self.viewName)

	local function wrapCb(Self)
		if cb_ then
			cb_(cbObj_)
		end

		UIBlockHelper.instance:endBlock(kBlock_Click)
	end

	local animName = _getDayAnimName(day)

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_role_move)
	self._playDaysAnim(self, animName, wrapCb, self)
end

function V3a6_WarmUp:_getDayItem(episodeId)
	return self._dayItemList[episodeId]
end

function V3a6_WarmUp:onClickItem(dayItem)
	local episodeId = dayItem:episodeId()
	local bPassed = self:_getbPassedAndbClaimable(episodeId)

	if bPassed then
		self._tmpEpisodeId = episodeId

		self:_onPlayDaysGoAnimDone(episodeId)

		return
	end

	local isOpen, remainDay = self.viewContainer:isEpisodeDayOpen(episodeId)

	if not isOpen then
		GameFacade.showToast(ToastEnum.V2a0WarmupEpisodeNotOpen, remainDay)

		return
	end

	if not self.viewContainer:checkPassedPreTask(episodeId) then
		GameFacade.showToast(ToastEnum.V3a6WarmupPreTaskNotCompleted)

		return
	end

	if not self.viewContainer:isEpisodeReallyOpen(episodeId) then
		GameFacade.showToast(ToastEnum.V2a0WarmupEpisodeLock)

		return
	end

	if self._tmpEpisodeId == episodeId then
		self:_onPlayDaysGoAnimDone()
	else
		self._tmpEpisodeId = episodeId

		self._playDaysGoAnim(self, episodeId, self._onPlayDaysGoAnimDone, self)
	end
end

function V3a6_WarmUp:_onPlayDaysGoAnimDone()
	self._startFlow(self, self._tmpEpisodeId, self._onDay25Pass, self)
end

function V3a6_WarmUp:_onDay25Pass()
	local episodeId = self._tmpEpisodeId
	local dayItem = self:_getDayItem(episodeId)
	local bPassed, bClaimable = self:_getbPassedAndbClaimable(episodeId)

	if bPassed and bPassed ~= self._bPassedLast then
		dayItem:playFinishAnim(self._onPlayFinishAnimDone, self)
	elseif bClaimable then
		self:_onPlayFinishAnimDone()
	end
end

function V3a6_WarmUp:_onPlayFinishAnimDone()
	self:_setActive_vxGetGo(true)
	self:_btnrawardOnClick()
end

function V3a6_WarmUp:_startFlow(episodeId, onPassSelfCb, onPassSelfCbObj)
	GameUtil.onDestroyViewMember(self, "_flow")

	if not episodeId then
		return
	end

	local bPassed, bClaimable = self:_getbPassedAndbClaimable(episodeId)

	self._bPassedLast = bPassed
	self._flow = GaoSiNiaoFlowSequence_Base.New()

	self._flow:addWork(FunctionWork.New(self._openGameView, self, episodeId))
	self._flow:addWork(WaitEventWork.New(kOnPassEventParam))
	self._flow:addWork(FunctionWork.New(onPassSelfCb, onPassSelfCbObj))
	self._flow:start()
end

function V3a6_WarmUp:_openGameView(episodeId)
	self._tmpEpisodeId = episodeId

	self.viewContainer:openV3a6_WarmUp_DialogueView(episodeId)
end

function V3a6_WarmUp:_setActive_vxGetGo(bActive)
	gohelper.setActive(self._vxGetGo, bActive)
end

function V3a6_WarmUp:_refreshTaskGoto()
	TaskDispatcher.cancelTask(self._refreshTaskGoto, self)

	local playingEpisodeId = self.viewContainer:getCurPlayingEpisodeId()
	local taskInfo = self.viewContainer:getPreTaskInfo(playingEpisodeId)

	if not taskInfo then
		gohelper.setActive(self._goTask, false)

		return
	end

	if self.viewContainer:isAllEpisodeFinish() then
		gohelper.setActive(self._goTask, false)

		return
	end

	gohelper.setActive(self._goTask, true)

	local taskMO = taskInfo.taskMO
	local isFinished = taskMO:isFinished()
	local day1 = self.viewContainer:day1Episode()
	local bPassed, bClaimable = self:_getbPassedAndbClaimable(playingEpisodeId)

	if playingEpisodeId == day1 then
		self._txtgoto.text = not isFinished and luaLang("v3a6_warmup_txt_task1") or not self.viewContainer:isEpisodeReallyOpen(playingEpisodeId) and "-" or bClaimable and luaLang("v3a6_warmup_txt_finish") or luaLang("v3a6_warmup_txt_goto1")

		local bShowHand = not bPassed and not bClaimable

		gohelper.setActive(self._imghandGo, bShowHand)
	else
		gohelper.setActive(self._imghandGo, false)

		if not isFinished then
			self._txtgoto.text = luaLang("v3a6_warmup_txt_task2")
		elseif not self.viewContainer:isEpisodeReallyOpen(playingEpisodeId) then
			local seconds = ServerTime.getToadyEndTimeStamp(true) - ServerTime.nowInLocal()
			local str = TimeUtil.SecondToActivityTimeFormat(seconds)

			self._txtgoto.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v3a6_warmup_txt_task3"), {
				str
			})

			TaskDispatcher.runDelay(self._refreshTaskGoto, self, 60)
		else
			self._txtgoto.text = bClaimable and luaLang("v3a6_warmup_txt_finish") or luaLang("v3a6_warmup_txt_goto2")
		end
	end
end

function V3a6_WarmUp:_play_ui_activity_role_move()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_role_move)
end

return V3a6_WarmUp
