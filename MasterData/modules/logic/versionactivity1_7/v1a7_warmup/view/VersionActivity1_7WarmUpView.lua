-- chunkname: @modules/logic/versionactivity1_7/v1a7_warmup/view/VersionActivity1_7WarmUpView.lua

module("modules.logic.versionactivity1_7.v1a7_warmup.view.VersionActivity1_7WarmUpView", package.seeall)

local VersionActivity1_7WarmUpView = class("VersionActivity1_7WarmUpView", BaseView)

function VersionActivity1_7WarmUpView:onInitView()
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/LimitTime/#txt_LimitTime")
	self._goradiotaskitem = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	self._txtTaskTitle = gohelper.findChildText(self.viewGO, "Right/TaskPanel/#go_Title/#txt_TaskTitle")
	self._txtTaskFMChannelNum = gohelper.findChildText(self.viewGO, "Right/TaskPanel/Title/#txt_TaskFMChannelNum")
	self._scrollTaskDesc = gohelper.findChildScrollRect(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	self._goTaskDescViewPort = gohelper.findChild(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport")
	self._rectmask2D = self._goTaskDescViewPort:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	self._txtTaskContent = gohelper.findChildText(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "Right/RawardPanel/#scroll_Reward")
	self._goWrongChannel = gohelper.findChild(self.viewGO, "Right/TaskPanel/#go_WrongChannel")
	self._gorewarditem = gohelper.findChild(self.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	self._btngetreward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/RawardPanel/#btn_getreward")
	self._isPlayingEpisodeDesc = false
	self._bottom = 324

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_7WarmUpView:addEvents()
	self.addEventCb(self, Activity125Controller.instance, Activity125Event.DataUpdate, self.refreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onRewardRefresh, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self._btngetreward:AddClickListener(self._btngetrewardOnClick, self)
end

function VersionActivity1_7WarmUpView:removeEvents()
	self.removeEventCb(self, Activity125Controller.instance, Activity125Event.DataUpdate, self.refreshUI, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onRewardRefresh, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self._btngetreward:RemoveClickListener()
end

function VersionActivity1_7WarmUpView:_editableInitView()
	self._episodeItemTab = {}
	self._rewardItemTab = self:getUserDataTb_()
	self._goTaskScroll = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	self._goTaskContent = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	self._scrollCanvasGroup = gohelper.onceAddComponent(self._scrollTaskDesc.gameObject, typeof(UnityEngine.CanvasGroup))
	self._episodeCanGetInfoDict = {}
end

function VersionActivity1_7WarmUpView:_btngetrewardOnClick()
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

function VersionActivity1_7WarmUpView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = ActivityEnum.Activity.Activity1_7WarmUp

	Activity125Controller.instance:getAct125InfoFromServer(self._actId)
end

function VersionActivity1_7WarmUpView:refreshUI()
	self:_refreshData()
	self:_showDeadline()
	self:_initEpisodeList()
	self:_initRewards()
	self:_initView()
	self:_checkPlayDesc()
end

function VersionActivity1_7WarmUpView:_initView()
	local isRecevied = Activity125Model.instance:isEpisodeFinished(self._actId, self:getCurSelectedEpisode())
	local localPlay = Activity125Model.instance:checkLocalIsPlay(self._actId, self:getCurSelectedEpisode())
	local isOld = Activity125Model.instance:checkIsOldEpisode(self._actId, self:getCurSelectedEpisode())
	local cangetreward = not isRecevied and localPlay

	for key, item in pairs(self._rewardItemTab) do
		gohelper.setActive(item.gocanget, cangetreward)
		gohelper.setActive(item.goreceive, isRecevied and not self.viewContainer:isPlayingDesc())
	end

	gohelper.setActive(self._btngetreward.gameObject, cangetreward)

	if isRecevied or localPlay or isOld then
		self._rectmask2D.padding = Vector4(0, 0, 0, 0)

		gohelper.setActive(self._goWrongChannel, false)
	else
		self._rectmask2D.padding = Vector4(0, self._bottom, 0, 0)

		gohelper.setActive(self._goWrongChannel, true)
	end
end

function VersionActivity1_7WarmUpView:getCurSelectedEpisode()
	return Activity125Model.instance:getSelectEpisodeId(self._actId)
end

function VersionActivity1_7WarmUpView:_refreshData()
	local curSelectedLvId = self:getCurSelectedEpisode()
	local co = Activity125Config.instance:getEpisodeConfig(self._actId, curSelectedLvId)

	self._txtTaskContent.text = co.text
	self._descHeight = self._txtTaskContent.preferredHeight
	self._txtTaskTitle.text = co.name

	recthelper.setAnchorY(self._txtTaskContent.transform, 0)
	gohelper.setActive(self._goWrongChannel, true)
end

function VersionActivity1_7WarmUpView:_showDeadline()
	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 60)
end

function VersionActivity1_7WarmUpView:_onRefreshDeadline()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

VersionActivity1_7WarmUpView.AnimSwitchMode = {
	UnFinish2Finish = 3,
	Finish = 1,
	Finish2UnFinish = 4,
	UnFinish = 2,
	None = 0
}

function VersionActivity1_7WarmUpView:_initEpisodeList()
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

function VersionActivity1_7WarmUpView:_taskItemOnClick(episodeId)
	if self.viewContainer:isPlayingDesc() then
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
		GameFacade.showToast(ToastEnum.V1A7WarmupPreEpisodeLock)

		return
	end

	if curSelectedEpisodeId ~= episodeId then
		Activity125Model.instance:setSelectEpisodeId(self._actId, episodeId)
		Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function VersionActivity1_7WarmUpView:_initRewards()
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

function VersionActivity1_7WarmUpView:_onRewardRefresh(viewName)
	if viewName == ViewName.CommonPropView then
		for key, item in pairs(self._rewardItemTab) do
			gohelper.setActive(item.gocanget, false)
		end

		self:_onGetRewardAnim(VersionActivity1_7WarmUpView.AnimSwitchMode.UnFinish2Finish)
	end
end

function VersionActivity1_7WarmUpView:_onGetRewardAnim(switchMode)
	self.viewContainer:setIsPlayingDesc(false)

	local animName = switchMode == VersionActivity1_7WarmUpView.AnimSwitchMode.UnFinish2Finish and "go_hasget_in" or "go_hasget_idle"

	for i = 1, self._rewardCount do
		gohelper.setActive(self._rewardItemTab[i].goreceive, true)
		self._rewardItemTab[i].hasgetAnim:Play(animName, 0, 0)
	end
end

function VersionActivity1_7WarmUpView:_onDailyRefresh()
	if self._actId then
		Activity125Controller.instance:getAct125InfoFromServer(self._actId)
	end
end

function VersionActivity1_7WarmUpView:_checkPlayDesc()
	local isRecevied = Activity125Model.instance:isEpisodeFinished(self._actId, self:getCurSelectedEpisode())
	local localPlay = Activity125Model.instance:checkLocalIsPlay(self._actId, self:getCurSelectedEpisode())
	local isOld = Activity125Model.instance:checkIsOldEpisode(self._actId, self:getCurSelectedEpisode())

	if isOld and not isRecevied and not localPlay then
		self:playDesc()
	end
end

function VersionActivity1_7WarmUpView:playDesc()
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

function VersionActivity1_7WarmUpView:_playEpisodeDesc(duration, playFinishCallBack, playFinishCallBackObj)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, duration, self.everyFrame, playFinishCallBack, playFinishCallBackObj, nil)

	gohelper.setActive(self._goWrongChannel, false)
end

function VersionActivity1_7WarmUpView:everyFrame(value)
	self._rectmask2D.padding = Vector4(0, Mathf.Lerp(0, self._bottom, value), 0, 0)
end

function VersionActivity1_7WarmUpView:_onPlayEpisodeDescFinished()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	self.viewContainer:setIsPlayingDesc(false)
	self:_checkIsPlayingButNoCompeleteDesc()

	if Activity125Model.instance:isEpisodeFinished(self._actId, self:getCurSelectedEpisode()) then
		return
	end

	Activity125Model.instance:setLocalIsPlay(self._actId, self:getCurSelectedEpisode())
	self:refreshUI()
	Activity125Controller.instance:dispatchEvent(Activity125Event.EpisodeUnlock)
end

function VersionActivity1_7WarmUpView:_checkIsPlayingButNoCompeleteDesc()
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

function VersionActivity1_7WarmUpView:onClose()
	return
end

function VersionActivity1_7WarmUpView:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._episodeItemTab then
		for _, v in pairs(self._episodeItemTab) do
			v.click:RemoveClickListener()
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
end

return VersionActivity1_7WarmUpView
