-- chunkname: @modules/logic/versionactivity2_5/liangyue/view/LiangYueLevelView.lua

module("modules.logic.versionactivity2_5.liangyue.view.LiangYueLevelView", package.seeall)

local LiangYueLevelView = class("LiangYueLevelView", BaseView)

function LiangYueLevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._gostoryPath = gohelper.findChild(self.viewGO, "#go_storyPath")
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._gostoryStages = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_Title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_Title/#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_Title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/#txt_limittime")
	self._btnPlayBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Title/#btn_PlayBtn")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goreddot = gohelper.findChild(self.viewGO, "#btn_Task/#go_reddot")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._scrollStory = gohelper.findChildScrollRect(self._gostoryPath, "")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/image_TryBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LiangYueLevelView:addEvents()
	self._btnPlayBtn:AddClickListener(self._btnPlayBtnOnClick, self)
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._touch:AddClickDownListener(self._onClickDown, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	self.addEventCb(self, LiangYueController.instance, LiangYueEvent.OnFinishEpisode, self.onEpisodeFinish, self)
	self.addEventCb(self, LiangYueController.instance, LiangYueEvent.OnClickStoryItem, self.onClickStoryItem, self)
end

function LiangYueLevelView:removeEvents()
	self._btnPlayBtn:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._touch:RemoveClickDownListener()
	self._scrollStory:RemoveOnValueChanged()
	self._btnTrial:RemoveClickListener()
	self.removeEventCb(self, LiangYueController.instance, LiangYueEvent.OnFinishEpisode, self.onEpisodeFinish, self)
	self.removeEventCb(self, LiangYueController.instance, LiangYueEvent.OnClickStoryItem, self.onClickStoryItem, self)
end

function LiangYueLevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.config.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function LiangYueLevelView:_btnTrialOnClick()
	if ActivityHelper.isOpen(self._actId) then
		local episodeId = self.config.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function LiangYueLevelView:_btnPlayBtnOnClick()
	return
end

function LiangYueLevelView:_btnTaskOnClick()
	ViewMgr.instance:openView(ViewName.LiangYueTaskView)
end

function LiangYueLevelView:_editableInitView()
	self._actId = VersionActivity2_5Enum.ActivityId.LiangYue
	self.config = ActivityConfig.instance:getActivityCo(self._actId)
	self._taskAnimator = self._btnTask.gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a5_Act184Task, nil, self._refreshRedDot, self)
	self:_initLevelItem()

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local rightOffsetX = -300

	self._offsetX = (width - rightOffsetX) / 2
	self.minContentAnchorX = -4760 + width
	self._bgWidth = recthelper.getWidth(self._simageFullBG.transform)
	self._minBgPositionX = BootNativeUtil.getDisplayResolution() - self._bgWidth
	self._maxBgPositionX = 0
	self._bgPositonMaxOffsetX = math.abs(self._maxBgPositionX - self._minBgPositionX)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gostoryPath)
	self._touch = SLFramework.UGUI.UIClickListener.Get(self._gostoryPath)
	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._gostoryPath, DungeonMapEpisodeAudio, self._scrollStory)
	self._pathAnimator = gohelper.findChildAnim(self.viewGO, "#go_storyPath/#go_storyScroll/path/path_2")
end

function LiangYueLevelView:_initLevelItem()
	self._levelItemList = {}

	local parentTran = self._gostoryStages.transform
	local count = parentTran.childCount

	for i = 1, count do
		local itemParent = parentTran:GetChild(i - 1)
		local name = string.format("item_%s", i)
		local itemObj = self:getResInst(self.viewContainer._viewSetting.otherRes[1], itemParent.gameObject, name)
		local item = MonoHelper.addLuaComOnceToGo(itemObj, LiangYueLevelItem)

		item:onInit(itemObj)
		table.insert(self._levelItemList, item)
	end
end

function LiangYueLevelView:_refreshRedDot(reddot)
	reddot:defaultRefreshDot()

	local showRedDot = reddot.show

	self._taskAnimator:Play(showRedDot and "loop" or "idle")
end

function LiangYueLevelView:onUpdateParam()
	return
end

function LiangYueLevelView:onOpen()
	TaskDispatcher.runRepeat(self.updateTime, self, TimeUtil.OneMinuteSecond)
	self:updateTime()
	self:refreshUI()

	if self:_checkFirstEnter() then
		local item = self._levelItemList[1]

		item:setLockState()
		self:_lockScreen(true)
		TaskDispatcher.runDelay(self._playFirstUnlock, self, 0.8)
	end
end

function LiangYueLevelView:_playFirstUnlock()
	local firstEpisodeConfig = LiangYueConfig.instance:getFirstEpisodeId()

	if firstEpisodeConfig then
		for _, item in ipairs(self._levelItemList) do
			if item.episodeId == firstEpisodeConfig.episodeId then
				item:refreshUI()
				item:refreshStoryState(false)
				item:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Unlock, 0)
				AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wangshi_argus_level_open)
				TaskDispatcher.runDelay(self.onPlayUnlockAnimEnd, self, 1)

				return
			end
		end
	end

	self:_lockScreen(false)
end

function LiangYueLevelView:_checkFirstEnter()
	local item = self._levelItemList[2]

	if item and not item.isPreFinish then
		local key = string.format("ActLiangYueFirstEnter_%s", PlayerModel.instance:getMyUserId())
		local record = PlayerPrefsHelper.getNumber(key, 0)

		if record == 0 then
			PlayerPrefsHelper.setNumber(key, 1)

			return true
		end
	end

	return false
end

function LiangYueLevelView:refreshUI()
	local noGameEpisodeList = LiangYueConfig.instance:getNoGameEpisodeList(self._actId)

	if #noGameEpisodeList ~= #self._levelItemList then
		logError("levelItem Count not match")

		return
	end

	local focusIndex = 1
	local focusEpisodeId

	for index, item in ipairs(self._levelItemList) do
		local config = noGameEpisodeList[index]

		item:setInfo(index, config)

		if LiangYueModel.instance:isEpisodeFinish(self._actId, config.preEpisodeId) then
			focusIndex = index
			focusEpisodeId = config.episodeId
		end
	end

	self:_focusStoryItem(focusIndex, focusEpisodeId, false, false, true)
	self:_playPathAnim(focusIndex, false)

	if focusEpisodeId ~= nil then
		TaskDispatcher.runDelay(self.delaySendEpisodeUnlockEvent, self, 0.01)
	end
end

function LiangYueLevelView:delaySendEpisodeUnlockEvent()
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnEpisodeUnlock, self._currentEpisodeId)
	logNormal("OnEpisodeUnlock episodeId: " .. self._currentEpisodeId)
end

function LiangYueLevelView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function LiangYueLevelView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function LiangYueLevelView:_onScrollValueChanged()
	return
end

function LiangYueLevelView:_onClickDown()
	self._audioScroll:onClickDown()
end

function LiangYueLevelView:_initBgPosition()
	local bgPositionX = -self._scrollStory.horizontalNormalizedPosition * self._bgPositonMaxOffsetX

	bgPositionX = Mathf.Clamp(bgPositionX, self._minBgPositionX, self._maxBgPositionX)

	recthelper.setAnchorX(self._simageFullBG.transform, bgPositionX)
end

function LiangYueLevelView:_playPathAnim(index, needPlay)
	if index > 1 then
		self._pathAnimator.speed = 1

		local animName = string.format("go%s", Mathf.Clamp(index - 1, 1, #self._levelItemList - 1))

		self._pathAnimator:Play(animName, 0, needPlay and 0 or 1)
	else
		self._pathAnimator.speed = 0

		self._pathAnimator:Play("go1", -1, 0)
	end
end

function LiangYueLevelView:onClickStoryItem(index, episodeId, isGame)
	self:_focusStoryItem(index, episodeId, isGame, true)
end

function LiangYueLevelView:_focusStoryItem(index, episodeId, isGame, needPlay, ignoreTween)
	self._currentEpisodeId = episodeId
	self._currentIndex = index

	local item = self._levelItemList[index]
	local contentAnchorX = recthelper.getAnchorX(item._go.transform.parent)
	local offsetX = self._offsetX - contentAnchorX

	if offsetX > 0 then
		offsetX = 0
	elseif offsetX < self.minContentAnchorX then
		offsetX = self.minContentAnchorX
	end

	if ignoreTween then
		recthelper.setAnchorX(self._gostoryScroll.transform, offsetX)
	elseif needPlay then
		ZProj.TweenHelper.DOAnchorPosX(self._gostoryScroll.transform, offsetX, LiangYueEnum.FocusItemMoveDuration, self.onFocusEnd, self, {
			episodeId,
			isGame
		})
	else
		ZProj.TweenHelper.DOAnchorPosX(self._gostoryScroll.transform, offsetX, LiangYueEnum.FocusItemMoveDuration)
	end
end

function LiangYueLevelView:onFocusEnd(param)
	local episodeId = param[1]
	local isGame = param[2]
	local actId = self._actId
	local config = LiangYueConfig.instance:getEpisodeConfigByActAndId(actId, episodeId)

	if isGame then
		LiangYueController.instance:openGameView(actId, episodeId)

		return
	end

	local storyId = config.storyId

	if LiangYueModel.instance:isEpisodeFinish(actId, episodeId) then
		StoryController.instance:playStory(storyId)

		return
	end

	local param = {}

	param.mark = true
	param.episodeId = episodeId

	StoryController.instance:playStory(storyId, param, self.onStoryFinished, self)
end

function LiangYueLevelView:onStoryFinished()
	LiangYueController.instance:finishEpisode(self._actId, self._currentEpisodeId)
end

function LiangYueLevelView:onEpisodeFinish(actId, episodeId)
	if self._actId ~= actId then
		return
	end

	self._finishEpisodeId = episodeId

	local config = LiangYueConfig.instance:getEpisodeConfigByActAndId(actId, episodeId)

	self._finishEpisodeConfig = config

	local isStory = config.puzzleId == 0

	if not isStory then
		self._listenView = ViewName.LiangYueGameView

		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	else
		self:_lockScreen(true)
		TaskDispatcher.runDelay(self.forceCloseMask, self, 10)
		TaskDispatcher.runDelay(self.onPlayFinishAnim, self, 1.93)
	end
end

function LiangYueLevelView:onCloseViewFinish(viewName)
	if viewName ~= self._listenView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self:_lockScreen(true)
	TaskDispatcher.runDelay(self.forceCloseMask, self, 10)
	TaskDispatcher.runDelay(self.onPlayFinishAnim, self, 0.73)
end

function LiangYueLevelView:onPlayFinishAnim()
	TaskDispatcher.cancelTask(self.onPlayFinishAnim, self)

	local episodeId = self._finishEpisodeId
	local delayTime
	local noGameEpisodeList = LiangYueConfig.instance:getNoGameEpisodeList(self._actId)

	for index, item in ipairs(self._levelItemList) do
		if item.episodeId == episodeId or item.gameEpisodeId == episodeId then
			item:refreshUI()

			self._temptIndex = math.min(index + 1, #self._levelItemList)

			if item.episodeId == episodeId then
				item:refreshStoryState(false)
				item:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Finish, 0)
				AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wulu_lucky_bag_prize)

				delayTime = LiangYueEnum.FinishStoryAnimDelayTime

				if item.gameEpisodeId then
					self._temptIndex = index
				end

				break
			end

			item:refreshGameState(false)
			item:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.FinishIdle, 0)
			item:playGameEpisodeRewardAnim(LiangYueEnum.EpisodeGameFinishAnim.Open, 0)

			delayTime = LiangYueEnum.FinishGameAnimDelayTime

			break
		else
			local config = noGameEpisodeList[index]

			item:setInfo(index, config)
		end
	end

	if not delayTime then
		logError("未找到对应的关卡 id:" .. episodeId)
		self:_lockScreen(false)
		self:refreshUI()

		return
	end

	TaskDispatcher.runDelay(self.onPlayPathAnim, self, delayTime)
end

function LiangYueLevelView:forceCloseMask()
	self:_lockScreen(false)
	logError("动画计时器超时，强制关闭")
	self:refreshUI()
	TaskDispatcher.cancelTask(self.forceCloseMask, self)
end

function LiangYueLevelView:onPlayPathAnim()
	TaskDispatcher.cancelTask(self.onPlayPathAnim, self)

	if self._temptIndex == self._currentIndex then
		self:onPlayUnlockAnim()
	else
		self:_playPathAnim(self._temptIndex, true)
		self:_focusStoryItem(self._temptIndex, self._currentEpisodeId)
		TaskDispatcher.runDelay(self.onPlayUnlockAnim, self, LiangYueEnum.PathAnimDelayTime)
	end
end

function LiangYueLevelView:onPlayUnlockAnim()
	TaskDispatcher.cancelTask(self.onPlayUnlockAnim, self)

	local episodeId = self._finishEpisodeId

	for index, item in ipairs(self._levelItemList) do
		if item.preEpisodeId == episodeId then
			item:refreshUI()
			item:refreshStoryState(false)
			item:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Unlock, 0)
			AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wangshi_argus_level_open)
		elseif item.episodeId == episodeId and item.gameEpisodeId ~= nil then
			item:refreshUI()
			item:refreshGameState(false)
			item:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.Open, 0)
			AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_feichi_stanzas)
		end
	end

	TaskDispatcher.runDelay(self.onPlayUnlockAnimEnd, self, LiangYueEnum.UnlockAnimDelayTime)
end

function LiangYueLevelView:onPlayUnlockAnimEnd()
	TaskDispatcher.cancelTask(self.onPlayUnlockAnimEnd, self)
	TaskDispatcher.cancelTask(self.forceCloseMask, self)
	self:_lockScreen(false)

	if self._finishEpisodeId then
		LiangYueController.instance:dispatchEvent(LiangYueEvent.OnEpisodeUnlock, self._finishEpisodeId)
		logNormal("OnEpisodeUnlock episodeId: " .. self._finishEpisodeId)
	end
end

function LiangYueLevelView:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("LiangYueLevelLock")
	else
		UIBlockMgr.instance:endBlock("LiangYueLevelLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function LiangYueLevelView:updateTime()
	local activityId = self._actId
	local actInfoMo = ActivityModel.instance:getActivityInfo()[activityId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		if offsetSecond > 0 then
			self._txtlimittime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

			return
		end
	end

	TaskDispatcher.cancelTask(self.updateTime, self)
end

function LiangYueLevelView:onClose()
	TaskDispatcher.cancelTask(self.updateTime, self)
	TaskDispatcher.cancelTask(self.onPlayFinishAnim, self)
	TaskDispatcher.cancelTask(self.onPlayPathAnim, self)
	TaskDispatcher.cancelTask(self.onPlayUnlockAnim, self)
	TaskDispatcher.cancelTask(self.onPlayUnlockAnimEnd, self)
	TaskDispatcher.cancelTask(self.forceCloseMask, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

function LiangYueLevelView:onDestroyView()
	return
end

return LiangYueLevelView
