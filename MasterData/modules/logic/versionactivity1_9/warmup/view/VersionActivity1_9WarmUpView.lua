-- chunkname: @modules/logic/versionactivity1_9/warmup/view/VersionActivity1_9WarmUpView.lua

module("modules.logic.versionactivity1_9.warmup.view.VersionActivity1_9WarmUpView", package.seeall)

local VersionActivity1_9WarmUpView = class("VersionActivity1_9WarmUpView", BaseView)

VersionActivity1_9WarmUpView.UI_CLICK_BLOCK_KEY = "VersionActivity1_9WarmUpView_UI_CLICK_BLOCK_KEY"

function VersionActivity1_9WarmUpView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._gostart = gohelper.findChild(self.viewGO, "Middle/#go_start")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "Middle/#go_start/#simage_bg")
	self._godrag = gohelper.findChild(self.viewGO, "Middle/#go_start/#go_drag")
	self._goscepter = gohelper.findChild(self.viewGO, "Middle/#go_start/#go_scepter")
	self._goguide = gohelper.findChild(self.viewGO, "Middle/#go_start/#go_guide")
	self._simageday = gohelper.findChildSingleImage(self.viewGO, "Middle/#simage_day")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/LimitTime/#txt_LimitTime")
	self._scrollTaskTabList = gohelper.findChildScrollRect(self.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	self._goradiotaskitem = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem/#go_reddot")
	self._goTitle = gohelper.findChild(self.viewGO, "Right/TaskPanel/#go_Title")
	self._txtTaskTitle = gohelper.findChildText(self.viewGO, "Right/TaskPanel/#go_Title/#txt_TaskTitle")
	self._scrollTaskDesc = gohelper.findChildScrollRect(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	self._txtTaskContent = gohelper.findChildText(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	self._goWrongChannel = gohelper.findChild(self.viewGO, "Right/TaskPanel/#go_WrongChannel")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "Right/RawardPanel/#scroll_Reward")
	self._gorewarditem = gohelper.findChild(self.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	self._btngetreward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/RawardPanel/#btn_getreward")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_9WarmUpView:addEvents()
	self._btngetreward:AddClickListener(self._btngetrewardOnClick, self)
	self:_addEvents()
end

function VersionActivity1_9WarmUpView:removeEvents()
	self._btngetreward:RemoveClickListener()
	self:_removeEvents()
end

function VersionActivity1_9WarmUpView:_editableInitView()
	self._episodeItemTab = {}
	self._rewardItemTab = self:getUserDataTb_()
	self._goTaskScroll = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	self._goTaskContent = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	self._scrollCanvasGroup = gohelper.onceAddComponent(self._scrollTaskDesc.gameObject, typeof(UnityEngine.CanvasGroup))
	self._episodeCanGetInfoDict = {}

	local goTaskDescViewPort = gohelper.findChild(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport")

	self._rectmask2D = goTaskDescViewPort:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag.gameObject)
	self._bottom = 324

	local _middle = gohelper.findChild(self.viewGO, "Middle")

	self._animView = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._animScepter = _middle:GetComponent(typeof(UnityEngine.Animator))
	self._animScepterPlayer = SLFramework.AnimatorPlayer.Get(_middle)
	self._animDayIcon = self._simageday.gameObject:GetComponent(typeof(UnityEngine.Animator))
end

function VersionActivity1_9WarmUpView:_btngetrewardOnClick()
	local curSelectedLvId = self:getCurSelectedEpisode()
	local isRecevied = Activity125Model.instance:isEpisodeFinished(self._actId, curSelectedLvId)
	local localPlay = Activity125Model.instance:checkLocalIsPlay(self._actId, curSelectedLvId)
	local cangetreward = not isRecevied and localPlay

	if not cangetreward then
		return
	end

	self.viewContainer:setIsPlayingDesc(true)

	local co = Activity125Config.instance:getEpisodeConfig(self._actId, curSelectedLvId)

	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(self._actId, curSelectedLvId, co.targetFrequency)
end

function VersionActivity1_9WarmUpView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = self.viewParam.actId

	Activity125Controller.instance:getAct125InfoFromServer(self._actId)
	self._animView:Play("in", 0, 0)

	self._isPlayScepterAnim = false

	self:_checkGuide()
end

function VersionActivity1_9WarmUpView:refreshUI()
	self:_refreshData()
	self:_showDeadline()
	self:_initEpisodeList()
	self:_initRewards()
	self:_initView()
	self:_checkPlayDesc()
end

function VersionActivity1_9WarmUpView:_addEvents()
	self.addEventCb(self, Activity125Controller.instance, Activity125Event.DataUpdate, self.refreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onRewardRefresh, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._animEventWrap:AddEventListener("switch", self._playSwitchAnimRefreshView, self)
end

function VersionActivity1_9WarmUpView:_removeEvents()
	self.removeEventCb(self, Activity125Controller.instance, Activity125Event.DataUpdate, self.refreshUI, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onRewardRefresh, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self._drag:RemoveDragBeginListener()
	self._animEventWrap:RemoveAllEventListener()
end

function VersionActivity1_9WarmUpView:_initView()
	local isRecevied = Activity125Model.instance:isEpisodeFinished(self._actId, self:getCurSelectedEpisode())
	local localPlay = Activity125Model.instance:checkLocalIsPlay(self._actId, self:getCurSelectedEpisode())
	local isOld = Activity125Model.instance:checkIsOldEpisode(self._actId, self:getCurSelectedEpisode())
	local cangetreward = not isRecevied and localPlay

	for key, item in pairs(self._rewardItemTab) do
		gohelper.setActive(item.gocanget, cangetreward)
		gohelper.setActive(item.goreceive, isRecevied and not self.viewContainer:isPlayingDesc())
	end

	gohelper.setActive(self._btngetreward.gameObject, cangetreward)

	local isFinish = isRecevied or localPlay or isOld

	if isFinish then
		self._rectmask2D.padding = Vector4(0, 0, 0, 0)

		gohelper.setActive(self._goWrongChannel, false)
	else
		self._rectmask2D.padding = Vector4(0, self._bottom, 0, 0)

		gohelper.setActive(self._goWrongChannel, true)
	end

	self:_activeScepter(isFinish)
end

function VersionActivity1_9WarmUpView:getCurSelectedEpisode()
	return Activity125Model.instance:getSelectEpisodeId(self._actId)
end

function VersionActivity1_9WarmUpView:_refreshData()
	local curSelectedLvId = self:getCurSelectedEpisode()
	local co = Activity125Config.instance:getEpisodeConfig(self._actId, curSelectedLvId)

	self._txtTaskContent.text = co.text
	self._descHeight = self._txtTaskContent.preferredHeight
	self._txtTaskTitle.text = co.name

	recthelper.setAnchorY(self._txtTaskContent.transform, 0)
	gohelper.setActive(self._goWrongChannel, true)
end

function VersionActivity1_9WarmUpView:_showDeadline()
	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 60)
end

function VersionActivity1_9WarmUpView:_onRefreshDeadline()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

VersionActivity1_9WarmUpView.AnimSwitchMode = {
	UnFinish2Finish = 3,
	Finish = 1,
	Finish2UnFinish = 4,
	UnFinish = 2,
	None = 0
}

function VersionActivity1_9WarmUpView:_initEpisodeList()
	local maxEpisodeCount = Activity125Config.instance:getEpisodeCount(self._actId)
	local selectId = self:getCurSelectedEpisode()

	for i = 1, maxEpisodeCount do
		local episodeItem = self._episodeItemTab[i]

		if not episodeItem then
			episodeItem = self:getUserDataTb_()
			episodeItem.episodeItemGo = gohelper.cloneInPlace(self._goradiotaskitem, "taskItem" .. i)

			local go = episodeItem.episodeItemGo

			episodeItem.txtDateUnSelected = gohelper.findChildText(go, "txt_DateUnSelected")
			episodeItem.goDateSelected = gohelper.findChild(go, "image_Selected")
			episodeItem.txtDateSelected = gohelper.findChildText(go, "image_Selected/txt_DateSelected")
			episodeItem.finishEffectGo = gohelper.findChild(go, "image_Selected/Wave_effect2")
			episodeItem.imagewave = gohelper.findChildImage(go, "image_Selected/image_wave")
			episodeItem.goDateLocked = gohelper.findChild(go, "image_Locked")
			episodeItem.goRed = gohelper.findChild(go, "#go_reddot")
			episodeItem.click = gohelper.findChildButton(go, "btn_click")

			episodeItem.click:AddClickListener(self._taskItemOnClick, self, i)

			self._episodeItemTab[i] = episodeItem
		end

		episodeItem.txtDateUnSelected.text = string.format("Day.%s", i)
		episodeItem.txtDateSelected.text = string.format("Day.%s", i)

		gohelper.setActive(episodeItem.episodeItemGo, true)

		local isSelect = i == selectId

		gohelper.setActive(episodeItem.goDateSelected, isSelect)
		gohelper.setActive(episodeItem.txtDateUnSelected.gameObject, not isSelect)

		local isLock = not Activity125Model.instance:isEpisodeReallyOpen(self._actId, i)

		gohelper.setActive(episodeItem.goDateLocked, isLock)
		gohelper.setActive(episodeItem.goRed, Activity125Model.instance:isEpisodeReallyOpen(self._actId, i) and Activity125Model.instance:isHasEpisodeCanReceiveReward(self._actId, i))
	end

	ZProj.UGUIHelper.RebuildLayout(self._goTaskContent.transform)

	if selectId == self._selectId then
		return
	end

	self._selectId = selectId

	local max = math.max(recthelper.getWidth(self._goTaskContent.transform) - recthelper.getWidth(self._goTaskScroll.transform), 0)
	local pos = (selectId - 1) * 166

	recthelper.setAnchorX(self._goTaskContent.transform, -math.min(pos, max))
end

function VersionActivity1_9WarmUpView:_taskItemOnClick(episodeId)
	if self.viewContainer:isPlayingDesc() or self._isPlayScepterAnim then
		return
	end

	local curSelectedEpisodeId = self:getCurSelectedEpisode()
	local isOpen, remainDay = Activity125Model.instance:isEpisodeDayOpen(self._actId, episodeId)

	if not isOpen then
		GameFacade.showToast(ToastEnum.V1A7WarmupDayLock, remainDay)

		return
	end

	local isTargetSelectEpisodeUnLock = Activity125Model.instance:isEpisodeUnLock(self._actId, episodeId)

	if not isTargetSelectEpisodeUnLock then
		GameFacade.showToast(ToastEnum.V1A9WarmupPreEpisodeLock)

		return
	end

	if curSelectedEpisodeId ~= episodeId then
		UIBlockMgr.instance:startBlock(VersionActivity1_9WarmUpView.UI_CLICK_BLOCK_KEY)
		self:_playDescFinish()
		Activity125Model.instance:setSelectEpisodeId(self._actId, episodeId)
		self._animPlayer:Play("switch", self._playSwitchAnimFinish, self)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	self:_checkGuide()
end

function VersionActivity1_9WarmUpView:_playSwitchAnimFinish()
	self._animView:Play("idle", 0, 0)
	UIBlockMgr.instance:endBlock(VersionActivity1_9WarmUpView.UI_CLICK_BLOCK_KEY)
end

function VersionActivity1_9WarmUpView:_playSwitchAnimRefreshView()
	Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
end

function VersionActivity1_9WarmUpView:_initRewards()
	local co = Activity125Config.instance:getEpisodeConfig(self._actId, self:getCurSelectedEpisode())
	local rewardBonus = co.bonus
	local rewards = string.split(rewardBonus, "|")

	self._rewardCount = #rewards

	for i = 1, self._rewardCount do
		local rewardItem = self._rewardItemTab[i]

		if not rewardItem then
			rewardItem = {
				go = gohelper.cloneInPlace(self._gorewarditem, "rewarditem" .. i)
			}

			local iconRoot = gohelper.findChild(rewardItem.go, "go_icon")

			rewardItem.icon = IconMgr.instance:getCommonPropItemIcon(iconRoot)
			rewardItem.goreceive = gohelper.findChild(rewardItem.go, "go_receive")
			rewardItem.gocanget = gohelper.findChild(rewardItem.go, "go_canget")
			rewardItem.hasgetAnim = gohelper.findChild(rewardItem.go, "go_receive/go_hasget"):GetComponent(typeof(UnityEngine.Animator))

			table.insert(self._rewardItemTab, rewardItem)
		end

		gohelper.setActive(self._rewardItemTab[i].go, true)

		local itemCo = string.splitToNumber(rewards[i], "#")

		self._rewardItemTab[i].icon:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self._rewardItemTab[i].icon:setCountFontSize(42)
		self._rewardItemTab[i].icon:setScale(0.5)
	end

	for i = self._rewardCount + 1, #self._rewardItemTab do
		gohelper.setActive(self._rewardItemTab[i].go, false)
	end
end

function VersionActivity1_9WarmUpView:_onRewardRefresh(viewName)
	if viewName == ViewName.CommonPropView then
		for key, item in pairs(self._rewardItemTab) do
			gohelper.setActive(item.gocanget, false)
		end

		self:_onGetRewardAnim(VersionActivity1_9WarmUpView.AnimSwitchMode.UnFinish2Finish)
	end
end

function VersionActivity1_9WarmUpView:_onGetRewardAnim(switchMode)
	self.viewContainer:setIsPlayingDesc(false)

	local animName = switchMode == VersionActivity1_9WarmUpView.AnimSwitchMode.UnFinish2Finish and "go_hasget_in" or "go_hasget_idle"

	for i = 1, self._rewardCount do
		gohelper.setActive(self._rewardItemTab[i].goreceive, true)
		self._rewardItemTab[i].hasgetAnim:Play(animName, 0, 0)
	end
end

function VersionActivity1_9WarmUpView:_onDailyRefresh()
	if self._actId then
		Activity125Controller.instance:getAct125InfoFromServer(self._actId)
	end
end

function VersionActivity1_9WarmUpView:_checkPlayDesc()
	local isRecevied = Activity125Model.instance:isEpisodeFinished(self._actId, self:getCurSelectedEpisode())
	local localPlay = Activity125Model.instance:checkLocalIsPlay(self._actId, self:getCurSelectedEpisode())
	local isOld = Activity125Model.instance:checkIsOldEpisode(self._actId, self:getCurSelectedEpisode())

	if isOld and not isRecevied and not localPlay then
		self:playDesc()
	end
end

function VersionActivity1_9WarmUpView:playDesc()
	if self.viewContainer:isPlayingDesc() then
		return
	end

	local co = Activity125Config.instance:getEpisodeConfig(self._actId, self:getCurSelectedEpisode())

	self.viewContainer:setIsPlayingDesc(true)

	self.desctime = co.time or 5

	self._playEpisodeDesc(self, self.desctime, self._onPlayEpisodeDescFinished, self)

	self._scrollCanvasGroup.blocksRaycasts = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_loop)
end

function VersionActivity1_9WarmUpView:_playEpisodeDesc(duration, playFinishCallBack, playFinishCallBackObj)
	self:_onKillTween()

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, duration, self.everyFrame, playFinishCallBack, playFinishCallBackObj, nil)

	gohelper.setActive(self._goWrongChannel, false)
end

function VersionActivity1_9WarmUpView:everyFrame(value)
	self._rectmask2D.padding = Vector4(0, Mathf.Lerp(0, self._bottom, value), 0, 0)
end

function VersionActivity1_9WarmUpView:_onPlayEpisodeDescFinished()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	self:_checkIsPlayingButNoCompeleteDesc()
	self.viewContainer:setIsPlayingDesc(false)

	if Activity125Model.instance:isEpisodeFinished(self._actId, self:getCurSelectedEpisode()) then
		return
	end

	Activity125Model.instance:setLocalIsPlay(self._actId, self:getCurSelectedEpisode())
	self:refreshUI()
	Activity125Controller.instance:dispatchEvent(Activity125Event.EpisodeUnlock)
end

function VersionActivity1_9WarmUpView:_checkIsPlayingButNoCompeleteDesc()
	local distance = self._descHeight - self._bottom

	if distance > 0 then
		local pertime = self.desctime / self._bottom
		local movetime = distance * pertime

		if self._movetweenId then
			ZProj.TweenHelper.KillById(self._movetweenId)

			self._movetweenId = nil
		end

		self._movetweenId = ZProj.TweenHelper.DOLocalMoveY(self._txtTaskContent.transform, distance, movetime, self._playDescFinish, self)
	end
end

function VersionActivity1_9WarmUpView:_playDescFinish()
	self._scrollCanvasGroup.blocksRaycasts = true

	if self._movetweenId then
		ZProj.TweenHelper.KillById(self._movetweenId)

		self._movetweenId = nil
	end
end

function VersionActivity1_9WarmUpView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_gudu_preheat)
end

function VersionActivity1_9WarmUpView:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	self:_onKillTween()

	if self._episodeItemTab then
		for _, v in pairs(self._episodeItemTab) do
			v.click:RemoveClickListener()
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	self._simageday:UnLoadImage()
end

function VersionActivity1_9WarmUpView:_onDragEnd(param, pointerEventData)
	local endDragPosX = pointerEventData.position.x

	if endDragPosX - self.startDragPosX < 0 then
		self:checkFinishEpisode(self._actId, self:getCurSelectedEpisode())
	end
end

function VersionActivity1_9WarmUpView:_onDragBegin(param, pointerEventData)
	self.startDragPosX = pointerEventData.position.x
end

function VersionActivity1_9WarmUpView:_onKillTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function VersionActivity1_9WarmUpView:checkFinishEpisode(activityId, episodeId)
	local isOpen = Activity125Model.instance:isEpisodeReallyOpen(activityId, episodeId)

	if not isOpen then
		return
	end

	local selectId = Activity125Model.instance:getSelectEpisodeId(activityId)
	local isOld = Activity125Model.instance:checkIsOldEpisode(activityId, episodeId)
	local isPlay = Activity125Model.instance:checkLocalIsPlay(activityId, episodeId)
	local isFinish = Activity125Model.instance:isEpisodeFinished(activityId, episodeId)
	local isSelelct = (isOld or isPlay or isFinish) and selectId == episodeId

	if isSelelct then
		return
	end

	Activity125Model.instance:setSelectEpisodeId(activityId, episodeId)

	if not isOld then
		Activity125Model.instance:setOldEpisode(activityId, episodeId)
	end

	self:_playScepterAnim()
end

function VersionActivity1_9WarmUpView:_playScepterAnim()
	self._isPlayScepterAnim = true

	gohelper.setActive(self._goguide, false)

	local day = self:getCurSelectedEpisode()
	local anim = "day_0" .. day

	self._animScepterPlayer:Play(anim, self._playScepterAnimFinish, self)
	gohelper.setActive(self._goguide, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_preheat)
end

function VersionActivity1_9WarmUpView:_playScepterAnimFinish()
	Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
	self:_activeScepter(true)

	self._isPlayScepterAnim = false
end

function VersionActivity1_9WarmUpView:_activeScepter(active)
	if active then
		local day = self:getCurSelectedEpisode()

		self._simageday:LoadImage(ResUrl.getV1a9WarmUpSingleBg(day))
	end

	gohelper.setActive(self._goTitle, active)
	gohelper.setActive(self._gostart, not active)

	local isActive = self._simageday.gameObject.activeSelf

	gohelper.setActive(self._simageday.gameObject, active)

	if active then
		if not isActive then
			self._animDayIcon:Play("open", 0, 0)
			self._animDayIcon:Update(0)
		end
	else
		self._animScepter:Play("idle", 0, 1)
		self._animScepter:Update(0)
	end
end

function VersionActivity1_9WarmUpView:_checkGuide()
	local isPlay = Activity125Model.instance:checkLocalIsPlay(self._actId, self:getCurSelectedEpisode())

	gohelper.setActive(self._goguide, not isPlay)
end

return VersionActivity1_9WarmUpView
