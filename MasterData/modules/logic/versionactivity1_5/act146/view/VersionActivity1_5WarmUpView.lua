-- chunkname: @modules/logic/versionactivity1_5/act146/view/VersionActivity1_5WarmUpView.lua

module("modules.logic.versionactivity1_5.act146.view.VersionActivity1_5WarmUpView", package.seeall)

local VersionActivity1_5WarmUpView = class("VersionActivity1_5WarmUpView", BaseView)

function VersionActivity1_5WarmUpView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/LimitTime/#txt_LimitTime")
	self._scrollTaskTabList = gohelper.findChildScrollRect(self.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	self._goradiotaskitem = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	self._scrollTaskDesc = gohelper.findChildScrollRect(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	self._txtTaskContent = gohelper.findChildText(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "Right/RawardPanel/#scroll_Reward")
	self._goWrongChannel = gohelper.findChild(self.viewGO, "Right/TaskPanel/#go_WrongChannel")
	self._gorewarditem = gohelper.findChild(self.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	self._godragarea = gohelper.findChild(self.viewGO, "Middle/#go_dragarea")
	self._goTitle = gohelper.findChild(self.viewGO, "Right/TaskPanel/#go_Title")
	self._txtTaskTitle = gohelper.findChildText(self.viewGO, "Right/TaskPanel/#go_Title/#txt_TaskTitle")
	self._btngetreward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/RawardPanel/#btn_getreward")
	self._imagePhoto2 = gohelper.findChildImage(self.viewGO, "Middle/#go_mail2/#image_Photo2")
	self._goguide1 = gohelper.findChild(self.viewGO, "Middle/#go_guide1")
	self._goguide2 = gohelper.findChild(self.viewGO, "Middle/#go_guide2")
	self._gomail1 = gohelper.findChild(self.viewGO, "Middle/#go_mail1")
	self._imageTipsBG1 = gohelper.findChild(self.viewGO, "Middle/#go_mail1/#image_TipsBG1")
	self._gomail2 = gohelper.findChild(self.viewGO, "Middle/#go_mail2")
	self._imageTipsBG2 = gohelper.findChild(self.viewGO, "Middle/#go_mail2/#image_TipsBG2")
	self._imagePhoto = gohelper.findChildImage(self.viewGO, "Middle/#go_mail1/image_Envelop/#image_Photo")
	self._imagePhotoMask1 = gohelper.findChildImage(self.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask1")
	self._imagePhotoMask2 = gohelper.findChildImage(self.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask2")
	self._imagePhotoMask3 = gohelper.findChildImage(self.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5WarmUpView:addEvents()
	self.addEventCb(self, Activity146Controller.instance, Activity146Event.DataUpdate, self.refreshUI, self)
	self.addEventCb(self, Activity146Controller.instance, Activity146Event.OnEpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self._btngetreward:AddClickListener(self._btngetrewardOnClick, self)
end

function VersionActivity1_5WarmUpView:removeEvents()
	self.removeEventCb(self, Activity146Controller.instance, Activity146Event.DataUpdate, self.refreshUI, self)
	self.removeEventCb(self, Activity146Controller.instance, Activity146Event.OnEpisodeFinished, self._onEpisodeFinished, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self._btngetreward:RemoveClickListener()
end

function VersionActivity1_5WarmUpView:_editableInitView()
	self._episodeItemTab = self:getUserDataTb_()
	self._rewardItemTab = self:getUserDataTb_()
	self._goRewardContent = gohelper.findChild(self.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content")
	self._goTaskContent = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	self._dragAreaCanvasGroup = gohelper.onceAddComponent(self._godragarea, typeof(UnityEngine.CanvasGroup))
	self._viewGOCanvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))

	local goMiddle = gohelper.findChild(self.viewGO, "Middle")

	self._middleAnim = gohelper.onceAddComponent(goMiddle, typeof(UnityEngine.Animator))
	self._tipsBG1Anim = gohelper.onceAddComponent(self._imageTipsBG1, typeof(UnityEngine.Animator))
	self._tipsBG2Anim = gohelper.onceAddComponent(self._imageTipsBG2, typeof(UnityEngine.Animator))
	self._viewGOAnim = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))

	gohelper.setActive(self._gomail1, false)
	gohelper.setActive(self._gomail2, false)

	self._episodeCanGetInfoDict = {}
end

function VersionActivity1_5WarmUpView:onUpdateParam()
	return
end

function VersionActivity1_5WarmUpView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = self.viewParam.actId

	Activity146Controller.instance:getAct146InfoFromServer(self._actId)
end

function VersionActivity1_5WarmUpView:refreshUI()
	self:_showDeadline()
	self:_initEpisodeList()
	self:_realRefreshEpisodeUI()
	self:_refreshGuide()
	self:_initRewards()
	Activity146Controller.instance:markHasEnterEpisode()
end

function VersionActivity1_5WarmUpView:_showDeadline()
	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 60)
end

function VersionActivity1_5WarmUpView:_onRefreshDeadline()
	local day, hour, minute = ActivityModel.instance:getRemainTime(self._actId)

	self._txtLimitTime.text = string.format(luaLang("verionactivity1_3radioview_remaintime"), day, hour)

	if day <= 0 and hour <= 0 and minute <= 0 then
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	end
end

VersionActivity1_5WarmUpView.DelaySwitchPhotoTime = 0.3

function VersionActivity1_5WarmUpView:_fakeRefreshEpisodeUI(episodeId, isFinished)
	gohelper.setActive(self._goWrongChannel, not isFinished)
	gohelper.setActive(self._godragarea, not isFinished)
	gohelper.setActive(self._goTitle, isFinished)
	gohelper.setActive(self._scrollTaskDesc.gameObject, isFinished)

	self._dragAreaCanvasGroup.alpha = isFinished and 0 or 1
	self._txtTaskContent.text = tostring(Activity146Config.instance:getEpisodeDesc(self._actId, episodeId))

	if self._isNeedDelaySwitchPhoto then
		if not VersionActivity1_5WarmUpView.DelaySwitchPhotoTime then
			local delaySwitchTime = 0

			self._fakeEpisodeId = episodeId
			self._fakeEpisodeState = isFinished

			TaskDispatcher.cancelTask(self._delaySwitchPhoto, self)
			TaskDispatcher.runDelay(self._delaySwitchPhoto, self, delaySwitchTime)

			self._isNeedDelaySwitchPhoto = false
		end
	end
end

function VersionActivity1_5WarmUpView:_delaySwitchPhoto()
	local episodeId = self._fakeEpisodeId
	local isFinished = self._fakeEpisodeState

	UISpriteSetMgr.instance:setV1a5WarmUpSprite(self._imagePhoto2, "v1a5_warmup_photo" .. episodeId)
	UISpriteSetMgr.instance:setV1a5WarmUpSprite(self._imagePhoto, "v1a5_warmup_photo" .. episodeId)
	gohelper.setActive(self._imagePhotoMask1.gameObject, not isFinished)
	gohelper.setActive(self._imagePhotoMask2.gameObject, not isFinished)
	gohelper.setActive(self._imagePhotoMask3.gameObject, not isFinished)
	gohelper.setActive(self._gomail1, episodeId == 1)
	gohelper.setActive(self._gomail2, episodeId ~= 1)

	local isEpisode_1_Finish = episodeId == 1 and isFinished
	local isEpisode_1_RealFinish = episodeId == 1 and Activity146Model.instance:isEpisodeFinished(episodeId)
	local stateInfo = self._middleAnim:GetCurrentAnimatorStateInfo(0)
	local isUnNeedSwitchMiddleAnim = stateInfo:IsName("open") and isEpisode_1_Finish

	if not isUnNeedSwitchMiddleAnim then
		if isEpisode_1_Finish then
			local normalizedTime = isEpisode_1_RealFinish and 1 or 0

			self._middleAnim:Play("open", 0, normalizedTime)
		else
			self._middleAnim:Play("idle", 0, 0)
		end
	end

	local tipsAnimName = isFinished and "close" or "open"

	self._tipsBG1Anim:Play(tipsAnimName, 0, 0)
	self._tipsBG2Anim:Play(tipsAnimName, 0, 0)
end

function VersionActivity1_5WarmUpView:_realRefreshEpisodeUI()
	local curSelectedEpisodeId = Activity146Model.instance:getCurSelectedEpisode()
	local isFinished = Activity146Model.instance:isEpisodeFinished(curSelectedEpisodeId)

	self:_fakeRefreshEpisodeUI(curSelectedEpisodeId, isFinished)

	self._txtTaskTitle.text = tostring(Activity146Config.instance:getEpisodeTitle(self._actId, curSelectedEpisodeId))

	gohelper.setActive(self._imageTipsBG1, not isFinished)
	gohelper.setActive(self._imageTipsBG2, not isFinished)
end

function VersionActivity1_5WarmUpView:_refreshGuide()
	local curEpisode = Activity146Model.instance:getCurSelectedEpisode()
	local isFinished = Activity146Model.instance:isEpisodeFinished(curEpisode)
	local isFirstEnter = Activity146Model.instance:isEpisodeFirstEnter(curEpisode)

	gohelper.setActive(self._goguide1, curEpisode == 1 and not isFinished and isFirstEnter)
	gohelper.setActive(self._goguide2, curEpisode == 2 and not isFinished and isFirstEnter)
end

local episodeTxtPlayDuration = 6

function VersionActivity1_5WarmUpView:_onEpisodeFinished()
	local curSelectedEpisodeId = Activity146Model.instance:getCurSelectedEpisode()

	self:_fakeRefreshEpisodeUI(curSelectedEpisodeId, true)

	self._viewGOCanvasGroup.blocksRaycasts = false

	self:_overrideViewCloseCheckFunc()
	ActivityController.instance:dispatchEvent(ActivityEvent.SetBannerViewCategoryListInteract, false)

	local fmTxt = tostring(Activity146Config.instance:getEpisodeDesc(self._actId, curSelectedEpisodeId))

	self._playEpisodeDesc(self, "", fmTxt, episodeTxtPlayDuration, self._onPlayEpisodeDescFinished, self)

	if curSelectedEpisodeId == 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_opening)
	end
end

function VersionActivity1_5WarmUpView:_playEpisodeDesc(hasPlayTxt, wholeTxt, duration, playFinishCallBack, playFinishCallBackObj)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	local wholeTxtLengthen = GameUtil.utf8len(wholeTxt)
	local hasPlayTxtLengthen = GameUtil.utf8len(hasPlayTxt)

	if wholeTxtLengthen > 0 then
		if not (hasPlayTxtLengthen / wholeTxtLengthen) then
			local progress = 0
			local remainDuration = duration * (1 - progress)

			self._txtTaskContent.text = hasPlayTxt
			self._tweenId = ZProj.TweenHelper.DOText(self._txtTaskContent, wholeTxt, remainDuration, playFinishCallBack, playFinishCallBackObj)
			self._isPlayingEpisodeDesc = true

			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_loop)
		end
	end
end

function VersionActivity1_5WarmUpView:_onPlayEpisodeDescFinished()
	self._viewGOCanvasGroup.blocksRaycasts = true

	gohelper.setActive(self._btngetreward.gameObject, true)

	self._isPlayingEpisodeDesc = false

	self:_revertViewCloseCheckFunc()
	ActivityController.instance:dispatchEvent(ActivityEvent.SetBannerViewCategoryListInteract, true)
	Activity146Controller.instance:onFinishActEpisode(self._actId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
end

function VersionActivity1_5WarmUpView:_initEpisodeList()
	local allEpisodeList = Activity146Config.instance:getAllEpisodeConfigs(self._actId)
	local curSelectEpisodeId = Activity146Model.instance:getCurSelectedEpisode()
	local useMap = {}

	if allEpisodeList then
		for index, episodeCfg in ipairs(allEpisodeList) do
			local episodeItem = self:_getOrCreateEpisodeItem(episodeCfg.id)

			gohelper.setActive(episodeItem.episodeItemGo, episodeCfg ~= nil)

			if episodeCfg then
				episodeItem.txtDateUnSelected.text = string.format("Day.%s", index)
				episodeItem.txtDateSelected.text = string.format("Day.%s", index)

				local isEpisodeUnLock = Activity146Model.instance:isEpisodeUnLock(episodeCfg.id)
				local isSelected = episodeCfg.id == curSelectEpisodeId

				gohelper.setActive(episodeItem.goDateSelected, isSelected)
				gohelper.setActive(episodeItem.txtDateUnSelected.gameObject, not isSelected)
				gohelper.setActive(episodeItem.goLocked, not isEpisodeUnLock)
			end

			useMap[episodeItem] = true
		end
	end

	self:_recycleUnUsefulEpisodeItem(useMap)
	ZProj.UGUIHelper.RebuildLayout(self._goTaskContent.transform)

	self._scrollTaskTabList.horizontalNormalizedPosition = Mathf.Lerp(0, 1, (curSelectEpisodeId - 1) / (#allEpisodeList - 1))
end

function VersionActivity1_5WarmUpView:_getOrCreateEpisodeItem(episodeId)
	self._episodeItemTab = self._episodeItemTab or {}

	local episodeItem = self._episodeItemTab[episodeId]

	if not episodeItem then
		local episodeItemGo = gohelper.cloneInPlace(self._goradiotaskitem, "taskItem" .. episodeId)
		local txtDateUnSelected = gohelper.findChildText(episodeItemGo, "txt_DateUnSelected")
		local goDateSelected = gohelper.findChild(episodeItemGo, "image_Selected")
		local txtDateSelected = gohelper.findChildText(episodeItemGo, "image_Selected/txt_DateSelected")
		local finishEffectGo = gohelper.findChild(episodeItemGo, "image_Selected/Wave_effect2")
		local imagewave = gohelper.findChildImage(episodeItemGo, "image_Selected/image_wave")
		local goDateLocked = gohelper.findChild(episodeItemGo, "image_Locked")
		local click = gohelper.findChildButtonWithAudio(episodeItemGo, "btn_click")

		click:AddClickListener(self._taskItemOnClick, self, episodeId)

		episodeItem = {
			episodeItemGo = episodeItemGo,
			goDateSelected = goDateSelected,
			txtDateSelected = txtDateSelected,
			imagewave = imagewave,
			finishEffectGo = finishEffectGo,
			goLocked = goDateLocked,
			txtDateUnSelected = txtDateUnSelected,
			click = click
		}
		self._episodeItemTab[episodeId] = episodeItem
	end

	return episodeItem
end

function VersionActivity1_5WarmUpView:_taskItemOnClick(episodeId)
	local curSelectedEpisodeId = Activity146Model.instance:getCurSelectedEpisode()
	local isTargetSelectEpisodeUnLock = Activity146Model.instance:isEpisodeUnLock(episodeId)

	if curSelectedEpisodeId ~= episodeId and isTargetSelectEpisodeUnLock then
		self._viewGOAnim:Play("switch", 0, 0)

		self._isNeedDelaySwitchPhoto = true
	end

	Activity146Controller.instance:setCurSelectedEpisode(episodeId)

	local nextSelectedEpisodeId = Activity146Model.instance:getCurSelectedEpisode()
	local isFinished = Activity146Model.instance:isEpisodeFinished(nextSelectedEpisodeId)

	gohelper.setActive(self._imageTipsBG1.gameObject, not isFinished)
	gohelper.setActive(self._imageTipsBG2.gameObject, not isFinished)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_day_tap)
end

function VersionActivity1_5WarmUpView:_recycleUnUsefulEpisodeItem(useMap)
	if useMap then
		for _, v in pairs(self._episodeItemTab) do
			if not useMap[v] then
				gohelper.setActive(v.episodeItemGo, false)
			end
		end
	end
end

function VersionActivity1_5WarmUpView:_initRewards()
	local curSelectedEpisode = Activity146Model.instance:getCurSelectedEpisode()
	local rewards = Activity146Config.instance:getEpisodeRewardConfig(self._actId, curSelectedEpisode)
	local isFinishedButUnReceive = Activity146Model.instance:isEpisodeFinishedButUnReceive(curSelectedEpisode)
	local hasReceivedReward = Activity146Model.instance:isEpisodeHasReceivedReward(curSelectedEpisode)
	local useMap = {}

	if rewards then
		for k, v in ipairs(rewards) do
			local rewardItem = self._rewardItemTab[k]

			if not rewardItem then
				rewardItem = {
					go = gohelper.cloneInPlace(self._gorewarditem, "rewarditem" .. k)
				}

				local iconRoot = gohelper.findChild(rewardItem.go, "go_icon")

				rewardItem.icon = IconMgr.instance:getCommonPropItemIcon(iconRoot)
				rewardItem.goreceive = gohelper.findChild(rewardItem.go, "go_receive")
				rewardItem.gocanget = gohelper.findChild(rewardItem.go, "go_canget")
				rewardItem.hasgetAnim = gohelper.findChild(rewardItem.go, "go_receive/go_hasget"):GetComponent(typeof(UnityEngine.Animator))
				self._rewardItemTab[k] = rewardItem
			end

			gohelper.setActive(rewardItem.go, true)
			gohelper.setActive(rewardItem.goreceive, hasReceivedReward)
			gohelper.setActive(rewardItem.gocanget, isFinishedButUnReceive)

			local itemCo = string.splitToNumber(v, "#")

			rewardItem.icon:setMOValue(itemCo[1], itemCo[2], itemCo[3])
			rewardItem.icon:setCountFontSize(42)
			rewardItem.icon:setScale(0.5)

			useMap[rewardItem] = true
		end
	end

	local episodeCanGetTempInfo = self._episodeCanGetInfoDict[curSelectedEpisode]

	self._episodeCanGetInfoDict[curSelectedEpisode] = isFinishedButUnReceive

	if episodeCanGetTempInfo == false and isFinishedButUnReceive == true then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_read_over)
	end

	gohelper.setActive(self._btngetreward.gameObject, isFinishedButUnReceive)

	for _, v in pairs(self._rewardItemTab) do
		if not useMap[v] then
			gohelper.setActive(v.go, false)
		end
	end
end

function VersionActivity1_5WarmUpView:_btngetrewardOnClick()
	Activity146Controller.instance:tryReceiveEpisodeRewards(self._actId)
end

function VersionActivity1_5WarmUpView:_onDailyRefresh()
	if self._actId then
		Activity146Controller.instance:getAct146InfoFromServer(self._actId)
	end
end

function VersionActivity1_5WarmUpView:_overrideViewCloseCheckFunc()
	local beginnerViewContainer = ViewMgr.instance:getContainer(ViewName.ActivityBeginnerView)

	if beginnerViewContainer then
		local navigationView = beginnerViewContainer.navigationView

		if navigationView then
			self._originCloseCheckFunc = navigationView._closeCheckFunc
			self._originCloseCheckObj = navigationView._closeCheckObj
			self._originHomeCheckFunc = navigationView._homeCheckFunc
			self._originHomeCheckObj = navigationView._homeCheckObj

			navigationView:setCloseCheck(self._onCloseCheckFunc, self)
			navigationView:setHomeCheck(self._onCloseCheckFunc, self)
		end
	end
end

function VersionActivity1_5WarmUpView:_revertViewCloseCheckFunc()
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
end

function VersionActivity1_5WarmUpView:_onCloseCheckFunc()
	if self._isPlayingEpisodeDesc then
		GameFacade.showMessageBox(MessageBoxIdDefine.V1a5_WarmUpPlayingQuitCheck, MsgBoxEnum.BoxType.Yes_No, self._messageBoxYesFunc, self._messageBoxNoFunc, nil, self, self)

		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)

			self._tweenId = nil
		end
	end

	return not self._isPlayingEpisodeDesc
end

function VersionActivity1_5WarmUpView:_messageBoxYesFunc()
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function VersionActivity1_5WarmUpView:_messageBoxNoFunc()
	local curSelectedEpisodeId = Activity146Model.instance:getCurSelectedEpisode()
	local wholeTxt = tostring(Activity146Config.instance:getEpisodeDesc(self._actId, curSelectedEpisodeId))
	local startTxt = self._txtTaskContent.text

	self._playEpisodeDesc(self, startTxt, wholeTxt, episodeTxtPlayDuration, self._onPlayEpisodeDescFinished, self)
end

function VersionActivity1_5WarmUpView:onClose()
	self:_revertViewCloseCheckFunc()
	Activity146Controller.instance:onCloseView()
	ActivityController.instance:dispatchEvent(ActivityEvent.SetBannerViewCategoryListInteract, true)
end

function VersionActivity1_5WarmUpView:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.cancelTask(self._delaySwitchPhoto, self)

	if self._episodeItemTab then
		for _, v in pairs(self._episodeItemTab) do
			v.click:RemoveClickListener()
		end
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
end

return VersionActivity1_5WarmUpView
