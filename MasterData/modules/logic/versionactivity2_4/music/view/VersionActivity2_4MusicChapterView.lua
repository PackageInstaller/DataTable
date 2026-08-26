-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicChapterView.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicChapterView", package.seeall)

local VersionActivity2_4MusicChapterView = class("VersionActivity2_4MusicChapterView", BaseView)

function VersionActivity2_4MusicChapterView:onInitView()
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "root/#simage_Title")
	self._txttime = gohelper.findChildText(self.viewGO, "root/time/#txt_time")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_task")
	self._goreddottask = gohelper.findChild(self.viewGO, "root/#btn_task/#go_reddottask")
	self._btnmodeentry = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_modeentry")
	self._gov2a4bakaluoerchapterlayout = gohelper.findChild(self.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout")
	self._scrollChapterList = gohelper.findChildScrollRect(self.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout/#scroll_ChapterList")
	self._gocontent = gohelper.findChild(self.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout/#scroll_ChapterList/Viewport/#go_content")
	self._gocurrentdown = gohelper.findChild(self.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout/#scroll_ChapterList/Viewport/#go_content/#go_currentdown")
	self._gocurrentBG = gohelper.findChild(self.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout/#scroll_ChapterList/Viewport/#go_content/#go_currentBG")
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Try/image_TryBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicChapterView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnmodeentry:AddClickListener(self._btnmodeentryOnClick, self)
	self._btnTrial:AddClickListener(self._clickTrial, self)
end

function VersionActivity2_4MusicChapterView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnmodeentry:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function VersionActivity2_4MusicChapterView:_clickTrial()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

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

function VersionActivity2_4MusicChapterView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function VersionActivity2_4MusicChapterView:_btntaskOnClick()
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicTaskView()
end

function VersionActivity2_4MusicChapterView:_btnmodeentryOnClick()
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeView()
end

function VersionActivity2_4MusicChapterView:_editableInitView()
	Activity179Model.instance:clearSelectedEpisodeId()

	self._taskAnimator = self._btntask.gameObject:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddottask, RedDotEnum.DotNode.V2a4MusicTaskRed, nil, self._refreshRedDot, self)

	self.actId = VersionActivity2_4Enum.ActivityId.MusicGame
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self:_initChapterList()
end

function VersionActivity2_4MusicChapterView:_refreshRedDot(reddot)
	reddot:defaultRefreshDot()

	local showRedDot = reddot.show

	self._taskAnimator:Play(showRedDot and "loop" or "idle")
end

function VersionActivity2_4MusicChapterView:_initChapterList()
	self._itemList = self:getUserDataTb_()

	local list = Activity179Config.instance:getEpisodeCfgList(Activity179Model.instance:getActivityId())

	for i, v in ipairs(list) do
		if v.episodeType ~= VersionActivity2_4MusicEnum.EpisodeType.Free then
			local path = self.viewContainer:getSetting().otherRes[1]
			local childGO = self:getResInst(path, self._gocontent)
			local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, VersionActivity2_4MusicChapterItem)

			item:onUpdateMO(v)
			table.insert(self._itemList, item)
		end
	end
end

function VersionActivity2_4MusicChapterView:onUpdateParam()
	return
end

function VersionActivity2_4MusicChapterView:onOpen()
	TaskDispatcher.runRepeat(self._updateTime, self, 1)
	self:_updateTime()
	self.addEventCb(self, StoryController.instance, StoryEvent.StoryFrontViewDestroy, self._onEpisodeStoryBeforeFinished, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:_updateItemList()
	self:_moveChapterItem(self:_getSelectedEpisodeIndex())
end

function VersionActivity2_4MusicChapterView:_getSelectedEpisodeIndex()
	local episodeId = Activity179Model.instance:getSelectedEpisodeId()

	for i, v in ipairs(self._itemList) do
		if v:getHasOpened() and v:getEpisodeId() == episodeId then
			return i
		end
	end

	Activity179Model.instance:clearSelectedEpisodeId()
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_4MusicSelectEpisode, VersionActivity2_4MusicEnum.FirstEpisodeId)

	for i, v in ipairs(self._itemList) do
		v:updateSelectedFlag()
	end

	return 1
end

function VersionActivity2_4MusicChapterView:_moveChapterItem(openIndex)
	if not openIndex then
		return
	end

	local viewWidth = recthelper.getWidth(self._scrollChapterList.transform)

	recthelper.setAnchorX(self._gocontent.transform, -VersionActivity2_4MusicEnum.EpisodeItemWidth * openIndex + VersionActivity2_4MusicEnum.EpisodeItemWidth / 2 + viewWidth / 2)
end

function VersionActivity2_4MusicChapterView:_onCloseViewFinish(viewName)
	if viewName ~= ViewName.VersionActivity2_4MusicBeatView then
		return
	end

	self:_updateItemList(true)
end

function VersionActivity2_4MusicChapterView:_onEpisodeStoryBeforeFinished()
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_4MusicBeatView) then
		return
	end

	self:_updateItemList(true)
end

function VersionActivity2_4MusicChapterView:_updateItemList(tween)
	local lastFinishedIndex, lastOpenIndex

	for i, v in ipairs(self._itemList) do
		v:updateView()

		if v:getHasFinished() then
			lastFinishedIndex = i
		end

		if v:getHasOpened() then
			lastOpenIndex = i
		end
	end

	self._lastFinishedIndex = lastFinishedIndex

	self:_updateProgress(tween, lastOpenIndex)

	local showFree = lastFinishedIndex == #self._itemList

	gohelper.setActive(self._btnmodeentry, showFree)

	if showFree then
		GuideController.instance:dispatchEvent(GuideEvent.TriggerActive, GuideEnum.EventTrigger.MusicFreeView)
	end
end

function VersionActivity2_4MusicChapterView:_updateProgress(tween, lastOpenIndex)
	self._oldOpenIndex = self._lastOpenIndex
	self._lastOpenIndex = lastOpenIndex

	if not tween or not self._oldOpenIndex or self._oldOpenIndex == self._lastOpenIndex then
		self:_setProgress(self._lastOpenIndex - 1, 1)

		return
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, self._tweenFrame, self._tweenFinish, self)

	self:_moveChapterItem(self._lastOpenIndex)
	AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_unlock)
end

function VersionActivity2_4MusicChapterView:_tweenFrame(value)
	self:_setProgress(self._oldOpenIndex, value)
end

function VersionActivity2_4MusicChapterView:_tweenFinish()
	self:_setProgress(self._oldOpenIndex, 1)
end

function VersionActivity2_4MusicChapterView:_setProgress(startIndex, percent)
	if gohelper.isNil(self._gocurrentdown) then
		return
	end

	local offsetWidth = (startIndex - 1) * VersionActivity2_4MusicEnum.EpisodeItemWidth + VersionActivity2_4MusicEnum.EpisodeItemWidth * percent

	recthelper.setAnchorX(self._gocurrentdown.transform, VersionActivity2_4MusicEnum.ProgressLightPos + offsetWidth)
	recthelper.setWidth(self._gocurrentBG.transform, VersionActivity2_4MusicEnum.ProgressBgWidth + offsetWidth)
end

function VersionActivity2_4MusicChapterView:_updateTime()
	local activityId = Activity179Model.instance:getActivityId()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[activityId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		if offsetSecond > 0 then
			self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

			return
		end
	end

	TaskDispatcher.cancelTask(self._updateTime, self)
end

function VersionActivity2_4MusicChapterView:onClose()
	self.removeEventCb(self, StoryController.instance, StoryEvent.StoryFrontViewDestroy, self._onEpisodeStoryBeforeFinished, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	TaskDispatcher.cancelTask(self._updateTime, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function VersionActivity2_4MusicChapterView:onDestroyView()
	return
end

return VersionActivity2_4MusicChapterView
