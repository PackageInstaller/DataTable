-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_LevelView.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_LevelView", package.seeall)

local V3a7_Wmz_LevelView = class("V3a7_Wmz_LevelView", BaseView)

function V3a7_Wmz_LevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._scrollStory = gohelper.findChildScrollRect(self.viewGO, "#scroll_Story")
	self._goMove = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move")
	self._goStoryStages = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/#go_StoryStages")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_Title/image_LimitTimeBG/#txt_LimitTime")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goReddot = gohelper.findChild(self.viewGO, "#btn_Task/#go_Reddot")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_LevelView:addEvents()
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
end

function V3a7_Wmz_LevelView:removeEvents()
	self._btnTask:RemoveClickListener()
end

local ti = table.insert
local csTweenHelper = ZProj.TweenHelper

function V3a7_Wmz_LevelView:ctor(...)
	V3a7_Wmz_LevelView.super.ctor(self, ...)

	self._storyItemList = {}
	self._latestStoryItem = 1
end

function V3a7_Wmz_LevelView:_actId()
	return self.viewContainer:actId()
end

function V3a7_Wmz_LevelView:_taskType()
	return self.viewContainer:taskType()
end

function V3a7_Wmz_LevelView:_create_V3a7_Wmz_LevelItem(parentGO, index)
	local viewSetting = self.viewContainer:getSetting()
	local resPath = viewSetting.otherRes.v3a7_wmz_levelitem
	local go = self.viewContainer:getResInst(resPath, parentGO, V3a7_Wmz_LevelItem.__cname)
	local item = V3a7_Wmz_LevelItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a7_Wmz_LevelView:onLevelItemClick(levelItemObj)
	if not levelItemObj:isEpisodeUnlock() then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	self:_onStoryItemClick(levelItemObj:index())
end

function V3a7_Wmz_LevelView:_btnTaskOnClick()
	local viewParam = {
		actId = self:_actId(),
		taskType = self:_taskType()
	}

	ViewMgr.instance:openView(ViewName.V3a7_Wmz_TaskView, viewParam)
end

function V3a7_Wmz_LevelView:_getDataList()
	self._tmpDataList = self._tmpDataList or self.viewContainer:getEpisodeConfigList()

	return self._tmpDataList
end

local function _findLineChildsImpl(refList, tr)
	local childCount = tr.childCount

	for i = 0, childCount - 1 do
		local childTr = tr:GetChild(i)

		ti(refList, childTr.gameObject)
	end
end

function V3a7_Wmz_LevelView:_editableInitView()
	local activityCo = self.viewContainer:getActivityCo()

	self._pathGo = gohelper.findChild(self._goMove, "path")
	self._lineAnimCmp = self._pathGo:GetComponent(gohelper.Type_Animator)
	self._goMoveTrans = self._goMove.transform
	self._goLevelItemContainerList = self:getUserDataTb_()

	_findLineChildsImpl(self._goLevelItemContainerList, self._goStoryStages.transform)

	local goTaskAnim = gohelper.findChild(self.viewGO, "#btn_Task/ani")

	self._animTask = goTaskAnim:GetComponent(gohelper.Type_Animator)
	self._gostoryPath = self._scrollStory.gameObject
	self._scrollStoryTrans = self._gostoryPath.transform
	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._gostoryPath, DungeonMapEpisodeAudio, self._scrollStory)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gostoryPath)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self._gostoryPath)

	self._touch:AddClickDownListener(self._onClickDown, self)

	local viewportWidth = recthelper.getWidth(self._scrollStoryTrans)
	local rightOffsetX = -300

	self._offsetX = (viewportWidth - rightOffsetX) / 2

	local maxWidth = recthelper.getWidth(self._goMoveTrans)

	self._minContentAnchorX = -maxWidth + viewportWidth

	self:_refreshItemList()
	gohelper.setActive(self._btnPlayBtn, activityCo.storyId > 0)
	self.viewContainer:addRedDot_Activity220Task(self._goReddot)

	self._simageFullBGTrans = self._simageFullBG.transform
	self._bgMoveRange = {
		max = 0,
		min = 0
	}
	self._bgwidth = recthelper.getWidth(self._simageFullBGTrans)
end

function V3a7_Wmz_LevelView:onOpen()
	self:_onRefreshClientCharacterDot()
	self:_showLeftTime()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
	self:_initPathStatus()
	self.addEventCb(self, StoryController.instance, StoryEvent.Finish, self._onStoryFinish, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Start, self._onStoryStart, self)
	self.addEventCb(self, Activity220Controller.instance, Activity220Event.EpisodePush, self._onEpisodePush, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._onRefreshClientCharacterDot, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self:_onScreenResize()
	self._scrollStory:AddOnValueChanged(self._onScrollValueChanged, self)
end

function V3a7_Wmz_LevelView:_onScrollValueChanged()
	local value01 = self._scrollStory.horizontalNormalizedPosition

	value01 = GameUtil.saturate(value01)

	local moveX = GameUtil.remap(value01, 0, 1, self._bgMoveRange.min, self._bgMoveRange.max)

	recthelper.setAnchorX(self._simageFullBGTrans, -moveX)
end

function V3a7_Wmz_LevelView:_onScreenResize()
	local canvasWidth = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local move = math.abs(self._bgwidth - canvasWidth) * 0.5

	self._bgMoveRange.min = -move
	self._bgMoveRange.max = move
end

function V3a7_Wmz_LevelView:_initPathStatus()
	for i, _ in ipairs(self._goLevelItemContainerList) do
		if i <= self._latestStoryItem then
			self:playAnim_PathIdle(i)
		end
	end
end

function V3a7_Wmz_LevelView:onOpenFinish()
	if not self._storyItemList[1] then
		return
	end

	if self:_checkFirstEnter() then
		self.viewContainer:simpleLockScreen(true)
		self._storyItemList[1]:_setActive_goLocked(true)
		TaskDispatcher.cancelTask(self._playFirstUnlock, self)
		TaskDispatcher.runDelay(self._playFirstUnlock, self, 0.8)
	end
end

function V3a7_Wmz_LevelView:_checkFirstEnter()
	local list = self:_getDataList()

	if not list or #list == 0 then
		return false
	end

	local episodeCO = list[2]

	if not episodeCO then
		return false
	end

	local episodeId = episodeCO.episodeId
	local isEpisodeUnlock = self.viewContainer:isEpisodeUnlock(episodeId)

	if not isEpisodeUnlock and not self.viewContainer:getIsActFirstEnter() then
		return true
	end

	return false
end

function V3a7_Wmz_LevelView:onClose()
	GameUtil.onDestroyViewMember_TweenId(self, "_moveTweenId")
	GameUtil.onDestroyViewMemberList(self, "_storyItemList")
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.cancelTask(self._playFirstUnlock, self)
	TaskDispatcher.cancelTask(self._unlockStoryEnd, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._playPathAnim, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	self.viewContainer:simpleLockScreen(false)
end

function V3a7_Wmz_LevelView:onDestroyView()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	GameUtil.onDestroyViewMemberList(self, "_storyItemList")
	GameUtil.onDestroyViewMember_TweenId(self, "_moveTweenId")

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	if self._touch then
		self._touch:RemoveClickDownListener()

		self._touch = nil
	end

	if self._scrollStory then
		self._scrollStory:RemoveOnValueChanged()
	end
end

function V3a7_Wmz_LevelView:_onStoryItemClick(index)
	self:_focusStoryItem(index, true, true)
end

function V3a7_Wmz_LevelView:_onStoryStart(storyId)
	local latestStoryCo = self:_getLatestStoryCo()

	if not latestStoryCo or latestStoryCo.storyClear ~= storyId then
		return
	end

	local episodeId = latestStoryCo.id
	local isPass = self.viewContainer:isEpisodePass(episodeId)

	if isPass then
		return
	end

	self._newFinishStoryEpisodeId = episodeId
end

function V3a7_Wmz_LevelView:_onStoryFinish()
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 0.73)
end

function V3a7_Wmz_LevelView:_onEpisodePush()
	local latestStoryCo = self:_getLatestStoryCo()

	if latestStoryCo then
		if not latestStoryCo.id then
			local latestEpisodeId = 0
			local bHasGame = self.viewContainer:bHasGame(latestEpisodeId)

			if latestStoryCo and latestStoryCo.storyClear ~= 0 then
				return
			end

			local baseDelayTime = 0.73
			local addDelayTime = bHasGame and 1.5 or 0
			local targetDelayTime = baseDelayTime + addDelayTime

			TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
			TaskDispatcher.runDelay(self._playStoryFinishAnim, self, targetDelayTime)
		end
	end
end

function V3a7_Wmz_LevelView:_getLatestStoryCo()
	local list = self:_getDataList()

	return list and list[self._latestStoryItem]
end

function V3a7_Wmz_LevelView:_onRefreshClientCharacterDot()
	local isDotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity220Task, self:_actId())

	if isDotShow then
		self._animTask:Play(UIAnimationName.Loop)
	else
		self._animTask:Play(UIAnimationName.Idle)
	end
end

function V3a7_Wmz_LevelView:_onStoryOpenEnd()
	self:_initPathStatus()
end

function V3a7_Wmz_LevelView:_onGoStoryEnd()
	self:_initPathStatus()
end

function V3a7_Wmz_LevelView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function V3a7_Wmz_LevelView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function V3a7_Wmz_LevelView:_onClickDown()
	self._audioScroll:onClickDown()
end

function V3a7_Wmz_LevelView:_refreshItemList()
	local bShowFirstLock = self:_checkFirstEnter()
	local list = self:_getDataList()
	local maxN = #self._goLevelItemContainerList
	local maxUnlockEpisode = self.viewContainer:getMaxUnlockEpisodeId()

	for i, episodeCO in ipairs(list or {}) do
		local parentGO = self._goLevelItemContainerList[i]
		local episodeId = episodeCO.episodeId
		local item

		if i > #self._storyItemList then
			item = self:_create_V3a7_Wmz_LevelItem(parentGO, i)

			ti(self._storyItemList, item)
		else
			item = self._storyItemList[i]
		end

		local isShowCurrent = maxUnlockEpisode == episodeId

		item:onUpdateMO(episodeCO)
		item:setActive(true)
		item:setActive_goCurrent(isShowCurrent)

		if maxUnlockEpisode == episodeId then
			self._latestStoryItem = i
		end

		if i == 1 and bShowFirstLock then
			item:_setActive_goLocked(true)
			item:playIdle(false)
		end
	end

	local n = math.min(maxN, #self._storyItemList)

	for i = #self._storyItemList + 1, n do
		local item = self._storyItemList[i]

		item:setActive(false)
	end

	self:_focusStoryItem(self._latestStoryItem)
end

function V3a7_Wmz_LevelView:_playFirstUnlock()
	self.viewContainer:setIsActFirstEnter(true)

	self._finishStoryIndex = 0

	self._storyItemList[1]:playUnlock()
	TaskDispatcher.cancelTask(self._unlockStoryEnd, self)
	TaskDispatcher.runDelay(self._unlockStoryEnd, self, 1.33)
end

function V3a7_Wmz_LevelView:_playStoryFinishAnim()
	local newFinishStoryLvlId = self.viewContainer:getNewFinishEpisode()
	local targetNewFinishStoryLvlId = newFinishStoryLvlId or self._newFinishStoryEpisodeId

	if targetNewFinishStoryLvlId then
		for index, storyItem in ipairs(self._storyItemList) do
			if storyItem:episodeId() == targetNewFinishStoryLvlId then
				self.viewContainer:simpleLockScreen(true)

				self._finishStoryIndex = index

				TaskDispatcher.cancelTask(self._finishStoryEnd, self)
				TaskDispatcher.runDelay(self._finishStoryEnd, self, 1)

				break
			end
		end

		self._newFinishStoryEpisodeId = nil

		self.viewContainer:clearFinishEpisode()
	end
end

function V3a7_Wmz_LevelView:_finishStoryEnd()
	if not self._finishStoryIndex then
		return
	end

	local storyItem = self._storyItemList[self._finishStoryIndex]

	if storyItem then
		storyItem:playStarAnim()
	end

	if self._finishStoryIndex == #self._storyItemList then
		self._latestStoryItem = self._finishStoryIndex
		self._finishStoryIndex = nil

		self.viewContainer:simpleLockScreen(false)
	else
		self._latestStoryItem = self._finishStoryIndex + 1

		self:_playPathAnim()
	end
end

function V3a7_Wmz_LevelView:_playPathAnim()
	if not self._finishStoryIndex then
		return
	end

	self:playAnim_PathUnlock(self._finishStoryIndex + 1)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	TaskDispatcher.runDelay(self._unlockStory, self, 0.33)
end

function V3a7_Wmz_LevelView:_unlockStory()
	if not self._finishStoryIndex then
		return
	end

	local index = self._finishStoryIndex + 1
	local storyItem = self._storyItemList[index]

	if not storyItem then
		return
	end

	storyItem:playUnlock()
	TaskDispatcher.cancelTask(self._unlockStoryEnd, self)
	TaskDispatcher.runDelay(self._unlockStoryEnd, self, 1)
end

function V3a7_Wmz_LevelView:_unlockStoryEnd()
	if self._finishStoryIndex then
		local lastStoryItem = self._storyItemList[self._finishStoryIndex]

		if lastStoryItem then
			lastStoryItem:refresh()
		end

		local index = self._finishStoryIndex + 1
		local storyItem = self._storyItemList[index]

		if storyItem then
			storyItem:refresh()
			self:_focusStoryItem(index, true)
		end
	end

	self._finishStoryIndex = nil

	self.viewContainer:simpleLockScreen(false)
end

function V3a7_Wmz_LevelView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self:_actId())
end

local kFocusDuration = 0.5

function V3a7_Wmz_LevelView:_focusStoryItem(index, isTween, needPlayStory)
	local contentAnchorX = recthelper.getAnchorX(self._storyItemList[index]:transform().parent)
	local offsetX = self._offsetX - contentAnchorX

	offsetX = GameUtil.clamp(offsetX, self._minContentAnchorX, 0)

	GameUtil.onDestroyViewMember_TweenId(self, "_moveTweenId")

	if isTween then
		self._moveTweenId = csTweenHelper.DOAnchorPosX(self._goMoveTrans, offsetX, kFocusDuration, self._onFocusEnd, self, needPlayStory and index or nil)
	else
		recthelper.setAnchorX(self._goMoveTrans, offsetX)
	end

	self:_setFocusFlag(index)
end

function V3a7_Wmz_LevelView:_onFocusEnd(index)
	if not index then
		return
	end

	local item = self._storyItemList[index]

	if not item then
		return
	end

	item:playStory()
end

function V3a7_Wmz_LevelView:_setFocusFlag(index)
	local preFocusStoryItem = self._storyItemList[self._focusStoryIndex]
	local curFocusStoryItem = self._storyItemList[index]

	if preFocusStoryItem then
		preFocusStoryItem:setActive_goCurrent(false)
	end

	if curFocusStoryItem then
		curFocusStoryItem:setActive_goCurrent(true)
	end

	self._focusStoryIndex = index

	self.viewContainer:simpleLockScreen(false)
end

function V3a7_Wmz_LevelView:playAnim_PathIdle(itemIndex)
	itemIndex = GameUtil.clamp(itemIndex, 1, 9)

	local animName = "idle" .. tostring(itemIndex)

	self._lineAnimCmp:Play(animName, 0, 1)
end

function V3a7_Wmz_LevelView:playAnim_PathUnlock(itemIndex)
	itemIndex = GameUtil.clamp(itemIndex, 1, 9)

	if itemIndex <= 1 then
		return
	end

	local animName = "move" .. tostring(itemIndex)

	self._lineAnimCmp:Play(animName, 0, 0)
end

return V3a7_Wmz_LevelView
