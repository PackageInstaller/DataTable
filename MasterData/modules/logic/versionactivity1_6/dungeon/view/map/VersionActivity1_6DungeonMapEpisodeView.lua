-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/map/VersionActivity1_6DungeonMapEpisodeView.lua

module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapEpisodeView", package.seeall)

local VersionActivity1_6DungeonMapEpisodeView = class("VersionActivity1_6DungeonMapEpisodeView", BaseView)
local UnlockHardModeBtnAnimPrefsKey = VersionActivity1_6Enum.ActivityId.Dungeon .. "UnlockHardModeBtnAnim"

function VersionActivity1_6DungeonMapEpisodeView:onInitView()
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
	self._bossBtnLockTip = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_bossmode/#go_bossModeLock")
	self._btnBoss = gohelper.findChildButtonWithAudio(self.viewGO, "#go_switchmodecontainer/#go_bossmode/#btn_hardMode")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_6DungeonMapEpisodeView:addEvents()
	self._btnstorymode:AddClickListener(self.btnStoryModeClick, self)
	self._btnhardmode:AddClickListener(self.btnHardModeClick, self)
	self._btnBoss:AddClickListener(self._btnDungeonBossClick, self)
end

function VersionActivity1_6DungeonMapEpisodeView:removeEvents()
	self._btnstorymode:RemoveClickListener()
	self._btnhardmode:RemoveClickListener()
	self._btnBoss:RemoveClickListener()
end

function VersionActivity1_6DungeonMapEpisodeView:_onDragBeginHandler()
	self._audioScroll:onDragBegin()
end

function VersionActivity1_6DungeonMapEpisodeView:_onDragEndHandler()
	self._audioScroll:onDragEnd()
end

function VersionActivity1_6DungeonMapEpisodeView:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

function VersionActivity1_6DungeonMapEpisodeView:btnStoryModeClick()
	self:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
end

function VersionActivity1_6DungeonMapEpisodeView:btnHardModeClick()
	local isOpen, toastId, toastParam = self:checkHardModeIsOpen()

	if not isOpen then
		GameFacade.showToast(toastId, toastParam)

		return
	end

	self:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function VersionActivity1_6DungeonMapEpisodeView:_btnDungeonBossClick()
	local isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102)

	if not isUnlock then
		local toastId, toastParamList = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.Act_60102)

		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	if self.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		if self.activityDungeonMo.episodeId == VersionActivity1_6DungeonEnum.DungeonBossEpisodeId then
			self:_forceToBossElement()
		else
			self:_forceToBossEpisode()
		end
	else
		self._changeModeCallback = self._forceToBossEpisode

		self:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
	end
end

function VersionActivity1_6DungeonMapEpisodeView:_forceToBossEpisode()
	self.activityDungeonMo:changeEpisode(VersionActivity1_6DungeonEnum.DungeonBossEpisodeId)
	self.chapterLayout:setSelectEpisodeId(VersionActivity1_6DungeonEnum.DungeonBossEpisodeId, true)
	self:markSelectBossEpisode()
end

function VersionActivity1_6DungeonMapEpisodeView:_forceToBossElement()
	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.FocusElement, VersionActivity1_6DungeonEnum.DungeonBossMapElementId)
end

function VersionActivity1_6DungeonMapEpisodeView:markSelectBossEpisode()
	VersionActivityDungeonBaseController.instance:setChapterIdLastSelectEpisodeId(VersionActivity1_6DungeonEnum.DungeonChapterId.Story, VersionActivity1_6DungeonEnum.DungeonBossEpisodeId)
end

function VersionActivity1_6DungeonMapEpisodeView:checkHardModeIsOpen()
	return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(VersionActivity1_6Enum.ActivityId.Dungeon)
end

function VersionActivity1_6DungeonMapEpisodeView:changeEpisodeMode(mode)
	if mode == self.activityDungeonMo.mode then
		return
	end

	if not self.chapterLayout then
		return
	end

	self.scrollRect.velocity = Vector2(0, 0)

	if mode == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		self.excessiveAnimator:Play("story")
	else
		self.excessiveAnimator:Play("hard")
	end

	self.activityDungeonMo.mode = mode

	TaskDispatcher.runDelay(self.directChangeMode, self, 0.41)
end

function VersionActivity1_6DungeonMapEpisodeView:directChangeMode()
	self.activityDungeonMo:changeMode(self.activityDungeonMo.mode)
end

function VersionActivity1_6DungeonMapEpisodeView:dailyRefresh()
	self:refreshModeNode()
	self:playUnlockAnimation()
end

function VersionActivity1_6DungeonMapEpisodeView:_editableInitView()
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
	gohelper.setActive(self._bossBtnLockTip, false)
	gohelper.setActive(self._goexcessive, true)

	self.excessiveAnimator = self._goexcessive:GetComponent(typeof(UnityEngine.Animator))
	self.goScrollRect = gohelper.findChild(self.viewGO, "#scroll_content")

	recthelper.setAnchorY(self.goScrollRect.transform, -240)

	self._changeModeCallback = nil

	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
end

function VersionActivity1_6DungeonMapEpisodeView:onUpdateParam()
	self:refreshModeNode()
	self.chapterLayout:refreshEpisodeNodes()
	self:playOnOpenAnimation()
end

function VersionActivity1_6DungeonMapEpisodeView:onOpen()
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.OnHideInteractUI, self.showUI, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnFuncUnlockRefresh, self.onFunUnlockRefreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:initChapterEpisodes()
	self:refreshModeNode()
end

function VersionActivity1_6DungeonMapEpisodeView:onOpenFinish()
	self:playUnlockAnimation(true)
end

function VersionActivity1_6DungeonMapEpisodeView:onDestroyView()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
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

function VersionActivity1_6DungeonMapEpisodeView:initChapterEpisodes()
	self._uiLoader = MultiAbLoader.New()

	self._uiLoader:addPath(self.activityDungeonMo:getLayoutPrefabUrl())
	self._uiLoader:startLoad(self.onLoadLayoutFinish, self)
end

function VersionActivity1_6DungeonMapEpisodeView:onLoadLayoutFinish()
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

function VersionActivity1_6DungeonMapEpisodeView:refreshModeNode()
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

function VersionActivity1_6DungeonMapEpisodeView:onModeChange()
	self:refreshModeNode()
	self.chapterLayout:playAnimation("switch")
	self.chapterLayout:refreshEpisodeNodes()

	if self._changeModeCallback then
		self:_changeModeCallback()

		self._changeModeCallback = nil
	end
end

function VersionActivity1_6DungeonMapEpisodeView:refreshModeLockText()
	local openTimeStamp = VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivity1_6DungeonEnum.DungeonChapterId.Hard)
	local serverTime = ServerTime.now()

	if serverTime < openTimeStamp then
		local timeStampOffset = openTimeStamp - serverTime
		local day = Mathf.Floor(timeStampOffset / TimeUtil.OneDaySecond)
		local hourSecond = timeStampOffset % TimeUtil.OneDaySecond
		local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
		local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_6Enum.ActivityId.Dungeon]

		if day > 0 then
			local tempStr = actInfoMo:getRemainTimeStr2(timeStampOffset)

			if hour > 0 then
				tempStr = GameUtil.getSubPlaceholderLuaLang(luaLang("hournum"), {
					tempStr,
					hour
				})
			end

			self._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), tempStr)
		else
			self._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), actInfoMo:getRemainTimeStr4(timeStampOffset))
		end

		gohelper.setActive(self._gohardmodelock, true)
		gohelper.setActive(self._hardModeLockTip, true)

		return
	end

	local isOpen, unLockEpisodeId = DungeonModel.instance:chapterIsUnLock(self.activityDungeonMo.activityDungeonConfig.hardChapterId)

	if not isOpen then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(unLockEpisodeId)

		self._txtunlocktime.text = string.format(luaLang("versionactivity1_3_hardlocktip"), "NS-" .. DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, unLockEpisodeId))

		gohelper.setActive(self._gohardmodelock, true)
		gohelper.setActive(self._hardModeLockTip, true)

		return
	end

	gohelper.setActive(self._gohardmodelock, false)
	gohelper.setActive(self._hardModeLockTip, false)
end

function VersionActivity1_6DungeonMapEpisodeView:onClickElement(elementComp)
	if elementComp:getElementId() == VersionActivity1_6DungeonEnum.DungeonBossMapElementId then
		AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossEnterClick)
		VersionActivity1_6DungeonController.instance:openDungeonBossView()
	end
end

function VersionActivity1_6DungeonMapEpisodeView:showUI()
	gohelper.setActive(self._gomodecontainer, true)
	self:showLayout()
end

function VersionActivity1_6DungeonMapEpisodeView:hideUI()
	gohelper.setActive(self._gomodecontainer, false)
	self:hideLayout()
end

function VersionActivity1_6DungeonMapEpisodeView:showLayout()
	if not self.chapterLayout then
		return
	end

	self._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(self.chapterLayout.viewGO.transform, self.chapterLayout.defaultY, 0.2)
end

function VersionActivity1_6DungeonMapEpisodeView:hideLayout()
	if not self.chapterLayout then
		return
	end

	self._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(self.chapterLayout.viewGO.transform, -260, 0.2)
end

function VersionActivity1_6DungeonMapEpisodeView:_onUpdateDungeonInfo()
	if self.chapterLayout then
		self.chapterLayout:refreshEpisodeNodes()
	end

	self:refreshModeNode()
	self:playUnlockAnimation()
end

function VersionActivity1_6DungeonMapEpisodeView:_onCloseViewFinish(viewName)
	if viewName == self.viewName then
		return
	end

	self:playUnlockAnimation()
end

function VersionActivity1_6DungeonMapEpisodeView:onFunUnlockRefreshUI()
	self:refreshModeNode()
	self:playUnlockAnimation()
end

function VersionActivity1_6DungeonMapEpisodeView:playOnOpenAnimation()
	self.chapterLayout:playAnimation(UIAnimationName.Open)

	if self.viewContainer.viewParam.needSelectFocusItem then
		self.chapterLayout:setSelectEpisodeId(self.activityDungeonMo.episodeId)
	else
		self.chapterLayout:playEpisodeItemAnimation("in")
	end
end

function VersionActivity1_6DungeonMapEpisodeView:playUnlockAnimation(needDone)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if self:checkPlayUnLockAnimation() then
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(UnlockHardModeBtnAnimPrefsKey), 1)

		local animator = gohelper.findChildComponent(self.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator)

		if animator then
			AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonHardModeUnlock)
			animator:Play(UIAnimationName.Unlock, 0, 0)
			TaskDispatcher.runDelay(self._unlockAniDone, self, VersionActivity1_6DungeonEnum.HardModeUnlockAnimDuration)

			return
		end
	end

	if needDone then
		self:_unlockAniDone()
	end
end

function VersionActivity1_6DungeonMapEpisodeView:_unlockAniDone()
	local animator = gohelper.findChildComponent(self.viewGO, "#go_switchmodecontainer/#go_hardmode", gohelper.Type_Animator)
	local goUnlock = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode/#unlock")

	animator.enabled = false

	gohelper.setActive(goUnlock, false)

	local isOpen = VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_6Enum.ActivityId.Dungeon)

	if not isOpen then
		return
	end

	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnHardUnlockAnimDone)
end

function VersionActivity1_6DungeonMapEpisodeView:checkPlayUnLockAnimation()
	local hardModeKey = UnlockHardModeBtnAnimPrefsKey
	local isPlayed = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(hardModeKey, 0)) == 1

	if isPlayed then
		return false
	end

	local isOpen = VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_6Enum.ActivityId.Dungeon)

	if not isOpen then
		return false
	end

	return true
end

return VersionActivity1_6DungeonMapEpisodeView
