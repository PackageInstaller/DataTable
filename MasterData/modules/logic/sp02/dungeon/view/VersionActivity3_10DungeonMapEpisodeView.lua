-- chunkname: @modules/logic/sp02/dungeon/view/VersionActivity3_10DungeonMapEpisodeView.lua

module("modules.logic.sp02.dungeon.view.VersionActivity3_10DungeonMapEpisodeView", package.seeall)

local VersionActivity3_10DungeonMapEpisodeView = class("VersionActivity3_10DungeonMapEpisodeView", VersionActivityFixedDungeonMapEpisodeView)
local FocusEpisodeBlockKey = "VersionActivity3_10DungeonMapEpisodeView_FocusEpisode"

function VersionActivity3_10DungeonMapEpisodeView:_editableInitView()
	VersionActivity3_10DungeonMapEpisodeView.super._editableInitView(self)

	self.mapView = self.viewContainer.mapView
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#scroll_content")
	self._goStory = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_storymode")
	self._goHard = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode")

	if self._touch then
		gohelper.removeComponent(self.scrollRect.gameObject, typeof(SLFramework.UGUI.UIClickListener))

		self._touch = nil
	end
end

function VersionActivity3_10DungeonMapEpisodeView:addEvents()
	VersionActivity3_10DungeonMapEpisodeView.super.addEvents(self)
	self._scrollcontent:AddOnValueChanged(self.onScrollValueChanged, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self._onBeginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self._onEndShowRewardView, self)
	self.addEventCb(self, VersionActivity3_10DungeonController.instance, VersionActivity3_10Event.FocusEpisodeNode, self._onFocusEpisodeNode, self)
	VersionActivity3_10DungeonController.instance:dispatchEvent(VersionActivity3_10Event.OnNewElementsFocusDone)
end

function VersionActivity3_10DungeonMapEpisodeView:removeEvents()
	VersionActivity3_10DungeonMapEpisodeView.super.removeEvents(self)
	self._scrollcontent:RemoveOnValueChanged()
end

function VersionActivity3_10DungeonMapEpisodeView:onLoadLayoutFinish()
	VersionActivity3_10DungeonMapEpisodeView.super.onLoadLayoutFinish(self)

	self._contentTran = self.scrollRect.content
	self._originLocalPosX, self._originLocalPosY = transformhelper.getPos(self._contentTran)
	self._originScreenPosX, self._originScreenPosY = recthelper.uiPosToScreenPos2(self._contentTran)

	self:tryFindNextEpisodeId()
	self:tryFocusNextEpisode()
end

function VersionActivity3_10DungeonMapEpisodeView:setLayoutVisible(isShow)
	if not self.chapterLayout then
		return
	end

	gohelper.setActive(self.scrollRect, isShow)
	VersionActivity3_10DungeonController.instance:dispatchEvent(VersionActivity3_10Event.OnEpisodeListVisible, isShow)
end

function VersionActivity3_10DungeonMapEpisodeView:onScrollValueChanged(value)
	local percent = self.chapterLayout:getShowEpisodePercent()

	VersionActivity3_10DungeonController.instance:dispatchEvent(VersionActivity3_10Event.OnScrollEpisodeList, value * percent, true)
end

function VersionActivity3_10DungeonMapEpisodeView:_onUpdateDungeonInfo()
	self:tryFindNextEpisodeId()
	self:tryFocusNextEpisode()
	VersionActivity3_10DungeonMapEpisodeView.super._onUpdateDungeonInfo(self)
end

function VersionActivity3_10DungeonMapEpisodeView:tryFindNextEpisodeId()
	local lastSendEpisodeId = DungeonModel.instance.lastSendEpisodeId

	self._nextFocusEpisodeId = nil

	if self.activityDungeonMo.episodeId ~= lastSendEpisodeId then
		return
	end

	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.activityDungeonMo.chapterId)

	for _, config in ipairs(episodeList) do
		local episodeMo = config and DungeonModel.instance:getEpisodeInfo(config.id) or nil

		if not episodeMo then
			break
		end

		if episodeMo.isNew and config.preEpisode == lastSendEpisodeId then
			episodeMo:setNewStatus(false)

			self._nextFocusEpisodeId = config.id

			break
		end
	end
end

function VersionActivity3_10DungeonMapEpisodeView:tryFocusNextEpisode()
	if not self._nextFocusEpisodeId or not self.chapterLayout then
		return
	end

	self:destroyFocusFlow()

	self._focusFlow = FlowSequence.New()

	self._focusFlow:addWork(WaitEventWork.New("VersionActivity3_10DungeonController;VersionActivity3_10Event;OnNewElementsFocusDone"))
	self._focusFlow:addWork(FunctionWork.New(self._lockScreen, true))
	self._focusFlow:addWork(DelayDoFuncWork.New(self._delay2ChangeEpisode, self, VersionActivity3_10DungeonEnum.Time_FocuysNewEpisode))
	self._focusFlow:addWork(FunctionWork.New(self._lockScreen, false))
	self._focusFlow:start()
end

function VersionActivity3_10DungeonMapEpisodeView:_lockScreen(lock)
	AssassinHelper.lockScreen(FocusEpisodeBlockKey, lock)
end

function VersionActivity3_10DungeonMapEpisodeView:destroyFocusFlow()
	if self._focusFlow then
		self._focusFlow:destroy()

		self._focusFlow = nil
	end
end

function VersionActivity3_10DungeonMapEpisodeView:_delay2ChangeEpisode()
	if not self.activityDungeonMo or not self._nextFocusEpisodeId then
		return
	end

	if self.chapterLayout then
		self.chapterLayout:setFocusEpisodeId(self._nextFocusEpisodeId, true)
	end

	self._nextFocusEpisodeId = nil
end

function VersionActivity3_10DungeonMapEpisodeView:_onBeginShowRewardView()
	self:hideUI()
end

function VersionActivity3_10DungeonMapEpisodeView:_onEndShowRewardView()
	self:showUI()
end

function VersionActivity3_10DungeonMapEpisodeView:refreshModeNode()
	local curMode = self.activityDungeonMo.mode

	self:refreshModeLockText()
	self:_updateBtnStatus(curMode)
end

function VersionActivity3_10DungeonMapEpisodeView:_updateBtnStatus(curMode)
	local storyModeEnum = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local hardModeEnum = VersionActivityDungeonBaseEnum.DungeonMode.Hard

	gohelper.setActive(self._goStory, curMode ~= storyModeEnum)
	gohelper.setActive(self._goHard, curMode ~= hardModeEnum)
end

function VersionActivity3_10DungeonMapEpisodeView:changeEpisodeMode(mode)
	VersionActivity3_10DungeonMapEpisodeView.super.changeEpisodeMode(self, mode)
	self:_updateBtnStatus(mode)
end

function VersionActivity3_10DungeonMapEpisodeView:_onFocusEpisodeNode(index, tween)
	self:clearTween()

	local percent = self.chapterLayout:getEpisodePercent(index)

	if tween then
		local cur = self._scrollcontent.horizontalNormalizedPosition

		self.tweenId = ZProj.TweenHelper.DOTweenFloat(cur, percent, 0.3, self._frameUpdateScrollValue, self._frameUpdateFinish, self, nil, EaseType.Linear)
	else
		self:_frameUpdateScrollValue(percent)
	end
end

function VersionActivity3_10DungeonMapEpisodeView:_frameUpdateScrollValue(value)
	if not self._scrollcontent then
		return
	end

	self._scrollcontent.horizontalNormalizedPosition = value
end

function VersionActivity3_10DungeonMapEpisodeView:_frameUpdateFinish()
	self:clearTween()
end

function VersionActivity3_10DungeonMapEpisodeView:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function VersionActivity3_10DungeonMapEpisodeView:_refreshHardModeCurrency(isOpen)
	local num, total = VersionActivityFixedDungeonModel.instance:getHardModeCurrenyNum(self.activityDungeonMo.activityDungeonConfig.hardChapterId)

	if total <= 0 then
		isOpen = false
	end

	local format = luaLang("activitymap_hardmode_reward_count")

	self._txthardModeCurrency.text = GameUtil.getSubPlaceholderLuaLangTwoParam(format, num, total)

	gohelper.setActive(self._hardModeCurrency, isOpen)
end

function VersionActivity3_10DungeonMapEpisodeView:refreshModeLockText()
	local openTimeStamp = VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).DungeonChapterId.Hard)
	local serverTime = ServerTime.now()
	local isOpenHardMode = false

	if serverTime < openTimeStamp then
		local timeStampOffset = openTimeStamp - serverTime
		local day = Mathf.Floor(timeStampOffset / TimeUtil.OneDaySecond)
		local hourSecond = timeStampOffset % TimeUtil.OneDaySecond
		local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
		local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.Dungeon]

		if day > 0 then
			local tempStr = actInfoMo:getRemainTimeStr2(timeStampOffset)

			if hour > 0 then
				tempStr = GameUtil.getSubPlaceholderLuaLang(luaLang("hournum"), {
					tempStr,
					hour
				})
			end

			self._txtHardModeUnlockTime.text = string.format(luaLang("seasonmainview_timeopencondition"), tempStr)
		else
			self._txtHardModeUnlockTime.text = string.format(luaLang("seasonmainview_timeopencondition"), actInfoMo:getRemainTimeStr4(timeStampOffset))
		end

		gohelper.setActive(self._hardModeLockTip, true)
		gohelper.setActive(self._gohardmodelock, true)
	else
		local isOpen, unLockEpisodeId = DungeonModel.instance:chapterIsUnLock(self.activityDungeonMo.activityDungeonConfig.hardChapterId)

		if isOpen then
			gohelper.setActive(self._hardModeLockTip, false)
			gohelper.setActive(self._gohardmodelock, false)

			isOpenHardMode = true
		else
			self._txtHardModeUnlockTime.text = luaLang("sp02_atomic_mainactivity_hardlocktip")

			gohelper.setActive(self._hardModeLockTip, true)
			gohelper.setActive(self._gohardmodelock, true)
		end
	end

	self:_refreshHardModeCurrency(isOpenHardMode)
end

function VersionActivity3_10DungeonMapEpisodeView:onDestroyView()
	self:_lockScreen(false)
	self:destroyFocusFlow()
	VersionActivity3_10DungeonMapEpisodeView.super.onDestroyView(self)
end

return VersionActivity3_10DungeonMapEpisodeView
