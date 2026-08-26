-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeonbase/view/VersionActivity1_3DungeonBaseEpisodeView.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeonbase.view.VersionActivity1_3DungeonBaseEpisodeView", package.seeall)

local VersionActivity1_3DungeonBaseEpisodeView = class("VersionActivity1_3DungeonBaseEpisodeView", BaseView)

function VersionActivity1_3DungeonBaseEpisodeView:onInitView()
	self._gochaptercontentitem = gohelper.findChild(self.viewGO, "#scroll_content/#go_chaptercontentitem")
	self._btnstorymode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#btn_storyMode")
	self._btnhardmode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#btn_hardMode")
	self._gohardmodelock = gohelper.findChild(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#go_hardModeLock")
	self._imgstorymode = gohelper.findChildImage(self.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon")
	self._gostorymodeNormal = gohelper.findChild(self.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon/go_normal")
	self._gostorymodeSelect = gohelper.findChild(self.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon/go_select")
	self._imghardmode = gohelper.findChildImage(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon")
	self._gohardmodeNormal = gohelper.findChild(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon/go_normal")
	self._gohardmodeSelect = gohelper.findChild(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon/go_select")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3DungeonBaseEpisodeView:addEvents()
	self._btnstorymode:AddClickListener(self.btnStoryModeClick, self)
	self._btnhardmode:AddClickListener(self.btnHardModeClick, self)
end

function VersionActivity1_3DungeonBaseEpisodeView:removeEvents()
	self._btnstorymode:RemoveClickListener()
	self._btnhardmode:RemoveClickListener()
end

function VersionActivity1_3DungeonBaseEpisodeView:btnStoryModeClick()
	self:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
end

function VersionActivity1_3DungeonBaseEpisodeView:btnHardModeClick()
	local isOpen, toastId, toastParam = self:checkHardModeIsOpen()

	if not isOpen then
		GameFacade.showToast(toastId, toastParam)

		return
	end

	self:changeEpisodeMode(VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function VersionActivity1_3DungeonBaseEpisodeView:checkHardModeIsOpen()
	return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(VersionActivity1_3Enum.ActivityId.Dungeon)
end

function VersionActivity1_3DungeonBaseEpisodeView:changeEpisodeMode(mode)
	if mode == self.activityDungeonMo.mode then
		return
	end

	if self.waitChangeMode == mode then
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

	self.waitChangeMode = mode

	TaskDispatcher.cancelTask(self.directChangeMode, self)
	TaskDispatcher.runDelay(self.directChangeMode, self, 0.41)
end

function VersionActivity1_3DungeonBaseEpisodeView:directChangeMode()
	if self.waitChangeMode and self.activityDungeonMo then
		self.activityDungeonMo:changeMode(self.waitChangeMode)

		self.waitChangeMode = nil
	end
end

function VersionActivity1_3DungeonBaseEpisodeView:dailyRefresh()
	self:refreshModeNode()
	self:playUnlockAnimation()
end

function VersionActivity1_3DungeonBaseEpisodeView:_editableInitView()
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

	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
end

function VersionActivity1_3DungeonBaseEpisodeView:_onDragBeginHandler()
	self._audioScroll:onDragBegin()
end

function VersionActivity1_3DungeonBaseEpisodeView:_onDragEndHandler()
	self._audioScroll:onDragEnd()
end

function VersionActivity1_3DungeonBaseEpisodeView:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

function VersionActivity1_3DungeonBaseEpisodeView:playOnOpenAnimation()
	self.chapterLayout:playAnimation(UIAnimationName.Open)

	if self.viewContainer.viewParam.needSelectFocusItem then
		self.chapterLayout:setSelectEpisodeId(self.activityDungeonMo.episodeId)
	else
		self.chapterLayout:playEpisodeItemAnimation("in")
	end
end

function VersionActivity1_3DungeonBaseEpisodeView:onUpdateParam()
	self:refreshModeNode()
	self.chapterLayout:refreshEpisodeNodes()
	self:playOnOpenAnimation()
end

function VersionActivity1_3DungeonBaseEpisodeView:onOpen()
	self.activityDungeonMo = self.viewContainer.versionActivityDungeonBaseMo

	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self.setEpisodeListVisible, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:initChapterEpisodes()
	self:refreshModeNode()
end

function VersionActivity1_3DungeonBaseEpisodeView:initChapterEpisodes()
	self._uiLoader = MultiAbLoader.New()

	self._uiLoader:addPath(self.activityDungeonMo:getLayoutPrefabUrl())
	self._uiLoader:startLoad(self.onLoadLayoutFinish, self)
end

function VersionActivity1_3DungeonBaseEpisodeView:onLoadLayoutFinish()
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

function VersionActivity1_3DungeonBaseEpisodeView:onOpenFinish()
	self:playUnlockAnimation(true)
end

function VersionActivity1_3DungeonBaseEpisodeView:refreshModeNode()
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
end

function VersionActivity1_3DungeonBaseEpisodeView:onModeChange()
	self:refreshModeNode()
	self.chapterLayout:playAnimation("switch")
	self.chapterLayout:refreshEpisodeNodes()
end

function VersionActivity1_3DungeonBaseEpisodeView:setEpisodeListVisible(value)
	if not self.chapterLayout then
		return
	end

	local time = 0.2

	self._episodeListTweenId = value and ZProj.TweenHelper.DOAnchorPosY(self.chapterLayout.viewGO.transform, self.chapterLayout.defaultY, time) or ZProj.TweenHelper.DOAnchorPosY(self.chapterLayout.viewGO.transform, -260, time)
end

function VersionActivity1_3DungeonBaseEpisodeView:_onUpdateDungeonInfo()
	if self.chapterLayout then
		self.chapterLayout:refreshEpisodeNodes()
	end
end

function VersionActivity1_3DungeonBaseEpisodeView:_onCloseViewFinish(viewName)
	if viewName == self.viewName then
		return
	end

	self:playUnlockAnimation()
end

function VersionActivity1_3DungeonBaseEpisodeView:playUnlockAnimation(needDone)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if self:needPlayUnLockAnimation() then
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(VersionActivity1_3EnterController.GetActivityPrefsKey(PlayerPrefsKey.LeiMiTeBeiPlayHardModeUnlockAnimationKey)), 1)

		local goHardMode = gohelper.findChild(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode")
		local animatorPlayer = goHardMode and SLFramework.AnimatorPlayer.Get(goHardMode)

		if animatorPlayer then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_explore_open)
			animatorPlayer:Play("unlock", self._unlockDone, self)

			return
		end
	end

	if needDone then
		self:_unlockDone()
	end
end

function VersionActivity1_3DungeonBaseEpisodeView:_unlockDone()
	local isOpen = VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_3Enum.ActivityId.Dungeon)

	if not isOpen then
		return
	end

	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnHardUnlockAnimDone)
end

function VersionActivity1_3DungeonBaseEpisodeView:needPlayUnLockAnimation()
	local isPlayed = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(VersionActivity1_3EnterController.GetActivityPrefsKey(PlayerPrefsKey.LeiMiTeBeiPlayHardModeUnlockAnimationKey)), 0) == 1

	if isPlayed then
		return false
	end

	local isOpen = VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_3Enum.ActivityId.Dungeon)

	if not isOpen then
		return false
	end

	return true
end

function VersionActivity1_3DungeonBaseEpisodeView:onDestroyView()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	TaskDispatcher.cancelTask(self.directChangeMode, self)

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

return VersionActivity1_3DungeonBaseEpisodeView
