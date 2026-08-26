-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/map/VersionActivityFixedDungeonMapEpisodeView.lua

module("modules.versionactivitybase.fixed.dungeon.view.map.VersionActivityFixedDungeonMapEpisodeView", package.seeall)

local VersionActivityFixedDungeonMapEpisodeView = class("VersionActivityFixedDungeonMapEpisodeView", BaseView)
local SCROLL_SPEED = 0.5
local SCROLL_ANCHOR_Y = -240
local SWITCH_MODE_ANIM_TIME = 0.41
local HARD_MODE_UNLOCK_ANIM_TIME = 1.7
local LAYOUT_TWEEN_TIME = 0.2
local HIDE_LAYOUT_POS_Y = -260

function VersionActivityFixedDungeonMapEpisodeView:onInitView()
	self.goScrollRect = gohelper.findChild(self.viewGO, "#scroll_content")
	self.scrollRect = gohelper.findChild(self.viewGO, "#scroll_content"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._audioScroll = MonoHelper.addLuaComOnceToGo(self.scrollRect.gameObject, DungeonMapEpisodeAudio, self.scrollRect)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self.scrollRect.gameObject)
	self._touch = SLFramework.UGUI.UIClickListener.Get(self.scrollRect.gameObject)
	self._gochaptercontentitem = gohelper.findChild(self.viewGO, "#scroll_content/#go_chaptercontentitem")
	self._btnstorymode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_switchmodecontainer/#go_storymode/#btn_storyMode")
	self._gostorymodeNormal = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon/go_normal")
	self._gostorymodeSelect = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_storymode/#image_storyModeIcon/go_select")
	self._hardModeBtnAnimator = gohelper.findChildComponent(self.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator)
	self._btnhardmode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#btn_hardMode")
	self._gohardmodeNormal = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_normal")
	self._gohardmodeSelect = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_select")
	self._gohardmodelock = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/go_locked")
	self._hardModeLockTip = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock")
	self._hardModeCurrency = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeUnLock")
	self._hardModeUnlockvx = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#image_hardModeIcon/#go_hardModeUnLock")
	self._txthardModeCurrency = gohelper.findChildText(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeUnLock/#txt_num")
	self._txtHardModeUnlockTime = gohelper.findChildText(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")
	self.excessiveAnimator = self._goexcessive:GetComponent(gohelper.Type_Animator)
	self._cghardModeCurrency = self._hardModeCurrency:GetComponent(typeof(UnityEngine.CanvasGroup))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityFixedDungeonMapEpisodeView:addEvents()
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, self.hideUI, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, self.showUI, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self._btnstorymode:AddClickListener(self.btnStoryModeClick, self)
	self._btnhardmode:AddClickListener(self.btnHardModeClick, self)
	self._drag:AddDragBeginListener(self._onDragBeginHandler, self)
	self._drag:AddDragEndListener(self._onDragEndHandler, self)

	if self._touch then
		self._touch:AddClickDownListener(self._onClickDownHandler, self)
	end
end

function VersionActivityFixedDungeonMapEpisodeView:removeEvents()
	self.removeEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)

	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion)

	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, self.hideUI, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, self.showUI, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self._btnstorymode:RemoveClickListener()
	self._btnhardmode:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()

	if self._touch then
		self._touch:RemoveClickDownListener()
	end
end

function VersionActivityFixedDungeonMapEpisodeView:_editableInitView()
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	gohelper.setActive(self._gochaptercontentitem, false)
	gohelper.setActive(self._goexcessive, true)
	recthelper.setAnchorY(self.goScrollRect.transform, SCROLL_ANCHOR_Y)

	local limitedScrollRect = self.scrollRect:GetComponent(typeof(ZProj.LimitedScrollRect))

	limitedScrollRect.scrollSpeed = SCROLL_SPEED
end

function VersionActivityFixedDungeonMapEpisodeView:onUpdateParam()
	self:refreshModeNode()
	self.chapterLayout:refreshEpisodeNodes()
	self:playOnOpenAnimation()
end

function VersionActivityFixedDungeonMapEpisodeView:onOpen()
	self:initChapterEpisodes()
	self:refreshModeNode()
	TaskDispatcher.runRepeat(self.refreshModeLockText, self, TimeUtil.OneMinuteSecond)
	self:_refreshHardModeVx()
end

function VersionActivityFixedDungeonMapEpisodeView:onOpenFinish()
	self:playUnlockAnimation(true)
end

function VersionActivityFixedDungeonMapEpisodeView:refreshModeNode()
	local curMode = self.activityDungeonMo.mode
	local storyModeEnum = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local hardModeEnum = VersionActivityDungeonBaseEnum.DungeonMode.Hard

	gohelper.setActive(self._gostorymodeSelect, curMode == storyModeEnum)
	gohelper.setActive(self._gostorymodeNormal, curMode ~= storyModeEnum)
	gohelper.setActive(self._gohardmodeSelect, curMode == hardModeEnum)
	gohelper.setActive(self._gohardmodeNormal, curMode ~= hardModeEnum)
	self:refreshModeLockText()

	if hardModeEnum then
		self:_refreshHardModeVx()
	end
end

function VersionActivityFixedDungeonMapEpisodeView:initChapterEpisodes()
	self._uiLoader = MultiAbLoader.New()

	local layoutPrefabUrl = self.activityDungeonMo:getLayoutPrefabUrl()

	self._uiLoader:addPath(layoutPrefabUrl)
	self._uiLoader:startLoad(self.onLoadLayoutFinish, self)
end

function VersionActivityFixedDungeonMapEpisodeView:onLoadLayoutFinish()
	self.goChapterContent = gohelper.cloneInPlace(self._gochaptercontentitem, "#go_chaptercontent")

	gohelper.setAsLastSibling(self.goChapterContent)
	gohelper.setActive(self.goChapterContent, true)

	self.scrollRect.content = self.goChapterContent.transform
	self.scrollRect.velocity = Vector2(0, 0)
	self.scrollRect.horizontalNormalizedPosition = 0

	local url = self.activityDungeonMo:getLayoutPrefabUrl()
	local assetItem = self._uiLoader:getAssetItem(url)
	local mainPrefab = assetItem:GetResource(url)
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

function VersionActivityFixedDungeonMapEpisodeView:refreshModeLockText()
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
			local episodeConfig = DungeonConfig.instance:getEpisodeCO(unLockEpisodeId)
			local episodeIndexWithSP = DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, unLockEpisodeId)
			local chapterCo = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
			local charpterTag = chapterCo.chapterIndex

			self._txtHardModeUnlockTime.text = string.format(luaLang("versionactivity1_3_hardlocktip"), charpterTag .. "-" .. episodeIndexWithSP)

			gohelper.setActive(self._hardModeLockTip, true)
			gohelper.setActive(self._gohardmodelock, true)
		end
	end

	self:_refreshHardModeCurrency(isOpenHardMode)
end

function VersionActivityFixedDungeonMapEpisodeView:onModeChange()
	self:refreshModeNode()
	self.chapterLayout:playAnimation("switch")
	self.chapterLayout:refreshEpisodeNodes()
end

function VersionActivityFixedDungeonMapEpisodeView:showUI()
	self:setLayoutVisible(true)
end

function VersionActivityFixedDungeonMapEpisodeView:hideUI()
	self:setLayoutVisible(false)
end

function VersionActivityFixedDungeonMapEpisodeView:_onRecheckInteractive(isShow)
	if isShow then
		self:showUI()
	else
		self:hideUI()
	end
end

function VersionActivityFixedDungeonMapEpisodeView:setLayoutVisible(isShow)
	if not self.chapterLayout then
		return
	end

	if self._episodeListTweenId then
		ZProj.TweenHelper.KillById(self._episodeListTweenId)

		self._episodeListTweenId = nil
	end

	local layoutTrans = self.chapterLayout.viewGO.transform

	self._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(layoutTrans, (isShow or nil) and self.chapterLayout.defaultY, LAYOUT_TWEEN_TIME)
end

function VersionActivityFixedDungeonMapEpisodeView:_onUpdateDungeonInfo()
	if self.chapterLayout then
		self.chapterLayout:refreshEpisodeNodes()
	end

	self:refreshModeNode()
	self:playUnlockAnimation()
end

function VersionActivityFixedDungeonMapEpisodeView:_onCloseViewFinish(viewName)
	if viewName == self.viewName then
		return
	end

	self:playUnlockAnimation()
end

function VersionActivityFixedDungeonMapEpisodeView:dailyRefresh()
	self:refreshModeNode()
	self:playUnlockAnimation()
end

function VersionActivityFixedDungeonMapEpisodeView:btnStoryModeClick()
	self:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
end

function VersionActivityFixedDungeonMapEpisodeView:btnHardModeClick()
	local isOpen, toastId, toastParam = self:checkHardModeIsOpen()

	if not isOpen then
		GameFacade.showToast(toastId, toastParam)

		return
	end

	self:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	VersionActivityFixedDungeonModel.instance:setTipHardModeUnlockOpen()
end

function VersionActivityFixedDungeonMapEpisodeView:checkHardModeIsOpen()
	local dungeonActId = VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.Dungeon

	return VersionActivityFixedDungeonController.instance:isOpenActivityHardDungeonChapterAndGetToast(dungeonActId)
end

function VersionActivityFixedDungeonMapEpisodeView:changeEpisodeMode(mode)
	if not self.chapterLayout or mode == self.activityDungeonMo.mode then
		return
	end

	self.scrollRect.velocity = Vector2(0, 0)

	if mode == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		self.excessiveAnimator:Play("story")
	else
		self.excessiveAnimator:Play("hard")
	end

	self.activityDungeonMo.mode = mode

	TaskDispatcher.runDelay(self.directChangeMode, self, SWITCH_MODE_ANIM_TIME)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)
end

function VersionActivityFixedDungeonMapEpisodeView:directChangeMode()
	self.activityDungeonMo:changeMode(self.activityDungeonMo.mode)
end

function VersionActivityFixedDungeonMapEpisodeView:_onDragBeginHandler()
	self._audioScroll:onDragBegin()
end

function VersionActivityFixedDungeonMapEpisodeView:_onDragEndHandler()
	self._audioScroll:onDragEnd()
end

function VersionActivityFixedDungeonMapEpisodeView:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

function VersionActivityFixedDungeonMapEpisodeView:playOnOpenAnimation()
	self.chapterLayout:playAnimation(UIAnimationName.Open)

	if self.viewContainer.viewParam.needSelectFocusItem then
		self.chapterLayout:setSelectEpisodeId(self.activityDungeonMo.episodeId)
	else
		self.chapterLayout:playEpisodeItemAnimation("in")
	end
end

function VersionActivityFixedDungeonMapEpisodeView:playUnlockAnimation(needDone)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	local isNeedPlayHardModeUnlockAnim = VersionActivityFixedDungeonModel.instance:isNeedPlayHardModeUnlockAnimation()

	if isNeedPlayHardModeUnlockAnim then
		VersionActivityFixedDungeonModel.instance:savePlayerPrefsPlayHardModeUnlockAnimation()

		if self._hardModeBtnAnimator then
			self._hardModeBtnAnimator:Play(UIAnimationName.Unlock, 0, 0)
			TaskDispatcher.runDelay(self._unlockAniDone, self, HARD_MODE_UNLOCK_ANIM_TIME)

			return
		end
	end

	if needDone then
		self:_unlockAniDone()
	end
end

function VersionActivityFixedDungeonMapEpisodeView:_refreshHardModeCurrency(isOpen)
	local num, total = VersionActivityFixedDungeonModel.instance:getHardModeCurrenyNum(self.activityDungeonMo.activityDungeonConfig.hardChapterId)

	if total <= 0 then
		isOpen = false
	end

	local format = luaLang("activitymap_hardmode_reward_count")

	self._txthardModeCurrency.text = GameUtil.getSubPlaceholderLuaLangTwoParam(format, num, total)

	gohelper.setActive(self._hardModeCurrency, isOpen)

	self._cghardModeCurrency.alpha = self.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and 1 or 0.5
end

function VersionActivityFixedDungeonMapEpisodeView:_refreshHardModeVx()
	local dungeonActId = VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.Dungeon
	local isTip = VersionActivityFixedDungeonModel.instance:isTipHardModeUnlockOpen(dungeonActId)

	gohelper.setActive(self._hardModeUnlockvx, isTip)

	if isTip then
		VersionActivityFixedDungeonModel.instance:refreshVersionActivityEnterRedDot()
	end
end

function VersionActivityFixedDungeonMapEpisodeView:_unlockAniDone()
	local dungeonActId = VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.Dungeon
	local isOpen = VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(dungeonActId)

	if not isOpen then
		return
	end

	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnHardUnlockAnimDone)
end

function VersionActivityFixedDungeonMapEpisodeView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshModeLockText, self)
	TaskDispatcher.cancelTask(self.directChangeMode, self)
	TaskDispatcher.cancelTask(self._unlockAniDone, self)

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

	if self._episodeListTweenId then
		ZProj.TweenHelper.KillById(self._episodeListTweenId)
	end
end

return VersionActivityFixedDungeonMapEpisodeView
