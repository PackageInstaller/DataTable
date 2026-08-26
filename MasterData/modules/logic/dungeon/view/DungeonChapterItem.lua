-- chunkname: @modules/logic/dungeon/view/DungeonChapterItem.lua

module("modules.logic.dungeon.view.DungeonChapterItem", package.seeall)

local DungeonChapterItem = class("DungeonChapterItem", ListScrollCellExtend)

function DungeonChapterItem:onInitView()
	self._simagechapterIcon = gohelper.findChildSingleImage(self.viewGO, "anim/#simage_chapterIcon")
	self._golock = gohelper.findChild(self.viewGO, "anim/#go_lock")
	self._simagechapterIconLock = gohelper.findChildSingleImage(self.viewGO, "anim/#go_lock/#simage_chapterIconLock")
	self._txtname = gohelper.findChildText(self.viewGO, "anim/#txt_name")
	self._gobgdot = gohelper.findChild(self.viewGO, "anim/bg_dot")
	self._gobgdot2 = gohelper.findChild(self.viewGO, "anim/bg_glow02")
	self._gobgdot3 = gohelper.findChild(self.viewGO, "anim/bg_glow03")
	self._gobgdot4 = gohelper.findChild(self.viewGO, "anim/bg_glow04")
	self._imagelockicon = gohelper.findChildImage(self.viewGO, "anim/#go_lock/icon")
	self._txtchapterNum = gohelper.findChildText(self.viewGO, "anim/#go_lock/#txt_chapterNum")
	self._goreddot = gohelper.findChild(self.viewGO, "anim/#go_reddot")
	self._gopreview = gohelper.findChild(self.viewGO, "anim/#go_first")
	self._gostorytrace = gohelper.findChild(self.viewGO, "anim/#go_trace")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonChapterItem:addEvents()
	return
end

function DungeonChapterItem:removeEvents()
	return
end

function DungeonChapterItem:_btncategoryOnClick()
	self._isLock, self._lockCode, self._lockToast, self._lockToastParam = DungeonModel.instance:chapterIsLock(self._mo.id)

	if self._isLock then
		if self._lockToast then
			GameFacade.showToast(self._lockToast, self._lockToastParam)
		end

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)

	if self._showPreviewChapterFlag then
		local key = DungeonMainStoryModel.getKey(PlayerPrefsKey.OpenDungeonPreviewChapter, self._mo.id)

		if not PlayerPrefsHelper.hasKey(key) then
			GameFacade.showMessageBox(MessageBoxIdDefine.PreviewChapterOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				self:_openDungeonChapterView()
			end, nil, nil)

			return
		end
	end

	self:_openDungeonChapterView()
end

function DungeonChapterItem:_openDungeonChapterView()
	DungeonMainStoryModel.instance:saveClickChapterId(self._mo.id)

	local param = {}

	param.chapterId = self._mo.id

	DungeonController.instance:openDungeonChapterView(param)
	self:_setDotState(false)
end

function DungeonChapterItem:_editableInitView()
	local animGo = gohelper.findChild(self.viewGO, "anim")

	self._anim = animGo:GetComponent(typeof(UnityEngine.Animation))
	self._canvasGroup = animGo:GetComponent(typeof(UnityEngine.CanvasGroup))

	local firstShowNormalTime = DungeonChapterListModel.instance.firstShowNormalTime

	self._canPlayEnterAnim = firstShowNormalTime and Time.time - firstShowNormalTime < 0.5
	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)

	gohelper.setActive(self._gopreview, false)
end

function DungeonChapterItem:_editableAddEvents()
	self._click:AddClickListener(self._btncategoryOnClick, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnGetPointReward, self._updateMapTip, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnGuidePlayUnlockAnim, self._onGuidePlayUnlockAnim, self)
	StoryController.instance:registerCallback(StoryEvent.Start, self._onStart, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._onFinish, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnShowStoryView, self._setEnterAnimState, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, self._refreshTraced, self)
end

function DungeonChapterItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnGetPointReward, self._updateMapTip, self)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnGuidePlayUnlockAnim, self._onGuidePlayUnlockAnim, self)
	StoryController.instance:unregisterCallback(StoryEvent.Start, self._onStart, self)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, self._onFinish, self)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnShowStoryView, self._setEnterAnimState, self)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, self._refreshTraced, self)
end

function DungeonChapterItem:_onStart(storyId)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		self._simagechapterIcon:UnLoadImage()
	end
end

function DungeonChapterItem:_onFinish(storyId)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		self._simagechapterIcon:LoadImage(ResUrl.getDungeonIcon(self._mo.chapterpic))
	end
end

function DungeonChapterItem:_onGuidePlayUnlockAnim()
	if self:_isNewChapter() then
		DungeonModel.instance.chapterTriggerNewChapter = true

		self:_doShowUnlockAnim()
	end
end

function DungeonChapterItem:_onCloseViewFinish(viewName, viewParam)
	if viewName == ViewName.DungeonMapView then
		self:_updateMapTip()
		self:_doShowUnlockAnim()
	end
end

function DungeonChapterItem:onUpdateMO(mo)
	self._mo = mo

	local chapterId = mo.id
	local imagePath = ResUrl.getDungeonIcon(mo.chapterpic)

	self._simagechapterIcon:LoadImage(imagePath)
	self._simagechapterIconLock:LoadImage(ResUrl.getDungeonIcon(mo.chapterpic .. "_lock"))

	self._isLock, self._lockCode, self._lockToast, self._lockToastParam = DungeonModel.instance:chapterIsLock(self._mo.id)
	self._txtname.text = mo.name

	local index = DungeonChapterListModel.instance:getChapterIndex(chapterId)

	self._txtchapterNum.text = index and string.format("CHAPTER %s", index) or "CHAPTER"

	local config, _ = DungeonModel.instance:getLastEpisodeConfigAndInfo()

	gohelper.setActive(self._gopointLight, chapterId == config.chapterId)

	if not self:_doShowUnlockAnim() then
		self:_setLockStatus(self:IsLock())
	end

	self:_setEnterAnim()
	self:_updateMapTip()
	self:refreshRed()
	self:_updatePreviewFlag()
	self:_refreshTraced()
end

function DungeonChapterItem:_updatePreviewFlag()
	self._showPreviewChapterFlag = DungeonMainStoryModel.instance:showPreviewChapterFlag(self._mo.id)

	gohelper.setActive(self._gopreview, self._showPreviewChapterFlag)
end

function DungeonChapterItem:_setEnterAnim()
	if self._canPlayEnterAnim then
		local animName = self:_getInAnimName()
		local enterClip = self._anim:GetClip(animName)

		if enterClip then
			self._anim:Play(animName)

			self._canvasGroup.alpha = 0

			TaskDispatcher.cancelTask(self._onEnterAnimFinished, self)
			TaskDispatcher.runDelay(self._onEnterAnimFinished, self, enterClip.length)

			return
		end
	end

	self:playIdleAnim()
end

function DungeonChapterItem:playIdleAnim()
	local animName = self:_getInAnimName()

	if not animName then
		return
	end

	local enterClip = self._anim:GetClip(animName)

	if enterClip then
		self._canvasGroup.alpha = 1

		self._anim:Play(animName)
	end
end

function DungeonChapterItem:playCloseAnim()
	self._isPlayCloseAnim = true

	local animName = self:_getCloseAnimName()

	self._anim:Play(animName)
end

function DungeonChapterItem:getIsPlayCloseAnim()
	return self._isPlayCloseAnim
end

function DungeonChapterItem:_getInAnimName()
	return "dungeonchapteritem_in"
end

function DungeonChapterItem:_getCloseAnimName()
	return "dungeonchapteritem_close"
end

function DungeonChapterItem:_onEnterAnimFinished()
	self._canPlayEnterAnim = false
end

function DungeonChapterItem:_setEnterAnimState()
	self._canPlayEnterAnim = true

	self:_setDotState(false)
	self:_setEnterAnim()
end

function DungeonChapterItem:_onUpdateDungeonInfo()
	if self._showPreviewChapterFlag then
		self:_updatePreviewFlag()
	end
end

function DungeonChapterItem:onRefreshActivity()
	if self._showPreviewChapterFlag then
		self:_updatePreviewFlag()

		if not self._showPreviewChapterFlag then
			self._isLock, self._lockCode, self._lockToast, self._lockToastParam = DungeonModel.instance:chapterIsLock(self._mo.id)

			self:_setLockStatus(self:IsLock())
		end
	end
end

function DungeonChapterItem:IsLock()
	return self._isLock or self:_isNewChapter()
end

function DungeonChapterItem:_isShowBtnGift()
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ChapterReward)
end

function DungeonChapterItem:_updateMapTip()
	return
end

function DungeonChapterItem:_isNewChapter()
	return self._mo.id == DungeonModel.instance.unlockNewChapterId or DungeonModel.instance:needUnlockChapterAnim(self._mo.id)
end

function DungeonChapterItem:_doShowUnlockAnim()
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		return false
	end

	local loadingState = GameGlobalMgr.instance:getLoadingState()

	if loadingState and loadingState:getLoadingViewName() then
		return false
	end

	if DungeonModel.instance.chapterTriggerNewChapter then
		local isNewChapter = self:_isNewChapter()

		if isNewChapter or DungeonModel.instance:needUnlockChapterAnim(self._mo.id) then
			self:_setLockStatus(true)
			TaskDispatcher.runDelay(self.showUnlockAnim, self, 0.5)

			return true
		end

		return false
	end
end

function DungeonChapterItem:_setLockStatus(isLock)
	self._golock:SetActive(isLock)
	gohelper.setActive(self._txtname.gameObject, not isLock)
end

function DungeonChapterItem:_onAnimFinished()
	self:_endBlock()
	self:_setLockStatus(false)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnUnlockNewChapterAnimFinish)
end

function DungeonChapterItem:_endBlock()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock(self:_getBlockName())

	self._startBlock = false
end

function DungeonChapterItem:_getBlockName()
	self._blockName = self._blockName or "UnlockNewChapterAnim" .. tostring(self._mo.id)

	return self._blockName
end

function DungeonChapterItem:showUnlockAnim()
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		self:_setLockStatus(self:IsLock())

		return
	end

	if DungeonModel.instance.chapterTriggerNewChapter then
		local isNewChapter = self:_isNewChapter()

		if isNewChapter or DungeonModel.instance:needUnlockChapterAnim(self._mo.id) then
			if isNewChapter then
				DungeonModel.instance.chapterTriggerNewChapter = nil
				DungeonModel.instance.unlockNewChapterId = nil
			end

			DungeonModel.instance:clearUnlockChapterAnim(self._mo.id)

			if not gohelper.isNil(self._anim) then
				local unlockAnimName = self:_getUnlockAnimName()
				local clip = self._anim:GetClip(unlockAnimName)

				if clip then
					UIBlockMgr.instance:endAll()
					UIBlockMgrExtend.setNeedCircleMv(false)
					UIBlockMgr.instance:startBlock(self:_getBlockName())

					self._startBlock = true

					TaskDispatcher.runDelay(self._onAnimFinished, self, clip.length)
					gohelper.setActive(self._txtname.gameObject, true)
				end

				self._canvasGroup.alpha = 1

				self._anim:Play(unlockAnimName)
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
			end
		end
	end
end

function DungeonChapterItem:_getUnlockAnimName()
	return "dungeonchapteritem_unlock"
end

function DungeonChapterItem:onSelect(isSelect)
	return
end

function DungeonChapterItem:_setDotState(state)
	gohelper.setActive(self._gobgdot, state)
	gohelper.setActive(self._gobgdot2, state)
	gohelper.setActive(self._gobgdot3, state)
	gohelper.setActive(self._gobgdot4, state)
	ZProj.UGUIHelper.SetColorAlpha(self._imagelockicon, 1)
end

function DungeonChapterItem:refreshRed()
	local redId = DungeonModel.instance:getChapterRedId(self._mo.id)

	if redId and redId > 0 then
		if not self.redDot then
			self.redDot = RedDotController.instance:addRedDot(self._goreddot, redId, 0)
		else
			self.redDot:refreshDot()
		end
	end
end

function DungeonChapterItem:_refreshTraced()
	self:_refreshTracedIcon()
end

function DungeonChapterItem:_refreshTracedIcon()
	if not self._mo then
		return
	end

	if DungeonModel.instance:chapterIsLock(self._mo.id) then
		return
	end

	local isTrade = CharacterRecommedModel.instance:isTradeChapter(self._mo.id)

	if isTrade then
		local tradeIconPrefab = CharacterRecommedController.instance:getTradeIcon()

		if not tradeIconPrefab then
			return
		end

		self._tracedIcon = self._tracedIcon or gohelper.clone(tradeIconPrefab, self._gostorytrace)
	end

	if self._tracedIcon then
		gohelper.setActive(self._tracedIcon, isTrade)
	end
end

function DungeonChapterItem:onDestroyView()
	self._simagechapterIcon:UnLoadImage()
	self._simagechapterIconLock:UnLoadImage()
	TaskDispatcher.cancelTask(self._onEnterAnimFinished, self)
	TaskDispatcher.cancelTask(self._onAnimFinished, self)
	TaskDispatcher.cancelTask(self.showUnlockAnim, self)

	if self._startBlock then
		self:_endBlock()
	end
end

return DungeonChapterItem
