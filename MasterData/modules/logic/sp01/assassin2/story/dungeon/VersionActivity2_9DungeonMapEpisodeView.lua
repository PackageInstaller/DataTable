-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapEpisodeView.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapEpisodeView", package.seeall)

local VersionActivity2_9DungeonMapEpisodeView = class("VersionActivity2_9DungeonMapEpisodeView", VersionActivityFixedDungeonMapEpisodeView)
local FocusEpisodeBlockKey = "VersionActivity2_9DungeonMapEpisodeView_FocusEpisode"

function VersionActivity2_9DungeonMapEpisodeView:_editableInitView()
	VersionActivity2_9DungeonMapEpisodeView.super._editableInitView(self)

	self.mapView = self.viewContainer.mapView
	self.mapSceneElements = self.viewContainer.mapSceneElements
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#scroll_content")
end

function VersionActivity2_9DungeonMapEpisodeView:addEvents()
	VersionActivity2_9DungeonMapEpisodeView.super.addEvents(self)
	self._touch:AddClickUpListener(self._onClickUpHandler, self)
	self._drag:AddDragListener(self._onDragHandler, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self._onBeginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self._onEndShowRewardView, self)
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnNewElementsFocusDone)
end

function VersionActivity2_9DungeonMapEpisodeView:removeEvents()
	VersionActivity2_9DungeonMapEpisodeView.super.removeEvents(self)
	self._touch:RemoveClickUpListener()
	self._drag:RemoveDragListener()
end

function VersionActivity2_9DungeonMapEpisodeView:refreshModeLockText()
	gohelper.setActive(self._hardModeLockTip, false)
	gohelper.setActive(self._gohardmodelock, false)
end

function VersionActivity2_9DungeonMapEpisodeView:onLoadLayoutFinish()
	VersionActivity2_9DungeonMapEpisodeView.super.onLoadLayoutFinish(self)

	self._contentTran = self.scrollRect.content
	self._originLocalPosX, self._originLocalPosY = transformhelper.getPos(self._contentTran)
	self._originScreenPosX, self._originScreenPosY = recthelper.uiPosToScreenPos2(self._contentTran)

	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnOneWorkLoadDone, VersionActivity2_9DungeonEnum.LoadWorkType.Layout)
	self:tryFindNextEpisodeId()
	self:tryFocusNextEpisode()
end

function VersionActivity2_9DungeonMapEpisodeView:_onClickUpHandler(params, eventPosition)
	if self._isDragging then
		return
	end

	if self.mapSceneElements:isMouseDownElement() then
		self.mapView:_btncloseviewOnClick()
		self.mapSceneElements:onClickDown()
		self.mapSceneElements:onClickUp()
	elseif self.chapterLayout:tryClickDNA(eventPosition) then
		-- block empty
	else
		self.mapView:_btncloseviewOnClick()
	end
end

function VersionActivity2_9DungeonMapEpisodeView:_onClickDownHandler(params, eventPosition)
	return
end

function VersionActivity2_9DungeonMapEpisodeView:setLayoutVisible(isShow)
	VersionActivity2_9DungeonMapEpisodeView.super.setLayoutVisible(self, isShow)

	if not self.chapterLayout then
		return
	end

	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnEpisodeListVisible, isShow)
end

function VersionActivity2_9DungeonMapEpisodeView:_onDragBeginHandler()
	self._isDragging = true
end

function VersionActivity2_9DungeonMapEpisodeView:_onDragEndHandler(param, pointerEventData)
	self._isDragging = false

	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnScrollEpisodeList, pointerEventData.delta.x, true)
end

function VersionActivity2_9DungeonMapEpisodeView:_onDragHandler(param, pointerEventData)
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnScrollEpisodeList, pointerEventData.delta.x, false)
end

function VersionActivity2_9DungeonMapEpisodeView:_onUpdateDungeonInfo()
	self:tryFindNextEpisodeId()
	self:tryFocusNextEpisode()
	VersionActivity2_9DungeonMapEpisodeView.super._onUpdateDungeonInfo(self)
end

function VersionActivity2_9DungeonMapEpisodeView:tryFindNextEpisodeId()
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
			episodeMo.isNew = false
			self._nextFocusEpisodeId = config.id

			break
		end
	end
end

function VersionActivity2_9DungeonMapEpisodeView:tryFocusNextEpisode()
	if not self._nextFocusEpisodeId or not self.chapterLayout then
		return
	end

	self:destroyFocusFlow()

	self._focusFlow = FlowSequence.New()

	self._focusFlow:addWork(WaitEventWork.New("VersionActivity2_9DungeonController;VersionActivity2_9Event;OnNewElementsFocusDone"))
	self._focusFlow:addWork(FunctionWork.New(self._lockScreen, true))
	self._focusFlow:addWork(DelayDoFuncWork.New(self._delay2ChangeEpisode, self, VersionActivity2_9DungeonEnum.Time_FocuysNewEpisode))
	self._focusFlow:addWork(FunctionWork.New(self._lockScreen, false))
	self._focusFlow:start()
end

function VersionActivity2_9DungeonMapEpisodeView:_lockScreen(lock)
	AssassinHelper.lockScreen(FocusEpisodeBlockKey, lock)
end

function VersionActivity2_9DungeonMapEpisodeView:destroyFocusFlow()
	if self._focusFlow then
		self._focusFlow:destroy()

		self._focusFlow = nil
	end
end

function VersionActivity2_9DungeonMapEpisodeView:_delay2ChangeEpisode()
	if not self.activityDungeonMo or not self._nextFocusEpisodeId then
		return
	end

	if self.chapterLayout then
		self.chapterLayout:setFocusEpisodeId(self._nextFocusEpisodeId, true)
		AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_unlockNewEpisode)
	end

	self._nextFocusEpisodeId = nil
end

function VersionActivity2_9DungeonMapEpisodeView:_onBeginShowRewardView()
	self:hideUI()
end

function VersionActivity2_9DungeonMapEpisodeView:_onEndShowRewardView()
	self:showUI()
end

function VersionActivity2_9DungeonMapEpisodeView:onDestroyView()
	self:_lockScreen(false)
	self:destroyFocusFlow()
	VersionActivity2_9DungeonMapEpisodeView.super.onDestroyView(self)
end

return VersionActivity2_9DungeonMapEpisodeView
