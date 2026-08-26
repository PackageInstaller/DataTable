-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_LevelView.lua

local ti = table.insert

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_LevelView", package.seeall)

local V3a4_Chg_LevelView = class("V3a4_Chg_LevelView", BaseView)

function V3a4_Chg_LevelView:onInitView()
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

function V3a4_Chg_LevelView:addEvents()
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
end

function V3a4_Chg_LevelView:removeEvents()
	self._btnTask:RemoveClickListener()
end

function V3a4_Chg_LevelView:ctor(...)
	V3a4_Chg_LevelView.super.ctor(self, ...)

	self._storyItemList = {}
	self._latestStoryItem = 1
end

function V3a4_Chg_LevelView:_actId()
	return self.viewContainer:actId()
end

function V3a4_Chg_LevelView:_taskType()
	return self.viewContainer:taskType()
end

function V3a4_Chg_LevelView:_create_V3a4_Chg_LevelItem(parentGO, index)
	local viewSetting = self.viewContainer:getSetting()
	local resPath = viewSetting.otherRes.v3a4_chg_levelitem
	local go = self.viewContainer:getResInst(resPath, parentGO, V3a4_Chg_LevelItem.__cname)
	local item = V3a4_Chg_LevelItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a4_Chg_LevelView:onLevelItemClick(levelItemObj)
	if not levelItemObj:isLevelUnlock() then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, levelItemObj:index())
end

function V3a4_Chg_LevelView:_btnTaskOnClick()
	local viewParam = {
		actId = self:_actId(),
		taskType = self:_taskType()
	}

	ViewMgr.instance:openView(ViewName.V3a4_Chg_TaskView, viewParam)
end

function V3a4_Chg_LevelView:_getDataList()
	self._tmpDataList = self._tmpDataList or self.viewContainer:getStoryLevelList()

	return self._tmpDataList
end

local kPathAnimPrefix = "stages_path_"

local function _animName_Path(animIndex)
	animIndex = GameUtil.clamp(animIndex, 0, 8)

	return kPathAnimPrefix .. tostring(animIndex)
end

function V3a4_Chg_LevelView:playAnim_PathIdle(itemIndex)
	local animName = _animName_Path(itemIndex)

	self._lineAnimCmp:Play(animName, 0, 1)
end

function V3a4_Chg_LevelView:playAnim_PathUnlock(itemIndex)
	local animName = _animName_Path(itemIndex)

	self._lineAnimCmp:Play(animName, 0, 0)
end

local function _findLineChildsImpl(refList, tr)
	local childCount = tr.childCount

	for i = 0, childCount - 1 do
		local childTr = tr:GetChild(i)

		ti(refList, childTr.gameObject)
	end
end

function V3a4_Chg_LevelView:_editableInitView()
	self._lineAnimCmp = gohelper.findChild(self._goMove, "path"):GetComponent(gohelper.Type_Animator)
	self._goMoveTrans = self._goMove.transform
	self._goLevelItemContainerList = self:getUserDataTb_()

	_findLineChildsImpl(self._goLevelItemContainerList, self._goStoryStages.transform)

	local goTaskAnim = gohelper.findChild(self.viewGO, "#btn_Task/ani")

	self._animTask = goTaskAnim:GetComponent(gohelper.Type_Animator)
	self._gostoryPath = self._scrollStory.gameObject
	self._scrollStoryTrans = self._gostoryPath.transform

	local activityCo = self.viewContainer:getActivityCo()

	RoleActivityModel.instance:initData(self:_actId())

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
end

function V3a4_Chg_LevelView:onOpen()
	self.viewContainer:addRedDot_V1a6RoleActivityTask(self._goReddot)
	self:_onRefreshClientCharacterDot()
	self:_showLeftTime()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
	self:_initPathStatus()
	self.addEventCb(self, RoleActivityController.instance, RoleActivityEvent.StoryItemClick, self._onStoryItemClick, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Finish, self._onStoryFinish, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Start, self._onStoryStart, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnEndDungeonPush, self._onEndDungeonPush, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._onRefreshClientCharacterDot, self)
end

function V3a4_Chg_LevelView:onOpenFinish()
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

function V3a4_Chg_LevelView:_checkFirstEnter()
	local list = self:_getDataList()

	if not list or #list == 0 then
		return false
	end

	local episodeCO = list[2]

	if not episodeCO then
		return false
	end

	local episodeId = episodeCO.id
	local isLevelUnlock = self.viewContainer:isLevelUnlock(episodeId)

	if not isLevelUnlock and not self.viewContainer:getIsActChgFirstEnter() then
		return true
	end

	return false
end

function V3a4_Chg_LevelView:onClose()
	GameUtil.onDestroyViewMember_TweenId(self, "_moveTweenId")
	GameUtil.onDestroyViewMemberList(self, "_storyItemList")
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.cancelTask(self._playFirstUnlock, self)
	TaskDispatcher.cancelTask(self._delayOpenStory, self)
	TaskDispatcher.cancelTask(self._unlockStoryEnd, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._playPathAnim, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	self.viewContainer:simpleLockScreen(false)
end

function V3a4_Chg_LevelView:onDestroyView()
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

function V3a4_Chg_LevelView:_onStoryItemClick(index)
	self:_focusStoryItem(index, true, true)
end

function V3a4_Chg_LevelView:_onStoryStart(storyId)
	local latestStoryCo = self:getLatestStoryCo()

	if not latestStoryCo or latestStoryCo.afterStory ~= storyId then
		return
	end

	local isPass = DungeonModel.instance:hasPassLevelAndStory(latestStoryCo.id)

	if isPass then
		return
	end

	self._newFinishStoryLvlId = latestStoryCo.id
end

function V3a4_Chg_LevelView:_onStoryFinish()
	RoleActivityModel.instance:updateData(self:_actId())
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 0.73)
	TaskDispatcher.cancelTask(self._delayOpenStory, self)
	TaskDispatcher.runDelay(self._delayOpenStory, self, 0.4)
end

function V3a4_Chg_LevelView:_onEndDungeonPush()
	RoleActivityModel.instance:updateData(self:_actId())

	local latestStoryCo = self:getLatestStoryCo()
	local latestEpisodeId = latestStoryCo and latestStoryCo.id
	local hasElement = Activity176Config.instance:hasElementCo(self:_actId(), latestEpisodeId)

	if latestStoryCo and latestStoryCo.afterStory ~= 0 then
		return
	end

	local baseDelayTime = 0.73
	local addDelayTime = hasElement and 1.5 or 0
	local targetDelayTime = baseDelayTime + addDelayTime

	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.runDelay(self._playStoryFinishAnim, self, targetDelayTime)
end

function V3a4_Chg_LevelView:getLatestStoryCo()
	local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(self:_actId())

	return storyConfigList and storyConfigList[self._latestStoryItem]
end

function V3a4_Chg_LevelView:_onRefreshClientCharacterDot()
	local isDotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V1a6RoleActivityTask, self:_actId())

	if isDotShow then
		self._animTask:Play(UIAnimationName.Loop)
	else
		self._animTask:Play(UIAnimationName.Idle)
	end
end

function V3a4_Chg_LevelView:_onStoryOpenEnd()
	self:_initPathStatus()
end

function V3a4_Chg_LevelView:_onGoStoryEnd()
	self:_initPathStatus()
end

function V3a4_Chg_LevelView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function V3a4_Chg_LevelView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function V3a4_Chg_LevelView:_onClickDown()
	self._audioScroll:onClickDown()
end

function V3a4_Chg_LevelView:_refreshItemList()
	local bShowFirstLock = self:_checkFirstEnter()
	local list = self:_getDataList()
	local maxN = #self._goLevelItemContainerList
	local currentEpisodeIdToPlay = self.viewContainer:currentEpisodeIdToPlay()

	for i, episodeCO in ipairs(list) do
		local parentGO = self._goLevelItemContainerList[i]
		local episodeId = episodeCO.id
		local item

		if i > #self._storyItemList then
			item = self:_create_V3a4_Chg_LevelItem(parentGO, i)

			ti(self._storyItemList, item)
		else
			item = self._storyItemList[i]
		end

		local isShowCurrent = currentEpisodeIdToPlay == episodeId

		item:onUpdateMO(episodeCO)
		item:setActive(true)
		item:setActive_goCurrent(isShowCurrent)

		if currentEpisodeIdToPlay == episodeId then
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

function V3a4_Chg_LevelView:_playFirstUnlock()
	self.viewContainer:setIsActChgFirstEnter(true)

	self._finishStoryIndex = 0

	self._storyItemList[1]:playUnlock()
	TaskDispatcher.cancelTask(self._unlockStoryEnd, self)
	TaskDispatcher.runDelay(self._unlockStoryEnd, self, 1.33)
end

function V3a4_Chg_LevelView:_playStoryFinishAnim()
	local newFinishStoryLvlId = RoleActivityModel.instance:getNewFinishStoryLvl()
	local targetNewFinishStoryLvlId = newFinishStoryLvlId or self._newFinishStoryLvlId

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

		self._newFinishStoryLvlId = nil

		RoleActivityModel.instance:clearNewFinishStoryLvl()
	end
end

function V3a4_Chg_LevelView:_finishStoryEnd()
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

function V3a4_Chg_LevelView:_playPathAnim()
	if not self._finishStoryIndex then
		return
	end

	self:playAnim_PathUnlock(self._finishStoryIndex)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	TaskDispatcher.runDelay(self._unlockStory, self, 0.33)
end

function V3a4_Chg_LevelView:_unlockStory()
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

function V3a4_Chg_LevelView:_unlockStoryEnd()
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

function V3a4_Chg_LevelView:_delayOpenStory()
	return
end

function V3a4_Chg_LevelView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self:_actId())
end

function V3a4_Chg_LevelView:_initPathStatus()
	for i, _ in ipairs(self._goLevelItemContainerList) do
		if i <= self._latestStoryItem - 1 then
			self:playAnim_PathIdle(i)
		end
	end
end

local kFocusDuration = 0.5

function V3a4_Chg_LevelView:_focusStoryItem(index, isTween, needPlayStory)
	local contentAnchorX = recthelper.getAnchorX(self._storyItemList[index]:transform().parent)
	local offsetX = self._offsetX - contentAnchorX

	offsetX = GameUtil.clamp(offsetX, self._minContentAnchorX, 0)

	GameUtil.onDestroyViewMember_TweenId(self, "_moveTweenId")

	if isTween then
		self._moveTweenId = ZProj.TweenHelper.DOAnchorPosX(self._goMoveTrans, offsetX, kFocusDuration, self._onFocusEnd, self, needPlayStory and index or nil)
	else
		recthelper.setAnchorX(self._goMoveTrans, offsetX)
	end

	self:_setFocusFlag(index)
end

function V3a4_Chg_LevelView:_onFocusEnd(index)
	if not index then
		return
	end

	local item = self._storyItemList[index]

	if not item then
		return
	end

	item:playStory()
end

function V3a4_Chg_LevelView:_setFocusFlag(index)
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

return V3a4_Chg_LevelView
