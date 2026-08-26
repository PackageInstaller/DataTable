-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/VersionActivity1_5DungeonMapEpisodeView.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapEpisodeView", package.seeall)

local VersionActivity1_5DungeonMapEpisodeView = class("VersionActivity1_5DungeonMapEpisodeView", BaseView)

function VersionActivity1_5DungeonMapEpisodeView:onInitView()
	self._gochaptercontentitem = gohelper.findChild(self.viewGO, "#scroll_content/#go_chaptercontentitem")
	self._gomodecontainer = gohelper.findChild(self.viewGO, "#go_switchmodecontainer")
	self._btnstorymode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_switchmodecontainer/#go_storymode/#btn_storyMode")
	self._btnhardmode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#btn_hardMode")
	self._imgstorymode = gohelper.findChildImage(self.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon")
	self._gostorymodeNormal = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon/go_normal")
	self._gostorymodeSelect = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon/go_select")
	self._imghardmode = gohelper.findChildImage(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon")
	self._gohardmodeNormal = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_normal")
	self._gohardmodeSelect = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_select")
	self._gohardmodelock = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_locked")
	self._hardModeLockTip = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock")
	self._txtunlocktime = gohelper.findChildText(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5DungeonMapEpisodeView:addEvents()
	self._btnstorymode:AddClickListener(self.btnStoryModeClick, self)
	self._btnhardmode:AddClickListener(self.btnHardModeClick, self)
end

function VersionActivity1_5DungeonMapEpisodeView:removeEvents()
	self._btnstorymode:RemoveClickListener()
	self._btnhardmode:RemoveClickListener()
end

function VersionActivity1_5DungeonMapEpisodeView:btnStoryModeClick()
	self:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
end

function VersionActivity1_5DungeonMapEpisodeView:btnHardModeClick()
	local isOpen, toastId, toastParam = self:checkHardModeIsOpen()

	if not isOpen then
		GameFacade.showToast(toastId, toastParam)

		return
	end

	self:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function VersionActivity1_5DungeonMapEpisodeView:checkHardModeIsOpen()
	return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(VersionActivity1_5Enum.ActivityId.Dungeon)
end

function VersionActivity1_5DungeonMapEpisodeView:changeEpisodeMode(mode)
	if mode == self.activityDungeonMo.mode then
		return
	end

	if not self.chapterLayout then
		return
	end

	self.scrollRect.velocity = Vector2(0, 0)

	if mode == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		self.excessiveAnimator:Play("story", 0, 0)
	else
		self.excessiveAnimator:Play("hard", 0, 0)
	end

	self.activityDungeonMo.mode = mode

	TaskDispatcher.runDelay(self.directChangeMode, self, 0.41)
end

function VersionActivity1_5DungeonMapEpisodeView:directChangeMode()
	self.activityDungeonMo:changeMode(self.activityDungeonMo.mode)
end

function VersionActivity1_5DungeonMapEpisodeView:dailyRefresh()
	self:refreshModeNode()
	self:playUnlockAnimation()
end

function VersionActivity1_5DungeonMapEpisodeView:_editableInitView()
	self.scrollRect = gohelper.findChild(self.viewGO, "#scroll_content"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._audioScroll = MonoHelper.addLuaComOnceToGo(self.scrollRect.gameObject, DungeonMapEpisodeAudio, self.scrollRect)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self.scrollRect.gameObject)

	self._drag:AddDragBeginListener(self._onDragBeginHandler, self)
	self._drag:AddDragEndListener(self._onDragEndHandler, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self.scrollRect.gameObject)

	self._touch:AddClickDownListener(self._onClickDownHandler, self)

	local limitedScrollRect = self.scrollRect:GetComponent(typeof(ZProj.LimitedScrollRect))

	limitedScrollRect.scrollSpeed = 0.5

	gohelper.setActive(self._gochaptercontentitem, false)
	gohelper.setActive(self._goexcessive, true)

	self.excessiveAnimator = self._goexcessive:GetComponent(typeof(UnityEngine.Animator))
	self.goScrollRect = gohelper.findChild(self.viewGO, "#scroll_content")

	recthelper.setAnchorY(self.goScrollRect.transform, -240)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)

	local key = self:getPlayUnlockAnimationKey()

	self.isPlayedModeUnLockAnimation = PlayerPrefsHelper.getNumber(key, 0) == 1
end

function VersionActivity1_5DungeonMapEpisodeView:_onDragBeginHandler()
	self._audioScroll:onDragBegin()
end

function VersionActivity1_5DungeonMapEpisodeView:_onDragEndHandler()
	self._audioScroll:onDragEnd()
end

function VersionActivity1_5DungeonMapEpisodeView:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

function VersionActivity1_5DungeonMapEpisodeView:playOnOpenAnimation()
	self.chapterLayout:playAnimation(UIAnimationName.Open)

	if self.viewContainer.viewParam.needSelectFocusItem then
		self.chapterLayout:setSelectEpisodeId(self.activityDungeonMo.episodeId)
	else
		self.chapterLayout:playEpisodeItemAnimation("in")
	end
end

function VersionActivity1_5DungeonMapEpisodeView:onUpdateParam()
	self:refreshModeNode()
	self.chapterLayout:refreshEpisodeNodes()
	self:playOnOpenAnimation()
end

function VersionActivity1_5DungeonMapEpisodeView:onOpen()
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, self.hideUI, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, self.showUI, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:initChapterEpisodes()
	self:refreshModeNode()
end

function VersionActivity1_5DungeonMapEpisodeView:initChapterEpisodes()
	self._uiLoader = MultiAbLoader.New()

	self._uiLoader:addPath(self.activityDungeonMo:getLayoutPrefabUrl())
	self._uiLoader:startLoad(self.onLoadLayoutFinish, self)
end

function VersionActivity1_5DungeonMapEpisodeView:onLoadLayoutFinish()
	local url = self.activityDungeonMo:getLayoutPrefabUrl()
	local assetItem = self._uiLoader:getAssetItem(url)
	local mainPrefab = assetItem:GetResource(url)

	self.goChapterContent = gohelper.cloneInPlace(self._gochaptercontentitem, "#go_chaptercontent")

	gohelper.setAsLastSibling(self.goChapterContent)
	gohelper.setActive(self.goChapterContent, true)

	self.scrollRect.content = self.goChapterContent.transform
	self.scrollRect.velocity = Vector2(0, 0)
	self.scrollRect.horizontalNormalizedPosition = 0

	local uiGO = gohelper.clone(mainPrefab, self.goChapterContent)

	self.chapterLayout = self.activityDungeonMo:getLayoutClass().New()
	self.chapterLayout.viewContainer = self.viewContainer
	self.chapterLayout.activityDungeonMo = self.activityDungeonMo

	self.chapterLayout:initView(uiGO, {
		goChapterContent = self.goChapterContent
	})
	self.chapterLayout:refreshEpisodeNodes()
	self:playOnOpenAnimation()
end

function VersionActivity1_5DungeonMapEpisodeView:onOpenFinish()
	self:playUnlockAnimation()
end

function VersionActivity1_5DungeonMapEpisodeView:refreshModeNode()
	if self.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		self._imgstorymode.color = VersionActivityDungeonBaseEnum.ModeSelectColor or VersionActivityDungeonBaseEnum.ModeDisSelectColor
	end

	if self.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		self._imghardmode.color = VersionActivityDungeonBaseEnum.ModeSelectColor or VersionActivityDungeonBaseEnum.ModeDisSelectColor
	end

	gohelper.setActive(self._gostorymodeSelect, self.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(self._gostorymodeNormal, self.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(self._gohardmodeSelect, self.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(self._gohardmodeNormal, self.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	self:refreshModeLockText()
end

function VersionActivity1_5DungeonMapEpisodeView:onModeChange()
	self:refreshModeNode()
	self.chapterLayout:playAnimation("switch")
	self.chapterLayout:refreshEpisodeNodes()
end

function VersionActivity1_5DungeonMapEpisodeView:showUI()
	gohelper.setActive(self._gomodecontainer, true)
	self:showLayout()
end

function VersionActivity1_5DungeonMapEpisodeView:hideUI()
	gohelper.setActive(self._gomodecontainer, false)
	self:hideLayout()
end

function VersionActivity1_5DungeonMapEpisodeView:_onRecheckInteractive(isShow)
	if isShow then
		self:showUI()
	else
		self:hideUI()
	end
end

function VersionActivity1_5DungeonMapEpisodeView:showLayout()
	if not self.chapterLayout then
		return
	end

	self._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(self.chapterLayout.viewGO.transform, self.chapterLayout.defaultY, 0.2)
end

function VersionActivity1_5DungeonMapEpisodeView:hideLayout()
	if not self.chapterLayout then
		return
	end

	self._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(self.chapterLayout.viewGO.transform, -260, 0.2)
end

function VersionActivity1_5DungeonMapEpisodeView:_onUpdateDungeonInfo()
	if self.chapterLayout then
		self.chapterLayout:refreshEpisodeNodes()
	end

	self:playUnlockAnimation()
end

function VersionActivity1_5DungeonMapEpisodeView:_onCloseViewFinish(viewName)
	self:playUnlockAnimation()
end

function VersionActivity1_5DungeonMapEpisodeView:playUnlockAnimation()
	if self.isPlayedModeUnLockAnimation then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if self:needPlayUnLockAnimation() then
		PlayerPrefsHelper.setNumber(self:getPlayUnlockAnimationKey(), 1)

		local animator = gohelper.findChildComponent(self.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator)

		if animator then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_explore_open)
			animator:Play("unlock", 0, 0)
			TaskDispatcher.runDelay(self.unlockAnimDone, self, VersionActivity1_5DungeonEnum.HardModeUnlockAnimDuration)
		end
	end
end

function VersionActivity1_5DungeonMapEpisodeView:unlockAnimDone()
	local animator = gohelper.findChildComponent(self.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator)
	local goUnlock = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#unlock")

	animator.enabled = false

	gohelper.setActive(goUnlock, false)
	self:refreshModeLockText()
	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnHardUnlockAnimDone)
end

function VersionActivity1_5DungeonMapEpisodeView:needPlayUnLockAnimation()
	local isPlayed = PlayerPrefsHelper.getNumber(self:getPlayUnlockAnimationKey(), 0) == 1

	if isPlayed then
		return false
	end

	local isOpen = VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_5Enum.ActivityId.Dungeon)

	if not isOpen then
		return false
	end

	return true
end

function VersionActivity1_5DungeonMapEpisodeView:getPlayUnlockAnimationKey()
	return PlayerModel.instance:getPlayerPrefsKey(VersionActivity1_5EnterController.GetActivityPrefsKey(PlayerPrefsKey.LeiMiTeBeiPlayHardModeUnlockAnimationKey))
end

function VersionActivity1_5DungeonMapEpisodeView:refreshModeLockText()
	local openTimeStamp = VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivity1_5DungeonEnum.DungeonChapterId.Hard)
	local serverTime = ServerTime.now()

	if serverTime < openTimeStamp then
		local timeStampOffset = openTimeStamp - serverTime
		local day = Mathf.Floor(timeStampOffset / TimeUtil.OneDaySecond)
		local hourSecond = timeStampOffset % TimeUtil.OneDaySecond
		local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
		local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.Dungeon]

		if day > 0 then
			local tempStr = actInfoMo:getRemainTimeStr2(timeStampOffset)

			if hour > 0 then
				tempStr = tempStr .. hour .. luaLang("time_hour2")
			end

			self._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), tempStr)
		else
			self._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), actInfoMo:getRemainTimeStr2(timeStampOffset))
		end

		gohelper.setActive(self._gohardmodelock, true)
		gohelper.setActive(self._hardModeLockTip, true)

		return
	end

	local isOpen, unLockEpisodeId = DungeonModel.instance:chapterIsUnLock(self.activityDungeonMo.activityDungeonConfig.hardChapterId)

	if not isOpen then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(unLockEpisodeId)

		self._txtunlocktime.text = string.format(luaLang("versionactivity1_3_hardlocktip"), "RUG-" .. DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, unLockEpisodeId))

		gohelper.setActive(self._gohardmodelock, true)
		gohelper.setActive(self._hardModeLockTip, true)

		return
	end

	gohelper.setActive(self._gohardmodelock, false)
	gohelper.setActive(self._hardModeLockTip, false)
end

function VersionActivity1_5DungeonMapEpisodeView:onClose()
	TaskDispatcher.cancelTask(self.directChangeMode, self)
	TaskDispatcher.cancelTask(self.unlockAnimDone, self)
end

function VersionActivity1_5DungeonMapEpisodeView:onDestroyView()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)

	if self._uiLoader then
		self._uiLoader:dispose()
	end

	if self.chapterLayout then
		self.chapterLayout:destroyView()

		self.chapterLayout = nil
	end

	if self._audioScroll then
		self._audioScroll:dispose()

		self._audioScroll = nil
	end

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	if self._touch then
		self._touch:RemoveClickDownListener()

		self._touch = nil
	end

	if self._episodeListTweenId then
		ZProj.TweenHelper.KillById(self._episodeListTweenId)
	end
end

return VersionActivity1_5DungeonMapEpisodeView
