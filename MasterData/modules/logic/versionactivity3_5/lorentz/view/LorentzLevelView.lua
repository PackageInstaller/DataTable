-- chunkname: @modules/logic/versionactivity3_5/lorentz/view/LorentzLevelView.lua

module("modules.logic.versionactivity3_5.lorentz.view.LorentzLevelView", package.seeall)

local LorentzLevelView = class("LorentzLevelView", BaseView)
local FocusDuration = 0.5

function LorentzLevelView:onInitView()
	self._trsBg = gohelper.findChild(self.viewGO, "#simage_FullBG").transform
	self._scrollstory = gohelper.findChildScrollRect(self.viewGO, "#scroll_Story")
	self._scrollstoryRect = self._scrollstory.gameObject:GetComponent(gohelper.Type_ScrollRect)
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move")
	self._gostages = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/#go_StoryStages")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_Title/image_LimitTimeBG/#txt_LimitTime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_Task/#go_Reddot")
	self._gotaskani = gohelper.findChild(self.viewGO, "#btn_Task/ani")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gopath = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/path")
	self._animTask = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LorentzLevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self.addEventCb(self, LorentzController.instance, LorentzEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, LorentzController.instance, LorentzEvent.OnBackToLevel, self._onBackToLevel, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._scrollstory:AddOnValueChanged(self.onValueChanged, self)
end

function LorentzLevelView:removeEvents()
	self._btntask:RemoveClickListener()
	self.removeEventCb(self, LorentzController.instance, LorentzEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.removeEventCb(self, LorentzController.instance, LorentzEvent.OnBackToLevel, self._onBackToLevel, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._scrollstory:RemoveOnValueChanged()
end

function LorentzLevelView:_btntaskOnClick()
	ViewMgr.instance:openView(ViewName.LorentzTaskView)
end

function LorentzLevelView:_btnEndlessOnClick()
	if self.lastCo and self.lastCo.gameId == 0 then
		if self.lastCo.storyBefore > 0 then
			local param = {}

			param.mark = true

			StoryController.instance:playStory(self.lastCo.storyBefore, param, self._onGameFinished, self)
		end
	elseif self.lastCo.storyBefore > 0 then
		local param = {}

		param.mark = true

		StoryController.instance:playStory(self.lastCo.storyBefore, param, self._enterGame, self)
	else
		self:_enterGame()
	end
end

function LorentzLevelView:_enterGame()
	LorentzGameController.instance:enterGame(self.lastCo.episodeId)
end

function LorentzLevelView:_onGameFinished()
	LorentzController.instance:_onGameFinished(self.actId, self.lastCo.episodeId)
end

function LorentzLevelView:_refreshTask()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity220Task, self.actId) then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function LorentzLevelView:_onCloseTask()
	self:_refreshTask()
end

function LorentzLevelView:_removeEvents()
	return
end

function LorentzLevelView:_editableInitView()
	self:_initViewInfo()

	self.actId = VersionActivity3_5Enum.ActivityId.Lorentz
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.Activity220Task, self.actId)
end

function LorentzLevelView:_initViewInfo()
	self._scrollWidth = recthelper.getWidth(self._gostoryScroll.transform)

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._scrollWidth + width
end

function LorentzLevelView:onValueChanged()
	local per = self._scrollstory.horizontalNormalizedPosition

	if per > 1 then
		per = 1
	end

	if per < 0 then
		per = 0
	end

	local moveX = self._canMoveBgWidth * per

	recthelper.setAnchorX(self._trsBg, -moveX)
end

function LorentzLevelView:_onScreenSizeChange()
	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._scrollWidth + width

	local per = self._scrollstory.horizontalNormalizedPosition

	if per > 1 then
		per = 1
	end

	local moveX = self._canMoveBgWidth * per

	recthelper.setAnchorX(self._trsBg, -moveX)
end

function LorentzLevelView:onOpen()
	LorentzTaskListModel.instance:init(self.actId)
	self:_initLevelItems()
	self:_refreshLeftTime()

	if self._curEpisodeIndex > 8 then
		self._curEpisodeIndex = 8
	end

	self:_focusStoryItem(self._curEpisodeIndex)
	self:_refreshTask()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function LorentzLevelView:_refreshLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function LorentzLevelView:_initLevelItems()
	local path = self.viewContainer:getSetting().otherRes[1]

	self._episodeItems = {}

	local episodeCos = LorentzConfig.instance:getEpisodeCoList(self.actId)
	local maxUnlockEpisode = LorentzModel.instance:getMaxUnlockEpisodeId()

	self._curEpisodeIndex = LorentzModel.instance:getEpisodeIndex(maxUnlockEpisode)

	LorentzModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)

	for i = 1, #episodeCos do
		local nodeRoot = gohelper.findChild(self._gostages, "stage" .. i)
		local cloneGo = self:getResInst(path, nodeRoot)

		self._episodeItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, LorentzLevelItem, self)

		self._episodeItems[i]:setParam(episodeCos[i], i, self.actId)
	end

	self._goLinePathList = self:getUserDataTb_()

	for i = 1, #episodeCos - 1 do
		local path = {}

		path.go = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/path/Path/Path" .. i)
		path.anim = path.go:GetComponent(typeof(UnityEngine.Animator))

		local isUnlock = i < self._curEpisodeIndex

		gohelper.setActive(path.go, isUnlock)
		table.insert(self._goLinePathList, path)
	end
end

function LorentzLevelView:_focusStoryItem(index, needPlay)
	local contentAnchorX = recthelper.getAnchorX(self._episodeItems[index].transform.parent)
	local offsetX = self._offsetX - contentAnchorX

	if offsetX > 0 then
		offsetX = 0
	elseif offsetX < self.minContentAnchorX then
		offsetX = self.minContentAnchorX
	end

	if needPlay then
		ZProj.TweenHelper.DOAnchorPosX(self._gostoryScroll.transform, offsetX, FocusDuration)
	else
		recthelper.setAnchorX(self._gostoryScroll.transform, offsetX)
	end
end

function LorentzLevelView:onStoryItemClick(index)
	return
end

function LorentzLevelView:_onBackToLevel()
	local newEpisode = LorentzModel.instance:getNewFinishEpisode()

	if newEpisode and newEpisode ~= 0 then
		local maxUnlockEpisode = LorentzModel.instance:getMaxUnlockEpisodeId()

		self._curEpisodeIndex = LorentzModel.instance:getEpisodeIndex(maxUnlockEpisode)

		LorentzModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)
	end

	self:_refreshTask()
end

function LorentzLevelView:_onEpisodeFinished()
	local newEpisode = LorentzModel.instance:getNewFinishEpisode()

	if newEpisode then
		TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 1)
	end

	AudioMgr.instance:trigger(AudioEnum3_5.Lorentz.play_ui_shengyan_beilier_open_sp)
end

function LorentzLevelView:_playStoryFinishAnim()
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)

	local newEpisode = LorentzModel.instance:getNewFinishEpisode()

	if newEpisode then
		for k, episodeItem in ipairs(self._episodeItems) do
			if episodeItem.id == newEpisode then
				self._finishEpisodeIndex = k

				episodeItem:playFinish()
				episodeItem:playStarAnim()
				TaskDispatcher.runDelay(self._finishStoryEnd, self, 1.5)

				break
			end
		end

		LorentzModel.instance:clearFinishEpisode()
	end
end

function LorentzLevelView:_finishStoryEnd()
	if self._finishEpisodeIndex == #self._episodeItems then
		self._curEpisodeIndex = self._finishEpisodeIndex
		self._finishEpisodeIndex = nil
	else
		self._curEpisodeIndex = self._finishEpisodeIndex + 1

		self:_onScreenSizeChange()
		TaskDispatcher.runDelay(self._unlockStory, self, 0.5)
	end
end

function LorentzLevelView:_unlockStory()
	TaskDispatcher.cancelTask(self._unlockStory, self)
	self._episodeItems[self._finishEpisodeIndex + 1]:refreshUI()
	self._episodeItems[self._finishEpisodeIndex + 1]:playUnlock()

	local path = self._goLinePathList[self._finishEpisodeIndex]

	if path and path.go and path.anim then
		gohelper.setActive(path.go, true)
		path.anim:Play("move", 0, 0)
	end

	self:_focusStoryItem(self._finishEpisodeIndex + 1, true)
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
end

function LorentzLevelView:_unlockLvEnd()
	self._finishEpisodeIndex = nil
end

function LorentzLevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
end

function LorentzLevelView:onDestroyView()
	self:_removeEvents()

	self._episodeItems = nil

	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
end

function LorentzLevelView:_onCloseView(viewName)
	if viewName == ViewName.LorentzGameView then
		gohelper.setActive(self.viewGO, true)
	elseif viewName == ViewName.LorentzTaskView then
		self:_onCloseTask()
	end
end

return LorentzLevelView
