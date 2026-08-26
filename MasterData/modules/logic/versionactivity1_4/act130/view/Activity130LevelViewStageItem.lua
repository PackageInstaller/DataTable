-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130LevelViewStageItem.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130LevelViewStageItem", package.seeall)

local Activity130LevelViewStageItem = class("Activity130LevelViewStageItem", LuaCompBase)

function Activity130LevelViewStageItem:init(go)
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

function Activity130LevelViewStageItem:refreshItem(co, index)
	self._index = index
	self._config = co

	if self._config then
		self._episodeId = self._config.episodeId or 0
	end

	local curEpisodeId = Activity130Model.instance:getCurEpisodeId()

	gohelper.setActive(self._imagechess.gameObject, self._episodeId == curEpisodeId)

	local newFinishEpisode = Activity130Model.instance:getNewFinishEpisode()
	local newUnlockEpisode = Activity130Model.instance:getNewUnlockEpisode()
	local unlockShow = false

	if self._index == 1 then
		unlockShow = true
	elseif self._index == 2 then
		local isNewUnlock = Activity130Model.instance:getNewUnlockEpisode() == 1

		unlockShow = not isNewUnlock
	else
		unlockShow = Activity130Model.instance:isEpisodeUnlock(self._episodeId)
	end

	gohelper.setActive(self._gounlock, unlockShow)

	local finish = true
	local finish

	if (self._index ~= 1 or newFinishEpisode == 0) and Activity130Model.instance:getEpisodeState(self._episodeId) ~= Activity130Enum.EpisodeState.Finished then
		finish = false
	end

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

	if self._index == 1 then
		self._txtstagename.text = luaLang("v1a4_role37_level_prologue")
		self._txtstagenum.text = ""

		gohelper.setActive(self._btnreview.gameObject, false)
		gohelper.setActive(self._stars[1].go, false)
		gohelper.setActive(self._stars[2].go, false)
	else
		gohelper.setActive(self._stars[1].go, true)
		gohelper.setActive(self._stars[2].go, false)
		gohelper.setActive(self._stars[1].has, finish)
		gohelper.setActive(self._stars[1].no, not finish)

		self._txtstagenum.text = co.episodetag
		self._txtstagename.text = co.name
	end
end

function Activity130LevelViewStageItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnreview:AddClickListener(self._btnReviewOnClick, self)
end

function Activity130LevelViewStageItem:removeEventListeners()
	if self._btnclick then
		self._btnclick:RemoveClickListener()
		self._btnreview:RemoveClickListener()
	end
end

function Activity130LevelViewStageItem:_btnclickOnClick()
	local curEpisodeId = Activity130Model.instance:getCurEpisodeId()

	if curEpisodeId == self._episodeId then
		self:_startEnterGame()

		return
	end

	self:_startEnterEpisode(self._episodeId)
end

function Activity130LevelViewStageItem:_onJumpToEpisode(episodeId)
	if self._episodeId ~= episodeId then
		return
	end

	local curEpisodeId = Activity130Model.instance:getCurEpisodeId()

	if curEpisodeId == episodeId then
		self:_startEnterGame()

		return
	end

	self:_startEnterEpisode(episodeId)
end

function Activity130LevelViewStageItem:_startEnterEpisode(episodeId)
	local curEpisodeId = Activity130Model.instance:getCurEpisodeId()

	Activity130Controller.instance:dispatchEvent(Activity130Event.EpisodeClick, self._episodeId)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("chessPlay")

	if self._episodeId == curEpisodeId then
		self:_startEnterGame()
	else
		TaskDispatcher.runDelay(self._chessStarFinished, self, 0.25)
	end
end

function Activity130LevelViewStageItem:_chessStarFinished()
	gohelper.setActive(self._imagechess.gameObject, true)

	local curEpisodeId = Activity130Model.instance:getCurEpisodeId()

	if curEpisodeId > self._episodeId then
		self._chessAnimator:Play("open_left", 0, 0)
	else
		self._chessAnimator:Play("open_right", 0, 0)
	end

	TaskDispatcher.runDelay(self._startEnterGame, self, 0.87)
end

function Activity130LevelViewStageItem:_startEnterGame()
	UIBlockMgr.instance:endBlock("chessPlay")
	Activity130Model.instance:setCurEpisodeId(self._episodeId)

	if self._index == 1 then
		local storyId = ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role37).storyId

		if storyId > 0 then
			self:_enterActivity130Story(storyId)
		end

		return
	end

	if self._config.mapId > 0 then
		local progress = Activity130Model.instance:getCurMapInfo().progress

		if progress == Activity130Enum.ProgressType.BeforeStory then
			if self._config.beforeStoryId > 0 then
				StoryController.instance:playStory(self._config.beforeStoryId, nil, self._onStoryFinishAndEnterGameView, self)
			else
				self:_onStoryFinishAndEnterGameView()
			end
		elseif progress == Activity130Enum.ProgressType.AfterStory then
			if self._config.afterStoryId > 0 then
				self:_enterActivity130Story(self._config.afterStoryId)
			else
				self:_onStoryFinished()
			end
		else
			self:_enterActivity130GameView()
		end
	elseif self._config.beforeStoryId > 0 then
		self:_enterActivity130Story(self._config.beforeStoryId)
	end
end

function Activity130LevelViewStageItem:_enterActivity130Story(storyId)
	UIBlockMgr.instance:startBlock("waitclose")
	Activity130Controller.instance:dispatchEvent(Activity130Event.PlayLeaveLevelView)

	self._enterStoryId = storyId

	TaskDispatcher.runDelay(self._waitLevelViewCloseFinished, self, 0.34)
end

function Activity130LevelViewStageItem:_waitLevelViewCloseFinished()
	module_views.StoryBackgroundView.viewType = ViewType.Modal

	StoryController.instance:playStory(self._enterStoryId, nil, self._onStoryFinished, self)
	TaskDispatcher.runDelay(self._storyFrontViewShowed, self, 0.5)
end

function Activity130LevelViewStageItem:_storyFrontViewShowed()
	self._enterStoryId = 0

	local lvViewGo = ViewMgr.instance:getContainer(ViewName.Activity130LevelView).viewGO

	recthelper.setAnchorX(lvViewGo.transform, 10000)
	UIBlockMgr.instance:endBlock("waitclose")
end

function Activity130LevelViewStageItem:_onStoryFinished()
	module_views.StoryBackgroundView.viewType = ViewType.Full

	local lvViewGo = ViewMgr.instance:getContainer(ViewName.Activity130LevelView).viewGO

	recthelper.setAnchorX(lvViewGo.transform, 0)
	Activity130Controller.instance:dispatchEvent(Activity130Event.BackToLevelView, true)

	if not self._config then
		return
	end

	if not Activity130Model.instance:isEpisodeFinished(self._config.episodeId) then
		Activity130Rpc.instance:sendAct130StoryRequest(self._config.activityId, self._config.episodeId)
	end
end

function Activity130LevelViewStageItem:_onStoryFinishAndEnterGameView()
	Activity130Rpc.instance:sendAct130StoryRequest(self._config.activityId, self._config.episodeId, self._enterActivity130GameView, self)
end

function Activity130LevelViewStageItem:_enterActivity130GameView()
	Activity130Controller.instance:dispatchEvent(Activity130Event.StartEnterGameView, self._episodeId)
end

function Activity130LevelViewStageItem:_btnReviewOnClick()
	local storyIds = {}

	if self._index == 1 then
		local storyId = ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role37).storyId

		table.insert(storyIds, storyId)
	else
		local state = Activity130Model.instance:getEpisodeState(self._config.episodeId)

		if state ~= Activity130Enum.EpisodeState.Finished then
			self:_btnclickOnClick()

			return
		end

		if self._config.beforeStoryId > 0 then
			table.insert(storyIds, self._config.beforeStoryId)
		end

		if self._config.afterStoryId > 0 then
			table.insert(storyIds, self._config.afterStoryId)
		end
	end

	StoryController.instance:playStories(storyIds)
end

function Activity130LevelViewStageItem:onUpdateMO(mo)
	return
end

function Activity130LevelViewStageItem:_addEvents()
	Activity130Controller.instance:registerCallback(Activity130Event.playNewUnlockEpisode, self._startNewUnlockEpisodeAni, self)
	Activity130Controller.instance:registerCallback(Activity130Event.playNewFinishEpisode, self._startNewFinishEpisodeAni, self)
	Activity130Controller.instance:registerCallback(Activity130Event.EpisodeClick, self._playChooseEpisode, self)
	Activity130Controller.instance:registerCallback(Activity130Event.EnterEpisode, self._onJumpToEpisode, self)
	Activity130Controller.instance:registerCallback(Activity130Event.PlayChessAutoToNewEpisode, self._playChessAutoToEpisode, self)
end

function Activity130LevelViewStageItem:_removeEvents()
	Activity130Controller.instance:unregisterCallback(Activity130Event.playNewUnlockEpisode, self._startNewUnlockEpisodeAni, self)
	Activity130Controller.instance:unregisterCallback(Activity130Event.playNewFinishEpisode, self._startNewFinishEpisodeAni, self)
	Activity130Controller.instance:unregisterCallback(Activity130Event.EpisodeClick, self._playChooseEpisode, self)
	Activity130Controller.instance:unregisterCallback(Activity130Event.EnterEpisode, self._onJumpToEpisode, self)
	Activity130Controller.instance:unregisterCallback(Activity130Event.PlayChessAutoToNewEpisode, self._playChessAutoToEpisode, self)
end

function Activity130LevelViewStageItem:_startNewUnlockEpisodeAni(episodeId)
	if self._episodeId and self._episodeId == episodeId then
		gohelper.setActive(self._gounlock, true)
		self._animator:Play("unlock", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	end
end

function Activity130LevelViewStageItem:_startNewFinishEpisodeAni(episodeId)
	if self._episodeId and self._episodeId == episodeId then
		gohelper.setActive(self._gounlock, true)
		self._animator:Play("finish", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	end
end

function Activity130LevelViewStageItem:_playChooseEpisode(episodeId)
	local curEpisodeId = Activity130Model.instance:getCurEpisodeId()

	if self._episodeId == curEpisodeId then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if episodeId < self._episodeId then
			self._chessAnimator:Play("close_left", 0, 0)
		else
			self._chessAnimator:Play("close_right", 0, 0)
		end
	end
end

function Activity130LevelViewStageItem:_playChessAutoToEpisode(episodeId)
	UIBlockMgr.instance:startBlock("chessPlay")

	local curEpisodeId = Activity130Model.instance:getCurEpisodeId()

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

function Activity130LevelViewStageItem:_autoChessStartFinished()
	UIBlockMgr.instance:endBlock("chessPlay")
	gohelper.setActive(self._imagechess.gameObject, true)

	local curEpisodeId = Activity130Model.instance:getCurEpisodeId()

	if curEpisodeId > self._episodeId then
		self._chessAnimator:Play("open_left", 0, 0)
	else
		self._chessAnimator:Play("open_right", 0, 0)
	end

	Activity130Model.instance:setCurEpisodeId(self._episodeId)
end

function Activity130LevelViewStageItem:onDestroyView()
	self:_removeEvents()
	self:removeEventListeners()
end

return Activity130LevelViewStageItem
