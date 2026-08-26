-- chunkname: @modules/logic/versionactivity1_6/v1a6_warmup/view/VersionActivity1_6WarmUpView.lua

module("modules.logic.versionactivity1_6.v1a6_warmup.view.VersionActivity1_6WarmUpView", package.seeall)

local VersionActivity1_6WarmUpView = class("VersionActivity1_6WarmUpView", BaseView)

function VersionActivity1_6WarmUpView:onInitView()
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/LimitTime/#txt_LimitTime")
	self._scrollTaskTabList = gohelper.findChildScrollRect(self.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	self._goradiotaskitem = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	self._txtTaskTitle = gohelper.findChildText(self.viewGO, "Right/TaskPanel/Title/#txt_TaskTitle")
	self._txtTaskFMChannelNum = gohelper.findChildText(self.viewGO, "Right/TaskPanel/Title/#txt_TaskFMChannelNum")
	self._scrollTaskDesc = gohelper.findChildScrollRect(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	self._goTaskDescViewPort = gohelper.findChild(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport")
	self._rectmask2D = self._goTaskDescViewPort:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	self._txtTaskContent = gohelper.findChildText(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "Right/RawardPanel/#scroll_Reward")
	self._goWrongChannel = gohelper.findChild(self.viewGO, "Right/TaskPanel/#go_WrongChannel")
	self._gorewarditem = gohelper.findChild(self.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Middle/titlebg/#txt_title")
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_play")
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_replay")
	self._btngetreward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/RawardPanel/#btn_getreward")
	self._goMiddle = gohelper.findChildSingleImage(self.viewGO, "Middle")
	self._txtmusictime = gohelper.findChildText(self.viewGO, "Middle/#go_playing/#txt_time")
	self._middleAnim = self._goMiddle:GetComponent(typeof(UnityEngine.Animator))
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._isPlayingEpisodeDesc = false
	self.isGetingReward = false
	self._isReselectCloseFunc = false
	self._bottom = 400

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_6WarmUpView:addEvents()
	Activity156Controller.instance:registerCallback(Activity156Event.DataUpdate, self.refreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onRewardRefresh, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self._btnplay:AddClickListener(self._playSong, self)
	self._btnreplay:AddClickListener(self._playSong, self)
	self._btngetreward:AddClickListener(self._btngetrewardOnClick, self)
end

function VersionActivity1_6WarmUpView:removeEvents()
	Activity156Controller.instance:unregisterCallback(Activity156Event.DataUpdate, self.refreshUI, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onRewardRefresh, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self._btnplay:RemoveClickListener()
	self._btnreplay:RemoveClickListener()
	self._btngetreward:RemoveClickListener()
end

function VersionActivity1_6WarmUpView:_editableInitView()
	self._episodeItemTab = {}
	self._rewardItemTab = self:getUserDataTb_()
	self._goTaskContent = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	self._scrollCanvasGroup = gohelper.onceAddComponent(self._scrollTaskDesc.gameObject, typeof(UnityEngine.CanvasGroup))
	self._episodeCanGetInfoDict = {}
end

function VersionActivity1_6WarmUpView:_btngetrewardOnClick()
	Activity156Controller.instance:tryReceiveEpisodeRewards(self._actId)
end

function VersionActivity1_6WarmUpView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = ActivityEnum.Activity.Activity1_6WarmUp
	self._config = Activity156Config.instance:getAct156Config(self._actId)

	Activity156Controller.instance:getAct125InfoFromServer(self._actId)
end

function VersionActivity1_6WarmUpView:refreshUI()
	self:_refreshData()
	self:_showDeadline()
	self:_initEpisodeList()
	self:_initRewards()
	self:_initView()
end

function VersionActivity1_6WarmUpView:_initView()
	local isRecevied = Activity156Model.instance:isEpisodeHasReceivedReward(self._curSelectedLvId)
	local localPlay = Activity156Model.instance:checkLocalIsPlay(self._curSelectedLvId)

	if localPlay then
		if isRecevied then
			for key, item in pairs(self._rewardItemTab) do
				gohelper.setActive(item.gocanget, false)
			end
		else
			for key, item in pairs(self._rewardItemTab) do
				gohelper.setActive(item.gocanget, true)
			end

			gohelper.setActive(self._btngetreward.gameObject, true)
		end
	else
		gohelper.setActive(self._btngetreward.gameObject, false)
	end

	if isRecevied or localPlay then
		self._rectmask2D.padding = Vector4(0, 0, 0, 0)

		gohelper.setActive(self._goWrongChannel, false)
	else
		self._rectmask2D.padding = Vector4(0, self._bottom, 0, 0)

		gohelper.setActive(self._goWrongChannel, true)
	end

	gohelper.setActive(self._btnreplay.gameObject, localPlay)
	gohelper.setActive(self._btnplay.gameObject, not localPlay)
end

function VersionActivity1_6WarmUpView:_refreshData()
	self._curSelectedLvId = Activity156Model.instance:getCurSelectedEpisode()

	if not self._curSelectedLvId then
		self._curSelectedLvId = Activity156Model.instance:getLastEpisode()

		Activity156Model.instance:setCurSelectedEpisode(self._curSelectedLvId)
	end

	local co = Activity156Config.instance:getEpisodeConfig(self._curSelectedLvId)

	self._descHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(self._txtTaskContent, co.text)
	self._txtTaskContent.text = co.text

	local co = Activity156Config.instance:getEpisodeConfig(self._curSelectedLvId)

	self._txtTitle.text = co.name

	recthelper.setAnchorY(self._txtTaskContent.transform, 0)
	gohelper.setActive(self._goWrongChannel, true)
end

function VersionActivity1_6WarmUpView:_showDeadline()
	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 60)
end

function VersionActivity1_6WarmUpView:_onRefreshDeadline()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

VersionActivity1_6WarmUpView.AnimSwitchMode = {
	UnFinish2Finish = 3,
	Finish = 1,
	Finish2UnFinish = 4,
	UnFinish = 2,
	None = 0
}

function VersionActivity1_6WarmUpView:_initEpisodeList()
	local maxEpisodeCount = Activity156Config.instance:getEpisodeCount(self._actId)

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
			episodeItem.click = gohelper.findChildButton(go, "btn_click")

			episodeItem.click:AddClickListener(self._taskItemOnClick, self, i)

			self._episodeItemTab[i] = episodeItem
		end

		episodeItem.txtDateUnSelected.text = string.format("Day.%s", i)
		episodeItem.txtDateSelected.text = string.format("Day.%s", i)

		gohelper.setActive(episodeItem.episodeItemGo, true)

		local isSelect = i == self._curSelectedLvId

		gohelper.setActive(episodeItem.goDateSelected, isSelect)
		gohelper.setActive(episodeItem.txtDateUnSelected.gameObject, not isSelect)

		local isLock = not Activity156Model.instance:reallyOpen(self._actId, i)

		gohelper.setActive(episodeItem.goDateLocked, isLock)
	end

	ZProj.UGUIHelper.RebuildLayout(self._goTaskContent.transform)

	self._scrollTaskTabList.horizontalNormalizedPosition = self:_getScrollTargetValue(1, maxEpisodeCount, self._curSelectedLvId)
end

function VersionActivity1_6WarmUpView:_getScrollTargetValue(startValue, endValue, curValue)
	if curValue == 1 then
		return 0
	end

	return 1 / (endValue - startValue) * (curValue - startValue)
end

function VersionActivity1_6WarmUpView:_taskItemOnClick(episodeId)
	local curSelectedEpisodeId = Activity156Model.instance:getCurSelectedEpisode()
	local isTargetSelectEpisodeUnLock = Activity156Model.instance:isEpisodeUnLock(episodeId)
	local isOpen = Activity156Model.instance:isOpen(self._actId, episodeId)

	if not isOpen then
		return
	end

	function self._switchCallBack()
		TaskDispatcher.cancelTask(self._switchCallBack, self)

		local co = Activity156Config.instance:getEpisodeConfig(self._curSelectedLvId)

		self._txtTitle.text = co.name

		self:refreshUI()
	end

	if curSelectedEpisodeId ~= episodeId and isTargetSelectEpisodeUnLock then
		self._anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(self._switchCallBack, self, 0.3)
	end

	Activity156Controller.instance:setCurSelectedEpisode(episodeId, true)

	if not Activity156Model.instance:checkIsPlayingMusicId(episodeId) then
		self:_initMusic()
		self._middleAnim:Play("idle", 0, 0)
	end

	if self._isReselectCloseFunc then
		self:_revertViewCloseCheckFunc()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function VersionActivity1_6WarmUpView:_initRewards()
	local rewardBonus = self._config[self._curSelectedLvId].bonus
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

		local isFinished = Activity156Model.instance:isEpisodeFinished(self._curSelectedLvId)

		gohelper.setActive(self._rewardItemTab[i].goreceive, isFinished and not self.isGetingReward)

		local itemCo = string.splitToNumber(rewards[i], "#")

		self._rewardItemTab[i].icon:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self._rewardItemTab[i].icon:setCountFontSize(42)
		self._rewardItemTab[i].icon:setScale(0.5)
	end

	for i = self._rewardCount + 1, #self._rewardItemTab do
		gohelper.setActive(self._rewardItemTab[i].go, false)
	end
end

function VersionActivity1_6WarmUpView:_onRewardRefresh(viewName)
	if viewName == ViewName.CommonPropView then
		for key, item in pairs(self._rewardItemTab) do
			gohelper.setActive(item.gocanget, false)
		end

		self:_onGetRewardAnim(VersionActivity1_6WarmUpView.AnimSwitchMode.UnFinish2Finish)
	end
end

function VersionActivity1_6WarmUpView:_onGetRewardAnim(switchMode)
	local animName = switchMode == VersionActivity1_6WarmUpView.AnimSwitchMode.UnFinish2Finish and "go_hasget_in" or "go_hasget_idle"

	for i = 1, self._rewardCount do
		gohelper.setActive(self._rewardItemTab[i].goreceive, true)
		self._rewardItemTab[i].hasgetAnim:Play(animName, 0, 0)
	end

	self.isGetingReward = false
end

function VersionActivity1_6WarmUpView:_onDailyRefresh()
	if self._actId then
		Activity156Controller.instance:getAct125InfoFromServer(self._actId)
	end
end

function VersionActivity1_6WarmUpView:_messageBoxYesFunc()
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function VersionActivity1_6WarmUpView:_checkIsPlayingDesc()
	local localPlay = Activity156Model.instance:checkLocalIsPlay(self._curSelectedLvId)

	if self._isPlayingEpisodeDesc and not localPlay then
		GameFacade.showMessageBox(MessageBoxIdDefine.V1a5_WarmUpPlayingQuitCheck, MsgBoxEnum.BoxType.Yes_No, self._messageBoxYesFunc, nil, nil, self, self)
	end
end

function VersionActivity1_6WarmUpView:_overrideViewCloseCheckFunc()
	local beginnerViewContainer = ViewMgr.instance:getContainer(ViewName.ActivityBeginnerView)

	if beginnerViewContainer then
		local navigationView = beginnerViewContainer.navigationView

		if navigationView then
			self._originCloseCheckFunc = navigationView._closeCheckFunc
			self._originCloseCheckObj = navigationView._closeCheckObj
			self._originHomeCheckFunc = navigationView._homeCheckFunc
			self._originHomeCheckObj = navigationView._homeCheckObj

			navigationView:setCloseCheck(self._checkIsPlayingDesc, self)
			navigationView:setHomeCheck(self._checkIsPlayingDesc, self)
		end
	end

	self._isReselectCloseFunc = true
end

function VersionActivity1_6WarmUpView:_revertViewCloseCheckFunc()
	local beginnerViewContainer = ViewMgr.instance:getContainer(ViewName.ActivityBeginnerView)

	if beginnerViewContainer then
		local navigationView = beginnerViewContainer.navigationView

		if navigationView then
			navigationView:setCloseCheck(self._originCloseCheckFunc, self._originCloseCheckObj)
			navigationView:setHomeCheck(self._originHomeCheckFunc, self._originHomeCheckObj)
		end
	end

	self._originCloseCheckFunc = nil
	self._originCloseCheckObj = nil
	self._originHomeCheckFunc = nil
	self._originHomeCheckObj = nil
	self._isReselectCloseFunc = false
end

function VersionActivity1_6WarmUpView:_playSong()
	if Activity156Model.instance:checkIsPlayingMusicId(self._curSelectedLvId) then
		return
	end

	local co = Activity156Config.instance:getEpisodeConfig(self._curSelectedLvId)
	local audioId = Activity156Enum.DayToMusic[self._curSelectedLvId]

	self:_initMusic()

	local localPlay = Activity156Model.instance:checkLocalIsPlay(self._curSelectedLvId)

	if not localPlay then
		self:_overrideViewCloseCheckFunc()
	end

	self.playaudioId = AudioMgr.instance:trigger(audioId)

	Activity156Model.instance:setIsPlayingMusicId(self._curSelectedLvId)

	self.desctime = co.time
	self.musictime = co.musictime or 10
	self._txtmusictime.text = formatLuaLang("VersionActivity1_6WarmUpView_musictime", self.musictime)

	self._playEpisodeDesc(self, self.desctime, self._onPlayEpisodeDescFinished, self)

	self._scrollCanvasGroup.blocksRaycasts = false

	TaskDispatcher.runDelay(self._playsongcallback, self, self.musictime)
	self._middleAnim:Update(0)
	self._middleAnim:Play("play", 0, 0)
	TaskDispatcher.runRepeat(self._remainMusicTime, self, 1, self.musictime)
end

function VersionActivity1_6WarmUpView:_remainMusicTime()
	self.musictime = self.musictime - 1
	self._txtmusictime.text = formatLuaLang("VersionActivity1_6WarmUpView_musictime", self.musictime)

	if self.musictime == 0 then
		TaskDispatcher.cancelTask(self._remainMusicTime, self)

		return
	end
end

function VersionActivity1_6WarmUpView:_playsongcallback()
	self._middleAnim:Play("close", 0, 0)
	self:_initMusic()
end

function VersionActivity1_6WarmUpView:_onPlayEpisodeDescFinished()
	self._isPlayingEpisodeDesc = false

	self:_revertViewCloseCheckFunc()
	self:_checkIsPlayingButNoCompeleteDesc()

	if Activity156Model.instance:isEpisodeHasReceivedReward(self._curSelectedLvId) then
		return
	end

	self.isGetingReward = true

	Activity156Model.instance:setLocalIsPlay(self._curSelectedLvId)

	for key, item in pairs(self._rewardItemTab) do
		gohelper.setActive(item.gocanget, true)
	end

	Activity156Controller.instance:setCurSelectedEpisode(self._curSelectedLvId)
	gohelper.setActive(self._btngetreward.gameObject, true)
	gohelper.setActive(self._btnreplay.gameObject, true)

	self._scrollCanvasGroup.blocksRaycasts = true
end

function VersionActivity1_6WarmUpView:_playEpisodeDesc(duration, playFinishCallBack, playFinishCallBackObj)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, duration, self.everyFrame, playFinishCallBack, playFinishCallBackObj, nil)

	gohelper.setActive(self._goWrongChannel, false)

	self._isPlayingEpisodeDesc = true
end

function VersionActivity1_6WarmUpView:everyFrame(value)
	self._rectmask2D.padding = Vector4(0, Mathf.Lerp(0, self._bottom, value), 0, 0)
end

function VersionActivity1_6WarmUpView:_checkIsPlayingButNoCompeleteDesc()
	if self.playaudioId then
		local distance = self._descHeight - self._bottom

		if distance > 0 then
			local pertime = self.desctime / self._bottom
			local movetime = distance * pertime

			if self._movetweenId then
				ZProj.TweenHelper.KillById(self._movetweenId)

				self._movetweenId = nil
			end

			self._movetweenId = ZProj.TweenHelper.DOLocalMoveY(self._txtTaskContent.transform, distance, movetime)
		end
	end
end

function VersionActivity1_6WarmUpView:_initMusic()
	if self.playaudioId then
		self:_stopAudio()

		self.playaudioId = nil

		if self._playsongcallback then
			TaskDispatcher.cancelTask(self._playsongcallback, self)

			self._playsongcallback = nil
		end

		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)

			self._tweenId = nil
		end

		if self._movetweenId then
			ZProj.TweenHelper.KillById(self._movetweenId)

			self._movetweenId = nil
		end

		Activity156Model.instance:cleanIsPlayingMusicId()

		self._scrollCanvasGroup.blocksRaycasts = true

		TaskDispatcher.cancelTask(self._remainMusicTime, self)
	end
end

function VersionActivity1_6WarmUpView:onClose()
	Activity156Model.instance:cleanCurSelectedEpisode()
	Activity156Model.instance:cleanIsPlayingMusicId()
	self:_initMusic()
	self:_revertViewCloseCheckFunc()
end

function VersionActivity1_6WarmUpView:_stopAudio()
	AudioMgr.instance:trigger(AudioEnum.ui_andamtte1_6_music.stop_ui_andamtte1_6_music)
end

function VersionActivity1_6WarmUpView:onDestroyView()
	TaskDispatcher.cancelTask(self._switchCallBack, self)
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.cancelTask(self._playsongcallback, self)
	TaskDispatcher.cancelTask(self._remainMusicTime, self)

	if self._episodeItemTab then
		for _, v in pairs(self._episodeItemTab) do
			v.click:RemoveClickListener()

			v = nil
		end
	end

	self._config = nil
end

return VersionActivity1_6WarmUpView
