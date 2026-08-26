-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131LevelViewStageItem.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131LevelViewStageItem", package.seeall)

local Activity131LevelViewStageItem = class("Activity131LevelViewStageItem", LuaCompBase)

function Activity131LevelViewStageItem:init(go)
	self.viewGO = go
	self._animator = go:GetComponent(typeof(UnityEngine.Animator))
	self._imagepoint = gohelper.findChildImage(self.viewGO, "#image_point")
	self._gounlock = gohelper.findChild(self.viewGO, "unlock")
	self._imagestageline = gohelper.findChildImage(self.viewGO, "unlock/#image_stageline")
	self._gostagefinish = gohelper.findChild(self.viewGO, "unlock/#go_stagefinish")
	self._gostagenormal = gohelper.findChild(self.viewGO, "unlock/#go_stagenormal")
	self._imageline = gohelper.findChildImage(self.viewGO, "unlock/#image_line")
	self._imageangle = gohelper.findChildImage(self.viewGO, "unlock/#image_angle")
	self._txtstagename = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stagename")
	self._txtstagenum = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stagename/#txt_stageNum")
	self._stars = self:getUserDataTb_()

	for i = 1, 2 do
		local star = {}

		star.go = gohelper.findChild(self.viewGO, "unlock/info/#txt_stagename/#go_star" .. i)
		star.has = gohelper.findChild(star.go, "has")
		star.no = gohelper.findChild(star.go, "no")

		table.insert(self._stars, star)
	end

	self._btnreview = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/info/#txt_stagename/#btn_review")
	self._imagechess = gohelper.findChildImage(self.viewGO, "unlock/#image_chess")
	self._chessAnimator = gohelper.findChild(self._imagechess.gameObject, "ani"):GetComponent(typeof(UnityEngine.Animator))
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#btn_click")

	self:_addEvents()
end

function Activity131LevelViewStageItem:refreshItem(co, index)
	self._index = index
	self._config = co
	self._episodeId = self._config.episodeId

	local curEpisodeId = Activity131Model.instance:getCurEpisodeId()

	gohelper.setActive(self._imagechess.gameObject, self._episodeId == curEpisodeId)

	local newFinishEpisode = Activity131Model.instance:getNewFinishEpisode()
	local newUnlockEpisode = Activity131Model.instance:getNewUnlockEpisode()
	local unlockShow = false

	if self._index == 1 then
		local isNewUnlock = Activity131Model.instance:getNewUnlockEpisode() == 1

		unlockShow = not isNewUnlock
	else
		unlockShow = Activity131Model.instance:isEpisodeUnlock(self._episodeId)
	end

	gohelper.setActive(self._gounlock, unlockShow)

	local finish = Activity131Model.instance:getEpisodeState(self._episodeId) == Activity131Enum.EpisodeState.Finished

	if finish then
		if newFinishEpisode == self._episodeId then
			self._animator:Play("finish", 0, 0)
		else
			self._animator:Play("finish", 0, 1)
		end
	elseif newUnlockEpisode == self._episodeId then
		self._animator:Play("unlock", 0, 0)
	else
		self._animator:Play("unlock", 0, 1)
	end

	gohelper.setActive(self._stars[1].go, true)
	gohelper.setActive(self._stars[2].go, false)
	gohelper.setActive(self._stars[1].has, finish)
	gohelper.setActive(self._stars[1].no, not finish)

	self._txtstagenum.text = co.episodetag
	self._txtstagename.text = co.name
end

function Activity131LevelViewStageItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnreview:AddClickListener(self._btnReviewOnClick, self)
end

function Activity131LevelViewStageItem:removeEventListeners()
	if self._btnclick then
		self._btnclick:RemoveClickListener()
		self._btnreview:RemoveClickListener()
	end
end

function Activity131LevelViewStageItem:_btnclickOnClick()
	local curEpisodeId = Activity131Model.instance:getCurEpisodeId()

	if curEpisodeId == self._episodeId then
		self:_startEnterGame()

		return
	end

	self:_startEnterEpisode(self._episodeId)
end

function Activity131LevelViewStageItem:_onJumpToEpisode(episodeId)
	if self._episodeId ~= episodeId then
		return
	end

	local curEpisodeId = Activity131Model.instance:getCurEpisodeId()

	if curEpisodeId == episodeId then
		self:_startEnterGame()

		return
	end

	self:_startEnterEpisode(episodeId)
end

function Activity131LevelViewStageItem:_startEnterEpisode(episodeId)
	local curEpisodeId = Activity131Model.instance:getCurEpisodeId()

	Activity131Controller.instance:dispatchEvent(Activity131Event.EpisodeClick, self._episodeId)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("chessPlay")

	if self._episodeId == curEpisodeId then
		self:_startEnterGame()
	else
		TaskDispatcher.runDelay(self._chessStarFinished, self, 0.25)
	end
end

function Activity131LevelViewStageItem:_chessStarFinished()
	gohelper.setActive(self._imagechess.gameObject, true)

	local curEpisodeId = Activity131Model.instance:getCurEpisodeId()

	if curEpisodeId > self._episodeId then
		self._chessAnimator:Play("open_left")
	else
		self._chessAnimator:Play("open_right", 0, 0)
	end

	TaskDispatcher.runDelay(self._startEnterGame, self, 0.87)
end

function Activity131LevelViewStageItem:_startEnterGame()
	UIBlockMgr.instance:endBlock("chessPlay")
	Activity131Model.instance:setCurEpisodeId(self._episodeId)

	if self._config.mapId > 0 then
		local progress = Activity131Model.instance:getCurMapInfo().progress

		if progress == Activity131Enum.ProgressType.BeforeStory then
			if self._config.beforeStoryId > 0 then
				StoryController.instance:playStory(self._config.beforeStoryId, nil, self._onStoryFinishAndEnterGameView, self)
			else
				self:_onStoryFinishAndEnterGameView()
			end
		elseif progress == Activity131Enum.ProgressType.AfterStory then
			if self._config.afterStoryId > 0 then
				self:_enterActivity131Story(self._config.afterStoryId)
			else
				self:_onStoryFinished()
			end
		else
			self:_enterActivity131GameView()
		end
	elseif self._config.beforeStoryId > 0 then
		self:_enterActivity131Story(self._config.beforeStoryId)
	end
end

function Activity131LevelViewStageItem:_enterActivity131Story(storyId)
	UIBlockMgr.instance:startBlock("waitclose")
	Activity131Controller.instance:dispatchEvent(Activity131Event.PlayLeaveLevelView)

	self._enterStoryId = storyId

	TaskDispatcher.runDelay(self._waitLevelViewCloseFinished, self, 0.34)
end

function Activity131LevelViewStageItem:_waitLevelViewCloseFinished()
	module_views.StoryBackgroundView.viewType = ViewType.Modal

	StoryController.instance:playStory(self._enterStoryId, nil, self._onStoryFinished, self)
	TaskDispatcher.runDelay(self._storyFrontViewShowed, self, 0.5)
end

function Activity131LevelViewStageItem:_storyFrontViewShowed()
	self._enterStoryId = 0

	local lvViewGo = ViewMgr.instance:getContainer(ViewName.Activity131LevelView).viewGO

	recthelper.setAnchorX(lvViewGo.transform, 10000)
	UIBlockMgr.instance:endBlock("waitclose")
end

function Activity131LevelViewStageItem:_onStoryFinished()
	module_views.StoryBackgroundView.viewType = ViewType.Full

	local lvViewGo = ViewMgr.instance:getContainer(ViewName.Activity131LevelView).viewGO

	recthelper.setAnchorX(lvViewGo.transform, 0)
	Activity131Controller.instance:dispatchEvent(Activity131Event.BackToLevelView, true)

	if not Activity131Model.instance:isEpisodeFinished(self._config.episodeId) then
		Activity131Rpc.instance:sendAct131StoryRequest(self._config.activityId, self._config.episodeId)
	end
end

function Activity131LevelViewStageItem:_onStoryFinishAndEnterGameView()
	Activity131Rpc.instance:sendAct131StoryRequest(self._config.activityId, self._config.episodeId, self._enterActivity131GameView, self)
end

function Activity131LevelViewStageItem:_enterActivity131GameView()
	Activity131Controller.instance:dispatchEvent(Activity131Event.StartEnterGameView, self._episodeId)
end

function Activity131LevelViewStageItem:_btnReviewOnClick()
	local storyIds = {}
	local state = Activity131Model.instance:getEpisodeState(self._config.episodeId)

	if state ~= Activity131Enum.EpisodeState.Finished then
		self:_btnclickOnClick()

		return
	end

	if self._config.beforeStoryId > 0 then
		table.insert(storyIds, self._config.beforeStoryId)
	end

	if self._config.afterStoryId > 0 then
		table.insert(storyIds, self._config.afterStoryId)
	end

	StoryController.instance:playStories(storyIds)
end

function Activity131LevelViewStageItem:_addEvents()
	Activity131Controller.instance:registerCallback(Activity131Event.playNewUnlockEpisode, self._startNewUnlockEpisodeAni, self)
	Activity131Controller.instance:registerCallback(Activity131Event.playNewFinishEpisode, self._startNewFinishEpisodeAni, self)
	Activity131Controller.instance:registerCallback(Activity131Event.EpisodeClick, self._playChooseEpisode, self)
	Activity131Controller.instance:registerCallback(Activity131Event.EnterEpisode, self._onJumpToEpisode, self)
	Activity131Controller.instance:registerCallback(Activity131Event.PlayChessAutoToNewEpisode, self._playChessAutoToEpisode, self)
end

function Activity131LevelViewStageItem:_removeEvents()
	Activity131Controller.instance:unregisterCallback(Activity131Event.playNewUnlockEpisode, self._startNewUnlockEpisodeAni, self)
	Activity131Controller.instance:unregisterCallback(Activity131Event.playNewFinishEpisode, self._startNewFinishEpisodeAni, self)
	Activity131Controller.instance:unregisterCallback(Activity131Event.EpisodeClick, self._playChooseEpisode, self)
	Activity131Controller.instance:unregisterCallback(Activity131Event.EnterEpisode, self._onJumpToEpisode, self)
	Activity131Controller.instance:unregisterCallback(Activity131Event.PlayChessAutoToNewEpisode, self._playChessAutoToEpisode, self)
end

function Activity131LevelViewStageItem:_startNewUnlockEpisodeAni(episodeId)
	if self._episodeId and self._episodeId == episodeId then
		gohelper.setActive(self._gounlock, true)
		self._animator:Play("unlock", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	end
end

function Activity131LevelViewStageItem:_startNewFinishEpisodeAni(episodeId)
	if self._episodeId and self._episodeId == episodeId then
		gohelper.setActive(self._gounlock, true)
		self._animator:Play("finish", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	end
end

function Activity131LevelViewStageItem:_playChooseEpisode(episodeId)
	local curEpisodeId = Activity131Model.instance:getCurEpisodeId()

	if self._episodeId == curEpisodeId then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if episodeId < self._episodeId then
			self._chessAnimator:Play("close_left", 0, 0)
		else
			self._chessAnimator:Play("close_right", 0, 0)
		end
	end
end

function Activity131LevelViewStageItem:_playChessAutoToEpisode(episodeId)
	UIBlockMgr.instance:startBlock("chessPlay")

	local curEpisodeId = Activity131Model.instance:getCurEpisodeId()

	if self._episodeId == curEpisodeId then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if episodeId < self._episodeId then
			self._chessAnimator:Play("close_left", 0, 0)
		else
			self._chessAnimator:Play("close_right", 0, 0)
		end
	end

	if self._episodeId == episodeId then
		TaskDispatcher.runDelay(self._autoChessStartFinished, self, 0.25)
	end
end

function Activity131LevelViewStageItem:_autoChessStartFinished()
	UIBlockMgr.instance:endBlock("chessPlay")
	gohelper.setActive(self._imagechess.gameObject, true)

	local curEpisodeId = Activity131Model.instance:getCurEpisodeId()

	if curEpisodeId > self._episodeId then
		self._chessAnimator:Play("open_left", 0, 0)
	else
		self._chessAnimator:Play("open_right", 0, 0)
	end

	Activity131Model.instance:setCurEpisodeId(self._episodeId)
end

function Activity131LevelViewStageItem:onDestroyView()
	TaskDispatcher.cancelTask(self._chessStarFinished, self)
	TaskDispatcher.cancelTask(self._startEnterGame, self)
	TaskDispatcher.cancelTask(self._waitLevelViewCloseFinished, self)
	TaskDispatcher.cancelTask(self._storyFrontViewShowed, self)
	TaskDispatcher.cancelTask(self._autoChessStartFinished, self)
	self:_removeEvents()
	self:removeEventListeners()
end

return Activity131LevelViewStageItem
